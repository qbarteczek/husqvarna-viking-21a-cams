#!/usr/bin/env python3
"""
Kontrola plików STL bębnów (niezależna od generatorów: tylko trimesh i wymiary z docs/DIMENSIONS.md).

    python tools/verify_drums.py                       # models/generated/cam_*.stl
    python tools/verify_drums.py --browser DIR         # STL z tools/test_browser_mesh.js (siatka z index.html)

Sprawdza: jedna szczelna bryła, spójne ściany, objętość > 0, brak trójkątów o zerowym polu,
długość 26 mm, otwór Ø15.6 przelotowy, wpust 4.5 × 2.2 mm na +X tylko od Z = 6.4 do 26,
dysk czołowy R14.5 z rowkami R14.1 (środki 0.4 / 1.2 / 2.0 mm), szyjka R11.5, kołnierz R17.03,
kołnierz tylny R11.5 z fazą do R10.3, zęby krzywek w R14.20 .. 17.03.
Kod wyjścia 1 przy błędach.
"""
import glob
import math
import sys
from pathlib import Path

import numpy as np
import trimesh

ROOT = Path(__file__).resolve().parent.parent
TOL = 0.06   # mm (wielokąt 96 boków: cięciwa vs łuk ~0.01 mm przy R17)


def hits(mesh, origin, direction):
    locs, _, _ = mesh.ray.intersects_location([origin], [direction], multiple_hits=True)
    if len(locs) == 0:
        return []
    return sorted(set(np.round(np.linalg.norm(locs - np.asarray(origin), axis=1), 3)))


def radial(mesh, z, deg):
    a = math.radians(deg)
    return hits(mesh, [0, 0, z], [math.cos(a), math.sin(a), 0])


def check(path):
    p = []
    m = trimesh.load(path, force="mesh")
    bodies = len(m.split(only_watertight=False))
    if bodies != 1:
        p.append(f"{bodies} osobnych brył")
    if not m.is_watertight:
        p.append("nieszczelna")
    if not m.is_winding_consistent:
        p.append("niespójna orientacja ścian")
    if m.volume <= 0:
        p.append(f"objętość {m.volume:.0f} <= 0 (odwrócone normalne)")
    deg = int((m.area_faces < 1e-9).sum())
    if deg:
        p.append(f"{deg} trójkątów o zerowym polu")
    (_, _, z0), (_, _, z1) = m.bounds
    if abs(z0) > TOL or abs(z1 - 26.0) > TOL:
        p.append(f"Z {z0:.2f} .. {z1:.2f}, oczekiwane 0 .. 26")
    if p and ("nieszczelna" in p or bodies != 1):
        return p   # pomiary promieniem na niezamkniętej bryle są niewiarygodne

    def expect(z, deg_, want, what, idx=0):
        h = radial(m, z, deg_)
        got = h[idx] if (idx < 0 and h) or len(h) > idx else None
        if got is None or abs(got - want) > TOL:
            p.append(f"{what}: {got} zamiast {want} (z={z}, {deg_}°)")
    expect(3.4, 180, 7.8, "otwór (szyjka)")
    expect(3.4, 0, 7.8, "otwór od czoła bez wpustu")           # wpust nie dochodzi do czoła
    expect(15.0, 0, 10.0, "dno wpustu")
    expect(15.0, 180, 7.8, "otwór naprzeciw wpustu")
    expect(25.0, 0, 10.0, "wpust w kołnierzu tylnym")
    for sy in (1, -1):                                          # szerokość wpustu
        h = hits(m, [8.9, 0, 15.0], [0, sy, 0])
        if not h or abs(h[0] - 2.25) > TOL:
            p.append(f"pół szerokości wpustu {h[0] if h else None} zamiast 2.25")
            break
    h = hits(m, [8.9, 0, 3.0], [0, 0, 1])                       # koniec wpustu: sufit na Z = 6.4
    if not h or abs(3.0 + h[0] - 6.4) > TOL:
        p.append(f"początek wpustu na Z={3.0 + h[0] if h else None} zamiast 6.4")
    # obwód: ostatnie trafienie promienia, kąt 135° (z dala od grawerunku na czole i od wpustu)
    expect(0.1, 135, 14.5, "dysk czołowy", idx=-1)
    for gz in (0.4, 1.2, 2.0):
        expect(gz, 135, 14.1, f"rowek dysku z={gz}", idx=-1)
    expect(3.4, 135, 11.5, "szyjka", idx=-1)
    expect(5.4, 135, 17.03, "kołnierz główny", idx=-1)
    expect(24.0, 135, 11.5, "kołnierz tylny", idx=-1)
    expect(25.95, 135, 10.3 + (11.5 - 10.3) * 0.05 / 1.4, "faza kołnierza tylnego", idx=-1)
    for z in (8.1, 11.6, 15.0, 18.4, 21.9):                    # środki 5 pozycji
        for d in range(0, 360, 15):
            h = radial(m, z, d)
            r = h[-1] if h else None
            if r is None or r < 14.20 - TOL or r > 17.03 + TOL:
                p.append(f"ząb poza 14.20..17.03: r={r} (z={z}, {d}°)")
                break
    return p


def main():
    args = sys.argv[1:]
    if args[:1] == ["--browser"]:
        files = sorted(glob.glob(str(Path(args[1]) / "*.stl")))
    else:
        files = sorted(glob.glob(str(ROOT / "models" / "generated" / "cam_*.stl")))
    total = 0
    for f in files:
        probs = check(f)
        total += len(probs)
        print(f"{'OK ' if not probs else 'BŁĄD'} {Path(f).name}" + ("" if not probs else ": " + "; ".join(probs)), flush=True)
    print(f"\n{len(files)} plików, {total} problemów")
    return 1 if total else 0


if __name__ == "__main__":
    sys.exit(main())

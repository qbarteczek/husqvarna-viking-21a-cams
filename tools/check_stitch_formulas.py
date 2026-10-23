#!/usr/bin/env python3
"""
Zgodność trzech zapisów każdego ściegu (36 pozycji katalogu):
  1. wzór OpenSCAD w index.html (pole formula – trafia do pobieranego .scad),
  2. funkcja JavaScript w index.html (pole fn – podgląd 3D i STL z przeglądarki),
  3. tools/openscad/stitch_catalog.scad (get_stitch_by_id).
Liczy wszystkie trzy w 72 kątach (OpenSCAD przez echo, JS przez node) i porównuje.

    python tools/check_stitch_formulas.py
"""
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")   # konsola Windows (cp1250) nie ma znaku ≠
ROOT = Path(__file__).resolve().parent.parent
OPENSCAD = r"C:\Program Files\OpenSCAD\openscad.com"
# Dwie siatki kątów: i*5+0.5° (między punktami nieciągłości) oraz dokładnie kąty próbek siatki bębna
# i*360/96 – w nich wypadają skoki fal (sign, floor), a STL z OpenSCAD i z przeglądarki muszą się zgadzać.
ANGLES = [i * 5 + 0.5 for i in range(72)] + [i * 360 / 96 for i in range(96)]
TOL = 1e-3

JS = r"""
const fs = require('fs');
const html = fs.readFileSync(process.argv[2], 'utf8');
const a = html.indexOf('    const STITCHES = ['), b = html.indexOf('    // Stan bieżący', a);
const S = new Function(html.slice(a, b) + '\nreturn STITCHES;')();
const angles = JSON.parse(process.argv[3]);
console.log(JSON.stringify(S.map(s => ({ id: s.id, key: s.key, formula: s.formula, js: angles.map(x => s.fn(x)) }))));
"""


def main():
    with tempfile.TemporaryDirectory() as td:
        td = Path(td)
        (td / "s.js").write_text(JS, encoding="utf-8")
        out = subprocess.run(["node", str(td / "s.js"), str(ROOT / "index.html"), json.dumps(ANGLES)],
                             capture_output=True, text=True, check=True).stdout
        stitches = json.loads(out)
        lib = (ROOT / "tools" / "openscad").as_posix()
        lines = [f"include <{lib}/cam_common.scad>", f"include <{lib}/stitch_catalog.scad>",
                 f"angles = {json.dumps(ANGLES)};"]
        for s in stitches:
            lines.append(f"function f{s['id']}(a) = {s['formula']};")
            lines.append(f'echo(str("F{s["id"]}=", [for (x = angles) f{s["id"]}(x)]));')
            lines.append(f'echo(str("C{s["id"]}=", [for (x = angles) get_stitch_by_id({s["id"]}, x)]));')
        (td / "t.scad").write_text("\n".join(lines), encoding="utf-8")
        r = subprocess.run([OPENSCAD, "-o", str(td / "t.echo"), str(td / "t.scad")], capture_output=True, text=True)
        echo = (td / "t.echo").read_text(encoding="utf-8") if (td / "t.echo").exists() else r.stderr
    vals = {}
    for m in re.finditer(r'ECHO: "([FC])(\d+)=\[(.*?)\]"', echo):
        vals[(m.group(1), int(m.group(2)))] = [float(v) if v.strip() != "undef" else float("nan") for v in m.group(3).split(",")]
    if not vals:
        print(echo[-2000:])
        sys.exit("brak wyników z OpenSCAD")
    bad = 0
    for s in stitches:
        f, c, j = vals.get(("F", s["id"])), vals.get(("C", s["id"])), s["js"]
        issues = []
        if f is None or any(x != x for x in f):
            issues.append("wzór nie liczy się w OpenSCAD (undef)")
            f = None
        else:
            d = max(abs(x - y) for x, y in zip(f, j))
            if d > TOL:
                k = max(range(len(j)), key=lambda i: abs(f[i] - j[i]))
                issues.append(f"JS ≠ wzór (maks. {d:.3f} przy {ANGLES[k]}°: scad {f[k]:.3f}, js {j[k]:.3f})")
        if c is None:
            issues.append("brak w stitch_catalog.scad")
        elif f is not None and max(abs(x - y) for x, y in zip(f, c)) > TOL:
            issues.append("stitch_catalog.scad ≠ wzór")
        if max(abs(x) for x in j) > 1.0 + TOL:
            issues.append(f"wartość poza -1..1 ({max(abs(x) for x in j):.2f}) – ząb wyjdzie poza 14.20..17.03 mm")
        if issues:
            bad += 1
            print(f"BŁĄD {s['id']:2} {s['key']}: " + "; ".join(issues))
    print(f"{len(stitches)} ściegów, {bad} z błędami")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())

# Workflow

## Wymagania

- OpenSCAD **2021.01 lub nowszy** (pliki używają function literals: `function(a) ...`).
  Na tym komputerze zainstalowany jest `C:\Program Files\OpenSCAD\openscad.exe` (2021.01.22).

## Renderowanie

```powershell
& "C:\Program Files\OpenSCAD\openscad.exe" -o cam_B.stl models\generated\cam_B.scad
& "C:\Program Files\OpenSCAD\openscad.exe" -o cam_C.stl models\generated\cam_C.scad
& "C:\Program Files\OpenSCAD\openscad.exe" -o cam_D.stl models\generated\cam_D.scad
```

Każda pozycja to pojedyncze `linear_extrude` wielokąta (profil krawędzi) — renderowanie zajmuje
ok. 20 sekund na plik.

Żeby zobaczyć sam kształt profilu (przekrój), np. do szybkiej kontroli po zmianie wzoru:

```powershell
& "C:\Program Files\OpenSCAD\openscad.exe" -o cross.png --render `
  --camera=0,0,13,0,0,0,55 --projection=o tools\openscad\render\cam_B_cross.scad
```

(`projection(cut=true)` w tych plikach robi przekrój na wysokości Z=13 — środek walca.)

## Kolejność prac

1. Wydrukować próbnie zestaw A (referencja z thing:6018240) i sprawdzić dopasowanie do maszyny
   — potwierdza poprawność zmierzonych wymiarów w `DIMENSIONS.md`.
2. Wydrukować próbnie jedną pozycję zestawu B/C/D i porównać szerokość ściegu z zestawem A —
   skalibrować `EDGE_MAX_R` / `EDGE_MIN_R` w `cam_common.scad` jeśli trzeba (patrz
   `docs/PRINTABILITY.md` za uzasadnieniem obecnych wartości i marginesów bezpieczeństwa).
3. Po kalibracji wydrukować pełne zestawy B, C, D.
4. Zaktualizować `DISC_INDEX` (do utworzenia) statusem `tested` po sprawdzeniu fizycznym.

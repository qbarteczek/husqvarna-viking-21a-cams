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

Renderowanie jest wolne (rzędu kilku–kilkunastu minut na plik) — każda pozycja rowka to 96
operacji `hull()` między sąsiednimi kulami, więc 5 pozycji × 96 = 480 brył pośrednich na
zestaw, zanim dojdzie do finalnego `difference()` z bryłą walca. To normalne dla tej metody
("many small primitives" sweep) w silniku CGAL. Do szybkiego podglądu w GUI OpenSCAD lepiej
tymczasowo zmniejszyć `samples` w `groove_ring()` (np. do 48) i `$fn` w `cam_barrel_blank()`.

## Kolejność prac

1. Wydrukować próbnie zestaw A (referencja z thing:6018240) i sprawdzić dopasowanie do maszyny
   — potwierdza poprawność zmierzonych wymiarów w `DIMENSIONS.md`.
2. Wydrukować próbnie jedną pozycję zestawu B/C/D i porównać szerokość ściegu z zestawem A —
   skalibrować `GROOVE_AMP` / `GROOVE_WIDTH` w `cam_common.scad` jeśli trzeba.
3. Po kalibracji wydrukować pełne zestawy B, C, D.
4. Zaktualizować `DISC_INDEX` (do utworzenia) statusem `tested` po sprawdzeniu fizycznym.

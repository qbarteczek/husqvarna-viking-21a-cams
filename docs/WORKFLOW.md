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

**Uwaga o podglądzie**: interaktywny podgląd OpenSCAD (F5 / `--preview`, silnik OpenCSG) potrafi
przy wielu małych bryłach pośrednich pokazać obiekt jako niemal gładki walec, mimo że rowek
faktycznie jest wycięty poprawnie — to ograniczenie wizualizacji, nie błąd geometrii. Żeby
naprawdę zobaczyć kształt ściegu, użyj `--render` (F6, dokładny CGAL) albo przekroju:

```powershell
& "C:\Program Files\OpenSCAD\openscad.exe" -o cross.png --render `
  --camera=0,0,13,0,0,0,55 --projection=o tools\openscad\render\cam_B_cross.scad
```

(`projection(cut=true)` w tych plikach robi przekrój na wysokości Z=13 — środek walca.)

## Kolejność prac

1. Wydrukować próbnie zestaw A (referencja z thing:6018240) i sprawdzić dopasowanie do maszyny
   — potwierdza poprawność zmierzonych wymiarów w `DIMENSIONS.md`.
2. Wydrukować próbnie jedną pozycję zestawu B/C/D i porównać szerokość ściegu z zestawem A —
   skalibrować `GROOVE_BASE_R` / `GROOVE_DEEP_R` / `GROOVE_WIDTH` w `cam_common.scad` jeśli trzeba
   (patrz `docs/PRINTABILITY.md` za uzasadnieniem obecnych wartości i marginesów bezpieczeństwa).
3. Po kalibracji wydrukować pełne zestawy B, C, D.
4. Zaktualizować `DISC_INDEX` (do utworzenia) statusem `tested` po sprawdzeniu fizycznym.

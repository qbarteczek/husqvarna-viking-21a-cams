# Workflow

## Wymagania

- OpenSCAD **2021.01 lub nowszy** (pliki używają function literals: `function(a) ...`).
  Na tym komputerze zainstalowany jest `C:\Program Files\OpenSCAD\openscad.exe` (2021.01.22).

## Renderowanie

```powershell
& "C:\Program Files\OpenSCAD\openscad.exe" -o cam_A.stl models\generated\cam_A.scad
& "C:\Program Files\OpenSCAD\openscad.exe" -o cam_B.stl models\generated\cam_B.scad
& "C:\Program Files\OpenSCAD\openscad.exe" -o cam_C.stl models\generated\cam_C.scad
& "C:\Program Files\OpenSCAD\openscad.exe" -o cam_D.stl models\generated\cam_D.scad
& "C:\Program Files\OpenSCAD\openscad.exe" -o mating_shaft_reference.stl tools\openscad\mating_shaft_reference.scad
```

Każda pozycja ściegu to pojedyncze `linear_extrude` wielokąta (profil krawędzi) — szybkie.
Całość: ok. 1.5 minuty na plik bębna, ułamek sekundy na `mating_shaft_reference`
(brak ząbków).

Żeby zobaczyć sam kształt profilu (przekrój), np. do szybkiej kontroli po zmianie wzoru:

```powershell
& "C:\Program Files\OpenSCAD\openscad.exe" -o cross.png --render `
  --camera=0,0,13,0,0,0,55 --projection=o tools\openscad\render\cam_B_cross.scad
```

(`projection(cut=true)` w tych plikach robi przekrój na wysokości Z=13 — środek walca.)

## Kontrola po zmianach (od 2026-10-23)

Po każdej zmianie geometrii, wzorów ściegów albo generatora w przeglądarce:

```powershell
python tools/verify_drums.py                         # models/generated/cam_*.stl
node tools/test_browser_mesh.js outrowser          # siatki z index.html: 5 presetów + 36 ściegów
python tools/verify_drums.py --browser outrowser
python tools/check_stitch_formulas.py                # 36 ściegów: JS = wzór OpenSCAD = stitch_catalog.scad
```

`verify_drums.py` sprawdza: jedna szczelna bryła, spójne ściany, brak trójkątów o zerowym polu, wymiary otworu,
wpustu (4.5 × 2.2 mm, od Z = 6.4), rowków dysku, kołnierzy i zakres zębów 14.20–17.03 mm.
Katalog ściegów jest zapisany w kilku miejscach (`index.html`, `tools/openscad/stitch_catalog.scad`,
`tools/generator/generate_drum.ps1`, presety w `tools/openscad/cam_generator.scad`) – zmieniaj wszystkie naraz.

Uwaga o OpenSCAD 2021 (CGAL): części, które w `union()` stykają się tylko płaszczyzną, potrafią wyjść w STL
jako osobne bryły. Dlatego `cam_common.scad` łączy sekcje z zakładką `JOIN_EPS = 0.01` mm.

## Kolejność prac

1. Wydrukować `tools/openscad/mating_shaft_reference.scad` i sprawdzić dopasowanie otworu +
   wpustu pryzmatycznego w gnieździe maszyny — szybszy, tańszy test niż całym bębnem
   (patrz `docs/PRINTABILITY.md`).
2. Wydrukować próbnie zestaw A (natywny `cam_A.scad` lub referencyjny plik z
   `models/original/`) i sprawdzić dopasowanie do maszyny — potwierdza poprawność zmierzonych/
   sfotografowanych wymiarów w `docs/DIMENSIONS.md`.
3. Wydrukować próbnie jedną pozycję zestawu B/C/D i porównać szerokość ściegu z zestawem A —
   skalibrować `EDGE_MAX_R` / `EDGE_MIN_R` w `cam_common.scad` jeśli trzeba (patrz
   `docs/PRINTABILITY.md` za uzasadnieniem obecnych wartości i marginesów bezpieczeństwa).
4. Po kalibracji wydrukować pełne zestawy B, C, D — albo zaprojektować własne, patrz
   [`docs/CREATING_NEW_DRUMS.md`](CREATING_NEW_DRUMS.md).
5. Zaktualizować status w tabeli w `README.md` na "przetestowany" po sprawdzeniu fizycznym.

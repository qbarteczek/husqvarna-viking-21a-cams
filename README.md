# Generator bębnów ściegowych do Husqvarna 21E / Husqvarna 21E Stitch Drum Generator

*Dokument dwujęzyczny — polski niżej, English below. / Bilingual document — Polish first, English below.*

---

## PL

Otwarty **generator** bębnów ściegowych (stitch cams) do maszyny **Husqvarna 21E**
(rodzina mechanizmu obejmuje też pokrewne oznaczenia: 19, 20, 21A). Nie jest to
zamknięty zestaw czterech wzorów — to parametryczna biblioteka OpenSCAD, w której
mocowanie jest raz zweryfikowane i wspólne, a Ty projektujesz dowolną liczbę
własnych wzorów ściegów. Patrz [`docs/CREATING_NEW_DRUMS.md`](docs/CREATING_NEW_DRUMS.md).

### Cel

Zestaw A jest już zaprojektowany: [Viking 21a Basic Stitch Cam](https://www.thingiverse.com/thing:6018240)
autorstwa maxkrippler — zygzak + zygzak 3-stopniowy. Geometrię zweryfikowano dwoma
niezależnymi źródłami:

1. **Analiza pliku STL** zestawu A (skan promienia co 0.1–0.25 mm wzdłuż całej długości) —
   wykazała, że to nie płaska tarcza, tylko **krzywka bębnowa z profilowaną krawędzią**:
   - sama krawędź walca na każdej z 5 pozycji jest ukształtowana jako ząbki/profil ściegu
     (nie schowany rowek) — czujnik/popychacz maszyny jeździ bezpośrednio po tej krawędzi,
   - pozycje **sąsiadują bezpośrednio, bez żadnego odstępu**,
   - krzywka **nie ma otworu przelotowego na wałek** — ma za to gniazdo montażowe (otwór na
     wałek napędowy z wypustem blokującym obrót) w czole dużego kołnierza oraz osobny,
     wieloschodkowy trzpień montażowy między dużym kołnierzem a częścią zębatą.
2. **Zdjęcia fizycznego bębna A** (dostarczone przez użytkownika, patrz
   [`references/husqvarna_photos_A/`](references/husqvarna_photos_A/)) — ujawniły dodatkowo
   gwint na dużym kołnierzu, dokładny kształt wpustu w gnieździe i układ grawerunku
   ("HUSQVARNA SWEDEN" + litera zestawu).

Na tej podstawie zbudowano parametryczny generator OpenSCAD z trzema gotowymi, oryginalnymi
zestawami — **B, C, D** — z tą samą, zweryfikowaną geometrią mocowania, ale nowymi wzorami
ściegów (nie odtworzeniem historii — źródeł do wiernej rekonstrukcji nie udało się znaleźć).

### Status

| Zestaw | Źródło | Status |
|---|---|---|
| A | thing:6018240 (maxkrippler) + zdjęcia fizycznego bębna | referencyjny plik w `models/original/`, wymiary w `docs/DIMENSIONS.md`; jest też natywna wersja generatora `models/generated/cam_A.scad` — **niezweryfikowana drukiem** |
| B | oryginalny wzór "Fale i muszelki" | wygenerowany (`models/generated/cam_B.scad` + `.stl`) — **niezweryfikowany drukiem** |
| C | oryginalny wzór "Ściegi ozdobne otwarte" | wygenerowany (`models/generated/cam_C.scad` + `.stl`) — **niezweryfikowany drukiem** |
| D | oryginalny wzór "Ściegi użytkowe specjalne" | wygenerowany (`models/generated/cam_D.scad` + `.stl`) — **niezweryfikowany drukiem** |

Element pomocniczy [`tools/openscad/mating_shaft_reference.scad`](tools/openscad/mating_shaft_reference.scad)
— testowy trzpień do sprawdzenia dopasowania otworu i wpustu przed drukiem całego bębna.

Kolejny krok: wydruk próbny i ew. kalibracja (`EDGE_MAX_R`/`EDGE_MIN_R`, `THREAD_*` w
`cam_common.scad`) — patrz [`docs/WORKFLOW.md`](docs/WORKFLOW.md) i
[`docs/PRINTABILITY.md`](docs/PRINTABILITY.md).

### Chcesz zaprojektować własny bęben?

Zobacz [`docs/CREATING_NEW_DRUMS.md`](docs/CREATING_NEW_DRUMS.md) — krok po kroku, jak
skopiować szablon [`tools/openscad/cam_template.scad`](tools/openscad/cam_template.scad),
zaprojektować 5 własnych kształtów krawędzi i wygenerować nowy bęben ściegowy, bez dotykania
zweryfikowanej geometrii mocowania.

### Podgląd

![Zestawienie A/B/C/D](docs/renders/assembly_all.png)

| | Widok izometryczny | Przekrój (pokazuje kształt ściegu) |
|---|---|---|
| **A** (referencja) | ![A iso](docs/renders/cam_A_iso.png) | ![A przekrój](docs/renders/cam_A_cross_section.png) |
| **B** | ![B iso](docs/renders/cam_B_iso.png) | ![B przekrój](docs/renders/cam_B_cross_section.png) |
| **C** | ![C iso](docs/renders/cam_C_iso.png) | ![C przekrój](docs/renders/cam_C_cross_section.png) |
| **D** | ![D iso](docs/renders/cam_D_iso.png) | ![D przekrój](docs/renders/cam_D_cross_section.png) |

Więcej widoków (z przodu) w [`docs/renders/`](docs/renders/).

### Dokumentacja

| Plik | Zawartość |
|---|---|
| [`docs/DIMENSIONS.md`](docs/DIMENSIONS.md) | Wymiary mechaniczne (STL + zdjęcia fizycznego bębna) |
| [`docs/STITCH_DESIGN.md`](docs/STITCH_DESIGN.md) | Wybór i uzasadnienie wzorów ściegów B/C/D, kalibracja |
| [`docs/CREATING_NEW_DRUMS.md`](docs/CREATING_NEW_DRUMS.md) | Jak zaprojektować i wygenerować własny bęben |
| [`docs/PRINTABILITY.md`](docs/PRINTABILITY.md) | Analiza drukowalności, orientacja, parametry druku |
| [`docs/USAGE.md`](docs/USAGE.md) | Montaż bębna w maszynie, wybór ściegu, bezpieczeństwo |
| [`docs/WORKFLOW.md`](docs/WORKFLOW.md) | Jak renderować/rozwijać projekt dalej |
| [`docs/renders/`](docs/renders/) | Podglądowe renderowania (różne rzuty + zestawienie) |

Każdy z powyższych ma wersję angielską pod nazwą `*.en.md` w tym samym folderze.

### Struktura

- `models/original/` — geometria zestawu A po imporcie/analizie pliku źródłowego,
- `models/generated/` — bębny B, C, D oraz natywna wersja A (`cam_A.scad`),
- `references/` — zdjęcia fizycznego bębna A, linki źródłowe,
- `docs/` — dokumentacja (PL + EN), renderowania,
- `tools/openscad/` — wspólna biblioteka OpenSCAD (`cam_common.scad`), szablon nowego bębna
  (`cam_template.scad`), element pomocniczy do testu dopasowania
  (`mating_shaft_reference.scad`) i skrypty renderujące (`render/`).

### Projekt źródłowy (zestaw A)

https://www.thingiverse.com/thing:6018240

### Licencja

CC-BY 4.0 — patrz [`LICENSE`](LICENSE) i [`LICENSE_NOTE.md`](LICENSE_NOTE.md) (atrybucja dla
zestawu A / maxkrippler).

---

## EN

An open **generator** of stitch cam drums for the **Husqvarna 21E** sewing machine (the same
mechanism family also covers related designations: 19, 20, 21A). This is not a closed set of
four patterns — it's a parametric OpenSCAD library where the mounting geometry is verified
once and shared, while you design any number of your own stitch patterns. See
[`docs/CREATING_NEW_DRUMS.md`](docs/CREATING_NEW_DRUMS.md).

### Goal

Set A is already designed: [Viking 21a Basic Stitch Cam](https://www.thingiverse.com/thing:6018240)
by maxkrippler — zigzag + 3-step zigzag. The geometry was verified from two independent
sources:

1. **STL file analysis** of set A (radius scan every 0.1–0.25 mm along the full length) —
   showed it's not a flat disc, but a **barrel cam with a profiled edge**:
   - the cylinder's edge itself, at each of the 5 positions, is shaped as the stitch profile
     (teeth), not a hidden groove — the machine's sensor/follower rides directly on this edge,
   - positions are **directly adjacent, with no gap between them**,
   - the cam **has no through-bore for a shaft** — instead it has a mounting socket (a hole
     for the drive shaft with a key that blocks rotation) in the face of the large flange, and
     a separate, multi-step mounting spindle between the large flange and the toothed section.
2. **Photos of the physical drum A** (provided by the user, see
   [`references/husqvarna_photos_A/`](references/husqvarna_photos_A/)) — additionally revealed
   a thread on the large flange, the exact shape of the socket's keyway, and the engraving
   layout ("HUSQVARNA SWEDEN" + the set's letter).

Based on this, a parametric OpenSCAD generator was built with three ready-made, original
sets — **B, C, D** — sharing the same, verified mounting geometry, but with new stitch
patterns (not a historical reconstruction — no source material for a faithful recreation
could be found).

### Status

| Set | Source | Status |
|---|---|---|
| A | thing:6018240 (maxkrippler) + photos of the physical drum | reference file in `models/original/`, dimensions in `docs/DIMENSIONS.en.md`; a native generator version also exists, `models/generated/cam_A.scad` — **not verified by printing** |
| B | original pattern "Waves and shells" | generated (`models/generated/cam_B.scad` + `.stl`) — **not verified by printing** |
| C | original pattern "Open decorative stitches" | generated (`models/generated/cam_C.scad` + `.stl`) — **not verified by printing** |
| D | original pattern "Special utility stitches" | generated (`models/generated/cam_D.scad` + `.stl`) — **not verified by printing** |

Auxiliary part [`tools/openscad/mating_shaft_reference.scad`](tools/openscad/mating_shaft_reference.scad)
— a test pin for checking the hole/key fit before printing a whole drum.

Next step: a test print and possible calibration (`EDGE_MAX_R`/`EDGE_MIN_R`, `THREAD_*` in
`cam_common.scad`) — see [`docs/WORKFLOW.md`](docs/WORKFLOW.md) and
[`docs/PRINTABILITY.md`](docs/PRINTABILITY.md).

### Want to design your own drum?

See [`docs/CREATING_NEW_DRUMS.md`](docs/CREATING_NEW_DRUMS.md) — a step-by-step guide to
copying the [`tools/openscad/cam_template.scad`](tools/openscad/cam_template.scad) template,
designing 5 of your own edge shapes, and generating a new stitch drum, without touching the
verified mounting geometry.

### Preview

![A/B/C/D lineup](docs/renders/assembly_all.png)

| | Isometric view | Cross-section (shows the stitch shape) |
|---|---|---|
| **A** (reference) | ![A iso](docs/renders/cam_A_iso.png) | ![A cross-section](docs/renders/cam_A_cross_section.png) |
| **B** | ![B iso](docs/renders/cam_B_iso.png) | ![B cross-section](docs/renders/cam_B_cross_section.png) |
| **C** | ![C iso](docs/renders/cam_C_iso.png) | ![C cross-section](docs/renders/cam_C_cross_section.png) |
| **D** | ![D iso](docs/renders/cam_D_iso.png) | ![D cross-section](docs/renders/cam_D_cross_section.png) |

More views (front) in [`docs/renders/`](docs/renders/).

### Documentation

| File | Content |
|---|---|
| [`docs/DIMENSIONS.en.md`](docs/DIMENSIONS.en.md) | Mechanical dimensions (STL + photos of the physical drum) |
| [`docs/STITCH_DESIGN.en.md`](docs/STITCH_DESIGN.en.md) | Choice and rationale for the B/C/D stitch patterns, calibration |
| [`docs/CREATING_NEW_DRUMS.md`](docs/CREATING_NEW_DRUMS.md) | How to design and generate your own drum (bilingual) |
| [`docs/PRINTABILITY.en.md`](docs/PRINTABILITY.en.md) | Printability analysis, orientation, print settings |
| [`docs/USAGE.en.md`](docs/USAGE.en.md) | Mounting the drum in the machine, selecting a stitch, safety |
| [`docs/WORKFLOW.en.md`](docs/WORKFLOW.en.md) | How to render/extend the project further |
| [`docs/renders/`](docs/renders/) | Preview renders (various views + lineup) |

### Structure

- `models/original/` — set A geometry, imported/analyzed from the source file,
- `models/generated/` — drums B, C, D, plus a native version of A (`cam_A.scad`),
- `references/` — photos of the physical drum A, source links,
- `docs/` — documentation (PL + EN), renders,
- `tools/openscad/` — the shared OpenSCAD library (`cam_common.scad`), the new-drum template
  (`cam_template.scad`), the fit-test auxiliary part (`mating_shaft_reference.scad`), and the
  rendering scripts (`render/`).

### Source project (set A)

https://www.thingiverse.com/thing:6018240

### License

CC-BY 4.0 — see [`LICENSE`](LICENSE) and [`LICENSE_NOTE.md`](LICENSE_NOTE.md) (attribution for
set A / maxkrippler).

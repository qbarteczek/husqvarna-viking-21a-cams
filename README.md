# Husqvarna Viking 21A — Cam Library (A/B/C/D)

Otwarta biblioteka krzywek (stitch cams) do maszyny **Husqvarna Viking 21A** (i modeli pokrewnych: 19, 20).

## Cel

Zestaw A jest już zaprojektowany: [Viking 21a Basic Stitch Cam](https://www.thingiverse.com/thing:6018240)
autorstwa maxkrippler — zygzak + zygzak 3-stopniowy.

Na tej podstawie odtwarzamy geometrię mechaniczną (piasta, tarcza, tor krzywki) i tworzymy
trzy kolejne, historyczne zestawy: **B, C, D** — każdy z zygzakiem + 4 ściegami ozdobnymi,
zgodnie z oryginalnym systemem stosu krzywek tej maszyny.

## Status

| Zestaw | Źródło | Status |
|---|---|---|
| A | thing:6018240 (maxkrippler) | referencyjny — plik STL przeanalizowany, wymiary spisane w `docs/DIMENSIONS.md` |
| B | oryginalny wzór "Fale i muszelki" | wygenerowany (`models/generated/cam_B.scad` + `.stl`) — **niezweryfikowany drukiem** |
| C | oryginalny wzór "Ściegi ozdobne otwarte" | wygenerowany (`models/generated/cam_C.scad` + `.stl`) — **niezweryfikowany drukiem** |
| D | oryginalny wzór "Ściegi użytkowe specjalne" | wygenerowany (`models/generated/cam_D.scad` + `.stl`) — **niezweryfikowany drukiem** |

Wzory B/C/D to **nowe, oryginalne projekty** (nie odtworzenie historii — źródeł nie udało się
znaleźć), ale z geometrią mocowania 1:1 z zestawem A. Szczegóły wyboru wzorów:
[`docs/STITCH_DESIGN.md`](docs/STITCH_DESIGN.md). Kolejny krok: wydruk próbny i kalibracja
`GROOVE_AMP`/`GROOVE_WIDTH` — patrz [`docs/WORKFLOW.md`](docs/WORKFLOW.md).

## Dokumentacja

| Plik | Zawartość |
|---|---|
| [`docs/DIMENSIONS.md`](docs/DIMENSIONS.md) | Wymiary mechaniczne zmierzone z pliku STL zestawu A |
| [`docs/STITCH_DESIGN.md`](docs/STITCH_DESIGN.md) | Wybór i uzasadnienie wzorów ściegów B/C/D, kalibracja |
| [`docs/PRINTABILITY.md`](docs/PRINTABILITY.md) | Analiza drukowalności, orientacja, parametry druku |
| [`docs/USAGE.md`](docs/USAGE.md) | Montaż krzywki w maszynie, wybór ściegu, bezpieczeństwo |
| [`docs/WORKFLOW.md`](docs/WORKFLOW.md) | Jak renderować/rozwijać projekt dalej |
| [`docs/renders/`](docs/renders/) | Podglądowe renderowania (różne rzuty + zestawienie) |

## Struktura

- `models/original/` — geometria zestawu A po imporcie/analizie pliku źródłowego,
- `models/generated/` — nowe modele B, C, D,
- `references/` — skany, zdjęcia, linki źródłowe (bez wrzucania cudzych plików bez licencji),
- `docs/` — dokumentacja, status, brakujące dane,
- `tools/` — generator OpenSCAD z profilu JSON (adaptacja z projektu elna-supermatic-cams).

## Projekt źródłowy (zestaw A)

https://www.thingiverse.com/thing:6018240

## Powiązany projekt

Podobna metodologia rekonstrukcji krzywek (profil JSON → generator OpenSCAD) została już
zastosowana w `elna-supermatic-cams` dla innej maszyny (Elna Supermatic) — tu ją adaptujemy
pod inną geometrię mocowania.

# Instrukcja obsługi generatora bębnów ściegowych Husqvarna 21E

Projekt zawiera wbudowany, uniwersalny system generowania własnych bębnów ściegowych z katalogu ponad 35 predefiniowanych wzorców (ściegi użytkowe, elastyczne, ozdobne fale, satynowe romby, meandry i szachownice).

---

## 3 Sposoby korzystania z generatora

### Sposób 1: Aplikacja GUI z podglądem 3D i haftem na tkaninie (Najprostszy dla amatorów!)

Najprostszy, w pełni wizualny sposób bez instalowania czegokolwiek:
1. W głównym katalogu projektu kliknij dwukrotnie plik:
   👉 **`Uruchom_Generator.bat`** (lub otwórz w przeglądarce [`tools/generator/index.html`](../tools/generator/index.html)).
2. W aplikacji zobaczysz:
   * **Interaktywny model 3D bębna ściegowego (WebGL / Three.js):** obracaj myszką, przybliżaj i oglądaj rzeczywistą geometrię zębów, rowków i kołnierza bębna w czasie rzeczywistym!
   * **Wirtualny haft na tkaninie:** podgląd przeszycia igłą nici w kolorze na materiale dla wszystkich 5 pozycji,
   * **Gotowe presety fabryczne:** 1-kliknięciem załaduj wzorzec `A1`, `B1`, `C1` lub `D`,
   * **Katalog 36 ściegów ozdobnych:** filtrowany według kategorii (użytkowe, fale, satynowe, meandry) z wyszukiwarką.
3. Kliknij wybraną pozycję (1–5) na górnym pasku, a następnie kliknij dowolny ścieg z katalogu.
4. Kliknij **„💾 Pobierz cam_X.scad”** lub **„📦 Plik Samodzielny (Standalone)”**.

---

### Sposób 2: W programie OpenSCAD (Panel okienkowy Customizer GUI)

Dla użytkowników pracujących bezpośrednio w OpenSCAD:
1. Zainstaluj darmowy program [OpenSCAD](https://openscad.org/) (wersja 2021.01+).
2. Otwórz plik [`tools/openscad/cam_generator.scad`](../tools/openscad/cam_generator.scad).
3. W górnym menu włącz panel parametrów: **Window -> Customizer** (lub odznacz *Hide Customizer*).
4. Wybierz preset (`A1`, `B1`, `C1`, `D`) lub tryb `Custom` i wybierz ściegi dla pozycji 1–5.
5. Wciśnij klawisz **F6** (Render), a po zakończeniu obliczeń **F7** (Export as STL).

---

### Sposób 3: Wiersz poleceń PowerShell (`tools/generator/generate_drum.ps1`)

Automatyczne generowanie kodu i natychmiastowa kompilacja siatki STL:
```powershell
# Wygenerowanie pliku .scad i kompilacja do .stl:
.\tools\generator\generate_drum.ps1 -Letter "E" -Pos1 1 -Pos2 14 -Pos3 23 -Pos4 29 -Pos5 4 -ExportSTL
```
Wynikowy plik `cam_E.stl` zostanie zapisany w katalogu `models/generated/`.

---

## Pełny wykaz ściegów w katalogu (`stitch_catalog.scad`)

| ID | Klucz | Nazwa ściegu | Kategoria | Źródło fabryczne |
|:---:|:---|:---|:---:|:---:|
| **0** | `straight` | Ścieg prosty zerowy | Użytkowy | — |
| **1** | `blind_hem_std` | Ścieg kryty standardowy | Użytkowy | A1 (poz. 1) |
| **2** | `blind_hem_dense` | Ścieg kryty gęsty (4c) | Użytkowy | — |
| **3** | `blind_hem_wide` | Ścieg kryty szeroki | Użytkowy | — |
| **4** | `zigzag_std` | Zygzak standardowy referencyjny | Użytkowy | A1/B1/C1 (poz. 5) |
| **5** | `zigzag_wide` | Zygzak szeroki | Użytkowy | A1 (poz. 3) |
| **6** | `zigzag_narrow` | Zygzak wąski precyzyjny | Użytkowy | — |
| **7** | `zigzag_satin` | Zygzak gęsty satynowy | Użytkowy | A1 (poz. 4) |
| **8** | `three_step_elastic` | Trójskok elastyczny | Użytkowy | A1 (poz. 2) |
| **9** | `four_step_elastic` | Zygzak 4-stopniowy superelastyczny | Użytkowy | — |
| **10** | `overlock_open` | Ścieg owerlokowy otwarty | Użytkowy | — |
| **11** | `overlock_closed` | Ścieg owerlokowy zamknięty | Użytkowy | — |
| **12** | `triple_stretch` | Potrójny prosty elastyczny | Użytkowy | — |
| **13** | `ladder` | Ścieg drabinkowy / cerujący | Użytkowy | — |
| **14** | `serpentine_wide` | Serpentyna szeroka (3c) | Ozdobny | B1 (poz. 1) |
| **15** | `serpentine_med` | Serpentyna średnia (4c) | Ozdobny | — |
| **16** | `serpentine_dense` | Serpentyna gęsta (6c) | Ozdobny | — |
| **17** | `scallop_wave` | Muszelka / łuska asymetryczna | Ozdobny | — |
| **18** | `double_lobe` | Podwójna pętla / podwójna fala | Ozdobny | — |
| **19** | `feather` | Piórko gałązkowe | Ozdobny | — |
| **20** | `stepped_chevron` | Jodełka schodkowa z ząbkiem | Ozdobny | B1 (poz. 2) |
| **21** | `angled_teeth` | Ząbki skośne / piła | Ozdobny | B1 (poz. 4) |
| **22** | `fine_comb` | Grzebyk drobny (14c) | Ozdobny | — |
| **23** | `diamond_satin_3` | Satynowy romb / liść (3c) | Satynowy | B1 (poz. 3) |
| **24** | `diamond_satin_4` | Satynowy romb gęsty (4c) | Satynowy | — |
| **25** | `pearl_beads` | Perełki satynowe okrągłe | Satynowy | — |
| **26** | `hourglass_satin` | Klepsydra satynowa | Satynowy | C1 (poz. 4) |
| **27** | `flame_satin` | Płomienie satynowe | Satynowy | C1 (poz. 2) |
| **28** | `taper_satin` | Stożek satynowy rosnący | Satynowy | — |
| **29** | `greek_key_4` | Grecki klucz meander (4c) | Geometryczny | C1 (poz. 1) |
| **30** | `greek_key_5` | Grecki klucz gęsty (5c) | Geometryczny | — |
| **31** | `satin_blocks` | Bloki satynowe naprzemienne | Geometryczny | C1 (poz. 3) |
| **32** | `checker_step` | Szachownica schodkowa | Geometryczny | — |
| **33** | `cross_stitch` | Krzyżyki geometryczne | Geometryczny | — |
| **34** | `arrowhead` | Strzałka ostra wyostrzona | Geometryczny | — |
| **35** | `honeycomb` | Plaster miodu / siatka rombowa | Geometryczny | — |

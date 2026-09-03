# Wzory ściegów — zestawy B, C, D

## Zastrzeżenie

To **nie są odtworzenia historycznych krzywek** Husqvarna Viking 21A. Mimo że pierwotnie
planowaliśmy wierną rekonstrukcję, nie udało się znaleźć źródeł (instrukcji z listą ściegów
per litera, zdjęć oryginalnych tarczek) — ani mi, ani użytkownikowi. Zamiast tego zaprojektowano
**nowe, oryginalne wzory** w duchu ściegów ozdobnych z epoki mechanicznych maszyn do szycia
(lata 50.–60.), które **fizycznie pasują** do maszyny, bo używają dokładnie tej samej geometrii
mocowania co zmierzony zestaw A (patrz `DIMENSIONS.md`).

Jeśli w przyszłości znajdą się realne źródła historyczne, profile w `tools/openscad/cam_B.scad`
itd. można podmienić bez zmiany reszty geometrii (bryła i mocowanie są w osobnym pliku
`cam_common.scad`).

## Zasada działania

Każdy zestaw ma **5 pozycji osiowych** (tak jak zestaw A — dźwignia wyboru ściegu przesuwa
czujnik/popychacz wzdłuż osi krzywki), rozdzielonych wąskimi kołnierzami. Na każdej pozycji
sama **krawędź walca** ma promień zmienny w funkcji kąta `r(kąt)` — czujnik jeździ bezpośrednio
po tej krawędzi (krzywka krawędziowa/edge cam, tak jak w zestawie A — nie kanał/rowek), a jej
wychylenie w bok tworzy ruch igły podczas szycia. Profile są zdefiniowane jako funkcje
znormalizowane (`-1..1`), przeskalowane w `cam_common.scad` na zakres promienia
`EDGE_MAX_R` (płytko) do `EDGE_MIN_R` (głęboko).

## Zestaw B — "Fale i muszelki"

| Poz. | Nazwa | Funkcja | Charakter |
|---|---|---|---|
| 1 | Zygzak referencyjny | `tri_wave(a,7)` | ciągłość z zestawem A, dla porównania szerokości |
| 2 | Muszelka (scallop) | `saw_wave(a,5, skew=0.85)` | wolny wznos, gwałtowny powrót — efekt "łuski" |
| 3 | Fala | `sine_wave(a,6)` | gładka sinusoida |
| 4 | Podwójny overlock | `double_lobe(a,5)` | zasadnicza fala + mała druga pętla na grzbiecie |
| 5 | Grzebyk | `tri_wave(a,14)` | drobna, gęsta fala (efekt ząbkowania) |

## Zestaw C — "Ściegi ozdobne otwarte"

| Poz. | Nazwa | Funkcja | Charakter |
|---|---|---|---|
| 1 | Zygzak referencyjny | `tri_wave(a,9)` | węższy wariant, odróżnia się od A i B |
| 2 | Piórko (feather) | `feather(a,6)` | seria drobnych wychyleń + jedno szersze przejście na cykl |
| 3 | Krzyżyk | `tri_wave(a,6) + 0.4·tri_wave(2a,6)` | dwie nałożone częstotliwości — wygląd "X" |
| 4 | Strzałka | `arrow_sharpen(a,4,0.5)` | wyostrzone szczyty (spłaszczona krzywa potęgowa) |
| 5 | Plaster miodu | `diamond_lattice(a,6)` | dwie przesunięte fale trójkątne — siatka rombów |

## Zestaw D — "Ściegi użytkowe specjalne" (najrzadszy, jak w historycznym oryginale)

| Poz. | Nazwa | Funkcja | Charakter |
|---|---|---|---|
| 1 | Zygzak referencyjny (wąski) | `tri_wave(a,10)` | najwęższy z trzech zestawów |
| 2 | Ślepy ścieg | `pulse(a,6,0.15)` | długi odcinek prosto + pojedyncze "ugryzienie" na cykl |
| 3 | Drabinka | `sign(sine_wave(a,6))` | niemal prostokątna fala — dwa równoległe "szyny" |
| 4 | Potrójny prosty wzmocniony | `tri_wave(a,18)` | delikatna, częsta oscylacja — imituje potrójny ścieg |
| 5 | Zamknięty overlock elastyczny | `sine_wave(a,6) + 0.3·sine_wave(3a,6)` | fala podstawowa + wzmocnienie brzegu |

## Zakres wychylenia — twarda granica, nie parametr do dowolnego strojenia

`EDGE_MAX_R = 17.03 mm` i `EDGE_MIN_R = 7.71 mm` w `cam_common.scad` to **zmierzony, rzeczywisty
zasięg ruchu czujnika/popychacza** w oryginalnym zestawie A (pełny skan promienia całej części
zębatej — patrz `docs/DIMENSIONS.md`). Wszystkie 15 profili B/C/D skaluje swoją amplitudę
WEWNĄTRZ tego zakresu (współczynniki 0.3–0.9 w tabelach niżej) — żaden wzór nie wychyla
czujnika poza granice, w których fizycznie się porusza w prawdziwej maszynie. Nie zmieniaj tych
dwóch stałych bez ponownego zmierzenia oryginału — to nie jest kosmetyczny parametr do
"wyczucia", tylko twardy limit mechanizmu.

## Inne parametry do kalibracji przed drukiem
- Pozycje ściegu sąsiadują bezpośrednio, bez kołnierzy separujących (`BAND_LEN` w
  `cam_common.scad`) — zgodnie ze zmierzoną budową oryginału.
- Schodkowy trzpień montażowy (`mounting_neck()`) i ślepe gniazdo (`SOCKET_R`/`SOCKET_DEPTH`)
  odtwarzają zmierzoną geometrię mocowania zestawu A — patrz `docs/DIMENSIONS.md`.

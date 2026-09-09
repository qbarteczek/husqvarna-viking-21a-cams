# Tworzenie nowych bębnów ściegowych / Creating new stitch drums

*(Polski poniżej / English below)*

## PL

Ten projekt jest pomyślany jako **generator**, nie zamknięty zestaw trzech
wzorów. Mocowanie (kołnierze, gwint, gniazdo, trzpień, dopuszczalny zakres
wychylenia czujnika) jest w całości w `tools/openscad/cam_common.scad` —
każdy nowy bęben automatycznie dziedziczy poprawną, zweryfikowaną geometrię
mechaniczną. Ty projektujesz tylko **5 kształtów krawędzi** (jeden na pozycję
ściegu).

### Krok po kroku

1. Skopiuj [`tools/openscad/cam_template.scad`](../tools/openscad/cam_template.scad)
   do `models/generated/cam_<LITERA>.scad`.
2. Zdefiniuj 5 funkcji `funkcja(a) = ...` — `a` to kąt obrotu w stopniach
   (0–360), wynik to wartość znormalizowana w przybliżeniu `-1..1`. `cam_common.scad`
   sam przeskaluje ją na rzeczywisty promień krawędzi w zmierzonym, bezpiecznym
   zakresie `[EDGE_MIN_R, EDGE_MAX_R]` (patrz `docs/DIMENSIONS.md`) — **nie da
   się** przez pomyłkę zaprojektować wzoru, który wychyli czujnik poza fizyczny
   zasięg mechanizmu.
3. Podmień literę w wywołaniu `cam_with_grooves("X", [...])` — to też steruje
   grawerunkiem na kołnierzu.
4. Wyrenderuj: `openscad.exe -o cam_<LITERA>.stl cam_<LITERA>.scad` (patrz
   `docs/WORKFLOW.md`).

### Dostępne funkcje falowe (w `cam_common.scad`)

| Funkcja | Kształt | Typowe zastosowanie |
|---|---|---|
| `tri_wave(a, reps)` | trójkątna, symetryczna | zygzak, ściegi geometryczne |
| `sine_wave(a, reps)` | gładka sinusoida | fale, ściegi delikatne |
| `saw_wave(a, reps, skew)` | piła (asymetryczna, `skew` 0–1 steruje proporcją zbocza) | muszelka, ostre przejścia |
| `double_lobe(a, reps)` | fala podstawowa + druga harmoniczna | ozdobne, "podwójne" wzory |
| `diamond_lattice(a, reps)` | dwie przesunięte fale trójkątne | siatka rombów, plaster miodu |
| `feather(a, clusters)` | grupki drobnych wychyleń + większe przejście | piórko, ściegi grupowane |
| `arrow_sharpen(a, reps, skew)` | piła z wyostrzonymi szczytami | strzałka, ostre wzory |
| `pulse(a, reps, spike_w)` | płasko + pojedynczy impuls na cykl | ślepy ścieg, rzadkie "ugryzienia" |

Można je swobodnie łączyć: dodawanie (`f(a)+g(a)`), mnożenie amplitudy,
przesunięcie fazowe (`f(a+90)`), złożenie kąta (`f(2*a)` dla podwojonej
częstotliwości). `reps` to liczba powtórzeń wzoru na pełny obrót (360°) —
większe `reps` = gęstszy/węższy ścieg.

### Zasady projektowe

- **Amplituda ≤ 1.0** per funkcja (mnożnik na końcu, np. `* 0.8`) — wartości
  bliskie ±1 wykorzystują pełny zmierzony zakres ruchu czujnika; mniejsze
  dają węższy, bardziej subtelny ścieg.
- Pierwsza pozycja to zwyczajowo "zygzak referencyjny" (ciągłość z zestawem
  A, ułatwia porównanie/kalibrację po wydruku) — nie jest to wymóg techniczny,
  tylko konwencja przyjęta w B/C/D.
- Nie modyfikuj stałych mocowania (`DISC_R`, `NECK_*`, `FLANGE_R`, `SOCKET_*`,
  `EDGE_MIN_R`/`EDGE_MAX_R`) w `cam_common.scad` dla pojedynczego
  bębna — to współdzielona geometria; zmiana tam wpłynie na WSZYSTKIE bębny.
  Jeśli naprawdę potrzebujesz innej geometrii mocowania (np. dla innego
  modelu maszyny), zrób osobną kopię `cam_common.scad`.

---

## EN

This project is meant to be a **generator**, not a closed set of three
patterns. The mounting geometry (flanges, thread, socket, spindle, the
sensor's allowed deflection range) lives entirely in
`tools/openscad/cam_common.scad` — every new drum automatically inherits the
correct, verified mechanical geometry. You only design **5 edge shapes**
(one per stitch position).

### Step by step

1. Copy [`tools/openscad/cam_template.scad`](../tools/openscad/cam_template.scad)
   to `models/generated/cam_<LETTER>.scad`.
2. Define 5 functions `func(a) = ...` — `a` is the rotation angle in degrees
   (0–360), the result is a value normalized to roughly `-1..1`.
   `cam_common.scad` rescales it to the real edge radius within the
   measured, safe range `[EDGE_MIN_R, EDGE_MAX_R]` (see `docs/DIMENSIONS.md`)
   — it is **not possible** to accidentally design a pattern that pushes the
   sensor beyond the mechanism's physical range.
3. Swap the letter in the `cam_with_grooves("X", [...])` call — this also
   controls the engraving on the flange.
4. Render: `openscad.exe -o cam_<LETTER>.stl cam_<LETTER>.scad` (see
   `docs/WORKFLOW.md`).

### Available wave functions (in `cam_common.scad`)

| Function | Shape | Typical use |
|---|---|---|
| `tri_wave(a, reps)` | symmetric triangle | zigzag, geometric stitches |
| `sine_wave(a, reps)` | smooth sine | waves, gentle stitches |
| `saw_wave(a, reps, skew)` | asymmetric sawtooth (`skew` 0–1 controls the slope ratio) | scallop, sharp transitions |
| `double_lobe(a, reps)` | base wave + second harmonic | decorative "double" patterns |
| `diamond_lattice(a, reps)` | two offset triangle waves | diamond lattice, honeycomb |
| `feather(a, clusters)` | small clustered wiggles + one bigger sweep | feather stitch, grouped stitches |
| `arrow_sharpen(a, reps, skew)` | sawtooth with sharpened peaks | arrowhead, sharp patterns |
| `pulse(a, reps, spike_w)` | flat baseline + one spike per cycle | blind hem, occasional "bites" |

Combine them freely: addition (`f(a)+g(a)`), amplitude scaling, phase shift
(`f(a+90)`), angle composition (`f(2*a)` for double frequency). `reps` is how
many times the pattern repeats per full rotation (360°) — a higher `reps`
means a denser/narrower stitch.

### Design rules

- **Amplitude ≤ 1.0** per function (the trailing multiplier, e.g. `* 0.8`) —
  values near ±1 use the full measured sensor travel range; smaller values
  give a narrower, more subtle stitch.
- Position 1 is conventionally a "reference zigzag" (continuity with set A,
  makes post-print comparison/calibration easier) — that's a convention
  followed by B/C/D, not a technical requirement.
- Don't modify the mounting constants (`DISC_R`, `NECK_*`, `FLANGE_R`, `SOCKET_*`,
  `EDGE_MIN_R`/`EDGE_MAX_R`) in `cam_common.scad` for a single
  drum — that's shared geometry; changing it there affects EVERY drum. If you
  genuinely need different mounting geometry (e.g. for a different machine
  model), make a separate copy of `cam_common.scad`.

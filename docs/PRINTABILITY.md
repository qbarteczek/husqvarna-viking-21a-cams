# Analiza drukowalności

## Metoda weryfikacji geometrii

Brak w tym środowisku narzędzi do naprawy siatki (np. admesh, Meshmixer). Jako podstawową
weryfikację wykorzystano wbudowany w OpenSCAD raport CGAL po pełnym renderze (`--render`,
silnik dokładny, nie podglądowy):

```
Simple:  yes
```

`Simple: yes` oznacza, że bryła jest poprawnym 2-manifoldem (zamknięta, bez samoprzecięć) —
to jest de facto test "czy siatka się nada do druku 3D" na poziomie topologii. Wszystkie
trzy pliki (`cam_B.scad`, `cam_C.scad`, `cam_D.scad`) przeszły ten test.

Dodatkowo, dla każdej pozycji każdego zestawu wygenerowano przekrój poprzeczny
(`docs/renders/cam_*_cross_section.png`, `projection(cut=true)` w wysokości środka walca) —
to bezpośredni dowód na rzeczywisty kształt krawędzi, niezależny od tego, jak wygląda
podgląd 3D (patrz niżej, punkt 3 w historii problemów).

## Historia czterech znalezionych i naprawionych problemów

### 1. Zbyt cienka ścianka (naprawione, potem zastąpione podejściem #3)

Pierwsza wersja parametrów przy najsilniej wychylonych profilach zostawiała ok. 0,17 mm
ścianki od strony powierzchni zewnętrznej — praktycznie przebicie na wylot, za mało dla FDM.

### 2. Rowek całkowicie schowany w materiale (naprawione, potem zastąpione podejściem #3)

Próba naprawy problemu #1 doprowadziła do rowka, który przestał sięgać powierzchni
zewnętrznej — niefunkcjonalne, bo trzpień śledzący wchodzi w rowek z zewnątrz.

### 3. Zły model mechanizmu — wąski rowek zamiast profilowanej krawędzi (błąd funkcjonalny, naprawione ostatecznie)

Nawet po naprawie #2 (rowek poprawnie otwarty na zewnątrz) konstrukcja była **wciąż
mechanicznie błędna**: był to wąski (2,2 mm), płytki kanał wycięty w ściance pełnowymiarowego
walca (Ø 33,94 mm na większości powierzchni). Porównanie z rzeczywistym wyglądem zestawu A
(`docs/renders/cam_A_iso.png`) pokazało, że prawdziwy mechanizm jest inny: **sama krawędź
walca na każdej z 5 pozycji jest ukształtowana jako profil ściegu** (widoczne, głębokie zęby
na całym obwodzie), a nie schowana w środku pełnej średnicy. Czujnik/popychacz maszyny jeździ
bezpośrednio po tej krawędzi — to klasyczna krzywka krawędziowa (edge/plate cam), nie kanał,
w którym coś by "pływało" wewnątrz materiału.

**Rozwiązanie #3**: każda z 5 pozycji to osobna bryła wytłoczona (`linear_extrude`) z
wielokąta, którego obrys BEZPOŚREDNIO jest profilem ściegu — promień zmienia się od
`EDGE_MAX_R = MAIN_R` (płytko) do `EDGE_MIN_R` (głęboko). Zweryfikowane wizualnie (widoki
izometryczne wyraźnie pokazują zęby, tak jak zestaw A) i przekrojem poprzecznym.

### 4. Kołnierze między pozycjami i pełny otwór na wałek — dwa dalsze błędy wykryte po dokładniejszym pomiarze oryginału (naprawione ostatecznie)

Dokładny skan promienia co 0.1–0.25 mm wzdłuż całej długości oryginału A (zamiast tylko kilku
przekrojów) ujawnił dwie kolejne nieścisłości względem realnej budowy:

- **Kołnierze między pozycjami**: w oryginale 5 pozycji ściegu sąsiaduje ze sobą
  **bezpośrednio, bez żadnego odstępu**. Wcześniejsza wersja wstawiała między nimi wąski
  (0,8 mm) kołnierz separujący — usunięty.
- **Brak otworu przelotowego**: krzywka A **nie ma** centralnego otworu na wałek na całej
  długości. Zamiast tego ma: ślepe gniazdo montażowe (r≈7,8 mm, głęb. ~2,5 mm) wycięte od
  czoła dużego kołnierza, oraz osobny, wieloschodkowy trzpień montażowy (kilka średnic:
  14,97 → 9,75 → 13,97 → 7,75 mm) między dużym kołnierzem a częścią zębatą — patrz
  `docs/DIMENSIONS.md`. Poprzednia wersja modelowała to jako prosty pełny otwór na całej
  długości, co było błędnym uproszczeniem wpływającym na realne mocowanie w maszynie.

**Ostateczne rozwiązanie**: `cam_common.scad` odtwarza teraz dokładny schodkowy profil
trzpienia (seria `cylinder(r1=...,r2=...)`) oraz ślepe gniazdo montażowe (zamiast otworu na
wylot), a pozycje ściegu sąsiadują bez odstępu (`BAND_LEN` liczone bez kołnierzy). Zweryfikowane
bezpośrednio w danych STL (skan promienia potwierdza każdy odcinek trzpienia) — patrz
`docs/renders/`.

## Orientacja druku

**Zalecana orientacja: oś walca pionowo (jak zapisano w plikach — oś Z), większym kołnierzem
(Ø 29,94 mm, strona z grawerowanym oznaczeniem litery) na stole.**

Powody:
- Ślepe gniazdo montażowe w czole drukuje się poziomo, warstwa po warstwie, jak każdy inny
  otwór drukowany prostopadle do osi — bez mostkowania.
- Schodkowy trzpień montażowy (Ø 29,94 → 19,5 → 27,94 → 15,5 mm) to seria krótkich stożków
  i kołnierzyków, wszystkie **zwężające się** w miarę wzrostu Z na przemian — żaden pojedynczy
  skok nie przekracza kilku mm i wszystkie mieszczą się w typowym zakresie bezproblemowego
  druku FDM bez podpór.
- Zwężenie Ø33,94 → Ø20,6 mm na dalekim końcu jest do wewnątrz — zawsze bezproblemowe.

**Znana niedoskonałość geometrii**: między sąsiednimi pozycjami ściegu (bez separującego
kołnierza — patrz wyżej) promień krawędzi może się zmieniać dość gwałtownie na granicy dwóch
pozycji, jeśli jedna kończy się głęboką "doliną" a sąsiednia zaczyna się płytkim punktem. To
lokalny, jednowarstwowy efekt (podobny do tego, co widać w oryginale A), zwykle drukowalny bez
podpór, ale warto obejrzeć te granice po wydruku i ew. delikatnie oczyścić.

**Nie są potrzebne żadne podpory.**

Odwrócenie części (mniejszym kołnierzem na stół) jest odradzane — wtedy przejście
Ø20,6 → Ø33,94 mm byłoby pojedynczym skokiem na zewnątrz o ~6,7 mm na pełnym obwodzie, czyli
za dużo na czysty druk bez podpór.

## Oznaczenie litery zestawu

Litera (`B`/`C`/`D`) jest wygrawerowana (wycięta na głębokość 0,7 mm) w płaskiej powierzchni
większego kołnierza — czyli w zalecanej orientacji druku znajdzie się **od strony stołu**.
To celowe i częste podejście (grawerunek identyfikacyjny na spodzie wydruku) — żeby odczytać
oznaczenie, obróć gotową część spodem do góry. Grawerunek nie wpływa na drukowalność (płytki,
0,7 mm, nie tworzy nawisów).

## Parametry druku (proponowane, do weryfikacji)

| Parametr | Wartość | Uwaga |
|---|---|---|
| Wysokość warstwy | 0.12–0.16 mm | drobniejsze warstwy = lepsza wierność krawędzi zęba |
| Materiał | PETG lub ABS | lepsza odporność na ścieranie/ciepło niż PLA przy stałym użytkowaniu w maszynie; PLA OK do testu dopasowania |
| Wypełnienie | 40–60% | zęby pracują pod obciążeniem mechanicznym (czujnik/popychacz) |
| Ściany (perimeters) | min. 3 | dodatkowa wytrzymałość wokół otworu i zębów |
| Podpory | brak | patrz uzasadnienie wyżej |
| Brim/skirt | zalecany brim 3–5 mm | stabilizacja podczas druku wysokiego, wąskiego elementu obracającego się później pod obciążeniem |
| Orientacja | oś pionowo, duży kołnierz na dole | patrz wyżej |

## Kroki po wydruku

1. Sprawdzić pasowanie ślepego gniazda montażowego i schodkowego trzpienia w maszynie —
   druk FDM często daje wymiary lekko mniejsze niż nominalne (skurcz materiału); w razie
   potrzeby delikatnie doszlifować/dopasować.
2. Sprawdzić i ew. oczyścić lokalne naddruki na granicy sąsiednich pozycji ściegu (patrz wyżej).
3. Sprawdzić płynność ruchu czujnika/popychacza po krawędzi — w razie szorstkości wygładzić
   drobnym pilnikiem.
4. Porównać wychylenie na pozycji "zygzak referencyjny" z zestawem A — jeśli znacząco się
   różni, skorygować `EDGE_MAX_R`/`EDGE_MIN_R` w `cam_common.scad` i przedrukować.

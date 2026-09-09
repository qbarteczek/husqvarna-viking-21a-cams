# Wymiary mechaniczne — zestaw A (referencja)

Źródło: `V21ZZ3Z.stl` z paczki [thing:6018240](https://www.thingiverse.com/thing:6018240)
(Viking 21a Basic Stitch Cam, maxkrippler). Wymiary wyciągnięte przez bezpośrednią analizę
wierzchołków siatki STL (skan promienia `sqrt(x²+z²)` w funkcji pozycji na osi Y, w krokach
0.1–0.25 mm), nie z narzędzia CAD (brak takiego w tym środowisku).

## Typ mechanizmu — cztery poprawki po kolejnych, coraz dokładniejszych analizach

1. To **nie jest płaska tarcza z profilowanym obrysem** (jak krzywki Elna Supermatic), tylko
   krzywka bębnowa/walcowa z 5 pozycjami osiowymi.
2. Profil ściegu to **sama krawędź walca** (jak ząbki/zęby), nie schowany rowek — czujnik
   maszyny jeździ bezpośrednio po krawędzi. Pozycje **sąsiadują bezpośrednio, bez odstępu**.
3. Krzywka **nie ma otworu przelotowego na całą długość**. To, co wcześniej wzięto za "otwór
   centralny", to w rzeczywistości: (a) **otwór na wałek napędowy maszyny z wypustem** (klinem)
   wycięty od czoła dużego kołnierza — wypust jest **niezbędny do przeniesienia ruchu
   obrotowego** z wałka na bęben (nie jest to kosmetyczny szczegół) — i (b) osobny, węższy
   **czop montażowy** będący częścią wieloschodkowego trzpienia między dużym kołnierzem a
   częścią zębatą. Cała reszta bryły jest lita.
4. Czujnik/popychacz maszyny ma **ograniczony, twardy zakres ruchu**: pełny skan promienia
   części zębatej (Y=9.7–24.25) pokazuje, że promień krawędzi w oryginale nigdy nie wychodzi
   poza **[7.71 mm, 17.03 mm]** — to fizyczna granica zasięgu czujnika w mechanizmie maszyny,
   nie dowolny parametr projektowy. Wcześniejsza wersja B/C/D używała dolnej granicy 6.5 mm
   (poza tym zakresem) dobranej wyłącznie z powodów wytrzymałościowych druku, bez odniesienia
   do realnego zasięgu czujnika — poprawione.

## Zmierzone wymiary (oś obrotu = Y w oryginalnym pliku)

Współrzędna Y biegnie od 0 (duży kołnierz, strona z widoczną strukturą montażową) do 26.01
(mały kołnierz na przeciwnym końcu).

| Odcinek (Y) | Promień | Opis |
|---|---:|---|
| Y = 0 (czoło) | Ø 29.94 mm (r 14.97) na zewnątrz, otwór na wałek r ≈ 7.8 mm w środku, z wypustem | czoło dużego kołnierza — otwór na wałek napędowy maszyny (wypust przenosi obrót) |
| Y = 0 – 3.2 | r = 14.97 mm | duży kołnierz (lity, poza gniazdem od czoła) |
| Y = 3.2 – 3.7 | 14.97 → 9.75 mm | stożkowe przejście / próg |
| Y = 3.7 – 5.8 | r = 9.75 mm | stała szyjka pośrednia |
| Y = 5.8 – 6.3 | 9.75 → 13.97 mm | stożkowe przejście / próg (promień znowu rośnie!) |
| Y = 6.3 – 7.3 | r = 13.97 mm | stały kołnierzyk pośredni |
| Y = 7.3 – 7.8 | 13.97 → 7.75 mm | stożkowe przejście / próg |
| Y = 7.8 – 9.7 | r = 7.75 mm | **czop montażowy** (najwęższy odcinek trzpienia) |
| Y = 9.7 – ~24.25 | r = **7.71–17.03 mm** (zmienny, nigdy poza tym zakresem) | część zębata — 5 pozycji ściegu, sąsiadujących bez odstępu |
| Y = ~24.25 – 26 | r → 10.30 mm | zwężenie do małego kołnierza na dalekim końcu |

Głębokość gniazda montażowego od czoła Y=0: ok. 2.5 mm (do potwierdzenia — pomiar siatki nie
rozstrzyga jednoznacznie dokładnego dna, tylko obecność i promień gniazda).

**Uwaga:** tabela wyżej opisuje dokładnie to, co jest w pliku `V21ZZ3Z.stl` (replika trzeciej
strony). Generowane bębny (`cam_common.scad`) **nie odwzorowują już dosłownie** wieloschodkowego
trzpienia Y=3.2–9.7 z tej tabeli — na podstawie adnotacji użytkownika na fizycznym bębnie
(sekcja niżej) zastąpiono go pojedynczym gładkim stożkiem, bo dosłowne odwzorowanie tworzyło w
renderze wnękę, której na prawdziwej części nie ma. STL pozostaje wiarygodny dla promieni
kołnierzy i zasięgu części zębatej, ale nie dla szczegółu tego konkretnego przejścia.

## Poprawki na podstawie zdjęć fizycznego bębna A

Użytkownik dostarczył serię zdjęć fizycznego, oryginalnego bębna A (nie pliku STL) — folder
`references/husqvarna_photos_A/` (patrz też `references/README.md`). Zdjęcia ujawniły trzy
elementy niewidoczne/niejednoznaczne w samej siatce STL:

1. **Pierścień z poziomymi rowkami na dużym kołnierzu (Y=0–3.2)** — na zdjęciach widać wyraźnie
   kilka poziomych rowków tuż przy grawerowanym czole. **Pierwsza wersja błędnie zinterpretowała
   je jako gwint śrubowy** (helisa, `boss0_threaded()`); po adnotacji użytkownika bezpośrednio na
   renderze (patrz sekcja niżej) poprawiono na zwykłe, poziome rowki — `ring_grooved()` w
   `cam_common.scad`. Głębokość i rozstaw rowków dobrano **wizualnie ze zdjęć** — **do
   weryfikacji i ew. korekty po dopasowaniu do prawdziwego gniazda maszyny**.
2. **Wpust w otworze na wałek** — zdjęcia pokazują wcięcie w otworze od strony grawerowanego
   czoła. To **funkcjonalny element napędowy**, nie kosmetyczny — bez niego wałek maszyny
   obracałby się swobodnie w otworze bez przenoszenia ruchu na bęben. Dodano jako
   `SOCKET_KEY_DEPTH`/`SOCKET_KEY_WIDTH` w `cam_common.scad` — **bęben ma wpust (rowek wycięty
   na zewnątrz od otworu), wałek maszyny ma wypust (klin)**, patrz sekcja niżej o poprawce
   kierunku wpust/wypust.
3. **Grawerunek** — realny bęben ma wygrawerowane "HUSQVARNA" łukiem u dołu czoła, "SWEDEN"
   pod spodem, i dużą, osobną literę zestawu bliżej otworu od góry. Odwzorowane w
   `arc_text()` / `cam_label_cut()` w `cam_common.scad`.

## Poprawki na podstawie adnotacji użytkownika na renderze

Użytkownik, mając fizyczny bęben A w ręku, naniósł bezpośrednio na render trzy strzałki i opis —
to najbardziej bezpośrednie źródło korekt w tym projekcie (fizyczny obiekt vs. render, nie
zdjęcie interpretowane wizualnie):

- **Czerwona strzałka** — wieloschodkowy trzpień montażowy (dawne Y=3.2–9.7, schodzący aż do
  promienia ~7.75 mm) tworzył w renderze niezamierzoną szczelinę/wnękę, której na fizycznym
  bębnie nie ma. Poprawka: usunięto wąskie stopnie, zastąpiono pojedynczym, gładkim stożkiem
  wprost do promienia doliny krzywek (`EDGE_MIN_R`) — materiał wypełnia teraz całą tę
  przestrzeń, bez odcinków węższych niż dolina krzywek (`mounting_neck()` w `cam_common.scad`).
- **Żółta strzałka** — element zidentyfikowany wcześniej jako gwint śrubowy **nie jest gwintem**
  i jest wyraźnie mniejszy niż maksymalna amplituda krzywek. Poprawka: zamieniono
  `boss0_threaded()` (helisa) na `ring_grooved()` — proste, poziome rowki o promieniu dna
  (`RING_R`) wyraźnie mniejszym niż `EDGE_MAX_R`.
- **Niebieska strzałka** — kołnierz z grawerunkiem (`BOSS0`) jest szerszy i to on **określa
  maksymalną średnicę/amplitudę krzywek** — powinien mieć średnicę równą maksymalnej amplitudzie
  krzywek. Poprawka: `BOSS0_R = EDGE_MAX_R` wprost w `cam_common.scad` (dawniej 14.97 mm i
  17.03 mm były niezależnie zmierzonymi, różnymi wartościami).
- **Ścięcie na czole** — element ma fazę (ścięcie) na górnej krawędzi czoła. Dodano jako
  `CHAMFER_LEN` w `boss0_plain()`.
- **Otwór na wałek z wpustem (najważniejsza poprawka)** — poprzednia wersja miała to odwrócone:
  żeberko wystające **do wnętrza** otworu bębna (błąd), a element pomocniczy
  `mating_shaft_reference.scad` miał pasujący rowek. Zgodnie ze standardową konwencją wpustu
  pryzmatycznego (i z korektą użytkownika trzymającego fizyczny bęben): **wałek maszyny ma
  wypust** (klin, materiał wystający na zewnątrz), a **bęben ma wpust** — rowek wycięty **na
  zewnątrz** od okrągłego otworu. Poprawiono `socket_cut()` (rowek zamiast żeberka) i
  `mating_shaft_reference.scad` (wypust zamiast rowka).

**Uwaga o oznaczeniu modelu maszyny**: dotychczasowa dokumentacja tego projektu odnosiła się
do "Husqvarna Viking 21A" (za tytułem źródłowego pliku thing:6018240). Użytkownik, fotografując
własny, fizyczny bęben, odnosi się do maszyny jako **Husqvarna 21E** — może to być inny wariant
tej samej rodziny mechanizmu (te same 21xx mają zwykle wspólną platformę mechaniczną z różnymi
oznaczeniami rynkowymi) albo dokładniejsze oznaczenie posiadanej maszyny. Nazwę projektu
zaktualizowano na "21E"; jeśli w przyszłości okaże się to niedokładne, wystarczy zmienić nazwę
— sama geometria (zmierzona z realnego bębna i pliku STL) pozostaje aktualna niezależnie od
dokładnego oznaczenia modelu.

## Co z tego wynika dla B, C, D

Żeby nowe zestawy fizycznie pasowały do maszyny, muszą zachować:
- tę samą długość całkowitą (26.0 mm),
- ten sam kołnierz z grawerunkiem o średnicy równej maksymalnej amplitudzie krzywek
  (`BOSS0_R = EDGE_MAX_R`), pierścień z poziomymi rowkami i gładki stożek do części zębatej,
- ten sam otwór na wałek napędowy z wpustem w czole dużego kołnierza (funkcjonalny —
  przenosi napęd; wpust w bębnie, wypust na wałku maszyny),
- ten sam promień kołnierza na dalekim końcu (Ø 20.6 mm przy Y=26),
- **brak odstępu między pozycjami** ściegu w części zębatej,
- **ten sam zakres promienia krawędzi [7.71, 17.03] mm** — żaden wzór nie może wychylić
  czujnika poza granice, w których fizycznie się porusza w oryginale.

Różni się **tylko kształt krawędzi (promień w funkcji kąta obrotu)** na każdej z 5 pozycji —
to jest właśnie "wzór ściegu", który projektujemy indywidualnie dla B, C, D.

## Ograniczenia tej analizy

Wymiary wyciągnięto z analizy surowej siatki trójkątów (bez dostępu do CAD/OpenSCAD/Python
w tym środowisku) — metoda: skanowanie min/max promienia w wąskich przedziałach Y (0.1–0.25 mm)
i identyfikacja skoków/stałych odcinków. Dokładność rzędu ±0.1 mm dla promieni, ale długości
niektórych krótkich odcinków przejściowych (progów/stożków) są przybliżone — rozdzielczość
siatki nie zawsze pozwalała jednoznacznie odróżnić ostry próg od bardzo krótkiego stożka.
**Przed drukiem produkcyjnym zalecana jest weryfikacja wydrukiem próbnym i porównaniem z
oryginałem / fizycznym gniazdem maszyny, jeśli jest dostępne.**

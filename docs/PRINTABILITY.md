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

## Historia trzech znalezionych i naprawionych problemów

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

**Ostateczne rozwiązanie**: każda z 5 pozycji to teraz osobna bryła wytłoczona
(`linear_extrude`) z wielokąta, którego obrys BEZPOŚREDNIO jest profilem ściegu — promień
zmienia się od `EDGE_MAX_R = MAIN_R` (płytko, płynne połączenie z sąsiadującym kołnierzem) do
`EDGE_MIN_R = BORE_R + 3.0 mm` (głęboko, zawsze min. 3 mm ścianki do otworu centralnego).
Pozycje są rozdzielone wąskimi (0,8 mm) kołnierzami o pełnej średnicy `MAIN_R` — tak jak
w oryginale — co też pomaga czujnikowi pozytywnie wyczuć granicę między pozycjami.
Zweryfikowane wizualnie (widoki izometryczne teraz wyraźnie pokazują zęby, tak jak zestaw A)
i przekrojem poprzecznym dla wszystkich pozycji.

## Orientacja druku

**Zalecana orientacja: oś walca pionowo (jak zapisano w plikach — oś Z), większym kołnierzem
(Ø 29,94 mm, strona z grawerowanym oznaczeniem litery) na stole.**

Powody:
- Otwór centralny drukuje się równolegle do osi Z — czysty okrągły otwór w każdej warstwie,
  bez mostkowania.
- Przejście Ø29,94 → Ø33,94 mm (kołnierz → pierwsza pozycja) to pojedynczy, krótki (2 mm)
  występ na zewnątrz — drukuje się jak zwykły kołnierz, bez podpór.
- Zwężenie Ø33,94 → Ø20,6 mm na drugim końcu jest do wewnątrz — zawsze bezproblemowe.

**Znana niedoskonałość geometrii**: na granicy między dnem "doliny" zęba (promień
`EDGE_MIN_R`, ok. Ø 21,5 mm) a sąsiadującym kołnierzem separującym (pełne Ø 33,94 mm)
promień skacze skokowo o ok. 6,2 mm w jednej warstwie, na wąskim wycinku obwodu (tam gdzie
akurat jest "dolina"). To lokalny, jednowarstwowy nawis — w praktyce FDM zwykle drukuje to
bez podpór (niewielkie smużenie/naddruk w tym jednym miejscu), ale warto obejrzeć ten
konkretny obszar po wydruku i ew. delikatnie oczyścić nożykiem/pilnikiem. Zestaw referencyjny
A ma bardzo podobną geometrię krawędzi, więc ten sam efekt dotyczy również oryginału.

**Nie są potrzebne żadne podpory** — powyższa niedoskonałość jest zbyt lokalna, żeby
uzasadniać budowanie podpór dla całego wydruku.

Odwrócenie części (mniejszym kołnierzem na stół) jest odradzane — wtedy przejście
Ø20,6 → Ø33,94 mm byłoby pojedynczym skokiem na zewnątrz o ~6,7 mm na pełnym obwodzie
(nie tylko lokalnie), czyli za dużo na czysty druk bez podpór.

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

1. Sprawdzić pasowanie otworu centralnego na wałek maszyny — druk FDM często daje otwór
   nieznacznie mniejszy niż nominalny (skurcz materiału); w razie potrzeby delikatnie
   pogłębić rozwiertakiem/wiertłem Ø15,5 mm.
2. Sprawdzić i ew. oczyścić lokalne naddruki na granicy zębów i kołnierzy (patrz wyżej).
3. Sprawdzić płynność ruchu czujnika/popychacza po krawędzi — w razie szorstkości wygładzić
   drobnym pilnikiem.
4. Porównać wychylenie na pozycji "zygzak referencyjny" z zestawem A — jeśli znacząco się
   różni, skorygować `EDGE_MAX_R`/`EDGE_MIN_R` w `cam_common.scad` i przedrukować.

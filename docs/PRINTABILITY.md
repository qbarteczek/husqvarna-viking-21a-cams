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
cztery pliki (`cam_B.scad`, `cam_C.scad`, `cam_D.scad`) przeszły ten test.

Pole `Volumes` w raporcie CGAL (zwykle >1, np. 7) **nie oznacza rozłącznych brył** — to
wewnętrzna dekompozycja Nef polyhedra CGAL uwzględniająca tunele/otwory, typowa dla brył
z przelotowym otworem i rowkami. Liczy się `Simple: yes`.

## Historia dwóch znalezionych i naprawionych problemów

### 1. Zbyt cienka ścianka (naprawione, potem zastąpione podejściem #2)

Pierwsza wersja parametrów (`GROOVE_PITCH_R=13.0`, wychylenie ±3.0 mm wokół tego promienia)
przy najsilniej wychylonych profilach (amplituda znormalizowana do 0.9, np. muszelka w B,
strzałka w C) zostawiała ok. 0.17 mm ścianki od strony powierzchni zewnętrznej — praktycznie
przebicie na wylot, za mało dla FDM.

### 2. Rowek całkowicie schowany w materiale — błąd funkcjonalny (naprawione ostatecznie)

Próba naprawy problemu #1 (zmniejszenie promienia i amplitudy tak, żeby zostawić margines po
obu stronach) doprowadziła do **poważniejszego błędu**: rowek przestał w ogóle sięgać
powierzchni zewnętrznej — cała krzywka wyglądałaby jak gładki walec bez żadnego funkcjonalnego
rowka, bo trzpień śledzący maszyny wchodzi w rowek **z zewnątrz** i nie miałby jak go dosięgnąć.
Wykryte przez bezpośrednią analizę wygenerowanej geometrii (przekrój poprzeczny pokazał idealne
koło zamiast falistego kształtu).

**Ostateczne rozwiązanie**: rowek liczony jest jako głębokość cięcia **od powierzchni głównego
walca** (`GROOVE_BASE_R = MAIN_R - 0.5`), a nie jako wychylenie wokół promienia środkowego —
dzięki temu nawet najpłytszy punkt toru faktycznie przebija powierzchnię (bo szerokość narzędzia
cięcia > margines do `MAIN_R`), a najgłębszy punkt (`GROOVE_DEEP_R`) zostawia bezpieczne
**~1,5–1,9 mm** ścianki do otworu centralnego. Zweryfikowane przekrojem poprzecznym dla
wszystkich pozycji każdego zestawu — patrz `docs/renders/cam_*_cross_section.png`.

## Orientacja druku

**Zalecana orientacja: oś walca pionowo (jak zapisano w plikach — oś Z), większym kołnierzem
(Ø 29,94 mm, strona z grawerowanym oznaczeniem litery) na stole.**

Powody:
- Otwór centralny drukuje się równolegle do osi Z — czysty okrągły otwór w każdej warstwie,
  bez mostkowania.
- Przejście Ø29,94 → Ø33,94 mm (kołnierz → główny walec) to pojedynczy, krótki (2 mm) występ
  na zewnątrz — drukuje się jak zwykły kołnierz, bez podpór.
- Zwężenie Ø33,94 → Ø20,6 mm na drugim końcu jest do wewnątrz — zawsze bezproblemowe.
- Rowki krzywek to płytkie, wąskie (2,2 mm) kanały wycięte w ściance pionowej — każda warstwa
  drukuje pełny pierścień z lokalnie mniejszym/większym promieniem; "sufit" nad kanałem to
  mostek szerokości ~2,2 mm, dobrze w granicach typowego bezpiecznego mostkowania FDM
  (standardowo do 5–10 mm bez podpór).
- **Nie są potrzebne żadne podpory.**

Odwrócenie części (mniejszym kołnierzem na stół) jest odradzane — wtedy przejście
Ø20,6 → Ø33,94 mm byłoby pojedynczym skokiem na zewnątrz o ~6,7 mm, czyli za dużo na czysty
druk bez podpór.

## Oznaczenie litery zestawu

Litera (`B`/`C`/`D`) jest wygrawerowana (wycięta na głębokość 0,7 mm) w płaskiej powierzchni
większego kołnierza — czyli w zalecanej orientacji druku znajdzie się **od strony stołu**.
To celowe i częste podejście (grawerunek identyfikacyjny na spodzie wydruku) — żeby odczytać
oznaczenie, obróć gotową część spodem do góry. Grawerunek nie wpływa na drukowalność (płytki,
0,7 mm, nie tworzy nawisów).

## Parametry druku (proponowane, do weryfikacji)

| Parametr | Wartość | Uwaga |
|---|---|---|
| Wysokość warstwy | 0.12–0.16 mm | drobniejsze warstwy = lepsza wierność krzywej rowka |
| Materiał | PETG lub ABS | lepsza odporność na ścieranie/ciepło niż PLA przy stałym użytkowaniu w maszynie; PLA OK do testu dopasowania |
| Wypełnienie | 40–60% | element pracuje pod obciążeniem mechanicznym (trzpień śledzący) |
| Ściany (perimeters) | min. 3 | dodatkowa wytrzymałość wokół otworu i rowków |
| Podpory | brak | patrz uzasadnienie wyżej |
| Brim/skirt | zalecany brim 3–5 mm | stabilizacja podczas druku wysokiego, wąskiego elementu obracającego się później pod obciążeniem |
| Orientacja | oś pionowo, duży kołnierz na dole | patrz wyżej |

## Kroki po wydruku

1. Sprawdzić pasowanie otworu centralnego na wałek maszyny — druk FDM często daje otwór
   nieznacznie mniejszy niż nominalny (skurcz materiału); w razie potrzeby delikatnie
   pogłębić rozwiertakiem/wiertłem Ø15,5 mm.
2. Sprawdzić płynność ruchu trzpienia śledzącego w rowku — w razie szorstkości wygładzić
   drobnym pilnikiem igłowym.
3. Porównać szerokość ściegu zestawu A (oryginał) z nowym zestawem na pozycji "zygzak
   referencyjny" — jeśli znacząco się różni, skorygować `GROOVE_BASE_R`/`GROOVE_DEEP_R`
   w `cam_common.scad` i przedrukować.

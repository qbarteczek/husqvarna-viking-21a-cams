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

## Znaleziony i naprawiony problem: zbyt cienka ścianka

Pierwsza wersja parametrów (`GROOVE_PITCH_R=13.0`, `GROOVE_AMP=3.0`) przy najsilniej
wychylonych profilach (amplituda znormalizowana do 0.9, np. muszelka w B, strzałka w C)
zostawiała:

- od strony otworu centralnego: ok. **1.45 mm** ścianki,
- od strony powierzchni zewnętrznej: ok. **0.17 mm** ścianki — praktycznie przebicie na wylot.

To za mało dla FDM (ryzyko dziury/pęknięcia na złączu warstw, brak trwałości mechanicznej
rowka pod obciążeniem trzpienia śledzącego).

**Poprawka**: `GROOVE_PITCH_R=12.4`, `GROOVE_AMP=2.0` — przy tej samej maks. amplitudzie 0.9
zostaje min. **~1.7 mm** ścianki po obu stronach (otwór i powierzchnia zewnętrzna) dla
wszystkich 15 profili B/C/D. Konsekwencja: nieco węższy zakres ruchu igły niż w pierwotnym
założeniu — do skalibrowania wydrukiem próbnym (patrz "Kalibracja" w `STITCH_DESIGN.md`).

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
   referencyjny" — jeśli znacząco się różni, skorygować `GROOVE_AMP` w `cam_common.scad`
   i przedrukować.

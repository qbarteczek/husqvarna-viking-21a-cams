# Wymiary mechaniczne — zestaw A (referencja)

Źródło: `V21ZZ3Z.stl` z paczki [thing:6018240](https://www.thingiverse.com/thing:6018240)
(Viking 21a Basic Stitch Cam, maxkrippler). Wymiary wyciągnięte przez analizę geometrii
siatki STL (5706 trójkątów, format binarny, wygenerowany narzędziem ATF — prawdopodobnie
eksport z Fusion 360).

## Typ mechanizmu — WAŻNE ODKRYCIE

To **nie jest płaska tarcza z profilowanym obrysem** (jak krzywki Elna Supermatic), tylko
**krzywka bębnowa / walcowa (barrel/drum cam)**:

- walec obraca się wokół osi (w pliku = oś Y),
- na powierzchni walca wyfrezowany jest rowek (tor) o zmiennym promieniu,
- trzpień/widełki maszyny wsuwają się w rowek i przesuwają igłę na boki (zygzak) w miarę
  obrotu walca podczas szycia,
- dźwignia wyboru ściegu przesuwa trzpień **osiowo** (wzdłuż Y) do jednej z **5 pozycji** —
  to zgadza się z opisem z README: "Positions 1&2 → 3-step zigzag, positions 3~5 → zygzak".

Każda z 5 pozycji to odrębny, zamknięty tor (pierścień) na innej "wysokości" walca — nie jeden
ciągły ślimak na całej długości.

## Zmierzone wymiary (oś obrotu = Y)

| Cecha | Wartość | Uwagi |
|---|---:|---|
| Długość całkowita walca | **26.01 mm** | zakres Y: 0 → 26.0096 |
| Maks. średnica zewnętrzna (grzbiet toru) | **~33.94–34.06 mm** | promień dopasowany metodą najmniejszych kwadratów (fit okręgu) do zewnętrznej ścianki: R=16.97 mm |
| Średnica otworu centralnego (na wałek napędowy) | **~15.4–15.6 mm** | promień ~7.71–7.80 mm, spójny na obu końcach — brak wyraźnego wpustu/D-shape w granicach dokładności pomiaru |
| Kołnierz/piasta na końcu Y=0 | promień **14.97 mm** (Ø ~29.9 mm) | węższy niż maks. średnica walca — najpewniej element mocujący/wprowadzający |
| Kołnierz/piasta na końcu Y=26 | promień **~10.3 mm** (Ø ~20.6 mm) | wyraźnie węższy niż strona Y=0 — walec jest **niesymetryczny końcami**, prawdopodobnie ten koniec wchodzi głębiej / ustala orientację |
| Asymetria obrysu w osi Z | bbox Z: -17.03 do +16.42 (nie idealnie symetryczny mimo dopasowanego środka w Z≈0) | ślad po rowku tnącym powierzchnię niesymetrycznie (naturalne dla nie-okresowego wzoru ściegu) |

## Co z tego wynika dla B, C, D

Żeby nowe zestawy fizycznie pasowały do maszyny, muszą zachować:
- tę samą długość walca (26.0 mm) i te same 5 pozycji osiowych w tych samych miejscach,
- tę samą średnicę i kształt otworu centralnego (~15.5 mm, okrągły),
- te same średnice/kształty kołnierzy na obu końcach (Ø 29.9 mm przy Y=0, Ø 20.6 mm przy Y=26),
- tę samą maksymalną obwiednię zewnętrzną (Ø ~34 mm), żeby zmieściły się w tej samej wnęce maszyny,
- tę samą szerokość/głębokość rowka (do doprecyzowania — nie udało się jej wiarygodnie
  wyciągnąć samym parsowaniem wierzchołków STL bez narzędzia do przekrojów; do zweryfikowania
  przy pierwszym wydruku próbnym).

Różni się **tylko kształt toru (promień w funkcji kąta obrotu)** na każdej z 5 pozycji —
to jest właśnie "wzór ściegu", który projektujemy indywidualnie dla B, C, D.

## Ograniczenia tej analizy

Wymiary wyciągnięto z analizy surowej siatki trójkątów (bez dostępu do CAD/OpenSCAD/Python
w tym środowisku) — metoda: dopasowanie okręgu do zewnętrznej ścianki + klastrowanie
promieni na przekrojach krańcowych. Dokładność rzędu ±0.1–0.2 mm. **Przed drukiem produkcyjnym
zalecana jest weryfikacja pierwszym wydrukiem próbnym / pomiarem fizycznym oryginału, jeśli jest
dostępny.**

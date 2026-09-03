# Wymiary mechaniczne — zestaw A (referencja)

Źródło: `V21ZZ3Z.stl` z paczki [thing:6018240](https://www.thingiverse.com/thing:6018240)
(Viking 21a Basic Stitch Cam, maxkrippler). Wymiary wyciągnięte przez bezpośrednią analizę
wierzchołków siatki STL (skan promienia `sqrt(x²+z²)` w funkcji pozycji na osi Y, w krokach
0.1–0.25 mm), nie z narzędzia CAD (brak takiego w tym środowisku).

## Typ mechanizmu — trzy poprawki po kolejnych, coraz dokładniejszych analizach

1. To **nie jest płaska tarcza z profilowanym obrysem** (jak krzywki Elna Supermatic), tylko
   krzywka bębnowa/walcowa z 5 pozycjami osiowymi.
2. Profil ściegu to **sama krawędź walca** (jak ząbki/zęby), nie schowany rowek — czujnik
   maszyny jeździ bezpośrednio po krawędzi. Pozycje **sąsiadują bezpośrednio, bez odstępu**.
3. Krzywka **nie ma otworu przelotowego na wałek**. To, co wcześniej wzięto za "otwór
   centralny", to w rzeczywistości: (a) płytkie, ślepe gniazdo montażowe wycięte od czoła
   dużego kołnierza i (b) osobny, węższy **czop montażowy** będący częścią wieloschodkowego
   trzpienia między dużym kołnierzem a częścią zębatą. Cała reszta bryły jest lita.

## Zmierzone wymiary (oś obrotu = Y w oryginalnym pliku)

Współrzędna Y biegnie od 0 (duży kołnierz, strona z widoczną strukturą montażową) do 26.01
(mały kołnierz na przeciwnym końcu).

| Odcinek (Y) | Promień | Opis |
|---|---:|---|
| Y = 0 (czoło) | Ø 29.94 mm (r 14.97) na zewnątrz, gniazdo r ≈ 7.8 mm w środku | czoło dużego kołnierza z wyciętym ślepym gniazdem montażowym |
| Y = 0 – 3.2 | r = 14.97 mm | duży kołnierz (lity, poza gniazdem od czoła) |
| Y = 3.2 – 3.7 | 14.97 → 9.75 mm | stożkowe przejście / próg |
| Y = 3.7 – 5.8 | r = 9.75 mm | stała szyjka pośrednia |
| Y = 5.8 – 6.3 | 9.75 → 13.97 mm | stożkowe przejście / próg (promień znowu rośnie!) |
| Y = 6.3 – 7.3 | r = 13.97 mm | stały kołnierzyk pośredni |
| Y = 7.3 – 7.8 | 13.97 → 7.75 mm | stożkowe przejście / próg |
| Y = 7.8 – 9.7 | r = 7.75 mm | **czop montażowy** (najwęższy odcinek trzpienia) |
| Y = 9.7 – ~24.25 | r = 6–17 mm (zmienny) | część zębata — 5 pozycji ściegu, sąsiadujących bez odstępu |
| Y = ~24.25 – 26 | r → 10.30 mm | zwężenie do małego kołnierza na dalekim końcu |

Głębokość gniazda montażowego od czoła Y=0: ok. 2.5 mm (do potwierdzenia — pomiar siatki nie
rozstrzyga jednoznacznie dokładnego dna, tylko obecność i promień gniazda).

## Co z tego wynika dla B, C, D

Żeby nowe zestawy fizycznie pasowały do maszyny, muszą zachować:
- tę samą długość całkowitą (26.0 mm),
- ten sam, dokładny profil schodkowego trzpienia montażowego (Y=3.2–9.7) — to
  prawdopodobnie kluczowy element pozycjonujący/mocujący, nie dowolny szczegół kosmetyczny,
- to samo ślepe gniazdo montażowe w czole dużego kołnierza,
- te same średnice kołnierzy na obu końcach (Ø 29.9 mm przy Y=0, Ø 20.6 mm przy Y=26),
- tę samą maksymalną obwiednię części zębatej (Ø ~34 mm),
- **brak odstępu między pozycjami** ściegu w części zębatej.

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

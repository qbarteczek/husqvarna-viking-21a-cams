# Analiza drukowalności i zalecenia druku 3D dla bębnów Husqvarna 21E

## Status weryfikacji geometrii

Wszystkie modele w formacie STL wygenerowano przy użyciu pełnego silnika CGAL w OpenSCAD:

```
Simple: yes
Volumes: 3
```

Wynik `Simple: yes` gwarantuje, że bryły są w 100% zamkniętymi, poprawnymi rozmaitościami 2-manifold (watertight/manifold), wolnymi od samoprzecięć czy odwróconych normalnych, gotowymi bezpośrednio do wczytania w dowolnym slicerze (Bambu Studio, PrusaSlicer, Cura, OrcaSlicer).

---

## Podsumowanie geometrii zgodnej z fizycznym bębnem

1. **Orientacja bębna do druku**:
   - **Oś Z pionowo**, czoło bębna (dysk z grawerunkiem Z=0) spoczywa płasko na stole roboczym (build plate).
   - Taka orientacja gwarantuje:
     - Maksymalną dokładność wymiarową profilu zębów krzywki w płaszczyźnie XY (rozdzielczość pasów i silników osi XY zamiast skoków warstwy Z).
     - Idealnie okrągły otwór centralny oraz rowek wpustowy bez konieczności podpór wewnątrz otworu.
     - Rowki na dysku czołowym układają się poziomo, nie tworząc nawisów.
     - Część zębata ciągnie się aż do samego końca walca (brak osobnego kołnierza na dalekim końcu) — kończy się płasko, bez dodatkowych przejść do wydrukowania na górze.

2. **Druk bez podpór (No Supports Required)**:
   - Dzięki usunięciu sztucznej szyjki przed krzywkami (czerwona strzałka z adnotacji użytkownika) oraz zastąpieniu ostrego skoku promienia między szyjką a kołnierzem głównym (11.5 → 17.03 mm) gładkim stożkiem (`NECK_TAPER_LEN` w `cam_common.scad`), model można drukować **całkowicie bez podpór** — nie ma już żadnego pojedynczo-warstwowego nawisu rzędu kilku mm, który wcześniej wymagałby wsparcia pod krawędzią kołnierza głównego.

3. **Ścięcie na czole (`CHAMFER_LEN`)**:
   - Mała faza stożkowa na górnej krawędzi dysku czołowego (Z=0) — drukowana jako pierwsza, na styku ze stołem; kąt jest łagodny (0.6 mm na promieniu ~14 mm), więc nie tworzy nawisu ani problemu z pierwszą warstwą.

4. **Grawerunek na pierwszej warstwie**:
   - Napisy "HUSQVARNA", "SWEDEN", litera bębna oraz znaczniki indeksujące mają głębokość wcięcia 0.4–0.5 mm.
   - Przy pierwszej warstwie o wysokości 0.20 mm zostaną one wyraźnie odwzorowane jako elegancki, czytelny deboss.

5. **Trzpień testowy (`mating_shaft_reference.stl`)**:
   - Przed wielogodzinnym drukiem pełnego bębna zaleca się wydrukowanie małego trzpienia testowego `mating_shaft_reference.stl`.
   - Trzpień posiada fabryczny luz montażowy `SHAFT_CLEARANCE = 0.15 mm`.
   - Pozwala w kilka minut sprawdzić pasowanie otworu Ø 15.6 mm oraz wpustu z wałkiem maszyny.

---

## Rekomendowane parametry w slicerze

| Parametr | Rekomendowana wartość | Uzasadnienie |
|---|---|---|
| **Materiał** | **PETG / ABS / ASA / Nylon (PA-CF)** | Część pracuje pod stałym naciskiem sprężynowego popychacza maszyny. PLA jest akceptowalne do testów geometrii, ale PETG/ABS/ASA zapewnią wieloletnią trwałość zmęczeniową i odporność na oleje maszynowe. |
| **Wysokość warstwy** | **0.12 mm – 0.16 mm** (pierwsza: 0.20 mm) | Cieńsza warstwa zapewnia gładkie przejścia na zębach krzywki i brak schodkowania przy ruchu czujnika ściegu. |
| **Liczba obrysów (Walls / Perimeters)** | **4 – 5 obrysów** | Zęby krzywki i kołnierze powinny być wykonane niemal z litego materiału (100% obrysów w strefie zębów). |
| **Wypełnienie (Infill)** | **40% – 50% Gyroid** | Zapewnia wysoką sztywność izotropową i odporność na skręcanie pod wpływem napędu wałka. |
| **Chłodzenie** | 40–60% dla PETG, 100% dla PLA | Zapewnia ostre, równe wierzchołki zębów bez podwijania krawędzi. |
| **Prędkość druku ścian zewnętrznych** | **30 – 45 mm/s** | Niska prędkość na obrysach zewnętrznych drastycznie poprawia precyzję wymiarową zębów i gładkość pracy czujnika. |

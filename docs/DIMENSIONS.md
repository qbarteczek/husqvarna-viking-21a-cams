# Wymiary mechaniczne — bęben ściegowy Husqvarna 21E (rodzina 19/20/21A/21E)

Źródło geometrii: bezpośrednia analiza 46 zdjęć w wysokiej rozdzielczości fizycznego bębna A użytkownika oraz adnotacji i korekt naniesionych na render testowy.

## Podsumowanie geometrii bębna

Bęben ma całkowitą długość osiową **26.0 mm** (oś obrotu Z). Składa się z następujących sekcji wzdłuż osi Z:

| Odcinek Z [mm] | Długość [mm] | Promień / Wymiar | Opis elementu |
|---|---:|---:|---|
| **0.0 – 2.4** | 2.4 | R = 14.5 mm (Ø 29.0 mm) | **Dysk czołowy z 3 rowkami**: Posiada 3 płytkie rowki obwodowe (szer. 0.35 mm, głęb. 0.4 mm). Na płaskim czole (Z=0) wygrawerowano literę zestawu ("A"), napisy "HUSQVARNA" i "SWEDEN" oraz radialne znaczniki indeksujące. |
| **2.4 – 4.4** | 2.0 | R = 11.5 mm (Ø 23.0 mm) | **Szyjka / rowek podcięciowy**: przewężenie oddzielające dysk czołowy od kołnierza głównego. |
| **4.4 – 6.4** | 2.0 | R = 17.03 mm (Ø 34.06 mm) | **Kołnierz główny**: definiuje maksymalną średnicę zewnętrzną bębna, idealnie równą wierzchołkom zębów krzywek (`EDGE_MAX_R`). |
| **6.4 – 23.6** | 17.2 | R = 14.20 – 17.03 mm | **Część robocza krzywek (5 pozycji)**: Zaczyna się **bezpośrednio** przy kołnierzu głównym (brak zbędnej szyjki pośredniej). 5 pozycji po 3.44 mm każda, stykających się bez przerw. Amplituda radialna zębów wynosi **2.83 mm** (szczyty R = 17.03 mm, dno dolin R = 14.20 mm). W bębnie A zęby mają profil trapezu (`trap_wave`, 9 zębów na obrót) z płaskimi szczytami i dolinami (fazy stabilizacji igły). |
| **23.6 – 26.0** | 2.4 | R = 11.5 → 10.3 mm | **Kołnierz tylny (montażowy)**: Walec bazowy o promieniu 11.5 mm, zakończony wyraźną fazą stożkową (dł. 1.4 mm, od Z=24.6 do 26.0) ułatwiającą osadzenie bębna na osi maszyny. |
| **0.0 – 26.0** | 26.0 (przelot) | R = 7.8 mm (Ø 15.6 mm) | **Otwór centralny na wałek maszyny**: Otwór **przelotowy na wylot** przez całą długość bębna. |
| **6.4 – 26.0** | 19.6 (nieprzelotowy) | Szer. 4.5 mm, głęb. 2.2 mm | **Wpust (rowek pod klin)**: Wzdłużny rowek wycięty w ściance otworu od strony tylnego kołnierza (Z=26.0) w głąb bębna aż do płaszczyzny początku strefy krzywek / kołnierza głównego (Z=6.4). **Nie przechodzi przez cały bęben** — nie wychodzi na czoło z grawerunkiem. Od strony czoła (Z=0.0 .. 6.4 mm) otwór tworzy jednolitą, gładką tuleję łożyskową (dysk czołowy 2.4 mm + przewężenie szyjki 2.0 mm + kołnierz główny 2.0 mm = 6.4 mm litej ścianki), co zapobiega osłabieniu przewężenia szyjki i chroni grawerunek czołowy. |

---

## Szczegółowe omówienie korekt fizycznych

Na podstawie zdjęć oryginału oraz rysunku z adnotacjami użytkownika rozwiązano wszystkie rozbieżności:

1. **Dysk zewnętrzny z 3 rowkami (żółta strzałka)**:
   - Wcześniej błędnie interpretowany jako helisa/gwint. W rzeczywistości to dysk o średnicy Ø 29.0 mm z trzema równoległymi, płytkimi rowkami obwodowymi.
2. **Kołnierz główny (niebieska strzałka)**:
   - Kołnierz ten wyznacza maksymalną średnicę zewnętrzną bębna i jest równy maksymalnej amplitudzie zębów krzywki (`EDGE_MAX_R = 17.03 mm`, Ø 34.06 mm).
3. **Ciągłość krzywek (czerwona strzałka)**:
   - Zlikwidowano sztuczną wnękę/szyjkę pomiędzy kołnierzem a krzywkami. Ścieżki krzywek zaczynają się bezpośrednio na ściance kołnierza głównego (przy Z = 6.4 mm).
4. **Otwór przelotowy i precyzyjny zakres wpustu (określony ze zdjęć)**:
   - Główny otwór cylindryczny na wałek jest przelotowy na wylot (Ø 15.6 mm).
   - **Wpust (rowek pod klin wałka)** wprowadzany jest od strony tylnego kołnierza montażowego ($Z = 26.0\text{ mm}$ — zdjęcia `08_far_end_gear_collar_keyway.jpg`, `09_far_end_keyway_closeup.jpg`, `IMG_20260909_081514.jpg`).
   - Biegnie przez strefę krzywek ($Z = 6.4 \dots 23.6\text{ mm}$) i tylny kołnierz ($Z = 23.6 \dots 26.0\text{ mm}$).
   - **Koniec wpustu ($Z = 6.4\text{ mm}$)**: jak widać na zdjęciach pod kątem od strony czoła (`04_engraving_angle.jpg`, `05_engraving_closeup.jpg`), wpust kończy się ślepym prostopadłym uskokiem na głębokości $6.4\text{ mm}$ od czoła. Czoło bębna, przewężenie szyjki (gdzie ścianka przy $R=11.5\text{ mm}$ byłaby zbyt cienka, gdyby wpust wchodził głębiej) oraz kołnierz tworzą $6.4\text{ mm}$ jednolitej tulei bez wycięcia wpustowego. Całkowita długość wpustu wynosi **19.6 mm** ($Z \in [6.4, 26.0]\text{ mm}$).
5. **Kołnierz tylny ze ścięciem stożkowym**:
   - Tylny kołnierz (od Z = 23.6 mm) posiada wyraźne sfazowanie stożkowe wprowadzające, zgodne ze zdjęciami oryginału.
6. **Kształt zębów krzywki A**:
   - Oryginalne zęby na bębnie A nie są ostrymi falami trójkątnymi, lecz falami trapezowymi (`trap_wave`) z płaską półką na szczycie i w dolinie (dwell), co odpowiada czasowi zatrzymania mechanizmu popychacza igły w skrajnych położeniach podczas wbicia igły w materiał.
7. **Skorygowana amplituda zębów krzywek**:
   - Zredukowano przesadną amplitudę (wcześniej 5.03 mm) do realistycznych **2.83 mm** (`EDGE_MAX_R = 17.03 mm`, `EDGE_MIN_R = 14.20 mm`). Na zdjęciach bębna dno ząbków leży zaledwie tuż poniżej krawędzi dysku czołowego (R = 14.5 mm) i znacznie powyżej tylnego kołnierza (R = 11.5 mm).
8. **Orientacja napisów czołowych od lewej do prawej**:
   - Napisy "HUSQVARNA" oraz "SWEDEN" biegną po łuku od lewej do prawej z naturalną orientacją czytania. Litera zestawu ("A") znajduje się czytelnie na dole, a po bokach umieszczone są oryginalne znaczniki indeksujące.

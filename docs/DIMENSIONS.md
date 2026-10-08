# Wymiary mechaniczne — bęben ściegowy Husqvarna 21E (rodzina 19/20/21A/21E)

Źródło geometrii: bezpośrednia analiza 46 zdjęć w wysokiej rozdzielczości fizycznego bębna A użytkownika oraz adnotacji i korekt naniesionych na render testowy.

## Podsumowanie geometrii bębna

Bęben ma całkowitą długość osiową **26.0 mm** (oś obrotu Z). Składa się z następujących sekcji wzdłuż osi Z:

| Odcinek Z [mm] | Długość [mm] | Promień / Wymiar | Opis elementu |
|---|---:|---:|---|
| **0.0 – 2.4** | 2.4 | R = 14.5 mm (Ø 29.0 mm) | **Dysk czołowy z 3 rowkami**: Posiada 3 płytkie rowki obwodowe (szer. 0.35 mm, głęb. 0.4 mm). Na płaskim czole (Z=0) wygrawerowano literę zestawu ("A"), napisy "HUSQVARNA" i "SWEDEN" oraz radialne znaczniki indeksujące. |
| **2.4 – 4.4** | 2.0 | R = 11.5 mm (Ø 23.0 mm) | **Szyjka / rowek podcięciowy**: przewężenie oddzielające dysk czołowy od kołnierza głównego. |
| **4.4 – 6.4** | 2.0 | R = 17.03 mm (Ø 34.06 mm) | **Kołnierz główny**: definiuje maksymalną średnicę zewnętrzną bębna, idealnie równą wierzchołkom zębów krzywek (`EDGE_MAX_R`). |
| **6.4 – 23.6** | 17.2 | R = 12.00 – 17.03 mm | **Część robocza krzywek (5 pozycji)**: Zaczyna się **bezpośrednio** przy kołnierzu głównym (brak zbędnej szyjki pośredniej). 5 pozycji po 3.44 mm każda, stykających się bez przerw. W bębnie A zęby mają profil trapezu (`trap_wave`, 9 zębów na obrót) z płaskimi szczytami i dolinami (fazy stabilizacji igły). |
| **23.6 – 26.0** | 2.4 | R = 11.5 → 10.3 mm | **Kołnierz tylny (montażowy)**: Walec bazowy o promieniu 11.5 mm, zakończony wyraźną fazą stożkową (dł. 1.4 mm, od Z=24.6 do 26.0) ułatwiającą osadzenie bębna na osi maszyny. |
| **0.0 – 26.0** | 26.0 (przelot) | R = 7.8 mm (Ø 15.6 mm) | **Otwór centralny na wałek maszyny**: Otwór **przelotowy na wylot** przez całą długość bębna. |
| **4.4 – 26.0** | 21.6 (nieprzelotowy) | Szer. 4.5 mm, głęb. 2.2 mm | **Wpust (rowek pod klin)**: Wzdłużny rowek wycięty w ściance otworu od strony tylnego kołnierza (Z=26.0) w głąb bębna do kołnierza głównego (Z=4.4). **Nie przechodzi przez cały bęben** — nie wychodzi na czoło z grawerunkiem. Od strony czoła (Z=0.0 .. 4.4 mm) otwór pozostaje w 100% okrągłym, gładkim pierścieniem. |

---

## Szczegółowe omówienie korekt fizycznych

Na podstawie zdjęć oryginału oraz rysunku z adnotacjami użytkownika rozwiązano wszystkie rozbieżności:

1. **Dysk zewnętrzny z 3 rowkami (żółta strzałka)**:
   - Wcześniej błędnie interpretowany jako helisa/gwint. W rzeczywistości to dysk o średnicy Ø 29.0 mm z trzema równoległymi, płytkimi rowkami obwodowymi.
2. **Kołnierz główny (niebieska strzałka)**:
   - Kołnierz ten wyznacza maksymalną średnicę zewnętrzną bębna i jest równy maksymalnej amplitudzie zębów krzywki (`EDGE_MAX_R = 17.03 mm`, Ø 34.06 mm).
3. **Ciągłość krzywek (czerwona strzałka)**:
   - Zlikwidowano sztuczną wnękę/szyjkę pomiędzy kołnierzem a krzywkami. Ścieżki krzywek zaczynają się bezpośrednio na ściance kołnierza głównego (przy Z = 6.4 mm).
4. **Otwór przelotowy i wpust (rowek)**:
   - Główny otwór cylindryczny na wałek jest przelotowy na wylot (Ø 15.6 mm).
   - **Wpust (rowek pod klin wałka)** wprowadzany jest od strony tylnego kołnierza montażowego i biegnie przez strefę roboczą krzywek, ale **nie przechodzi przez czoło bębna**. Kończy się na głębokości Z = 4.4 mm (długość wpustu 21.6 mm), co pozostawia czołowy dysk i szyjkę w postaci pełnego, gładkiego cylindra bez wycięcia.
5. **Kołnierz tylny ze ścięciem stożkowym**:
   - Tylny kołnierz (od Z = 23.6 mm) posiada wyraźne sfazowanie stożkowe wprowadzające, zgodne ze zdjęciami oryginału.
6. **Kształt zębów krzywki A**:
   - Oryginalne zęby na bębnie A nie są ostrymi falami trójkątnymi, lecz falami trapezowymi (`trap_wave`) z płaską półką na szczycie i w dolinie (dwell), co odpowiada czasowi zatrzymania mechanizmu popychacza igły w skrajnych położeniach podczas wbicia igły w materiał.

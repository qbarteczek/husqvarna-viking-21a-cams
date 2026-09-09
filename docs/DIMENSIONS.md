# Wymiary mechaniczne — bęben ściegowy Husqvarna 21E (rodzina 19/20/21A/21E)

Źródło geometrii: bezpośrednia analiza 46 zdjęć w wysokiej rozdzielczości fizycznego bębna A użytkownika (`C:\Users\Qbart\Downloads\husqvarna\`, skopiowane do `references/`) oraz adnotacji i korekt naniesionych na render testowy. Brak w zdjęciach linijki/suwmiarki — wszystkie wymiary to oszacowania proporcji względem znanej średnicy elementów, nie pomiary bezwzględne. **Do potwierdzenia wydrukiem próbnym.**

## Podsumowanie geometrii bębna

Bęben ma całkowitą długość osiową **26.0 mm** (oś obrotu Z). Składa się z następujących sekcji wzdłuż osi Z:

| Odcinek Z [mm] | Długość [mm] | Promień / Wymiar | Opis elementu |
|---|---:|---:|---|
| **0.0 – 0.6** | 0.6 | R = 13.9 → 14.5 mm | **Ścięcie na czole**: mała faza stożkowa na krawędzi czoła (widoczna na zdjęciach IMG_20260909_074232, _081059). |
| **0.6 – 2.4** | 1.8 | R = 14.5 mm (Ø 29.0 mm) | **Dysk czołowy z 3 rowkami**: 3 płytkie rowki obwodowe (szer. 0.35 mm, głęb. 0.4 mm). Na płaskim czole (Z=0) wygrawerowano literę zestawu ("A"), napisy "HUSQVARNA" i "SWEDEN" oraz radialne znaczniki indeksujące. |
| **2.4 – 3.2** | 0.8 | R = 11.5 mm (Ø 23.0 mm) | **Szyjka**: stała część przewężenia oddzielającego dysk czołowy od kołnierza głównego. |
| **3.2 – 4.4** | 1.2 | R = 11.5 → 17.03 mm | **Stożkowe przejście szyjki do kołnierza głównego**: gładki stożek (nie ostry skok promienia) — unika ok. 5.5 mm nawisu przy druku z osią pionową. |
| **4.4 – 6.4** | 2.0 | R = 17.03 mm (Ø 34.06 mm) | **Kołnierz główny**: definiuje maksymalną średnicę zewnętrzną bębna, równą wierzchołkom zębów krzywek (`EDGE_MAX_R`). |
| **6.4 – 23.6** | 17.2 | R = 14.20 – 17.03 mm | **Część robocza krzywek (5 pozycji)**: zaczyna się bezpośrednio przy kołnierzu głównym — brak zbędnej szyjki pośredniej. 5 pozycji po 3.44 mm każda, stykających się bez przerw. Amplituda radialna zębów wynosi 2.83 mm. W bębnie A zęby mają profil trapezu (`trap_wave`, 9 zębów na obrót) z płaskimi szczytami i dolinami (fazy stabilizacji igły). |
| **23.6 – 26.0** | 2.4 | R = 11.5 → 10.3 mm | **Kołnierz tylny (montażowy)**: walec bazowy o promieniu 11.5 mm, zakończony fazą stożkową (dł. 1.4 mm) ułatwiającą osadzenie bębna na osi maszyny — widoczny na zdjęciu `08_far_end_gear_collar_keyway.jpg` jako osobny, stopniowany element wokół otworu, odrębny od pierścienia zębatego. |
| **0.0 – 26.0** | 26.0 (przelot) | R = 7.8 mm (Ø 15.6 mm) | **Otwór centralny na wałek maszyny**: otwór **przelotowy na wylot** przez całą długość bębna. |
| **6.4 – 26.0** | 19.6 (nieprzelotowy) | Szer. 4.5 mm, głęb. 2.2 mm | **Wpust (rowek pod klin)**: wzdłużny rowek wycięty w ściance otworu od strony tylnego kołnierza (Z=26.0) w głąb bębna aż do początku kołnierza głównego / strefy krzywek (Z=6.4). **Nie przechodzi przez cały bęben** — nie wychodzi na czoło z grawerunkiem. Czoło, szyjka i kołnierz główny (Z=0.0–6.4 mm) tworzą jednolitą, pełną tuleję — zapobiega to osłabieniu wąskiej szyjki (R=11.5 mm) i chroni grawerunek czołowy. |

---

## Szczegółowe omówienie korekt fizycznych

Na podstawie bezpośredniej analizy wszystkich 46 zdjęć oraz rysunku z adnotacjami użytkownika (czerwona/żółta/niebieska strzałka) rozwiązano wszystkie rozbieżności względem poprzednich wersji (opartych głównie na pliku referencyjnym STL z thing:6018240):

1. **Dysk czołowy z 3 rowkami (żółta strzałka: "to nie jest gwint, i jest znacznie mniejsze niż maksymalna amplituda krzywek")**:
   - Wcześniej błędnie interpretowany jako helisa/gwint śrubowy. W rzeczywistości to dysk o średnicy Ø 29.0 mm z trzema równoległymi, płytkimi rowkami obwodowymi (nie helisą) — wyraźnie węższy niż część zębata.
2. **Kołnierz główny, osobny od dysku czołowego (niebieska strzałka: "jest szersze i określa maksymalną średnicę/amplitudę krzywek")**:
   - To NIE dysk z grawerunkiem (który jest węższy), lecz osobny, płaski kołnierzyk pośredni między szyjką a częścią zębatą. Wyznacza maksymalną średnicę zewnętrzną bębna, równą maksymalnej amplitudzie zębów krzywki (`FLANGE_R = EDGE_MAX_R = 17.03 mm`, Ø 34.06 mm).
3. **Ciągłość krzywek (czerwona strzałka: "to nie powinno istnieć, poszerz krzywki aby wypełnić tę przestrzeń")**:
   - Zlikwidowano sztuczną wnękę między kołnierzem a krzywkami — nie przez poszerzenie samych krzywek, lecz przez zastąpienie ostrego skoku promienia (11.5 → 17.03 mm) gładkim stożkiem w szyjce (`NECK_TAPER_LEN`), tak żeby nigdzie nie było odcinka węższego niż dolina krzywek. Dodatkowo eliminuje to ok. 5.5 mm nawis, który wymagałby podpory przy druku z osią pionową.
4. **Otwór przelotowy i precyzyjny zakres wpustu**:
   - Główny otwór na wałek jest przelotowy na wylot (Ø 15.6 mm) — sensowne mechanicznie dla wymiennych bębnów nasuwanych na wspólny wałek maszyny.
   - Wpust (rowek pod klin) NIE przechodzi przez cały bęben: zdjęcia czoła pod kątem (`04_engraving_angle.jpg`, `05_engraving_closeup.jpg`) pokazują czysty, gładki otwór bez wycięcia, natomiast zdjęcia dalekiego końca (`08_far_end_gear_collar_keyway.jpg`, `09_far_end_keyway_closeup.jpg`, `IMG_20260909_081514.jpg`) pokazują wyraźne wycięcie wpustowe. Wpust zaczyna się na wysokości kołnierza głównego (Z = 6.4 mm) i biegnie do tylnego końca (Z = 26.0 mm). Dodatkowy argument wytrzymałościowy: przy R=11.5 mm w szyjce, wpust sięgający głębiej zostawiłby tam zbyt cienką ściankę.
5. **Ścięcie na czole**:
   - Krawędź dysku czołowego (Z=0) ma małą fazę stożkową, widoczną na kilku zdjęciach czoła.
6. **Kołnierz tylny ze ścięciem stożkowym**:
   - Tylny kołnierz (od Z = 23.6 mm) ma wyraźne sfazowanie stożkowe wprowadzające — osobny, stopniowany element wokół otworu na dalekim końcu, widoczny na `08_far_end_gear_collar_keyway.jpg` i `09_far_end_keyway_closeup.jpg`, odrębny od pierścienia zębatego.
7. **Kształt zębów krzywki A**:
   - Zęby na bębnie A nie są ostrymi falami trójkątnymi, lecz falami trapezowymi (`trap_wave`) z płaską półką na szczycie i w dolinie (dwell), co odpowiada czasowi zatrzymania mechanizmu popychacza igły w skrajnych położeniach podczas wbicia igły w materiał.
8. **Amplituda krzywek (głębokość zębów)**:
   - Pierwsza wersja oparta na zdjęciach ustawiała `EDGE_MIN_R = 12.00 mm` (wychylenie 5.03 mm, ok. 29.5% promienia szczytu) — po korekcie użytkownika ("amplituda nadal jest za duża") zmniejszono do `EDGE_MIN_R = 14.20 mm` (wychylenie 2.83 mm, ok. 16.6% promienia szczytu). Na zdjęciach dno ząbków leży tuż poniżej krawędzi dysku czołowego (R = 14.5 mm), używanego jako skala odniesienia w tym samym kadrze, i wyraźnie powyżej promienia tylnego kołnierza (R = 11.5 mm) — stąd promień dna dolin bliski, ale nieco mniejszy niż `DISC_R`.

## Weryfikacja przez porównanie z niezależną analizą

Ten model (gałąź/katalog "claude") był porównany z niezależnie wykonaną analizą tych samych
46 zdjęć przez inny model AI (Gemini, katalog `krzywki-do-husqvarna-gemini`). Obie analizy
zbiegły się na wielu punktach (wąski dysk czołowy, osobny szeroki kołnierz główny, przelotowy
otwór główny, redukcja amplitudy zębów do zbliżonych wartości: 14.20 vs 14.50 mm). Tam, gdzie
się różniły, ponowne, bezpośrednie sprawdzenie zdjęć rozstrzygnęło na korzyść:
- analizy Gemini w sprawie kołnierza tylnego (przywrócony — zdjęcie `08_far_end_gear_collar_keyway.jpg`
  jednoznacznie pokazuje osobny, stopniowany element, którego wcześniejsza wersja tego dokumentu
  błędnie nie uwzględniła) i zasięgu wpustu (cofnięty do Z=6.4, zamiast przelotowego — potwierdzone
  brakiem wycięcia na zdjęciach czoła pod kątem),
- tego modelu w sprawie stożkowego przejścia szyjka→kołnierz (Gemini zostawiło tam ostry, wymagający
  podpory skok promienia) i rozmieszczenia grawerunku (litera u góry, HUSQVARNA u dołu — zgodnie z
  `03_engraving_husqvarna_sweden_A.jpg`; wersja Gemini miała to odwrotnie).

## Historia poprzednich wersji

Wcześniejsze wersje tego dokumentu opisywały geometrię wyprowadzoną głównie z pliku referencyjnego STL (`V21ZZ3Z.stl`, thing:6018240, replika trzeciej strony) — wieloschodkowy trzpień montażowy schodzący do ~7.75 mm, kołnierz z grawerunkiem o tej samej średnicy co szczyty zębów, gwint śrubowy na kołnierzu, żeberko wystające do wnętrza otworu. Po bezpośrednim, systematycznym przejrzeniu wszystkich 46 zdjęć fizycznego bębna A okazało się, że rzeczywista część różni się w kilku istotnych punktach (patrz wyżej) — plik STL pozostaje wiarygodny dla ogólnych proporcji (długość, zasięg zębów), ale nie dla szczegółów elementu montażowego między kołnierzem a częścią zębatą.

## Ograniczenia tej analizy

Żadne z 46 zdjęć nie zawiera linijki, suwmiarki ani innego wzorca skali — wszystkie wymiary powyżej to oszacowania proporcji względem znanej średnicy dysku czołowego/kołnierza głównego widocznych w tym samym kadrze, nie pomiary bezwzględne. **Przed drukiem produkcyjnym zalecana jest weryfikacja wydrukiem próbnym** (zacznij od `mating_shaft_reference.scad` — szybszy, tańszy test dopasowania otworu i wpustu niż cały bęben) **i porównaniem z oryginałem / fizycznym gniazdem maszyny, jeśli jest dostępne.**

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
| **6.4 – 26.0** | 19.6 | R = 14.50 – 17.03 mm | **Część robocza krzywek (5 pozycji)**: zaczyna się bezpośrednio przy kołnierzu głównym i ciągnie się aż do samego końca walca — brak osobnego kołnierza na dalekim końcu (zdjęcia IMG_20260909_081617, _081625 pokazują płaski koniec bezpośrednio za częścią zębatą). 5 pozycji po 3.92 mm każda, stykających się bez przerw. W bębnie A zęby mają profil trapezu (`trap_wave`, 9 zębów na obrót) z płaskimi szczytami i dolinami (fazy stabilizacji igły). |
| **0.0 – 26.0** | 26.0 (przelot) | R = 7.8 mm (Ø 15.6 mm) | **Otwór centralny na wałek maszyny**: otwór **przelotowy na wylot** przez całą długość bębna. |
| **0.0 – 26.0** | 26.0 (przelot) | Szer. 4.5 mm, głęb. 2.2 mm | **Wpust (rowek pod klin)**: wzdłużny rowek wycięty w ściance otworu, w który wchodzi wypust (klin napędowy) wałka maszyny — **przelotowy przez całą długość bębna**, łącznie z dyskiem czołowym (poprawka użytkownika — wcześniejsza wersja błędnie kończyła rowek przed czołem). |

---

## Szczegółowe omówienie korekt fizycznych

Na podstawie bezpośredniej analizy wszystkich 46 zdjęć oraz rysunku z adnotacjami użytkownika (czerwona/żółta/niebieska strzałka) rozwiązano wszystkie rozbieżności względem poprzednich wersji (opartych głównie na pliku referencyjnym STL z thing:6018240):

1. **Dysk czołowy z 3 rowkami (żółta strzałka: "to nie jest gwint, i jest znacznie mniejsze niż maksymalna amplituda krzywek")**:
   - Wcześniej błędnie interpretowany jako helisa/gwint śrubowy. W rzeczywistości to dysk o średnicy Ø 29.0 mm z trzema równoległymi, płytkimi rowkami obwodowymi (nie helisą) — wyraźnie węższy niż część zębata.
2. **Kołnierz główny, osobny od dysku czołowego (niebieska strzałka: "jest szersze i określa maksymalną średnicę/amplitudę krzywek")**:
   - To NIE dysk z grawerunkiem (który jest węższy), lecz osobny, płaski kołnierzyk pośredni między szyjką a częścią zębatą. Wyznacza maksymalną średnicę zewnętrzną bębna, równą maksymalnej amplitudzie zębów krzywki (`FLANGE_R = EDGE_MAX_R = 17.03 mm`, Ø 34.06 mm).
3. **Ciągłość krzywek (czerwona strzałka: "to nie powinno istnieć, poszerz krzywki aby wypełnić tę przestrzeń")**:
   - Zlikwidowano sztuczną wnękę między kołnierzem a krzywkami — nie przez poszerzenie samych krzywek, lecz przez zastąpienie ostrego skoku promienia (11.5 → 17.03 mm) gładkim stożkiem w szyjce, tak żeby nigdzie nie było odcinka węższego niż dolina krzywek.
4. **Otwór przelotowy i wpust (rowek), oba przelotowe na wylot**:
   - Otwór nie jest ślepy (jak sugerował stary plik Thingiverse), lecz przelotowy na wylot (Ø 15.6 mm) — sensowne mechanicznie dla wymiennych bębnów nasuwanych na wspólny wałek maszyny.
   - W bębnie znajduje się wpust (rowek), a wypust (klin napędowy) wystaje z wałka maszyny — patrz `tools/openscad/mating_shaft_reference.scad`. Rowek jest **przelotowy przez całą długość bębna** (poprawka użytkownika po ponownym sprawdzeniu fizycznej części — wcześniejsza wersja błędnie kończyła go przed dyskiem czołowym, zakładając że tam otwór pozostaje gładki).
5. **Ścięcie na czole**:
   - Krawędź dysku czołowego (Z=0) ma małą fazę stożkową, widoczną na kilku zdjęciach czoła.
6. **Kształt zębów krzywki A**:
   - Zęby na bębnie A nie są ostrymi falami trójkątnymi, lecz falami trapezowymi (`trap_wave`) z płaską półką na szczycie i w dolinie (dwell), co odpowiada czasowi zatrzymania mechanizmu popychacza igły w skrajnych położeniach podczas wbicia igły w materiał.
7. **Amplituda krzywek (głębokość zębów)**:
   - Pierwsza wersja oparta na zdjęciach ustawiała `EDGE_MIN_R = 12.00 mm` (wychylenie 5.03 mm, ok. 29.5% promienia szczytu) — po korekcie użytkownika ("amplituda nadal jest za duża") zmniejszono do `EDGE_MIN_R = 14.50 mm` (wychylenie 2.53 mm, ok. 14.9% promienia szczytu), bliżej subtelnej, "szachownicowej" faktury zębów widocznej na zdjęciach niż poprzednie, głębsze, bardziej kanciaste wcięcia.

## Historia poprzednich wersji

Wcześniejsze wersje tego dokumentu opisywały geometrię wyprowadzoną głównie z pliku referencyjnego STL (`V21ZZ3Z.stl`, thing:6018240, replika trzeciej strony) — wieloschodkowy trzpień montażowy schodzący do ~7.75 mm, kołnierz z grawerunkiem o tej samej średnicy co szczyty zębów, gwint śrubowy na kołnierzu, żeberko wystające do wnętrza otworu. Po bezpośrednim, systematycznym przejrzeniu wszystkich 46 zdjęć fizycznego bębna A okazało się, że rzeczywista część różni się w kilku istotnych punktach (patrz wyżej) — plik STL pozostaje wiarygodny dla ogólnych proporcji (długość, zasięg zębów), ale nie dla szczegółów elementu montażowego między kołnierzem a częścią zębatą.

## Ograniczenia tej analizy

Żadne z 46 zdjęć nie zawiera linijki, suwmiarki ani innego wzorca skali — wszystkie wymiary powyżej to oszacowania proporcji względem znanej średnicy dysku czołowego/kołnierza głównego widocznych w tym samym kadrze, nie pomiary bezwzględne. **Przed drukiem produkcyjnym zalecana jest weryfikacja wydrukiem próbnym** (zacznij od `mating_shaft_reference.scad` — szybszy, tańszy test dopasowania otworu i wpustu niż cały bęben) **i porównaniem z oryginałem / fizycznym gniazdem maszyny, jeśli jest dostępne.**

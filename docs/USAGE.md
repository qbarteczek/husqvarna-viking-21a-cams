# Instrukcja obsługi — montaż i użytkowanie bębnów ściegowych w maszynie

Dotyczy zestawów A, B, C, D (ten projekt — generator) do Husqvarna 21E i modeli pokrewnych
(19, 20, 21A) z tym samym mechanizmem stosu krzywek.

## Zasada działania (przypomnienie)

Bęben **nie ma otworu przelotowego na całą długość** — mocuje się schodkowym trzpieniem
(kilka średnic) i gwintowanym kołnierzem z otworem na wałek napędowy (z wypustem
pryzmatycznym przenoszącym obrót), które pasują do konkretnego gniazda w mechanizmie maszyny
(patrz `docs/DIMENSIONS.md`). Sama krawędź walca na każdej z 5 pozycji jest ukształtowana jako
profil ściegu (ząbki) — czujnik/popychacz maszyny jeździ bezpośrednio po tej krawędzi i
przekłada jej wychylenie na ruch igły w bok. Dźwignia wyboru ściegu na maszynie przesuwa
czujnik **wzdłuż osi bębna** do jednej z 5 pozycji (sąsiadujących bez odstępu) — to wybiera,
który wzór zostanie użyty.

Przed montażem całego bębna warto wydrukować i przetestować
[`tools/openscad/mating_shaft_reference.scad`](../tools/openscad/mating_shaft_reference.scad)
— prosty trzpień sprawdzający dopasowanie otworu i wpustu, patrz `docs/PRINTABILITY.md`.

## Montaż bębna

1. Wyłącz maszynę / odłącz od zasilania przed wymianą bębna.
2. Zdejmij aktualnie zamontowany bęben zgodnie z instrukcją maszyny.
3. Osadź nowy bęben (A/B/C/D) w gnieździe maszyny — **duży, gwintowany kołnierz (Ø 29,94 mm,
   strona z literą) i otwór na wałek z wypustem** ustawione zgodnie z tym, jak był ustawiony
   oryginał (sprawdź orientację na oryginalnym bębnie przed wymianą, jeśli to Twój pierwszy
   montaż). Jeśli mechanizm wymaga wkręcenia gwintu — wkręcaj delikatnie, bez siłowania.
4. Upewnij się, że schodkowy trzpień wchodzi swobodnie w gniazdo maszyny, wypust prawidłowo
   zazębia się z wałkiem, i że czujnik/popychacz dotyka krawędzi bębna na każdej z 5 pozycji —
   przesuń dźwignię wyboru ściegu przez pełny zakres **ręcznie, bez napędu**, żeby sprawdzić,
   że nic się nie zacina, zanim uruchomisz maszynę.
5. Zamknij osłonę.

## Wybór ściegu

Dźwignia wyboru ściegu na maszynie ma 5 pozycji odpowiadających pozycjom 1–5 opisanym w
`docs/STITCH_DESIGN.md` (dla B/C/D) lub w oryginalnym opisie zestawu A (pozycje 1–2 = zygzak
3-stopniowy, 3–5 = zygzak). Ustaw dźwignię na wybraną pozycję **przy nieruchomej igle**
(maszyna wyłączona lub koło ręczne w pozycji spoczynkowej), dopiero potem szyj.

## Pierwsze uruchomienie po wymianie — zalecana procedura

1. Obróć kołem ręcznym maszynę o pełny obrót **bez nitki**, obserwując ruch igły — sprawdź,
   czy zygzak jest płynny, bez szarpnięć czy zacinania trzpienia.
2. Przetestuj wszystkie 5 pozycji po kolei w ten sam sposób.
3. Dopiero po potwierdzeniu płynnego ruchu na wszystkich pozycjach — nawlecz i szyj próbkę na
   skrawku materiału.
4. Jeśli ścieg jest węższy/szerszy niż oczekiwano względem zestawu A — patrz sekcja
   "Kalibracja" w `docs/STITCH_DESIGN.md` (`EDGE_MAX_R`/`EDGE_MIN_R`) i rozważ przedruk.

## Bezpieczeństwo i trwałość

- To są **wydruki 3D** — nie mają twardości/trwałości oryginalnych krzywek fabrycznych
  (metal/bakelit). Traktuj jako rozwiązanie hobbystyczne/serwisowe, nie jako trwały
  zamiennik do intensywnego użytku profesjonalnego.
- Regularnie sprawdzaj krawędź (zęby) pod kątem śladów zużycia (ścierania) — wydruk FDM może
  zużywać się szybciej niż oryginał przy częstym użytkowaniu.
- Nigdy nie zmieniaj pozycji dźwigni wyboru ściegu podczas ruchu igły — ryzyko złamania
  trzpienia śledzącego lub krzywki.
- W razie oporu przy przesuwaniu dźwigni — zatrzymaj się i sprawdź krzywkę/mechanizm zamiast
  siłować.

## Odtworzenie oznaczenia po wydruku

Litera zestawu jest wygrawerowana na spodzie (stronie kołnierza Ø29,94 mm, która podczas
druku leży na stole — patrz `docs/PRINTABILITY.md`). Obróć wydrukowaną część spodem do góry,
żeby ją odczytać.

# Czego potrzebuję, żeby zacząć modelować B, C, D

## 1. Plik zestawu A (geometria mechaniczna)

Thingiverse blokuje automatyczne pobieranie (strona renderowana przez JS, API wymaga
autoryzacji), więc nie mam bezpośredniego dostępu do plików z
https://www.thingiverse.com/thing:6018240.

**Co zrobić:**
1. Wejdź na stronę, pobierz paczkę plików (przycisk "Download all files").
2. Rozpakuj i skopiuj zawartość do `models/original/` w tym repo
   (albo podaj mi lokalną ścieżkę, jeśli zapisałeś gdzie indziej).
3. Jeśli w paczce jest plik `.scad` (parametryczny) — to najlepszy przypadek, mogę odczytać
   wymiary wprost z kodu. Jeśli jest tylko `.stl` — też się da, ale będę potrzebował
   zmierzyć/odczytać wymiary z mesha (np. przez opis autora w komentarzach na Thingiverse,
   albo pomiar w programie typu MeshLab/PrusaSlicer, jeśli masz).

**Kluczowe wymiary, które muszę znać:**
- Średnica i kształt otworu centralnego (okrągły / D-shape / z wpustem?),
- Średnica zewnętrzna tarczy,
- Grubość tarczy,
- Profil toru krzywki: promień min/maks, liczba pozycji na pełny obrót, głębokość rowka,
- Czy tarcza ma jednostronny czy dwustronny tor (single/double, tak jak w Elna),
- Ewentualne oznaczenie orientacji (ząb/otwór ustalający obrót).

## 2. Realne wzory ściegów dla B, C, D

Chcesz wiernej rekonstrukcji historycznych zestawów, więc potrzebuję materiału źródłowego —
jedno z poniższych (im więcej, tym lepiej):

- Skan/zdjęcia stron instrukcji Husqvarna Viking 21A (albo 19/20 — ta sama rodzina) z listą
  ściegów przypisanych do liter A/B/C/D,
- Zdjęcia oryginalnych tarczek B/C/D z widocznym numerem/literą i najlepiej prostopadłym
  ujęciem toru krzywki,
- Link do already-cyfrowej wersji instrukcji, jeśli znajdziesz taką, która nie jest zablokowana
  (np. PDF hostowany bezpośrednio, nie za paywallem typu Scribd — ten akurat sprawdziłem i jest
  zablokowany dla automatycznego odczytu).

Bez tego materiału mogę co najwyżej zaprojektować **nowe, oryginalne** wzory pasujące
mechanicznie do maszyny — ale to nie będzie wierna rekonstrukcja historii, o którą prosiłeś.

## Status

- [ ] Plik zestawu A skopiowany do `models/original/`
- [ ] Wymiary mechaniczne wyciągnięte i spisane w `docs/DIMENSIONS.md`
- [ ] Materiał źródłowy do zestawu B
- [ ] Materiał źródłowy do zestawu C
- [ ] Materiał źródłowy do zestawu D

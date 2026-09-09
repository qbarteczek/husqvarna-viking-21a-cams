# Materiały referencyjne

Dla każdego zestawu (B, C, D) twórz osobny plik:

```text
references/cam_B_sources.md
references/cam_C_sources.md
references/cam_D_sources.md
```

Nie wrzucaj cudzych zdjęć/skanów bez licencji do repo — zapisuj link, datę dostępu,
opis źródła i własny odczytany profil (numer/litera zestawu, lista ściegów, jakość źródła).

## Szablon źródła

```markdown
# Cam X — źródła

## Źródło 1
- URL / pochodzenie:
- Data dostępu:
- Litera zestawu widoczna: tak/nie
- Lista ściegów czytelna: tak/nie/częściowo
- Widok toru krzywki: tak/nie/częściowo
- Jakość: dobra/średnia/słaba
- Uwagi:
```

## Oficjalne dokumenty techniczne w repozytorium

1. **[`Husqvarna-21E_User-Manual_NO.pdf`](Husqvarna-21E_User-Manual_NO.pdf)**:
   - Oficjalna instrukcja obsługi maszyny Husqvarna Automatic 21 E (język norweski).
   - Strona 31: kompletna tabela *Grunnmönster* z nastawami i próbkami przeszyć dla bębnów A1, B1, C1.
   - Strona 28, 30: fabryczna procedura wymiany bębnów na pozycji 5.
   - Strona 55: wykaz części zamiennych i akcesoriów (S 41-10950, S 41-10951, S 41-10952).

2. **[`Husqvarna-Class-21_Service-Manual_EN.pdf`](Husqvarna-Class-21_Service-Manual_EN.pdf)**:
   - Oficjalna instrukcja serwisowa fabryki Viking Husqvarna dla maszyn Class 21.
   - Sekcja 1: kalibracja minimalnego luzu wodzika (*follower*) na najwyższym punkcie krzywki (`EDGE_MAX_R`) na pozycji 5.
   - Sekcja 2: faza ruchu wahadłowego igły (zakończenie przed 7 mm nad płytką).
   - Sekcja 4 i 5: centrowanie igielnicy i regulacja wodzika.

# Wzory ściegów — zestawy fabryczne A1, B1, C1 oraz zestaw rozszerzony D

## Źródła historyczne i specyfikacja fabryczna

Geometria i wzory ściegów zostały zrekonstruowane w oparciu o oficjalne dokumenty techniczne producenta:
1. **Instrukcja obsługi Husqvarna Automatic 21 E** (`Husqvarna-21E_User-Manual_NO.pdf`):
   - Strona 31: *Grunnmönster for kammene A1, B1 og C1* — oficjalna tabela parametrów (szerokość, długość) oraz ryciny przeszyć,
   - Strona 25: *Mönsternøkkelen* — tarcza wyboru ściegów 1- i 2-igłowych,
   - Strona 27, 29, 30: numery katalogowe, procedura wymiany bębna na pozycji 5,
   - Strona 55: wykaz części i akcesoriów.
2. **Instrukcja serwisowa Viking Automatic class 21** (`Husqvarna-Class-21_Service-Manual_EN.pdf`):
   - Sekcja 1 (str. 1): kalibracja minimalnego luzu wodzika (*follower*) w najwyższym punkcie krzywki (`EDGE_MAX_R = 17.03 mm`) na **pozycji 5**,
   - Sekcja 2 (str. 1): synchronizacja fazowa igły — ruch poprzeczny igielnicy kończy się, gdy czubek igły jest co najmniej 7 mm nad płytką ściegową (uzasadnienie faz stabilizacji *dwell* w profilach trapezowych).

---

## Zasada działania mechanizmu

Każdy bęben posiada **5 pozycji osiowych** (`N_POS = 5`), rozdzielonych na odcinku $Z \in [6.4, 23.6]\text{ mm}$ (długość ścieżki `BAND_LEN = 3.44 mm`).
Dźwignia wyboru ściegu (*Mönstervelger*, pozycje 1–5 na tarczy czołowej maszyny) przesuwa palec wodzika wzdłuż osi wałka bębna.
Palec wodzika spoczywa bezpośrednio na profilowanej krawędzi obwodowej walca:
* Gdy krawędź ma promień maksymalny (`EDGE_MAX_R = 17.03 mm`, wartość znormalizowana `-1`), igielnica znajduje się w skrajnym lewym położeniu (baza ściegu prostego).
* Gdy krawędź opada do dna doliny (`EDGE_MIN_R = 14.20 mm`, wartość znormalizowana `+1`), igielnica wykonuje maksymalne wychylenie w prawo (amplituda radialna zęba `EDGE_SWING = 2.83 mm`).

---

## Zestaw A1 — Bęben standardowy (`S 41-10950`)

Fabryczny bęben dostarczany w maszynie (*„i maskinen”*). Zapewnia podstawowe ściegi użytkowe i elastyczne.

| Poz. | Nazwa ściegu wg instrukcji | Nastawa fabryczna (szer./dł.) | Funkcja matematyczna | Zastosowanie i charakterystyka |
|:---:|:---|:---:|:---|:---|
| **1** | **Ścieg brzegowy / kryty** (*Usynlig faldsöm / Picot*) | 4 / 0.3 | `blind_hem(a, 3, 0.20)` | 4–5 wkłuć prostych po lewej stronie + pojedynczy skok w prawo do podszywania dołów i krycia brzegów. |
| **2** | **Zygzak 3-stopniowy elastyczny** (*Trestings siksak / Quick-Stopp*) | 4 / 0.3 | `three_step_zigzag(a, 3)` | Trójskok (3 wkłucia w lewo, 3 w prawo) — elastyczne łączenie dzianin, wszywanie gumy, cerowanie. |
| **3** | **Zygzak klasyczny szeroki** | 4 / 1.0 | `trap_wave(a, 9, 0.28) * 0.95` | Wydłużony skok zygzaka do obrzucania krawędzi. |
| **4** | **Ścieg cerujący / ozdobny gęsty** | 4 / 0.3 | `trap_wave(a, 9, 0.28) * 0.80` | Gęsty zygzak satynowy. |
| **5** | **Zygzak standardowy referencyjny** | 4 / 1.5 | `trap_wave(a, 9, 0.28) * 0.95` | Pozycja spoczynkowa mechanizmu, baza do wymiany bębna. |

---

## Zestaw B1 — Bęben akcesoryjny (`S 41-10951`)

Zestaw ściegów ozdobnych i falistych.

| Poz. | Nazwa ściegu wg instrukcji | Nastawa fabryczna (szer./dł.) | Funkcja matematyczna | Zastosowanie i charakterystyka |
|:---:|:---|:---:|:---|:---|
| **1** | **Ścieg serpentynowy / fala płynna** (*Slangesöm*) | 4 / 1.5 | `sine_wave(a, 3) * 0.90` | Płynna sinusoida o łagodnych łukach (ozdabianie falbanek, bielizny). |
| **2** | **Jodełka schodkowa / gęsta fala łamana** | 4 / 0.3 | `tri_wave(a, 3)*0.70 + tri_wave(a, 18)*0.25` | Załamana fala z drobnym ząbkiem krawędziowym. |
| **3** | **Satynowy romb / liście / perełki** (*Diamantsöm*) | 4 / 0.3 | `diamond_satin(a, 18, 3)` | Płynne rozszerzanie i zwężanie szerokości satyny tworzące serię rombów/perełek. |
| **4** | **Ząbki skośne / piła** (*Tannsöm*) | 4 / 0.3 | `saw_wave(a, 6, 0.80) * 0.90` | Asymetryczny profil piłokształtny o ostrym powrocie. |
| **5** | **Zygzak standardowy referencyjny** | 4 / 1.5 | `trap_wave(a, 9, 0.28) * 0.95` | Pozycja spoczynkowa i referencyjna (identyczna we wszystkich bębnach). |

---

## Zestaw C1 — Bęben akcesoryjny (`S 41-10952`)

Zestaw ściegów geometrycznych i meandrowych.

| Poz. | Nazwa ściegu wg instrukcji | Nastawa fabryczna (szer./dł.) | Funkcja matematyczna | Zastosowanie i charakterystyka |
|:---:|:---|:---:|:---|:---|
| **1** | **Meander grecki / baszty** (*Mekaniskt meander / Tinn*) | 4 / 0.3 | `trap_wave(a, 4, 0.45) * 0.90` | Prostopadłe uskoki z gęstym kryciem tworzące grzebień meandrowy. |
| **2** | **Ścieg płomieniowy / ostry trójkątny** (*Flammesöm*) | 4 / 0.3 | `arrow_sharpen(a, 6, 0.50) * 0.90` | Wyostrzone zęby trójkątne o dużej dynamice wizualnej. |
| **3** | **Bloki satynowe prostokątne** (*Blokksöm*) | 4 / 0.3 | `block_satin(a, 16, 4)` | Naprzemienne schodkowe prostokąty satynowe (przeskok lewo-prawo). |
| **4** | **Klepsydra / podwójny romb** | 4 / 0.3 | `hourglass_satin(a, 18, 3)` | Symetryczne przewężenie satyny tworzące wzór klepsydry. |
| **5** | **Zygzak standardowy referencyjny** | 4 / 1.5 | `trap_wave(a, 9, 0.28) * 0.95` | Pozycja spoczynkowa i referencyjna. |

---

## Zestaw D — Rozszerzony / Eksperymentalny

Zestaw autorski przeznaczony do zadań specjalnych i ściegów wzmocnionych.

| Poz. | Nazwa ściegu | Nastawa (szer./dł.) | Funkcja matematyczna | Charakterystyka |
|:---:|:---|:---:|:---|:---|
| **1** | **Zygzak wąski referencyjny** | 2 / 1.0 | `tri_wave(a, 10) * 0.40` | Drobny zygzak precyzyjny. |
| **2** | **Ślepy ścieg wzmocniony** | 4 / 0.5 | `blind_hem(a, 4, 0.15)` | Rzadsze wkłucia poprzeczne. |
| **3** | **Drabinka** | 4 / 0.5 | `sign(sine_wave(a, 6)) * 0.85` | Dwie równoległe szyny z szybkim przeskokiem. |
| **4** | **Potrójny prosty elastyczny** | 1 / 1.5 | `tri_wave(a, 18) * 0.30` | Szybka mikro-oscylacja wzmacniająca szew. |
| **5** | **Zygzak standardowy referencyjny** | 4 / 1.5 | `trap_wave(a, 9, 0.28) * 0.95` | Pozycja spoczynkowa. |

---

## Zasady mechaniczne i serwisowe

1. **Pozycja nr 5 jako stan spoczynkowy:**
   Na każdym bębnie pozycja nr 5 to standardowy zygzak trapezowy. Zgodnie z instrukcją obsługi (str. 28/30), **przed demontażem lub montażem bębna należy zawsze ustawić wybierak ściegów na pozycję 5**.
2. **Kalibracja zerowego luzu:**
   Zgodnie z instrukcją serwisową (sekcja 1, str. 1), przy ściegu prostym (nastawa 0 na ramieniu i pozycja 5 na wybieraku) luz między wierzchołkiem zęba (`EDGE_MAX_R = 17.03 mm`) a palcem wodzika powinien być zredukowany do absolutnego minimum.
3. **Zakaz pracy bez bębna (*OBS!*, str. 31):**
   Nigdy nie należy uruchamiać maszyny z wyjętym bębnem ściegowym.

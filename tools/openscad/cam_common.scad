// Wspólna biblioteka dla bębnów ściegowych Husqvarna 21E (rodzina 19/20/21A/21E) — generator,
// nie zamknięty zestaw. Nowy bęben: skopiuj cam_template.scad, patrz docs/CREATING_NEW_DRUMS.md.
// Wymaga OpenSCAD 2021.01+ (function literals).
// Wymiary skalibrowane na podstawie analizy pliku V21ZZ3Z.stl z zestawu A
// (thing:6018240) — patrz ../../docs/DIMENSIONS.md. Oś obrotu w tym pliku to Z
// (w oryginalnym STL była to oś Y — sama nazwa osi nie wpływa na pasowanie).
//
// MECHANIZM (drugi raz poprawiony, po dokładnym skanie promienia co 0.1-0.25 mm
// wzdłuż całej długości oryginału A):
// 1. Krawędź walca na każdej z 5 pozycji JEST profilem ściegu (ząbki jak w A),
//    nie schowanym rowekiem — czujnik jeździ bezpośrednio po krawędzi.
// 2. Pozycje NIE są rozdzielone kołnierzami — w oryginale sąsiadują bezpośrednio
//    (brak odstępu). Wcześniejsza wersja błędnie dodawała 0.8 mm kołnierz
//    między każdą parą pozycji.
// 3. Między dużym kołnierzem (BOSS0) a częścią zębatą jest w oryginale
//    wieloschodkowy trzpień (nie prosty walec!): 14.97 -> 9.75 -> 13.97 -> 7.75,
//    a najwęższy odcinek (promień ~7.75 mm, dł. ~1.9 mm) to osobny, wyraźnie
//    węższy "czop" — prawdopodobnie właściwy element pasujący do gniazda
//    napędu maszyny.
// 4. W dużym kołnierzu (Z=0, strona z literą) jest OTWÓR NA WAŁEK NAPĘDOWY
//    maszyny Z WYPUSTEM (promień ~7.8 mm, wycięty od czoła) — wypust jest
//    niezbędny do przeniesienia ruchu obrotowego z wałka na bęben, to nie
//    kosmetyczny szczegół. To NIE otwór przelotowy przez całą krzywkę —
//    całość poza tym otworem jest lita.
// 5. Na kołnierzu BOSS0 jest gwint (kilka zwojów), a otwór ma wypust — oba
//    potwierdzone zdjęciami fizycznego bębna A, patrz docs/DIMENSIONS.md.
// Poprzednia wersja tego pliku zakładała prosty pełny otwór na wałek na całej
// długości — było to błędne uproszczenie.

LENGTH   = 26.0;   // długość całkowita walca
MAIN_R   = 16.97;  // promień części zębatej, Ø ~33.94
BOSS0_R  = 14.97;  // promień dużego kołnierza przy Z=0 (strona z literą), Ø ~29.94
BOSS1_R  = 10.30;  // promień kołnierza przy Z=LENGTH (strona daleka), Ø ~20.6

// --- Schodkowy trzpień montażowy między BOSS0 a częścią zębatą (zmierzone
// z oryginału, długości ok. 0.1-0.5 mm zaokrąglone/uproszczone tam, gdzie
// rozdzielczość pomiaru siatki nie pozwalała rozróżnić ostrego progu od
// krótkiego stożka) ---
BOSS0_LEN   = 3.2;
NECK_R1     = 9.75;   // promień pierwszego "przewężenia"
NECK_LEN1   = 2.1;    // Z = 3.7 .. 5.8
NECK_R2     = 13.97;  // promień pośredniego kołnierzyka
NECK_LEN2   = 1.0;    // Z = 6.3 .. 7.3
NECK_PIN_R  = 7.75;   // promień najwęższego czopu montażowego
NECK_PIN_LEN = 1.9;   // Z = 7.8 .. 9.7
TAPER_LEN   = 0.5;    // długość każdego skosu/progu między odcinkami trzpienia

NECK_START = BOSS0_LEN;                                    // 3.2
NECK_END   = BOSS0_LEN + TAPER_LEN + NECK_LEN1 + TAPER_LEN + NECK_LEN2 + TAPER_LEN + NECK_PIN_LEN;  // 9.7

// Otwór na wałek napędowy maszyny, wycięty od czoła Z=0 (nie przelotowy przez
// całą długość — patrz punkt 4 wyżej). SOCKET_KEY_* niżej to wypust
// przenoszący napęd z wałka na bęben.
SOCKET_R     = 7.8;
SOCKET_DEPTH = 2.5;
// Wpust pryzmatyczny (zabierak) — sprawdzono w pliku referencyjnym STL
// (V21ZZ3Z.stl, thing:6018240): otwór na wałek w tym pliku jest IDEALNIE
// okrągły na całym obwodzie (skan kąta co ~5° na Y=0-3mm, promień stały
// 7.80mm) — replika trzeciej strony NIE odwzorowuje wpustu. Jedynym źródłem
// wymiarów są więc zdjęcia fizycznego bębna: prostokątny wypust wystaje
// DO WEWNĄTRZ otworu (nie płaskie ścięcie) — bęben ma pełny, lity "żeberko"
// pasujące do rowka w wałku maszyny (odwrotnie niż klasyczny luźny wpust
// pryzmatyczny wg DIN 6885, gdzie klin siedzi w rowkach obu elementów).
// Szacunek proporcji z fotografii (brak twardej skali na zdjęciach): szerokość
// ok. 60% średnicy otworu, wysunięcie w głąb otworu ok. 25% promienia —
// DO WERYFIKACJI dopasowaniem do prawdziwego wałka maszyny.
SOCKET_KEY_WIDTH = 6.0;    // szerokość żeberka (na cięciwie otworu)
SOCKET_KEY_PROTRUSION = 3.0; // jak daleko żeberko wystaje w głąb otworu

// Gwint na kołnierzu BOSS0 — widoczny na zdjęciach fizycznego bębna A
// (kilka zwojów gwintu tuż przy grawerowanym czole), nieobecny we
// wcześniejszej wersji (modelowano gładki walec). Wysokość zwoju i skok
// dobrane wizualnie ze zdjęć (brak wzorca z pliku STL) — do weryfikacji
// wydrukiem próbnym i dopasowaniem do gniazda maszyny.
THREAD_PITCH   = 1.1;
THREAD_DEPTH   = 0.9;
THREAD_R_OUT   = BOSS0_R + THREAD_DEPTH;
THREAD_TURNS   = BOSS0_LEN / THREAD_PITCH;

N_POS     = 5;     // liczba pozycji wyboru ściegu (jak w zestawie A)
BOSS1_LEN = 1.75;
BAND_LEN  = (LENGTH - NECK_END - BOSS1_LEN) / N_POS;  // pozycje sąsiadują bez odstępu

function position_z(i) = NECK_END + i*BAND_LEN;

// Zakres promienia krawędzi ząbków = rzeczywisty, zmierzony zakres ruchu
// czujnika/popychacza na oryginale A. Pierwsza wersja ([7.71, 17.03] mm)
// pochodziła z pliku STL zestawu A (thing:6018240) — trzeciej strony repliki,
// niekoniecznie identycznej z fizycznym bębnem użytkownika. Po dostarczeniu
// zdjęć fizycznego bębna porównano głębokość wcięć zębów z pola widoku, w
// którym widoczny jest też kołnierz o znanej średnicy (Ø 29.94 mm, BOSS0_R)
// — jako skala odniesienia. Na tej podstawie doliny zębów sięgają wizualnie
// płycej niż zakładał plik STL — ok. 70% promienia szczytu, nie ~45%.
// EDGE_MAX_R pozostaje zgodny z Ø części zębatej (szczyty zębów, potwierdzone
// i na zdjęciach, i w STL). EDGE_MIN_R podniesiono, więc amplituda (EDGE_SWING)
// jest mniejsza — subtelniejszy, płytszy ścieg, bliższy temu, co widać na
// zdjęciach. To nadal szacunek wizualny (brak w zdjęciach twardej skali/
// suwmiarki) — do potwierdzenia wydrukiem próbnym i porównaniem z oryginałem.
EDGE_MAX_R = 17.03;
EDGE_MIN_R = 12.0;
EDGE_SWING = EDGE_MAX_R - EDGE_MIN_R;

// --- Podstawowe kształty fal, zwracają wartości znormalizowane -1..1 (chyba że zaznaczono inaczej) ---

function tri_wave(a, reps) =
    let(t = (a*reps/360) - floor(a*reps/360))
    4*abs(t - 0.5) - 1;

function sine_wave(a, reps) = sin(a*reps);

function saw_wave(a, reps, skew=0.5) =
    let(t = (a*reps/360) - floor(a*reps/360))
    (t < skew ? (2*(t/skew) - 1) : (1 - 2*(t - skew)/(1 - skew)));

function double_lobe(a, reps) =
    (sine_wave(a, reps) + 0.35*sine_wave(a, reps*2)) / 1.35;

function diamond_lattice(a, reps) =
    (tri_wave(a, reps) + tri_wave(a + 180/reps, reps)) / 2;

function feather(a, clusters) =
    let(macro = 360/clusters, t = (a - macro*floor(a/macro)) / macro)
    (t < 0.75 ? 0.5*tri_wave(a, clusters*9) : sine_wave(a, clusters));

function arrow_sharpen(a, reps, skew=0.5) =
    let(v = saw_wave(a, reps, skew))
    sign(v) * pow(abs(v), 0.6);

// impuls: 0 w tle, skok do 1 raz na cykl (do ściegu ślepego)
function pulse(a, reps, spike_w=0.15) =
    let(t = (a*reps/360) - floor(a*reps/360))
    (t < spike_w ? sin(180*t/spike_w) : 0);

// --- Geometria bryły ---

// profile_fn zwraca wartość znormalizowaną w przybliżeniu -1..1 (patrz funkcje
// fal wyżej); tu jest zamieniana na jednostronną głębokość 0..1 (0 = płytko/
// promień EDGE_MAX_R, 1 = głęboko/promień EDGE_MIN_R).
function edge_depth(v) = (v + 1) / 2;

function edge_radius(profile_fn, a) =
    EDGE_MAX_R - EDGE_SWING*edge_depth(profile_fn(a));

function edge_points(profile_fn, samples=96) = [
    for (i = [0:samples-1])
        let(a = i*360/samples, r = edge_radius(profile_fn, a))
        [r*cos(a), r*sin(a)]
];

module tooth_band(profile_fn, height, samples=96) {
    linear_extrude(height=height)
        polygon(edge_points(profile_fn, samples));
}

module mounting_neck() {
    // BOSS0_LEN..+TAPER: 14.97 -> NECK_R1
    translate([0, 0, BOSS0_LEN])
        cylinder(h=TAPER_LEN, r1=BOSS0_R, r2=NECK_R1, $fn=96);
    // stała szyjka NECK_R1
    translate([0, 0, BOSS0_LEN+TAPER_LEN])
        cylinder(h=NECK_LEN1, r=NECK_R1, $fn=96);
    // skos NECK_R1 -> NECK_R2
    translate([0, 0, BOSS0_LEN+TAPER_LEN+NECK_LEN1])
        cylinder(h=TAPER_LEN, r1=NECK_R1, r2=NECK_R2, $fn=96);
    // stały kołnierzyk NECK_R2
    translate([0, 0, BOSS0_LEN+2*TAPER_LEN+NECK_LEN1])
        cylinder(h=NECK_LEN2, r=NECK_R2, $fn=96);
    // skos NECK_R2 -> NECK_PIN_R
    translate([0, 0, BOSS0_LEN+2*TAPER_LEN+NECK_LEN1+NECK_LEN2])
        cylinder(h=TAPER_LEN, r1=NECK_R2, r2=NECK_PIN_R, $fn=96);
    // czop montażowy NECK_PIN_R
    translate([0, 0, BOSS0_LEN+3*TAPER_LEN+NECK_LEN1+NECK_LEN2])
        cylinder(h=NECK_PIN_LEN, r=NECK_PIN_R, $fn=96);
}

// Gwintowany kołnierz BOSS0 — walec bazowy + zwoje gwintu nawinięte helisą
// (unia małych brył wzdłuż ścieżki spiralnej, ta sama metoda co przy
// krawędziach ściegu, tylko addytywnie zamiast cięcia).
module boss0_threaded(samples_per_turn=32) {
    total_samples = floor(THREAD_TURNS * samples_per_turn);
    union() {
        cylinder(h=BOSS0_LEN, r=BOSS0_R, $fn=96);
        for (i = [0:total_samples-1]) {
            a0 = i*360/samples_per_turn;
            a1 = (i+1)*360/samples_per_turn;
            z0 = i*THREAD_PITCH/samples_per_turn;
            z1 = (i+1)*THREAD_PITCH/samples_per_turn;
            if (z1 <= BOSS0_LEN)
                hull() {
                    translate([THREAD_R_OUT*cos(a0), THREAD_R_OUT*sin(a0), z0])
                        sphere(d=1.6, $fn=8);
                    translate([THREAD_R_OUT*cos(a1), THREAD_R_OUT*sin(a1), z1])
                        sphere(d=1.6, $fn=8);
                }
        }
    }
}

// Grawerunek wzorowany na zdjęciach fizycznego bębna A: duża litera zestawu
// blisko gniazda od góry, "HUSQVARNA" łukiem u dołu, "SWEDEN" pod spodem.
module arc_text(str, radius, center_angle, angle_span, size, depth) {
    n = len(str);
    for (i = [0:n-1]) {
        frac = (n <= 1) ? 0.5 : i/(n-1);
        a = center_angle - angle_span/2 + frac*angle_span;
        translate([radius*cos(a), radius*sin(a), -0.01])
            rotate([0, 0, a - 90])
                linear_extrude(depth)
                    text(str[i], size=size, halign="center", valign="center",
                         font="Liberation Sans:style=Bold");
    }
}

module cam_label_cut(letter) {
    translate([0, 11, -0.01])
        linear_extrude(0.7)
            text(letter, size=6.5, halign="center", valign="center", font="Liberation Sans:style=Bold");
    arc_text("HUSQVARNA", 10.6, 250, 130, 2.0, 0.7);
    arc_text("SWEDEN", 8.8, 250, 90, 1.6, 0.7);
}

// Otwór na wałek z wypustem pryzmatycznym (zabierakiem): PEŁNE żeberko
// wystające do wnętrza otworu, nie ścięcie/rowek. Zaimplementowane jako
// walec-otwór, z którego wycinamy prostokąt tam, gdzie ma zostać żeberko —
// czyli w tym miejscu materiał NIE jest usuwany z bryły (patrz zdjęcia
// 08/09 w references/husqvarna_photos_A/, docs/DIMENSIONS.md).
module socket_cut() {
    difference() {
        cylinder(h=SOCKET_DEPTH, r=SOCKET_R, $fn=64);
        translate([SOCKET_R - SOCKET_KEY_PROTRUSION, -SOCKET_KEY_WIDTH/2, -1])
            cube([SOCKET_KEY_PROTRUSION + 1, SOCKET_KEY_WIDTH, SOCKET_DEPTH + 2]);
    }
}

module cam_solid(profile_fns) {
    difference() {
        union() {
            boss0_threaded();
            mounting_neck();
            for (i = [0:N_POS-1])
                translate([0, 0, position_z(i)])
                    tooth_band(profile_fns[i], BAND_LEN);
            translate([0, 0, LENGTH-BOSS1_LEN])
                cylinder(h=BOSS1_LEN, r=BOSS1_R, $fn=96);
        }
        socket_cut();
    }
}

module cam_with_grooves(letter, profile_fns) {
    difference() {
        cam_solid(profile_fns);
        cam_label_cut(letter);
    }
}

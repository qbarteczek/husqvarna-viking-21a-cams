// Wspólna biblioteka dla krzywek bębnowych Husqvarna Viking 21A (B, C, D).
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
// 4. W dużym kołnierzu (Z=0, strona z literą) jest ślepe gniazdo montażowe
//    (promień ~7.8 mm) wycięte od czoła, NIE otwór przelotowy przez całą
//    krzywkę — całość poza tym gniazdem jest lita (bez centralnego wałka).
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

// Ślepe gniazdo montażowe wycięte od czoła Z=0 (nie otwór przelotowy!)
SOCKET_R     = 7.8;
SOCKET_DEPTH = 2.5;

N_POS     = 5;     // liczba pozycji wyboru ściegu (jak w zestawie A)
BOSS1_LEN = 1.75;
BAND_LEN  = (LENGTH - NECK_END - BOSS1_LEN) / N_POS;  // pozycje sąsiadują bez odstępu

function position_z(i) = NECK_END + i*BAND_LEN;

// Zakres promienia krawędzi ząbków = rzeczywisty, zmierzony zakres ruchu
// czujnika/popychacza na oryginale A (skan promienia całej części zębatej,
// Y=9.7..24.25): promień tam NIGDY nie wychodzi poza [7.71, 17.03] mm.
// To są twarde granice mechanizmu maszyny — czujnik fizycznie nie sięga dalej
// ani nie wchodzi głębiej — więc żaden wzór B/C/D nie może ich przekroczyć.
// (Wcześniejsza wersja używała dolnego limitu 6.5 mm — poza zmierzonym
// zakresem — dobranego tylko z względów wytrzymałościowych wydruku, bez
// odniesienia do realnego zasięgu czujnika. Błąd naprawiony.)
EDGE_MAX_R = 17.03;
EDGE_MIN_R = 7.71;
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

module cam_label_cut(letter) {
    translate([BOSS0_R - 4.5, -3, -0.01])
        linear_extrude(0.7)
            text(letter, size=6, halign="center", valign="center", font="Liberation Sans:style=Bold");
}

module cam_solid(profile_fns) {
    difference() {
        union() {
            cylinder(h=BOSS0_LEN, r=BOSS0_R, $fn=96);
            mounting_neck();
            for (i = [0:N_POS-1])
                translate([0, 0, position_z(i)])
                    tooth_band(profile_fns[i], BAND_LEN);
            translate([0, 0, LENGTH-BOSS1_LEN])
                cylinder(h=BOSS1_LEN, r=BOSS1_R, $fn=96);
        }
        translate([0, 0, -1])
            cylinder(h=SOCKET_DEPTH+1, r=SOCKET_R, $fn=64);
    }
}

module cam_with_grooves(letter, profile_fns) {
    difference() {
        cam_solid(profile_fns);
        cam_label_cut(letter);
    }
}

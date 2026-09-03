// Wspólna biblioteka dla krzywek bębnowych Husqvarna Viking 21A (B, C, D).
// Wymaga OpenSCAD 2021.01+ (function literals).
// Wymiary skalibrowane na podstawie analizy pliku V21ZZ3Z.stl z zestawu A
// (thing:6018240) — patrz ../../docs/DIMENSIONS.md. Oś obrotu w tym pliku to Z
// (w oryginalnym STL była to oś Y — sama nazwa osi nie wpływa na pasowanie).
//
// MECHANIZM (poprawiony po weryfikacji z realnym wyglądem zestawu A): to NIE
// jest wąski rowek schowany wewnątrz pełnego walca. Sama KRAWĘDŹ walca na
// każdej z 5 pozycji jest ukształtowana jako profil ściegu (jak ząbki na
// zestawie A) — czujnik/popychacz maszyny jeździ bezpośrednio po tej krawędzi,
// a jego wychylenie w bok napędza igłę. Pozycje są oddzielone wąskimi
// kołnierzami o pełnej średnicy (MAIN_R), tak jak w oryginale.

LENGTH   = 26.0;   // długość całkowita walca
MAIN_R   = 16.97;  // promień głównego walca / kołnierzy separujących, Ø ~33.94
BOSS0_R  = 14.97;  // promień kołnierza przy Z=0 (strona "wejściowa"), Ø ~29.94
BOSS1_R  = 10.30;  // promień kołnierza przy Z=LENGTH (strona "daleka"), Ø ~20.6
BOSS_LEN = 2.0;    // długość każdego kołnierza — wartość przybliżona, do weryfikacji wydrukiem próbnym
BORE_R   = 7.75;   // promień otworu centralnego (wałek napędowy), Ø ~15.5

MAIN_LEN = LENGTH - 2*BOSS_LEN;

N_POS       = 5;     // liczba pozycji wyboru ściegu (jak w zestawie A)
COLLAR_LEN  = 0.8;   // wysokość wąskiego kołnierza separującego pozycje
BAND_LEN    = (MAIN_LEN - (N_POS-1)*COLLAR_LEN) / N_POS;  // wysokość jednej "ząbkowanej" pozycji

// Zakres promienia krawędzi ząbków: EDGE_MAX_R = MAIN_R (płynne połączenie
// z kołnierzami przy najpłytszym punkcie profilu), EDGE_MIN_R zostawia min.
// ~3 mm ścianki do otworu centralnego (BORE_R) w najgłębszym punkcie — patrz
// docs/PRINTABILITY.md.
EDGE_MAX_R = MAIN_R;
EDGE_MIN_R = BORE_R + 3.0;
EDGE_SWING = EDGE_MAX_R - EDGE_MIN_R;

function position_z(i) = BOSS_LEN + i*(BAND_LEN + COLLAR_LEN);

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

module cam_solid(profile_fns) {
    union() {
        cylinder(h=BOSS_LEN, r=BOSS0_R, $fn=96);
        for (i = [0:N_POS-1]) {
            translate([0, 0, position_z(i)])
                tooth_band(profile_fns[i], BAND_LEN);
            if (i < N_POS-1)
                translate([0, 0, position_z(i) + BAND_LEN])
                    cylinder(h=COLLAR_LEN, r=MAIN_R, $fn=96);
        }
        translate([0, 0, LENGTH-BOSS_LEN])
            cylinder(h=BOSS_LEN, r=BOSS1_R, $fn=96);
    }
}

module cam_label_cut(letter) {
    translate([BOSS0_R - 4.5, -3, -0.01])
        linear_extrude(0.7)
            text(letter, size=6, halign="center", valign="center", font="Liberation Sans:style=Bold");
}

module cam_with_grooves(letter, profile_fns) {
    difference() {
        cam_solid(profile_fns);
        translate([0, 0, -1])
            cylinder(h=LENGTH+2, r=BORE_R, $fn=64);
        cam_label_cut(letter);
    }
}

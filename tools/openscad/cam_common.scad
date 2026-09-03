// Wspólna biblioteka dla krzywek bębnowych Husqvarna Viking 21A (B, C, D).
// Wymaga OpenSCAD 2021.01+ (function literals).
// Wymiary skalibrowane na podstawie analizy pliku V21ZZ3Z.stl z zestawu A
// (thing:6018240) — patrz ../../docs/DIMENSIONS.md. Oś obrotu w tym pliku to Z
// (w oryginalnym STL była to oś Y — sama nazwa osi nie wpływa na pasowanie).

LENGTH   = 26.0;   // długość całkowita walca
MAIN_R   = 16.97;  // promień głównego walca (grzbiet rowków), Ø ~33.94
BOSS0_R  = 14.97;  // promień kołnierza przy Z=0 (strona "wejściowa"), Ø ~29.94
BOSS1_R  = 10.30;  // promień kołnierza przy Z=LENGTH (strona "daleka"), Ø ~20.6
BOSS_LEN = 2.0;    // długość każdego kołnierza — wartość przybliżona, do weryfikacji wydrukiem próbnym
BORE_R   = 7.75;   // promień otworu centralnego (wałek napędowy), Ø ~15.5

MAIN_LEN       = LENGTH - 2*BOSS_LEN;
GROOVE_WIDTH   = 2.2;   // szerokość rowka (średnica narzędzia/trzpienia)
// Rowek MUSI być otwarty na zewnątrz (trzpień śledzący wchodzi w niego z zewnątrz
// walca) — to nie jest kanał ukryty w środku ścianki. Dlatego promień toru liczymy
// jako głębokość cięcia OD powierzchni głównego walca (MAIN_R), a nie jako
// wychylenie wokół promienia środkowego. GROOVE_BASE_R leży celowo bliżej
// powierzchni niż MAIN_R o mniej niż połowę szerokości narzędzia, więc nawet
// najpłytszy punkt toru faktycznie przebija powierzchnię (widoczny, dostępny
// rowek), a GROOVE_DEEP_R zostawia min. ~1.5 mm ścianki do otworu (BORE_R).
// Patrz docs/PRINTABILITY.md.
GROOVE_BASE_R = MAIN_R - 0.5;
GROOVE_DEEP_R = BORE_R + 1.5 + GROOVE_WIDTH/2;
GROOVE_SWING  = GROOVE_BASE_R - GROOVE_DEEP_R;

function position_z(i) = BOSS_LEN + (MAIN_LEN/5) * (i + 0.5);

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

// --- Geometria bryły i cięcia rowków ---

module cam_barrel_blank() {
    difference() {
        union() {
            cylinder(h=BOSS_LEN, r=BOSS0_R, $fn=96);
            translate([0,0,BOSS_LEN])
                cylinder(h=MAIN_LEN, r=MAIN_R, $fn=96);
            translate([0,0,LENGTH-BOSS_LEN])
                cylinder(h=BOSS_LEN, r=BOSS1_R, $fn=96);
        }
        translate([0,0,-1])
            cylinder(h=LENGTH+2, r=BORE_R, $fn=64);
    }
}

// profile_fn zwraca wartość znormalizowaną w przybliżeniu -1..1 (patrz funkcje
// fal wyżej); tu jest zamieniana na jednostronną głębokość 0..1 (0 = płytko/
// blisko powierzchni, 1 = głęboko/blisko otworu), więc rowek zawsze pozostaje
// fizycznie otwarty na zewnątrz, niezależnie od użytej amplitudy wzoru.
function groove_depth(v) = (v + 1) / 2;

module groove_ring(z_center, profile_fn, width=GROOVE_WIDTH, samples=96) {
    union() {
        for (i = [0:samples-1]) {
            a0 = i*360/samples;
            a1 = (i+1)*360/samples;
            r0 = GROOVE_BASE_R - GROOVE_SWING*groove_depth(profile_fn(a0));
            r1 = GROOVE_BASE_R - GROOVE_SWING*groove_depth(profile_fn(a1));
            hull() {
                translate([r0*cos(a0), r0*sin(a0), z_center]) sphere(d=width, $fn=10);
                translate([r1*cos(a1), r1*sin(a1), z_center]) sphere(d=width, $fn=10);
            }
        }
    }
}

module cam_label_cut(letter) {
    translate([BOSS0_R - 4.5, -3, -0.01])
        linear_extrude(0.7)
            text(letter, size=6, halign="center", valign="center", font="Liberation Sans:style=Bold");
}

module cam_with_grooves(letter, profile_fns) {
    difference() {
        cam_barrel_blank();
        for (i = [0:4])
            groove_ring(position_z(i), profile_fns[i]);
        cam_label_cut(letter);
    }
}

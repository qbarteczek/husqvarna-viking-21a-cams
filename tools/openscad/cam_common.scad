// Wspólna biblioteka dla bębnów ściegowych Husqvarna 21E (rodzina 19/20/21A/21E).
// Wymiary skalibrowane na podstawie 46 zdjęć w wysokiej rozdzielczości fizycznego
// bębna A oraz korekt naniesionych bezpośrednio na render.
// Wymaga OpenSCAD 2021.01+ (function literals).

LENGTH = 26.0;   // całkowita długość walca wzdłuż osi Z [mm]

// --- Amplituda krzywek i średnice walców ---
// EDGE_MAX_R = 17.03 mm (Ø 34.06 mm) - maksymalny promień szczytów ząbków krzywki
// EDGE_MIN_R - promień dna doliny ząbków. Poprawka użytkownika: poprzednia wartość
// (12.00 mm, wychylenie 5.03 mm, ok. 29.5% promienia) nadal dawała zbyt głębokie,
// ostro zakończone zęby względem tego, co widać na zdjęciach fizycznego bębna A
// (subtelna, "szachownicowa" faktura, nie ostre kolce). Ustawione na 14.20 mm
// (wychylenie 2.83 mm) — na zdjęciach dno ząbków leży tuż poniżej krawędzi dysku
// czołowego (DISC_R=14.5 mm), używanego tu jako bezpośrednia skala odniesienia w tym
// samym kadrze, więc promień dna dolin powinien być tylko odrobinę mniejszy niż
// DISC_R, nie znacząco mniejszy. To nadal szacunek proporcji ze zdjęć (brak twardej
// skali) - do potwierdzenia wydrukiem próbnym i porównaniem z oryginałem.
EDGE_MAX_R = 17.03;
EDGE_MIN_R = 14.20;
EDGE_SWING = EDGE_MAX_R - EDGE_MIN_R; // 2.83 mm

// 1. Dysk czołowy z 3 rowkami (Z = 0 .. DISC_LEN)
// Na czole Z=0 znajduje się grawerunek litery oraz napisów HUSQVARNA SWEDEN.
// Średnica dysku jest wyraźnie mniejsza niż maksymalna amplituda krzywek: Ø 29.0 mm.
// Krawędź czoła ma małe ścięcie (CHAMFER_LEN) — widoczne na zdjęciach fizycznego
// bębna (IMG_20260909_074232, _081059) na samej górze elementu.
DISC_R          = 14.5;
DISC_LEN        = 2.4;
DISC_GROOVES    = 3;
DISC_GROOVE_W   = 0.35;
DISC_GROOVE_D   = 0.4;
CHAMFER_LEN     = 0.6;

// 2. Szyjka / przewężenie między dyskiem a kołnierzem głównym (Z = 2.4 .. 4.4)
// Poprawka (przegląd Claude, zdjęcia IMG_20260909_074150/_081033/_081157/_081205):
// przejście do kołnierza głównego jest teraz STOŻKOWE (nie ostry, pionowy skok
// promienia 11.5 -> 17.03 mm), żeby uniknąć ok. 5.5 mm nawisu przy druku z osią
// pionową. NECK_TAPER_LEN to część długości szyjki przeznaczona na stożek.
NECK_R          = 11.5;   // Ø 23.0 mm
NECK_LEN        = 2.0;
NECK_TAPER_LEN  = 1.2;    // ostatnia część szyjki, stożek NECK_R -> FLANGE_R

// 3. Kołnierz główny (Z = 4.4 .. 6.4)
// Definiuje maksymalną średnicę zewnętrzną, równą szczytom krzywek (Ø 34.06 mm)
FLANGE_R        = EDGE_MAX_R; // 17.03 mm
FLANGE_LEN      = 2.0;

// 4. Ścieżki krzywek (Z = 6.4 .. 23.6)
// Zaczynają się BEZPOŚREDNIO przy kołnierzu głównym — brak zbędnej szyjki.
CAM_START_Z     = DISC_LEN + NECK_LEN + FLANGE_LEN; // 6.4 mm
N_POS           = 5;
COLLAR_LEN      = 2.4;
CAM_TOTAL_LEN   = LENGTH - CAM_START_Z - COLLAR_LEN; // 17.2 mm
BAND_LEN        = CAM_TOTAL_LEN / N_POS;             // 3.44 mm na pozycję

function position_z(i) = CAM_START_Z + i * BAND_LEN;

// 5. Kołnierz tylny (Z = 23.6 .. 26.0)
// Ponowny przegląd zdjęć (po porównaniu z niezależną analizą drugiego agenta) —
// zdjęcie 08_far_end_gear_collar_keyway.jpg pokazuje wyraźny, stopniowany
// kołnierzyk dookoła otworu na dalekim końcu, osobny od pierścienia zębatego —
// poprzednia wersja (przegląd Claude, oparta głównie na dwóch zdjęciach bocznych)
// błędnie to pominęła jako "płaski koniec". Walec bazowy zakończony fazą stożkową
// ułatwiającą osadzenie bębna na osi maszyny.
COLLAR_R            = 11.5;   // Ø 23.0 mm
COLLAR_TOP_R        = 10.3;   // Ø 20.6 mm
COLLAR_CHAMFER_LEN  = 1.4;

// 6. Otwór centralny przelotowy i wpust (rowek)
// Otwór centralny jest przelotowy na wylot (Z = 0 .. 26 mm).
// Wpust (rowek pod klin) NIE przechodzi przez całą długość bębna — ponowna analiza
// zdjęć (04_engraving_angle.jpg, 05_engraving_closeup.jpg: bore od strony czoła jest
// czysty, bez wycięcia; IMG_20260909_081514.jpg, 08/09_far_end_*: wycięcie wyraźnie
// widoczne od dalekiego końca) pokazuje, że wpust zaczyna się dopiero na wysokości
// kołnierza głównego / początku krzywek (Z = KEY_START_Z = 6.4 mm) i biegnie do
// końca (Z = 26.0). Czoło, szyjka i kołnierz główny (Z = 0 .. 6.4 mm) pozostają
// pełną, nienaruszoną tuleją — także z powodów wytrzymałościowych: przy R=11.5 mm
// w szyjce, wpust sięgający głębiej zostawiłby tam zbyt cienką ściankę.
SOCKET_R            = 7.8;    // Ø 15.6 mm (przelotowy na wylot)
SOCKET_KEY_WIDTH    = 4.5;    // szerokość rowka wpustowego
SOCKET_KEY_DEPTH    = 2.2;    // głębokość wcięcia w ściankę (promień zewn. wpustu = 10.0 mm)
KEY_START_Z         = 6.4;    // początek wpustu w osi Z [mm] (czoło+szyjka+kołnierz Z=0..6.4 pozostają pełne)

// --- Podstawowe kształty fal, zwracają wartości znormalizowane -1..1 ---

function tri_wave(a, reps) =
    let(t = (a*reps/360) - floor(a*reps/360))
    4*abs(t - 0.5) - 1;

function sine_wave(a, reps) = sin(a*reps);

function saw_wave(a, reps, skew=0.5) =
    let(t = (a*reps/360) - floor(a*reps/360))
    (t < skew ? (2*(t/skew) - 1) : (1 - 2*(t - skew)/(1 - skew)));

// Fala trapezowa z płaskimi szczytami i płaskimi dolinami — idealnie odwzorowuje
// rzeczywiste zęby bębna A (stabilne punkty zwrotne igły maszyny).
function trap_wave(a, reps, dwell=0.28) =
    let(t = (a*reps/360) - floor(a*reps/360),
        ramp = (1.0 - 2.0*dwell) / 2.0)
    (t < dwell ? 1.0 :
     (t < dwell + ramp ? 1.0 - 2.0*(t - dwell)/ramp :
      (t < 2.0*dwell + ramp ? -1.0 :
       -1.0 + 2.0*(t - 2.0*dwell - ramp)/ramp)));

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

// Bryła dysku czołowego ze ściętą krawędzią na czole (Z=0), bez rowków —
// pomocnicze dla disc_grooved() poniżej, żeby rowki były wycinane z pełnego
// kształtu (razem ze ścięciem), a nie dolepiane osobno (co inaczej cofałoby
// rowek w miejscu, gdzie nachodzi na ścięcie).
module disc_blank() {
    union() {
        cylinder(h=CHAMFER_LEN, r1=DISC_R-CHAMFER_LEN, r2=DISC_R, $fn=96);
        translate([0, 0, CHAMFER_LEN])
            cylinder(h=DISC_LEN-CHAMFER_LEN, r=DISC_R, $fn=96);
    }
}

// 1. Dysk czołowy z 3 rowkami obwodowymi i ze ściętą krawędzią na czole (Z=0)
module disc_grooved() {
    difference() {
        disc_blank();
        for (i = [0:DISC_GROOVES-1]) {
            gz = DISC_LEN * (i + 0.5) / DISC_GROOVES;
            translate([0, 0, gz - DISC_GROOVE_W/2])
                difference() {
                    cylinder(h=DISC_GROOVE_W, r=DISC_R + 0.1, $fn=96);
                    cylinder(h=DISC_GROOVE_W, r=DISC_R - DISC_GROOVE_D, $fn=96);
                }
        }
    }
}

// 2. Szyjka między dyskiem a kołnierzem — stała część + stożkowe przejście
// do FLANGE_R na końcu (patrz NECK_TAPER_LEN wyżej; unika nawisu przy druku).
module neck_section() {
    translate([0, 0, DISC_LEN])
        cylinder(h=NECK_LEN-NECK_TAPER_LEN, r=NECK_R, $fn=96);
    translate([0, 0, DISC_LEN + NECK_LEN - NECK_TAPER_LEN])
        cylinder(h=NECK_TAPER_LEN, r1=NECK_R, r2=FLANGE_R, $fn=96);
}

// 3. Główny kołnierz o maksymalnej średnicy
module main_flange() {
    translate([0, 0, DISC_LEN + NECK_LEN])
        cylinder(h=FLANGE_LEN, r=FLANGE_R, $fn=96);
}

// 5. Kołnierz tylny ze stożkową fazą montażową (patrz uwaga przy COLLAR_* wyżej)
module end_collar() {
    collar_cyl_h = COLLAR_LEN - COLLAR_CHAMFER_LEN;
    translate([0, 0, LENGTH - COLLAR_LEN]) {
        cylinder(h=collar_cyl_h, r=COLLAR_R, $fn=96);
        translate([0, 0, collar_cyl_h])
            cylinder(h=COLLAR_CHAMFER_LEN, r1=COLLAR_R, r2=COLLAR_TOP_R, $fn=96);
    }
}

// Grawerunek na czole Z=0 wzorowany na zdjęciach fizycznego bębna A
module arc_text(str, radius, center_angle, angle_span, size, depth) {
    n = len(str);
    for (i = [0:n-1]) {
        frac = (n <= 1) ? 0.5 : i / (n - 1);
        // Od lewej do prawej wzdłuż dolnego łuku
        a = center_angle - angle_span/2 + frac * angle_span;
        translate([radius*cos(a), radius*sin(a), -0.01])
            rotate([0, 0, a - 180])
                linear_extrude(depth)
                    text(str[i], size=size, halign="center", valign="center",
                         font="Liberation Sans:style=Bold");
    }
}

module cam_label_cut(letter) {
    mirror([1, 0, 0]) {
        // Litera u góry (Y > 0)
        translate([0, 11.2, -0.01])
            linear_extrude(0.5)
                text(letter, size=4.0, halign="center", valign="center", font="Liberation Sans:style=Bold");
        // Napisy na łuku u dołu (Y < 0) czytane naturalnie od lewej do prawej
        arc_text("HUSQVARNA", 12.2, 270, 95, 1.6, 0.5);
        arc_text("SWEDEN", 10.1, 270, 65, 1.3, 0.5);

        // Dwa radialne znaczniki pozycjonujące widoczne na oryginale
        translate([8.5, -0.3, -0.01])
            cube([5.0, 0.6, 0.5]);
        translate([-13.5, -0.3, -0.01])
            cube([5.0, 0.6, 0.5]);
    }
}

// Otwór przelotowy z wpustem, który sięga od KEY_START_Z do końca (patrz uwaga
// przy KEY_START_Z wyżej) — czoło/szyjka/kołnierz główny pozostają pełną tuleją.
module socket_cut() {
    union() {
        // Otwór centralny przelotowy na wylot
        translate([0, 0, -1])
            cylinder(h=LENGTH + 2, r=SOCKET_R, $fn=64);
        // Wpust (rowek pod klin) wycięty tylko od KEY_START_Z do końca tylnego Z=LENGTH
        translate([SOCKET_R - 0.5, -SOCKET_KEY_WIDTH/2, KEY_START_Z])
            cube([SOCKET_KEY_DEPTH + 0.5, SOCKET_KEY_WIDTH, LENGTH - KEY_START_Z + 1]);
    }
}

module cam_solid(profile_fns) {
    difference() {
        union() {
            disc_grooved();
            neck_section();
            main_flange();
            for (i = [0:N_POS-1])
                translate([0, 0, position_z(i)])
                    tooth_band(profile_fns[i], BAND_LEN);
            end_collar();
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

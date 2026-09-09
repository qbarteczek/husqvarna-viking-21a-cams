// Wspólna biblioteka dla bębnów ściegowych Husqvarna 21E (rodzina 19/20/21A/21E).
// Wymiary skalibrowane na podstawie 46 zdjęć w wysokiej rozdzielczości fizycznego
// bębna A oraz korekt naniesionych bezpośrednio na render.
// Wymaga OpenSCAD 2021.01+ (function literals).

LENGTH = 26.0;   // całkowita długość walca wzdłuż osi Z [mm]

// --- Amplituda krzywek i średnice walców ---
// EDGE_MAX_R = 17.03 mm (Ø 34.06 mm) - maksymalny promień szczytów ząbków krzywki
// EDGE_MIN_R = 14.20 mm (Ø 28.40 mm) - promień dna doliny ząbków (amplituda ząbka 2.83 mm, zgodna ze zdjęciami)
EDGE_MAX_R = 17.03;
EDGE_MIN_R = 14.20;
EDGE_SWING = EDGE_MAX_R - EDGE_MIN_R; // 2.83 mm

// 1. Dysk czołowy z 3 rowkami (Z = 0 .. DISC_LEN)
// Na czole Z=0 znajduje się grawerunek litery oraz napisów HUSQVARNA SWEDEN.
// Średnica dysku jest wyraźnie mniejsza niż maksymalna amplituda krzywek: Ø 29.0 mm.
DISC_R          = 14.5;
DISC_LEN        = 2.4;
DISC_GROOVES    = 3;
DISC_GROOVE_W   = 0.35;
DISC_GROOVE_D   = 0.4;

// 2. Szyjka / przewężenie między dyskiem a kołnierzem głównym (Z = 2.4 .. 4.4)
NECK_R          = 11.5;   // Ø 23.0 mm
NECK_LEN        = 2.0;

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
// Walec z szeroką fazą stożkową na szczycie (Z = 24.6 .. 26.0) ułatwiającą montaż
COLLAR_R            = 11.5;   // Ø 23.0 mm
COLLAR_TOP_R        = 10.3;   // Ø 20.6 mm
COLLAR_CHAMFER_LEN  = 1.4;

// 6. Otwór centralny przelotowy i wpust (rowek)
// Otwór centralny jest przelotowy na wylot (Z = 0 .. 26 mm).
// Wpust (rowek pod klin) NIE przechodzi przez całą długość bębna — wprowadzany jest
// od strony tylnego kołnierza montażowego (Z = 26.0 mm) i kończy się przed czołem
// (na wysokości Z = KEY_START_Z = 6.4 mm), dzięki czemu przód bębna (Z = 0 .. 6.4 mm)
// zachowuje idealnie gładki, nienaruszony otwór cylindryczny (zgodnie ze zdjęciami oryginału).
SOCKET_R            = 7.8;    // Ø 15.6 mm (przelotowy na wylot)
SOCKET_KEY_WIDTH    = 4.5;    // szerokość rowka wpustowego
SOCKET_KEY_DEPTH    = 2.2;    // głębokość wcięcia w ściankę (promień zewn. wpustu = 10.0 mm)
// Początek wpustu w osi Z [mm] — na podstawie zdjęć 04, 05, 08 i IMG_20260909_081514
// wpust zaczyna się na wysokości kołnierza głównego / początku krzywek (Z = 6.4 mm),
// co pozostawia całe czoło, szyjkę i kołnierz (Z = 0 .. 6.4 mm) jako pełną, wytrzymałą tuleję.
KEY_START_Z         = 6.4;    // Z = CAM_START_Z (wpust biegnie od Z = 6.4 do Z = 26.0 mm)

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

// Impuls do ściegu krytego / brzegowego (blind hem): tło po lewej (-1), wąskie wychylenie w prawo (+1)
function blind_hem(a, reps=3, spike_w=0.20) =
    let(t = (a*reps/360) - floor(a*reps/360))
    (t < spike_w ? (sin(180*t/spike_w) * 2 - 1) : -1);

// Alias dla kompatybilności z wcześniejszymi projektami
function pulse(a, reps=3, spike_w=0.20) = blind_hem(a, reps, spike_w);

// Zygzak 3-stopniowy elastyczny (trestings siksak): 3 stopnie w prawo, 3 stopnie w lewo
function three_step_zigzag(a, reps=3) =
    let(t = (a*reps/360) - floor(a*reps/360),
        step = floor(t * 6))
    (step == 0 ? -0.9 :
     (step == 1 ? -0.3 :
      (step == 2 ? 0.3 :
       (step == 3 ? 0.9 :
        (step == 4 ? 0.3 : -0.3)))));

// Ścieg satynowy w kształcie rombu / perełek (diamantsöm dla bębna B1 poz. 3)
function diamond_satin(a, satin_reps=18, cycle_reps=3) =
    let(env = (1 - cos(a*cycle_reps))/2)
    trap_wave(a, satin_reps, 0.22) * (env * 0.75 + 0.2);

// Bloki satynowe schodkowe (blokksöm dla bębna C1 poz. 3)
function block_satin(a, satin_reps=16, block_reps=4) =
    let(side = sign(sin(a*block_reps)))
    (trap_wave(a, satin_reps, 0.22) * 0.45 + side * 0.45);

// Klepsydra / podwójny romb (dla bębna C1 poz. 4)
function hourglass_satin(a, satin_reps=18, cycle_reps=3) =
    let(env = abs(cos(a*cycle_reps)))
    trap_wave(a, satin_reps, 0.22) * (env * 0.75 + 0.2);


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

// 1. Dysk czołowy z 3 rowkami obwodowymi
module disc_grooved() {
    difference() {
        cylinder(h=DISC_LEN, r=DISC_R, $fn=96);
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

// 2. Szyjka między dyskiem a kołnierzem
module neck_section() {
    translate([0, 0, DISC_LEN])
        cylinder(h=NECK_LEN, r=NECK_R, $fn=96);
}

// 3. Główny kołnierz o maksymalnej średnicy
module main_flange() {
    translate([0, 0, DISC_LEN + NECK_LEN])
        cylinder(h=FLANGE_LEN, r=FLANGE_R, $fn=96);
}

// 5. Kołnierz tylny ze stożkową fazą montażową
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
        // Od lewej do prawej po łuku (naturalny kierunek czytania)
        a = center_angle + angle_span/2 - frac * angle_span;
        translate([radius*cos(a), radius*sin(a), -0.01])
            rotate([0, 0, a - 90])
                linear_extrude(depth)
                    text(str[i], size=size, halign="center", valign="center",
                         font="Liberation Sans:style=Bold");
    }
}

module cam_label_cut(letter) {
    mirror([1, 0, 0]) {
        // Napisy HUSQVARNA SWEDEN na łuku u góry (Y > 0)
        arc_text("HUSQVARNA", 12.2, 90, 95, 1.6, 0.5);
        arc_text("SWEDEN", 10.1, 90, 65, 1.3, 0.5);

        // Oznaczenie litery bębna na dole (Y < 0)
        translate([0, -11.2, -0.01])
            linear_extrude(0.5)
                text(letter, size=3.8, halign="center", valign="center", font="Liberation Sans:style=Bold");

        // Dwa radialne znaczniki pozycjonujące widoczne na oryginale
        translate([8.5, -0.3, -0.01])
            cube([5.0, 0.6, 0.5]);
        translate([-13.5, -0.3, -0.01])
            cube([5.0, 0.6, 0.5]);
    }
}

// Otwór przelotowy z wpustem nieprzelotowym (ślepym od czoła)
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

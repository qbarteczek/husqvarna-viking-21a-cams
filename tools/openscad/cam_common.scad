// Wspólna biblioteka dla bębnów ściegowych Husqvarna 21E (rodzina 19/20/21A/21E) — generator,
// nie zamknięty zestaw. Nowy bęben: skopiuj cam_template.scad, patrz docs/CREATING_NEW_DRUMS.md.
// Wymaga OpenSCAD 2021.01+ (function literals).
// Wymiary skalibrowane na podstawie analizy pliku V21ZZ3Z.stl z zestawu A
// (thing:6018240) — patrz ../../docs/DIMENSIONS.md. Oś obrotu w tym pliku to Z
// (w oryginalnym STL była to oś Y — sama nazwa osi nie wpływa na pasowanie).
//
// MECHANIZM (trzeci raz poprawiony — tym razem na podstawie zdjęć fizycznego
// bębna A z opisami użytkownika, narysowanymi bezpośrednio na renderze):
// 1. Krawędź walca na każdej z 5 pozycji JEST profilem ściegu (ząbki jak w A),
//    nie schowanym rowkiem — czujnik jeździ bezpośrednio po krawędzi.
// 2. Pozycje NIE są rozdzielone kołnierzami — w oryginale sąsiadują bezpośrednio
//    (brak odstępu).
// 3. Kołnierz BOSS0 (strona z grawerunkiem) ma średnicę RÓWNĄ maksymalnej
//    amplitudzie krzywek (EDGE_MAX_R) — na zdjęciu użytkownika oznaczone
//    niebieską strzałką jako element "szerszy", który "określa maksymalną
//    średnicę/amplitudę krzywek". Wcześniej BOSS0_R (14.97) i EDGE_MAX_R
//    (17.03) były różnymi, niezależnie zmierzonymi wartościami — błąd,
//    teraz BOSS0_R = EDGE_MAX_R wprost.
// 4. Tuż za kołnierzem jest pierścień z płytkimi, POZIOMYMI rowkami (nie
//    helisą!) — na zdjęciu oznaczone żółtą strzałką: "to nie jest gwint, i
//    jest znacznie mniejsze niż maksymalna amplituda krzywek". Wcześniejsza
//    wersja modelowała to jako gwint śrubowy (boss0_threaded, helisa) — błąd
//    interpretacji zdjęć, poprawione na ring_grooved() poniżej.
// 5. Między tym pierścieniem a częścią zębatą jest pojedynczy, gładki stożek
//    wprost do promienia doliny krzywek (EDGE_MIN_R) — bez węższych stopni.
//    Wcześniejsza wersja (wieloschodkowy trzpień schodzący do ~7.75 mm,
//    wyraźnie węższego niż dolina krzywek) tworzyła w renderze niezamierzoną
//    szczelinę/wnękę — na zdjęciu oznaczone czerwoną strzałką: "to nie
//    powinno istnieć, poszerz krzywki aby wypełnić tę przestrzeń". Usunięto
//    wąskie stopnie, materiał wypełnia teraz całą tę przestrzeń.
// 6. Czoło kołnierza BOSS0 (Z=0, strona z literą) ma ścięcie (fazę) na
//    krawędzi — widoczne na zdjęciach na samej górze elementu.
// 7. W kołnierzu BOSS0 jest OTWÓR NA WAŁEK NAPĘDOWY maszyny, wycięty od
//    czoła (nie przelotowy przez całą krzywkę — całość poza tym otworem
//    jest lita). WAŁEK maszyny ma wypust (klin wystający na zewnątrz), a
//    BĘBEN (ten model) ma WPUST — rowek wycięty na zewnątrz od okrągłego
//    otworu, w który ten wypust wchodzi (poprzednia wersja miała to
//    odwrócone — żeberko wystające do wnętrza otworu bębna — błąd,
//    poprawione po korekcie użytkownika mającego fizyczny bęben w ręku).
//    Element pomocniczy tools/openscad/mating_shaft_reference.scad ma
//    wypust pasujący do tego wpustu.

LENGTH   = 26.0;   // długość całkowita walca

// Amplituda krzywek — zdefiniowana najpierw, bo teraz to ONA determinuje
// średnicę kołnierza BOSS0 (patrz punkt 3 wyżej).
// Zakres promienia krawędzi ząbków = rzeczywisty, zmierzony zakres ruchu
// czujnika/popychacza na oryginale A. Pierwsza wersja ([7.71, 17.03] mm)
// pochodziła z pliku STL zestawu A (thing:6018240) — trzeciej strony repliki,
// niekoniecznie identycznej z fizycznym bębnem użytkownika. Po dostarczeniu
// zdjęć fizycznego bębna porównano głębokość wcięć zębów z polem widoku, w
// którym widoczny jest też kołnierz o znanej średnicy — jako skala
// odniesienia. Na tej podstawie doliny zębów sięgają wizualnie płycej niż
// zakładał plik STL — ok. 70% promienia szczytu, nie ~45%.
// EDGE_MAX_R pozostaje zgodny z Ø części zębatej (szczyty zębów, potwierdzone
// i na zdjęciach, i w STL). EDGE_MIN_R podniesiono, więc amplituda (EDGE_SWING)
// jest mniejsza — subtelniejszy, płytszy ścieg, bliższy temu, co widać na
// zdjęciach. To nadal szacunek wizualny (brak w zdjęciach twardej skali/
// suwmiarki) — do potwierdzenia wydrukiem próbnym i porównaniem z oryginałem.
EDGE_MAX_R = 17.03;
EDGE_MIN_R = 12.0;
EDGE_SWING = EDGE_MAX_R - EDGE_MIN_R;

BOSS0_R  = EDGE_MAX_R;  // kołnierz z grawerunkiem, Ø = maks. amplituda krzywek (niebieska strzałka)
BOSS1_R  = 10.30;       // promień kołnierza przy Z=LENGTH (strona daleka), Ø ~20.6

BOSS0_LEN   = 3.2;
CHAMFER_LEN = 0.7;      // ścięcie na czole kołnierza (punkt 6 wyżej)

// Pierścień z płytkimi, poziomymi rowkami tuż za kołnierzem (punkt 4 wyżej).
RING_R        = BOSS0_R - 2.2;  // promień dna rowków, wyraźnie mniejszy niż EDGE_MAX_R
RING_LEN      = 2.0;
RING_GROOVES  = 3;
RING_GROOVE_W = 0.5;

// Przejście między pierścieniem a częścią zębatą: pojedynczy, gładki stożek
// wprost do EDGE_MIN_R (punkt 5 wyżej) — długość dobrana tak, by
// NECK_END wypadł w tym samym miejscu co w poprzedniej wersji (9.7 mm),
// zachowując układ 5 pozycji ściegu bez dalszych przeliczeń.
NECK_START = BOSS0_LEN + RING_LEN;   // 5.2
NECK_LEN   = 4.5;
NECK_END   = NECK_START + NECK_LEN;  // 9.7

// Otwór na wałek napędowy maszyny, wycięty od czoła Z=0 (nie przelotowy przez
// całą długość — patrz punkt 7 wyżej). SOCKET_KEY_* niżej to wpust
// przyjmujący wypust wałka.
SOCKET_R     = 7.8;
SOCKET_DEPTH = 2.5;
// Wpust pryzmatyczny — standardowy układ: to WAŁEK maszyny ma wypust (klin,
// materiał wystający na zewnątrz), a BĘBEN (ten model) ma WPUST — rowek
// wycięty NA ZEWNĄTRZ od okrągłego otworu, w które ten klin wchodzi.
// Element pomocniczy `mating_shaft_reference.scad` ma wypust (protruding
// key) pasujący do tego rowka.
// Wymiary nadal szacowane wizualnie ze zdjęć (plik referencyjny STL nie ma
// żadnego wpustu — jego otwór jest idealnie okrągły) — DO WERYFIKACJI
// dopasowaniem do prawdziwego wałka maszyny.
SOCKET_KEY_WIDTH = 6.0;    // szerokość rowka (wpustu)
SOCKET_KEY_DEPTH = 3.0;    // jak daleko rowek wcina się na zewnątrz od SOCKET_R

N_POS     = 5;     // liczba pozycji wyboru ściegu (jak w zestawie A)
BOSS1_LEN = 1.75;
BAND_LEN  = (LENGTH - NECK_END - BOSS1_LEN) / N_POS;  // pozycje sąsiadują bez odstępu

function position_z(i) = NECK_END + i*BAND_LEN;

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

// Kołnierz z grawerunkiem: ścięcie na czole (Z=0), potem walec o promieniu
// BOSS0_R (punkty 3 i 6 wyżej).
module boss0_plain() {
    cylinder(h=CHAMFER_LEN, r1=BOSS0_R-CHAMFER_LEN, r2=BOSS0_R, $fn=96);
    translate([0, 0, CHAMFER_LEN])
        cylinder(h=BOSS0_LEN-CHAMFER_LEN, r=BOSS0_R, $fn=96);
}

// Pierścień z poziomymi rowkami — NIE gwint (punkt 4 wyżej).
module ring_grooved() {
    difference() {
        cylinder(h=RING_LEN, r=BOSS0_R, $fn=96);
        for (i = [0:RING_GROOVES-1]) {
            gz = RING_LEN * (i+0.5) / RING_GROOVES;
            translate([0, 0, gz - RING_GROOVE_W/2])
                cylinder(h=RING_GROOVE_W, r=RING_R, $fn=96);
        }
    }
}

// Przejście do części zębatej: pojedynczy, gładki stożek (punkt 5 wyżej).
module mounting_neck() {
    translate([0, 0, NECK_START])
        cylinder(h=NECK_LEN, r1=RING_R, r2=EDGE_MIN_R, $fn=96);
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
    // Promienie/rozmiary przeskalowane proporcjonalnie do nowego, większego
    // BOSS0_R (dawniej 14.97, teraz = EDGE_MAX_R = 17.03 — punkt 3 wyżej).
    translate([0, 12.5, -0.01])
        linear_extrude(0.7)
            text(letter, size=7.4, halign="center", valign="center", font="Liberation Sans:style=Bold");
    arc_text("HUSQVARNA", 12.0, 250, 130, 2.3, 0.7);
    arc_text("SWEDEN", 10.0, 250, 90, 1.8, 0.7);
}

// Otwór na wałek z wpustem pryzmatycznym: okrągły otwór + rowek wycięty na
// zewnątrz (dodatkowa przestrzeń usunięta z bryły), w który wchodzi wypust
// (klin) wałka maszyny — patrz uwaga przy SOCKET_KEY_* wyżej.
module socket_cut() {
    union() {
        cylinder(h=SOCKET_DEPTH, r=SOCKET_R, $fn=64);
        translate([SOCKET_R - 0.5, -SOCKET_KEY_WIDTH/2, 0])
            cube([SOCKET_KEY_DEPTH + 0.5, SOCKET_KEY_WIDTH, SOCKET_DEPTH]);
    }
}

module cam_solid(profile_fns) {
    difference() {
        union() {
            boss0_plain();
            translate([0, 0, BOSS0_LEN])
                ring_grooved();
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

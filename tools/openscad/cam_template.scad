// SZABLON nowego bębna ściegowego — skopiuj ten plik jako cam_X.scad (gdzie X
// to nowa litera/nazwa zestawu) i zmień tylko to, co jest oznaczone TODO.
// Geometria mocowania (kołnierze, gwint, gniazdo, trzpień, zakres wychylenia)
// jest wspólna dla wszystkich zestawów i mieszka w cam_common.scad — nie trzeba
// (i nie należy) jej tu powtarzać ani zmieniać.
//
// PL: Ten plik to pełny przykład — 5 pozycji ściegu zbudowanych z gotowych
// funkcji falowych z cam_common.scad. Możesz łączyć je dowolnie (dodawanie,
// mnożenie, przesunięcia fazowe) — patrz docs/CREATING_NEW_DRUMS.md po opis
// każdej funkcji i wskazówki projektowe.
//
// EN: This file is a full example — 5 stitch positions built from the ready
// wave functions in cam_common.scad. Combine them however you like (add,
// multiply, phase-shift) — see docs/CREATING_NEW_DRUMS.md for a description
// of every function and design guidance.

include <cam_common.scad>

// TODO: zdefiniuj 5 funkcji profilu, jedna na pozycję ściegu.
// Każda przyjmuje kąt `a` w stopniach (0..360) i zwraca wartość w przybliżeniu
// -1..1 (mnożnik amplitudy pilnuje, żeby nie wyjść poza sensowny zakres —
// sama skala fizyczna [EDGE_MIN_R, EDGE_MAX_R] jest już wspólna, patrz wyżej).
function x_pos1(a) = tri_wave(a, 8) * 0.5;                 // TODO: nazwij i opisz wzór
function x_pos2(a) = sine_wave(a, 6) * 0.7;                 // TODO
function x_pos3(a) = saw_wave(a, 5, 0.6) * 0.8;             // TODO
function x_pos4(a) = double_lobe(a, 6) * 0.75;              // TODO
function x_pos5(a) = diamond_lattice(a, 7) * 0.6;           // TODO

// TODO: podmień "X" na literę/nazwę nowego zestawu (używana też do grawerunku).
cam_with_grooves("X", [
    function(a) x_pos1(a),
    function(a) x_pos2(a),
    function(a) x_pos3(a),
    function(a) x_pos4(a),
    function(a) x_pos5(a),
]);

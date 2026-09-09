// ==============================================================================
// BÄ™ben Ĺ›ciegowy E dla Husqvarna 21E / 21A.
// Wygenerowano za pomocÄ… generatora projektu krzywki-do-husqvarna-gemini.
//
// Poz 1: Ĺšcieg kryty / brzegowy (A1)
// Poz 2: Ĺšcieg serpentynowy / fala pĹ‚ynna (B1 poz. 1)
// Poz 3: Satynowy romb / pereĹ‚ki (B1 poz. 3)
// Poz 4: Meander grecki / baszty (C1 poz. 1)
// Poz 5: Zygzak standardowy referencyjny / spoczynkowy
// ==============================================================================
include <../../tools/openscad/cam_common.scad>

function e_pos1(a) = blind_hem(a, 3, 0.20);
function e_pos2(a) = sine_wave(a, 3) * 0.90;
function e_pos3(a) = diamond_satin(a, 18, 3);
function e_pos4(a) = trap_wave(a, 4, 0.45) * 0.90;
function e_pos5(a) = trap_wave(a, 9, 0.28) * 0.95;

cam_with_grooves("E", [
    function(a) e_pos1(a),
    function(a) e_pos2(a),
    function(a) e_pos3(a),
    function(a) e_pos4(a),
    function(a) e_pos5(a),
]);
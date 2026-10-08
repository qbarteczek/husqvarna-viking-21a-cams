// Bęben A (standardowy) dla Husqvarna 21E / 21A.
// Geometria zębów oparta na 9-zębnej fali trapezowej (trap_wave) o płaskich szczytach
// i dolinach, bezpośrednio odwzorowującej fizyczny bęben A ze zdjęć.
include <../../tools/openscad/cam_common.scad>

// 5 pozycji ściegów bębna A:
function a_pos1(a) = trap_wave(a, 9, 0.28) * 0.85;        // zygzak standardowy / pełny
function a_pos2(a) = trap_wave(a + 20, 9, 0.28) * 0.70;   // wariant ściegu elastycznego
function a_pos3(a) = trap_wave(a, 9, 0.28) * 0.50;        // zygzak wąski
function a_pos4(a) = trap_wave(a + 10, 9, 0.28) * 0.65;   // zygzak średni
function a_pos5(a) = trap_wave(a, 9, 0.28) * 0.95;        // zygzak szeroki

cam_with_grooves("A", [
    function(a) a_pos1(a),
    function(a) a_pos2(a),
    function(a) a_pos3(a),
    function(a) a_pos4(a),
    function(a) a_pos5(a),
]);

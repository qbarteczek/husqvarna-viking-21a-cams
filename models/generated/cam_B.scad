// Zestaw B — "Fale i muszelki" (oryginalny wzór, nowoprojektowany — nie jest
// odtworzeniem historycznej krzywki, bo źródła historyczne nie były dostępne).
// Wymiary mechaniczne = zestaw A (thing:6018240). Patrz ../../docs/STITCH_DESIGN.md.
include <../../tools/openscad/cam_common.scad>

function b_pos1(a) = tri_wave(a, 7) * 0.55;                 // zygzak referencyjny
function b_pos2(a) = saw_wave(a, 5, 0.85) * 0.9;             // muszelka (scallop)
function b_pos3(a) = sine_wave(a, 6) * 0.8;                  // fala
function b_pos4(a) = double_lobe(a, 5) * 0.9;                // podwójny overlock
function b_pos5(a) = tri_wave(a, 14) * 0.5;                  // grzebyk (drobna fala)

cam_with_grooves("B", [
    function(a) b_pos1(a),
    function(a) b_pos2(a),
    function(a) b_pos3(a),
    function(a) b_pos4(a),
    function(a) b_pos5(a),
]);

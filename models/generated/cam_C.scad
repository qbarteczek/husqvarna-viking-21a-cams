// Zestaw C — "Ściegi ozdobne otwarte" (oryginalny wzór, nowoprojektowany — nie
// jest odtworzeniem historycznej krzywki, bo źródła historyczne nie były dostępne).
// Wymiary mechaniczne = zestaw A (thing:6018240). Patrz ../../docs/STITCH_DESIGN.md.
include <../../tools/openscad/cam_common.scad>

function c_pos1(a) = tri_wave(a, 9) * 0.5;                              // zygzak referencyjny
function c_pos2(a) = feather(a, 6) * 0.85;                              // piórko
function c_pos3(a) = (tri_wave(a, 6) + 0.4*tri_wave(a*2, 6)) / 1.4 * 0.85; // krzyżyk
function c_pos4(a) = arrow_sharpen(a, 4, 0.5) * 0.9;                    // strzałka
function c_pos5(a) = diamond_lattice(a, 6) * 0.8;                       // plaster miodu

cam_with_grooves("C", [
    function(a) c_pos1(a),
    function(a) c_pos2(a),
    function(a) c_pos3(a),
    function(a) c_pos4(a),
    function(a) c_pos5(a),
]);

// Zestaw D — "Ściegi użytkowe specjalne" (oryginalny wzór, nowoprojektowany —
// nie jest odtworzeniem historycznej krzywki, bo źródła historyczne nie były
// dostępne). Wymiary mechaniczne = zestaw A (thing:6018240).
// Patrz ../../docs/STITCH_DESIGN.md.
include <../../tools/openscad/cam_common.scad>

function d_pos1(a) = tri_wave(a, 10) * 0.4;                     // zygzak referencyjny (wąski)
function d_pos2(a) = (pulse(a, 6, 0.15)*1.6 - 0.3) * 0.6;       // ślepy ścieg (pojedyncze ugryzienie)
function d_pos3(a) = sign(sine_wave(a, 6)) * 0.7;                // drabinka
function d_pos4(a) = tri_wave(a, 18) * 0.3;                      // potrójny prosty wzmocniony
function d_pos5(a) = (sine_wave(a, 6) + 0.3*sine_wave(a, 18)) / 1.3 * 0.85; // zamknięty overlock elastyczny

cam_with_grooves("D", [
    function(a) d_pos1(a),
    function(a) d_pos2(a),
    function(a) d_pos3(a),
    function(a) d_pos4(a),
    function(a) d_pos5(a),
]);

// Natywna rekonstrukcja zestawu A w generatorze (nie zamiennik pliku
// referencyjnego w models/original/ — ten zostaje jako źródło pomiarów).
// Wzór wg opisu z thing:6018240: pozycje 1-2 = zygzak 3-stopniowy,
// pozycje 3-5 = zwykły zygzak (węższy/średni/szerszy). Profil przybliżony
// falą trójkątną (dokładny, oryginalny kształt toru nie jest odtwarzany
// 1:1 — patrz docs/DIMENSIONS.md o ograniczeniach analizy STL).
include <../../tools/openscad/cam_common.scad>

function a_pos1(a) = tri_wave(a, 9) * 0.55;   // zygzak 3-stopniowy, wariant 1
function a_pos2(a) = tri_wave(a, 7) * 0.7;    // zygzak 3-stopniowy, wariant 2
function a_pos3(a) = tri_wave(a, 6) * 0.45;   // zwykły zygzak, wąski
function a_pos4(a) = tri_wave(a, 6) * 0.65;   // zwykły zygzak, średni
function a_pos5(a) = tri_wave(a, 6) * 0.85;   // zwykły zygzak, szeroki

cam_with_grooves("A", [
    function(a) a_pos1(a),
    function(a) a_pos2(a),
    function(a) a_pos3(a),
    function(a) a_pos4(a),
    function(a) a_pos5(a),
]);

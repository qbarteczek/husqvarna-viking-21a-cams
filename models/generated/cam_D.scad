// Bęben D (specjalne ściegi użytkowe i wzmocnione) dla Husqvarna 21E / 21A.
// Geometria mechaniczna bębna identyczna z wzorcowymi zestawami A, B, C.
// Zgodny ze specyfikacją w docs/STITCH_DESIGN.md:
// Poz 1: Zygzak wąski precyzyjny (tri_wave, 10 cykli, amplituda 0.40)
// Poz 2: Ścieg ślepy kryty wzmocniony (blind_hem, 4 cykle)
// Poz 3: Drabinka cerująca dwustronna (ladder stitch, 6 cykli)
// Poz 4: Potrójny ścieg prosty elastyczny (triple stretch, 18 cykli)
// Poz 5: Zygzak standardowy referencyjny / stan spoczynkowy (stinglengde 1.5)
include <../../tools/openscad/cam_common.scad>

function d_pos1(a) = tri_wave(a, 10) * 0.40;
function d_pos2(a) = blind_hem(a, 4, 0.15);
function d_pos3(a) = sign(sine_wave(a, 6)) * 0.85;
function d_pos4(a) = tri_wave(a, 18) * 0.30;
function d_pos5(a) = trap_wave(a, 9, 0.28) * 0.95;

cam_with_grooves("D", [
    function(a) d_pos1(a),
    function(a) d_pos2(a),
    function(a) d_pos3(a),
    function(a) d_pos4(a),
    function(a) d_pos5(a),
]);


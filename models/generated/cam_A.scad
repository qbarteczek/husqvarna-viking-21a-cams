// Bęben A1 (standardowy, nr kat. S 41-10950) dla Husqvarna 21E / 21A.
// Odtworzenie fabrycznych ściegów z instrukcji obsługi Husqvarna 21E (str. 31):
// Poz 1: Ścieg kryty / brzegowy (usynlig faldsöm / picot, stinglengde 0.3)
// Poz 2: Zygzak 3-stopniowy elastyczny (trestings siksak, stinglengde 0.3)
// Poz 3: Zygzak szeroki (stinglengde 1.0)
// Poz 4: Zygzak gęsty cerujący (stinglengde 0.3)
// Poz 5: Zygzak standardowy referencyjny / stan spoczynkowy (stinglengde 1.5)
include <../../tools/openscad/cam_common.scad>

function a_pos1(a) = blind_hem(a, 3, 0.20);
function a_pos2(a) = three_step_zigzag(a, 3);
function a_pos3(a) = trap_wave(a, 9, 0.28) * 0.95;
function a_pos4(a) = trap_wave(a, 9, 0.28) * 0.80;
function a_pos5(a) = trap_wave(a, 9, 0.28) * 0.95;

cam_with_grooves("A", [
    function(a) a_pos1(a),
    function(a) a_pos2(a),
    function(a) a_pos3(a),
    function(a) a_pos4(a),
    function(a) a_pos5(a),
]);

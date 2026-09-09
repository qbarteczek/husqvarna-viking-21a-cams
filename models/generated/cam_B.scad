// Bęben B1 (mönsterkamsats B:1, nr kat. S 41-10951) dla Husqvarna 21E / 21A.
// Odtworzenie fabrycznych ściegów z instrukcji obsługi Husqvarna 21E (str. 31):
// Poz 1: Ścieg serpentynowy / fala płynna (slangesöm, stinglengde 1.5)
// Poz 2: Jodełka schodkowa / gęsta fala łamana (stinglengde 0.3)
// Poz 3: Satynowy romb / perełki / liście (diamantsöm, stinglengde 0.3)
// Poz 4: Ząbki skośne / piła (tannsöm, stinglengde 0.3)
// Poz 5: Zygzak standardowy referencyjny (stinglengde 1.5)
include <../../tools/openscad/cam_common.scad>

function b_pos1(a) = sine_wave(a, 3) * 0.90;
function b_pos2(a) = (tri_wave(a, 3) * 0.70 + tri_wave(a, 18) * 0.25);
function b_pos3(a) = diamond_satin(a, 18, 3);
function b_pos4(a) = saw_wave(a, 6, 0.80) * 0.90;
function b_pos5(a) = trap_wave(a, 9, 0.28) * 0.95;

cam_with_grooves("B", [
    function(a) b_pos1(a),
    function(a) b_pos2(a),
    function(a) b_pos3(a),
    function(a) b_pos4(a),
    function(a) b_pos5(a),
]);

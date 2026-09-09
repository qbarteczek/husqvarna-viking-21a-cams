// Bęben C1 (mönsterkamsats C:1, nr kat. S 41-10952) dla Husqvarna 21E / 21A.
// Odtworzenie fabrycznych ściegów z instrukcji obsługi Husqvarna 21E (str. 31):
// Poz 1: Meander grecki / baszty (mekaniskt meander, stinglengde 0.3)
// Poz 2: Ścieg płomieniowy / ostry trójkątny (flammesöm, stinglengde 0.3)
// Poz 3: Bloki satynowe prostokątne (blokksöm, stinglengde 0.3)
// Poz 4: Klepsydra / podwójny romb (stinglengde 0.3)
// Poz 5: Zygzak standardowy referencyjny (stinglengde 1.5)
include <../../tools/openscad/cam_common.scad>

function c_pos1(a) = trap_wave(a, 4, 0.45) * 0.90;
function c_pos2(a) = arrow_sharpen(a, 6, 0.50) * 0.90;
function c_pos3(a) = block_satin(a, 16, 4);
function c_pos4(a) = hourglass_satin(a, 18, 3);
function c_pos5(a) = trap_wave(a, 9, 0.28) * 0.95;

cam_with_grooves("C", [
    function(a) c_pos1(a),
    function(a) c_pos2(a),
    function(a) c_pos3(a),
    function(a) c_pos4(a),
    function(a) c_pos5(a),
]);

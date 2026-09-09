// ==============================================================================
// BÄBEN ĹšCIEGOWY HUSQVARNA 21E â€” ZESTAW E
// Wygenerowano automatycznie za pomocÄ… generate_drum.ps1
// ==============================================================================
include <../../tools/openscad/cam_common.scad>
include <../../tools/openscad/stitch_catalog.scad>

function pos1(a) = get_stitch_by_id(1, a);
function pos2(a) = get_stitch_by_id(14, a);
function pos3(a) = get_stitch_by_id(23, a);
function pos4(a) = get_stitch_by_id(29, a);
function pos5(a) = get_stitch_by_id(4, a);

cam_with_grooves("E", [
    function(a) pos1(a),
    function(a) pos2(a),
    function(a) pos3(a),
    function(a) pos4(a),
    function(a) pos5(a)
]);
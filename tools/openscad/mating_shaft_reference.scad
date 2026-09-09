// Element pomocniczy/techniczny — NIE jest to model prawdziwego wałka maszyny
// (jego dokładna geometria poza otworem/wpustem nie jest znana). To prosty
// trzpień testowy odwzorowujący TYLKO otwór na wałek i wpust pryzmatyczny
// z cam_common.scad, z niewielkim luzem — do wydrukowania i sprawdzenia, czy
// wpust w wydrukowanym bębnie pasuje, zanim wydrukuje się cały bęben (który
// zajmuje więcej czasu/materiału).
//
// PL: Wydrukuj ten trzpień i spróbuj go wsunąć w otwór wydrukowanego bębna
// (dowolnego z A/B/C/D — otwór jest wspólny). Jeśli wchodzi z wyczuwalnym,
// ale niezbyt luźnym oporem — wymiary wpustu (SOCKET_KEY_WIDTH/PROTRUSION w
// cam_common.scad) są w porządku. Jeśli za ciasno/za luźno, skoryguj
// SHAFT_CLEARANCE poniżej i wydrukuj ponownie — taniej niż przedruk bębna.
//
// EN: Print this pin and try sliding it into the hole of a printed drum (any
// of A/B/C/D — the hole is shared). If it goes in with noticeable but not too
// loose resistance, the key dimensions (SOCKET_KEY_WIDTH/PROTRUSION in
// cam_common.scad) are fine. If too tight/loose, adjust SHAFT_CLEARANCE below
// and reprint — cheaper than reprinting a whole drum.

include <cam_common.scad>

SHAFT_CLEARANCE = 0.15; // luz montażowy / assembly clearance (mm, promieniowo/na stronę)
SHAFT_LEN        = 15;  // dowolna długość do trzymania w ręku / arbitrary, easy to hold

module mating_shaft() {
    difference() {
        cylinder(h=SHAFT_LEN, r=SOCKET_R - SHAFT_CLEARANCE, $fn=64);
        translate([SOCKET_R - SOCKET_KEY_PROTRUSION - SHAFT_CLEARANCE,
                    -(SOCKET_KEY_WIDTH + 2*SHAFT_CLEARANCE)/2, -1])
            cube([SOCKET_KEY_PROTRUSION + SHAFT_CLEARANCE + 1,
                  SOCKET_KEY_WIDTH + 2*SHAFT_CLEARANCE, SHAFT_LEN + 2]);
    }
}

mating_shaft();

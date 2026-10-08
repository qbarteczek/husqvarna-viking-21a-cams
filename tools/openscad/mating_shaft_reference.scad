// Element pomocniczy/techniczny — wzorzec wałka do szybkiego testu pasowania.
// Wałek posiada wystający klin (wypust) pasujący do wyciętego w bębnie wpustu (rowka).
// Wydrukuj ten element przed drukiem całego bębna, aby sprawdzić spasowanie z otworem bębna.

include <cam_common.scad>

SHAFT_CLEARANCE = 0.15; // luz montażowy (promieniowo/na stronę w mm)
SHAFT_LEN       = 20.0; // poręczna długość próbki testowej

module mating_shaft() {
    union() {
        cylinder(h=SHAFT_LEN, r=SOCKET_R - SHAFT_CLEARANCE, $fn=64);
        translate([SOCKET_R - SHAFT_CLEARANCE - 0.3,
                   -(SOCKET_KEY_WIDTH - 2*SHAFT_CLEARANCE)/2, 0])
            cube([SOCKET_KEY_DEPTH - SHAFT_CLEARANCE + 0.3,
                  SOCKET_KEY_WIDTH - 2*SHAFT_CLEARANCE, SHAFT_LEN]);
    }
}

mating_shaft();

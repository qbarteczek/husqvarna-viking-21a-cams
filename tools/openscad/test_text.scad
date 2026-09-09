// test_text.scad
include <cam_common.scad>;

module arc_text_top(str, radius, center_angle, angle_span, size, depth) {
    n = len(str);
    for (i = [0:n-1]) {
        frac = (n <= 1) ? 0.5 : i / (n - 1);
        // od lewej do prawej po górnym łuku (od kąta > 90 do kąta < 90)
        a = center_angle + angle_span/2 - frac * angle_span;
        translate([radius*cos(a), radius*sin(a), -0.01])
            rotate([0, 0, a - 90])
                linear_extrude(depth)
                    text(str[i], size=size, halign="center", valign="center", font="Liberation Sans:style=Bold");
    }
}

difference() {
    cylinder(h=2.4, r=14.5, $fn=96);
    mirror([1, 0, 0]) {
        // test napisu u góry
        arc_text_top("HUSQVARNA", 12.2, 90, 95, 1.6, 0.6);
        arc_text_top("SWEDEN", 10.1, 90, 65, 1.3, 0.6);
        // litera A i 1 na dole
        translate([0, -11.2, -0.01])
            linear_extrude(0.6)
                text("A 1", size=3.5, halign="center", valign="center", font="Liberation Sans:style=Bold");
        // znaczniki radialne
        translate([8.5, -0.3, -0.01]) cube([5.0, 0.6, 0.6]);
        translate([-13.5, -0.3, -0.01]) cube([5.0, 0.6, 0.6]);
    }
    // otwór
    cylinder(h=10, r=7.8, center=true, $fn=64);
}

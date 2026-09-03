// Widok zbiorczy wszystkich czterech krzywek (A referencyjna + B, C, D) obok
// siebie, do jednego renderu poglądowego. Importuje gotowe pliki .stl (a nie
// przelicza CSG na żywo) — łączenie czterech pełnych drzew CSG w jednym
// podglądzie przekracza limit normalizacji OpenSCAD 2021.01 (pusty wynik).
// Wymaga wcześniejszego wyrenderowania models/generated/cam_B.stl, cam_C.stl,
// cam_D.stl (patrz docs/WORKFLOW.md).

SPACING = 45;

module label(t) {
    translate([0, -24, -13])
        rotate([90,0,0])
            linear_extrude(1)
                text(t, size=7, halign="center", valign="center", font="Liberation Sans:style=Bold");
}

translate([-1.5*SPACING, 0, 0]) {
    rotate([90,0,0]) import("../../../models/original/cam_A_V21ZZ3Z.stl");
    label("A (referencja)");
}
translate([-0.5*SPACING, 0, 0]) {
    import("../../../models/generated/cam_B.stl");
    label("B");
}
translate([0.5*SPACING, 0, 0]) {
    import("../../../models/generated/cam_C.stl");
    label("C");
}
translate([1.5*SPACING, 0, 0]) {
    import("../../../models/generated/cam_D.stl");
    label("D");
}

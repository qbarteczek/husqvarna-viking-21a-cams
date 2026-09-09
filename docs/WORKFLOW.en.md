# Workflow

*(Polish original: [`WORKFLOW.md`](WORKFLOW.md))*

## Requirements

- OpenSCAD **2021.01 or newer** (the files use function literals: `function(a) ...`).
  This machine has `C:\Program Files\OpenSCAD\openscad.exe` (2021.01.22) installed.

## Rendering

```powershell
& "C:\Program Files\OpenSCAD\openscad.exe" -o cam_A.stl models\generated\cam_A.scad
& "C:\Program Files\OpenSCAD\openscad.exe" -o cam_B.stl models\generated\cam_B.scad
& "C:\Program Files\OpenSCAD\openscad.exe" -o cam_C.stl models\generated\cam_C.scad
& "C:\Program Files\OpenSCAD\openscad.exe" -o cam_D.stl models\generated\cam_D.scad
& "C:\Program Files\OpenSCAD\openscad.exe" -o mating_shaft_reference.stl tools\openscad\mating_shaft_reference.scad
```

Each stitch position is a single `linear_extrude` of a polygon (the edge profile) — fast.
Overall: about 1.5 minutes per drum file, a fraction of a second for
`mating_shaft_reference` (no teeth).

To see just the profile shape (a cross-section), e.g. for a quick check after changing a
pattern:

```powershell
& "C:\Program Files\OpenSCAD\openscad.exe" -o cross.png --render `
  --camera=0,0,13,0,0,0,55 --projection=o tools\openscad\render\cam_B_cross.scad
```

(`projection(cut=true)` in these files makes a cross-section at Z=13 — the barrel's midpoint.)

## Order of work

1. Print `tools/openscad/mating_shaft_reference.scad` and check the fit of the hole + prismatic
   key against the machine's socket — a faster, cheaper test than a whole drum (see
   `docs/PRINTABILITY.en.md`).
2. Print a test copy of set A (the native `cam_A.scad`, or the reference file from
   `models/original/`) and check the fit against the machine — confirms the measured/
   photographed dimensions in `docs/DIMENSIONS.en.md` are correct.
3. Print a test copy of one position of set B/C/D and compare the stitch width against set A —
   calibrate `EDGE_MAX_R` / `EDGE_MIN_R` in `cam_common.scad` if needed (see
   `docs/PRINTABILITY.en.md` for the rationale behind the current values and safety margins).
4. After calibration, print the full B, C, D sets — or design your own, see
   [`docs/CREATING_NEW_DRUMS.md`](CREATING_NEW_DRUMS.md).
5. Update the status in the table in `README.md` to "tested" once physically verified.

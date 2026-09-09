# Printability analysis

*(Polish original: [`PRINTABILITY.md`](PRINTABILITY.md))*

## Geometry verification method

No mesh-repair tools available in this environment (e.g. admesh, Meshmixer). The primary
verification used OpenSCAD's built-in CGAL report after a full render (`--render`, the exact
engine, not the preview one):

```
Simple:  yes
```

`Simple: yes` means the solid is a valid 2-manifold (closed, no self-intersections) — this is
effectively the "is this mesh fit for 3D printing" test at the topology level. All four files
(`cam_A.scad`, `cam_B.scad`, `cam_C.scad`, `cam_D.scad`) pass this test.

In addition, a cross-section was generated for every position of every set
(`docs/renders/cam_*_cross_section.png`, `projection(cut=true)` at the barrel's mid-height) —
direct proof of the actual edge shape, independent of how the 3D preview happens to render
(see point 3 in the problem history below).

## History of the problems found and fixed

### 1. Wall too thin (fixed, later superseded by approach #3)

The first version of the parameters left about 0.17 mm of wall on the outer-surface side at
the most strongly deflected profiles — practically a breach all the way through, too little
for FDM.

### 2. Groove completely hidden inside the material (fixed, later superseded by approach #3)

An attempt to fix problem #1 resulted in a groove that stopped reaching the outer surface —
non-functional, since the follower pin approaches the groove from outside.

### 3. Wrong mechanism model — a narrow groove instead of a profiled edge (functional bug, fixed for good)

Even after fix #2 (the groove correctly opened to the outside), the design was **still
mechanically wrong**: it was a narrow (2.2 mm), shallow channel cut into the wall of an
otherwise full-diameter cylinder (Ø 33.94 mm over most of the surface). Comparing this against
the real appearance of set A (`docs/renders/cam_A_iso.png`) showed the real mechanism is
different: **the cylinder's edge itself, at each of the 5 positions, is shaped as the stitch
profile** (visible, deep teeth all around the circumference), not hidden in the middle of a
full-diameter body. The machine's sensor/follower rides directly on this edge — a classic edge/
plate cam, not a channel with something "floating" inside the material.

**Fix #3**: each of the 5 positions is now a separate solid extruded (`linear_extrude`) from a
polygon whose outline IS DIRECTLY the stitch profile — the radius varies from
`EDGE_MAX_R = MAIN_R` (shallow) to `EDGE_MIN_R` (deep). Verified visually (isometric views
clearly show teeth, just like set A) and by cross-section.

### 4. Collars between positions and a full-length shaft bore — two further bugs found after a more precise measurement of the original (fixed)

A precise radius scan every 0.1–0.25 mm along the full length of original A (instead of just a
few cross-sections) revealed two more discrepancies against the real structure:

- **Collars between positions**: in the original, the 5 stitch positions sit **directly
  adjacent to each other, with no gap at all**. An earlier version inserted a narrow (0.8 mm)
  separating collar between them — removed.
- **No through-bore**: cam A **does not have** a central shaft bore running its full length.
  Instead it has: a shaft hole (r≈7.8 mm, depth ~2.5 mm) cut into the face of the large
  flange, and a separate, multi-step mounting spindle (several diameters: 14.97 → 9.75 →
  13.97 → 7.75 mm) between the large flange and the toothed section — see
  `docs/DIMENSIONS.en.md`. An earlier version modeled this as a simple full-length hole, which
  was a wrong simplification affecting the real mounting in the machine.

**Final fix**: `cam_common.scad` now reproduces the exact stepped spindle profile (a series of
`cylinder(r1=...,r2=...)`) and the shaft hole (instead of a through-hole), and stitch positions
sit directly adjacent with no gap (`BAND_LEN` computed without collars). Verified directly
against the STL data (a radius scan confirms every segment of the spindle) — see
`docs/renders/`.

### 5. Sensor deflection range exceeded the mechanism's real reach (fixed, later refined with photos)

`EDGE_MIN_R` was earlier set to 6.5 mm — a value chosen purely for print-strength reasons (so
a tooth valley wouldn't be too thin), **with no reference to how far the sensor/follower can
physically reach in the real machine**. A full radius scan of the entire toothed section of
original A (the STL file, a third-party replica) showed a range of **[7.71 mm, 17.03 mm]**.
After the user's photos of the physical drum arrived and the notch depth was compared against
the flange's known diameter as a scale — the real valley depth turned out to be shallower.
Corrected to `EDGE_MIN_R = 12.0 mm` (see `docs/STITCH_DESIGN.en.md`) — still an estimate (no
hard scale in the photos), but closer to the physical drum than the STL replica alone.

**Fix**: `EDGE_MAX_R = 17.03`, `EDGE_MIN_R = 12.0`. Each of the 15 B/C/D profiles (the
`*_pos1..5` functions in `cam_B/C/D.scad`) scales its amplitude WITHIN this range (coefficients
0.3–0.9 from `docs/STITCH_DESIGN.en.md`), so no pattern asks the sensor to deflect beyond its
reach.

### 6. Thread, prismatic key, and engraving added based on photos of the physical drum

After receiving photos of the real drum A (see `docs/DIMENSIONS.en.md`, "Corrections based on
photos..." section), three elements not visible in the STL mesh of set A alone were added:

- **Thread on the large flange** (`boss0_threaded()` in `cam_common.scad`) — instead of a
  smooth cylinder. Printability: a thread printed with the axis vertical (like the rest of the
  solid) is standard, trouble-free FDM — each turn is just a slight, gradual radius increase
  across successive layers, no overhangs. **The exact thread dimensions should be confirmed by
  a test fit into the machine's socket** — pitch/depth were chosen visually from photos, not
  measured.
- **Prismatic key (drive dog) in the shaft hole** — a solid, rectangular rib protruding INTO
  the hole (not a flat cut/slot, see `docs/DIMENSIONS.en.md`). Printability: the rib is solid
  material spanning the hole, printed from the first layer along with the rest of the flange —
  no overhangs, no supports. Dimensions (`SOCKET_KEY_WIDTH`/`SOCKET_KEY_PROTRUSION`) were
  revised after a closer look at photos of the drum's far end — the rib is more prominent than
  initially estimated. **To be verified by fitting against the real shaft.**
- **Engraving** ("HUSQVARNA" + "SWEDEN" + the set's letter) — shallow (0.7 mm), on the flat
  face, no effect on printability — as before.

### Auxiliary part for verifying the fit

[`tools/openscad/mating_shaft_reference.scad`](../tools/openscad/mating_shaft_reference.scad)
— a simple test pin reproducing only the hole and prismatic key (with a small
`SHAFT_CLEARANCE`), to print and check the fit **before** printing a whole drum (a faster,
cheaper test than reprinting an entire cam if the key turns out to be sized wrong).

## Print orientation

**Recommended orientation: barrel axis vertical (as written in the files — the Z axis), the
larger flange (Ø 29.94 mm, the side with the engraved letter) on the bed.**

Reasons:
- The shaft hole in the face prints horizontally, layer by layer, like any other hole printed
  perpendicular to the axis — no bridging.
- The stepped mounting spindle (Ø 29.94 → 19.5 → 27.94 → 15.5 mm) is a series of short cones
  and collars, all **narrowing** alternately as Z increases — no single step exceeds a few mm
  and all fall within the typical trouble-free FDM range without supports.
- The taper Ø33.94 → Ø20.6 mm at the far end is inward — always trouble-free.

**Known geometric imperfection**: between adjacent stitch positions (with no separating
collar — see above), the edge radius can change fairly abruptly at the boundary between two
positions, if one ends on a deep "valley" and the next starts at a shallow point. This is a
local, single-layer effect (similar to what's seen on original A), usually printable without
supports, but it's worth inspecting these boundaries after printing and lightly cleaning them
up if needed.

**No supports are needed.**

Printing the part flipped (small flange on the bed) is discouraged — then the transition
Ø20.6 → Ø33.94 mm would be a single ~6.7 mm outward step around the full circumference, too
much for a clean print without supports.

## Set-letter marking

The letter (`A`/`B`/`C`/`D`) is engraved (cut to a depth of 0.7 mm) into the flat face of the
larger flange — so in the recommended print orientation it ends up **facing the bed**. This is
a deliberate, common approach (identification engraving on the underside of a print) — to read
it, turn the finished part upside down. The engraving has no effect on printability (shallow,
0.7 mm, creates no overhangs).

## Print settings (proposed, to be verified)

| Parameter | Value | Note |
|---|---|---|
| Layer height | 0.12–0.16 mm | finer layers = better fidelity of the tooth edge |
| Material | PETG or ABS | better wear/heat resistance than PLA for regular use in the machine; PLA is fine for a fit test |
| Infill | 40–60% | the teeth work under mechanical load (sensor/follower) |
| Perimeters | 3 min. | extra strength around the hole and the teeth |
| Supports | none | see rationale above |
| Brim/skirt | a 3–5 mm brim recommended | stabilizes a tall, narrow part during printing, given it later rotates under load |
| Orientation | axis vertical, large flange down | see above |

## Steps after printing

1. Check the fit of the shaft hole (with its key) and the stepped spindle in the machine —
   start with the `mating_shaft_reference.scad` auxiliary part, cheaper than a whole drum.
   FDM prints often come out slightly smaller than nominal (material shrinkage); lightly sand/
   fit as needed.
2. Check and, if needed, clean up local over-extrusion at the boundaries between adjacent
   stitch positions (see above).
3. Check that the sensor/follower moves smoothly along the edge — smooth out any roughness
   with a small needle file.
4. Compare the deflection at the "reference zigzag" position against set A — if it differs
   significantly, adjust `EDGE_MAX_R`/`EDGE_MIN_R` in `cam_common.scad` and reprint.

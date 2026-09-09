# Mechanical dimensions — set A (reference)

*(Polish original: [`DIMENSIONS.md`](DIMENSIONS.md))*

Source: `V21ZZ3Z.stl` from the [thing:6018240](https://www.thingiverse.com/thing:6018240)
package (Viking 21a Basic Stitch Cam, maxkrippler). Dimensions extracted by directly
analyzing the STL mesh vertices (radius scan `sqrt(x²+z²)` as a function of position along
the Y axis, in 0.1–0.25 mm steps), not with a CAD tool (none available in this environment).

## Mechanism type — four corrections across successive, increasingly precise analyses

1. This is **not a flat, profiled disc** (like Elna Supermatic cams), but a barrel/drum cam
   with 5 axial positions.
2. The stitch profile is **the cylinder's edge itself** (teeth), not a hidden groove — the
   machine's sensor rides directly on the edge. Positions are **directly adjacent, with no
   gap**.
3. The cam **has no bore running through its full length**. What was earlier taken for a
   "central hole" is actually: (a) **a hole for the machine's drive shaft, with a key**, cut
   into the face of the large flange — the key is **essential for transmitting rotary
   motion** from the shaft to the drum (not a cosmetic detail) — and (b) a separate, narrower
   **mounting spindle** that's part of a multi-step neck between the large flange and the
   toothed section. Everything else is solid.
4. The machine's sensor/follower has a **limited, hard range of motion**: a full radius scan
   of the toothed section (Y=9.7–24.25) shows the edge radius in the original never leaves
   **[7.71 mm, 17.03 mm]** — this is a physical limit of the sensor's reach in the machine's
   mechanism, not an arbitrary design parameter. An earlier version of B/C/D used a lower
   bound of 6.5 mm (outside this range), chosen purely for print-strength reasons without
   reference to the sensor's real reach — corrected.

## Measured dimensions (rotation axis = Y in the original file)

The Y coordinate runs from 0 (large flange, the side with the visible mounting structure) to
26.01 (small flange at the opposite end).

| Segment (Y) | Radius | Description |
|---|---:|---|
| Y = 0 (face) | Ø 29.94 mm (r 14.97) outer, shaft hole r ≈ 7.8 mm at center, with a key | face of the large flange — hole for the machine's drive shaft (the key transmits rotation) |
| Y = 0 – 3.2 | r = 14.97 mm | large flange (solid, apart from the hole in the face) |
| Y = 3.2 – 3.7 | 14.97 → 9.75 mm | conical transition / shoulder |
| Y = 3.7 – 5.8 | r = 9.75 mm | constant intermediate neck |
| Y = 5.8 – 6.3 | 9.75 → 13.97 mm | conical transition / shoulder (radius increases again!) |
| Y = 6.3 – 7.3 | r = 13.97 mm | constant intermediate collar |
| Y = 7.3 – 7.8 | 13.97 → 7.75 mm | conical transition / shoulder |
| Y = 7.8 – 9.7 | r = 7.75 mm | **mounting spindle** (the narrowest section of the neck) |
| Y = 9.7 – ~24.25 | r = **7.71–17.03 mm** (variable, never outside this range) | toothed section — 5 stitch positions, directly adjacent |
| Y = ~24.25 – 26 | r → 10.30 mm | taper to the small flange at the far end |

Depth of the shaft hole from the Y=0 face: approx. 2.5 mm (to be confirmed — the mesh
measurement doesn't unambiguously resolve the exact floor, only the hole's presence and
radius).

## Corrections based on photos of the physical drum A

The user supplied a series of photos of the physical, original drum A (not an STL file) —
folder [`references/husqvarna_photos_A/`](../references/husqvarna_photos_A/) (see also its
README). The photos revealed three elements not visible/ambiguous in the STL mesh alone:

1. **Thread on the large flange (Y=0–3.2)** — the photos clearly show several thread turns
   right next to the engraved face. The earlier version modeled this flange as a smooth
   cylinder. The pitch and depth of the thread were chosen **visually from the photos** (no
   STL data for this) — `THREAD_PITCH=1.1mm`, `THREAD_DEPTH=0.9mm` in `cam_common.scad` —
   **to be verified and possibly corrected once fitted to the machine's actual socket**.
2. **Key/spline in the shaft hole** — the photos show a flat cut (D-shape) in the hole on the
   engraved-face side. This is a **functional drive element**, not cosmetic — without it the
   machine's shaft would spin freely in the hole without transmitting motion to the drum.
   Added as `SOCKET_KEY_DEPTH`/`SOCKET_KEY_WIDTH` in `cam_common.scad`. The other end of the
   drum (near the small flange) shows a different, more protruding key in the photos (a
   rectangular block projecting into the hole) — **not modeled** in this version (lower
   priority — it's not the face with the interchangeable letter marking, and the face-side
   key already carries the drive).
3. **Engraving** — the real drum has "HUSQVARNA" engraved in an arc at the bottom of the
   face, "SWEDEN" below it, and a large, separate letter for the set closer to the hole at
   the top. Reproduced via `arc_text()` / `cam_label_cut()` in `cam_common.scad`.

**Note on the machine model designation**: this project's documentation previously referred
to "Husqvarna Viking 21A" (following the title of the source file, thing:6018240). The user,
photographing their own physical drum, refers to the machine as **Husqvarna 21E** — this may
be a different variant of the same mechanism family (the 21xx models typically share a
mechanical platform under different market designations), or simply a more accurate
designation of the machine they own. The project name has been updated to "21E"; if this
turns out to be inaccurate in the future, only the name needs to change — the geometry itself
(measured from the real drum and the STL file) remains valid regardless of the exact model
designation.

## What this means for B, C, D

For new sets to physically fit the machine, they must keep:
- the same overall length (26.0 mm),
- the same, exact profile of the stepped mounting spindle (Y=3.2–9.7) — likely a key
  positioning/mounting element, not an arbitrary cosmetic detail,
- the same drive-shaft hole with key in the face of the large flange (functional — carries
  the drive),
- the same flange diameters at both ends (Ø 29.9 mm at Y=0, Ø 20.6 mm at Y=26),
- the same maximum envelope of the toothed section (Ø ~34 mm),
- **no gap between positions** in the toothed section,
- **the same edge-radius range [7.71, 17.03] mm** — no pattern may deflect the sensor beyond
  the limits it physically moves within on the original.

Only **the edge shape (radius as a function of rotation angle)** differs at each of the 5
positions — that's exactly the "stitch pattern" that's designed individually for B, C, D.

## Limitations of this analysis

Dimensions were extracted by analyzing the raw triangle mesh (no access to CAD/OpenSCAD/
Python in this environment) — method: scanning min/max radius in narrow Y bins (0.1–0.25 mm)
and identifying steps/constant segments. Accuracy is on the order of ±0.1 mm for radii, but
the lengths of some short transition segments (shoulders/cones) are approximate — the mesh
resolution didn't always allow a sharp step to be distinguished from a very short cone.
**Before production printing, verification with a test print and comparison against the
original / the machine's actual socket, if available, is recommended.**

# Mechanical dimensions — Husqvarna 21E stitch cam drum (19/20/21A/21E family)

*(Polish original: [`DIMENSIONS.md`](DIMENSIONS.md))*

Geometry source: direct analysis of 46 high-resolution photos of the user's physical drum A (`C:\Users\Qbart\Downloads\husqvarna\`, copied into `references/`), plus annotations and corrections marked up on a test render. None of the photos include a ruler or caliper — every dimension below is a proportional estimate relative to the known diameter of nearby features, not an absolute measurement. **To be confirmed with a test print.**

## Drum geometry summary

The drum has a total axial length of **26.0 mm** (rotation axis Z). It consists of the following sections along Z:

| Z segment [mm] | Length [mm] | Radius / dimension | Feature |
|---|---:|---:|---|
| **0.0 – 0.6** | 0.6 | R = 13.9 → 14.5 mm | **Face chamfer**: a small conical bevel on the face edge (visible in IMG_20260909_074232, _081059). |
| **0.6 – 2.4** | 1.8 | R = 14.5 mm (Ø 29.0 mm) | **Grooved face disc**: 3 shallow circumferential grooves (0.35 mm wide, 0.4 mm deep). The flat face (Z=0) carries the engraved set letter ("A"), "HUSQVARNA" and "SWEDEN" text, and radial index marks. |
| **2.4 – 3.2** | 0.8 | R = 11.5 mm (Ø 23.0 mm) | **Neck**: constant-radius part of the waist separating the face disc from the main flange. |
| **3.2 – 4.4** | 1.2 | R = 11.5 → 17.03 mm | **Tapered transition from neck to main flange**: a smooth cone (not a sharp radius jump) — avoids an ~5.5 mm overhang when printed with the axis vertical. |
| **4.4 – 6.4** | 2.0 | R = 17.03 mm (Ø 34.06 mm) | **Main flange**: defines the drum's maximum outer diameter, equal to the cam teeth's crest radius (`EDGE_MAX_R`). |
| **6.4 – 26.0** | 19.6 | R = 14.50 – 17.03 mm | **Cam working section (5 positions)**: starts directly at the main flange and runs all the way to the very end of the barrel — no separate flange at the far end (photos IMG_20260909_081617, _081625 show a flat end directly behind the toothed section). 5 positions of 3.92 mm each, directly adjacent. Set A's teeth use a trapezoidal profile (`trap_wave`, 9 teeth per revolution) with flat crests and valleys (needle-stabilization dwell phases). |
| **0.0 – 26.0** | 26.0 (through) | R = 7.8 mm (Ø 15.6 mm) | **Central hole for the machine's drive shaft**: a hole running **all the way through** the drum's full length. |
| **0.0 – 26.0** | 26.0 (through) | 4.5 mm wide, 2.2 mm deep | **Keyway**: a longitudinal slot cut into the hole's wall, into which the machine shaft's key (drive spline) fits — **runs all the way through the drum's full length**, including through the face disc (user correction — an earlier version incorrectly stopped the slot short of the face). |

---

## Detailed discussion of physical corrections

Based on a direct, systematic review of all 46 photos and the user's annotated diagram (red/yellow/blue arrows), all discrepancies against earlier versions (based mainly on the reference STL from thing:6018240) were resolved:

1. **Grooved face disc (yellow arrow: "this is not a thread, and it's clearly smaller than the maximum cam amplitude")**:
   - Previously misread as a helical screw thread. It's actually a Ø 29.0 mm disc with three parallel, shallow circumferential grooves (not a helix) — clearly narrower than the toothed section.
2. **Main flange, separate from the face disc (blue arrow: "it's wider and defines the maximum diameter/amplitude of the cams")**:
   - This is NOT the engraved disc (which is narrower), but a separate, flat, intermediate collar between the neck and the toothed section. It sets the drum's maximum outer diameter, equal to the cam teeth's maximum amplitude (`FLANGE_R = EDGE_MAX_R = 17.03 mm`, Ø 34.06 mm).
3. **Continuity of the cams (red arrow: "this shouldn't exist, widen the cams to fill this space")**:
   - The unintended gap between the flange and the cams was eliminated — not by widening the cams themselves, but by replacing the sharp radius jump (11.5 → 17.03 mm) with a smooth taper in the neck, so nothing along the way is narrower than the tooth valley.
4. **Through-hole and keyway, both running the full length**:
   - The hole is not blind (as the old Thingiverse file suggested) but runs all the way through (Ø 15.6 mm) — mechanically sensible for interchangeable drums slid onto a shared machine shaft.
   - The drum has the keyway (slot); the key (drive spline) protrudes from the machine's shaft — see `tools/openscad/mating_shaft_reference.scad`. The slot **runs the full length of the drum** (user correction after re-checking the physical part — an earlier version incorrectly stopped it short of the face disc, assuming the hole stayed smooth there).
5. **Face chamfer**:
   - The face disc's edge (Z=0) has a small conical bevel, visible in several face photos.
6. **Set A's tooth shape**:
   - Set A's teeth are not sharp triangular waves but trapezoidal waves (`trap_wave`) with a flat shelf at the crest and valley (dwell), corresponding to the needle-mechanism's pause at its extreme positions while piercing the material.
7. **Cam amplitude (tooth depth)**:
   - The first photo-based version set `EDGE_MIN_R = 12.00 mm` (a 5.03 mm swing, ~29.5% of the crest radius) — after the user's correction ("the amplitude is still too big"), this was reduced to `EDGE_MIN_R = 14.50 mm` (a 2.53 mm swing, ~14.9% of the crest radius), closer to the subtle, "checkerboard" tooth texture visible in the photos than the earlier, deeper, more angular cuts.

## History of earlier versions

Earlier versions of this document described geometry derived mainly from the reference STL file (`V21ZZ3Z.stl`, thing:6018240, a third-party replica) — a multi-step mounting spindle narrowing down to ~7.75 mm, an engraved flange sharing the same diameter as the tooth crests, a screw thread on the flange, a rib protruding into the hole. After a direct, systematic review of all 46 photos of the physical drum A, it turned out the real part differs on several material points (see above) — the STL remains reliable for overall proportions (length, tooth-section reach), but not for the details of the mounting feature between the flange and the toothed section.

## Limitations of this analysis

None of the 46 photos include a ruler, caliper, or other scale reference — every dimension above is a proportional estimate relative to the known diameter of the face disc/main flange visible in the same frame, not an absolute measurement. **Verification with a test print is recommended before production printing** (start with `mating_shaft_reference.scad` — a faster, cheaper fit test for the hole and keyway than a whole drum) **and comparison against the original / the machine's actual socket, if available.**

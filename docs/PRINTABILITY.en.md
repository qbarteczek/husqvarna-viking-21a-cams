# Printability analysis and 3D print recommendations for the Husqvarna 21E drums

*(Polish original: [`PRINTABILITY.md`](PRINTABILITY.md))*

## Geometry verification status

All STL models were generated using OpenSCAD's full CGAL engine:

```
Simple: yes
```

`Simple: yes` guarantees the solids are fully closed, valid 2-manifolds (watertight), free of self-intersections or flipped normals, ready to load directly into any slicer (Bambu Studio, PrusaSlicer, Cura, OrcaSlicer).

---

## Geometry summary as it relates to printing the physical drum

1. **Print orientation**:
   - **Z axis vertical**, the drum's face (the engraved disc, Z=0) sits flat on the build plate.
   - This orientation guarantees:
     - Maximum dimensional accuracy for the cam tooth profile in the XY plane (belt/motor resolution instead of Z-layer steps).
     - A perfectly round central hole and keyway slot with no supports needed inside the hole.
     - The face disc's grooves run horizontally, creating no overhangs.
     - The toothed section runs all the way to the very end of the barrel (no separate flange at the far end) — it just ends flat, with nothing extra to print on top.

2. **No supports required**:
   - Thanks to removing the artificial gap in front of the cams (red arrow from the user's annotations) and replacing the sharp radius jump between the neck and the main flange (11.5 → 17.03 mm) with a smooth taper (`NECK_TAPER_LEN` in `cam_common.scad`), the model can be printed **entirely without supports** — there's no longer any few-millimeter, single-layer overhang that used to need support under the main flange's edge.

3. **Face chamfer (`CHAMFER_LEN`)**:
   - A small conical bevel on the top edge of the face disc (Z=0) — printed first, right at the bed; the angle is gentle (0.6 mm over a radius of ~14 mm), so it creates no overhang and no first-layer issue.

4. **Engraving on an early layer**:
   - The "HUSQVARNA", "SWEDEN", set-letter text, and index marks are cut 0.4–0.5 mm deep.
   - At a first-layer height of 0.20 mm, they'll come out as a clean, legible debossed engraving.

5. **Test pin (`mating_shaft_reference.stl`)**:
   - Before committing to a multi-hour print of the full drum, it's recommended to print the small `mating_shaft_reference.stl` test pin first.
   - The pin has a built-in assembly clearance, `SHAFT_CLEARANCE = 0.15 mm`.
   - It lets you check the fit of the Ø 15.6 mm hole and keyway against the machine's shaft in a few minutes.

---

## Recommended slicer settings

| Parameter | Recommended value | Rationale |
|---|---|---|
| **Material** | **PETG / ABS / ASA / Nylon (PA-CF)** | The part works under the constant pressure of the machine's spring-loaded follower. PLA is acceptable for geometry tests, but PETG/ABS/ASA give better long-term fatigue durability and resistance to machine oils. |
| **Layer height** | **0.12 mm – 0.16 mm** (first layer: 0.20 mm) | Thinner layers give smoother transitions on the cam teeth and less stepping in the stitch sensor's travel. |
| **Wall / perimeter count** | **4 – 5 perimeters** | The cam teeth and flanges should be nearly solid material (100% perimeters in the tooth zone). |
| **Infill** | **40% – 50% Gyroid** | Provides high isotropic stiffness and resistance to twisting under the shaft's drive torque. |
| **Cooling** | 40–60% for PETG, 100% for PLA | Keeps tooth crests sharp and even, without edge curling. |
| **Outer-wall print speed** | **30 – 45 mm/s** | A slow outer-perimeter speed drastically improves the teeth's dimensional accuracy and how smoothly the sensor rides on them. |

## History of problems found and fixed

Earlier iterations of this project went through several rounds of geometry corrections — full history in the Polish original and in `docs/DIMENSIONS.en.md`. Summary of the two biggest, most consequential fixes:

- **Wrong mechanism model** (fixed early on): an initial version modeled the stitch profile as a narrow, shallow channel cut into an otherwise full-diameter cylinder. Comparison against the real appearance of set A showed the actual mechanism is different: the cylinder's edge itself, at each of the 5 positions, IS the stitch profile (visible teeth around the full circumference) — a classic edge/plate cam, not a hidden channel.
- **Geometry based on a mismatched reference STL, corrected via direct photo analysis**: earlier versions derived the mounting geometry (between the engraved face and the toothed section) mainly from a third-party reference STL file (`V21ZZ3Z.stl`, thing:6018240). After a systematic review of all 46 photos of the user's physical drum, several structural differences emerged (see `docs/DIMENSIONS.en.md` for the full breakdown): the engraved disc is narrower than the toothed section, not the same width; there's a separate, wider intermediate flange that sets the maximum diameter; there's no separate small flange at the far end; the hole runs all the way through rather than being blind. The current geometry (`cam_common.scad`: `disc_grooved()`, `neck_section()`, `main_flange()`, `socket_cut()`) reflects the photo-based read, with the sharp radius jump between sections replaced by a smooth taper for printability.

### Auxiliary part for verifying the fit

[`tools/openscad/mating_shaft_reference.scad`](../tools/openscad/mating_shaft_reference.scad) — a simple test pin reproducing only the through-hole and its protruding key (with a small `SHAFT_CLEARANCE`), to print and check the fit **before** printing a whole drum (a faster, cheaper test than reprinting an entire cam if the key turns out to be sized wrong).

## Print orientation details

**Recommended orientation: barrel axis vertical, the engraved face disc down on the bed.**

Reasons:
- The central hole and keyway print as a clean, perpendicular-to-axis hole — no bridging.
- The transition from the neck to the main flange is now a single, smooth taper (`NECK_TAPER_LEN`) — standard, trouble-free FDM geometry without supports.
- The toothed section runs straight to the far end with no separate collar to print on top.

**Known geometric imperfection**: between adjacent stitch positions (which sit directly adjacent, with no separating collar), the edge radius can change fairly abruptly at the boundary between two positions, if one ends on a deep "valley" and the next starts at a shallow point. This is a local, single-layer effect, usually printable without supports, but it's worth inspecting these boundaries after printing and lightly cleaning them up if needed.

**No supports are needed.**

## Set-letter marking

The letter (`A`/`B`/`C`/`D`) is engraved into the flat face of the engraved disc — so in the recommended print orientation it ends up **facing the bed**. This is a deliberate, common approach (identification engraving on the underside of a print) — to read it, turn the finished part upside down. The engraving has no effect on printability (shallow, creates no overhangs).

## Steps after printing

1. Check the fit of the through-hole (with its keyway) in the machine — start with the `mating_shaft_reference.scad` auxiliary part, cheaper than a whole drum. FDM prints often come out slightly smaller than nominal (material shrinkage); lightly sand/fit as needed.
2. Check and, if needed, clean up local over-extrusion at the boundaries between adjacent stitch positions (see above).
3. Check that the sensor/follower moves smoothly along the edge — smooth out any roughness with a small needle file.
4. Compare the deflection at the "reference zigzag" position against set A — if it differs significantly, adjust `EDGE_MAX_R`/`EDGE_MIN_R` in `cam_common.scad` and reprint.

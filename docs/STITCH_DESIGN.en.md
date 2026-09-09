# Stitch patterns — sets B, C, D

*(Polish original: [`STITCH_DESIGN.md`](STITCH_DESIGN.md))*

## Disclaimer

These are **not reconstructions of historical Husqvarna Viking 21A/21E cams**. Although a
faithful reconstruction was originally planned, no source material could be found (an
instruction manual with a per-letter stitch list, photos of the original discs) — neither by
me nor by the user. Instead, **new, original patterns** were designed in the spirit of
decorative stitches from the era of mechanical sewing machines (1950s–60s), which **physically
fit** the machine because they use exactly the same mounting geometry as the measured set A
(see `DIMENSIONS.md`).

If real historical source material turns up in the future, the profiles in
`tools/openscad/cam_B.scad` etc. can be swapped out without changing the rest of the geometry
(the solid body and mounting live in a separate file, `cam_common.scad`).

## How it works

Each set has **5 axial positions** (like set A — the stitch-selector lever moves the sensor/
follower along the drum's axis), directly adjacent to each other. At each position, the
**cylinder's edge itself** has a radius that varies as a function of the rotation angle
`r(angle)` — the sensor rides directly on this edge (an edge cam, like set A — not a channel/
groove), and its sideways deflection drives the needle during sewing. Profiles are defined as
normalized functions (`-1..1`), rescaled in `cam_common.scad` to the radius range `EDGE_MAX_R`
(shallow) to `EDGE_MIN_R` (deep).

## Set B — "Waves and shells"

| Pos. | Name | Function | Character |
|---|---|---|---|
| 1 | Reference zigzag | `tri_wave(a,7)` | continuity with set A, for width comparison |
| 2 | Shell (scallop) | `saw_wave(a,5, skew=0.85)` | slow rise, sharp return — a "scale" effect |
| 3 | Wave | `sine_wave(a,6)` | smooth sine |
| 4 | Double overlock | `double_lobe(a,5)` | base wave + small second loop on the crest |
| 5 | Fine comb | `tri_wave(a,14)` | small, dense wave (a toothed effect) |

## Set C — "Open decorative stitches"

| Pos. | Name | Function | Character |
|---|---|---|---|
| 1 | Reference zigzag | `tri_wave(a,9)` | narrower variant, distinct from A and B |
| 2 | Feather | `feather(a,6)` | a series of small wiggles + one wider transition per cycle |
| 3 | Cross | `tri_wave(a,6) + 0.4·tri_wave(2a,6)` | two overlaid frequencies — an "X" look |
| 4 | Arrowhead | `arrow_sharpen(a,4,0.5)` | sharpened peaks (a flattened power curve) |
| 5 | Honeycomb | `diamond_lattice(a,6)` | two offset triangle waves — a diamond lattice |

## Set D — "Special utility stitches" (the rarest, as in the historical original)

| Pos. | Name | Function | Character |
|---|---|---|---|
| 1 | Reference zigzag (narrow) | `tri_wave(a,10)` | the narrowest of the three sets |
| 2 | Blind hem | `pulse(a,6,0.15)` | a long straight run + a single "bite" per cycle |
| 3 | Ladder | `sign(sine_wave(a,6))` | an almost square wave — two parallel "rails" |
| 4 | Reinforced triple straight | `tri_wave(a,18)` | a gentle, frequent oscillation — mimics a triple stitch |
| 5 | Closed elastic overlock | `sine_wave(a,6) + 0.3·sine_wave(3a,6)` | base wave + edge reinforcement |

## Deflection range — a hard limit, not a free tuning parameter

`EDGE_MAX_R = 17.03 mm` (tooth peaks, measured both in the STL file and in the photos) and
`EDGE_MIN_R = 12.0 mm` (tooth valleys — revised down from an initial 7.71 mm after comparing
the notch depth in photos of the physical drum A against the flange's known diameter as a
scale reference — the STL file on its own suggested deeper valleys, but that's a third-party
replica model, not the user's physical drum) in `cam_common.scad` are the **approximate, real
range of motion of the sensor/follower**. All 15 B/C/D profiles scale their amplitude WITHIN
this range (coefficients 0.3–0.9 in the tables above) — no pattern deflects the sensor beyond
these limits. Don't change these two constants without re-measuring/re-comparing against the
original — this isn't a cosmetic parameter to "feel out," just an approximation of the
mechanism's real limit (see `docs/DIMENSIONS.en.md` for the full rationale and caveats about
the accuracy of this estimate).

## Other parameters to calibrate before printing
- Stitch positions are directly adjacent, with no separating collar (`BAND_LEN` in
  `cam_common.scad`) — matching the measured structure of the original.
- The stepped mounting spindle (`mounting_neck()`), the shaft hole with its prismatic key
  (`SOCKET_R`/`SOCKET_DEPTH`/`SOCKET_KEY_*`), and the thread (`THREAD_*`) reproduce the
  measured/photographed mounting geometry of set A — see `docs/DIMENSIONS.en.md`.
- Set A now also has a native generator version (`models/generated/cam_A.scad`), independent
  of the reference STL file — it approximates the pattern described in the source (positions
  1–2 = 3-step zigzag, 3–5 = plain zigzag), but is not a faithful copy of the original edge
  track.

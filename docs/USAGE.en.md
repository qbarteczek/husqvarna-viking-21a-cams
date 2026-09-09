# Usage instructions — mounting and using stitch drums in the machine

*(Polish original: [`USAGE.md`](USAGE.md))*

Applies to sets A, B, C, D (this project — a generator) for the Husqvarna 21E and related
models (19, 20, 21A) sharing the same cam-stack mechanism.

## How it works (recap)

The drum **has no bore running its full length** — it mounts via a stepped spindle (several
diameters) and a threaded flange with a hole for the drive shaft (with a prismatic key that
transmits rotation), which fit a specific socket in the machine's mechanism (see
`docs/DIMENSIONS.en.md`). The cylinder's edge itself, at each of the 5 positions, is shaped as
the stitch profile (teeth) — the machine's sensor/follower rides directly on this edge and
converts its deflection into sideways needle motion. The stitch-selector lever on the machine
moves the sensor **along the drum's axis** to one of the 5 positions (directly adjacent, no
gap) — that selects which pattern is used.

Before mounting a whole drum, it's worth printing and testing
[`tools/openscad/mating_shaft_reference.scad`](../tools/openscad/mating_shaft_reference.scad)
— a simple pin that checks the hole and key fit, see `docs/PRINTABILITY.en.md`.

## Mounting the drum

1. Turn the machine off / unplug it before replacing the drum.
2. Remove the currently mounted drum following the machine's manual.
3. Seat the new drum (A/B/C/D) in the machine's socket — **the large, threaded flange
   (Ø 29.94 mm, the side with the letter) and the shaft hole with its key** oriented the same
   way the original was (check the orientation on the original drum before replacing it, if
   this is your first time mounting one). If the mechanism requires screwing the thread in —
   thread it gently, don't force it.
4. Make sure the stepped spindle slides freely into the machine's socket, the key properly
   engages the shaft, and the sensor/follower touches the drum's edge at each of the 5
   positions — move the stitch-selector lever through its full range **by hand, with the
   machine off**, to confirm nothing binds, before running the machine.
5. Close the cover.

## Selecting a stitch

The stitch-selector lever on the machine has 5 positions corresponding to positions 1–5
described in `docs/STITCH_DESIGN.en.md` (for B/C/D) or in the original description of set A
(positions 1–2 = 3-step zigzag, 3–5 = zigzag). Set the lever to the desired position **with
the needle stationary** (machine off, or the handwheel at rest), only then start sewing.

## First run after replacement — recommended procedure

1. Turn the handwheel through a full rotation **with no thread**, watching the needle motion —
   check that the zigzag is smooth, with no jerking or binding of the follower.
2. Test all 5 positions in turn the same way.
3. Only after confirming smooth motion at every position — thread the machine and sew a sample
   on a scrap of fabric.
4. If the stitch is narrower/wider than expected compared to set A — see the "Calibration"
   section in `docs/STITCH_DESIGN.en.md` (`EDGE_MAX_R`/`EDGE_MIN_R`) and consider reprinting.

## Safety and durability

- These are **3D prints** — they don't have the hardness/durability of the original factory
  cams (metal/bakelite). Treat this as a hobbyist/service solution, not a durable replacement
  for intensive professional use.
- Regularly check the edge (teeth) for signs of wear (abrasion) — an FDM print may wear faster
  than the original under frequent use.
- Never change the stitch-selector lever position while the needle is moving — risk of
  breaking the follower pin or the drum.
- If you feel resistance moving the lever — stop and check the drum/mechanism instead of
  forcing it.

## Reading the marking after printing

The set's letter is engraved on the underside (the Ø29.94 mm flange face, which sits on the
print bed during printing — see `docs/PRINTABILITY.en.md`). Turn the printed part upside down
to read it.

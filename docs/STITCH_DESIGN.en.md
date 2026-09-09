# Stitch Patterns — Factory Sets A1, B1, C1 and Extended Set D

## Historical Sources and Factory Specifications

The geometry and stitch profiles have been reconstructed using original factory technical documentation:
1. **Husqvarna Automatic 21 E User Manual** (`Husqvarna-21E_User-Manual_NO.pdf`):
   - Page 31: *Grunnmönster for kammene A1, B1 og C1* — official table of settings (stitch width and length) and stitch sample photographs,
   - Page 25: *Mönsternøkkelen* — pattern selection wheel for 1-needle and twin-needle (2 mm) stitching,
   - Pages 27, 29, 30: catalog numbers, cam replacement procedure on position 5,
   - Page 55: catalog listing of accessories and parts.
2. **Viking Automatic class 21 Service Manual** (`Husqvarna-Class-21_Service-Manual_EN.pdf`):
   - Section 1 (p. 1): calibration of minimum follower play at the high point of the cam (`EDGE_MAX_R = 17.03 mm`) on **position 5**,
   - Section 2 (p. 1): needle swing timing — sideways needle bar frame movement terminates when needle tip is at least 7 mm above throat plate (justifying flat dwell periods on trapezoidal tooth profiles).

---

## Operating Principle

Each drum features **5 axial positions** (`N_POS = 5`) spanning $Z \in [6.4, 23.6]\text{ mm}$ (track width `BAND_LEN = 3.44 mm`).
The stitch selector (*Mönstervelger*, 1–5 on the front dial) slides the contact follower along the camshaft axis.
The follower rides directly on the profiled outer edge:
* At maximum radius (`EDGE_MAX_R = 17.03 mm`, normalized `-1`), the needle bar rests at the far left (straight stitch baseline).
* At the tooth valley bottom (`EDGE_MIN_R = 14.20 mm`, normalized `+1`), the needle bar performs full sideways deflection to the right (radial tooth swing `EDGE_SWING = 2.83 mm`).

---

## Set A1 — Standard Drum (`S 41-10950`)

Factory standard drum supplied inside the machine (*"i maskinen"*).

| Pos. | Manual Stitch Name | Factory Setting (W / L) | Mathematical Function | Description |
|:---:|:---|:---:|:---|:---|
| **1** | **Blind hem / picot** (*Usynlig faldsöm / Picot*) | 4 / 0.3 | `blind_hem(a, 3, 0.20)` | 4–5 straight stitches on left + single spike to right for blind hems. |
| **2** | **3-step elastic zig-zag** (*Trestings siksak / Quick-Stopp*) | 4 / 0.3 | `three_step_zigzag(a, 3)` | 3 steps right, 3 steps left — knit joining, elastic insertion, mending. |
| **3** | **Wide zig-zag** | 4 / 1.0 | `trap_wave(a, 9, 0.28) * 0.95` | Extended pitch zig-zag for seam finishing. |
| **4** | **Dense darning zig-zag** | 4 / 0.3 | `trap_wave(a, 9, 0.28) * 0.80` | Fine satin stitch. |
| **5** | **Standard reference zig-zag** | 4 / 1.5 | `trap_wave(a, 9, 0.28) * 0.95` | Mechanism rest/zero position, baseline for cam removal. |

---

## Set B1 — Accessory Drum (`S 41-10951`)

Decorative and curved wavy stitch set.

| Pos. | Manual Stitch Name | Factory Setting (W / L) | Mathematical Function | Description |
|:---:|:---|:---:|:---|:---|
| **1** | **Serpentine / wavy stitch** (*Slangesöm*) | 4 / 1.5 | `sine_wave(a, 3) * 0.90` | Smooth sine wave with gentle curves. |
| **2** | **Stepped chevron / dense wave** | 4 / 0.3 | `tri_wave(a, 3)*0.70 + tri_wave(a, 18)*0.25` | Angled wave combined with fine micro-teeth. |
| **3** | **Satin diamond / leaf / pearls** (*Diamantsöm*) | 4 / 0.3 | `diamond_satin(a, 18, 3)` | Amplitude-modulated satin zigzag expanding and tapering into diamonds. |
| **4** | **Angled teeth / saw** (*Tannsöm*) | 4 / 0.3 | `saw_wave(a, 6, 0.80) * 0.90` | Asymmetrical sawtooth wave with steep return. |
| **5** | **Standard reference zig-zag** | 4 / 1.5 | `trap_wave(a, 9, 0.28) * 0.95` | Rest position and reference track. |

---

## Set C1 — Accessory Drum (`S 41-10952`)

Geometric and meander stitch set.

| Pos. | Manual Stitch Name | Factory Setting (W / L) | Mathematical Function | Description |
|:---:|:---|:---:|:---|:---|
| **1** | **Greek key / crenelated meander** (*Mekaniskt meander / Tinn*) | 4 / 0.3 | `trap_wave(a, 4, 0.45) * 0.90` | Rectangular crenelations with dense coverage. |
| **2** | **Flame stitch / sharp triangle** (*Flammesöm*) | 4 / 0.3 | `arrow_sharpen(a, 6, 0.50) * 0.90` | Sharpened triangular teeth. |
| **3** | **Satin blocks** (*Blokksöm*) | 4 / 0.3 | `block_satin(a, 16, 4)` | Alternating left/right shifted rectangular satin panels. |
| **4** | **Hourglass / double diamond** | 4 / 0.3 | `hourglass_satin(a, 18, 3)` | Symmetrical taper creating an hourglass shape. |
| **5** | **Standard reference zig-zag** | 4 / 1.5 | `trap_wave(a, 9, 0.28) * 0.95` | Rest position and reference track. |

---

## Set D — Extended / Experimental Set

Experimental custom utility set.

| Pos. | Stitch Name | Settings (W / L) | Mathematical Function | Description |
|:---:|:---|:---:|:---|:---|
| **1** | **Narrow reference zig-zag** | 2 / 1.0 | `tri_wave(a, 10) * 0.40` | Fine precision zig-zag. |
| **2** | **Reinforced blind stitch** | 4 / 0.5 | `blind_hem(a, 4, 0.15)` | Sparsely spaced lateral bites. |
| **3** | **Ladder stitch** | 4 / 0.5 | `sign(sine_wave(a, 6)) * 0.85` | Dual parallel rails with abrupt shifts. |
| **4** | **Triple stretch straight** | 1 / 1.5 | `tri_wave(a, 18) * 0.30` | Fast micro-oscillation for seam strength. |
| **5** | **Standard reference zig-zag** | 4 / 1.5 | `trap_wave(a, 9, 0.28) * 0.95` | Rest position. |

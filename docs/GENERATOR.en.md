# Husqvarna 21E Stitch Drum Generator User Guide

This project includes a universal, parametric stitch drum generation system featuring a built-in catalog of over 35 pre-verified patterns (utility, stretch, decorative waves, modulated satin, meanders, and geometric checkerboards).

---

## 3 Ways to Use the Generator

### Method 1: OpenSCAD Customizer GUI (No coding required)

The recommended native method for desktop users:
1. Open free [OpenSCAD](https://openscad.org/) (version 2021.01 or newer).
2. Open the file [`tools/openscad/cam_generator.scad`](../tools/openscad/cam_generator.scad).
3. Enable the GUI parameter panel: **Window -> Customizer** (or uncheck *Hide Customizer*).
4. The panel provides intuitive controls:
   * **Drum_Letter:** enter the letter engraved on the front face (e.g. `E`, `M`, `S`),
   * **Position_1 .. Position_5:** select any stitch from the dropdown menus (0–35),
   * *(Note: position 5 is recommended to remain as standard zigzag `4`, serving as the resting baseline for cam installation).*
5. Press **F6** (Render), then **F7** (Export as STL).

---

### Method 2: Visual Web Application in Browser (`tools/generator/index.html`)

A 100% client-side web application suitable for local use or hosting on GitHub Pages:
1. Open [`tools/generator/index.html`](../tools/generator/index.html) in any browser (Chrome, Edge, Firefox).
2. Features:
   * **Live Fabric Sewing Simulation:** Real-time multi-track needle path rendering on fabric canvas,
   * **Visual 36-Stitch Catalog:** Filter by category (Utility, Decorative, Satin, Geometric) with live mini-wave cards,
   * **Factory Presets:** Quick one-click setups for `Set A1`, `Set B1`, `Set C1`, `Set D`.
3. Click any track slot 1–5, then click the desired stitch from the catalog.
4. Click **"Download .SCAD File"** to save your custom drum model.

---

### Method 3: PowerShell CLI Batch Generator (`tools/generator/generate_drum.ps1`)

Automated script for headless generation and compilation:
```powershell
.\tools\generator\generate_drum.ps1 -Letter "E" -Pos1 1 -Pos2 14 -Pos3 23 -Pos4 29 -Pos5 4 -ExportSTL
```
The resulting `cam_E.stl` will be generated in `models/generated/`.

---

## Complete Stitch Catalog Reference (`stitch_catalog.scad`)

| ID | Key | Pattern Name | Category | Factory Source |
|:---:|:---|:---|:---:|:---:|
| **0** | `straight` | Straight Stitch | Utility | — |
| **1** | `blind_hem_std` | Blind Hem Standard | Utility | A1 (pos. 1) |
| **2** | `blind_hem_dense` | Blind Hem Dense (4c) | Utility | — |
| **3** | `blind_hem_wide` | Blind Hem Wide | Utility | — |
| **4** | `zigzag_std` | Standard Reference Zigzag | Utility | A1/B1/C1 (pos. 5) |
| **5** | `zigzag_wide` | Wide Zigzag | Utility | A1 (pos. 3) |
| **6** | `zigzag_narrow` | Narrow Precision Zigzag | Utility | — |
| **7** | `zigzag_satin` | Dense Darning Satin | Utility | A1 (pos. 4) |
| **8** | `three_step_elastic` | 3-Step Elastic Zigzag | Utility | A1 (pos. 2) |
| **9** | `four_step_elastic` | 4-Step Super Stretch | Utility | — |
| **10** | `overlock_open` | Open Stretch Overlock | Utility | — |
| **11** | `overlock_closed` | Closed Elastic Overlock | Utility | — |
| **12** | `triple_stretch` | Triple Stretch Straight | Utility | — |
| **13** | `ladder` | Ladder / Darning Stitch | Utility | — |
| **14** | `serpentine_wide` | Wide Serpentine Wave (3c) | Decorative | B1 (pos. 1) |
| **15** | `serpentine_med` | Medium Serpentine Wave (4c) | Decorative | — |
| **16** | `serpentine_dense` | Dense Serpentine Wave (6c) | Decorative | — |
| **17** | `scallop_wave` | Scallop / Shell Wave | Decorative | — |
| **18** | `double_lobe` | Double Lobe Wave | Decorative | — |
| **19** | `feather` | Feather Stitch | Decorative | — |
| **20** | `stepped_chevron` | Stepped Chevron Wave | Decorative | B1 (pos. 2) |
| **21** | `angled_teeth` | Angled Teeth / Saw | Decorative | B1 (pos. 4) |
| **22** | `fine_comb` | Fine Comb Wave (14c) | Decorative | — |
| **23** | `diamond_satin_3` | Diamond Satin Leaf (3c) | Satin | B1 (pos. 3) |
| **24** | `diamond_satin_4` | Dense Diamond Satin (4c) | Satin | — |
| **25** | `pearl_beads` | Pearl Beads Satin | Satin | — |
| **26** | `hourglass_satin` | Hourglass Satin | Satin | C1 (pos. 4) |
| **27** | `flame_satin` | Flame Satin | Satin | C1 (pos. 2) |
| **28** | `taper_satin` | Tapering Satin Wedge | Satin | — |
| **29** | `greek_key_4` | Greek Key Meander (4c) | Geometric | C1 (pos. 1) |
| **30** | `greek_key_5` | Greek Key Meander (5c) | Geometric | — |
| **31** | `satin_blocks` | Alternating Satin Blocks | Geometric | C1 (pos. 3) |
| **32** | `checker_step` | Checkerboard Step | Geometric | — |
| **33** | `cross_stitch` | Geometric Cross Stitch | Geometric | — |
| **34** | `arrowhead` | Sharp Arrowhead | Geometric | — |
| **35** | `honeycomb` | Honeycomb Lattice | Geometric | — |

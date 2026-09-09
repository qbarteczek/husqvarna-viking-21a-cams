// ==============================================================================
// KATALOG ŚCIEGÓW HUSQVARNA 21E / STITCH CATALOG
// ==============================================================================
// Biblioteka ponad 35 zweryfikowanych funkcji matematycznych profili ściegowych.
// Każda funkcja przyjmuje kąt obrotu wałka `a` [stopnie, 0..360] i zwraca
// znormalizowane wychylenie w zakresie [-1, 1]:
//   -1: promień maksymalny (EDGE_MAX_R = 17.03 mm) -> igła po lewej (ścieg prosty)
//   +1: promień minimalny  (EDGE_MIN_R = 14.20 mm) -> igła po prawej (pełne wychylenie)
// ==============================================================================

include <cam_common.scad>

// --- Grupa I: Ściegi użytkowe i elastyczne ---
function stitch_straight(a) = -1.0;
function stitch_blind_hem_std(a) = blind_hem(a, 3, 0.20);
function stitch_blind_hem_dense(a) = blind_hem(a, 4, 0.16);
function stitch_blind_hem_wide(a) = blind_hem(a, 3, 0.28);
function stitch_zigzag_std(a) = trap_wave(a, 9, 0.28) * 0.95;
function stitch_zigzag_wide(a) = trap_wave(a, 6, 0.30) * 0.95;
function stitch_zigzag_narrow(a) = trap_wave(a, 10, 0.25) * 0.40;
function stitch_zigzag_satin(a) = trap_wave(a, 18, 0.20) * 0.85;
function stitch_three_step_elastic(a) = three_step_zigzag(a, 3);
function stitch_four_step_elastic(a) =
    let(t = (a*3/360) - floor(a*3/360), step = floor(t * 8))
    (step < 4 ? -0.9 + step * 0.6 : 0.9 - (step - 4) * 0.6);
function stitch_overlock_open(a) = (sine_wave(a, 4) * 0.6 + blind_hem(a, 4, 0.20) * 0.4);
function stitch_overlock_closed(a) = (sine_wave(a, 6) + 0.3*sine_wave(a, 18)) / 1.3 * 0.85;
function stitch_triple_stretch(a) = tri_wave(a, 18) * 0.35;
function stitch_ladder(a) = sign(sine_wave(a, 6)) * 0.85;

// --- Grupa II: Ściegi ozdobne faliste i organiczne ---
function stitch_serpentine_wide(a) = sine_wave(a, 3) * 0.90;
function stitch_serpentine_med(a) = sine_wave(a, 4) * 0.85;
function stitch_serpentine_dense(a) = sine_wave(a, 6) * 0.80;
function stitch_scallop_wave(a) = saw_wave(a, 5, 0.85) * 0.90;
function stitch_double_lobe(a) = double_lobe(a, 5) * 0.90;
function stitch_feather(a) = feather(a, 6) * 0.85;
function stitch_stepped_chevron(a) = (tri_wave(a, 3) * 0.70 + tri_wave(a, 18) * 0.25);
function stitch_angled_teeth(a) = saw_wave(a, 6, 0.80) * 0.90;
function stitch_fine_comb(a) = tri_wave(a, 14) * 0.50;

// --- Grupa III: Ściegi satynowe modulowane ---
function stitch_diamond_satin_3(a) = diamond_satin(a, 18, 3);
function stitch_diamond_satin_4(a) = diamond_satin(a, 20, 4);
function stitch_pearl_beads(a) =
    let(env = pow(sin(a*3/2), 2))
    trap_wave(a, 18, 0.20) * (env * 0.80 + 0.15);
function stitch_hourglass_satin(a) = hourglass_satin(a, 18, 3);
function stitch_flame_satin(a) =
    let(env = (1 - cos(a*4))/2)
    arrow_sharpen(a, 16, 0.6) * (env * 0.75 + 0.20);
function stitch_taper_satin(a) =
    let(t = (a*3/360) - floor(a*3/360))
    trap_wave(a, 18, 0.22) * (t * 0.80 + 0.15);

// --- Grupa IV: Ściegi geometryczne i meandrowe ---
function stitch_greek_key_4(a) = trap_wave(a, 4, 0.45) * 0.90;
function stitch_greek_key_5(a) = trap_wave(a, 5, 0.45) * 0.90;
function stitch_satin_blocks(a) = block_satin(a, 16, 4);
function stitch_checker_step(a) =
    let(t = (a*4/360) - floor(a*4/360))
    (t < 0.5 ? (tri_wave(a, 16)*0.4 + 0.5) : (tri_wave(a, 16)*0.4 - 0.5));
function stitch_cross_stitch(a) = (tri_wave(a, 6) + 0.4*tri_wave(a*2, 6)) / 1.4 * 0.85;
function stitch_arrowhead(a) = arrow_sharpen(a, 6, 0.50) * 0.90;
function stitch_honeycomb(a) = diamond_lattice(a, 6) * 0.80;

// ==============================================================================
// DYSPOZYTOR ŚCIEGU WG ID (0 .. 35)
// ==============================================================================
function get_stitch_by_id(id, a) =
    (id == 0)  ? stitch_straight(a) :
    (id == 1)  ? stitch_blind_hem_std(a) :
    (id == 2)  ? stitch_blind_hem_dense(a) :
    (id == 3)  ? stitch_blind_hem_wide(a) :
    (id == 4)  ? stitch_zigzag_std(a) :
    (id == 5)  ? stitch_zigzag_wide(a) :
    (id == 6)  ? stitch_zigzag_narrow(a) :
    (id == 7)  ? stitch_zigzag_satin(a) :
    (id == 8)  ? stitch_three_step_elastic(a) :
    (id == 9)  ? stitch_four_step_elastic(a) :
    (id == 10) ? stitch_overlock_open(a) :
    (id == 11) ? stitch_overlock_closed(a) :
    (id == 12) ? stitch_triple_stretch(a) :
    (id == 13) ? stitch_ladder(a) :
    (id == 14) ? stitch_serpentine_wide(a) :
    (id == 15) ? stitch_serpentine_med(a) :
    (id == 16) ? stitch_serpentine_dense(a) :
    (id == 17) ? stitch_scallop_wave(a) :
    (id == 18) ? stitch_double_lobe(a) :
    (id == 19) ? stitch_feather(a) :
    (id == 20) ? stitch_stepped_chevron(a) :
    (id == 21) ? stitch_angled_teeth(a) :
    (id == 22) ? stitch_fine_comb(a) :
    (id == 23) ? stitch_diamond_satin_3(a) :
    (id == 24) ? stitch_diamond_satin_4(a) :
    (id == 25) ? stitch_pearl_beads(a) :
    (id == 26) ? stitch_hourglass_satin(a) :
    (id == 27) ? stitch_flame_satin(a) :
    (id == 28) ? stitch_taper_satin(a) :
    (id == 29) ? stitch_greek_key_4(a) :
    (id == 30) ? stitch_greek_key_5(a) :
    (id == 31) ? stitch_satin_blocks(a) :
    (id == 32) ? stitch_checker_step(a) :
    (id == 33) ? stitch_cross_stitch(a) :
    (id == 34) ? stitch_arrowhead(a) :
    (id == 35) ? stitch_honeycomb(a) :
    stitch_zigzag_std(a);

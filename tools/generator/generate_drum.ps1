<#
.SYNOPSIS
    Generator bębnów ściegowych Husqvarna 21E z wiersza poleceń PowerShell.
.DESCRIPTION
    Generuje plik .scad w formacie identycznym z modelami projektu (cam_A, cam_B, cam_C, cam_D)
    oraz opcjonalnie kompiluje gotowy plik .stl do druku 3D.
.EXAMPLE
    .\generate_drum.ps1 -Preset "B1"
    .\generate_drum.ps1 -Letter "E" -Pos1 1 -Pos2 14 -Pos3 23 -Pos4 29 -Pos5 4 -ExportSTL
#>

param(
    [string]$Preset = "",
    [string]$Letter = "E",
    [int]$Pos1 = 1,
    [int]$Pos2 = 14,
    [int]$Pos3 = 23,
    [int]$Pos4 = 29,
    [int]$Pos5 = 4,
    [switch]$ExportSTL,
    [string]$OutputDir = "$PSScriptRoot\..\..\models\generated"
)

# Słownik ściegów: id -> @{ Name = "..."; Formula = "..." }
$stitchDefs = @{
    0  = @{ Name = "Ścieg prosty zerowy"; Formula = "-1.0" }
    1  = @{ Name = "Ścieg kryty / brzegowy (A1)"; Formula = "blind_hem(a, 3, 0.20)" }
    2  = @{ Name = "Ścieg kryty gęsty"; Formula = "blind_hem(a, 4, 0.16)" }
    3  = @{ Name = "Ścieg kryty szeroki"; Formula = "blind_hem(a, 3, 0.28)" }
    4  = @{ Name = "Zygzak standardowy referencyjny / spoczynkowy"; Formula = "trap_wave(a, 9, 0.28) * 0.95" }
    5  = @{ Name = "Zygzak szeroki (A1 poz. 3)"; Formula = "trap_wave(a, 9, 0.28) * 0.95" }
    6  = @{ Name = "Zygzak wąski precyzyjny (D poz. 1)"; Formula = "tri_wave(a, 10) * 0.40" }
    7  = @{ Name = "Zygzak gęsty satynowy (A1 poz. 4)"; Formula = "trap_wave(a, 9, 0.28) * 0.80" }
    8  = @{ Name = "Zygzak 3-stopniowy elastyczny (A1 poz. 2)"; Formula = "three_step_zigzag(a, 3)" }
    9  = @{ Name = "Zygzak 4-stopniowy elastyczny"; Formula = "let(t = (a*3/360) - floor(a*3/360), step = floor(t * 8)) (step < 4 ? -0.9 + step * 0.6 : 0.9 - (step - 4) * 0.6)" }
    10 = @{ Name = "Owerlok otwarty"; Formula = "(sine_wave(a, 4) * 0.6 + blind_hem(a, 4, 0.20) * 0.4)" }
    11 = @{ Name = "Owerlok elastyczny zamknięty"; Formula = "(sine_wave(a, 6) + 0.3*sine_wave(a, 18)) / 1.3 * 0.85" }
    12 = @{ Name = "Potrójny elastyczny prosty (D poz. 4)"; Formula = "tri_wave(a, 18) * 0.30" }
    13 = @{ Name = "Drabinka cerująca (D poz. 3)"; Formula = "sign(sine_wave(a, 6)) * 0.85" }
    14 = @{ Name = "Ścieg serpentynowy / fala płynna (B1 poz. 1)"; Formula = "sine_wave(a, 3) * 0.90" }
    15 = @{ Name = "Serpentyna średnia"; Formula = "sine_wave(a, 4) * 0.85" }
    16 = @{ Name = "Serpentyna gęsta"; Formula = "sine_wave(a, 6) * 0.80" }
    17 = @{ Name = "Muszelka łuskowa"; Formula = "saw_wave(a, 5, 0.85) * 0.90" }
    18 = @{ Name = "Podwójna pętla"; Formula = "double_lobe(a, 5) * 0.90" }
    19 = @{ Name = "Piórko gałązkowe"; Formula = "feather(a, 6) * 0.85" }
    20 = @{ Name = "Jodełka schodkowa / fala łamana (B1 poz. 2)"; Formula = "(tri_wave(a, 3) * 0.70 + tri_wave(a, 18) * 0.25)" }
    21 = @{ Name = "Ząbki skośne piła (B1 poz. 4)"; Formula = "saw_wave(a, 6, 0.80) * 0.90" }
    22 = @{ Name = "Grzebyk drobny"; Formula = "tri_wave(a, 14) * 0.50" }
    23 = @{ Name = "Satynowy romb / perełki (B1 poz. 3)"; Formula = "diamond_satin(a, 18, 3)" }
    24 = @{ Name = "Satynowy romb gęsty (4 cykle)"; Formula = "diamond_satin(a, 20, 4)" }
    25 = @{ Name = "Perełki satynowe"; Formula = "let(env = pow(sin(a*3/2), 2)) trap_wave(a, 18, 0.20) * (env * 0.80 + 0.15)" }
    26 = @{ Name = "Klepsydra / podwójny romb (C1 poz. 4)"; Formula = "hourglass_satin(a, 18, 3)" }
    27 = @{ Name = "Ścieg płomieniowy ostry (C1 poz. 2)"; Formula = "arrow_sharpen(a, 6, 0.50) * 0.90" }
    28 = @{ Name = "Stożek satynowy"; Formula = "let(t = (a*3/360) - floor(a*3/360)) trap_wave(a, 18, 0.22) * (t * 0.80 + 0.15)" }
    29 = @{ Name = "Meander grecki / baszty (C1 poz. 1)"; Formula = "trap_wave(a, 4, 0.45) * 0.90" }
    30 = @{ Name = "Meander grecki gęsty (5 cykli)"; Formula = "trap_wave(a, 5, 0.45) * 0.90" }
    31 = @{ Name = "Bloki satynowe prostokątne (C1 poz. 3)"; Formula = "block_satin(a, 16, 4)" }
    32 = @{ Name = "Szachownica schodkowa"; Formula = "let(t = (a*4/360) - floor(a*4/360)) (t < 0.5 ? (tri_wave(a, 16)*0.4 + 0.5) : (tri_wave(a, 16)*0.4 - 0.5))" }
    33 = @{ Name = "Krzyżyki"; Formula = "(tri_wave(a, 6) + 0.4*tri_wave(a*2, 6)) / 1.4 * 0.85" }
    34 = @{ Name = "Strzałka ostra"; Formula = "arrow_sharpen(a, 6, 0.50) * 0.90" }
    35 = @{ Name = "Plaster miodu"; Formula = "diamond_lattice(a, 6) * 0.80" }
}

# Obsługa presetów
if ($Preset -eq "A1" -or $Preset -eq "A") {
    $Letter = "A"; $Pos1 = 1; $Pos2 = 8; $Pos3 = 5; $Pos4 = 7; $Pos5 = 4
} elseif ($Preset -eq "B1" -or $Preset -eq "B") {
    $Letter = "B"; $Pos1 = 14; $Pos2 = 20; $Pos3 = 23; $Pos4 = 21; $Pos5 = 4
} elseif ($Preset -eq "C1" -or $Preset -eq "C") {
    $Letter = "C"; $Pos1 = 29; $Pos2 = 27; $Pos3 = 31; $Pos4 = 26; $Pos5 = 4
} elseif ($Preset -eq "D") {
    $Letter = "D"; $Pos1 = 6; $Pos2 = 1; $Pos3 = 13; $Pos4 = 12; $Pos5 = 4
}

$Letter = $Letter.ToUpper().Trim()
$prefix = $Letter.ToLower()
$scadFile = Join-Path $OutputDir "cam_$Letter.scad"
$stlFile = Join-Path $OutputDir "cam_$Letter.stl"

$s1 = $stitchDefs[$Pos1]; if (-not $s1) { $s1 = $stitchDefs[1] }
$s2 = $stitchDefs[$Pos2]; if (-not $s2) { $s2 = $stitchDefs[14] }
$s3 = $stitchDefs[$Pos3]; if (-not $s3) { $s3 = $stitchDefs[23] }
$s4 = $stitchDefs[$Pos4]; if (-not $s4) { $s4 = $stitchDefs[29] }
$s5 = $stitchDefs[$Pos5]; if (-not $s5) { $s5 = $stitchDefs[4] }

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " Generator Bębnów Ściegowych Husqvarna 21E" -ForegroundColor White
Write-Host " Wzorowany wprost na modelach projektu krzywki-do-husqvarna-gemini" -ForegroundColor Gray
Write-Host " Litera bębna: $Letter" -ForegroundColor Yellow
Write-Host " 1: $($s1.Name) -> $($s1.Formula)" -ForegroundColor Green
Write-Host " 2: $($s2.Name) -> $($s2.Formula)" -ForegroundColor Green
Write-Host " 3: $($s3.Name) -> $($s3.Formula)" -ForegroundColor Green
Write-Host " 4: $($s4.Name) -> $($s4.Formula)" -ForegroundColor Green
Write-Host " 5: $($s5.Name) -> $($s5.Formula)" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan

$code = @"
// ==============================================================================
// Bęben ściegowy $Letter dla Husqvarna 21E / 21A.
// Wygenerowano za pomocą generatora projektu krzywki-do-husqvarna-gemini.
//
// Poz 1: $($s1.Name)
// Poz 2: $($s2.Name)
// Poz 3: $($s3.Name)
// Poz 4: $($s4.Name)
// Poz 5: $($s5.Name)
// ==============================================================================
include <../../tools/openscad/cam_common.scad>

function ${prefix}_pos1(a) = $($s1.Formula);
function ${prefix}_pos2(a) = $($s2.Formula);
function ${prefix}_pos3(a) = $($s3.Formula);
function ${prefix}_pos4(a) = $($s4.Formula);
function ${prefix}_pos5(a) = $($s5.Formula);

cam_with_grooves("$Letter", [
    function(a) ${prefix}_pos1(a),
    function(a) ${prefix}_pos2(a),
    function(a) ${prefix}_pos3(a),
    function(a) ${prefix}_pos4(a),
    function(a) ${prefix}_pos5(a),
]);
"@

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($scadFile, $code, $utf8NoBom)
Write-Host "[OK] Utworzono plik OpenSCAD zgodny z modelami repozytorium: $scadFile" -ForegroundColor Green

if ($ExportSTL) {
    $openscadExe = "C:\Program Files\OpenSCAD\openscad.com"
    if (-not (Test-Path $openscadExe)) {
        $openscadExe = "openscad"
    }

    Write-Host "[...] Renderowanie siatki 3D do formatu STL: $stlFile" -ForegroundColor Yellow
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    & $openscadExe -o $stlFile $scadFile
    $sw.Stop()

    if (Test-Path $stlFile) {
        $size = (Get-Item $stlFile).Length / 1MB
        Write-Host ("[OK] Wyrenderowano bryłę STL: {0:N2} MB w {1:N1} s" -f $size, $sw.Elapsed.TotalSeconds) -ForegroundColor Green
    } else {
        Write-Error "Błąd podczas renderowania pliku STL!"
    }
}


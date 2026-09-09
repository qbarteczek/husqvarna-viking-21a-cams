<#
.SYNOPSIS
    Generator bębnów ściegowych Husqvarna 21E z wiersza poleceń PowerShell.
.DESCRIPTION
    Generuje plik .scad oraz opcjonalnie kompiluje gotowy plik .stl do druku 3D
    na podstawie 5 wybranych ściegów z katalogu stitch_catalog.scad.
.EXAMPLE
    .\generate_drum.ps1 -Letter "E" -Pos1 1 -Pos2 14 -Pos3 23 -Pos4 29 -Pos5 4 -ExportSTL
#>

param(
    [string]$Letter = "E",
    [int]$Pos1 = 1,
    [int]$Pos2 = 14,
    [int]$Pos3 = 23,
    [int]$Pos4 = 29,
    [int]$Pos5 = 4,
    [switch]$ExportSTL,
    [string]$OutputDir = "$PSScriptRoot\..\..\models\generated"
)

$Letter = $Letter.ToUpper().Trim()
$scadFile = Join-Path $OutputDir "cam_$Letter.scad"
$stlFile = Join-Path $OutputDir "cam_$Letter.stl"

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " Generator Bębnów Ściegowych Husqvarna 21E" -ForegroundColor White
Write-Host " Litera bębna: $Letter" -ForegroundColor Yellow
Write-Host " Pozycje: 1=$Pos1, 2=$Pos2, 3=$Pos3, 4=$Pos4, 5=$Pos5" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan

$code = @"
// ==============================================================================
// BĘBEN ŚCIEGOWY HUSQVARNA 21E — ZESTAW $Letter
// Wygenerowano automatycznie za pomocą generate_drum.ps1
// ==============================================================================
include <../../tools/openscad/cam_common.scad>
include <../../tools/openscad/stitch_catalog.scad>

function pos1(a) = get_stitch_by_id($Pos1, a);
function pos2(a) = get_stitch_by_id($Pos2, a);
function pos3(a) = get_stitch_by_id($Pos3, a);
function pos4(a) = get_stitch_by_id($Pos4, a);
function pos5(a) = get_stitch_by_id($Pos5, a);

cam_with_grooves("$Letter", [
    function(a) pos1(a),
    function(a) pos2(a),
    function(a) pos3(a),
    function(a) pos4(a),
    function(a) pos5(a)
]);
"@

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($scadFile, $code, $utf8NoBom)
Write-Host "[OK] Utworzono plik OpenSCAD: $scadFile" -ForegroundColor Green

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

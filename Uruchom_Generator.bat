@echo off
chcp 65001 >nul
title Generator Bebnow Sciegowych Husqvarna 21E
echo ============================================================
echo  Uruchamianie Studia Projektowania Bebnow Sciegowych...
echo  Husqvarna Viking 21E / 21A
echo ============================================================
echo.
echo Otwieranie aplikacji w domyslnej przegladarce...
if exist "%~dp0index.html" (
    start "" "%~dp0index.html"
) else (
    start "" "%~dp0tools\generator\index.html"
)
exit

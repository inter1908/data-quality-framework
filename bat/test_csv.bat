@echo off
REM ═══════════════════════════════════════════════════════════════════════════════
REM TEST CSV - Data Quality Framework
REM ═══════════════════════════════════════════════════════════════════════════════
REM 👤 AUTORE: Alberto Robetti
REM 📅 DATA: 12 Novembre 2025
REM 🎯 SCOPO: Esegue test completo validazione file CSV demo
REM ═══════════════════════════════════════════════════════════════════════════════

echo.
echo ═══════════════════════════════════════════════════════════════════════════════
echo   DATA QUALITY FRAMEWORK v1.0.0 - TEST CSV
echo ═══════════════════════════════════════════════════════════════════════════════
echo.

REM Vai alla directory root del progetto
cd /d "%~dp0.."

REM Verifica che l'eseguibile esista
if not exist "bin\DataQualityFramework.exe" (
    echo ❌ ERRORE: Eseguibile non trovato in bin\DataQualityFramework.exe
    pause
    exit /b 1
)

echo 📋 Informazioni Sistema:
echo 📁 Directory corrente: %CD%
echo 🔧 Eseguibile: bin\DataQualityFramework.exe
echo.

REM Pulisci output precedenti (opzionale - commentare se si vuole mantenere storico)
echo 🧹 Pulizia output precedenti...
if exist "demo\csv\output\success\*.ok" del /Q "demo\csv\output\success\*.ok" 2>nul
if exist "demo\csv\output\error\*.ko" del /Q "demo\csv\output\error\*.ko" 2>nul
if exist "demo\csv\output\report\*.codici" del /Q "demo\csv\output\report\*.codici" 2>nul
if exist "demo\csv\output\statistics\*.stats" del /Q "demo\csv\output\statistics\*.stats" 2>nul
echo ✅ Pulizia completata
echo.

REM Esegui test CSV
echo ═══════════════════════════════════════════════════════════════════════════════
echo 🚀 ESECUZIONE TEST CSV - Flusso DIPENDENTI_CSV
echo ═══════════════════════════════════════════════════════════════════════════════
echo.

bin\DataQualityFramework.exe DIPENDENTI_CSV

REM Verifica exit code
if errorlevel 1 (
    echo.
    echo ═══════════════════════════════════════════════════════════════════════════════
    echo ❌ TEST FALLITO - Exit code: %ERRORLEVEL%
    echo ═══════════════════════════════════════════════════════════════════════════════
    echo.
    echo 📋 Verifica log in: log\
    echo.
    pause
    exit /b %ERRORLEVEL%
)

REM Mostra risultati
echo.
echo ═══════════════════════════════════════════════════════════════════════════════
echo ✅ TEST COMPLETATO CON SUCCESSO
echo ═══════════════════════════════════════════════════════════════════════════════
echo.
echo 📊 Verifica output generati:
echo.

REM Conta file generati
set /a count_ok=0
set /a count_ko=0
set /a count_codici=0
set /a count_stats=0

for %%f in ("demo\csv\output\success\*.ok") do set /a count_ok+=1
for %%f in ("demo\csv\output\error\*.ko") do set /a count_ko+=1
for %%f in ("demo\csv\output\report\*.codici") do set /a count_codici+=1
for %%f in ("demo\csv\output\statistics\*.stats") do set /a count_stats+=1

echo   ✅ File validati (.ok):           %count_ok%
if %count_ok% GTR 0 dir /B "demo\csv\output\success\*.ok"
echo.

echo   ❌ File scartati (.ko):           %count_ko%
if %count_ko% GTR 0 dir /B "demo\csv\output\error\*.ko"
echo.

echo   📋 Anagrafica errori (.codici):   %count_codici%
if %count_codici% GTR 0 dir /B "demo\csv\output\report\*.codici"
echo.

echo   📊 Report statistiche (.stats):   %count_stats%
if %count_stats% GTR 0 dir /B "demo\csv\output\statistics\*.stats"
echo.

REM Mostra ultimo log
echo ═══════════════════════════════════════════════════════════════════════════════
echo 📜 ULTIMO LOG GENERATO
echo ═══════════════════════════════════════════════════════════════════════════════
echo.

for /f "delims=" %%f in ('dir /b /o-d "log\*.log" 2^>nul') do (
    echo 📁 File: log\%%f
    echo.
    echo 📄 Ultime 20 righe:
    powershell -Command "Get-Content 'log\%%f' -Tail 20"
    goto :show_actions
)

:show_actions
echo.
echo ═══════════════════════════════════════════════════════════════════════════════
echo 🎯 AZIONI DISPONIBILI
echo ═══════════════════════════════════════════════════════════════════════════════
echo.
echo   1. Visualizza file .ko (scartati)
echo   2. Visualizza anagrafica codici (.codici)
echo   3. Visualizza statistiche (.stats)
echo   4. Apri directory output
echo   5. Esci
echo.

choice /C 12345 /N /M "Scegli azione [1-5]: "

if errorlevel 5 goto :end
if errorlevel 4 (
    start explorer "demo\csv\output"
    goto :show_actions
)
if errorlevel 3 (
    for /f "delims=" %%f in ('dir /b /o-d "demo\csv\output\statistics\*.stats" 2^>nul') do (
        type "demo\csv\output\statistics\%%f"
        echo.
        pause
        goto :show_actions
    )
)
if errorlevel 2 (
    for /f "delims=" %%f in ('dir /b /o-d "demo\csv\output\report\*.codici" 2^>nul') do (
        type "demo\csv\output\report\%%f"
        echo.
        pause
        goto :show_actions
    )
)
if errorlevel 1 (
    for /f "delims=" %%f in ('dir /b /o-d "demo\csv\output\error\*.ko" 2^>nul') do (
        type "demo\csv\output\error\%%f"
        echo.
        pause
        goto :show_actions
    )
)

:end
echo.
echo ═══════════════════════════════════════════════════════════════════════════════
echo   Test CSV completato. Grazie per aver usato Data Quality Framework!
echo ═══════════════════════════════════════════════════════════════════════════════
echo.
pause

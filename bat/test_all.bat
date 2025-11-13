@echo off
REM ═══════════════════════════════════════════════════════════════════════════════
REM TEST COMPLETO - Data Quality Framework
REM ═══════════════════════════════════════════════════════════════════════════════
REM 👤 AUTORE: Alberto Robetti
REM 📅 DATA: 12 Novembre 2025
REM 🎯 SCOPO: Esegue tutti i test (CSV + FIXED) in sequenza
REM ═══════════════════════════════════════════════════════════════════════════════

echo.
echo ═══════════════════════════════════════════════════════════════════════════════
echo   DATA QUALITY FRAMEWORK v1.0.0 - TEST SUITE COMPLETA
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
echo ═══════════════════════════════════════════════════════════════════════════════
echo.

REM ═══════════════════════════════════════════════════════════════════════════════
REM TEST 1: CSV
REM ═══════════════════════════════════════════════════════════════════════════════

echo.
echo ╔═══════════════════════════════════════════════════════════════════════════════╗
echo ║                          TEST 1: VALIDAZIONE CSV                              ║
echo ╚═══════════════════════════════════════════════════════════════════════════════╝
echo.

REM Pulisci output CSV
echo 🧹 Pulizia output CSV precedenti...
if exist "demo\csv\output\success\*.ok" del /Q "demo\csv\output\success\*.ok" 2>nul
if exist "demo\csv\output\error\*.ko" del /Q "demo\csv\output\error\*.ko" 2>nul
if exist "demo\csv\output\report\*.codici" del /Q "demo\csv\output\report\*.codici" 2>nul
if exist "demo\csv\output\statistics\*.stats" del /Q "demo\csv\output\statistics\*.stats" 2>nul
echo ✅ Pulizia CSV completata
echo.

echo 🚀 Esecuzione: bin\DataQualityFramework.exe DIPENDENTI_CSV
echo.

bin\DataQualityFramework.exe DIPENDENTI_CSV

if errorlevel 1 (
    echo.
    echo ❌ TEST CSV FALLITO - Exit code: %ERRORLEVEL%
    set /a test_csv_failed=1
) else (
    echo.
    echo ✅ TEST CSV COMPLETATO CON SUCCESSO
    set /a test_csv_failed=0
)

REM Conta output CSV
set /a csv_ok=0
set /a csv_ko=0
set /a csv_codici=0
set /a csv_stats=0

for %%f in ("demo\csv\output\success\*.ok") do set /a csv_ok+=1
for %%f in ("demo\csv\output\error\*.ko") do set /a csv_ko+=1
for %%f in ("demo\csv\output\report\*.codici") do set /a csv_codici+=1
for %%f in ("demo\csv\output\statistics\*.stats") do set /a csv_stats+=1

echo.
echo 📊 Output generati CSV:
echo   ✅ File .ok:      %csv_ok%
echo   ❌ File .ko:      %csv_ko%
echo   📋 File .codici:  %csv_codici%
echo   📊 File .stats:   %csv_stats%

timeout /t 3 /nobreak >nul

REM ═══════════════════════════════════════════════════════════════════════════════
REM TEST 2: FIXED
REM ═══════════════════════════════════════════════════════════════════════════════

echo.
echo ╔═══════════════════════════════════════════════════════════════════════════════╗
echo ║                        TEST 2: VALIDAZIONE FIXED                              ║
echo ╚═══════════════════════════════════════════════════════════════════════════════╝
echo.

REM Pulisci output FIXED
echo 🧹 Pulizia output FIXED precedenti...
if exist "demo\fixed\output\success\*.ok" del /Q "demo\fixed\output\success\*.ok" 2>nul
if exist "demo\fixed\output\error\*.ko" del /Q "demo\fixed\output\error\*.ko" 2>nul
if exist "demo\fixed\output\report\*.codici" del /Q "demo\fixed\output\report\*.codici" 2>nul
if exist "demo\fixed\output\statistics\*.stats" del /Q "demo\fixed\output\statistics\*.stats" 2>nul
echo ✅ Pulizia FIXED completata
echo.

echo 🚀 Esecuzione: bin\DataQualityFramework.exe DIPENDENTI_FIXED
echo.

bin\DataQualityFramework.exe DIPENDENTI_FIXED

if errorlevel 1 (
    echo.
    echo ❌ TEST FIXED FALLITO - Exit code: %ERRORLEVEL%
    set /a test_fixed_failed=1
) else (
    echo.
    echo ✅ TEST FIXED COMPLETATO CON SUCCESSO
    set /a test_fixed_failed=0
)

REM Conta output FIXED
set /a fixed_ok=0
set /a fixed_ko=0
set /a fixed_codici=0
set /a fixed_stats=0

for %%f in ("demo\fixed\output\success\*.ok") do set /a fixed_ok+=1
for %%f in ("demo\fixed\output\error\*.ko") do set /a fixed_ko+=1
for %%f in ("demo\fixed\output\report\*.codici") do set /a fixed_codici+=1
for %%f in ("demo\fixed\output\statistics\*.stats") do set /a fixed_stats+=1

echo.
echo 📊 Output generati FIXED:
echo   ✅ File .ok:      %fixed_ok%
echo   ❌ File .ko:      %fixed_ko%
echo   📋 File .codici:  %fixed_codici%
echo   📊 File .stats:   %fixed_stats%

timeout /t 2 /nobreak >nul

REM ═══════════════════════════════════════════════════════════════════════════════
REM RIEPILOGO FINALE
REM ═══════════════════════════════════════════════════════════════════════════════

echo.
echo.
echo ═══════════════════════════════════════════════════════════════════════════════
echo   RIEPILOGO TEST SUITE COMPLETA
echo ═══════════════════════════════════════════════════════════════════════════════
echo.

set /a total_tests=2
set /a failed_tests=0

if %test_csv_failed%==1 set /a failed_tests+=1
if %test_fixed_failed%==1 set /a failed_tests+=1

set /a passed_tests=%total_tests%-%failed_tests%

echo   📊 Test eseguiti:    %total_tests%
echo.

if %test_csv_failed%==0 (
    echo   ✅ CSV:              PASSATO
) else (
    echo   ❌ CSV:              FALLITO
)

if %test_fixed_failed%==0 (
    echo   ✅ FIXED:            PASSATO
) else (
    echo   ❌ FIXED:            FALLITO
)

echo.
echo   ─────────────────────────────────────────────────────────────────────────────
echo.

if %failed_tests%==0 (
    echo   🎉 TUTTI I TEST SUPERATI! (%passed_tests%/%total_tests%)
    echo.
    echo   📂 Output totali generati:
    echo      • File .ok:      %csv_ok% ^(CSV^) + %fixed_ok% ^(FIXED^) = %csv_ok% + %fixed_ok%
    echo      • File .ko:      %csv_ko% ^(CSV^) + %fixed_ko% ^(FIXED^) = %csv_ko% + %fixed_ko%
    echo      • File .codici:  %csv_codici% ^(CSV^) + %fixed_codici% ^(FIXED^) = %csv_codici% + %fixed_codici%
    echo      • File .stats:   %csv_stats% ^(CSV^) + %fixed_stats% ^(FIXED^) = %csv_stats% + %fixed_stats%
) else (
    echo   ⚠️  ALCUNI TEST FALLITI (%passed_tests%/%total_tests% passati)
    echo.
    echo   📋 Verifica log in: log\
)

echo.
echo ═══════════════════════════════════════════════════════════════════════════════
echo.

REM Menu azioni
echo 🎯 AZIONI DISPONIBILI:
echo.
echo   1. Apri directory output CSV
echo   2. Apri directory output FIXED
echo   3. Visualizza log
echo   4. Esci
echo.

choice /C 1234 /N /M "Scegli azione [1-4]: "

if errorlevel 4 goto :end
if errorlevel 3 (
    start explorer "log"
    goto :end
)
if errorlevel 2 (
    start explorer "demo\fixed\output"
    goto :end
)
if errorlevel 1 (
    start explorer "demo\csv\output"
    goto :end
)

:end
echo.
echo ═══════════════════════════════════════════════════════════════════════════════
echo   Test Suite completata. Grazie per aver usato Data Quality Framework!
echo ═══════════════════════════════════════════════════════════════════════════════
echo.

if %failed_tests% GTR 0 (
    exit /b 1
) else (
    exit /b 0
)

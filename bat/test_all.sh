#!/bin/bash
# ═══════════════════════════════════════════════════════════════════════════════
# TEST COMPLETO - Data Quality Framework
# ═══════════════════════════════════════════════════════════════════════════════
# 👤 AUTORE: Alberto Robetti
# 📅 DATA: 12 Novembre 2025
# 🎯 SCOPO: Esegue tutti i test (CSV + FIXED) in sequenza
# ═══════════════════════════════════════════════════════════════════════════════

echo ""
echo "═══════════════════════════════════════════════════════════════════════════════"
echo "  DATA QUALITY FRAMEWORK v1.0.0 - TEST SUITE COMPLETA"
echo "═══════════════════════════════════════════════════════════════════════════════"
echo ""

# Vai alla directory root del progetto
cd "$(dirname "$0")/.." || exit 1

# Verifica che Python sia installato
if ! command -v python3 &> /dev/null; then
    echo "❌ ERRORE: Python non trovato. Installare Python 3.6+"
    exit 1
fi

echo "📋 Informazioni Sistema:"
python3 --version
echo "📁 Directory corrente: $(pwd)"
echo ""
echo "═══════════════════════════════════════════════════════════════════════════════"
echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# TEST 1: CSV
# ═══════════════════════════════════════════════════════════════════════════════

echo ""
echo "╔═══════════════════════════════════════════════════════════════════════════════╗"
echo "║                          TEST 1: VALIDAZIONE CSV                              ║"
echo "╚═══════════════════════════════════════════════════════════════════════════════╝"
echo ""

# Pulisci output CSV
echo "🧹 Pulizia output CSV precedenti..."
rm -f demo/csv/output/success/*.ok 2>/dev/null
rm -f demo/csv/output/error/*.ko 2>/dev/null
rm -f demo/csv/output/report/*.codici 2>/dev/null
rm -f demo/csv/output/statistics/*.stats 2>/dev/null
echo "✅ Pulizia CSV completata"
echo ""

echo "🚀 Esecuzione: python3 bin/DataQualityFramework.py DIPENDENTI_CSV"
echo ""

python3 bin/DataQualityFramework.py DIPENDENTI_CSV
csv_exit_code=$?

if [ $csv_exit_code -ne 0 ]; then
    echo ""
    echo "❌ TEST CSV FALLITO - Exit code: $csv_exit_code"
    test_csv_failed=1
else
    echo ""
    echo "✅ TEST CSV COMPLETATO CON SUCCESSO"
    test_csv_failed=0
fi

# Conta output CSV
csv_ok=$(ls -1 demo/csv/output/success/*.ok 2>/dev/null | wc -l)
csv_ko=$(ls -1 demo/csv/output/error/*.ko 2>/dev/null | wc -l)
csv_codici=$(ls -1 demo/csv/output/report/*.codici 2>/dev/null | wc -l)
csv_stats=$(ls -1 demo/csv/output/statistics/*.stats 2>/dev/null | wc -l)

echo ""
echo "📊 Output generati CSV:"
echo "  ✅ File .ok:      $csv_ok"
echo "  ❌ File .ko:      $csv_ko"
echo "  📋 File .codici:  $csv_codici"
echo "  📊 File .stats:   $csv_stats"

sleep 2

# ═══════════════════════════════════════════════════════════════════════════════
# TEST 2: FIXED
# ═══════════════════════════════════════════════════════════════════════════════

echo ""
echo "╔═══════════════════════════════════════════════════════════════════════════════╗"
echo "║                        TEST 2: VALIDAZIONE FIXED                              ║"
echo "╚═══════════════════════════════════════════════════════════════════════════════╝"
echo ""

# Pulisci output FIXED
echo "🧹 Pulizia output FIXED precedenti..."
rm -f demo/fixed/output/success/*.ok 2>/dev/null
rm -f demo/fixed/output/error/*.ko 2>/dev/null
rm -f demo/fixed/output/report/*.codici 2>/dev/null
rm -f demo/fixed/output/statistics/*.stats 2>/dev/null
echo "✅ Pulizia FIXED completata"
echo ""

echo "🚀 Esecuzione: python3 bin/DataQualityFramework.py DIPENDENTI_FIXED"
echo ""

python3 bin/DataQualityFramework.py DIPENDENTI_FIXED
fixed_exit_code=$?

if [ $fixed_exit_code -ne 0 ]; then
    echo ""
    echo "❌ TEST FIXED FALLITO - Exit code: $fixed_exit_code"
    test_fixed_failed=1
else
    echo ""
    echo "✅ TEST FIXED COMPLETATO CON SUCCESSO"
    test_fixed_failed=0
fi

# Conta output FIXED
fixed_ok=$(ls -1 demo/fixed/output/success/*.ok 2>/dev/null | wc -l)
fixed_ko=$(ls -1 demo/fixed/output/error/*.ko 2>/dev/null | wc -l)
fixed_codici=$(ls -1 demo/fixed/output/report/*.codici 2>/dev/null | wc -l)
fixed_stats=$(ls -1 demo/fixed/output/statistics/*.stats 2>/dev/null | wc -l)

echo ""
echo "📊 Output generati FIXED:"
echo "  ✅ File .ok:      $fixed_ok"
echo "  ❌ File .ko:      $fixed_ko"
echo "  📋 File .codici:  $fixed_codici"
echo "  📊 File .stats:   $fixed_stats"

sleep 2

# ═══════════════════════════════════════════════════════════════════════════════
# RIEPILOGO FINALE
# ═══════════════════════════════════════════════════════════════════════════════

echo ""
echo ""
echo "═══════════════════════════════════════════════════════════════════════════════"
echo "  RIEPILOGO TEST SUITE COMPLETA"
echo "═══════════════════════════════════════════════════════════════════════════════"
echo ""

total_tests=2
failed_tests=$((test_csv_failed + test_fixed_failed))
passed_tests=$((total_tests - failed_tests))

echo "  📊 Test eseguiti:    $total_tests"
echo ""

if [ $test_csv_failed -eq 0 ]; then
    echo "  ✅ CSV:              PASSATO"
else
    echo "  ❌ CSV:              FALLITO"
fi

if [ $test_fixed_failed -eq 0 ]; then
    echo "  ✅ FIXED:            PASSATO"
else
    echo "  ❌ FIXED:            FALLITO"
fi

echo ""
echo "  ─────────────────────────────────────────────────────────────────────────────"
echo ""

if [ $failed_tests -eq 0 ]; then
    echo "  🎉 TUTTI I TEST SUPERATI! ($passed_tests/$total_tests)"
    echo ""
    echo "  📂 Output totali generati:"
    echo "     • File .ok:      $csv_ok (CSV) + $fixed_ok (FIXED) = $((csv_ok + fixed_ok))"
    echo "     • File .ko:      $csv_ko (CSV) + $fixed_ko (FIXED) = $((csv_ko + fixed_ko))"
    echo "     • File .codici:  $csv_codici (CSV) + $fixed_codici (FIXED) = $((csv_codici + fixed_codici))"
    echo "     • File .stats:   $csv_stats (CSV) + $fixed_stats (FIXED) = $((csv_stats + fixed_stats))"
else
    echo "  ⚠️  ALCUNI TEST FALLITI ($passed_tests/$total_tests passati)"
    echo ""
    echo "  📋 Verifica log in: log/"
fi

echo ""
echo "═══════════════════════════════════════════════════════════════════════════════"
echo ""

# Menu azioni
echo "🎯 AZIONI DISPONIBILI:"
echo ""
echo "  1. Apri directory output CSV"
echo "  2. Apri directory output FIXED"
echo "  3. Visualizza log"
echo "  4. Esci"
echo ""

read -p "Scegli azione [1-4]: " choice

case $choice in
    1)
        if command -v xdg-open &> /dev/null; then
            xdg-open demo/csv/output
        elif command -v open &> /dev/null; then
            open demo/csv/output
        else
            echo "📁 Directory: demo/csv/output"
        fi
        ;;
    2)
        if command -v xdg-open &> /dev/null; then
            xdg-open demo/fixed/output
        elif command -v open &> /dev/null; then
            open demo/fixed/output
        else
            echo "📁 Directory: demo/fixed/output"
        fi
        ;;
    3)
        if command -v xdg-open &> /dev/null; then
            xdg-open log
        elif command -v open &> /dev/null; then
            open log
        else
            echo "📁 Directory: log"
        fi
        ;;
    4)
        ;;
esac

echo ""
echo "═══════════════════════════════════════════════════════════════════════════════"
echo "  Test Suite completata. Grazie per aver usato Data Quality Framework!"
echo "═══════════════════════════════════════════════════════════════════════════════"
echo ""

if [ $failed_tests -gt 0 ]; then
    exit 1
else
    exit 0
fi

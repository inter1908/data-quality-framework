#!/bin/bash
# ═══════════════════════════════════════════════════════════════════════════════
# TEST CSV - Data Quality Framework
# ═══════════════════════════════════════════════════════════════════════════════
# 👤 AUTORE: Alberto Robetti
# 📅 DATA: 12 Novembre 2025
# 🎯 SCOPO: Esegue test completo validazione file CSV demo
# ═══════════════════════════════════════════════════════════════════════════════

echo ""
echo "═══════════════════════════════════════════════════════════════════════════════"
echo "  DATA QUALITY FRAMEWORK v1.0.0 - TEST CSV"
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

# Pulisci output precedenti (opzionale - commentare se si vuole mantenere storico)
echo "🧹 Pulizia output precedenti..."
rm -f demo/csv/output/success/*.ok 2>/dev/null
rm -f demo/csv/output/error/*.ko 2>/dev/null
rm -f demo/csv/output/report/*.codici 2>/dev/null
rm -f demo/csv/output/statistics/*.stats 2>/dev/null
echo "✅ Pulizia completata"
echo ""

# Esegui test CSV
echo "═══════════════════════════════════════════════════════════════════════════════"
echo "🚀 ESECUZIONE TEST CSV - Flusso DIPENDENTI_CSV"
echo "═══════════════════════════════════════════════════════════════════════════════"
echo ""

python3 bin/DataQualityFramework.py DIPENDENTI_CSV
EXIT_CODE=$?

# Verifica exit code
if [ $EXIT_CODE -ne 0 ]; then
    echo ""
    echo "═══════════════════════════════════════════════════════════════════════════════"
    echo "❌ TEST FALLITO - Exit code: $EXIT_CODE"
    echo "═══════════════════════════════════════════════════════════════════════════════"
    echo ""
    echo "📋 Verifica log in: log/"
    echo ""
    exit $EXIT_CODE
fi

# Mostra risultati
echo ""
echo "═══════════════════════════════════════════════════════════════════════════════"
echo "✅ TEST COMPLETATO CON SUCCESSO"
echo "═══════════════════════════════════════════════════════════════════════════════"
echo ""
echo "📊 Verifica output generati:"
echo ""

# Conta file generati
count_ok=$(ls -1 demo/csv/output/success/*.ok 2>/dev/null | wc -l)
count_ko=$(ls -1 demo/csv/output/error/*.ko 2>/dev/null | wc -l)
count_codici=$(ls -1 demo/csv/output/report/*.codici 2>/dev/null | wc -l)
count_stats=$(ls -1 demo/csv/output/statistics/*.stats 2>/dev/null | wc -l)

echo "  ✅ File validati (.ok):           $count_ok"
[ $count_ok -gt 0 ] && ls -1 demo/csv/output/success/*.ok 2>/dev/null | xargs -n1 basename
echo ""

echo "  ❌ File scartati (.ko):           $count_ko"
[ $count_ko -gt 0 ] && ls -1 demo/csv/output/error/*.ko 2>/dev/null | xargs -n1 basename
echo ""

echo "  📋 Anagrafica errori (.codici):   $count_codici"
[ $count_codici -gt 0 ] && ls -1 demo/csv/output/report/*.codici 2>/dev/null | xargs -n1 basename
echo ""

echo "  📊 Report statistiche (.stats):   $count_stats"
[ $count_stats -gt 0 ] && ls -1 demo/csv/output/statistics/*.stats 2>/dev/null | xargs -n1 basename
echo ""

# Mostra ultimo log
echo "═══════════════════════════════════════════════════════════════════════════════"
echo "📜 ULTIMO LOG GENERATO"
echo "═══════════════════════════════════════════════════════════════════════════════"
echo ""

LAST_LOG=$(ls -1t log/*.log 2>/dev/null | head -1)
if [ -n "$LAST_LOG" ]; then
    echo "📁 File: $LAST_LOG"
    echo ""
    echo "📄 Ultime 20 righe:"
    tail -20 "$LAST_LOG"
fi

echo ""
echo "═══════════════════════════════════════════════════════════════════════════════"
echo "🎯 AZIONI DISPONIBILI"
echo "═══════════════════════════════════════════════════════════════════════════════"
echo ""
echo "  1. Visualizza file .ko (scartati)"
echo "  2. Visualizza anagrafica codici (.codici)"
echo "  3. Visualizza statistiche (.stats)"
echo "  4. Apri directory output"
echo "  5. Esci"
echo ""

read -p "Scegli azione [1-5]: " choice

case $choice in
    1)
        KO_FILE=$(ls -1t demo/csv/output/error/*.ko 2>/dev/null | head -1)
        [ -n "$KO_FILE" ] && cat "$KO_FILE"
        ;;
    2)
        CODICI_FILE=$(ls -1t demo/csv/output/report/*.codici 2>/dev/null | head -1)
        [ -n "$CODICI_FILE" ] && cat "$CODICI_FILE"
        ;;
    3)
        STATS_FILE=$(ls -1t demo/csv/output/statistics/*.stats 2>/dev/null | head -1)
        [ -n "$STATS_FILE" ] && cat "$STATS_FILE"
        ;;
    4)
        if command -v xdg-open &> /dev/null; then
            xdg-open demo/csv/output
        elif command -v open &> /dev/null; then
            open demo/csv/output
        else
            echo "📁 Directory: demo/csv/output"
        fi
        ;;
    5)
        ;;
esac

echo ""
echo "═══════════════════════════════════════════════════════════════════════════════"
echo "  Test CSV completato. Grazie per aver usato Data Quality Framework!"
echo "═══════════════════════════════════════════════════════════════════════════════"
echo ""

exit 0

# Data Quality Framework

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows-blue.svg)
![License](https://img.shields.io/badge/license-Proprietary-red.svg)

## 📋 Descrizione

**Data Quality Framework** è un sistema enterprise per la validazione di dati CSV e Fixed-Width con regole configurabili.

### Caratteristiche Principali

✅ **Dual Format Support**
- CSV con delimiter configurabile (`,`, `;`, `|`, `\t`)
- Fixed-Width con posizionamento esatto dei campi

✅ **Validazioni Avanzate**
- Pattern regex per formato dati
- Lunghezza minima/massima
- Obbligatorietà campi
- Valori ammessi (whitelist)

✅ **Reporting Completo**
- Split automatico OK/KO
- Report dettagliati con codici errore
- Statistiche qualità per file e globali
- Logging multi-level con rotation

✅ **Configurazione Flessibile**
- Configurazione sistema centralizzata
- Configurazione flusso dedicata
- Layout CSV per definizione campi
- Mapping PATH dinamici

## 🚀 Quick Start

### Requisiti
- Windows 10/11 (64-bit)
- **NESSUNA installazione Python richiesta** (eseguibile standalone)

### Installazione

1. **Download**: Scarica l'ultima release
2. **Estrai**: Decomprimi in `C:\DataQualityFramework\`
3. **Pronto**: Nessuna installazione necessaria!

### Primo Utilizzo

```batch
# 1. Vai nella directory
cd C:\DataQualityFramework

# 2. Testa con esempio CSV
.\bin\DataQualityFramework.exe DIPENDENTI_CSV

# 3. Testa con esempio Fixed-Width
.\bin\DataQualityFramework.exe DIPENDENTI_FIXED

# 4. Testa tutti gli esempi
.\bat\test_all.bat
```

## 📁 Struttura Package

```
DataQualityFramework/
├── bin/
│   └── DataQualityFramework.exe    # Eseguibile standalone (8.1 MB)
├── docs/
│   └── Data_Quality_Framework_Guida.md    # Documentazione completa
├── demo/
│   ├── csv/                        # Esempi formato CSV
│   │   ├── cfg/                    # Configurazioni flusso + layout
│   │   ├── input/pending/          # File CSV da validare
│   │   └── output/                 # Success + Error + Statistics
│   └── fixed/                      # Esempi formato Fixed-Width
│       ├── cfg/                    # Configurazioni flusso + layout
│       ├── input/pending/          # File Fixed-Width da validare
│       └── output/                 # Success + Error + Statistics
├── bat/
│   ├── test_csv.bat                # Test esempio CSV
│   ├── test_fixed.bat              # Test esempio Fixed-Width
│   └── test_all.bat                # Test completo
└── README.md                       # Questo file
```

## 📖 Documentazione

Consulta la **guida completa** in `docs/Data_Quality_Framework_Guida.md`:
- Installazione e configurazione
- Creazione nuovi flussi
- Definizione regole validazione
- Interpretazione report e statistiche
- Troubleshooting e FAQ

## 🎯 Esempio Rapido

### Configurazione Flusso CSV

**File**: `demo/csv/cfg/flows/dipendenti_csv.cfg`
```ini
[FLOW]
FLOW_NAME = DIPENDENTI_CSV
FILE_PATTERN = dipendenti_csv_*.csv
FILE_FORMAT = CSV

[PATHS]
PATH_INPUT = demo/csv/input/pending
PATH_SUCCESS = demo/csv/output/success
PATH_ERROR = demo/csv/output/error

[CSV_FORMAT]
CSV_SEPARATOR = ,
CSV_QUOTE = "
CSV_ENCODING = utf-8
```

### Layout Campi

**File**: `demo/csv/cfg/layouts/dipendenti_csv_layout.csv`
```csv
FIELD_NAME,MANDATORY,MIN_LEN,MAX_LEN,PATTERN,ALLOWED_VALUES
ID,TRUE,1,10,^\d+$,
NOME,TRUE,2,50,,
COGNOME,TRUE,2,50,,
EMAIL,TRUE,5,100,^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$,
STATO,FALSE,,,,"ATTIVO,SOSPESO,CESSATO"
```

### Esecuzione

```batch
.\bin\DataQualityFramework.exe DIPENDENTI_CSV
```

**Output**:
```
🚀 AVVIO VALIDAZIONE - DIPENDENTI_CSV
════════════════════════════════════════════════════════════

📋 CONFIGURAZIONE FLUSSO
  Flusso        : DIPENDENTI_CSV
  Formato       : CSV
  Pattern file  : dipendenti_csv_*.csv
  
📂 DIRECTORY OPERATIVE
  📥 Input      : demo/csv/input/pending
  ✅ Success    : demo/csv/output/success
  ❌ Error      : demo/csv/output/error
  📊 Statistics : demo/csv/output/statistics

✅ ELABORAZIONE TERMINATA CON SUCCESSO
```

## 🔧 Configurazione Personalizzata

### Creazione Nuovo Flusso

1. **Crea configurazione flusso**: `cfg/flows/mio_flusso.cfg`
2. **Definisci layout campi**: `cfg/layouts/mio_flusso_layout.csv`
3. **Aggiungi mapping**: In `cfg/DataQualityFramework.cfg`
   ```ini
   [FLOW_MAPPING]
   MIO_FLUSSO = cfg/flows/mio_flusso.cfg
   ```
4. **Esegui**: `.\bin\DataQualityFramework.exe MIO_FLUSSO`

## 📊 Report e Statistiche

### File Statistiche
Output in `output/statistics/nome_file.csv.stats`:
```
════════════════════════════════════════════════════════════
📊 STATISTICHE FILE
════════════════════════════════════════════════════════════
📋 File                : dipendenti_csv_20251101.csv
⏱️  Avvio file         : 2025-11-13 18:30:15
⏱️  Termine file       : 2025-11-13 18:30:16
⏱️  Durata             : 0.89 sec
📊 Righe totali        : 25
✅ Righe valide        : 18 (72.00%)
❌ Righe con errori    : 7 (28.00%)
📈 Qualita dati        : 72.00%
```

### Report Errori
File con errori salvati in `output/error/` con suffisso timestamp.

## 🆘 Supporto e FAQ

### Problema: "Flusso non trovato"
**Soluzione**: Verifica che il nome flusso sia nel file `cfg/DataQualityFramework.cfg` sezione `[FLOW_MAPPING]`.

### Problema: "File layout non trovato"
**Soluzione**: Verifica path `FILE_LAYOUT` nella configurazione flusso.

### Problema: "Encoding non supportato"
**Soluzione**: Usa `CSV_ENCODING = utf-8` nella configurazione flusso.

### Log Dettagliati
I log completi sono in `log/DataQualityFramework_YYYYMMDD.log` con informazioni diagnostiche.

## 🔒 Licenza

**Proprietario** - Tutti i diritti riservati

Software distribuito come eseguibile standalone. Il codice sorgente NON è pubblico.

## 📞 Contatti

Per supporto o informazioni: [inserire contatto]

---

**Versione**: 1.0.0  
**Build**: 2025-11-13 18:27:42  
**Dimensione exe**: 8.1 MB

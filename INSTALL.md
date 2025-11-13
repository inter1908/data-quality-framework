# Guida Installazione Data Quality Framework

## 📋 Requisiti Sistema

### Minimi
- **Sistema Operativo**: Windows 10 (64-bit) o superiore
- **RAM**: 512 MB disponibili
- **Spazio Disco**: 50 MB per installazione base + spazio dati

### Raccomandati
- **Sistema Operativo**: Windows 11 (64-bit)
- **RAM**: 2 GB disponibili
- **Spazio Disco**: 500 MB (include log e statistiche)
- **CPU**: Processore multi-core per file di grandi dimensioni

## 🚀 Installazione

### Metodo 1: Download Release (Raccomandato)

1. **Scarica l'ultima release**
   - Vai su https://github.com/inter1908/data-quality-framework/releases
   - Scarica `DataQualityFramework-v1.0.0-win64.zip`

2. **Estrai i file**
   ```
   Decomprimi in: C:\DataQualityFramework\
   ```

3. **Verifica struttura**
   ```
   C:\DataQualityFramework\
   ├── bin\DataQualityFramework.exe
   ├── docs\
   ├── demo\
   └── bat\
   ```

4. **Test installazione**
   ```batch
   cd C:\DataQualityFramework
   .\bat\test_csv.bat
   ```

### Metodo 2: Clone Repository

```batch
# 1. Clona repository (richiede git)
git clone https://github.com/inter1908/data-quality-framework.git C:\DataQualityFramework

# 2. Entra nella directory
cd C:\DataQualityFramework

# 3. Test
.\bat\test_csv.bat
```

## ⚙️ Configurazione Iniziale

### 1. Configurazione Sistema

**File**: `cfg\DataQualityFramework.cfg`

Parametri da personalizzare:

```ini
[PATHS]
PATH_LOG = log                    # Directory log (default: log/)

[LOGGING]
LOG_LEVEL = INFO                  # Livello log: DEBUG, INFO, WARNING, ERROR
LOG_MAX_SIZE_MB = 10             # Dimensione max singolo file log
LOG_BACKUP_COUNT = 5             # Numero file log backup

[FLOW_MAPPING]
# Aggiungi mapping per nuovi flussi
MIO_FLUSSO = cfg/flows/mio_flusso.cfg
```

### 2. Configurazione Primo Flusso

**Usa gli esempi** in `demo\` come template:
- `demo\csv\` → Flussi formato CSV
- `demo\fixed\` → Flussi formato Fixed-Width

## 🎯 Primo Avvio

### Test con Esempio CSV

```batch
cd C:\DataQualityFramework
.\bin\DataQualityFramework.exe DIPENDENTI_CSV
```

**Output atteso**:
```
🚀 AVVIO VALIDAZIONE - DIPENDENTI_CSV
════════════════════════════════════════════════════════════

📋 CONFIGURAZIONE FLUSSO
  Flusso        : DIPENDENTI_CSV
  Formato       : CSV
  
📂 DIRECTORY OPERATIVE
  📥 Input      : demo/csv/input/pending
  ✅ Success    : demo/csv/output/success
  ❌ Error      : demo/csv/output/error

✅ ELABORAZIONE TERMINATA CON SUCCESSO

📊 RIEPILOGO QUALITÀ GLOBALE
════════════════════════════════════════════════════════════
File                              Stato    Qualità
dipendenti_csv_20251101.csv       OK       72.00%

✅ TOTALI: 3 file - 72.00% qualità media
```

### Test con Esempio Fixed-Width

```batch
.\bin\DataQualityFramework.exe DIPENDENTI_FIXED
```

### Test Completo

```batch
.\bat\test_all.bat
```

Esegue validazione di tutti gli esempi (CSV + Fixed-Width).

## 📁 Struttura Directory Lavoro

### Directory Input
```
demo\csv\input\pending\
├── dipendenti_csv_20251101.csv    # File da processare
├── dipendenti_csv_20251102.csv
└── dipendenti_csv_20251103.csv
```

I file vengono spostati automaticamente dopo elaborazione.

### Directory Output

**Success**: File validi (qualità > 0%)
```
demo\csv\output\success\
└── dipendenti_csv_20251101.csv_20251113_183045_OK.csv
```

**Error**: File con errori
```
demo\csv\output\error\
└── dipendenti_csv_20251101.csv_20251113_183045_KO.csv
```

**Statistics**: Report qualità
```
demo\csv\output\statistics\
└── dipendenti_csv_20251101.csv.stats
```

## 🔧 Risoluzione Problemi

### Problema: Eseguibile non parte

**Sintomo**: Doppio click su `.exe` non fa nulla

**Soluzione**:
1. Apri PowerShell/CMD come amministratore
2. Vai nella directory: `cd C:\DataQualityFramework`
3. Esegui: `.\bin\DataQualityFramework.exe DIPENDENTI_CSV`
4. Controlla messaggi errore

### Problema: "Flusso non trovato"

**Sintomo**: Errore `Configurazione flusso 'XXX' non trovata`

**Soluzione**:
1. Verifica nome flusso in `cfg\DataQualityFramework.cfg` sezione `[FLOW_MAPPING]`
2. Verifica path configurazione flusso sia corretto
3. Usa nome MAIUSCOLO: `DIPENDENTI_CSV` (non `dipendenti_csv`)

### Problema: "File layout non trovato"

**Sintomo**: Errore `Layout file XXX not found`

**Soluzione**:
1. Verifica parametro `FILE_LAYOUT` nella configurazione flusso
2. Verifica file layout esista nel path specificato
3. Usa path relativi alla root: `demo/csv/cfg/layouts/nome.csv`

### Problema: Errori di encoding

**Sintomo**: Caratteri strani nei file output

**Soluzione**:
Aggiungi nella configurazione flusso:
```ini
[CSV_FORMAT]
CSV_ENCODING = utf-8
```

Encoding supportati: `utf-8`, `latin-1`, `cp1252`

### Problema: Permessi negati

**Sintomo**: `PermissionError: [Errno 13]`

**Soluzione**:
1. Chiudi file Excel/editor che hanno aperti i file CSV
2. Esegui come amministratore
3. Verifica permessi cartelle `output/`

## 📊 Interpretazione Log

### Log Applicazione
**Path**: `log\DataQualityFramework_YYYYMMDD.log`

Livelli log:
- `INFO`: Operazioni normali
- `WARNING`: Situazioni anomale ma gestibili
- `ERROR`: Errori bloccanti

Esempio log:
```
2025-11-13 18:30:15 INFO     🚀 AVVIO VALIDAZIONE - DIPENDENTI_CSV
2025-11-13 18:30:15 INFO     📥 Input: demo/csv/input/pending
2025-11-13 18:30:16 INFO     ✅ File elaborato: dipendenti_csv_20251101.csv
2025-11-13 18:30:16 INFO     📊 Qualità: 72.00% (18 OK, 7 KO)
```

### File Statistiche
**Path**: `output/statistics/nome_file.csv.stats`

Contiene:
- Timestamp elaborazione
- Contatori righe (totali, valide, errori)
- Percentuale qualità
- Path file output

## 🔒 Note Sicurezza

### Dati Sensibili
- NON committare file con dati reali in `demo/`
- Pulire regolarmente directory `output/` e `log/`
- Usare `.gitignore` per escludere dati

### Permessi File
- L'eseguibile NON richiede privilegi amministratore
- Necessita lettura su `input/` e scrittura su `output/` e `log/`

## 📞 Supporto

### Risorse
- **Documentazione completa**: `docs\Data_Quality_Framework_Guida.md`
- **Esempi**: `demo\csv\` e `demo\fixed\`
- **Script test**: `bat\test_*.bat`

### Logs Diagnostici
Per supporto, includere:
1. File log: `log\DataQualityFramework_YYYYMMDD.log`
2. Configurazione flusso usata
3. Esempio file input (se possibile)
4. Messaggi errore completi

---

**Versione Guida**: 1.0.0  
**Ultimo Aggiornamento**: 2025-11-13

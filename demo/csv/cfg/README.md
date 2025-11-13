# ?? Cartella `cfg/` - Configurazioni del Flusso

## ?? Scopo

La cartella **`cfg/`** contiene i **file di configurazione del flusso di validazione**.

Questi file `.cfg` definiscono tutti i parametri operativi del framework:

- Il tipo di file da elaborare (CSV delimitato o Fixed-Width)
- I caratteri delimitatori per i file CSV
- I percorsi delle directory di input e output
- Il tracciato di validazione da applicare
- Le modalità di elaborazione (singolo file, pattern matching, ordinamento)
- I parametri di encoding e formato

---

## ?? Sottocartelle

```
cfg/
+-- flows/      ? File di configurazione specifici per ogni tipologia di flusso
+-- layouts/    ? Template di tracciati riutilizzabili tra più flussi (opzionale)
```

### `flows/`

Contiene i file `.cfg` che configurano ciascun flusso di validazione.

Un flusso rappresenta l'elaborazione completa di una specifica tipologia di file, dalla lettura all'output dei risultati.

**Esempi di file**: `flusso_anagrafica.cfg`, `flusso_transazioni.cfg`, `flusso_movimenti.cfg`

### `layouts/`

Cartella opzionale per memorizzare tracciati di validazione utilizzati da più flussi.

La maggior parte dei tracciati specifici si trova nella cartella `../layouts/` al livello superiore.

---

## ?? Struttura di un File `.cfg`

Un file di configurazione del flusso contiene sezioni organizzate per parametro:

```ini
[FLUSSO]
# Identificativo univoco del flusso
NOME_FLUSSO = Validazione_Anagrafica

# Tipo di file da elaborare
FILE_FORMAT = CSV

# Directory contenente i file da validare
INPUT_DIR = C:\Progetti\demo\csv\input\pending

# Nome del file o pattern per selezione multipla
INPUT_FILE_NAME = anagrafica_20250105.csv

# Tracciato di validazione da applicare
LAYOUT_FILE = layout_anagrafica.csv

# Directory per i record che superano la validazione
OUTPUT_VALID_DIR = C:\Progetti\demo\csv\output\success

# Directory per i record scartati
OUTPUT_ERROR_DIR = C:\Progetti\demo\csv\output\error

# Directory per i report statistici
REPORT_DIR = C:\Progetti\demo\csv\output\reports

# Carattere delimitatore per file CSV
SEPARATORE = ,

# Codifica caratteri del file
ENCODING = utf-8

# Modalità selezione file (per pattern matching)
PROCESS_WHICH = all
```

---

## ?? Parametri Principali

### Identificazione e Tipo File

| Parametro | Descrizione | Valori Possibili | Obbligatorio |
|-----------|-------------|------------------|--------------|
| `NOME_FLUSSO` | Nome identificativo del flusso | Testo libero | Sì |
| `FILE_FORMAT` | Tipologia di file da elaborare | `CSV`, `FIXED` | Sì |

### Percorsi Input

| Parametro | Descrizione | Esempio | Obbligatorio |
|-----------|-------------|---------|--------------|
| `INPUT_DIR` | Directory contenente i file da validare | `C:\Progetti\demo\csv\input\pending` | Sì |
| `INPUT_FILE_NAME` | Nome specifico o pattern con wildcard | `anagrafica_20250105.csv` o `anagrafica_*.csv` | Sì |
| `LAYOUT_FILE` | Nome del tracciato di validazione | `layout_anagrafica.csv` | Sì |

### Percorsi Output

| Parametro | Descrizione | Esempio | Obbligatorio |
|-----------|-------------|---------|--------------|
| `OUTPUT_VALID_DIR` | Destinazione record validi | `C:\Progetti\demo\csv\output\success` | Sì |
| `OUTPUT_ERROR_DIR` | Destinazione record scartati | `C:\Progetti\demo\csv\output\error` | Sì |
| `REPORT_DIR` | Destinazione report statistici | `C:\Progetti\demo\csv\output\reports` | Sì |

### Parametri CSV

| Parametro | Descrizione | Valori Possibili | Obbligatorio |
|-----------|-------------|------------------|--------------|
| `SEPARATORE` | Carattere delimitatore | `,`, `;`, `\t` (tab), `|` | Sì (solo per CSV) |
| `ENCODING` | Codifica caratteri | `utf-8`, `latin1`, `cp1252` | Sì |

### Pattern Matching

| Parametro | Descrizione | Valori Possibili | Obbligatorio |
|-----------|-------------|------------------|--------------|
| `PROCESS_WHICH` | Modalità selezione file multipli | `all`, `first`, `last` | No (default: `all`) |
| `SORT_KEYS` | Criteri ordinamento file | `nome[start:length:tipo:order]` | No |

---

## ?? Esempio Pratico

### File: `flusso_anagrafica.cfg`

Questo file configura la validazione di file anagrafici giornalieri:

```ini
[FLUSSO]
NOME_FLUSSO = Validazione_Anagrafica_Giornaliera
FILE_FORMAT = CSV

INPUT_DIR = C:\Dati\csv\input
INPUT_FILE_NAME = anagrafica_*.csv
LAYOUT_FILE = layout_anagrafica.csv

OUTPUT_VALID_DIR = C:\Dati\csv\output\success
OUTPUT_ERROR_DIR = C:\Dati\csv\output\error
REPORT_DIR = C:\Dati\csv\reports

SEPARATORE = ;
ENCODING = utf-8

# Elabora solo il file più recente
PROCESS_WHICH = first
SORT_KEYS = nome[11:8:numero:desc]
```

Questa configurazione:
- Cerca tutti i file che corrispondono al pattern `anagrafica_*.csv`
- Li ordina per data (estratta dalla posizione 11-18 del nome file)
- Elabora solo il più recente
- Applica le regole definite in `layout_anagrafica.csv`
- Salva i risultati nelle directory specificate

---

## ?? Documentazione Completa

Per l'elenco completo dei parametri disponibili e le configurazioni avanzate:

- **`../../GUIDA_UTENTE.md`** - Sezione "Configurazione Dettagliata"
- **`../../README.md`** - Panoramica generale del framework
- **`../../README_CSV_DQ.md`** - Parametri specifici per CSV e Fixed-Width

---

*Configurazioni Flusso - Data Quality Framework v1.0.0*



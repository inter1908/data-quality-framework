# 📂 Cartella `demo` - Ambiente Dimostrativo

**Autore**: Alberto Robetti  
**Versione**: 1.0.0  
**Ultimo Aggiornamento**: 5 Novembre 2025

---

## 🎯 Perché Questa Cartella?

La cartella **`demo`** serve a **mostrare come organizzare il tuo progetto** di validazione dati.

È un **esempio pratico** di come strutturare:

- 📁 Le directory per input/output
- ⚙️ I file di configurazione  
- 📋 I tracciati di validazione relativi ai dati da elaborare
- 🔄 Il flusso completo dei file dall'ingresso all'uscita

**Usala come riferimento** per organizzare il tuo ambiente di lavoro.

---

## 📁 Organizzazione Cartelle

La cartella `demo` contiene due ambienti separati:

```
demo/
│
├── csv/          → Esempi e configurazioni per file CSV delimitati
│   ├── cfg/     → Configurazioni del flusso (tipo file, delimitatore, percorsi)
│   ├── input/   → File da sottoporre a validazione
│   ├── layouts/ → Tracciati con le regole di validazione dei dati
│   ├── output/  → Risultati della validazione (record validi, scartati, report)
│   ├── archive/ → Storico dei file già elaborati
│   └── report/  → Report statistici dell'elaborazione
│
└── fixed/        → Esempi e configurazioni per file Fixed-Width
    ├── cfg/     → Configurazioni del flusso (tipo file, lunghezza record, percorsi)
    ├── input/   → File da sottoporre a validazione
    ├── layouts/ → Tracciati con le regole di validazione dei dati (con posizioni)
    ├── output/  → Risultati della validazione (record validi, scartati, report)
    ├── archive/ → Storico dei file già elaborati
    └── report/  → Report statistici dell'elaborazione
```

### 📂 Ramo `csv/`

Nel ramo **`csv/`** trovi tutto il necessario per testare i **file CSV delimitati** (con virgola, punto-virgola, tab):

- File dati di esempio da validare
- Configurazioni pronte all'uso per i flussi
- Tracciati di validazione con regole sui campi

### 📂 Ramo `fixed/`

Nel ramo **`fixed/`** trovi tutto il necessario per testare i **file Fixed-Width** (a lunghezza fissa):

- File dati a posizione fissa da validare
- Configurazioni specifiche per file Fixed-Width
- Tracciati di validazione con posizioni start/length per ogni campo

---

## 📖 Dettaglio Sottocartelle

Ogni sottocartella ha uno scopo specifico nell'elaborazione. Consulta i README dedicati per approfondire:

### 🔧 Configurazioni

| Cartella | Cosa Contiene | Documentazione |
|----------|---------------|----------------|
| **`cfg/`** | File di configurazione del flusso (.cfg) che definiscono il tipo di file, i delimitatori, i percorsi di input/output | [→ README cfg/](csv/cfg/README.md) |
| **`layouts/`** | Tracciati CSV che descrivono le regole di validazione da applicare ai dati (tipo, obbligatorietà, formati, regex) | [→ README layouts/](csv/layouts/README.md) |

### 📥 Input

| Cartella | Cosa Contiene | Documentazione |
|----------|---------------|----------------|
| **`input/`** | File dati da sottoporre a validazione (area di staging prima dell'elaborazione) | [→ README input/](csv/input/README.md) |

### 📤 Output

| Cartella | Cosa Contiene | Documentazione |
|----------|---------------|----------------|
| **`output/`** | Risultati della validazione suddivisi in: record validi (.ok), record scartati (.ko) con codici errore, report statistici | [→ README output/](csv/output/README.md) |

### 📦 Gestione

| Cartella | Cosa Contiene | Documentazione |
|----------|---------------|----------------|
| **`archive/`** | Storico dei file dati già elaborati con successo | [→ README archive/](csv/archive/README.md) |
| **`report/`** | Report statistici dell'elaborazione con metriche di qualità, distribuzione errori e timestamp | [→ README report/](csv/report/README.md) |

---

## 🚀 Come Usare Questa Demo

### 🏷️ Convenzione Naming

Tutti i file della demo seguono la convenzione **dominio_formato_tipo**:

**Formato CSV**:
- Flusso: `DIPENDENTI_CSV`
- File dati: `dipendenti_csv_YYYYMMDD.csv`
- Layout: `dipendenti_csv_layout.csv`
- Config: `dipendenti_csv.cfg`

**Formato FIXED**:
- Flusso: `DIPENDENTI_FIXED`
- File dati: `dipendenti_fixed_YYYYMMDD.dat`
- Layout: `dipendenti_fixed_layout.csv`
- Config: `dipendenti_fixed.cfg`

### 🧪 Esecuzione Test

**Test CSV**:
```powershell
cd C:\Python
python bin\DataQualityFramework.py DIPENDENTI_CSV
```

**Test FIXED**:
```powershell
cd C:\Python
python bin\DataQualityFramework.py DIPENDENTI_FIXED
```

**Test completo** (entrambi i formati):
```powershell
cd C:\Python
.\test_framework_completo.bat
```

### 1️⃣ Esplora la Struttura

Naviga nelle sottocartelle per comprendere come organizzare il tuo progetto.

Leggi i README specifici di ogni cartella per capire il ruolo di ciascuna directory, esamina i file di esempio forniti e studia le configurazioni già preparate.

### 2️⃣ Testa con i Tuoi Dati

Usa questa struttura per sperimentare le validazioni sui tuoi file.

Copia i tuoi file CSV nella cartella `csv/input/pending/`, crea o modifica i tracciati di validazione in `csv/layouts/` secondo le tue regole di business, e configura i parametri del flusso nei file `.cfg` presenti in `csv/cfg/flows/`.

### 3️⃣ Replica nel Tuo Progetto

Quando hai compreso la logica organizzativa, ricrea questa struttura nel tuo ambiente di lavoro adattando percorsi e configurazioni alle tue esigenze.

---

## 📚 Prossimi Passi

1. 📖 **Leggi i README nelle sottocartelle** - Ogni cartella contiene documentazione specifica sul suo utilizzo
2. 🔍 **Esamina i file di esempio** - Studiare la struttura dei file aiuta a configurare correttamente il proprio progetto
3. 🧪 **Sperimenta con le validazioni** - Utilizza la demo per testare diverse configurazioni senza rischi

---

## ℹ️ Note Importanti

- La struttura delle cartelle `csv/` e `fixed/` è identica. L'unica differenza è il tipo di file gestito (delimitato vs lunghezza fissa).
- Ogni sottocartella contiene un README dedicato con dettagli specifici sulla configurazione e l'utilizzo.
- I percorsi negli esempi sono relativi e facilmente adattabili al tuo ambiente.

---

*Ambiente Demo - Data Quality Framework v1.0.0*



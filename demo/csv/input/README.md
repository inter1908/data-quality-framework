# 📁 Cartella `input/` - Area di Staging per File da Validare

## 🎯 Scopo

La cartella **`input/`** rappresenta l'**area di staging** dove vengono depositati i file CSV da sottoporre a validazione.

Quando un file viene posizionato in questa directory, il framework Data Quality Framework lo preleva automaticamente e avvia il processo di validazione applicando:

- Le regole definite nel tracciato corrispondente (in `../layouts/`)
- I parametri configurati nel flusso associato (in `../cfg/flows/`)

Al termine della validazione, il file viene spostato automaticamente nella cartella di destinazione appropriata (`../output/success/`, `../output/error/`, `../output/skipped/`).

---

## 📂 Sottocartella `pending/`

### Funzione

La sottocartella **`pending/`** ospita i **file in attesa di elaborazione**.

Questa directory funge da buffer temporaneo per:

- File depositati manualmente dall'utente
- File caricati da processi automatici esterni
- File ricevuti da trasferimenti FTP/SFTP

Il framework monitora periodicamente questa cartella ed elabora i file secondo le configurazioni definite.

### Funzionamento

**Deposito**: L'utente o il processo automatico deposita il file in `input/pending/`

**Rilevamento**: Il framework rileva la presenza del nuovo file

**Validazione**: Il file viene processato applicando le regole del tracciato

**Spostamento**: Il file viene spostato dalla cartella `pending/` alla destinazione finale in `../output/`

### Esempio Pratico

Struttura prima della validazione:

```
input/
└── pending/
    ├── anagrafica_20240115.csv      ← File appena depositato
    └── vendite_gennaio.csv          ← In attesa di elaborazione
```

Struttura dopo la validazione:

```
input/
└── pending/                          ← Cartella svuotata
```

I file sono stati processati e spostati in:

- `../output/success/anagrafica_20240115.csv` (se validazione riuscita)
- `../output/error/vendite_gennaio.csv` (se rilevati errori)

---

## 📋 Convenzioni di Naming

Per facilitare il tracciamento e l'elaborazione, si consiglia di utilizzare nomi file descrittivi che includano:

**Identificativo del contenuto**: `dipendenti_csv`, `my_data`, `dipendenti`

**Timestamp o riferimento temporale**: `20240115`, `gennaio2024`

**Formato fisso consigliato**: `<tipo_dato>_<riferimento_temporale>.csv`

### Esempi di Naming Consigliati

```
anagrafica_20240115.csv
vendite_gennaio_2024.csv
dipendenti_Q1_2024.csv
dipendenti_csv_20240115.csv
```

### Vantaggi del Naming Strutturato

- Identificazione immediata del contenuto
- Ordinamento cronologico automatico
- Facilità di troubleshooting
- Tracciabilità nei log e nei report

---

## 🔄 Flusso Operativo

### Scenario Tipico

1. **Deposito Manuale**: L'utente copia il file `anagrafica_20240115.csv` in `input/pending/`

2. **Rilevamento Automatico**: Il framework rileva il nuovo file e identifica il flusso configurato per gestire file con pattern `anagrafica_*.csv`

3. **Caricamento Configurazione**: Il sistema carica:
   - Il tracciato di validazione da `../layouts/layout_anagrafica.csv`
   - I parametri del flusso da `../cfg/flows/flow_anagrafica.cfg`

4. **Esecuzione Validazione**: Il file viene validato applicando tutte le regole definite

5. **Spostamento Automatico**: Il file viene spostato in:
   - `../output/success/` se TUTTI i record sono validi
   - `../output/error/` se ALMENO UN record ha errori
   - `../output/skipped/` se il file non corrisponde ad alcun pattern configurato

6. **Generazione Report**: Viene creato un report dettagliato in `../output/reports/` con l'esito della validazione

---

## ⚠️ Attenzione

### File Non Riconosciuti

Se un file non corrisponde ad alcun pattern configurato nei flussi:

- Il file viene spostato in `../output/skipped/`
- Viene generato un avviso nel log di sistema
- Non viene eseguita alcuna validazione

**Soluzione**: Verificare che esista un file `.cfg` in `../cfg/flows/` con un `FILE_INPUT_PATTERN` che corrisponda al nome del file.

### Formato Obbligatorio

La cartella `input/` è destinata **esclusivamente** a file in formato CSV con delimitatore configurabile.

Per file con tracciato a larghezza fissa (Fixed-Width), utilizza la struttura parallela in `../../fixed/`.

### Pulizia Automatica

I file depositati in `pending/` vengono **sempre** spostati dopo l'elaborazione (mai cancellati).

Per liberare spazio, è necessario gestire manualmente le cartelle di destinazione (`../output/`, `../archive/`).

---

## 📁 Struttura Completa

```
input/
└── pending/                    ← File in attesa di validazione
    ├── (file1.csv)            ← Depositato dall'utente
    ├── (file2.csv)            ← Ricevuto da processo esterno
    └── (...)
```

---

## 📚 Riferimenti

- **`../cfg/flows/`** - Configurazioni dei flussi che specificano i pattern dei file da elaborare
- **`../layouts/`** - Tracciati di validazione con le regole da applicare
- **`../output/`** - Destinazione finale dei file dopo la validazione
- **`../../GUIDA_DATA_QUALITY.md`** - Guida completa al framework

---

*Area di Staging - Data Quality Framework v1.0.0*



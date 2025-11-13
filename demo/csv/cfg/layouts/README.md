# 📁 Cartella `layouts/` - Tracciati di Validazione

## 🎯 Scopo

La cartella **`layouts/`** contiene i **tracciati di validazione** che definiscono le regole da applicare ai dati.

Un tracciato è un file CSV che descrive nel dettaglio:

- La struttura attesa del file da validare (nomi e ordine dei campi)
- Il tipo di dato previsto per ciascun campo (stringa, numero, data, ecc.)
- Le regole di validazione da applicare (obbligatorietà, formati, vincoli)
- I codici errore da assegnare in caso di violazione delle regole

I tracciati rappresentano il "contratto di qualità" che i tuoi dati devono rispettare.

---

## 📋 Cos'è un Tracciato?

Un tracciato è uno schema formale che definisce:

**La struttura dei dati**: quali campi devono essere presenti e in quale ordine

**Le regole di business**: quali valori sono accettabili e quali no

**Le modalità di validazione**: come verificare la correttezza di ogni singolo campo

**I codici di errore**: come identificare univocamente ogni tipo di problema rilevato

### Esempio Concreto

Se hai un file `anagrafica.csv` con questa struttura:

```csv
CodiceID,Nome,Cognome,Email,DataNascita
A001,Mario,Rossi,mario.rossi@email.it,15/03/1985
```

Il tracciato `layout_anagrafica.csv` definisce:

- Il campo `CodiceID` deve essere una stringa obbligatoria nel formato `A` seguito da 3 cifre
- Il campo `Nome` deve essere una stringa obbligatoria
- Il campo `Email` deve essere una stringa obbligatoria validata tramite controllo RFC5322
- Il campo `DataNascita` deve essere una data obbligatoria nel formato `gg/mm/aaaa`

---

## 📝 Struttura di un Tracciato

Un file tracciato contiene una riga di intestazione seguita da una riga per ogni campo da validare:

```csv
NomeAttributo,TipoDato,Obbligatorio,Regex,ValoriAmmessi,Formato,FunzioneCustom,CodiceErrore
CodiceID,stringa,true,^A\d{3}$,,,,E001
Nome,stringa,true,,,,,E002
Cognome,stringa,true,,,,,E003
Email,stringa,true,,,,is_email_valid,E004
DataNascita,date,true,,,%d/%m/%Y,is_data_valid,E005
Stato,stringa,true,,Attivo|Sospeso|Chiuso,,,E006
```

### Colonne del Tracciato

| Colonna | Descrizione | Esempio di Uso |
|---------|-------------|----------------|
| **`NomeAttributo`** | Nome esatto del campo nel file CSV | `CodiceID`, `Email`, `ImportoTotale` |
| **`TipoDato`** | Tipo di dato atteso | `stringa`, `intero`, `float`, `date`, `boolean` |
| **`Obbligatorio`** | Indica se il campo è richiesto | `true` (campo obbligatorio), `false` (campo facoltativo) |
| **`Regex`** | Espressione regolare per validazione pattern | `^\d{5}$` (CAP), `^[A-Z]{2}$` (sigla provincia) |
| **`ValoriAmmessi`** | Lista chiusa di valori consentiti (separati da pipe) | `Si\|No`, `Attivo\|Sospeso\|Chiuso` |
| **`Formato`** | Formato per date o numeri | `%d/%m/%Y` (data italiana), `italian` (numero con virgola) |
| **`FunzioneCustom`** | Nome funzione Python per validazione complessa | `is_email_valid`, `is_partita_iva_valid`, `is_codice_fiscale_valid` |
| **`CodiceErrore`** | Codice univoco per identificare l'errore | `E001`, `E002`, `E003` (sequenza progressiva consigliata) |

### Regole di Utilizzo

**Esclusività Regex/FunzioneCustom**: Per ogni campo puoi usare OPPURE `Regex` OPPURE `FunzioneCustom`, non entrambi.

**Codici Errore Univoci**: Ogni campo deve avere un codice errore distinto per facilitare il troubleshooting.

**Ordine dei Campi**: L'ordine delle righe nel tracciato deve corrispondere all'ordine delle colonne nel file CSV.

---

## 📂 File Esempio Presenti

Questa cartella contiene tracciati di esempio che illustrano diverse casistiche di validazione:

| File | Descrizione | Campi Principali |
|------|-------------|------------------|
| `dipendenti_csv_layout.csv` | Tracciato dati dipendenti in formato CSV | CodiceDipendente, Nome, Cognome, Email, DataNascita, Stipendio, Reparto, Attivo, CAP, CodiceFiscale |

**Attenzione**: Questo è un **tracciato di esempio** per test del framework.

Puoi modificarlo per adattarlo ai tuoi dati reali o creare nuovi tracciati specifici per le tue esigenze.

---

## 🛠️ Come Creare un Nuovo Tracciato

### Passo 1: Analizza il File Dati

Esamina la struttura del file CSV che devi validare e identifica:

- Nomi esatti delle colonne
- Tipi di dato contenuti
- Regole di business da applicare

Esempio di file da analizzare:

```csv
CodiceID,Nome,Cognome,Email,DataNascita,Stato
A001,Mario,Rossi,mario.rossi@email.it,15/03/1985,Attivo
A002,Anna,Bianchi,anna.bianchi@email.it,22/07/1990,Sospeso
```

### Passo 2: Crea il File Tracciato

Crea un nuovo file CSV (es. `layout_anagrafica.csv`) nella cartella `layouts/`.

Inizia con l'intestazione standard:

```csv
NomeAttributo,TipoDato,Obbligatorio,Regex,ValoriAmmessi,Formato,FunzioneCustom,CodiceErrore
```

### Passo 3: Definisci le Regole per Ogni Campo

Aggiungi una riga per ogni colonna del file da validare:

```csv
CodiceID,stringa,true,^A\d{3}$,,,,E001
Nome,stringa,true,,,,,E002
Cognome,stringa,true,,,,,E003
Email,stringa,true,,,,is_email_valid,E004
DataNascita,date,true,,,%d/%m/%Y,is_data_valid,E005
Stato,stringa,true,,Attivo|Sospeso|Chiuso,,,E006
```

### Passo 4: Scegli il Tipo di Validazione

Per ogni campo, seleziona il metodo più appropriato:

**Pattern Regex**: Per validazioni basate su formato fisso

- CAP: `^\d{5}$`
- Codice formato A123: `^A\d{3}$`
- Sigla provincia: `^[A-Z]{2}$`

**Funzione Custom**: Per validazioni complesse con algoritmi specifici

- Email: `is_email_valid`
- Partita IVA: `is_partita_iva_valid`
- Codice Fiscale: `is_codice_fiscale_valid`

**Valori Ammessi**: Per elenchi chiusi di valori validi

- Stati: `Attivo|Sospeso|Chiuso`
- Booleani: `Si|No`
- Categorie: `Elettronica|Abbigliamento|Alimentari`

### Passo 5: Assegna Codici Errore

Utilizza una numerazione progressiva univoca per facilitare il troubleshooting:

- `E001` per il primo campo
- `E002` per il secondo campo
- E così via...

Oppure usa una codifica semantica:

- `E_ID_001` per errori sul campo ID
- `E_EMAIL_001` per errori sul campo Email

---

## 📚 Documentazione Completa

Per dettagli su tutte le opzioni disponibili e le funzioni di validazione:

- **`../../README_CSV_DQ.md`** - Specifiche complete dei tracciati CSV
- **`../../GUIDA_DATA_QUALITY.md`** - Catalogo funzioni di validazione disponibili
- **`../../API_REFERENCE.md`** - Documentazione tecnica delle funzioni custom

---

*Tracciati di Validazione - Data Quality Framework v1.0.0*



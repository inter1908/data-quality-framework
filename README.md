# Data Quality Framework

Sistema di validazione dati CSV e Fixed-Width con regole configurabili.

## Quick Start

```batch
cd C:\DataQualityFramework
.\bin\DataQualityFramework.exe DIPENDENTI_CSV
```

## Features

- **Dual Format**: CSV delimiter + Fixed-Width positional
- **Validazioni**: Regex, lunghezza, obbligatorietà, valori ammessi
- **Report**: Split OK/KO, statistiche qualità, codici errore
- **Logging**: Multi-level con rotation automatica

## Requirements

- Windows 10/11 (64-bit)
- Nessuna installazione Python richiesta (standalone)

## Structure

```
bin/DataQualityFramework.exe    # Eseguibile (8.1 MB)
docs/                           # Documentazione
demo/csv/                       # Esempi CSV
demo/fixed/                     # Esempi Fixed-Width
bat/                            # Script test
```

## Documentation

Guida completa: `docs/Data_Quality_Framework_Guida.md`

Installation guide: `INSTALL.md`

## Examples

**Test CSV**:
```batch
.\bin\DataQualityFramework.exe DIPENDENTI_CSV
```

**Test Fixed-Width**:
```batch
.\bin\DataQualityFramework.exe DIPENDENTI_FIXED
```

**Test All**:
```batch
.\bat\test_all.bat
```

## Version

Current: **v1.0.0** (Build: 2025-11-13 18:27:42)

---

🔒 **Proprietary License** - Binary Distribution Only

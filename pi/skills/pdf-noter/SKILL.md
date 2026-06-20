---
name: pdf-noter
description: Læs et specifikt kapitel fra en lokal PDF og lav strukturerede markdown-noter. Modellen finder selv kapitlets sider og udtrækker indholdet via pdftotext. Brug: /skill:pdf-noter <pdf-sti> <kapitel>
allowed-tools: bash
---

# PDF Noter

Du er blevet bedt om at lave markdown-noter fra et specifikt kapitel i en PDF.

## Fremgangsmåde

### Trin 1 — Udtræk al tekst fra PDF'en

```bash
pdftotext -layout "<pdf-sti>" /tmp/pi_pdf_raw.txt
```

Hvis du vil have sidenumre med, brug:

```bash
pdftotext -layout -f 1 "<pdf-sti>" - | cat -n > /tmp/pi_pdf_raw.txt
```

### Trin 2 — Find kapitlet

Søg i den udtrukne tekst efter kapiteloverskriften. Kapitler kan stave sig selv på mange måder:
- "Kapitel 12", "KAPITEL 12", "12.", "Chapter 12", "12 -", "Del 3"

Brug grep til at finde overskriften og de omgivende linjer:
```bash
grep -n -i "kapitel\|chapter" /tmp/pi_pdf_raw.txt | head -40
```

Identificér præcist hvor det ønskede kapitel begynder og slutter (hvor næste kapitel starter).

### Trin 3 — Udtruk kapitelindhold

Udtræk kun de relevante linjer fra filen og læs dem som kontekst. Brug evt. `sed -n '<start>,<slut>p'` til at afgrænse.

### Trin 4 — Lav noter

Strukturér noter i markdown:

```markdown
# Kapitel X: [Titel]

## Kernepunkter
- ...

## Vigtige begreber
**[Begreb]** — definition

## Sammendrag
...
```

### Trin 5 — Gem filen

Gem noter ved siden af PDF'en:
- `rapport.pdf` → `rapport-kapitel-12.md`
- Eller spørg brugeren om foretrukket placering

## Vigtige regler
- Læs **al** tekst du er i tvivl om for at forstå konteksten — lav ikke noter fra et forkert kapitel
- Spørg brugeren hvis kapiteloverskriften er uklar eller ikke findes
- Ryd op: `rm /tmp/pi_pdf_raw.txt` når du er færdig

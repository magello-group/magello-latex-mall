# Magello Mall för Rapporter skrivna i Markdown

Är du också trött på att behöva skriva officiella Magello-dokument i Word? Längtar du efter den dagen då du kan skriva
i Markdown och få ut en rapport med den officiella Magello-mallen?

**Den dagen är äntligen här!** Nu kan du använda `magellohub/magello-mall:latest` Docker image för att generera rapport 
till PDF från vilket Markdown dokument som helst!

## Hur funkar detta under huven?

Jag har skapat en Latex-mall och genom att köra [Pandoc](https://pandoc.org/) så kan jag exportera Markdown-filer till
PDF-format!

Latex-mallen heter `pandoc.tex`, det är bara att läsa - lycka till!

Om du vill ändra i mallen så är det bara att köra! Pandoc är väldigt kraftfullt och observera att Pandoc stödjer
Templating, du kan läsa mer om templating-system de har [här](https://pandoc.org/MANUAL.html#templates)

## Hur kör jag denna Docker image?

Du måste mount:a en volym (där du har din Markdown-fil), vilket görs med `-v`-flaggan. För att vara säker på att du har
skriv och läsrättigheter på filen som genereras så sätter vi samma user id och group id för användaren i Docker 
containern som du har lokalt på datorn, detta görs via `-u`-flaggan

```bash
docker run --rm \
   -v "$(pwd):/data" \
   -u "$(id -u):$(id -g)" \
   magellohub/magello-mall:latest min-markdown-rapport.md -o magello-mall-rapport.pdf
```

Första argumentet säger vilken Markdown-fil du vill konvertera, denna måste finnas i volymen du mount:ar. 
`-o`-argumentet säger vad PDF-filen som Pandoc genererar ska heta.

### Jag är en stinkande linux nörd
Ok, du kan skria en enkel pipe in och ut istället, så som:
```console
cat input.md | docker run --rm -i docker.io/magellohub/magello-mall:latest -f markdown -w pdf > magello-mall-rapport.pdf
```

För att läsa in en godtycklig markdown (eller innan fil) `input.md` av formatet `-f markdown` sen exportera i formatet `w pdf` till filen `> magello-mall-rapport.pdf`

### Eller om man råkar köra Windows istället
Då ser det ut såhär, eftersom vi inte är så noga med filrättigheter där.

```console
docker run --rm -v "%CD%:/data" magellohub/magello-mall:latest min-markdown-rapport.md -o magello-mall-rapport.pdf
```

### Metadata i Markdown-dokumentet

Pandoc stödjer lite metadata som kan användas för att göra rapporten lite extra fin! Genom att skapa ett YAML-block i
början på Markdown-rapporten du vill göra om till en PDF så kan du definiera lite olika saker. Här kommer ett exempel
som är bra att ha på alla rapporter du skriver:

```markdown
---
title: En titel, flytta din '#'-header hit
subtitle: En schysst undertitel
author:
- Fabian Eriksson
- Lista av Skribenter
geometry:
- top=40mm
- left=40mm
documentclass: extarticle
fontsize: 8pt
---

## Introduktion

geometry gör så att rapporten täcker A4 pappret lite bättre, schyssta default-värden!

documentclass kan sättas till något annat, men med `extarticle` så kan du sätta fontsize mellan 8-24pt
```

Fler metadata options finns att läsa om här: https://pandoc.org/MANUAL.html#metadata-variables

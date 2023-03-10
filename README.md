# Magello Mall för Rapporter skrivna i Markdown

Är du också trött på att behöva skriva officiella Magello-dokument i Word? Längtar du efter den dagen då du kan skriva
i Markdown och få ut en rapport med den officiella Magello-mallen?

**Den dagen är äntligen här!** Nu kan du använda `magello-mall:latest` Docker image för att generera rapport till PDF
från vilket Markdown dokument som helst!

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
   magello-mall:latest min-markdown-rapport.md -o magello-mall-rapport.pdf
```

Första argumentet säger vilken Markdown-fil du vill konvertera, denna måste finnas i volymen du mount:ar. 
`-o`-argumentet säger vad PDF-filen som Pandoc genererar ska heta.

## Förbättringar för framtiden

För tillfället vet jag inte vilka kommandon man behöver för att kunna köra detta i Windows, så någon snäll 
Windows-användare får gärna hjälpa till!

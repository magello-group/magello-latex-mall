# Find a good image
FROM pandoc/latex:3.1-alpine

COPY logo.png pandoc.tex /
COPY fonts/* /usr/share/fonts/

RUN tlmgr install xpatch realboxes collectbox extsizes

ENTRYPOINT ["pandoc", "--pdf-engine", "xelatex", "--listings", "--template", "/pandoc.tex"]

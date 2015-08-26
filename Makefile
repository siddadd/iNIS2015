PAPER = inis2015
TEX = $(wildcard *.tex)
BIB = library.bib
FIGS = $(wildcard figures/*.pdf figures/*.png graphs/*.pdf graphs/*.png)

.PHONY: all clean

$(PAPER).pdf: $(TEX) $(BIB) $(FIGS) IEEEtran.cls
	echo $(FIGS)
	pdflatex $(PAPER)
	#latex $(PAPER)
	bibtex $(PAPER)
	pdflatex $(PAPER)
	#latex $(PAPER)
	pdflatex $(PAPER)
	#latex $(PAPER)
	#dvipdf $(PAPER).dvi

clean:
	rm -f *.aux *.bbl *.blg *.log *.out $(PAPER).pdf


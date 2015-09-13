PAPER = inis2015
TEX = $(wildcard *.tex)
BIB = library.bib
FIGS = $(wildcard figures/*.pdf figures/*.png graphs/*.pdf graphs/*.png)

.PHONY: all clean

$(PAPER).pdf: $(TEX) $(BIB) $(FIGS) IEEEtran.cls
	echo $(FIGS)
	pdflatex -shell-escape $(PAPER)
	#make -f results.makefile -j 2 
	#latex $(PAPER)
	bibtex $(PAPER)
	pdflatex -shell-escape $(PAPER)
	#latex $(PAPER)
	pdflatex -shell-escape $(PAPER)
	#latex $(PAPER)
	#dvipdf $(PAPER).dvi

figures:
	pdflatex -shell-escape -halt-on-error -interaction=batchmode -jobname "figures/hog_fps" "\def\tikzexternalrealjob{$(PAPER)}\input{$(PAPER)}"	
	pdflatex -shell-escape -halt-on-error -interaction=batchmode -jobname "figures/face_fps" "\def\tikzexternalrealjob{$(PAPER)}\input{$(PAPER)}"	
clean:
	rm -f *.aux *.bbl *.blg *.log *.out $(PAPER).pdf


# Build every lecture in both versions:
#   make            -> NN-name.pdf (static) and NN-name-animated.pdf (animated)
#   make static     -> static versions only
#   make 08-sigma-protocols.pdf
#   make clean      -> remove auxiliary files
LATEXMK = latexmk -pdf -interaction=nonstopmode -halt-on-error

SOURCES  := $(filter-out %-animated.tex,$(wildcard [0-9][0-9]-*.tex))
STATIC   := $(SOURCES:.tex=.pdf)
ANIMATED := $(SOURCES:.tex=-animated.pdf)

all: $(STATIC) $(ANIMATED)
static: $(STATIC)
animated: $(ANIMATED)

%-animated.pdf: %-animated.tex %.tex zkdl-presentation-template.cls
	$(LATEXMK) $<

%.pdf: %.tex zkdl-presentation-template.cls
	$(LATEXMK) $<

clean:
	latexmk -c
	rm -f *.nav *.snm *.vrb

.PHONY: all static animated clean

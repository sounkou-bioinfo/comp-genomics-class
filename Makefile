# h/t to @jimhester and @yihui for this parse block:
# https://github.com/yihui/knitr/blob/dc5ead7bcfc0ebd2789fe99c527c7d91afb3de4a/Makefile#L1-L4
# Note the portability change as suggested in the manual:
# https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Writing-portable-packages
PKGNAME = `sed -n "s/Package: *\([^ ]*\)/\1/p" DESCRIPTION`
PKGVERS = `sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION`
R = $(shell which R)
# get Rscript from R home
RHOME = $(shell R -e 'cat(R.home())')
RSCRIPT = $(RHOME)/bin/Rscript

.PHONY: all build check install install2 rd2 clean

all: check

build: install_deps
	$(R) CMD build .

check: build
	$(R) CMD check --no-manual $(PKGNAME)_$(PKGVERS).tar.gz

install_deps:
	$(R) \
	-e 'if (!requireNamespace("remotes")) install.packages("remotes")' \
	-e 'remotes::install_deps(dependencies = TRUE)'

install: build
	$(R) CMD INSTALL $(PKGNAME)_$(PKGVERS).tar.gz

install2: rd2
	$(R) CMD INSTALL --no-configure .

rd2: install2
	$(RSCRIPT) -e 'roxygen2::roxygenise()'

clean:
	@rm -rf $(PKGNAME)_$(PKGVERS).tar.gz $(PKGNAME).Rcheck

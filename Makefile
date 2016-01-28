default: all-answers

.SECONDARY:

bin/%: %.hs
	@ghc $< -o $@ -odir bin 2>&1 > $@.log

answer/%: bin/prob%
	@echo "Solving for $*"
	@time -o $@.time -f %e timeout --foreground 60 ./$< > $@
	@cat $@ $@.time | xargs printf "%s in %ss\n"

answer/%: prob%.py
	@echo "Solving for $*"
	@time -o $@.time -f %e timeout --foreground 120 python2 $< > $@
	@cat $@ $@.time | xargs printf "%s in %ss\n"

problist:=$(shell ls -1 prob* | egrep -o "[0-9]*" | xargs -I{} printf "answer/%s " {})

all-answers: ${problist}

.PHONY: all-answers

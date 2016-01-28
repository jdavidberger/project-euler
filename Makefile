default: all-answers

bin/%: %.hs
	ghc $< -o $@ -odir bin 2>&1 > $@.log

answer/%: prob%.py
	@echo "Solving for $@"
	@time -f %e python2 $< > $@

answer/%: bin/prob%
	@echo "Solving for $@"
	@time -f %e ./$< > $@

problist:=$(shell ls -1 prob* | grep [0-9]* -o | xargs -I{} printf "answer/%s " {})

all-answers: ${problist}

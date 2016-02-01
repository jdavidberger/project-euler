default: all-answers

.SECONDARY:

answer/%: prob%/src/main.rs
	cd prob$* && cargo build --release
	@time -o $@.time -f %e timeout --foreground 60 ./prob$*/target/release/prob$* > $@
	@cat $@ $@.time | xargs printf "%s in %ss\n"

bin/%: %.hs
	@ghc -O2 $< -o $@ -odir bin 2>&1 > $@.log

bin/%: %.cc
	@g++ -std=c++11 -O2 $< -o $@ 2>&1 > $@.log

answer/%: bin/prob%
	@echo "Solving for $* (binary)"
	@time -o $@.time -f %e timeout --foreground 60 ./$< > $@
	@cat $@ $@.time | xargs printf "%s in %ss\n"

answer/%: prob%.scala
	@echo "Solving for $* (scala)"
	@time -o $@.time -f %e timeout --foreground 60 scala ./$< > $@
	@cat $@ $@.time | xargs printf "%s in %ss\n"

answer/%: prob%.jl
	@echo "Solving for $* (julia)"
	@time -o $@.time -f %e timeout --foreground 120 julia $< > $@
	@cat $@ $@.time | xargs printf "%s in %ss\n"

answer/%: prob%.py
	@echo "Solving for $* (python)"
	@time -o $@.time -f %e timeout --foreground 120 python2 $< > $@
	@cat $@ $@.time | xargs printf "%s in %ss\n"

problist:=$(shell ls -1 prob* | egrep -o "[0-9]*" | xargs -I{} printf "answer/%s " {})

all-answers: ${problist}

.PHONY: all-answers

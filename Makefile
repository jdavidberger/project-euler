default: all-answers

.SECONDARY:

answer/%: prob%/src/main.rs
	cd prob$* && cargo build --release
	@time -o $@.time -f %e timeout --foreground 60 ./prob$*/target/release/prob$* > $@
	@cat $@ $@.time | xargs printf "%s in %ss\n"

bin/prob529: prob529.cc
	@g++ -std=c++14 -Wall -O3 -march=native $< -o $@ -lopenblas -DARMA_DONT_USE_WRAPPER -DARMA_USE_U64S64 -llapack -lflint 2>&1 > $@.log

bin/%.d: %.cc
	@g++ -std=c++14 -Wall -g -O0 $< -o $@ 2>&1 > $@.log

bin/%: %.cc Euler.h
	@g++ -std=c++14 -Wall -O3 $< -o $@ 2>&1 > $@.log

bin/%.prof: %.hs Euler.hs
	@ghc -prof -fprof-auto -rtsopts -O2 $< -o $@ -odir bin 2>&1 > $@.log

bin/%: %.hs Euler.hs
	@ghc -O2 $< -o $@ -odir bin 2>&1 > $@.log

bin/%: %.c
	@gcc -std=c11 -O2 $< -o $@ 2>&1 > $@.log

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

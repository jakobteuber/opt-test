.PHONY: all
all: swap-xor.run swap-temp.run swap-stack.run

.PHONY: run-hyperfine
run-hyperfine: all
	hyperfine "./swap-xor.run" "./swap-temp.run" "./swap-stack.run" --export-markdown benchmark.md

.PHONY: run
run: all
	@echo "Swap with xor scheme"
	time ./swap-xor.run 
	@echo "Swap with with temporary register"
	time ./swap-temp.run
	@echo "Swap with stack slot"
	time ./swap-stack.run

swap-xor.run: swap-xor.o main.o
	cc -o $@ $^

swap-temp.run: swap-temp.o main.o
	cc -o $@ $^

swap-stack.run: swap-stack.o main.o
	cc -o $@ $^

main.o: main.c
	cc -c -Wall -Wextra -Wpedantic -masm=intel -o $@ $^

swap-xor.o: swap-xor.s
	cc -c -masm=intel -o $@ $^

swap-temp.o: swap-temp.s
	cc -c -masm=intel -o $@ $^

swap-stack.o: swap-stack.s
	cc -c -masm=intel -o $@ $^

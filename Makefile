CLANG_FLAGS := -framework AppKit

.PHONY: all clean run
all: clean oct oct-dbg
clean:
	@rm -f ./oct ./oct-dbg
run: oct
	./oct
oct:
	clang oct.m -o oct $(CLANG_FLAGS)
oct-dbg:
	clang oct.m -o oct-dbg $(CLANG_FLAGS) -g

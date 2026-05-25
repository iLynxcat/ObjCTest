CLANG_FLAGS := -framework AppKit
SOURCE_FILES := \
	oct.m \
	Button.m

.PHONY: all clean run
all: clean oct oct-dbg
clean:
	@rm -f ./oct ./oct-dbg
run: oct
	./oct
oct:
	clang $(SOURCE_FILES) -o oct $(CLANG_FLAGS)
oct-dbg:
	clang $(SOURCE_FILES) -o oct-dbg $(CLANG_FLAGS) -g

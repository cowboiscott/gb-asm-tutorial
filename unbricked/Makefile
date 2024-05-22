.DEFAULT_GOAL := unbricked.gb
.PHONY: clean

clean:
	rm -f *.o unbricked.gb

main.o: main.asm
	rgbasm -L -o $@ $<

unbricked.gb: main.o
	rgblink -o $@ $<
	rgbfix -v -p 0xFF $@

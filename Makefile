all: build run

build:
	as -o boot.o boot.asm
	ld -o boot.bin --oformat binary -e main -Ttext 0x7c00 -o boot.bin boot.o

run:
	qemu-system-x86_64 boot.bin

clean:
	rm -r boot.o boot.bin

all: build run

build:
	nasm -f bin -o boot.bin boot.asm
	dd if=/dev/zero of=boot.iso count=2880
	dd if=boot.bin of=boot.iso conv=notrunc

run:
	qemu-system-x86_64 boot.iso

clean:
	rm -r boot.iso boot.bin

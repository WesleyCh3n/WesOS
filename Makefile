all:
	nasm -f bin -o ./bin/boot.bin ./src/boot/boot.asm


run:
	qemu-system-x86_64 -nographic -hda ./bin/boot.bin
	@# Terminate: Ctrl-A X

.PHONY: clean
clean:
		rm -rf ./bin/*

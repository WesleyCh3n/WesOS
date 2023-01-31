all:
	nasm -f bin -o boot.bin ./boot.asm
	dd if=./msg.txt >> ./boot.bin
	dd if=/dev/zero bs=512 count=1 >> ./boot.bin

run:
	qemu-system-x86_64 -nographic -hda ./boot.bin
	@# Terminate: Ctrl-A X

flash_usb:
	sudo dd if=./boot.bin of=/dev/sdb

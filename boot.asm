ORG 0x7c00
BITS 16

start:
  mov ah, 0eh
  mov al, 'A'
  mov bx, 0
  int 0x10

  jmp $

padding_zero times 510-($ - $$) db 0
msg dw 0xAA55

; nasm -f bin -o boot.bin ./boot.asm
; qemu-system-x86_64 -nographic -hda ./boot.bin

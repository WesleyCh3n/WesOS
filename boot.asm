ORG 0x7c00
BITS 16

start:
  mov si, message
  call print
  jmp $

print:
  mov bx, 0
.loop:
  lodsb
  cmp al, 0
  je .done
  call print_chaar
  jmp .loop
.done:
  ret

print_char:
  mov ah, 0eh
  int 0x10   ;bios sys call
  ret

message: db "Hello World!", 0

; Padding zero
times 510-($ - $$) db 0
dw 0xAA55

; nasm -f bin -o boot.bin ./boot.asm
; qemu-system-x86_64 -nographic -hda ./boot.bin

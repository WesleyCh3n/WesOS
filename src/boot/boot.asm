ORG 0x7c00
BITS 16

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

_start:
  jmp short start
  nop

times 33 db 0

start:
  jmp 0:step2

step2:
  cli  ; Clear Interrupts
  mov ax, 0x00
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov sp, 0x7c00
  sti  ; Enables Interrupts

.load_protected:
  cli
  lgdt[gdt_descriptor]
  mov eax, cr0
  or eax, 0x1
  mov cr0, eax
  jmp CODE_SEG:load32

; GDT: https://wiki.osdev.org/Global_Descriptor_Table
gdt_start:
gdt_null:
  dd 0x0
  dd 0x0

; offset 0x8
gdt_code:     ; cs should point to this
  dw 0xffff   ; segment limit first 0-15 bits
  dw 0        ; base first 0-15 bits
  db 0 ; base
  db 0x9a
  db 11001111b
  db 0

; offset 0x10
gdt_data: ; ds, ss, es, fs, gs
  dw 0xffff   ; segment limit first 0-15 bits
  dw 0        ; base first 0-15 bits
  db 0 ; base
  db 0x92
  db 11001111b
  db 0

gdt_end:

gdt_descriptor:
  dw gdt_end - gdt_start - 1 ; gdt size
  dd gdt_start

[BITS 32]
load32:
  mov ax, DATA_SEG
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  mov ebp, 0x00200000
  mov esp , ebp

  ; Enable A20 Line https://wiki.osdev.org/A20_Line
  in al, 0x92
  or al, 2
  out 0x92, al

  jmp $

; Padding zero
times 510-($ - $$) db 0
dw 0xAA55

buffer:

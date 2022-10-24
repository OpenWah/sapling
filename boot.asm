.code16 # usa 16 bits
.global main

main:
 mov $0x0002, %ax
 int $0x10 #setea 80x25 modo texto

 mov $0x0700, %ax
 mov $0x0f, %bh
 mov $0x184f, %dx
 xor %cx, %cx
 int $0x10 #limpia la pantalla (fondo negro)
 jmp print_message

 # Lee el Timer
 mov $0x02, %ah
 int $0x1a
 
 # Imprime Horas 
 mov $0x0e, %ah
 mov %ch, %al
 int $0x10 

 # Imprime '/'
 mov $0x0e, %ah
 mov $0x2f, %al
 int $0x10

 # Imprime Minutos
 mov $0x0e, %ah
 mov %cl, %al
 int $0x10

 # Imprime '/'
 mov $0x0e, %ah
 mov $0x2f, %al
 int $0x10

 # Imprime Segundos
 mov $0x0e, %ah
 mov %dh, %al
 int $0x10

print_message:
 mov $0x02, %ah
 mov $0x00, %bh
 mov $0x0000, %dx
 int $0x10 # configura la posición del cursor 

 mov $msg, %si # carga la dirección del msg dentro de si
 mov $0x0001, %cx
 mov $0xe, %ah # carga 0xe (función number para int 0x10) dentro de ah
 jmp print_char

print_message_2:
 mov $0x02, %ah
 mov $0x00, %bh
 mov $0x0100, %dx
 int $0x10 # configura la posición del cursor

 mov $msg2, %si # carga la dirección del msg dentro de si
 mov $0x0002, %cx
 mov $0xe, %ah # carga 0xe (función number para int 0x10) dentro de ah
 jmp print_char

print_message_3:
 mov $0x02, %ah
 mov $0x00, %bh
 mov $0x0200, %dx

 int $0x10 # configura la posición del cursor
 mov $msg3, %si # carga la dirección del msg dentro de si
 mov $0x0003, %cx
 mov $0xe, %ah # carga 0xe (función number para int 0x10) dentro de ah
 jmp print_char

print_char:
 mov $0x0e, %ah
 lodsb # carga el byte de la dirección en si dentro de al e incrementa si
 cmp $0, %al # compara el contenido de AL con zero
 je done # if al == 0, go to "done"
 mov $0xc0, %bl
 int $0x10 # imprime el caracter en al a pantalla
 jmp print_char # lo repite con el siguiente byte

done:
 cmp $0x0001, %cx
 je print_message_2
 
 cmp $0x0002, %cx
 je print_message_3

 cmp $0x0003, %cx
 
end:
 hlt # para la ejecuciónMarco Ramilli
msg: .asciz "==========================="
msg2: .asciz "Sapling BootLoader: test 01"
msg3: .asciz "==========================="

.fill 510-(.-main), 1, 0 # añade 0s hasta 510 bytes long

.word 0xaa55 # byte mágico para decirle a la BIOS que es bootable

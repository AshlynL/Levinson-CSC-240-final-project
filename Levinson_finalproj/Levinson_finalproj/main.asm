;
; Levinson_finalproj.asm
;
; Created: 11/26/2019 8:21:58 AM
; Author : Physics Lab
;


; Replace with your application code
.cseg
.org 0x000
rjmp setup
.org 0x100
directives:
	.equ OLED_WIDTH = 128
	.equ OLED_HEIGHT = 64
	.include "lib_delay.asm"
	.include "lib_SSD1306_OLED.asm"
	.include "lib_GFX.asm"
	.def workhorse = r16
setup:
	rcall OLED_initialize
	rcall GFX_clear_array
	rcall GFX_refresh_screen
	ldi workhorse, 0b00000000
	sts PORTB_DIR, workhorse
	ldi workhorse, 0b00001000
	sts PORTB_PIN4CTRL, workhorse
	ldi r20, 0 //frog
	ldi r21, 15 //car1
	ldi r22, 7 //car2
	ldi r23, 3 //car3
	ldi r24, 10 //car4
	ldi r25, 1 //car5
	ldi workhorse, 13 
	mov r15, workhorse
	
loop:
	rcall GFX_clear_array
	rcall car1
	rcall car2
	rcall car3
	rcall car4
	rcall car5
	rcall car6
	rcall delay_10ms
	rcall delay_10ms
	rcall frog
	rcall GFX_refresh_screen
	rcall check_if_hit1
	rjmp loop

check_if_hit1:
	cpi workhorse, 6
	breq check_if_hit2
	ret

check_if_hit2:
	cp r20, r19
	breq hit
	ret

hit:
	ldi r20, 0
	ret

car1:
	mov workhorse, r21
	mov r18, workhorse
	rcall move_car
	mov r21, workhorse
	ldi r19, 1
	rcall set_car
	rcall check_if_hit1
	ret

car2:
	mov workhorse, r22
	mov r18, workhorse
	rcall move_car
	mov r22, workhorse
	ldi r19, 2
	rcall set_car
	rcall check_if_hit1
	ret

car3:
	mov workhorse, r23
	mov r18, workhorse
	rcall move_car
	mov r23, workhorse
	ldi r19, 3
	rcall set_car
	rcall check_if_hit1
	ret

car4:
	mov workhorse, r24
	mov r18, workhorse
	rcall move_car
	mov r24, workhorse
	ldi r19, 4
	rcall set_car
	rcall check_if_hit1
	ret
	
car5:
	mov workhorse, r25
	mov r18, workhorse
	rcall move_car
	mov r25, workhorse
	ldi r19, 5
	rcall set_car
	rcall check_if_hit1
	ret

car6:
	mov workhorse, r15
	mov r18, workhorse
	rcall move_car
	mov r15, workhorse
	ldi r19, 6
	rcall set_car
	rcall check_if_hit1
	ret

increment:
	cpi r19, 8
	breq hit
	inc r19
	mov r20, r19
	ret

move_car:
	cpi workhorse, 0
	breq exit
	dec workhorse
	ret

exit:
	ldi workhorse, 15
	ret

set_car:
	rcall GFX_set_array_pos
	ldi r17, 219
	st X, r17
	ret

frog:
	ldi r18, 7
	mov r19, r20
	rcall check_button
	rcall GFX_set_array_pos
	ldi r17, 42
	st X, r17
	ret

check_button:
	lds workhorse, PORTB_IN
	andi workhorse, 0b00010000
	cpi workhorse, 0b00000000
	breq increment
	ldi workhorse, 0b00010000
	sts PORTB_IN, workhorse
	ret

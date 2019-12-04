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
	sts PORTB_DIR, r16
	ldi workhorse, 0b00001000
	sts PORTB_PIN4CTRL, r16
	ldi r21, 0 //frog
	ldi r22, 15 //car1
	ldi r20, 15

loop:
	rcall GFX_clear_array
	//car 1
	mov workhorse, r22
	mov r18, workhorse
	rcall move_car
	mov r22, workhorse
	rcall delay_1ms
	rcall delay_1ms
	rcall delay_1ms
	ldi r19, 2
	rcall GFX_set_array_pos
	ldi r17, 219
	st X, r17

	//car2
	mov workhorse, r20
	mov r18, workhorse
	rcall move_car
	mov r20, workhorse
	ldi r19, 3
	rcall GFX_set_array_pos
	ldi r17, 219
	st X, r17

	//frog
	ldi r18, 7
	mov r19, r21
	rcall check_button
	rcall GFX_set_array_pos
	ldi r17, 42
	st X, r17
	rcall GFX_refresh_screen
	rcall check_if_hit1
	rjmp loop

check_button:
	lds workhorse, PORTB_IN
	andi workhorse, 0b00010000
	cpi workhorse, 0b00000000
	breq increment
	ret

increment:
	cpi r19, 8
	breq lose
	inc r19
	mov r21, r19
	ret

lose:
	ldi r21, 0
	ret

move_car:
	cpi workhorse, 0
	breq exit
	dec workhorse
	ret
exit:
	ldi workhorse, 15
	ret

check_if_hit1:
	cpi r21, 2
	breq check_if_hit2
	ret

check_if_hit2:
	cpi r22, 7
	breq hit
	ret

hit:
	ldi r21, 0
	ret
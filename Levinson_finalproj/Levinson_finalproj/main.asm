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
setup:
	rcall OLED_initialize
	rcall GFX_clear_array
	rcall GFX_refresh_screen
	ldi r16, 0b00000000
	sts PORTB_DIR, r16
	ldi r16, 0b00001000
	sts PORTB_PIN4CTRL, r16
	ldi r19, 1

	;clc 
	;rol r16
	;brcc nj1
	;ldi r20, 29
	;eor r16, r20
	;nj1:

loop:
	rcall GFX_clear_array
	rcall check_button
	ldi r18, 1
	rcall GFX_set_array_pos
	ldi r17, 42
	st X, r17
	rcall GFX_refresh_screen
	rjmp loop
<<<<<<< HEAD

check_button:
	lds r20, PORTB_IN
	andi r20, 0b00010000
	cpi r20, 0b00000000
	breq increment
	ret
increment:
	inc r19
	ret
=======
>>>>>>> ec10ffdf4870ef75326dcf8176cdee228e245278

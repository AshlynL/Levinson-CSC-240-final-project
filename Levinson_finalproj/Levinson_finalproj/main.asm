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
	ldi r16, 1

loop:
	mov r18, r16
	ldi r19, 1
	rcall GFX_set_array_pos
	ldi r17, 219
	st X, r17
	rcall GFX_refresh_screen
	inc r16
	rjmp loop
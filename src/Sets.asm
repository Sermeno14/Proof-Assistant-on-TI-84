include 'include/ez80.inc'
include 'include/tiformat.inc'
include 'include/ti84pceg.inc'

format ti archived executable protected program 'SETS'

; Pseudocode
; main:
	; LD string HL
	
	; Break up string into two arrays

	; for (strlen):
		; if {:
			; replace { with next symbol
			; push next symbol
		; if ,:
			; replace , with 0x01
		; if }:
			; replace } with 0x00
			; move to next function
		; push symbol

	; next_function:
		; while ( <= } )
			; str_until_comma 
			
			; while ( current_position <= 0x00)	
				; while ( current_position <= 0x01 )
					; create str_until_0x01
					
				; if (str_until_comma BOOLEAN_AND str_until_0x01 == str_until_comma) then 
					; put str_until_comma in new set
					; break
			

	; First array 0x01 replaces each comma. 0x00 at the very end
	; Second array grab string before each comma
	; Compare string with and
	; If CP is the exact same thing
	; JR B, add to our intersection code.	

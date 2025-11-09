
include 'include/ez80.inc'
include 'include/tiformat.inc'
include 'include/ti84pceg.inc'

format ti archived executable protected program 'INPUT'

main:
    call ti.ClrLCDFull
    call ti.HomeUp
    LD   HL, 0
    LD   (ti.curRow), HL
    ld   hl, inputPrompt
	ld	 bc,inputPrompt_end-inputPrompt
	ld	 de, ti.ioPrompt
    ldir
    xor  A,A
    ld   (ti.curUnder), A
    ld   B,(iy+9)
	ld	 c,(iy+28)				; back up old flag values so StringInput doesn't break screen
	res	 6,(iy+28)
	set	 7,(iy+9)
	push bc
    call ti.GetStringInput
    pop bc
    res 4, b
    call ti.PutS                ; puts the string grabbed on screen
    
    ld a, h                     ; assuming string is in hl and firsts byte is the first character of the string
    cp 158                      ; Check if byte of stringInput matches for E
    jp nz, even                 
    
    cp 168
    jp z, odd                   ; Jumps to odd code 


    RET
even:
    call ti.NewLine             ; Moves to phase 3
    ld   hl, inputPrompt
	ld	 de, ti.ioPrompt
    ldir
    xor  A,A
    ld   (ti.curUnder), A
    ld   B,(iy+9)
	ld	 c,(iy+28)				; Still backs up old flag values so StringInput doesn't break screen
	res	 6,(iy+28)
	set	 7,(iy+9)
	push bc
    call ti.GetStringInput
    pop bc
    res 4, b
    call ti.PutS

    cp 166                      ; Supposed to check for "M"
    jp nz, multt

multt:                          ; Would be the ends of checks because 2k*c would still be true that 2|2kc
    ld hl, 0                    ; Hoping resetting hl would stop it from crashing
    call ti.NewLine
    ld hl, true
    call ti.PutS

    call ti.GetKey

    ret
    
odd:  
    call ti.HomeUp              ; Print 2nd phase of function
    ld hl, inputPrompt
    call ti.PutS

    cp 169                      ; Supposed to check for another char
    jp nz, multt

inputPrompt:
    db "Function: ", 0
inputPrompt_end:
true:
    db "True", 0 
false:
    db "False", 0


; While not the enter key, let user keep typing.
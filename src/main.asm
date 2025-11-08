
; Include code for finite sets, write code that calculates the intersections installed
; Main idea: Have side functions that replace a proof with each step along the way to prove what we're proving.

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
	ld	 c,(iy+28)				;back up old flag values
	res	 6,(iy+28)
	set	 7,(iy+9)
	push bc
    call ti.GetStringInput
    pop bc
    res 4, b

    call ti.PutS
    call ti.NewLine   ; This will shift the "Done" message down one line.




    RET


inputPrompt:
    db "Set: ", 0
inputPrompt_end:
    

; While not the enter key, let user keep typing.
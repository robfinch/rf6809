; ============================================================================
;        __
;   \\__/ o\    (C) 2013-2022  Robert Finch, Waterloo
;    \  __ /    All rights reserved.
;     \/_//     robfinch<remove>@opencores.org
;       ||
;  
;
; BSD 3-Clause License
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions are met:
;
; 1. Redistributions of source code must retain the above copyright notice, this
;    list of conditions and the following disclaimer.
;
; 2. Redistributions in binary form must reproduce the above copyright notice,
;    this list of conditions and the following disclaimer in the documentation
;    and/or other materials provided with the distribution.
;
; 3. Neither the name of the copyright holder nor the names of its
;    contributors may be used to endorse or promote products derived from
;    this software without specific prior written permission.
;
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
; DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
; CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
; OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
; OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;                                                                          
; ============================================================================
;
OPT include "d:\cores2022\rf6809\software\boot\mon_equates.asm"
OPT include "d:\cores2022\rf6809\software\boot\io_equates.asm"

OPC_SWI				EQU		$03F
ScreenLocation		EQU		$10
ColorCodeLocation	EQU		$14
ScreenLocation2		EQU		$18
BlkcpySrc			EQU		$1C
BlkcpyDst			EQU		$20
Strptr				EQU		$24
PICptr				EQU		$28
; Forth Area
; 0x30-0x60

; Task control blocks, room for 256 tasks
TCB_NxtRdy		EQU		$00	; next task on ready / timeout list
TCB_PrvRdy		EQU		$04	; previous task on ready / timeout list
TCB_NxtTCB		EQU		$08
TCB_Timeout		EQU		$0C
TCB_Priority	EQU		$10
TCB_MSGPTR_D1	EQU		$14
TCB_MSGPTR_D2	EQU		$18
TCB_hJCB			EQU		$1C
TCB_Status		EQU		$1E
TCB_CursorRow	EQU		$20
TCB_CursorCol	EQU		$21
TCB_hWaitMbx	EQU		$22	; handle of mailbox task is waiting at
TCB_mbq_next	EQU		$24	; mailbox queue next
TCB_mbq_prev	EQU		$28	; mailbox queue previous
TCB_iof_next	EQU		$2C
TCB_iof_prev	EQU		$30
TCB_SPSave		EQU		$34	; TCB_SPSave area
TCB_mmu_map		EQU		$38

KeybdHead		EQU		$FFC800
KeybdTail		EQU		$FFC900
KeybdEcho		EQU		$FFCA00
KeybdBad		EQU		$FFCB00
KeybdAck		EQU		$FFCC00
KeybdLocks		EQU		$FFCD00
KeybdBuffer		EQU		$FFC000	; buffer is 16 chars

BIOS_SCREENS	EQU	$17000000	; $17000000 to $171FFFFF

; EhBASIC vars:
;
NmiBase		EQU		$FFC01E
IrqBase		EQU		$FFC01F

IOFocusNdx	EQU		$100

; These variables in global OS storage area

IOFocusList	EQU		$FFC000	; to $FF000F
IOFocusID		EQU		$FFC010
IrqSource		EQU		$FFC011
IRQFlag			EQU		$FFC012
RunningID		EQU		$FFC013
milliseconds	EQU		$FFC014

; One copy of serial buffer management
; 1 serial buffer for system.
SerHeadRcv	EQU	$FFC018
SerTailRcv	EQU	$FFC019
SerHeadXmit	EQU	$FFC01A
SerTailXmit	EQU	$FFC01B
SerRcvXon		EQU	$FFC01C
SerRcvXoff	EQU	$FFC01D
SerRcvBuf		EQU	$FFB000	; 4kB serial recieve buffer

; Top of boot stack is at $FFC0FF

; These variables use direct page access
CursorRow	EQU		$110
CursorCol	EQU		$111
CharColor	EQU		$112
ScreenColor	EQU		$113
CursorFlash	EQU		$114
KeyState1	EQU	$120
KeyState2	EQU	$121
KeyLED		EQU	$122
KeybdID		EQU	$124
KeybdBlock	EQU	$126
kbdHeadRcv	EQU	$127
kbdTailRcv	EQU	$128
kbdFifo			EQU	$40				; in local RAM
kbdFifoAlias	EQU	$C00040	; to $C0007F	; alias for $40 to $7F
SerhZero		EQU	$130
SertZero		EQU	$132


farflag	EQU		$15F
asmbuf	EQU		$160	; to $17F

QNdx0		EQU		$780
QNdx1		EQU		QNdx0+2
QNdx2		EQU		QNdx1+2
QNdx3		EQU		QNdx2+2
QNdx4		EQU		QNdx3+2
FreeTCB		EQU		QNdx4+2
TimeoutList	EQU		FreeTCB+2
FreeMbx		EQU		RunningTCB + 2
nMailbox	EQU		FreeMbx + 2
FreeMsg		EQU		nMailbox + 2
nMsgBlk		EQU		FreeMsg + 2


CharOutVec	EQU		$800
CharInVec	EQU		$804
CmdPromptJI	EQU	$808
MonErrVec	EQU		$80C
BreakpointFlag	EQU		$810
NumSetBreakpoints	EQU	$811	; to 812
Breakpoints			EQU		$820	; to $83F
BreakpointBytes	EQU		$850	; to $85F
mon_vectb				EQU		$880

; Register save area for monitor
mon_DSAVE	EQU		$900
mon_XSAVE	EQU		$902
mon_YSAVE	EQU		$904
mon_USAVE	EQU		$906
mon_SSAVE	EQU		$908
mon_PCSAVE	EQU		$90A
mon_DPRSAVE	EQU		$90E
mon_CCRSAVE	EQU		$90F

mon_numwka	EQU		$910
mon_r1		EQU		$920
mon_r2		EQU		$924
jmpvec		EQU		$928
mon_init	EQU		$92C
mon_retflag	EQU	$930

; The ORG directive must set an address a multiple of 4 in order for the Verilog
; output to work correctly.

	org		$FFFFFD0AC
	nop
	nop
	nop
XBLANK
	ldb		#' '
	lbsr	OUTCH
	rts

	org		$FFFFFD0D0
	nop
	nop
CRLF
CRLF1:
	ldb		#CR
	lbsr	OUTCH
	ldb		#LF
	lbsr	OUTCH
	rts

	org		$FFFFFD0F0
	nop
	bra		CRLF1

	org		$FFFFFD1DC
ONEKEY
	jmp		[CharInVec]

	org		$FFFFFD2C0
	nop
LETTER
	lbsr	OUTCH
	rts

	org		$FFFFFD2CC
	nop
	nop
HEX2
	lbsr	DispByteAsHex
	rts
HEX4
	lbsr	DispWordAsHex
	rts

	org		$FFFFFD300
ClearScreenJmp
	lbra	ClearScreen
	org		$FFFFFD308
HomeCursorJmp
	lbra	HomeCursor

	org		$FFFFFD400

; Local RAM test routine
; Checkerboard testing.
; There is 70kB of local RAM
; Does not use any RAM including no stack

ramtest:
	ldy		#0
	lda		#1
	sta		LEDS
	ldd		#$AAA555
ramtest1:
	std		,y++
	cmpy	#$8000
	blo		ramtest1
	; now readback values and compare
	ldy		#0
ramtest3:
	ldd		,y++
	cmpd	#$AAA555
	bne		ramerr
	cmpy	#$8000
	blo		ramtest3
	lda		#2
	sta		LEDS
	jmp		,u
ramerr:
	lda		#$80
	sta		LEDS
	ldb		COREID
	cmpb	#$20
	beq		ramerr1
	ldx		#TEXTSCR
	abx
	lda		#'F'
	sta		,x
	sync
ramerr1:
	jmp		,u

BCDArith:
	lbsr	ignBlanks
	lbsr	GetHexNumber
	ldd		mon_numwka+2
	std		mon_r1+2
	lbsr	ignBlanks
	lbsr	MonGetch
	stb		mon_r1
	lbsr	ignblanks
	lbsr	GetHexNumber
	ldd		mon_numwka+2
	std		mon_r2+2
	lbsr	CRLF
	ldb		mon_r1
	cmpb	#'+'
	beq		bcdDoAdd
	cmpb	#'-'
	beq		bcdDoSub
	cmpb	#'*'
	beq		bcdDoMul
	lbra	DisplayErr
bcdDoAdd:
	orcc	#$100
	ldd		mon_r1+2
	addd	mon_r2+2
	andcc	#$EFF
	lbsr	DispWordAsHex
	lbsr	CRLF
	lbra	Monitor
bcdDoSub:
	orcc	#$100
	ldd		mon_r1+2
	subd	mon_r2+2
	andcc	#$EFF
	lbsr	DispWordAsHex
	lbsr	CRLF
	lbra	Monitor
bcdDoMul:
	orcc	#$100
	lda		mon_r1+3
	ldb		mon_r2+3
	mul
	andcc	#$EFF
	lbsr	DispWordAsHex
	lbsr	CRLF
	lbra	Monitor

;------------------------------------------------------------------------------
; Set MAP #0 up as a linear memory map
; - semaphore memory is mapped
; - ROMs are mapped
; - The text screen memory is mapped.
;------------------------------------------------------------------------------

InitMMU:
	clrb
	stb		MMU_AKEY
	ldx		#0
	ldd		#$F00000	; CRWX=1111
	clre
immu1:
	stb		MMU,x
	sta		MMU+1,x
	leax	2,x
	incb
	ince
	cmpe	#2048			; number of entries to update
	blo		immu1
	; Map the MMU table into the address space.
	; (requires only 1 page)
	ldx		#$E38			; E38000 = page 71C * 2 bytes per record
	ldd		#$F1C6FF	; high order bits are all ones, plus CRWX=0110
	std		MMU,x
	; Map semaphore memory into address space.
	ldx		#$EF0
	ldd		#SEMA_MMU
	std		MMU,x
	; Map LEDs (VIA) into address space
	ldx		#$E60
	ldd		#VIA_MMU
	std		MMU,x
	; Map ROMs into address space
	ldx		#$F00
	lda		#$F80
	ldb		#$DFF			; D=cachable, readable, executable
	clre
immu2:
	sta		MMU,x
	stb		MMU+1,x
	leax	2,x
	inca
	ince
	cmpe	#128
	blo		immu2
	; Map Text Screen
	; Map Entire I/O region
	ldx		#$E00
	lda		#$F00
	ldb		#$6FF			; 6 = readable, writable
	clre						; e = 0
immu3:
	sta		MMU,x
	stb		MMU+1,x
	leax	2,x
	inca
	ince
	cmpe	#128
	blo		immu3

	ldb		#$800
	stb		MMU_OKEY	; turn on mapping
	rts

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
	org		$FFFFFE000
	FDB Monitor
	FDB DumRts	;	NEXTCMD
	FDB INCH
	FDB INCHE
	FDB INCHEK
	FDB OUTCH
	FDB PDATA
	FDB PCRLF
	FDB PSTRNG
	FDB DumRts			; LRA
	FDB DumRts
	FDB DumRts
	FDB DumRts
	FDB DumRts			; VINIZ
	FDB DisplayChar	;	VOUTCH
	FDB DumRts			; ACINIZ
	FDB DumRts			; AOUTCH

DumRts:
	rts

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------

start:
	ldmd	#7				; switch to native mode, firq stacks all, and ipl
	lda		#$FFF			; all cores can do this
	sta		VIA+VIA_DDRA
	lda		#$55			; see if we can at least set LEDs
	sta		LEDS
	lda		#1				; prime OS semaphore
	sta		OSSEMA+$1000
	sta		OUTSEMA+$1000
	ldu		#st6			; U = return address
;	jmp		ramtest		; JMP dont JSR
st6:
	lds		#$6FFF		; boot up stack area
	lda		COREID
	cmpa	#FIRST_CORE
;	beq		st8
;	sync						; halt cores other than 2
st8:
;	bne		skip_init
;	bsr		romToRam
;	ldd		#st7 & $FFFF
;	tfr		d,x
;	jmp		,x				; jump to the BIOS now in local RAM
st7:
	lbsr	InitMMU
	bsr		Delay3s		; give some time for devices to reset
	clr		BreakpointFlag
	clr		NumSetBreakpoints
	lda		#$AA
	sta		LEDS
	lda		COREID
	cmpa	#$20
	beq		st11
	lda		#FIRST_CORE
st11:
	sta		IOFocusID	; core #2 has focus
	sta		RunningID
	; Clear IO focus list
	ldx		#0
st9:
	clr		IOFocusList,x
	inx
	cmpx	#16
	blo		st9
	lda		#24
	sta		IOFocusList+FIRST_CORE

	lda		#$0CE
	sta		ScreenColor
	sta		CharColor
	bsr		ClearScreen
	ldd		#DisplayChar
	std		CharOutVec
	ldd		#SerialPeekCharDirect
	std		CharInVec
;	swi
;	fcb		MF_OSCALL
;	fcb		24					; request IO focus
	ldb		COREID
	cmpb	#FIRST_CORE
	beq		init
	cmpb	#$20				; CmodA709 core?
	beq		init2
	bra		skip_init
	bra		multi_sieve
st3:
	lda		#$FF
	sta		LEDS
	bra		st3

	; initialize interrupt controller
	; first, zero out all the vectors
init:
;	lbsr	rtc_read	; get clock values
	ldx		#kbdHeadRcv
	ldb		#32				; number of bytes to zero out
init1:
	clr		,x+
	decb
	bne		init1
	ldx		#128			; register to start at
	sei
	ldd		#PIC_MMU
	std		MMU
st1:
	clr		,x				; cause code
	sta		1,x
	stb		2,x
	leax	4,x
	cmpx	#256			; max reg
	blo		st1
	lda		#$C1			; make irq edge sensitive (bit 7), enable interupt (bit 6), irq (bit 0)
	sta		$FD
	lda		#$41			; level sensitive, enabled, irq
	sta		$D1				; serial irq is #20
	ldd		#$000F00
	std		MMU
	lda		#COLS
	sta		TEXTREG+TEXT_COLS
	lda		#ROWS
	sta		TEXTREG+TEXT_ROWS
	bsr		ClearScreen
	bsr		HomeCursor
	ldx		#0
	ldd		#0
	lbsr	ShowSprites
;	lbsr	KeybdInit
	ldd		KeybdID
	bsr		DispWordAsHex
init2:
	lbsr	TimerInit
	lbsr	InitSerial
	ldx		#128
	lda		#1			; set irq(bit0), clear firq (bit1), disable int (bit 6), clear edge sense(bit 7)
	ldb		#FIRST_CORE			; serving core id
;	lda		#4				; make the timer interrupt edge sensitive
;	sta		PIC+4			; reg #4 is the edge sensitivity setting
;	sta		PIC				; reg #0 is interrupt enable
	ldb		#1
	stb		OUTSEMA+SEMAABS	; set semaphore to 1 available slot
skip_init:
	andcc	#$EF			; unmask irq
	lda		#5
	sta		LEDS
	ldd		#msgStartup
	bsr		DisplayString
st10:
	swi
	fcb		MF_Monitor
	bra		st10

msgStartup
	fcb		"rf6809 12-bit System Starting.",CR,LF,0

;------------------------------------------------------------------------------
; The checkpoint register must be cleared within 1 second or a NMI interrupt
; will occur. checkpoint should be called with a JSR so that the global ROM
; routine is called.
;
; Modifies:
;		none
;------------------------------------------------------------------------------

checkpoint:
	clr		$FFFFFFFE1	; writing any value will do
	rts

;------------------------------------------------------------------------------
; Copy the system ROM to local RAM
; Running the code from local RAM is probably an order of magnitude faster
; then running from the global ROM. It also reduces the network traffic to
; run from local RAM.
;
; Modifies:
;		d,x,y
;------------------------------------------------------------------------------

romToRam:
	ldx		#$FFC000
	ldy		#$00C000
romToRam1:
	ldd		,x++
	std		,y++
	cmpx	#0
	bne		romToRam1
	rts

;------------------------------------------------------------------------------
; Multi-core sieve program.
;------------------------------------------------------------------------------

; First fill screen chars with 'P' indicating prime positions
; Each core is responsible for the Nth position where N is the
; core number minus two.
;
multi_sieve:
	lda		#'P'					; indicate prime
	ldb		COREID				; find out which core we are
	subb	#FIRST_CORE
	ldx		#0						; start at first char of screen
	abx
multi_sieve3:
	sta		TEXTSCR,x			; store 'P'
	leax	8,x						; advance to next position
	cmpx	#4095
	blo		multi_sieve3
	jsr		checkpoint
	addb	#2						; start sieve at 2 (core id)
	lda		#'N'					; flag position value of 'N' for non-prime
multi_sieve2:
	ldx		#0
	abx									; skip the first position - might be prime
multi_sieve1:
	abx									; increment
	sta		TEXTSCR,x
	cmpx	#4095
	blo		multi_sieve1
	jsr		checkpoint
	addb	#8						; number of cores working on it
	cmpb	#4080
	blo		multi_sieve2
multi_sieve4:					; hang machine
	sync
	lbra	Monitor

;------------------------------------------------------------------------------
; Single core sieve.
;------------------------------------------------------------------------------

sieve:
	lda		#'P'					; indicate prime
	ldx		#0						; start at first char of screen
sieve3:
	sta		TEXTSCR,x			; store 'P'
	inx									; advance to next position
	cmpx	#4095
	blo		sieve3
	ldb		#2						; start sieve at 2
	lda		#'N'					; flag position value of 'N' for non-prime
sieve2:
	ldx		#0
	abx									; skip the first position - might be prime
sieve1:
	abx									; increment
	sta		TEXTSCR,x
	cmpx	#4095
	blo		multi_sieve1
	incb								; number of cores working on it
	cmpb	#4080
	blo		sieve2
sieve4:								; hang machine
	rts

;------------------------------------------------------------------------------
; Three second delay for user convenience and to allow some devices time to
; reset.
;------------------------------------------------------------------------------

Delay3s:
	ldd		#9000000
dly3s1:
	cmpb	#$FF
	bne		dly3s2
dly3s2:
	sta		LEDS
	subd	#1
	bne		dly3s1
	rts

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
ShiftLeft5:
	aslb
	rola
	aslb
	rola
	aslb
	rola
	aslb
	rola
	aslb
	rola
	rts

;------------------------------------------------------------------------------
; Parameters:
;		b = core id of core to copy
;------------------------------------------------------------------------------
;
CopyVirtualScreenToScreen:
	pshs	d,x,y,u
	; Compute virtual screen location for core passed in accb.
	tfr		b,a
	asla
	asla
	asla
	asla
	ora		#$C00
	clrb
	tfr		d,x
	pshs	d
	ldy		#TEXTSCR
	ldu		#COLS*ROWS/2
cv2s1:
	ldd		,x++
	std		,y++
	leau	-1,u
	cmpu	#0
	bne		cv2s1
	; reset the cursor position in the text controller
	puls	x
	ldb		CursorRow,x
	lda		#COLS
	mul
	tfr		d,y
	ldb		CursorCol,x
	tfr		y,x
	abx
	stx		TEXTREG+TEXT_CURPOS
	puls	d,x,y,u,pc

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
;
CopyScreenToVirtualScreen:
	pshs	d,x,y,u
	bsr		GetScreenLocation
	tfr		d,y
	ldx		#TEXTSCR
	ldu		#COLS*ROWS/2
cs2v1:
	ldd		,x++
	std		,y++
	leau	-1,u
	cmpu	#0
	bne		cs2v1
	puls	d,x,y,u,pc

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
	fcb		"TEXTSCR "
	fcw		TextOpen
	fcw		TextClose
	fcw		TextRead
	fcw		TextWrite
	fcw		TextSeek

TextOpen:
	rts
TextClose:
	rts
TextRead:
	rts
TextWrite:
	rts
TextSeek:
	rts

;------------------------------------------------------------------------------
; Clear the screen and the screen color memory
; We clear the screen to give a visual indication that the system
; is working at all.
;
; Modifies:
;		none
;------------------------------------------------------------------------------

ClearScreen:
	pshs	d,x,y,u
	ldx		#COLS*ROWS
	tfr		x,u
	bsr		GetScreenLocation
	tfr		d,y
	ldb		#' '				; space char
cs1:
	stb		,y+					; set text to space
	dex								; decrement x
	bne		cs1
	ldb		COREID			; update colors only if we have focus
	cmpb	IOFocusID
	bra		cs3
	ldy		#TEXTSCR+$2000
;	lda		CharColor
	lda		#$0CE
	tfr		u,x					; get back count
cs2:
	sta		,y+
	dex								; decrement x
	bne		cs2
cs3:
	puls	d,x,y,u,pc

;------------------------------------------------------------------------------
; Scroll text on the screen upwards
;
; Modifies:
;		none
;------------------------------------------------------------------------------

ScrollUp:
	pshs	d,x,y,u
	ldy		#(COLS*ROWS-1)/2	; y = num chars/2 to move
	bsr		GetScreenLocation
	tfr		d,x
	tfr		d,u
	leax	COLS,x		; x = index to source row
scrup1:
	ldd		,x++			; move 2 characters
	std		,u++
	dey
	bne		scrup1
	lda		#ROWS-1
	bsr		BlankLine
	puls	d,x,y,u,pc

;------------------------------------------------------------------------------
; Blank out a line on the display
;
; Modifies:
;		none
; Parameters:
; 	acca = line number to blank
;------------------------------------------------------------------------------

BlankLine:
	pshs	d,x
	pshs	a
	bsr		GetScreenLocation
	tfr		d,x
	puls	a
	ldb		#COLS	; b = # chars to blank out from video controller
	mul					; d = screen index (row# * #cols)
	leax	d,x
	lda		#' '
	ldb		#COLS	; b = # chars to blank out from video controller
blnkln1:
	sta		,x+
	decb
	bne		blnkln1
	puls	d,x,pc

;------------------------------------------------------------------------------
; Get the location of the screen memory. The location
; depends on whether or not the task has the output focus.
;
; Modifies:
;		d
; Retuns:
;		d = screen location
;------------------------------------------------------------------------------

GetScreenLocation:
	lda		COREID			; which core are we?
	cmpa	IOFocusID		; do we have the IO focus
	bne		gsl1				; no, go pick virtual screen address
	cmpa	#$20				; CmodA709?
	beq		gsl1
	ldd		#TEXTSCR		; yes, we update the real screen
	rts
gsl1:
	ldd		#$7800
	rts

;------------------------------------------------------------------------------
; HomeCursor
; Set the cursor location to the top left of the screen.
;
; Modifies:
;		none
;------------------------------------------------------------------------------

HomeCursor:
	pshs	d,x
	clr		CursorRow
	clr		CursorCol
	ldb		COREID
	cmpb	IOFocusID
	bne		hc1
	cmpb	#$20
	beq		hc1
	clra
	sta		TEXTREG+TEXT_CURPOS
hc1:
	puls	d,x,pc

;------------------------------------------------------------------------------
; Update the cursor position in the text controller based on the
;  CursorRow,CursorCol.
;
; Modifies:
;		none
;------------------------------------------------------------------------------
;
UpdateCursorPos:
	pshs	d,x
	ldb		COREID				; update cursor position in text controller
	cmpb	IOFocusID			; only for the task with the output focus
	bne		ucp1
	cmpb	#$20					; and not for CmodA709
	beq		ucp1					
	lda		CursorRow
	anda	#$3F					; limit of 63 rows
	ldb		TEXTREG+TEXT_COLS
	mul
	tfr		d,x
	ldb		CursorCol
	abx
	stx		TEXTREG+TEXT_CURPOS
ucp1:
	puls	d,x,pc

;------------------------------------------------------------------------------
; Calculate screen memory location from CursorRow,CursorCol.
; Also refreshes the cursor location.
;
; Modifies:
;		d
; Returns:
; 	d = screen location
;------------------------------------------------------------------------------
;
CalcScreenLoc:
	pshs	x
	lda		CursorRow
	ldb		#COLS
	mul
	tfr		d,x
	ldb		CursorCol
	abx
	ldb		COREID				; update cursor position in text controller
	cmpb	IOFocusID			; only for the task with the output focus
	bne		csl1					
	cmpb	#$20
	beq		csl1
	stx		TEXTREG+TEXT_CURPOS
csl1:
	bsr		GetScreenLocation
	addr	x,d
	puls	x,pc

;------------------------------------------------------------------------------
; Display a character on the screen.
; If the task doesn't have the I/O focus then the character is written to
; the virtual screen.
;
; Modifies:
;		none
; Parameters:
; 	accb = char to display
;------------------------------------------------------------------------------
;
DisplayChar:
	lbsr	SerialPutChar
ScreenDisplayChar:
	pshs	d,x
	cmpb	#CR					; carriage return ?
	bne		dccr
	clr		CursorCol		; just set cursor column to zero on a CR
	bsr		UpdateCursorPos
dcx14:
	lbra		dcx4
dccr:
	cmpb	#$91				; cursor right ?
	bne		dcx6
	lda		CursorCol
	cmpa	#COLS
	bhs		dcx7
	inca
	sta		CursorCol
dcx7:
	bsr		UpdateCursorPos
	puls	d,x,pc
dcx6:
	cmpb	#$90				; cursor up ?
	bne		dcx8		
	lda		CursorRow
	beq		dcx7
	deca
	sta		CursorRow
	bra		dcx7
dcx8:
	cmpb	#$93				; cursor left ?
	bne		dcx9
	lda		CursorCol
	beq		dcx7
	deca
	sta		CursorCol
	bra		dcx7
dcx9:
	cmpb	#$92				; cursor down ?
	bne		dcx10
	lda		CursorRow
	cmpa	#ROWS
	beq		dcx7
	inca
	sta		CursorRow
	bra		dcx7
dcx10:
	cmpb	#$94				; cursor home ?
	bne		dcx11
	lda		CursorCol
	beq		dcx12
	clr		CursorCol
	bra		dcx7
dcx12:
	clr		CursorRow
	bra		dcx7
dcx11:
	cmpb	#$99				; delete ?
	bne		dcx13
	bsr		CalcScreenLoc
	tfr		d,x
	lda		CursorCol		; acc = cursor column
	bra		dcx5
dcx13
	cmpb	#CTRLH			; backspace ?
	bne		dcx3
	lda		CursorCol
	beq		dcx4
	deca
	sta		CursorCol
	bsr		CalcScreenLoc
	tfr		d,x
	lda		CursorCol
dcx5:
	ldb		1,x
	stb		,x++
	inca
	cmpa	#COLS
	blo		dcx5
	ldb		#' '
	dex
	stb		,x
	bra		dcx4
dcx3:
	cmpb	#LF				; linefeed ?
	beq		dclf
	pshs	b
	bsr 	CalcScreenLoc
	tfr		d,x
	puls	b
	stb		,x
	; ToDo character color
;	lda		CharColor
;	sta		$2000,x
	bsr		IncCursorPos
	bra		dcx4
dclf:
	bsr		IncCursorRow
dcx4:
	puls	d,x,pc

;------------------------------------------------------------------------------
; Increment the cursor position, scroll the screen if needed.
;
; Modifies:
;		none
;------------------------------------------------------------------------------

IncCursorPos:
	pshs	d,x
	lda		CursorCol
	inca
	sta		CursorCol
	cmpa	#COLS
	blo		icc1
	clr		CursorCol		; column = 0
	bra		icr1
IncCursorRow:
	pshs	d,x
icr1:
	lda		CursorRow
	inca
	sta		CursorRow
	cmpa	#ROWS
	blo		icc1
	deca							; backup the cursor row, we are scrolling up
	sta		CursorRow
	bsr		ScrollUp
icc1:
	bsr		UpdateCursorPos
icc2:
	puls	d,x,pc	

;------------------------------------------------------------------------------
; Display a string on the screen.
;
; Modifies:
;		none
; Parameters:
;		d = pointer to string
;------------------------------------------------------------------------------
;
DisplayString:
	pshs	d,x
	tfr		d,x
	lda		COREID
	cmpa	#$20
	beq		dspj1B
dspj2:						; lock semaphore for access
	lda		OUTSEMA+1
	beq		dspj2
dspj1B:
	ldb		,x+				; move string char into acc
	beq		dsretB		; is it end of string ?
	lbsr	OUTCH			; display character
	bra		dspj1B
dsretB:
	clr		OUTSEMA+1	; unlock semaphore
	puls	d,x,pc

DisplayStringCRLF:
	pshs	d
	bsr		DisplayString
	ldb		#CR
	lbsr	OUTCH
	ldb		#LF
	lbsr	OUTCH
	puls	d,pc
	
;
; PRINT CR, LF, STRING
;
PSTRNG
	BSR		PCRLF
	BRA		PDATA
PCRLF
	PSHS	X
	LDX		#CRLFST
	BSR		PDATA
	PULS	X
	RTS

PRINT
	JSR		OUTCH
PDATA
	LDB		,X+
	CMPB	#$04
	BNE		PRINT
	RTS

CRLFST
	fcb	CR,LF,4

DispDWordAsHex:
	bsr		DispWordAsHex
	exg		d,x
	bsr		DispWordAsHex
	exg		d,x
	rts

DispWordAsHex:
	exg		a,b
	bsr		DispByteAsHex
	exg		a,b
	bsr		DispByteAsHex
	rts

DispByteAsHex:
  pshs	b
	lsrb
	lsrb
	lsrb
	lsrb
	lsrb
	lsrb
	lsrb
	lsrb
	bsr		DispNyb
	puls	b
	pshs	b
	lsrb
	lsrb
	lsrb
	lsrb
	bsr		DispNyb
	puls	b

DispNyb
	pshs	b
	andb	#$0F
	cmpb	#10
	blo		DispNyb1
	addb	#'A'-10
	lbsr	OUTCH
	puls	b,pc
DispNyb1
	addb	#'0'
	lbsr	OUTCH
	puls	b,pc

;==============================================================================
; Timer
;==============================================================================

OPT INCLUDE "d:\cores2022\rf6809\software\boot\timer.asm"
OPT INCLUDE "d:\cores2022\rf6809\software\boot\i2c.asm"
OPT INCLUDE "d:\cores2022\rf6809\software\boot\rtc_driver.asm"

;==============================================================================
; Keyboard I/O
;==============================================================================

OPT INCLUDE "d:\cores2022\rf6809\software\boot\scancodes.asm"
OPT INCLUDE "d:\cores2022\rf6809\software\boot\keyboard.asm"

	fcb		"KEYBOARD"
	fcw		KeybdOpen
	fcw		KeybdClose
	fcw		KeybdRead
	fcw		KeybdWrite
	fcw		KeybdSeek

; Keyboard Open:
; Initialize the keyboard buffer head and tail indexes
;
KeybdOpen:
	rts

; Keyboard Close:
; Nothing to do except maybe clear the keyboard buffer
;
KeybdClose:
	rts
;
KeybdRead:
	rts
;
KeybdWrite:
	rts

KeybdSeek:
	rts

;==============================================================================
; Serial I/O
;==============================================================================

OPT INCLUDE "d:\cores2022\rf6809\software\boot\serial.asm"
OPT INCLUDE "d:\cores2022\rf6809\software\boot\C19Loader.asm"
OPT INCLUDE "d:\cores2022\rf6809\software\boot\xmodem.asm"

;------------------------------------------------------------------------------
; Check if there is a keyboard character available. If so return true (<0)
; otherwise return false (0) in accb.
;------------------------------------------------------------------------------
;
KeybdCheckForKeyDirect:
	bra		DBGCheckForKey

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
INCH:
	pshs	b
INCH2:
	ldb		COREID
	cmpb	IOFocusID	; if we do not have focus, block
	bne		INCH2			
;	ldb		#$800			; block if no key available, get scancode directly
;	bra		GetKey
;	jsr		[CharInVec]	; vector is being overwritten somehow
;	lbsr	SerialPeekCharDirect
	lbsr	SerialGetChar
	tsta
	bmi		INCH1			; block if no key available
	leas	1,s				; get rid of blocking status
	rts							; return character
INCH1:
	puls	b					; check blocking status
	tstb
	bmi 	INCH			; if blocking, loop
	ldd		#-1				; return -1 if no char available
	rts

INCHE:
	bsr		INCH
	bra		INCHEK3

INCHEK:
	bsr		INCH
	tst		KeybdEcho
	beq		INCHEK1
INCHEK3:
	cmpa	#CR
	bne		INCHEK2
	lbsr		CRLF
	bra		INCHEK1
INCHEK2:
	lbsr	DisplayChar
INCHEK1:
	rts

OUTCH:
	jmp		[CharOutVec]

;------------------------------------------------------------------------------
; r1 0=echo off, non-zero = echo on
;------------------------------------------------------------------------------
;
SetKeyboardEcho:
	stb		KeybdEcho
	rts


;------------------------------------------------------------------------------
; Stack Space:
;		2 words
; Parameters:
;		x,d	bitmap of sprites to enable
;------------------------------------------------------------------------------

ShowSprites:
	pshs	ccr,u
	ldu		#SPRITE_MMU
	sei
	stu		MMU
	stx		SPRITE_EN
	std		SPRITE_EN+2
	ldu		#$000F00
	stu		MMU
	puls	ccr,u,pc

;==============================================================================
; Femtiki Operating System.
;==============================================================================

OSCallTbl:
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		0
	fcw		ReleaseIOFocus
	fcw		0
	fcw		RequestIOFocus

NumOSFuncs	EQU	(*-OSCallTbl)/2

RequestIOFocus:
	ldb		COREID
	ldx		#IOFocusList
	abx
	sta		,x
	tst		IOFocusID
	lbne	oscx
	stb		IOFocusID
	lbra	oscx

ReleaseIOFocus:
	ldb		COREID
	ldx		#IOFocusList
	abx
	clr		,x						; clear the request indicator
	lbsr	CopyScreenToVirtualScreen
	cmpb	IOFocusID			; are we the one with the focus?
	lbne	oscx
	; We had the focus, so now a new core needs the focus.
	; Search the focus list for a requestor. If no requester
	; is found, give focus to core #1.
	lda		#15
riof2:
	incb
	andb	#15
	abx
	tst		,x
	bne		riof1
	deca
	bne		riof2
	; If no focus is requested by anyone, give to core #1
	ldb		#1
	lda		#24
	sta		,x
riof1:
	stb		IOFocusID
	lbsr	CopyVirtualScreenToScreen
	lbra	oscx
		
	
;==============================================================================
;==============================================================================

;------------------------------------------------------------------------------
; Seed the random number generator. All channels are seeded with the same
; value.
;
; Parameters:
;		d = 'z' part of seed
;		x = 'w' part of seed
; Returns:
;		none
;------------------------------------------------------------------------------

mon_srand:
	ldy	#0
	pshs	ccr
	tfr		d,u
	sei
	ldd		#PRNG_MMU
	std		MMU
mon_srand1:
	sty		4				; select channel
	clr		8
	clr 	9
	stu		10				; update low half of value
	clr 	12
	clr 	13
	stx		14				; update low half of value
	iny
	cmpy	#$400				; 1k channels
	blo		mon_srand1
	ldd		#$000F00
	std		MMU
	puls	ccr,pc

;------------------------------------------------------------------------------
; Get a random number and generate the next one.
;
; Parameters:
;		d = channel to use
; Returns:
;		x,d = 36 bit random value
;------------------------------------------------------------------------------

mon_rand:
	pshs	u,ccr
	ldu		#PRNG_MMU
	sei
	stu		MMU
	std		4				; select channel
	ldx		0
	ldd		2
	stb		3				; trigger calc of next number
	ldu		#$000F00
	stu		MMU
	puls	u,ccr,pc

;==============================================================================
; System Monitor
;==============================================================================

; Command Tables

cmdTable1:
	fcb		'<','>'+$800
	fcb		'B','+'+$800
	fcb		'B','-'+$800
	fcb		"BC",'D'+$800
	fcb		"DI",'V'+$800
	fcb		'D','R'+$800
	fcb		'D'+$800
	fcb		':'+$800
	fcb		"FI",'G'+$800
	fcb		"FI",'L'+$800
	fcb		'F','L'+$800
	fcb		'J'+$800
	fcb		"RAMTES",'T'+$800
	fcb		"SP",'D'+$800
	fcb		"TI",'R'+$800
	fcb		'U'+$800
	fcb		"exi",'t'+$800
	fcb		'?'+$800
	fcb		"CL",'S'+$800
	fcb		"C1",'9'+$800
	fcb		"JD",'4'+$800
	fcb		"XM",'R'+$800
	fcb		"XM",'S'+$800
	fcb		'R','A'+$800
	fcb		'R','B'+$800
	fcb		"RDP",'R'+$800
	fcb		'R','D'+$800
	fcb		'R','X'+$800
	fcb		'R','Y'+$800
	fcb		'R','U'+$800
	fcb		'R','S'+$800
	fcb		"RCC",'R'+$800
	fcb		"RP",'C'+$800
	fcb		'L','B'+$800
;	fcb		"MU",'L'+$800
	fcw		0

cmdTable2:
	fcw		Redirect
	fcw		MonArmBreakpoint
	fcw		MonDisarmBreakpoint
	fcw		BCDArith
	fcw		DivTest
	fcw		DumpRegs
	fcw		DumpMemory
	fcw		EditMemory
	fcw		$FE0000					; FIG forth
	fcw		FillMemory
	fcw		DumpIOFocusList
	fcw		jump_to_code
	fcw		$FFD400
	fcw		$FF8000					; sprite demo
	fcw		rtc_read
	fcw		$FF8003					; unassembler
	fcw		xitMonitor
	fcw		PromptHelp
	fcw		PromptClearscreen
	fcw		C19Loader
	fcw		$FFD400
	fcw		xm_ReceiveStart
	fcw		xm_SendStart
	fcw		SetRegA
	fcw		SetRegB
	fcw		SetRegDPR
	fcw		SetRegD
	fcw		SetRegX
	fcw		SetRegY
	fcw		SetRegU
	fcw		SetRegS
	fcw		SetRegCCR
	fcw		SetRegPC
	fcw		ListBreakpoints
;	fcw		MulTest

CmdPrompt:
	lbsr	CRLF
	ldb		#'$'
	lbsr	OUTCH
	lbra	OUTCH

msgF09Starting:
	fcb		"Femtiki F09 Multi-core OS Starting",CR,LF,0

Monitor:
	ldd		#PIC_MMU
	std		MMU
	lda		#31						; Timer is IRQ #31
	sta		16						; register 16 is edge sense reset reg	
	ldd		#$000F00
	std		MMU
	andcc	#$EF					; SWI disables interrupts, re-enable them
	ldd		mon_init			; check special code to see if monitor has been initialized
	cmpd	#1234567
	beq		mon1
	clr		BreakpointFlag
	clr		NumSetBreakpoints
	ldd		#123
	ldx		#654
	lbsr	mon_srand
	ldd		#msgF09Starting
	lbsr	DisplayString
	ldd		#HelpMsg
	lbsr	DisplayString
	ldd		#CmdPrompt
	std		CmdPromptJI
	ldd		#DisplayErr
	std		MonErrVec
	ldd		#$63FF			; default app stack
	std		mon_SSAVE
	clr		mon_DPRSAVE	;
	tfr		ccr,a
	sta		mon_CCRSAVE
	clr		mon_PCSAVE
	ldd		#Monitor
	std		mon_PCSAVE+1
	clr		mon_XSAVE
	clr		mon_YSAVE
	clr		mon_USAVE
	ldd		#1234567
	std		mon_init
mon1:
	leas	$6FFF				; reset stack pointer
	clrb							; turn off keyboard echo
	lbsr	SetKeyboardEcho
	; Reset IO vectors
	ldd		#SerialPeekCharDirect
	std		CharInVec
	ldd		#DisplayChar
	std		CharOutVec
	ldd		#CmdPrompt
	std		CmdPromptJI
;	jsr		RequestIOFocus
PromptLn:
	jsr		[CmdPromptJI]

; Get characters until a CR is keyed
	
Prompt3:
	ldd		#-1					; block until key present
	lbsr	INCH
	tsta							; should not get this with blocking
	bmi		Prompt3
	cmpb	#CR					; carriage return?
	beq		Prompt1	
	lbsr	OUTCH				; spit out the character
	bra		Prompt3			; and keep going

; Process the screen line that the CR was keyed on
;
Prompt1:
	ldd		#$5050
	std		LEDS
;	ldb		RunningID
;	cmpb	#61
;	bhi		Prompt3
	clr		CursorCol			; go back to the start of the line
	lbsr	CalcScreenLoc	; calc screen memory location
	tfr		d,y
skipDollar:
	bsr		MonGetNonSpace
	cmpb	#'$'
	beq		skipDollar		; skip over '$' prompt character

; Dispatch based on command
;
	dey
	tfr		y,u							; save off input position
	clrb
	ldx		#cmdTable1
parseCmd1:
	lda		,y+							; get input character
	tst		,x							; test for end of command
	bmi		endOfWord				;
	cmpa	,x+							; does input match command?
	beq		parseCmd1
scanNextWord:
	tst		,x+
	beq		Monitor					; if end of table reached, not a command
	bpl		scanNextWord
	incb
	tfr		u,y							; reset input pointer
	bra		parseCmd1				; try again
endOfWord:
	eora	,x
	asla
	bne		scanNextWord
	; we found the command in the table
	aslb									; b = word index
	ldx		#cmdTable2
	jmp		[b,x]						; execute command

Redirect:
	bsr		MonGetch
	cmpb	#'s'
	bne		Prompt2a
	ldd		#SerialPeekCharDirect
	std		CharInVec
	ldd		#SerialPutChar
	std		CharOutVec
	bra		Monitor
Prompt2a:
	cmpb	#'c'
	bne		Monitor
	ldd		#GetKey
	std		CharInVec
	ldd		#DisplayChar
	std		CharOutVec
	bra		Monitor

PromptHelp:
	ldd		#HelpMsg
	lbsr	DisplayString
	bra		Monitor

PromptClearscreen:
	lbsr	ClearScreen
	lbsr	HomeCursor
	bra		Monitor

MonGetch:
	ldb		,y
	iny
	rts

MonGetNonSpace:
	bsr		MonGetCh
	cmpb	#' '
	beq		MonGetNonSpace
	rts

MonArmBreakpoint:
	lbsr	ArmBreakpoint
	ldb		#$FFF
	stb		BreakpointFlag
	lbra	Monitor
MonDisarmBreakpoint:
	lbsr	DisarmBreakpoint
	lbra	Monitor

;------------------------------------------------------------------------------
; Ignore blanks in the input
; Y = text pointer
; D destroyed
;------------------------------------------------------------------------------
;
ignBlanks:
ignBlanks1:
	bsr		MonGetch
	cmpb	#' '
	beq		ignBlanks1
	dey
	rts

;------------------------------------------------------------------------------
; Multiply number in work area by 10.
;------------------------------------------------------------------------------
Times10:
	pshs	d
	ldd		mon_numwka		; make a copy of the number
	std		mon_numwka+8
	ldd		mon_numwka+2
	std		mon_numwka+10
	bsr		shl_numwka		; shift left = *2
	bsr		shl_numwka		; shift left = *4
	ldd		mon_numwka+2	; add in original value
	addd	mon_numwka+10	; = *5
	ldb		mon_numwka+1
	adcb	mon_numwka+9
	stb		mon_numwka+1
	lda		mon_numwka+0
	adca	mon_numwka+8
	sta		mon_numwka+0
	bsr		shl_numwka		; shift left = * 10
	puls	d,pc
	
;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
GetTwoParams:
	bsr		ignBlanks
	bsr		GetNumber			; get start address of dump
	ldd		mon_numwka
	std		mon_r1
	ldd		mon_numwka+2
	std		mon_r1+2
	bsr		ignBlanks
	bsr		GetNumber			; get end address of dump
	ldd		mon_numwka
	std		mon_r2
	ldd		mon_numwka+2
	std		mon_r2+2
	rts

;------------------------------------------------------------------------------
; Get a range, the end must be greater or equal to the start.
;------------------------------------------------------------------------------
GetRange:
	bsr		GetTwoParams
	ldd		mon_r2+2
	subd	mon_r1+2
	ldd		mon_r2
	sbcb	mon_r1+1
	sbca	mon_r1
	lbcc	grng1
	jsr		[MonErrVec]
	lbra	Monitor
grng1:
	rts

shl_numwka:
	asl		mon_numwka+3
	rol		mon_numwka+2
	rol		mon_numwka+1
	rol		mon_numwka
	rts

;------------------------------------------------------------------------------
; Get a hexidecimal number. Maximum of twelve digits.
;
; Modifies:
; 	Y = text pointer (updated)
; 	D = number of digits
; 	mon_numwka contains number
;------------------------------------------------------------------------------
;
GetHexNumber:
	clrd
	std		mon_numwka	; zero out work area
	std		mon_numwka+2
	pshs	x
	ldx		#0					; max 12 eight digits
gthxn2:
	bsr		MonGetch
	bsr		AsciiToHexNybble
	cmpb	#-1
	beq		gthxn1
	bsr		shl_numwka
	bsr		shl_numwka
	bsr		shl_numwka
	bsr		shl_numwka
	andb	#$0f
	orb		mon_numwka+3
	stb		mon_numwka+3
	inx
	cmpx	#12
	blo		gthxn2
gthxn1:
	tfr		x,d
	puls	x,pc

GetBinNumber:
	clrd
	std		mon_numwka
	std		mon_numwka+2
	pshs	x
	ldx		#0
gtbin2:
	bsr		MonGetch
	bsr		AsciiToBinDigit
	tstb
	bmi		gtbin1
	bsr		shl_numwka
	orb		mon_numwka+3
	stb		mon_numwka+3
	inx
	cpx		#48
	blo		gtbin2
gtbin1:
	tfr		x,d
	puls	x,pc
	
GetDecNumber:
	clrd
	std		mon_numwka
	std		mon_numwka+2
	pshs	x
	ldx		#0
gtdec2:
	bsr		MonGetch
	bsr		AsciiToDecDigit
	tstb
	bmi		gtdec1
	bsr		Times10
	addb	mon_numwka+3
	stb		mon_numwka+3
	ldb		mon_numwka+2
	adcb	#0
	stb		mon_numwka+2
	ldb		mon_numwka+1
	adcb	#0
	stb		mon_numwka+1
	ldb		mon_numwka+0
	adcb	#0
	stb		mon_numwka+0
	inx
	cpx		#15
	blo		gtdec2
gtdec1:
	tfr		x,d
	puls	x,pc

GetNumber:
	bsr		MonGetch
	cmpb	#'+'
	beq		GetDecNumber
	cmpb	#'%'
	beq		GetBinNumber
	dey
	bra		GetHexNumber

;	phx
;	push	r4
;	push	r5
;	ldx		#0
;	ld		r4,#10
;	ld		r5,#10
;gtdcn2:
;	jsr		MonGetch
;	jsr		AsciiToDecNybble
;	cmp		#-1
;	beq		gtdcn1
;	mul		r2,r2,r5
;	add		r2,r1
;	dec		r4
;	bne		gtdcn2
;gtdcn1:
;	txa
;	pop		r5
;	pop		r4
;	plx
;	rts

;------------------------------------------------------------------------------
; Convert ASCII character in the range '0' to '9', 'a' to 'f' or 'A' to 'F'
; to a hex nybble.
;------------------------------------------------------------------------------
;
AsciiToHexNybble:
	cmpb	#'0'
	blo		gthx3
	cmpb	#'9'
	bhi		gthx5
	subb	#'0'
	rts
gthx5:
	cmpb	#'A'
	blo		gthx3
	cmpb	#'F'
	bhi		gthx6
	subb	#'A'
	addb	#10
	rts
gthx6:
	cmpb	#'a'
	blo		gthx3
	cmpb	#'z'
	bhi		gthx3
	subb	#'a'
	addb	#10
	rts
gthx3:
	ldb		#-1		; not a hex number
	rts

AsciiToDecDigit:
	cmpb	#'0'
	blo		gtdc3
	cmpb	#'9'
	bhi		gtdc3
	subb	#'0'
	rts
gtdc3:
	ldb		#-1
	rts

AsciiToBinDigit:
	cmpb	#'0'
	bne		abd1
	clrb
	rts
abd1:
	cmpb	#'1'
	bne		abd2
	ldb		#1
	rts
abd2:
	ldb		#-1
	rts

DisplayErr:
	ldd		#msgErr
	lbsr	DisplayString
	jmp		Monitor

DisplayStringDX
	std		Strptr
	stx		Strptr+2
	jsr		DisplayString
	rts

msgErr:
	fcb	"**Err",CR,LF,0

HelpMsg:
	fcb		"? = Display help",CR,LF
	fcb	"CLS = clear screen",CR,LF
	fcb	"b+ = set breakpoint",CR,LF
	fcb	"b- = clear breakpoint",CR,LF
	fcb	"C19 = run C19 loader",CR,LF
;	db	"S = Boot from SD Card",CR,LF
	fcb	": = Edit memory bytes",CR,LF
;	db	"L = Load sector",CR,LF
;	db	"W = Write sector",CR,LF
	fcb "DR = Dump registers",CR,LF
	fcb	"D = Dump memory",CR,LF
	fcb "DIV = Divider Test", CR, LF
	fcb	"F = Fill memory",CR,LF
	fcb "FL = Dump I/O Focus List",CR,LF
;	fcb "FIG = start FIG Forth",CR,LF
;	db	"KILL n = kill task #n",CR,LF
;	db	"B = start tiny basic",CR,LF
;	db	"b = start EhBasic 6502",CR,LF
	fcb	"J = Jump to code",CR,LF
	fcb	"JD4 = Jump to $FFD400",CR,LF
	fcb	"R[n] = Set register value",CR,LF
;	db	"r = random lines - test bitmap",CR,LF
;	db	"e = ethernet test",CR,LF
	fcb	"s = serial output test",CR,LF
	fcb	"SP = sprite demo",CR,LF
;	db	"T = Dump task list",CR,LF
;	db	"TO = Dump timeout list",CR,LF
	fcb	"TI = display date/time",CR,LF
;	db	"TEMP = display temperature",CR,LF
	fcb	"U = unassemble",CR,LF
;	db	"P = Piano",CR,LF
	fcb	"XM = xmodem transfer",CR,LF
	fcb	"x = exit monitor",CR,LF
	fcb		0

msgRegHeadings
	fcb	CR,LF,"  D/AB     X      Y      U      S       PC    DP  CCR",CR,LF,0
msgDBRegHeadings:
	fcb	CR,LF,"  AD0     AD1    AD2    AD3    CTL0 CTL1 CTL2 CTL3",CR,LF,0
nHEX4:
	jsr		HEX4
	rts

nXBLANK:
	ldb		#' '
	lbra	OUTCH

;------------------------------------------------------------------------------
; Dump Memory
;
; Usage:
; 	$D FFFC12 FFFC20
;
; Dump formatted to look like:
;		:FFFC12 012 012 012 012 555 666 777 888
;
;------------------------------------------------------------------------------

DumpMemory:
	bsr		GetRange
	ldy		#0
	ldy		mon_r1+2
dmpm2:
	lbsr	CRLF
	ldb		#':'
	lbsr	OUTCH
	tfr		y,d
	;addd	mon_r1+2					; output the address
	lbsr	DispWordAsHex
	ldb		#' '
	lbsr	OUTCH
	ldx		#8								; number of bytes to display
dmpm1:
;	ldb		far [mon_r1+1],y
	;ldb		[mon_r1+2],y
	ldb		,y
	iny
	lbsr	DispByteAsHex			; display byte
	ldb		#' '							; followed by a space
	lbsr	OUTCH
	clrb
	clra
	lbsr	INCH
	cmpb	#CTRLC
	beq		dmpm3
	dex
	bne		dmpm1
	; Now output ascii
	ldb		#' '
	lbsr	OUTCH
	ldx		#8								; 8 chars to output
	leay	-8,y							; backup pointer
dmpm5:
;	ldb		far [mon_r1+1],y	; get the char
;	ldb		[mon_r1+2],y			; get the char
	ldb		,y
	cmpb	#$20							; is it a control char?
	bhs		dmpm4
	ldb		#'.'
dmpm4:
	lbsr	OUTCH
	iny
	dex
	bne		dmpm5
	cmpy	mon_r2+2
	blo		dmpm2
dmpm3:
	lbsr	CRLF
	lbra	Monitor

;------------------------------------------------------------------------------
; Edit Memory
;
; Usage:
; 	$$:FFFC12 8 "Hello World!" 0
;
; Dump formatted to look like:
;		:FFFC12 012 012 012 012 555 666 777 888
;
;------------------------------------------------------------------------------

EditMemory:
	ldu		#8						; set max byte count
	lbsr	ignBlanks
	lbsr	GetHexNumber	; get the start address
	ldx		mon_numwka+2
EditMem2:
	lbsr	ignBlanks			; skip over blanks
	lbsr	GetHexNumber	; get the byte value
	tstb								; check for valid value
	beq		EditMem1			; if invalid, quit
	ldb		mon_numwka+3	; get value
	stb		,x+						; update memory at address
	leau	-1,u					; decremeent byte count
	cmpu	#0
	bne		EditMem2			; go back for annother byte
EditMem1:
	lbsr	MonGetch			; see if a string is being entered
	cmpb	#'"'
	bne		EditMem3			; no string, we're done
	ldu		#40						; string must be less than 40 chars
EditMem4:
	lbsr	MonGetch			; look for close quote
	cmpb	#'"'
	bne		EditMem6			; end of string?
	ldu		#8						; reset the byte count
	bra		EditMem2
EditMem6:			
	stb		,x+						; store the character in memory
	leau	-1,u					; decrement byte count
	cmpu	#0
	bhi		EditMem4			; max 40 chars
EditMem3:
	lbra	Monitor
	

;------------------------------------------------------------------------------
; Fill Memory
;
; Usage:
; 	$$F FFFC12 FFFC30 89F
;
;------------------------------------------------------------------------------

FillMemory:
	lbsr	GetRange			; get address range to fill
	lbsr	ignBlanks
	lbsr	GetHexNumber	; get target byte to write
	ldb		mon_numwka+3
	ldx		mon_r1+2
	clra
fillm1:								; Check for a CTRL-C every page of memory
	tsta
	bne		fillm2
	clrb								; we want a non-blocking check
	clra
	lbsr	INCH
	cmpb	#CTRLC
	lbeq	Monitor
	ldb		mon_numwka+3	; reset target byte
fillm2:
	stb		,x+
	cmpx	mon_r2+2
	bls		fillm1
fillm3:
	lbra	Monitor
	
;------------------------------------------------------------------------------
; Dump Registers
;
;	Usage:
;		$DR
;------------------------------------------------------------------------------

DumpRegs:
	ldd		#msgRegHeadings
	lbsr	DisplayString
	bsr		nXBLANK
	ldd		mon_DSAVE
	bsr		nHEX4
	bsr		nXBLANK
	ldd		mon_XSAVE
	bsr		nHEX4
	bsr		nXBLANK
	ldd		mon_YSAVE
	bsr		nHEX4
	bsr		nXBLANK
	ldd		mon_USAVE
	bsr		nHEX4
	bsr		nXBLANK
	ldd		mon_SSAVE
	bsr		nHEX4
	bsr		nXBLANK
	ldb		mon_PCSAVE+1
	lbsr	DispByteAsHex	
	ldd		mon_PCSAVE+2
	bsr		nHEX4
	bsr		nXBLANK
	ldd		mon_DPRSAVE
	jsr		HEX2
	bsr		nXBLANK
	lda		mon_CCRSAVE
	lbsr	HEX2
	bsr		nXBLANK
	ldd		#msgDBRegHeadings
	lbsr	DisplayString
	ldd		BRKAD0
	lbsr  DispWordAsHex
	bsr		nXBLANK
	ldd		BRKAD1
	lbsr  DispWordAsHex
	bsr		nXBLANK
	ldd		BRKAD2
	lbsr  DispWordAsHex
	bsr		nXBLANK
	ldd		BRKAD3
	lbsr  DispWordAsHex
	bsr		nXBLANK
	ldb		BRKCTRL0
	lbsr	DispByteAsHex
	bsr		nXBLANK
	ldb		BRKCTRL1
	lbsr	DispByteAsHex
	bsr		nXBLANK
	ldb		BRKCTRL2
	lbsr	DispByteAsHex
	bsr		nXBLANK
	ldb		BRKCTRL3
	lbsr	DispByteAsHex
	lbsr	CRLF
	lbra	Monitor

;------------------------------------------------------------------------------
; SetRegXXX
;
; Set the value to be loaded into a register.
;------------------------------------------------------------------------------

SetRegA:
	lbsr	ignBlanks
	lbsr	GetNumber
	lda		mon_numwka+3
	sta		mon_DSAVE
	lbra	Monitor
SetRegB:
	lbsr	ignBlanks
	lbsr	GetNumber
	lda		mon_numwka+3
	sta		mon_DSAVE+1
	lbra	Monitor
SetRegD:
	lbsr	ignBlanks
	lbsr	GetNumber
	ldd		mon_numwka+2
	std		mon_DSAVE
	lbra	Monitor
SetRegX:
	lbsr	ignBlanks
	lbsr	GetNumber
	ldd		mon_numwka+2
	std		mon_XSAVE
	lbra	Monitor
SetRegY:
	lbsr	ignBlanks
	lbsr	GetNumber
	ldd		mon_numwka+2
	std		mon_YSAVE
	lbra	Monitor
SetRegU:
	lbsr	ignBlanks
	lbsr	GetNumber
	ldd		mon_numwka+2
	std		mon_USAVE
	lbra	Monitor
SetRegS:
	lbsr	ignBlanks
	lbsr	GetNumber
	ldd		mon_numwka+2
	std		mon_SSAVE
	lbra	Monitor
SetRegDPR:
	lbsr	ignBlanks
	lbsr	GetNumber
	lda		mon_numwka+3
	sta		mon_DPRSAVE
	lbra	Monitor
SetRegCCR:
	lbsr	ignBlanks
	lbsr	GetNumber
	lda		mon_numwka+3
	sta		mon_CCRSAVE
	lbra	Monitor
SetRegPC:
	lbsr	ignBlanks
	lbsr	GetNumber
	ldd		mon_numwka+2
	std		mon_PCSAVE+2
	ldb		mon_numwka+1
	stb		mon_PCSAVE+1
	lbra	Monitor

;------------------------------------------------------------------------------
; Jump to code
;
; Registers are loaded with values from the monitor register save area before
; the code is jumped to.
;
; J <address>
;------------------------------------------------------------------------------

jump_to_code:
	lbsr	ignBlanks
	lbsr	GetNumber
	sei
	lds		mon_SSAVE
	ldd		#jtc_exit			; setup stack for RTS back to monitor
	pshs	d
	ldb		#0
	pshs	b
	ldd		mon_USAVE
	pshs	d
	ldd		mon_YSAVE
	pshs	d
	ldd		mon_XSAVE
	pshs	d
	lda		mon_DPRSAVE
	pshs	a
	ldd		mon_DSAVE
	pshs	d
	lda		mon_CCRSAVE
	pshs	a
	puls	far ccr,d,dpr,x,y,u
	jmp		far [mon_numwka+1]
jtc_exit:
	sts		>mon_SSAVE		; need to use extended addressing, no direct page setting
	leas	$6FFF					; reset stack to system area, dont modify flags register!
	pshs	ccr						; now the stack can be used
	pshs	a							; save acca register so we can use it
	tfr		dpr,a					; a = outgoing dpr value
	sta		>mon_DPRSAVE	; force extended addressing mode usage here dpr is not set
	clra								; dpg register must be set to zero before values are 
	tfr		a,dpr					; saved in the monitor register save area.
	puls	a							; get back acca
	std		mon_DSAVE			; save regsters, can use direct addressing now
	stx		mon_XSAVE
	sty		mon_YSAVE
	stu		mon_USAVE
	puls	a							; get back ccr
	sta		mon_CCRSAVE		; and save it too
	; Reset vectors in case they got toasted.
	ldd		#SerialPeekCharDirect
	std		CharInVec
	ldd		#DisplayChar
	std		CharOutVec
	ldd		DisplayErr
	std		MonErrVec
	; todo set according to coreid
	lbra	DumpRegs			; now go do a register dump

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------

DumpIOFocusList:
	ldx		#0
dfl2:
	ldb		IOFocusList,x
	cmpb	#24
	bne		dfl1
	tfr		x,d
	lbsr	DispByteAsHex
	ldb		#' '
	lbsr	OUTCH
dfl1:
	inx
	cmpx	#16
	blo		dfl2
	lbsr	CRLF
	lbra	Monitor
	
bootpg:
	fcb		$000
boot_stack:
	fcw		$FFC0FF
numBreakpoints:
	fcw		8
mon_rom_vectab:
	fcw		mon_rom_vecs
mon_rom_vecs:
	fcw		Monitor						; enter monitor program
	fcw		INCH							; input a character
	fcw		OUTCH							; output a character
	fcw		CRLF							; output carriage-return, line feed
	fcw		DisplayString
	fcw		DispByteAsHex
	fcw		DispWordAsHex
	fcw		ShowSprites
	fcw		mon_srand
	fcw		mon_rand
	fcw		0									; operating system call
	fcw		GetRange
	fcw		GetNumber
	fcw		SerialPutChar	

NumFuncs	EQU	(*-mon_rom_vectab)/2

; The following table indicates which routines need to return values in the
; D and possibly X registers.

mon_rettab:
	fcb		0			; monitor
	fcb		$800	; INCH
	fcb		0			; OUTCH
	fcb		0			; CRLF
	fcb		0			; DisplayString
	fcb		0			; DisplayByte
	fcb		0			; DisplayWord
	fcb		0			; show sprites
	fcb		0			; srand
	fcb		$C00	; rand
	fcb		$C00	; OS call
	fcb		0			; GetRange
	fcb		$800	; GetNumber
	fcb		0			; SerialPutChar
	
;------------------------------------------------------------------------------
; SWI routine.
;
; SWI is used to call ROM monitor routines and process breakpoints.
;
;	swi
;	fcb <desired function>
;------------------------------------------------------------------------------

swi_rout:
	ldb		bootpg,pcr			; reset direct page
	tfr		b,dp
swi_rout1:
	ldu		11,s						; get program counter (low order 2 bytes)
	leau	-1,u						; backup a byte
	tst		BreakpointFlag	; are we in breakpoint mode?
	beq		swiNotBkpt
	ldy		#Breakpoints
	ldb		NumSetBreakpoints
	beq		swiNotBkpt
swi_rout2:
	cmpu	,y++	
	beq		processBreakpoint
	decb
	bne		swi_rout2
swiNotBkpt:
	clr		BreakpointFlag
	pulu	d								; get function #, increment PC
	cmpb	#NumFuncs
	lbhi	DisplayErr
	stu		11,s						; save updated PC on stack
	cmpb	#MF_OSCALL
	beq		swiCallOS
	aslb									; 2 bytes per vector
	ldx		mon_rom_vectab,pcr
	abx
	ldx		,x
	stx		jmpvec
	lsrb
	ldx		#mon_rettab
	abx
	ldb		,x
	stb		mon_retflag
	sts		mon_SSAVE				; save the stack pointer
	ldd		1,s							; get back D
	ldx		4,s							; get back X
	ldy		6,s							; get back Y
	ldu		8,s							; get back U
	lds		boot_stack,pcr	; and use our own stack
	jsr		[jmpvec]				; call the routine
swi_rout3:
	lds		mon_SSAVE				; restore stack
	tst		mon_retflag
	bpl		swi_rout4
	std		1,s							; return value in D
	asl		mon_retflag
	bpl		swi_rout4
	stx		4,s							; return value in X
swi_rout4:
	rti

;------------------------------------------------------------------------------
; A breakpoint was struck during program execution, process accordingly.
;------------------------------------------------------------------------------

processBreakpoint:
	lda		,s
	sta		mon_CCRSAVE
	ldd		1,s
	std		mon_DSAVE
	ldb		3,s
	stb		mon_DPRSAVE
	ldd		4,s
	std		mon_XSAVE
	ldd		6,s
	std		mon_YSAVE
	ldd		8,s
	std		mon_USAVE
	sts		mon_SSAVE
	ldb		10,s
	stb		mon_PCSAVE
	ldd		11,s
	std		mon_PCSAVE+1
	lds		boot_stack,pcr
	ldd		#swi_rout3			; setup so monitor can return
	pshs	d
	bsr		DisarmAllBreakpoints
	lbra	DumpRegs

xitMonitor:
	bra		ArmAllBreakpoints

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------

swiCallOS:	
	leau	1,u							; next byte is func number
	ldb		,u+
	cmpb	#NumOSFuncs			; check for valid range
	lbhi	DisplayErr
	stu		11,s						; save updateed PC on stack
	aslb									; compute vector address
	ldx		#OSCallTbl
	tst		b,x							; check for non-zero vector
	beq		swi_rout3
osc1:
;	tst		OSSEMA+1				; wait for availability
;	beq		osc1
	jsr		[b,x]						; call the OS routine
oscx:
	clr		OSSEMA+1
	bra		swi_rout3

;------------------------------------------------------------------------------
; DisarmAllBreakpoints, used when entering the monitor.
;------------------------------------------------------------------------------

DisarmAllBreakpoints:
	pshs	d,x,y
	ldy		#0
	clrb
	ldx		#BreakpointBytes	; x = breakpoint byte table address
disarm2:
	cmpb	#numBreakpoints		; safety check
	bhs		disarm1
	cmpb	NumSetBreakpoints
	bhs		disarm1
	lda		b,x								; get memory byte
	sta		[Breakpoints,y]		; and store it back to memory
	leay	2,y								; increment for next address
	incb										; increment to next byte
	bra		disarm2						; loop back
disarm1:
	puls	d,x,y,pc

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------

ArmAllBreakpoints:
	pshs	d,x,y
	ldy		#0
	clrb
	ldx		#BreakpointBytes	; x = breakpoint byte table address
arm2:
	cmpb	numBreakpoints		; safety check
	bhs		arm1
	cmpb	NumSetBreakpoints
	bhs		arm1
	lda		[Breakpoints,y]		; load byte at memory address
	sta		b,x								; save in table
	leay	2,y								; increment for next address
	incb										; increment to next byte
	bra		arm2							; loop back
arm1:
	puls	d,x,y,pc

;------------------------------------------------------------------------------
; b+ h0 123456	; set hardware breakpoint #0 to address 123456
; b+ 987654     ; set software breakpoint to address 987654
;------------------------------------------------------------------------------

ArmBreakpoint:
	pshs	d,x,y
	lda		NumSetBreakpoints		; check if too many breakpoints set
	cmpa	numBreakpoints
;	lbhs	DisplayErr
	lbsr	ignBlanks
	lbsr	MonGetch
	clr		mon_numwka+9
	cmpb	#'h'
	bne		armb1
	lbsr	MonGetch
	stb		mon_numwka+9
	lbsr	ignBlanks
	bra		armb2
armb1:
	dey
armb2:
	lbsr	GetHexNumber				; get address parameter
	tst		mon_numwka+9
	beq		armb3
	ldd		mon_numwka+2
	std		BRKAD0+2
	ldd		mon_numwka
	std		BRKAD0
	ldb		#$08F								; enable breakpoint with exact match
	stb		BRKCTRL0
	lbra	Monitor
armb3:
	tstb
	lbmi	DisplayErr
	ldb		NumSetBreakpoints		; b = number of set breakpoints
	lda		far [mon_numwka+1]	; get byte at address
	ldx		#0
	abx
	sta		BreakpointBytes,x		; and store byte in a table
	lda		#OPC_SWI						; put a SWI instruction in place
	sta		far [mon_numwka+1]
	ldx		#Breakpoints				
	aslb											; index for 2 byte values
	aslb
	abx
	ldy		mon_numwka					; get breakpoint address
	sty		Breakpoints,x				; store the address in a table
	ldy		mon_numwka+2
	sty		Breakpoints+2,x
	lsrb											; size back to single byte
	lsrb
	incb
	stb		NumSetBreakpoints
	puls	d,x,y
	lbra	Monitor

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------

DisarmBreakpoint:
	pshs	d,x,y,u
	lbsr	ignBlanks
	lbsr	GetHexNumber
	tstb
	lbmi	Monitor
	clrb
	clrb
	tfr		d,x									; x = zero too
disarm6:
	cmpb	numBreakpoints			; no more than this many may be set
	bhs		disarm4
	cmpb	NumSetBreakpoints		; number actually set
	bhs		disarm4
	ldy		Breakpoints,x				; y = breakpoint address
	cmpy	mon_numwka+2				; is it the one we want?
	bne		disarm3							; if not, go increment to next
	ldx		mon_numwka+2				; x = memory address
	ldy		#BreakpointBytes
	lda		b,y									; get saved byte from table
	sta		,x									; set the byte at the memory address
	; compress breakpoint table by removing breakpoint
	dec		NumSetBreakpoints		; set the new number of set breakpoints
	pshs	b										; save the position we're removing from
disarm7:
	incb											; set index for next byte
	lda		b,y									; get byte
	decb											; and store it back
	sta		b,y
	incb											; move to next position
	cmpb	numBreakpoints			; hit end of table?
	blo		disarm7
	puls	b										; get back position
	aslb											; times two for word index
	clra
	tfr		d,y
	lsrb											; back to byte index value
disarm8:
	ldu		2,y									; get next breakpoint address
	stu		,y++								; store in current pos, increment
	incb											; increment count
	cmpb	numBreakpoints			; hit end of table?
	blo		disarm8
	puls	d,x,y,u,pc
disarm3:
	leax	2,x
	incb
	bra		disarm6
disarm4:
	puls	d,x,y,u
	lbra	Monitor

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------

ListBreakpoints:
	pshs	d,x
	swi
	fcb		MF_CRLF
	ldx		#0
	ldb		#0
lbrk1:
	cmpb	numBreakpoints
	bhs		lbrk2
	cmpb	NumSetBreakpoints
	bhs		lbrk2
	ldd		Breakpoints,x
	leax	2,x
	incb
	pshs	b
	swi
	fcb		MF_DisplayWordAsHex
	swi
	fcb		MF_CRLF
	puls	b
	bra		lbrk1
lbrk2:
 	puls	d,x
 	lbra	Monitor
 
;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
DivTest:
	lbsr	ignBlanks
	lbsr	GetTwoParams
	lbsr	CRLF
	ldd		mon_r1+2
	divd	mon_r2+3
	pshs	d
	ldb		#'='
	lbsr	OUTCH
	ldb		1,s
	lbsr	DispByteAsHex
	ldb		#' '
	lbsr	OUTCH
	ldb		,s
	lbsr	DispByteAsHex
	leas	2,s
	lbsr	CRLF
	lbra	Monitor

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
dbg_rout:
swi3_rout:
	sei
	lda		,s
	sta		mon_CCRSAVE
	ldd		1,s
	std		mon_DSAVE
	ldb		3,s
	stb		mon_DPRSAVE
	ldd		4,s
	std		mon_XSAVE
	ldd		6,s
	std		mon_YSAVE
	ldd		8,s
	std		mon_USAVE
	sts		mon_SSAVE
	ldd		11,s
	std		mon_PCSAVE
	sts		mon_SSAVE
	lds		#$3FFF
	ldd		#swi3_exit
	pshs	d
	cli
	jmp		DumpRegs
swi3_exit:
	lds		mon_SSAVE
	rti

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
firq_rout:
	rti

irq_rout:
	clrd
	tfr		d,dpr
	setdp	$000
	lbsr	SerialIRQ		; check for recieved character
	lbsr	TimerIRQ

	lda		IrqBase			; get the IRQ flag byte
	lsra
	ora		IrqBase
	anda	#$FE0
	sta		IrqBase

;	inc		TEXTSCR+54		; update IRQ live indicator on screen
;	inc		TEXTSCR+$2000+54
	
	; flash the cursor
	; only bother to flash the cursor for the task with the IO focus.
	lda		COREID
	cmpa	IOFocusID
	bne		tr1a
	lda		CursorFlash		; test if we want a flashing cursor
	beq		tr1a
	lbsr	CalcScreenLoc	; compute cursor location in memory
	tfr		d,y
	inc		$2000,y			; get color code $2000 higher in memory
tr1a:
	rti

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
iop_rout:
	rti

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
nmi_rout:
ipl4_rout:
ipl5_rout:
ipl6_rout:
ipl7_rout:
	ldb		COREID
	lda		#'I'
	ldx		#TEXTSCR+40
	sta		b,x
rti_insn:
ipl1_rout:
ipl2_rout:
ipl3_rout:
	rti

; Special Register Area
	org		$FFFFFFF00
	
; Extended vector table

	org		$FFFFFFFC0
	fcdw		dbg_rout
	fcdw		irq_rout
	fcdw		firq_rout
	fcdw		firq_rout
	fcdw		ipl4_rout
	fcdw		ipl5_rout
	fcdw		ipl6_rout
	fcdw		ipl7_rout

; Interrupt vector table

	org		$FFFFFFFE0
	fcdw		iop_rout		; illegal operation / divide by zero
	fcdw		swi3_rout		; SWI3
	fcdw		rti_insn		; SWI2
	fcdw		firq_rout		; FIRQ
	fcdw		irq_rout		; IRQ
	fcdw		swi_rout		; SWI
	fcdw		nmi_rout		; NMI
	fcdw		start				; RST

; ============================================================================
;        __
;   \\__/ o\    (C) 2022  Robert Finch, Waterloo
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
; Xmodem variables
;
xm_timer				EQU		$FFFFFC020
xm_protocol			EQU		$9F5
xm_flag					EQU		$9F6
xm_checksum			EQU		$9F7
xm_tmp2					EQU		$9F8
xm_packetnum		EQU		$9FA
xm_tmp					EQU		$9FC
xm_crc					EQU		$9FE
xm_ibuf					EQU		$A00	; to $A7F
xm_obuf					EQU		$A80	; to $AFF

; ------------------------------------------------------------------------------
; Send data using XModem.
; ------------------------------------------------------------------------------

xm_SendStart:
	lbsr	GetRange
	ldx		mon_r1+2				; x = buffer address
	tfr		x,u
	ldb		#1							; packet numbers start at one
	stb		xm_packetnum+1
	; Wait for receiver to send a NAK
xm_send:							
	ldd		#-1							; select blocking input
	swi
	fcb		MF_INCH
	cmpb	#NAK						; should have got a NAK
	beq		xm_send5
	cmpb	#'C'						; or a 'C'
	bne		xm_send
xm_send5:
	stb		xm_protocol
xm_send4:
	ldb		#SOH						; send start
	swi
	fcb		OUTCH			
	ldb		xm_packetnum+1	; send packet number
	swi
	fcb		MF_OUTCH
	comb									; one's complement
	swi
	fcb		MF_OUTCH				; send packet number complement
	clra									; acca = byte count
	tfr		x,u							; u = buffer address
xm_send1:
	ldb		,u+							; grab a byte from the buffer
	swi
	fcb		MF_OUTCH				; send it out
	inca
	cmpa	#128						; number of bytes in payload
	blo		xm_send1
	ldb		xm_protocol
	cmpb	#'C'						; CRC protocol?
	bne		xm_send2
	bsr		xm_calc_crc			; compute CRC
	ldd		xm_crc					; get crc
	lsra									; transfer high eight bits first, so
	rorb									; right shift D by eight
	lsra
	rorb
	lsra
	rorb
	lsra
	rorb
	lsra
	rorb
	lsra
	rorb
	lsra
	rorb
	lsra
	rorb
	swi
	fcb		MF_OUTCH				; send out the byte
	ldd		xm_crc					; get back CRC
	swi									
	fcb		MF_OUTCH				; and send out low byte
	bra		xm_send3
xm_send2:
	bsr		xm_calc_checksum
	ldb		xm_checksum
	swi
	fcb		MF_OUTCH
xm_send3:
	swi
	ldd		#-1							; block until input is present
	fcb		MF_INCH
	cmpb	#ACK
	bne		xm_send4				; not an ACK then resend the record
	inc		xm_packetnum		; increment packet number
	leax	128,x						; advance buffer pointer
	cmpx	mon_r2+2
	blo		xm_send4				; go send next record
	ldb		#EOT						; send end of transmission
	swi
	fcb		MF_OUTCH
	swi
	fcb		MF_OUTCH
	swi
	fcb		MF_OUTCH
	rts

; ------------------------------------------------------------------------------
; Get a byte, checking for a receive timeout.
;
; Returns:
;		accb = byte (0 to 255) or -1 if timed out
; ------------------------------------------------------------------------------

xm_getbyte:
xm_gb1:
	tst		xm_timer		; check the timeout - 2048 ticks (3 seconds approx.)
	bmi		xm_gb2
	clra							; non-blocking
	clrb
	swi	
	fcb		MF_INCH			; try and get a character
	bmi		xm_gb1			; if no character, try again
	bsr		xm_outbyteAsHex
	rts
xm_gb2:
	ldb		#-1
	rts

; ------------------------------------------------------------------------------
; XModem Receive
;
; Parameters:
;		none
; Modifies:
;		All
;	Returns:
;		none
; ------------------------------------------------------------------------------

xm_ReceiveStart:
	lbsr	Delay3s				; give a little bit of time for sender
	lbsr	Delay3s
	lbsr	Delay3s
	lbsr	GetNumber			; Get the transfer address
	tstb								; Make sure we got a value
	lbeq	Monitor
	ldx		mon_numwka+2	; X = transfer address
	clr		xm_packetnum	; initialize
	lda		#'C'					; try for CRC first
	sta		xm_protocol
xm_receive:
	lda		#2						; number of times to retry -1
xm_rcv5:
	ldb		xm_protocol		; indicate we want a transfer (send protocol byte)
	swi
	fcb		MF_SerialPutchar
xm_rcv4:
	clr		xm_timer		; clear the timeout
xm_rcv1:
	bsr		xm_getbyte
	tstb
	bmi		xm_retry1		; timeout on protocol id?
	cmpb	#SOH				; it should be start of a transfer
	beq		xm_SOH
	cmpb	#EOT
	beq		xm_EOT			; or end of transfer (EOT)
	cmpb	#CAN
	beq		xm_receive	; might be a cancel
	cmpb	#ETB
	beq		xm_EOT
xm_rcv_nak:					; wasn't a valid start so
	ldb		#NAK				; send a NAK
	swi
	fcb		MF_SerialPutchar	; and try again
	bra		xm_rcv4
xm_SOH:
	bsr		xm_getbyte	; get packet number
	bmi		xm_rcv_to1
	stb		xm_packetnum+1
	pshs	b						; save it
	bsr		xm_getbyte	; get complement of packet number
	bmi		xm_rcv_to2
	addb	,s					; add the two values
	andb	#$FF				; the sum should be $FF
	subb	#$FF
	stb		xm_flag			; should be storing a zero if there is no error
	ldy		#0					; y = payload byte counter
	tfr		x,u
xm_rcv2:
	bsr		xm_getbyte
	bmi		xm_rcv_to1
	stb		,u+					; store the byte to memory
	iny
	cmpy	#128				; 128 bytes per payload
	blo		xm_rcv2
	bsr		xm_getbyte	; get checksum or CRC byte
	bmi		xm_rcv_to1
	stb		xm_tmp			; stuff checksum/CRC byte
	ldb		xm_protocol
	cmpb	#'C'
	bne		xm_rcv_chksum
	bsr		xm_getbyte	; get low order CRC byte
	bmi		xm_rcv_to1
	lda		xm_tmp			; get the high byte
	aslb							; prepare to combine high and low order
	aslb
	aslb
	aslb
	lsra							; shift low nybble of acca into accb
	rorb
	lsra
	rorb
	lsra
	rorb
	lsra
	rorb
	anda	#$00F					; mask off any extra bits
	std 	xm_tmp2
	bsr		xm_calc_crc		; compute the CRC-16 for the received data
	ldd		xm_crc				; and compare to received value
	cmpd	xm_tmp2
	bra		xm_rcv3
xm_rcv_chksum:
	bsr		xm_calc_checksum
	ldb		xm_checksum
	cmpb	xm_tmp				; where we stuffed the byte
xm_rcv3:
	bne		xm_rcv_nak		; if not the same, NAK
	tst		xm_flag
	bne		xm_rcv_nak		; bad packet number?
	ldb		#ACK					; packet recieved okay, send back an ACK
	swi
	fcb		MF_SerialPutchar
	ldb		xm_packetnum+1	; did we receive the same packet
	cmpb	xm_packetnum
	beq		xm_rcv4				; same packet received, dont update buffer pointer
	stb		xm_packetnum	; update last seen packet number
	leax	128,x					; increment buffer pointer
	bra		xm_rcv4				; and go back for next packet
xm_rcv_to2:
	leas	1,s						; get rid of stacked byte
xm_rcv_to1:
	ldd		#msgXmTimeout
	swi
	fcb		MF_DisplayString
	lbra	Monitor
xm_EOT:								; end of transmission received, return
	ldb		#ACK					; ACK the EOT
	swi
	fcb		MF_SerialPutchar
	lbra	Monitor
xm_retry1:
	deca
	bpl		xm_rcv5
	lda		xm_protocol
	cmpa	#NAK					; are we already lowered down to checksum protocol?
	beq		xm_noTransmitter	; did we try both checksum and CRC?
	lda		#NAK
	sta		xm_protocol
	bra		xm_receive
xm_noTransmitter:
	ldd		#msgXmNoTransmitter
	swi
	fcb		MF_DisplayString
	lbra	Monitor	

msgXmTimeout:
	fcb		"Xmodem: timed out",CR,LF,0
msgXmNoTransmitter:
	fcb		"XModem: transmitter not responding",CR,LF,0

; ------------------------------------------------------------------------------
; Calculate checksum value. The checksum is simply the low order eight bits of
; the sum of all the bytes in the payload area.
;
; Stack space:
;		two words
;	Modifies:
;		xm_checksum		contains the checksum value for the record
; Parameters:
;		X = buffer address
;	Returns:
;		none
; ------------------------------------------------------------------------------

xm_calc_checksum:
	pshs	d,x
	clra
	clrb
xm_cs1:
	addb	,x+
	inca
	cmpa	#128
	blo		xm_cs1
	andb	#$FF
	stb		xm_checksum
	puls	d,x,pc

; ------------------------------------------------------------------------------
; Compute CRC-16 of buffer.
;
;int calcrc(char *ptr, int count)
;{
;    int  crc;
;    char i;
;    crc = 0;
;    while (--count >= 0)
;    {
;        crc = crc ^ (int) (*ptr++ << 8);
;        i = 8;
;        do
;        {
;            if (crc & 0x8000)
;                crc = crc << 1 ^ 0x1021;
;            else
;                crc = crc << 1;
;        } while(--i);
;    }
;    return (crc);
;}
;
; Modifies:
;		xm_crc variable
; Parameters:
;		u = buffer address
; Returns:
;		none
; ------------------------------------------------------------------------------

xm_calc_crc:
	pshs	d,x,y,u
	clr		xm_crc
	clr		xm_crc+1	
	ldu		#0					; u = byte count
xm_crc1:
	ldb		,x+					; get byte
	clr		xm_tmp			; save in temp
	stb		xm_tmp+1
	asl		xm_tmp+1		; shift temp eight bits to left		
	rol		xm_tmp
	asl		xm_tmp+1
	rol		xm_tmp
	asl		xm_tmp+1
	rol		xm_tmp
	asl		xm_tmp+1
	rol		xm_tmp
	asl		xm_tmp+1
	rol		xm_tmp
	asl		xm_tmp+1
	rol		xm_tmp
	asl		xm_tmp+1
	rol		xm_tmp
	asl		xm_tmp+1
	rol		xm_tmp
	ldd		xm_crc		; crc = crc ^ tmp
	eora	xm_tmp
	eorb	xm_tmp+1
	std		xm_crc
	ldy		#0
xm_crc4:
	ldb		xm_crc		; get high byte
	bitb	#$8				; check for $8000
	beq		xm_crc2		; no? then just go shift
	ldd		xm_crc		; load
	aslb						; shift
	rola
	eorb	#$021			; and xor
	eora	#$001
	std		xm_crc		; store it back
	bra		xm_crc3
xm_crc2:
	ldd		xm_crc		; load
	aslb						; shift
	rola
	std		xm_crc		; and store
xm_crc3:
	iny
	cmpy	#8				; repeat eight times
	blo		xm_crc4
	leau	1,u				; increment byte count
	cmpu	#128
	ldd		xm_crc		; we want only a 16-bit CRC
	anda	#$0F
	std		xm_crc
	blo		xm_crc1
	puls	d,x,y,u,pc

xm_outbyteAsHex:
	pshs	d
	ldd		CharOutVec						; get current char out vector
	pshs	d											; save it
	ldd		#ScreenDisplayChar		; set output vector to screen display
	std		CharOUtVec
	ldd		2,s										; get passed data
	lbsr	DispByteAsHex					; and display on-screen
	ldb		#' '
	lbsr	ScreenDisplayChar
	puls	d											; get back old char out vector
	std		CharOutVec						; and restore it
	puls	d											; restore input arguments
	rts

	
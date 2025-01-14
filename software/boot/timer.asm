; ============================================================================
;        __
;   \\__/ o\    (C) 2022  Robert Finch, Waterloo
;    \  __ /    All rights reserved.
;     \/_//     robfinch<remove>@opencores.org
;       ||
;  
;
; Timer routines for a WDC6522 compatible circuit.
;
; This source file is free software: you can redistribute it and/or modify 
; it under the terms of the GNU Lesser General Public License as published 
; by the Free Software Foundation, either version 3 of the License, or     
; (at your option) any later version.                                      
;                                                                          
; This source file is distributed in the hope that it will be useful,      
; but WITHOUT ANY WARRANTY; without even the implied warranty of           
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            
; GNU General Public License for more details.                             
;                                                                          
; You should have received a copy of the GNU General Public License        
; along with this program.  If not, see <http://www.gnu.org/licenses/>.    
;                                                                          
; ============================================================================
;
TimerInit:
	pshs	ccr
	sei										; turn off interrupts while using mapped I/O
	ldd		#VIA_MMU				; VIA MMU setting; map VIA into page $000
	std		MMU
	ldd		#$61A80					; compare to 400000 (100 Hz assuming 40MHz clock)
	stb		VIA_T3CMPL
	sta		VIA_T3CMPH
	clr		VIA_T3LL
	clr		VIA_T3LH
	lda		VIA_ACR			; set continuous mode for timer
	ora		#$100
	sta		VIA_ACR			
	lda		#$880						; enable timer #3 interrupts
	sta		VIA_IER
	ldd		#$000F00				; reset page zero
	std		MMU
	puls	ccr,pc

TimerIRQ:
	ldd		#VIA_MMU			; map VIA to page 0
	std		MMU
	ldd		#PIC_MMU			; map PIC to page 1
	std		MMU+2
	; Reset the edge sense circuit in the PIC
	lda		#31							; Timer is IRQ #31
	sta		$2000+16					; register 16 is edge sense reset reg	
	lda		$2000+$FF					; Timer active interrupt flag
	beq		notTimerIRQ
	clr		$2000+$FF					; clear the flag
	lda		#31							; Timer is IRQ #31
	sta		IrqSource		; stuff a byte indicating the IRQ source for PEEK()
	clr		VIA_T3LL		; should clear the interrupt
	clr		VIA_T3LH
	lda		#31							; Timer is IRQ #31
	sta		$2000+16					; register 16 is edge sense reset reg	
	clr		$2000+$FF					; clear the flag
	inc		$E0003F		; update timer IRQ screen flag
	ldd		milliseconds+2
	addd	#10
	std		milliseconds+2
	ldd		milliseconds
	adcd	#0
	std		milliseconds

	; Update XModem timer, we just always do it rather than testing if XModem
	; is active. The increment is set to give approximately 3s before the MSB
	; gets set.
	ldb		xm_timer
	addb	#4
	stb		xm_timer
notTimerIRQ:
	ldd		#$000F00			; done with VIA, map it out
	std		MMU
	ldd		#$001F00			; done with PIC, map it out
	std		MMU+2
	rts
	
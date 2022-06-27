;APS00000000000000000000000000000000000000000000000000000000000000000000000000000000
add:
	clr.l 	d0
	move.l	#table,a0
	
	move.w	#5,d1
loop:
	add 	(a0)+,d0	; read val and incr addr
	subq	#1,d1
	bne	loop

	rts	
	
table:
	dc.w	2,4,6,8,10

;APS00000000000000000000000000000000000000000000000000000000000000000000000000000000
add:
	clr.l 	d0
	move.l	#table,a0
	
	move.w	#4,d1
loop:
	add 	(a0)+,d0
	dbra	d1,loop		; decr and beq

	rts	
	
table:
	dc.w	2,4,6,8,10

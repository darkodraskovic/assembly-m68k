;APS00000000000000000000000000000000000000000000000000000000000000000000000000000000
add:
	clr.l 	d0
	move.l	#table,a0
	
	move 	0(a0),d0
	add	2(a0),d0	; incr addr and read val
	add	4(a0),d0
	add	6(a0),d0
	add 	8(a0),d0

	rts	
	
table:
	dc.w	2,4,6,8,10

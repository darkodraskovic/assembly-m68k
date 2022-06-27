;APS00000000000000000000000000000000000000000000000000000000000000000000000000000000
add:
	clr.l 	d0
	
	move 	table,d0
	add	table+2,d0
	add	table+4,d0
	add	table+6,d0
	add 	table+8,d0

	rts	
	
table:
	dc.w	2,4,6,8,10	; declare word

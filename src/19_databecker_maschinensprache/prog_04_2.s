;APS00000066000000660000006600000066000000660000006600000066000000660000006600000066
; sort ascending

	movem.l	d0-d7/a0-a6,-(sp)

	move.l	#table,a1
	clr.l	d2
	move	(a1),d2
	add.l	#2,a1

sort:
	move.l 	a1,a0	; table addr to a0
	move.l	d2,d0	; num vals in table
	subq	#2,d0	; fix vals count
	clr	d1	; clr swap marker

loop:
	move	2(a0),d3	; nex val in d3
	cmp	(a0),d3		; cmp prev with next val
	bcc 	noswap		; prev - next >= 0

swap:
	move 	(a0),d1		; move prev to d1
	move	2(a0),(a0)	; move next to addr of prev
	move	d1,2(a0)	; move prev to addr of next
	moveq	#1,d1		; set swap marker

noswap:
	addq.l	#2,a0	; incr counter
	dbra	d0,loop	; cont loop until d0=0
	
	tst	d1	; test swap marker
	bne 	sort	; if swap then cont sort

	movem.l	(sp)+,d0-d7/a0-a6

	rts		

table:
	dc.w	6
	dc.w 	3,5,2,7,11,1

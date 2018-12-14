; Gabriel dos Santos Brito
; Luiz Miguel Saraiva
; Rafael Meliani Velloso

; INVASAO ESPACIAL

jmp main
auxi: var #1
random_a: var #1  ; #16807
random_c: var #1 ; #13
random_m: var #1 ;#65535
random_x: var #1 ;#13

static random_a+#0, #16807
static random_c+#0, #13
static random_m+#0, #65535
static random_x+#0, #13
static auxi+#0, #0

main:
	call print_cage
	loadn r1, #737
	loadn r2, #376
	outchar r1, r2

	loadn r1, #737
	loadn r2, #384
	outchar r1, r2

	loadn r1, #737
	loadn r2, #425
	outchar r1, r2

	loadn r1, #737
	loadn r2, #410
	outchar r1, r2

	loadn r1, #940	;pos_nave
	loadn r2, #0	
	loadn r3, #218	;pos_enemy_1
	loadn r4, #0	;enemy_move_cond
	loadn r5, #0	;pos_enemy_2
	loadn r6, #0	;aux1
	loadn r7, #0	;aux2
	
	call enemy_load_r3
	call enemy_load_r5
	
loop:
	call ship
	call enemy_start_move_0
	
	jmp loop
	

;---- Inicio das Subrotinas de Nave Inimiga-----

enemy_load_r3:
	loadn r3, #0
	loadn r7, #17000
	add r3, r3, r7
	
	call random
	loadn r6, #100
	mul r7, r7, r6
	add r3, r3, r7
	
	call random
	loadn r6, #10
	mul r7, r7, r6
	add r3, r3, r7
	
	call random
	add r3, r3, r7
	
	rts

enemy_load_r5:
	
	loadn r5, #0
	loadn r7, #7000
	add r5, r5, r7
	call random
	loadn r6, #100
	mul r7, r7, r6
	add r5, r5, r7
	call random
	loadn r6, #10
	mul r7, r7, r6
	add r5, r5, r7
	call random
	add r5, r5, r7
	
	rts
;
;40 * L + d + C
;a = Line*1000 + rand(1-5) * 100 + rand(1-5) * 10 + rand(1-5)
;a = 4135
enemy_start_r3:
	loadn r3, #0
	loadn r7, #7000
	add r3, r3, r7
	call random
	loadn r6, #100
	mul r7, r7, r6
	add r3, r3, r7
	call random
	loadn r6, #10
	mul r7, r7, r6
	add r3, r3, r7
	call random
	add r3, r3, r7
	;call score_set
	jmp enemy_r3_return
	
enemy_start_r5:
	loadn r5, #0
	loadn r7, #7000
	add r5, r5, r7
	call random
	loadn r6, #100
	mul r7, r7, r6
	add r5, r5, r7
	call random
	loadn r6, #10
	mul r7, r7, r6
	add r5, r5, r7
	call random
	add r5, r5, r7
	;call score_set
	jmp enemy_r5_return

;-------------------------------------------------------------

enemy_start_move_0:
	push r6
	loadn r6, #10
	cmp r4, r6
	pop r6
	jeq enemy_start_move_1
	inc r4
	rts
	
enemy_start_move_1:
;erase r3
	loadn r6, #1000
	push r2
	push r3
	mov r7, r3
	div r7, r7, r6 ; r7 = r7/1000
	push r7
	mul r7, r7, r6 ; r7 = r7*1000
	sub r7, r3, r7 ; r7 = r3 - r7
	mov r3, r7 ; r3 = r7
	loadn r6, #100
	div r7, r7, r6
	pop r6
	loadn r2, #40
	mul r6, r6, r2
	loadn r2, #18
	add r6, r6, r2
	push r6
	add r6, r6, r7
	loadn r2, #0
	outchar r2, r6
	;print enemy ship 01
	loadn r6, #100
	mul r7, r7, r6
	sub r7, r3, r7
	mov r3, r7
	loadn r6, #10
	div r7, r7, r6
	pop r6
	push r6
	add r6, r6, r7
	loadn r2, #0
	outchar r2, r6
	;print enemy ship 02
	loadn r6, #10
	mul r7, r7, r6
	sub r7, r3, r7
	pop r6
	add r6, r6, r7
	loadn r2, #0
	outchar r2, r6
	pop r3
;erase r5
	loadn r6, #1000
	push r5
	mov r7, r5
	div r7, r7, r6
	push r7
	mul r7, r7, r6
	sub r7, r5, r7
	mov r5, r7
	loadn r6, #100
	div r7, r7, r6
	pop r6
	loadn r2, #40
	mul r6, r6, r2
	loadn r2, #18
	add r6, r6, r2
	push r6
	add r6, r6, r7
	loadn r2, #0
	outchar r2, r6
	;print enemy ship 01
	loadn r6, #100
	mul r7, r7, r6
	sub r7, r5, r7
	mov r5, r7
	loadn r6, #10
	div r7, r7, r6
	pop r6
	push r6
	add r6, r6, r7
	loadn r2, #0
	outchar r2, r6
	;print enemy ship 02
	loadn r6, #10
	mul r7, r7, r6
	sub r7, r5, r7
	pop r6
	add r6, r6, r7
	loadn r2, #0
	outchar r2, r6
	pop r5

	push r3
	loadn r6, #1000
	div r3, r3, r6
	loadn r7, #26
	cmp r3, r7
	pop r3
	pop r2
	jeq enemy_start_r3
	
enemy_r3_return:
	push r5
	loadn r6, #1000
	div r5, r5, r6
	loadn r7, #26
	cmp r5, r7
	pop r5
	jeq enemy_start_r5
	
enemy_r5_return:
	loadn r6, #1000
	add r5, r5, r6
	add r3, r3, r6
	loadn r4, #0

enemy_start_move_2:
	call collide_test
	push r2
	push r3
	;a = r3
	;b = r7
	;push a (s=4135)
	mov r7, r3
	;b = a (b=4135)
	div r7, r7, r6
	;b = b/1000 (b=4)	L
	push r7
	;stack = r3 line -> r5 -> r3
	mul r7, r7, r6
	;b = b*1000 (b=4000)
	sub r7, r3, r7
	;b = a-b (b=135)
	;r7 = 135
	mov r3, r7
	;a = b (a=135)
	;r3 = 135
	loadn r6, #100
	div r7, r7, r6
	;b = b/100 (b=1)		C1
	;r7 = 1
	pop r6
	;r6 = r3 line
	loadn r2, #40
	mul r6, r6, r2
	loadn r2, #18
	add r6, r6, r2
	push r6
	add r6, r6, r7
	loadn r2, #700
	outchar r2, r6
	;print enemy ship 01
	loadn r6, #100
	mul r7, r7, r6
	;b = b*100 (b=100)
	sub r7, r3, r7
	;b = a-b (b=35)
	mov r3, r7
	;a = b (a=35)
	loadn r6, #10
	div r7, r7, r6
	;b = b/10 (b=3)		C2
	;r7 = 3
	pop r6
	push r6
	add r6, r6, r7
	loadn r2, #2500
	outchar r2, r6
	;print enemy ship 02
	loadn r6, #10
	mul r7, r7, r6
	;b = b*10 (b=30)
	sub r7, r3, r7
	;b = a-b (b=5)		C3
	;r7 = 5
	pop r6
	add r6, r6, r7
	loadn r2, #700
	outchar r2, r6
	;print enemy ship 03
	;pop a (a=4135)
	pop r3
	
;-------------------------------------------------------------
	loadn r6, #1000
	push r5
	mov r7, r5
	div r7, r7, r6
	push r7
	mul r7, r7, r6
	sub r7, r5, r7
	mov r5, r7
	loadn r6, #100
	div r7, r7, r6
	pop r6
	loadn r2, #40
	mul r6, r6, r2
	loadn r2, #18
	add r6, r6, r2
	push r6
	add r6, r6, r7
	loadn r2, #1400
	outchar r2, r6
	;print enemy ship 01
	loadn r6, #100
	mul r7, r7, r6
	sub r7, r5, r7
	mov r5, r7
	loadn r6, #10
	div r7, r7, r6
	pop r6
	push r6
	add r6, r6, r7
	loadn r2, #3050
	outchar r2, r6
	;print enemy ship 02
	loadn r6, #10
	mul r7, r7, r6
	sub r7, r5, r7
	pop r6
	add r6, r6, r7
	loadn r2, #1000
	outchar r2, r6
	pop r5
	
;-------------------------------------------------------------
	loadn r4, #0
	pop r2
	rts

;---- Fim das Subrotinas de Carro Inimigo-----
	
;---- Inicio das Subrotinas de Colisão-----	
	
collide:
	loadn r7, #41
	sub r1, r1, r7
	loadn r6, #299
	outchar r6, r1
	inc r1
	loadn r6, #557
	outchar r6, r1
	inc r1
	loadn r6, #300
	outchar r6, r1
	loadn r7, #40
	add r1, r1, r7
	loadn r6, #558
	outchar r6, r1
	add r1, r1, r7
	loadn r6, #299
	outchar r6, r1
	dec r1
	loadn r6, #557
	outchar r6, r1
	dec r1
	loadn r6, #300
	outchar r6, r1
	sub r1, r1, r7
	loadn r6, #558
	outchar r6, r1
	call print_msg
	jmp restart_0
	
;---- Fim das Subrotinas de Colisão-----
	
collide_test:
	push r2
	push r4
	push r6
	push r7
	
	;collide r3
	push r3
	loadn r6, #1000
	mov r7, r3
	div r7, r7, r6
	push r7
	mul r7, r7, r6
	sub r7, r3, r7
	mov r3, r7
	loadn r6, #100
	div r7, r7, r6
	pop r6
	loadn r2, #40
	mul r6, r6, r2
	loadn r2, #18
	add r6, r6, r2
	push r6
	add r6, r6, r7
	cmp r1, r6
	jeq collide
	
	;collide enemy ship 01
	loadn r6, #100
	mul r7, r7, r6
	sub r7, r3, r7
	mov r3, r7
	loadn r6, #10
	div r7, r7, r6
	pop r6
	push r6
	add r6, r6, r7
	cmp r1, r6
	jeq collide
	;collide enemy ship 02
	loadn r6, #10
	mul r7, r7, r6
	sub r7, r3, r7
	pop r6
	add r6, r6, r7
	cmp r1, r6
	pop r3
	jeq collide

	;collide r5

	push r5
	loadn r6, #1000
	mov r7, r5
	div r7, r7, r6
	push r7
	mul r7, r7, r6
	sub r7, r5, r7
	mov r5, r7
	loadn r6, #100
	div r7, r7, r6
	pop r6
	loadn r2, #40
	mul r6, r6, r2
	loadn r2, #18
	add r6, r6, r2
	push r6
	add r6, r6, r7
	cmp r1, r6
	jeq collide
		;collide enemy ship 01
	loadn r6, #100
	mul r7, r7, r6
	sub r7, r5, r7
	mov r5, r7
	loadn r6, #10
	div r7, r7, r6
	pop r6
	push r6
	add r6, r6, r7
	cmp r1, r6
	jeq collide
		;collide enemy ship 02
	loadn r6, #10
	mul r7, r7, r6
	sub r7, r5, r7
	pop r6
	add r6, r6, r7
	cmp r1, r6
	pop r5
	jeq collide


	;----------------------

	pop r7
	pop r6
	pop r4
	pop r2

	rts
	
;---- Inicio das Subrotinas de Movimentação-----

ship:
	call delay
	loadn r7, #0
	outchar r7, r1
	moveship:
		push r1
		push r3
		push r4
		push r5
		inchar r1
		loadn r5, #'a'
		cmp r1, r5
		jeq  left
		loadn r5, #'d'
		cmp r1, r5
		jeq right
		loadn r5, #'s'
		cmp r1, r5
		jeq down
		loadn r5, #'w'
		cmp r1, r5
		jeq up
		pop r5
		pop r4
		pop r3
		pop r1
	move_back:
		loadn r7, #42
		outchar r7, r1
		rts

	left:
		pop r5
		pop r4
		pop r3
		pop r1
		dec r1
		loadn r7, #40
		mod r7, r1, r7
		loadn r6, #17
		cmp r6, r7
		jeq move_left_over
		cmp r1, r3
		call collide_test
		jmp move_back
	right:
		pop r5
		pop r4
		pop r3
		pop r1
		inc r1
		loadn r7, #40
		mod r7, r1, r7
		loadn r6, #23
		cmp r6, r7
		jeq move_right_over
		cmp r1, r3
		call collide_test
		jmp move_back
	down:
		pop r5
		pop r4
		pop r3
		pop r1
		loadn r7, #40
		add r1, r1, r7
		loadn r7, #1023
		cmp r1, r7
		jeg move_down_over
		cmp r1, r3
		call collide_test
		jmp move_back
	up:
		pop r5
		pop r4
		pop r3
		pop r1
		loadn r7, #40
		sub r1, r1, r7
		loadn r7, #857
		cmp r1, r7
		jel move_up_over
		cmp r1, r3
		call collide_test
		jmp move_back

move_down_over:
	loadn r7, #40
	sub r1, r1, r7
	jmp move_back

move_up_over:
	loadn r7, #40
	add r1, r1, r7
	jmp move_back
	
move_left_over:
	loadn r7, #1200
	inc r1
	jmp move_back
	
move_right_over:
	loadn r7, #1200
	dec r1
	jmp move_back

;---- Inicio das Subrotinas de Random-----

random:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    load r0  , random_a
    load r1  , random_c
    load r2  , random_m
    load r3  , random_x
    load r4  , auxi

    mul r3 , r0 , r3
    add r3 , r1 , r3
    mul r3 , r3 , r4
    mod r3 , r3 , r2
    mov r7 , r3
    inc r4

    store  random_a , r0
    store  random_c , r1 
    store  random_m , r2 
    store  random_x , r3 
    store  auxi , r4
    loadn r4, #5
    mod r7, r7, r4
    loadn r4, #0
    cmp r7, r4
    jle not_neg
    
not_neg_return:
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

;---- Inicio das Subrotinas de Delay-----

delay:
	push r0
	push r1
	loadn r1, #100
delay1:
	loadn r0, #600
delay2:
	dec r0
	jnz delay2
	dec r1
	jnz delay1
	pop r1
	pop r0
	rts
	
restart_0:
	loadn r3, #0
	loadn r1, #40
	loadn r4, #1200
	call delay
restart_1:
	outchar r3, r1
	inc r1
	cmp r1, r4
	jeq main
	jmp restart_1
	
print_msg:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7


	loadn r1, #87
	loadn r4, #96
	
	loadn r1, #87
	inc r4
	outchar r1, r4
	loadn r1, #65
	inc r4
	outchar r1, r4
	loadn r1, #83
	inc r4
	outchar r1, r4
	loadn r1, #84
	inc r4
	outchar r1, r4
	loadn r1, #69
	inc r4
	outchar r1, r4
	loadn r1, #66
	inc r4
	outchar r1, r4

space_wait_loop:
	inchar r1
	loadn r2, #' '
	cmp r1, r2
	jeq space_wait_out
	jmp space_wait_loop
	
space_wait_out:
	loadn r3, #0
	loadn r1, #90
	loadn r4, #120
space_wait_erase:
	outchar r3, r1
	inc r1
	cmp r1, r4
	jeq space_wait_exit
	jmp space_wait_erase
space_wait_exit:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

not_neg:
	loadn r4, #13
	add r7, r7, r4
	loadn r4, #5
	mod r7, r7, r4
	jmp not_neg_return
	
print_cage:
	; parede da esquerda
	loadn r1, #377
	loadn r2, #40
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	add r1, r1, r2
	outchar r2, r1
	

	; parede da direita
	loadn r1, #383
	loadn r3, #41
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	add r1, r1, r2
	outchar r3, r1
	rts
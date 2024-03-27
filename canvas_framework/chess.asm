.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc

includelib canvas.lib
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
window_title DB "Exemplu proiect desenare",0
area_width EQU 644
area_height EQU 644
area DD 0

counter DD 0 ; numara evenimentele de tip timer
clickcounter DD 0 ; numara evenimentele de tip click

arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20

symbol_width EQU 10
symbol_height EQU 20
include digits.inc
include letters.inc

.code
; procedura make_text afiseaza o litera sau o cifra la coordonatele date
; arg1 - simbolul de afisat (litera sau cifra)
; arg2 - pointer la vectorul de pixeli
; arg3 - pos_x
; arg4 - pos_y
make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0FFFFFFh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp

; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm

line_horizontal macro x, y, len, color
    local bucla_linie
    mov ebx, area_width
    mov eax, y
    mul ebx
    add eax, x
    shl eax, 2
    add eax, area
    mov ecx, len
bucla_linie:
    mov ebx, color
    mov dword ptr [eax], ebx
    add eax, 4
    loop bucla_linie
endm

line_vertical macro x,y,len,color
    local bucla_linie
    mov eax, y
    mov ebx, area_width
    mul ebx
    add eax,x
    shl eax,2
    add eax,area
    mov ecx,len
bucla_linie:
    mov dword ptr[eax],color
    add eax,area_width * 4
    loop bucla_linie
endm


; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click)
; arg2 - x
; arg3 - y
draw proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1]
	cmp eax, 1
	jz evt_click
	cmp eax, 2
	jz evt_timer ; nu s-a efectuat click pe nimic
	;mai jos e codul care intializeaza fereastra cu pixeli albi
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	jmp afisare_litere



	
evt_click:
	; mov eax, [ebp+arg3] ; EAX = y
	; mov ebx, area_width
	; mul ebx ; EAX = y * area_width
	; add eax, [ebp+arg2] ; EAX = y * area_width + x
	; shl eax, 2 ; EAX = (y * area_width +x) * 4
	; add eax, area
	; mov dword ptr[eax], 0FF0000h
	; mov dword ptr[eax+4], 0FF0000h
	; mov dword ptr[eax-4], 0FF0000h
	; mov dword ptr[eax+4*area_width], 0FF0000h 
	; mov dword ptr[eax-4*area_width], 0FF0000h 
	inc clickcounter
	cmp clickcounter,1
	je chess_board

	
	cmp clickcounter, 2
	je mutare1
	
click_mutare2:
	cmp clickcounter, 3
	je mutare2
	
click_mutare3:
	cmp clickcounter, 4
	je mutare3
	
click_mutare4:
	cmp clickcounter, 5
	je mutare4
	
click_mutare5:
	cmp clickcounter, 6
	je mutare5
	
click_mutare6:
	cmp clickcounter, 7
	je mutare6
	
click_mutare7:
	cmp clickcounter, 8
	je mutare7
	
click_mutare8:
	cmp clickcounter, 9
	je mutare8
	
click_mutare9:
	cmp clickcounter, 10
	je mutare9
	
click_mutare10:
	cmp clickcounter, 11
	je mutare10
	
click_mutare11:
	cmp clickcounter, 12
	je mutare11
	
click_mutare12:
	cmp clickcounter, 13
	je mutare12
	
click_mutare13:
	cmp clickcounter, 14
	je mutare13
	
click_mutare14:

	jmp afisare_litere
	
mutare1:
;e4
	make_text_macro ' ', area, 345, 500
	make_text_macro ' ', area, 355, 500
	make_text_macro ' ', area, 365, 500
	make_text_macro ' ', area, 366, 500
	make_text_macro ' ', area, 345, 510
	make_text_macro ' ', area, 345, 520
	make_text_macro ' ', area, 345, 530
	make_text_macro ' ', area, 345, 531
	make_text_macro ' ', area, 366, 510
	make_text_macro ' ', area, 366, 520
	make_text_macro ' ', area, 366, 530
	make_text_macro ' ', area, 366, 531
	make_text_macro ' ', area, 360, 531
	make_text_macro ' ', area, 350, 531
	
	line_vertical 345, 340, 50, 0000FFFh
	line_vertical 375, 340, 50, 0000FFFh
	line_horizontal 345, 340, 30, 0000FFFh
	line_horizontal 345, 390, 30, 0000FFFh
	line_horizontal 345, 355, 30, 0000FFFh
	jmp click_mutare2
	
mutare2:
;e5
	make_text_macro ' ', area, 345, 100
	make_text_macro ' ', area, 355, 100
	make_text_macro ' ', area, 365, 100
	make_text_macro ' ', area, 366, 100
	make_text_macro ' ', area, 345, 110
	make_text_macro ' ', area, 345, 120
	make_text_macro ' ', area, 345, 130
	make_text_macro ' ', area, 345, 131
	make_text_macro ' ', area, 366, 110
	make_text_macro ' ', area, 366, 120
	make_text_macro ' ', area, 366, 130
	make_text_macro ' ', area, 366, 131
	make_text_macro ' ', area, 360, 131
	make_text_macro ' ', area, 350, 131
	
	line_vertical 345, 260, 50, 0000000h
	line_vertical 375, 260, 50, 0000000h
	line_horizontal 345, 260, 30, 0000000h
	line_horizontal 345, 310, 30, 0000000h
	line_horizontal 345, 275, 30, 0000000h
	jmp click_mutare3
	
mutare3:
;d4
	make_text_macro ' ', area, 265, 500
	make_text_macro ' ', area, 275, 500
	make_text_macro ' ', area, 285, 500
	make_text_macro ' ', area, 286, 500
	make_text_macro ' ', area, 265, 510
	make_text_macro ' ', area, 265, 520
	make_text_macro ' ', area, 265, 530
	make_text_macro ' ', area, 265, 531
	make_text_macro ' ', area, 286, 510
	make_text_macro ' ', area, 286, 520
	make_text_macro ' ', area, 286, 530
	make_text_macro ' ', area, 286, 531
	make_text_macro ' ', area, 280, 531
	make_text_macro ' ', area, 270, 531
	
	line_vertical 265, 340, 50, 0000FFFh
	line_vertical 295, 340, 50, 0000FFFh
	line_horizontal 265, 340, 30, 0000FFFh
	line_horizontal 265, 390, 30, 0000FFFh
	line_horizontal 265, 355, 30, 0000FFFh
	jmp click_mutare4
	
mutare4:	
;nf6
	make_text_macro ' ', area, 505, 20
	make_text_macro ' ', area, 515, 30
	make_text_macro ' ', area, 525, 30
	make_text_macro ' ', area, 535, 30
	make_text_macro ' ', area, 505, 30
	make_text_macro ' ', area, 495, 20
	make_text_macro ' ', area, 496, 30
	make_text_macro ' ', area, 535, 40
	make_text_macro ' ', area, 535, 50
	make_text_macro ' ', area, 535, 60
	make_text_macro ' ', area, 495, 40
	make_text_macro ' ', area, 495, 50
	make_text_macro ' ', area, 495, 60
	
	line_vertical 420, 180, 50, 0000000h
	line_vertical 460, 200, 30, 0000000h
	line_horizontal 420, 200, 40, 0000000h
	line_vertical 420, 180, 50, 0000000h
	line_vertical 460, 200, 30, 0000000h
	line_horizontal 420, 200, 40, 0000000h
	jmp click_mutare5
	
mutare5:
;dxe5
	make_text_macro ' ', area, 265, 340
	make_text_macro ' ', area, 275, 340
	make_text_macro ' ', area, 285, 340
	make_text_macro ' ', area, 286, 340
	make_text_macro ' ', area, 265, 350
	make_text_macro ' ', area, 265, 360
	make_text_macro ' ', area, 265, 370
	make_text_macro ' ', area, 265, 371
	make_text_macro ' ', area, 286, 350
	make_text_macro ' ', area, 286, 360
	make_text_macro ' ', area, 286, 370
	make_text_macro ' ', area, 286, 371
	make_text_macro ' ', area, 280, 371
	make_text_macro ' ', area, 270, 371
	
	make_text_macro ' ', area, 345, 260
	make_text_macro ' ', area, 355, 260
	make_text_macro ' ', area, 365, 260
	make_text_macro ' ', area, 366, 260
	make_text_macro ' ', area, 345, 270
	make_text_macro ' ', area, 345, 280
	make_text_macro ' ', area, 345, 290
	make_text_macro ' ', area, 345, 291
	make_text_macro ' ', area, 366, 270
	make_text_macro ' ', area, 366, 280
	make_text_macro ' ', area, 366, 290
	make_text_macro ' ', area, 366, 291
	make_text_macro ' ', area, 360, 291
	make_text_macro ' ', area, 350, 291
	
	line_vertical 345, 260, 50, 0000FFFh
	line_vertical 375, 260, 50, 0000FFFh
	line_horizontal 345, 260, 30, 0000FFFh
	line_horizontal 345, 310, 30, 0000FFFh
	line_horizontal 345, 275, 30, 0000FFFh
	
	jmp click_mutare6
	
mutare6:
;nxe4
	make_text_macro ' ', area, 425, 180
	make_text_macro ' ', area, 435, 190
	make_text_macro ' ', area, 445, 190
	make_text_macro ' ', area, 455, 190
	make_text_macro ' ', area, 425, 190
	make_text_macro ' ', area, 415, 180
	make_text_macro ' ', area, 416, 190
	make_text_macro ' ', area, 455, 200
	make_text_macro ' ', area, 455, 210
	make_text_macro ' ', area, 455, 220
	make_text_macro ' ', area, 415, 200
	make_text_macro ' ', area, 415, 210
	make_text_macro ' ', area, 415, 220
	
	make_text_macro ' ', area, 345, 340
	make_text_macro ' ', area, 355, 340
	make_text_macro ' ', area, 365, 340
	make_text_macro ' ', area, 366, 340
	make_text_macro ' ', area, 345, 350
	make_text_macro ' ', area, 345, 360
	make_text_macro ' ', area, 345, 370
	make_text_macro ' ', area, 345, 371
	make_text_macro ' ', area, 366, 350
	make_text_macro ' ', area, 366, 360
	make_text_macro ' ', area, 366, 370
	make_text_macro ' ', area, 366, 371
	make_text_macro ' ', area, 360, 371
	make_text_macro ' ', area, 350, 371
	
	line_vertical 340, 340, 50, 0000000h
	line_vertical 380, 360, 30, 0000000h
	line_horizontal 340, 360, 40, 0000000h
	line_vertical 340, 340, 50, 0000000h
	line_vertical 380, 360, 30, 0000000h
	line_horizontal 340, 360, 40, 0000000h

	jmp click_mutare7
	
mutare7:
;bf4
	make_text_macro ' ', area, 185, 580
	make_text_macro ' ', area, 195, 580
	make_text_macro ' ', area, 205, 580
	make_text_macro ' ', area, 206, 580
	make_text_macro ' ', area, 185, 590
	make_text_macro ' ', area, 185, 600
	make_text_macro ' ', area, 185, 610
	make_text_macro ' ', area, 185, 611
	make_text_macro ' ', area, 206, 610
	make_text_macro ' ', area, 206, 600
	make_text_macro ' ', area, 206, 610
	make_text_macro ' ', area, 206, 611
	make_text_macro ' ', area, 200, 611
	make_text_macro ' ', area, 190, 611
	make_text_macro ' ', area, 195, 590
	make_text_macro ' ', area, 205, 590
	
	line_vertical 425, 360, 30, 0000FFFh
	line_vertical 455, 360, 30, 0000FFFh
	line_vertical 435, 340, 20, 0000FFFh
	line_vertical 445, 340, 20, 0000FFFh
	line_horizontal 425, 360, 11, 0000FFFh
	line_horizontal 445, 360, 11, 0000FFFh
	line_horizontal 435, 340, 11, 0000FFFh
	line_horizontal 425, 390, 31, 0000FFFh
	
	
	jmp click_mutare8
	
mutare8:
;be2
	make_text_macro ' ', area, 425, 20
	make_text_macro ' ', area, 435, 20
	make_text_macro ' ', area, 445, 20
	make_text_macro ' ', area, 446, 20
	make_text_macro ' ', area, 425, 30
	make_text_macro ' ', area, 425, 40
	make_text_macro ' ', area, 425, 50
	make_text_macro ' ', area, 425, 51
	make_text_macro ' ', area, 446, 50
	make_text_macro ' ', area, 446, 40
	make_text_macro ' ', area, 446, 50
	make_text_macro ' ', area, 446, 51
	make_text_macro ' ', area, 440, 51
	make_text_macro ' ', area, 430, 51
	make_text_macro ' ', area, 435, 30
	make_text_macro ' ', area, 445, 30
	
	line_vertical 345, 120, 30, 0000000h
	line_vertical 375, 120, 30, 0000000h
	line_vertical 355, 100, 20, 0000000h
	line_vertical 365, 100, 20, 0000000h
	line_horizontal 345, 120, 11, 0000000h
	line_horizontal 365, 120, 11, 0000000h
	line_horizontal 355, 100, 11, 0000000h
	line_horizontal 345, 150, 31, 0000000h
	
	jmp click_mutare9

mutare9:
;qa5
	
	make_text_macro ' ', area, 345, 570
	make_text_macro ' ', area, 355, 570
	make_text_macro ' ', area, 365, 570
	make_text_macro ' ', area, 375, 570
	make_text_macro ' ', area, 345, 580
	make_text_macro ' ', area, 355, 580
	make_text_macro ' ', area, 365, 580
	make_text_macro ' ', area, 375, 580
	make_text_macro ' ', area, 345, 590
	make_text_macro ' ', area, 355, 590
	make_text_macro ' ', area, 365, 590
	make_text_macro ' ', area, 375, 590
	make_text_macro ' ', area, 345, 600
	make_text_macro ' ', area, 355, 600
	make_text_macro ' ', area, 365, 600
	make_text_macro ' ', area, 375, 600
	make_text_macro ' ', area, 345, 620
	make_text_macro ' ', area, 355, 620
	make_text_macro ' ', area, 365, 620
	make_text_macro ' ', area, 375, 620
	make_text_macro ' ', area, 335, 620
	make_text_macro ' ', area, 385, 620
	make_text_macro ' ', area, 325, 620
	make_text_macro ' ', area, 325, 610
	make_text_macro ' ', area, 325, 600
	make_text_macro ' ', area, 335, 590
	make_text_macro ' ', area, 335, 610
	make_text_macro ' ', area, 365, 610
	make_text_macro ' ', area, 365, 610
	make_text_macro ' ', area, 385, 610
	
	line_vertical 14, 290, 20, 0000FFFh
	line_vertical 74, 290, 20, 0000FFFh
	line_horizontal 14, 290, 60, 0000FFFh
	line_horizontal 14, 310, 61, 0000FFFh
	line_vertical 34, 280, 10, 0000FFFh
	line_vertical 54, 280, 10, 0000FFFh
	line_horizontal 34, 280, 20, 0000FFFh
	line_vertical 24, 270, 10, 0000FFFh
	line_vertical 64, 270, 10, 0000FFFh
	line_horizontal 24, 280, 41, 0000FFFh
	line_horizontal 24, 270, 40, 0000FFFh
	
	line_vertical 32, 258, 12, 0000FFFh
	line_vertical 56, 258, 12, 0000FFFh
	line_horizontal 32, 258, 4, 0000FFFh
	line_horizontal 53, 258, 4, 0000FFFh
	line_vertical 35, 258, 4, 0000FFFh
	line_vertical 53, 258, 4, 0000FFFh
	line_horizontal 35, 261, 3, 0000FFFh
	line_horizontal 50, 261, 3, 0000FFFh
	line_vertical 38, 258, 4, 0000FFFh
	line_vertical 50, 258, 4, 0000FFFh
	line_horizontal 38, 258, 3, 0000FFFh
	line_horizontal 47, 258, 3, 0000FFFh
	line_vertical 41, 258, 4, 0000FFFh
	line_vertical 47, 258, 4, 0000FFFh
	line_horizontal 41, 261, 6, 0000FFFh
	
	jmp click_mutare10

mutare10:
;f6	

	make_text_macro ' ', area, 425, 100
	make_text_macro ' ', area, 435, 100
	make_text_macro ' ', area, 445, 100
	make_text_macro ' ', area, 446, 100
	make_text_macro ' ', area, 425, 110
	make_text_macro ' ', area, 425, 120
	make_text_macro ' ', area, 425, 130
	make_text_macro ' ', area, 425, 131
	make_text_macro ' ', area, 446, 110
	make_text_macro ' ', area, 446, 120
	make_text_macro ' ', area, 446, 130
	make_text_macro ' ', area, 446, 131
	make_text_macro ' ', area, 440, 131
	make_text_macro ' ', area, 430, 131

	line_vertical 425, 180, 50, 0000000h
	line_vertical 455, 180, 50, 0000000h
	line_horizontal 425, 180, 30, 0000000h
	line_horizontal 425, 230, 30, 0000000h
	line_horizontal 425, 195, 30, 0000000h
	
	jmp click_mutare11
	
mutare11:
;exf6
	
	make_text_macro ' ', area, 345, 260
	make_text_macro ' ', area, 355, 260
	make_text_macro ' ', area, 365, 260
	make_text_macro ' ', area, 366, 260
	make_text_macro ' ', area, 345, 270
	make_text_macro ' ', area, 345, 280
	make_text_macro ' ', area, 345, 290
	make_text_macro ' ', area, 345, 291
	make_text_macro ' ', area, 366, 270
	make_text_macro ' ', area, 366, 280
	make_text_macro ' ', area, 366, 290
	make_text_macro ' ', area, 366, 291
	make_text_macro ' ', area, 360, 291
	make_text_macro ' ', area, 350, 291
	
	make_text_macro ' ', area, 425, 180
	make_text_macro ' ', area, 435, 180
	make_text_macro ' ', area, 445, 180
	make_text_macro ' ', area, 446, 180
	make_text_macro ' ', area, 425, 190
	make_text_macro ' ', area, 425, 200
	make_text_macro ' ', area, 425, 210
	make_text_macro ' ', area, 425, 211
	make_text_macro ' ', area, 446, 190
	make_text_macro ' ', area, 446, 200
	make_text_macro ' ', area, 446, 210
	make_text_macro ' ', area, 446, 211
	make_text_macro ' ', area, 440, 211
	make_text_macro ' ', area, 430, 211
	
	line_vertical 425, 180, 50, 0000FFFh
	line_vertical 455, 180, 50, 0000FFFh
	line_horizontal 425, 180, 30, 0000FFFh
	line_horizontal 425, 230, 30, 0000FFFh
	line_horizontal 425, 195, 30, 0000FFFh
	
	jmp click_mutare12
	
mutare12:
;gxf6
	
	make_text_macro ' ', area, 505, 100
	make_text_macro ' ', area, 515, 100
	make_text_macro ' ', area, 525, 100
	make_text_macro ' ', area, 526, 100
	make_text_macro ' ', area, 505, 110
	make_text_macro ' ', area, 505, 120
	make_text_macro ' ', area, 505, 130
	make_text_macro ' ', area, 505, 131
	make_text_macro ' ', area, 526, 110
	make_text_macro ' ', area, 526, 120
	make_text_macro ' ', area, 526, 130
	make_text_macro ' ', area, 526, 131
	make_text_macro ' ', area, 520, 131
	make_text_macro ' ', area, 510, 131
	
	make_text_macro ' ', area, 425, 180
	make_text_macro ' ', area, 435, 180
	make_text_macro ' ', area, 445, 180
	make_text_macro ' ', area, 446, 180
	make_text_macro ' ', area, 425, 190
	make_text_macro ' ', area, 425, 200
	make_text_macro ' ', area, 425, 210
	make_text_macro ' ', area, 425, 211
	make_text_macro ' ', area, 446, 190
	make_text_macro ' ', area, 446, 200
	make_text_macro ' ', area, 446, 210
	make_text_macro ' ', area, 446, 211
	make_text_macro ' ', area, 440, 211
	make_text_macro ' ', area, 430, 211
	
	line_vertical 425, 180, 50, 0000000h
	line_vertical 455, 180, 50, 0000000h
	line_horizontal 425, 180, 30, 0000000h
	line_horizontal 425, 230, 30, 0000000h
	line_horizontal 425, 195, 30, 0000000h
	
	jmp click_mutare13
	
mutare13:
;qxc7

	make_text_macro ' ', area, 25, 250
	make_text_macro ' ', area, 35, 250
	make_text_macro ' ', area, 45, 250
	make_text_macro ' ', area, 55, 250
	make_text_macro ' ', area, 25, 260
	make_text_macro ' ', area, 35, 260
	make_text_macro ' ', area, 45, 260
	make_text_macro ' ', area, 55, 260
	make_text_macro ' ', area, 25, 270
	make_text_macro ' ', area, 35, 270
	make_text_macro ' ', area, 45, 270
	make_text_macro ' ', area, 55, 270
	make_text_macro ' ', area, 25, 280
	make_text_macro ' ', area, 35, 280
	make_text_macro ' ', area, 45, 280
	make_text_macro ' ', area, 55, 280
	make_text_macro ' ', area, 25, 300
	make_text_macro ' ', area, 35, 300
	make_text_macro ' ', area, 45, 300
	make_text_macro ' ', area, 55, 300
	make_text_macro ' ', area, 15, 300
	make_text_macro ' ', area, 65, 300
	make_text_macro ' ', area, 5, 300
	make_text_macro ' ', area, 5, 290
	make_text_macro ' ', area, 5, 280
	make_text_macro ' ', area, 15, 270
	make_text_macro ' ', area, 15, 290
	make_text_macro ' ', area, 65, 290
	make_text_macro ' ', area, 65, 290
	make_text_macro ' ', area, 55, 290

	make_text_macro ' ', area, 185, 100
	make_text_macro ' ', area, 195, 100
	make_text_macro ' ', area, 205, 100
	make_text_macro ' ', area, 206, 100
	make_text_macro ' ', area, 185, 110
	make_text_macro ' ', area, 185, 120
	make_text_macro ' ', area, 185, 130
	make_text_macro ' ', area, 185, 131
	make_text_macro ' ', area, 206, 110
	make_text_macro ' ', area, 206, 120
	make_text_macro ' ', area, 206, 130
	make_text_macro ' ', area, 206, 131
	make_text_macro ' ', area, 200, 131
	make_text_macro ' ', area, 190, 131

	
	line_vertical 174, 130, 20, 0000FFFh
	line_vertical 234, 130, 20, 0000FFFh
	line_horizontal 174, 130, 60, 0000FFFh
	line_horizontal 174, 150, 61, 0000FFFh
	line_vertical 194, 120, 10, 0000FFFh
	line_vertical 214, 120, 10, 0000FFFh
	line_horizontal 194, 120, 20, 0000FFFh
	line_vertical 184, 110, 10, 0000FFFh
	line_vertical 224, 110, 10, 0000FFFh
	line_horizontal 184, 120, 41, 0000FFFh
	line_horizontal 184, 110, 40, 0000FFFh
	
	line_vertical 192, 98, 12, 0000FFFh
	line_vertical 216, 98, 12, 0000FFFh
	line_horizontal 192, 98, 4, 0000FFFh
	line_horizontal 213, 98, 4, 0000FFFh
	line_vertical 195, 98, 4, 0000FFFh
	line_vertical 213, 98, 4, 0000FFFh
	line_horizontal 195, 101, 3, 0000FFFh
	line_horizontal 210, 101, 3, 0000FFFh
	line_vertical 198, 98, 4, 0000FFFh
	line_vertical 210, 98, 4, 0000FFFh
	line_horizontal 198, 98, 3, 0000FFFh
	line_horizontal 207, 98, 3, 0000FFFh
	line_vertical 201, 98, 4, 0000FFFh
	line_vertical 207, 98, 4, 0000FFFh
	line_horizontal 201, 101, 6, 0000FFFh
	
	make_text_macro 'S', area, 290, 250
	make_text_macro 'A', area, 300, 250
	make_text_macro 'H', area, 310, 250
	make_text_macro 'M', area, 330, 250
	make_text_macro 'A', area, 340, 250
	make_text_macro 'T', area, 350, 250
	make_text_macro 'B', area, 280, 270
	make_text_macro 'L', area, 290, 270
	make_text_macro 'U', area, 300, 270
	make_text_macro 'E', area, 310, 270
	make_text_macro 'W', area, 330, 270
	make_text_macro 'I', area, 340, 270
	make_text_macro 'N', area, 350, 270
	make_text_macro 'S', area, 360, 270
	
	jmp click_mutare14
	
chess_board:
	line_horizontal 1, 1, 644, 0895A0Ch
	line_horizontal 1, 2, 644, 0895A0Ch
	line_horizontal 1, 3, 644, 0895A0Ch
	line_horizontal 1, 4, 644, 0895A0Ch
	line_horizontal 1, 81, 644, 0895A0Ch
	line_horizontal 1, 82, 644, 0895A0Ch
	line_horizontal 1, 83, 644, 0895A0Ch
	line_horizontal 1, 84, 644, 0895A0Ch
	line_horizontal 1, 161, 644, 0895A0Ch
	line_horizontal 1, 162, 644, 0895A0Ch
	line_horizontal 1, 163, 644, 0895A0Ch
	line_horizontal 1, 164, 644, 0895A0Ch
	line_horizontal 1, 241, 644, 0895A0Ch
	line_horizontal 1, 242, 644, 0895A0Ch
	line_horizontal 1, 243, 644, 0895A0Ch
	line_horizontal 1, 244, 644, 0895A0Ch
	line_horizontal 1, 321, 644, 0895A0Ch
	line_horizontal 1, 322, 644, 0895A0Ch
	line_horizontal 1, 323, 644, 0895A0Ch
	line_horizontal 1, 324, 644, 0895A0Ch
	line_horizontal 1, 401, 644, 0895A0Ch
	line_horizontal 1, 402, 644, 0895A0Ch
	line_horizontal 1, 403, 644, 0895A0Ch
	line_horizontal 1, 404, 644, 0895A0Ch
	line_horizontal 1, 481, 644, 0895A0Ch
	line_horizontal 1, 482, 644, 0895A0Ch
	line_horizontal 1, 483, 644, 0895A0Ch
	line_horizontal 1, 484, 644, 0895A0Ch
	line_horizontal 1, 561, 644, 0895A0Ch
	line_horizontal 1, 562, 644, 0895A0Ch
	line_horizontal 1, 563, 644, 0895A0Ch
	line_horizontal 1, 564, 644, 0895A0Ch
	line_horizontal 1, 641, 644, 0895A0Ch
	line_horizontal 1, 642, 644, 0895A0Ch
	line_horizontal 1, 643, 644, 0895A0Ch
	line_horizontal 1, 644, 644, 0895A0Ch
	
	line_vertical 1, 1, 644, 0895A0Ch
	line_vertical 2, 1, 644, 0895A0Ch
	line_vertical 81, 1, 644, 0895A0Ch
	line_vertical 82, 1, 644, 0895A0Ch
	line_vertical 83, 1, 644, 0895A0Ch
	line_vertical 84, 1, 644, 0895A0Ch
	line_vertical 161, 1, 644, 0895A0Ch
	line_vertical 162, 1, 644, 0895A0Ch
	line_vertical 163, 1, 644, 0895A0Ch
	line_vertical 164, 1, 644, 0895A0Ch
	line_vertical 241, 1, 644, 0895A0Ch
	line_vertical 242, 1, 644, 0895A0Ch
	line_vertical 243, 1, 644, 0895A0Ch
	line_vertical 244, 1, 644, 0895A0Ch
	line_vertical 321, 1, 644, 0895A0Ch
	line_vertical 322, 1, 644, 0895A0Ch
	line_vertical 323, 1, 644, 0895A0Ch
	line_vertical 324, 1, 644, 0895A0Ch
	line_vertical 401, 1, 644, 0895A0Ch
	line_vertical 402, 1, 644, 0895A0Ch
	line_vertical 403, 1, 644, 0895A0Ch
	line_vertical 404, 1, 644, 0895A0Ch
	line_vertical 481, 1, 644, 0895A0Ch
	line_vertical 482, 1, 644, 0895A0Ch
	line_vertical 483, 1, 644, 0895A0Ch
	line_vertical 484, 1, 644, 0895A0Ch
	line_vertical 561, 1, 644, 0895A0Ch
	line_vertical 562, 1, 644, 0895A0Ch
	line_vertical 563, 1, 644, 0895A0Ch
	line_vertical 564, 1, 644, 0895A0Ch
	line_vertical 641, 1, 644, 0895A0Ch
	line_vertical 642, 1, 644, 0895A0Ch
	line_vertical 643, 1, 644, 0895A0Ch
	line_vertical 644, 1, 644, 0895A0Ch
	
	;rooks
	
	;black
	
	line_vertical 20, 20, 50, 0000000h
	line_vertical 60, 20, 50, 0000000h
	line_horizontal 20, 30, 40, 0000000h
	line_horizontal 20, 70, 40, 0000000h
	line_vertical 580, 20, 50, 0000000h
	line_vertical 620, 20, 50, 0000000h
	line_horizontal 580, 30, 40, 0000000h
	line_horizontal 580, 70, 40, 0000000h
	;blue
	line_vertical 20, 580, 50, 0000FFFh
	line_vertical 60, 580, 50, 0000FFFh
	line_horizontal 20, 590, 40, 0000FFFh
	line_horizontal 20, 630, 40, 0000FFFh
	line_vertical 580, 580, 50, 0000FFFh
	line_vertical 620, 580, 50, 0000FFFh
	line_horizontal 580, 590, 40, 0000FFFh
	line_horizontal 580, 630, 40, 0000FFFh
	
	;knights
	
	;black
	
	line_vertical 100, 20, 50, 0000000h
	line_vertical 140, 40, 30, 0000000h
	line_horizontal 100, 40, 40, 0000000h
	line_vertical 500, 20, 50, 0000000h
	line_vertical 540, 40, 30, 0000000h
	line_horizontal 500, 40, 40, 0000000h
	
	;blue
	
	line_vertical 100, 580, 50, 0000FFFh
	line_vertical 140, 600, 30, 0000FFFh
	line_horizontal 100, 600, 40, 0000FFFh
	line_vertical 500, 580, 50, 0000FFFh
	line_vertical 540, 600, 30, 0000FFFh
	line_horizontal 500, 600, 40, 0000FFFh
	
	;bishops
	
	;black
	
	line_vertical 185, 40, 30, 0000000h
	line_vertical 215, 40, 30, 0000000h
	line_vertical 195, 20, 20, 0000000h
	line_vertical 205, 20, 20, 0000000h
	line_horizontal 185, 40, 11, 0000000h
	line_horizontal 205, 40, 11, 0000000h
	line_horizontal 195, 20, 11, 0000000h
	line_horizontal 185, 70, 31, 0000000h
	line_vertical 425, 40, 30, 0000000h
	line_vertical 455, 40, 30, 0000000h
	line_vertical 435, 20, 20, 0000000h
	line_vertical 445, 20, 20, 0000000h
	line_horizontal 425, 40, 11, 0000000h
	line_horizontal 445, 40, 11, 0000000h
	line_horizontal 435, 20, 11, 0000000h
	line_horizontal 425, 70, 31, 0000000h
	
	;blue
	
	line_vertical 185, 600, 30, 0000FFFh
	line_vertical 215, 600, 30, 0000FFFh
	line_vertical 195, 580, 20, 0000FFFh
	line_vertical 205, 580, 20, 0000FFFh
	line_horizontal 185, 600, 11, 0000FFFh
	line_horizontal 205, 600, 11, 0000FFFh
	line_horizontal 195, 580, 11, 0000FFFh
	line_horizontal 185, 630, 31, 0000FFFh
	line_vertical 425, 600, 30, 0000FFFh
	line_vertical 455, 600, 30, 0000FFFh
	line_vertical 435, 580, 20, 0000FFFh
	line_vertical 445, 580, 20, 0000FFFh
	line_horizontal 425, 600, 11, 0000FFFh
	line_horizontal 445, 600, 11, 0000FFFh
	line_horizontal 435, 580, 11, 0000FFFh
	line_horizontal 425, 630, 31, 0000FFFh
	
	;kings
	
	;black
	
	line_vertical 254, 50, 20, 0000000h
	line_vertical 314, 50, 20, 0000000h
	line_horizontal 254, 50, 60, 0000000h
	line_horizontal 254, 70, 61, 0000000h
	line_vertical 260, 35, 15, 0000000h
	line_vertical 308, 35, 15, 0000000h
	line_horizontal 260, 35, 48, 0000000h
	line_vertical 274, 20, 15, 0000000h
	line_vertical 294, 20, 15, 0000000h
	line_horizontal 274, 20, 20, 0000000h
	line_vertical 282, 14, 6, 0000000h
	line_vertical 286, 14, 6, 0000000h
	line_horizontal 280, 14, 2, 0000000h
	line_horizontal 286, 14, 2, 0000000h
	line_vertical 280, 12, 2, 0000000h
	line_vertical 288, 12, 3, 0000000h
	line_horizontal 280, 12, 3, 0000000h
	line_horizontal 286, 12, 3, 0000000h
	line_vertical 282, 10, 2, 0000000h
	line_vertical 286, 10, 2, 0000000h
	line_horizontal 282, 10 , 4, 0000000h
	
	;blue
	
	line_vertical 254, 610, 20, 0000FFFh
	line_vertical 314, 610, 20, 0000FFFh
	line_horizontal 254, 610, 60, 0000FFFh
	line_horizontal 254, 630, 61, 0000FFFh
	line_vertical 260, 595, 15, 0000FFFh
	line_vertical 308, 595, 15, 0000FFFh
	line_horizontal 260, 595, 48, 0000FFFh
	line_vertical 274, 580, 15, 0000FFFh
	line_vertical 294, 580, 15, 0000FFFh
	line_horizontal 274, 580, 20, 0000FFFh
	line_vertical 282, 574, 6, 0000FFFh
	line_vertical 286, 574, 6, 0000FFFh
	line_horizontal 280, 574, 2, 0000FFFh
	line_horizontal 286, 574, 2, 0000FFFh
	line_vertical 280, 572, 2, 0000FFFh
	line_vertical 288, 572, 3, 0000FFFh
	line_horizontal 280, 572, 3, 0000FFFh
	line_horizontal 286, 572, 3, 0000FFFh
	line_vertical 282, 570, 2, 0000FFFh
	line_vertical 286, 570, 2, 0000FFFh
	line_horizontal 282, 570 , 4, 0000FFFh
	
	;queens
	
	;black
	
	line_vertical 334, 50, 20, 0000000h
	line_vertical 394, 50, 20, 0000000h
	line_horizontal 334, 50, 60, 0000000h
	line_horizontal 334, 70, 61, 0000000h
	line_vertical 354, 40, 10, 0000000h
	line_vertical 374, 40, 10, 0000000h
	line_horizontal 354, 40, 20, 0000000h
	line_vertical 344, 30, 10, 0000000h
	line_vertical 384, 30, 10, 0000000h
	line_horizontal 344, 40, 41, 0000000h
	line_horizontal 344, 30, 40, 0000000h
	
	;crown
	
	line_vertical 352, 18, 12, 0000000h
	line_vertical 376, 18, 12, 0000000h
	line_horizontal 352, 18, 4, 0000000h
	line_horizontal 373, 18, 4, 0000000h
	line_vertical 355, 18, 4, 0000000h
	line_vertical 373, 18, 4, 0000000h
	line_horizontal 355, 21, 3, 0000000h
	line_horizontal 370, 21, 3, 0000000h
	line_vertical 358, 18, 4, 0000000h
	line_vertical 370, 18, 4, 0000000h
	line_horizontal 358, 18, 3, 0000000h
	line_horizontal 367, 18, 3, 0000000h
	line_vertical 361, 18, 4, 0000000h
	line_vertical 367, 18, 4, 0000000h
	line_horizontal 361, 21, 6, 0000000h
	
	;blue

	line_vertical 334, 610, 20, 0000FFFh
	line_vertical 394, 610, 20, 0000FFFh
	line_horizontal 334, 610, 60, 0000FFFh
	line_horizontal 334, 630, 61, 0000FFFh
	line_vertical 354, 600, 10, 0000FFFh
	line_vertical 374, 600, 10, 0000FFFh
	line_horizontal 354, 600, 20, 0000FFFh
	line_vertical 344, 590, 10, 0000FFFh
	line_vertical 384, 590, 10, 0000FFFh
	line_horizontal 344, 600, 41, 0000FFFh
	line_horizontal 344, 590, 40, 0000FFFh
	
	;crown
	
	line_vertical 352, 578, 12, 0000FFFh
	line_vertical 376, 578, 12, 0000FFFh
	line_horizontal 352, 578, 4, 0000FFFh
	line_horizontal 373, 578, 4, 0000FFFh
	line_vertical 355, 578, 4, 0000FFFh
	line_vertical 373, 578, 4, 0000FFFh
	line_horizontal 355, 581, 3, 0000FFFh
	line_horizontal 370, 581, 3, 0000FFFh
	line_vertical 358, 578, 4, 0000FFFh
	line_vertical 370, 578, 4, 0000FFFh
	line_horizontal 358, 578, 3, 0000FFFh
	line_horizontal 367, 578, 3, 0000FFFh
	line_vertical 361, 578, 4, 0000FFFh
	line_vertical 367, 578, 4, 0000FFFh
	line_horizontal 361, 581, 6, 0000FFFh
	
	;pawns
	
	;black
	
	;pawn1
	
	line_vertical 25, 100, 50, 0000000h
	line_vertical 55, 100, 50, 0000000h
	line_horizontal 25, 100, 30, 0000000h
	line_horizontal 25, 150, 30, 0000000h
	line_horizontal 25, 115, 30, 0000000h
	
	;pawn2
	
	line_vertical 105, 100, 50, 0000000h
	line_vertical 135, 100, 50, 0000000h
	line_horizontal 105, 100, 30, 0000000h
	line_horizontal 105, 150, 30, 0000000h
	line_horizontal 105, 115, 30, 0000000h
	
	;pawn3
	
	line_vertical 185, 100, 50, 0000000h
	line_vertical 215, 100, 50, 0000000h
	line_horizontal 185, 100, 30, 0000000h
	line_horizontal 185, 150, 30, 0000000h
	line_horizontal 185, 115, 30, 0000000h
	
	;pawn4
	
	line_vertical 265, 100, 50, 0000000h
	line_vertical 295, 100, 50, 0000000h
	line_horizontal 265, 100, 30, 0000000h
	line_horizontal 265, 150, 30, 0000000h
	line_horizontal 265, 115, 30, 0000000h
	
	;pawn5
	
	line_vertical 345, 100, 50, 0000000h
	line_vertical 375, 100, 50, 0000000h
	line_horizontal 345, 100, 30, 0000000h
	line_horizontal 345, 150, 30, 0000000h
	line_horizontal 345, 115, 30, 0000000h
	
	;pawn6
	
	line_vertical 425, 100, 50, 0000000h
	line_vertical 455, 100, 50, 0000000h
	line_horizontal 425, 100, 30, 0000000h
	line_horizontal 425, 150, 30, 0000000h
	line_horizontal 425, 115, 30, 0000000h
	
	;pawn7
	
	line_vertical 505, 100, 50, 0000000h
	line_vertical 535, 100, 50, 0000000h
	line_horizontal 505, 100, 30, 0000000h
	line_horizontal 505, 150, 30, 0000000h
	line_horizontal 505, 115, 30, 0000000h
	
	;pawn8
	
	line_vertical 585, 100, 50, 0000000h
	line_vertical 615, 100, 50, 0000000h
	line_horizontal 585, 100, 30, 0000000h
	line_horizontal 585, 150, 30, 0000000h
	line_horizontal 585, 115, 30, 0000000h
	
	;blue
	
	;pawn1
	
	line_vertical 25, 500, 50, 0000FFFh
	line_vertical 55, 500, 50, 0000FFFh
	line_horizontal 25, 500, 30, 0000FFFh
	line_horizontal 25, 550, 30, 0000FFFh
	line_horizontal 25, 515, 30, 0000FFFh
	
	;pawn2
	
	line_vertical 105, 500, 50, 0000FFFh
	line_vertical 135, 500, 50, 0000FFFh
	line_horizontal 105, 500, 30, 0000FFFh
	line_horizontal 105, 550, 30, 0000FFFh
	line_horizontal 105, 515, 30, 0000FFFh
	
	;pawn3
	
	line_vertical 185, 500, 50, 0000FFFh
	line_vertical 215, 500, 50, 0000FFFh
	line_horizontal 185, 500, 30, 0000FFFh
	line_horizontal 185, 550, 30, 0000FFFh
	line_horizontal 185, 515, 30, 0000FFFh
	
	;pawn4
	
	line_vertical 265, 500, 50, 0000FFFh
	line_vertical 295, 500, 50, 0000FFFh
	line_horizontal 265, 500, 30, 0000FFFh
	line_horizontal 265, 550, 30, 0000FFFh
	line_horizontal 265, 515, 30, 0000FFFh
	
	;pawn5
	
	line_vertical 345, 500, 50, 0000FFFh
	line_vertical 375, 500, 50, 0000FFFh
	line_horizontal 345, 500, 30, 0000FFFh
	line_horizontal 345, 550, 30, 0000FFFh
	line_horizontal 345, 515, 30, 0000FFFh
	
	;pawn6
	
	line_vertical 425, 500, 50, 0000FFFh
	line_vertical 455, 500, 50, 0000FFFh
	line_horizontal 425, 500, 30, 0000FFFh
	line_horizontal 425, 550, 30, 0000FFFh
	line_horizontal 425, 515, 30, 0000FFFh
	
	;pawn7
	
	line_vertical 505, 500, 50, 0000FFFh
	line_vertical 535, 500, 50, 0000FFFh
	line_horizontal 505, 500, 30, 0000FFFh
	line_horizontal 505, 550, 30, 0000FFFh
	line_horizontal 505, 515, 30, 0000FFFh
	
	;pawn8
	
	line_vertical 585, 500, 50, 0000FFFh
	line_vertical 615, 500, 50, 0000FFFh
	line_horizontal 585, 500, 30, 0000FFFh
	line_horizontal 585, 550, 30, 0000FFFh
	line_horizontal 585, 515, 30, 0000FFFh
	
	jmp afisare_litere
evt_timer:
	inc counter
	
afisare_litere:
	;scriem un mesaj
	

final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	
	;terminarea programului
	push 0
	call exit
end start

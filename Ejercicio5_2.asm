;*************************************dos.asm**********************************
;
;	Programa que indica cuál sensor refleja la luz infraroja mediante el 
;	equivalente despliege al puerto B, representado mediante la siguiente tabla:
;
;	___________________________________________________
;				ENTRADAS					SALIDAS
;	-----------------------------	    ---------------
;	  Sensor	Sensor	  Sensor	
;	izquierdo  central	 derecho		PB3 PB2 PB1 PB0
;	   PA2		 PA1	   PA0			
;	-----------------------------		---------------
;		N		  N		    N			 0	 0	 0   0
;		N		  N		    B			 0	 0	 0   1
;		N		  B		    N			 0	 0	 1   0
;		N		  B		    B			 0	 0	 1   1
;		B		  N		    N			 0	 1	 0   0
;		B		  N		    B			 0	 1	 0   1
;		B		  B		    N			 0	 1	 1   0
;		B		  B		    B			 0	 1	 1   1
;	___________________________________________________
;
;	N (LINEA NEGRA)  : 0
;	B (LINEA BLANCA) : 1
;
; 	De acuerdo a la configuración de la tarjeta con la que se cuenta en el 
;	laboratorio, los sensores infrarojos están conectados a los bits menos 
;	significativos de puerto A, por otro lado la salida esta conectada al 
;	puerto B como se muestra en la tabla anterior.
;
;******************************************************************************
  processor 16f877
  include<p16f877.inc>

; Variables para el DELAY
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 10h 
cte2 equ 50h
cte3 equ 60h

;Definicion de variables a utilizar para
;comparar las entradas a través del puerto A

  org 0h
  goto INICIO
  org 05h

INICIO:
       clrf PORTA
       bsf STATUS,RP0    ;Cambia la banco 1
       bcf STATUS,RP1 
       movlw h'0'
       movwf TRISB       ;Configura puerto B como salida
       clrf PORTB
            
       movlw 06h         ;Configura puertos A y E como digitales
       movwf ADCON1 
       movlw 3fh         ;Configura el purto A como entrada
       movwf TRISA
       bcf STATUS,RP0    ;refresa al banco 0
PRINCIPAL:
		MOVLW b'00000000'
		subwf PORTA,w
		btfsc STATUS,Z
		goto  CERO     

		MOVLW b'00000001'
		subwf PORTA,w
		btfsc STATUS,Z
       goto UNO
       
		MOVLW b'000000010'
		subwf PORTA,w
		btfsc STATUS,Z
       goto DOS

		MOVLW b'00000011'
		subwf PORTA,w
		btfsc STATUS,Z
       goto  TRES

		MOVLW b'00000100'
		subwf PORTA,w
		btfsc STATUS,Z
       goto  CUATRO


		MOVLW b'00000101'
		subwf PORTA,w
		btfsc STATUS,Z
       goto CINCO
       
		MOVLW b'00000110'
		subwf PORTA,w
		btfsc STATUS,Z
       goto SEIS

		MOVLW b'00000111'
		subwf PORTA,w
		btfsc STATUS,Z
       goto  SIETE
       
;Salidas a través de PORTB        
CERO:
       movlw b'0000'
       movwf PORTB
       goto PRINCIPAL

UNO:
       movlw b'0001'
       movwf PORTB
       call retardo       
       goto PRINCIPAL

DOS:
       movlw b'0010'
       movwf PORTB
       call retardo        
       goto PRINCIPAL

TRES: 
       movlw b'0011'
       movwf PORTB
       call retardo
       goto PRINCIPAL

CUATRO:
       movlw b'0100'
       movwf PORTB
       goto PRINCIPAL

CINCO:
       movlw b'0101'
       movwf PORTB
       call retardo       
       goto PRINCIPAL

SEIS:
       movlw b'0110'
       movwf PORTB
       call retardo        
       goto PRINCIPAL

SIETE: 
       movlw b'0111'
       movwf PORTB
       call retardo
       goto PRINCIPAL
       
retardo movlw cte1   ;Rutina que genera un DELAY
     movwf valor1
tres movwf cte2
     movwf valor2
dos  movlw cte3
     movwf valor3
uno  decfsz valor3 
     goto uno 
     decfsz valor2
     goto dos
     decfsz valor1   
     goto tres
     return
     end


;******************************************************************************
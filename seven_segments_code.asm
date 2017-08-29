;Laboratório Display de 7 Segmentos

;LABEL		OPERANDO 		OPERAÇÃO				COMENTÁRIOS
			ORG 			00h
			MOV 			P3,#00H; Configura porta como saída
			MOV			R0,#0FFH; Armazena #0ffh em R0
			MOV			R5,#00H
    

;Rotina de Leitua de Palavra de Entrada
ciclo1:
			MOV				 A,P1; Leitura do Porte 1
			CJNE 			 A,#0FFH,ciclo2; se a entrada atual for diferente da anterior, vá para o ciclo2 (00h = R0)
			SJMP 			 ciclo1; caso contrário vá para o ciclo 1

ciclo2:
			MOV 			A,P1		; lê teclado
			MOV 			TH0,#HIGH(65000); perde tempo para ler último estado da tecla
																; antes de soltar, para evitar problemas de 
																; "boucing" da tecla
			MOV 			TL0,#LOW(65000)
			SETB 		TR0									; liga timer0
			JNB 			TF0,$								;	enquanto TF0=0 permanece aqui
			CLR 			TR0									; desliga timer
			CLR 			TF0									; reseta FLAG do timer 0
			MOV 			A,P1								; lê teclado
			CJNE 		A,#0FFH,ciclo2; enquanto tecla estiver apertada espera soltar
			SJMP			incrementa

;Rotina de Varredura de caractere a ser Mostrado
incrementa:
			INC			R5
			CJNE			R5,#0AH,continua
			MOV			R5,#00H

continua:
			MOV			P3,R5
			SJMP			ciclo1
			END

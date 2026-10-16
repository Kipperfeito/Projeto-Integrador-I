.data
msg_A: .asciiz "Digite o valor da Porta(0 ou 1): "
msg_B: .asciiz "Digite o valor do Sensor de movimento(0 ou 1): "
msg_C: .asciiz "Digite o valor do Sistema(0 ou 1): "
msg_S: .asciiz "Alarme Ligado!"
msg_S2: .asciiz "Alarme Desligado!"

.text
.globl main
main:
    # --- Passo 1: Solicitar e ler A (Porta) ---    
    
    # Imprimir a msg_A
    li $v0, 4         # 'li' = Load Immediate. Carrega o código 4 (print_string) em $v0
    la $a0, msg_A     # 'la' = Load Address. Carrega o endereço da msg_A em $a0
    syscall           # O sistema lê o $v0 e o $a0 e imprime o texto na tela!

    # Ler o valor de A
    li $v0, 5         # Carrega o código 5 (read_int) em $v0
    syscall           # O sistema pausa e espera você digitar. O número digitado vai para o $v0
    
    # Salvar o valor em um lugar seguro
    move $t0, $v0     # Copia o valor digitado de $v0 para o registrador temporário $t0 (nosso A)

    # --- Passo 1: Solicitar e ler B (Sensor de movimento) ---    
    
    # Imprimir a msg_B
    li $v0, 4         # 'li' = Load Immediate. Carrega o código 4 (print_string) em $v0
    la $a0, msg_B     # 'la' = Load Address. Carrega o endereço da msg_B em $a0
    syscall           # O sistema lê o $v0 e o $a0 e imprime o texto na tela!

    # Ler o valor de B  
    li $v0, 5         # Carrega o código 5 (read_int) em $v0
    syscall           # O sistema pausa e espera você digitar. O número digitado vai para o $v0
    
    # Salvar o valor em um lugar seguro
    move $t1, $v0     # Copia o valor digitado de $v0 para o registrador temporário $t1 (nosso B)

     # --- Passo 1: Solicitar e ler C (Sistema ligado) ---

    # Imprimir a msg_C
    li $v0, 4         # 'li' = Load Immediate. Carrega o código 4 (print_string) em $v0
    la $a0, msg_C     # 'la' = Load Address. Carrega o endereço da msg_C em $a0
    syscall           # O sistema lê o $v0 e o $a0 e imprime o texto na tela!

    # Ler o valor de C
    li $v0, 5         # Carrega o código 5 (read_int) em $v0
    syscall           # O sistema pausa e espera você digitar. O número digitado vai para o $v0

    # Salvar o valor em um lugar seguro
    move $t2, $v0     # Copia o valor digitado de $v0 para o registrador temporário $t2 (nosso C

    # --- Passo 2: Calcular a expressão (A OU B) E C ---
    or $t3, $t0, $t1    # $t3 = $t0 (A) OU $t1 (B)
    and $t4, $t3, $t2   # $t4 = $t3 (A OU B) E $t2 (C)

    # --- Passo 3: Verificar o resultado e imprimir a mensagem correspondente ---
    beq $t4, $zero, alarme_desligado  # Se $t4 == 0, vá para alarme_desligado
    # Se não for zero
    li $v0, 4         # Carrega o código 4 (print_string) em $v0
    la $a0, msg_S     # Carrega o endereço da msg_S em $a0
    syscall           # Imprime "Alarme Ligado!"
    j fim             # Pula para o fim do programa 
    
alarme_desligado:
    li $v0, 4         # Carrega o código 4 (print_string) em $v0
    la $a0, msg_S2    # Carrega o endereço da msg_S2 em $a0
    syscall           # Imprime "Alarme Desligado!"
fim:
    li $v0, 10        # Carrega o código 10 (exit)
    syscall           # Encerra o programa 

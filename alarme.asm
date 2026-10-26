.data
msg_A: .asciiz "Digite o valor da Porta(0 ou 1): "
msg_B: .asciiz "Digite o valor do Sensor de movimento(0 ou 1): "
msg_C: .asciiz "Digite o valor do Sistema(0 ou 1): "
msg_S: .asciiz "Alarme Ligado!"
msg_S2: .asciiz "Alarme Desligado!"

.text
.globl main
main:
    # --- Leitura das Entradas ---    
    
    # Solicita e armazena Porta (A) em $t0
    li $v0, 4      
    la $a0, msg_A     
    syscall           
    li $v0, 5         
    syscall           
    move $t0, $v0     

    # Solicita e armazena Sensor (B) e e já calcula (A OU B)
    li $v0, 4         
    la $a0, msg_B     
    syscall          
    li $v0, 5         
    syscall           
    or $t0, $t0, $v0    # $t0 recebe A OU B (sobrescreve o valor antigo)

    # Lê o Sistema (C) e já calcula o resultado final
    li $v0, 4         
    la $a0, msg_C     
    syscall           
    li $v0, 5         
    syscall         
    and $t0, $t0, $v0     # $t0 recebe (A OU B) E C

    # --- Avaliação e Saída ---
    beq $t0, $zero, alarme_desligado  

    # Dispara o Alarme
    li $v0, 4         
    la $a0, msg_S     
    syscall           
    j fim            
    
alarme_desligado:
    li $v0, 4         
    la $a0, msg_S2   
    syscall           # Imprime "Alarme Desligado!"
fim:
    li $v0, 10       
    syscall          

.data 
Array: .word 5, 4, 3, 2, 1
.text
main: 
                la $s0, Array #[array base address]
                addi $t0, $zero, 5 #[array size] [n]
                addi $t1, $zero, 1 #[i = 1]
    outer_loop: beq $t0,$t1, end1 
                addi $t2, $zero, 1 #[j=1] 
                sub $s1, $t0, $t1 #[n-i]
                beq $t2,$s1, end2  
                addi $s3, $s0, 0
    inner_loop: lw $s5, 0($s3)
                lw $s6, 4($s3)
                slt $s7, $s6, $s5
                beq $s7,$0, end3 
                sw $s6, 0($s3)
                sw $s5, 4($s3)
    end3:       addi $s3, $s3, 4 #[[skip_swap]]
                addi $t2, $t2, 1 #[j - updation]
                bne $t2, $s1, inner_loop
    end2:       addi $t1, $t1, 1 #[i-updation]
                bne $t1, $t0, outer_loop
    end1:       li $v0, 10
                syscall
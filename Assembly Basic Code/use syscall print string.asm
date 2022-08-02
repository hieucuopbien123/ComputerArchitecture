#Laboratory Exercise 5, Assignment 2
.data
  test: .asciiz "The sum of "
  test1: .asciiz " and "
  test2: .asciiz " is "
.text
  li $s0, 10
  li $s1, 20

  li $v0, 4
  la $a0, test
  syscall
  li $v0, 1
  add $a0, $zero, $s0
  syscall
  li $v0, 4
  la $a0, test1
  syscall
  li $v0, 1
  add $a0, $zero, $s1
  syscall
  li $v0, 4
  la $a0, test2
  syscall
  li $v0, 1
  add $a0, $s1, $s0
  syscall
  

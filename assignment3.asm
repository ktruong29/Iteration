;---------------------------------------------------------
;Author:        Kien Truong
;Program name:  Assignment 3
;Course ID:     CPSC 240
;---------------------------------------------------------

extern printf         ;External C++ function for writing to standard output device

extern scanf

extern getchar

extern clearerr

extern stdin

global ctrl_D_mean_ints

segment .data

initialMess   db "We will compute the mean for you using only integers.", 10,0

inputMess     db "Enter a sequence of long integers separated by white space."
              db " After the last input press Control+D.",0

numCountMess  db "The number of numbers entered was %ld.", 10, 0

meanMess      db "The integer mean was %ld.", 10, 10, 0

loopAgainMess db "Do you have more sets of integers to process (y or n)?",0

goodbyeMess1  db "Kien Truong hopes you liked your means. Please come again",10,0

goodbyeMess2  db "This software will return the last mean to the driver program."
              db " Bye", 10, 0

stringFormat db "%s", 0

intFormat    db "%ld", 0

segment .bss
;empty

segment .text
ctrl_D_mean_ints:

  push rbp
  mov rbp, rsp
  push rbx
  push rcx
  push rdx
  push rdi
  push rsi
  push r8
  push r9
  push r10
  push r11
  push r12
  push r13
  push r14
  push r15

  ;===This will execute when we want to run the loop again====
  loop_again:

  ;=====Show the initial message=======
  mov qword  rax, 0                         ;No floating points
  mov        rdi, stringFormat              ;"%s"
  mov        rsi, initialMess               ;"We will compute the mean for you using only integers."
  call       printf                         ;output

  ;=====Show the prompt========
  mov qword rax, 0                          ;No floating points
  mov       rdi, stringFormat               ;"%s"
  mov       rsi, inputMess                  ;"Enter a sequence of long integers
                                            ;separated by white space. After the
                                            ;last input press Control+D. "
  call      printf                          ;output

  ;=====Loop to input ints until Control+D=====
  mov r15, 0                                ;counter
  mov r14, 0                                ;sum

  begin_loop:
  push qword 0                              ;reserve 8 bytes of memory
  mov  qword rax, 0                         ;no floating points
  mov  rdi, intFormat                       ;"%ld"
  mov  rsi, rsp                             ;Give scanf a pointer to the reserved storage
  call scanf                                ;read input

  cdqe

  cmp rax, -1                               ;compares rax with -1

  je  loop_finished                         ;if rax == -1 => exit the loop

  ;====This will execute when rax != -1======
  pop   r13                                   ;stores inputted value in r13
  add   r14, r13                              ;sum of ints stored in r14
  inc   r15                                   ;increment counter
  jmp   begin_loop

  ;====This will execute when rax == -1=====

  loop_finished:

  ;=====Returning the stdin to good state=====
  mov  rax,0
  mov  rdi, [stdin]
  call clearerr

  pop rax				;Remove that last remaining push resulting from the loop.
  pop rax				;Remove the 0 that put us on the boundary.

  ;====Output number of ints inputted=====
  mov qword rax, 0                       ;No floating points
  mov rdi, numCountMess                  ;"The number of numbers entered was %ld."
  mov rsi, r15                           ;counter
  call     printf                        ;output

  cmp r15, 0    ;if the user first enters Ctrl-D
  je justCtrlD

  ;=====Calculating the mean=======
  mov  rax, r14                          ;copy r14 (sum) to rax for division
  cqo
  idiv r15                               ;rax = rax/r15
  mov  r12, rax                          ;backup quotient (mean) to r12

  ;=====Output the mean of ints inputted===
  mov qword rax, 0                      ;No floating points
  mov rdi, meanMess                     ;"The integer mean was %ld."
  mov rsi, r12                          ;mean
  call printf                           ;output

  jmp next

  justCtrlD:

  ;=====Output the mean of 0 when user just hits CtrlD===
  mov qword rax, 0                      ;No floating points
  mov rdi, meanMess                     ;"The integer mean was %ld."
  mov rsi, r15                          ;mean
  call printf                           ;output

  next:
  ;====Prompt to run again=====
  mov qword rax, 0                          ;no floating points
  mov rdi, stringFormat                     ;"%s"
  mov rsi, loopAgainMess                    ;"Do you have more sets of integers to process (y or n)?"
  call printf                               ;output

  ;====Getting char input======
  push qword 0
  mov  qword rax, 0                          ;no floating points
  call getchar

  ;====Comparing input with ASCII value of y====
  cmp rax, 121                              ;comparing input vs ASCII value (y)

  ;====Jump occurs when the input == y====
  je loop_again

  ;====Output goodbye message 1====
  mov qword rax, 0                          ;no floating points
  mov rdi, stringFormat                     ;"%s"
  mov rsi, goodbyeMess1                     ;"Kien Truong hopes you liked your means. Please come again"
  call     printf

  ;====Output goodbye messsage 2====
  mov qword rax, 0                          ;no floating points
  mov rdi, stringFormat                     ;"%s"
  mov rsi, goodbyeMess2                     ;"This software will return the last mean to the driver program. Bye."
  call     printf

  ;=====Returning the mean back to main====

  ;=====This will execute when the user first hits CtrlD======
  cmp r15, 0
  je returnMain0

  mov rax, r12
  jmp ignore

  returnMain0:
  mov rax, 0

  ignore:

  pop r15
  pop r14
  pop r13
  pop r12
  pop r11
  pop r10
  pop r9
  pop r8
  pop rsi
  pop rdi
  pop rdx
  pop rcx
  pop rbx
  pop rbp

  ret

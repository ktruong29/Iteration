# Iteration with the use of Control-D in X86
---
The purpose of this program is to become familiar with using Ctrl-D to stop
iteration.

This program will do the following:
* Input a sequence of long integers separated by white space
* Stops iteration when Ctrl-D is used
* Computes and displays the count and mean of integers
* Run the loop again if user enters "y" when get prompted
* Exit the loop if user enters "n" when get prompted
* The last mean will be returned to the caller program

This program has three different source files:
* A driver file, which is written in C/C++ language.
* An X86 assembly file, which is a function written in X86 language and
is called from the driver program. This program inputs, computes the count and
mean of integers, and outputs the result.
* A bash script is used to compile the two previously mentioned files, link
them to create one executable file, and lastly load that newly created
executable file.

## Prerequisites
---
* A virtual machine
* Install g++ and nasm

## Instruction on how to run the program
---
1. chmod +x run.sh then ./run.sh              
2. sh run.sh

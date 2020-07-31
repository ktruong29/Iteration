#!/bin/bash


#Author: Kien Truong
#Program name: Assignment
#Course ID: CPSC 240

rm *.o
rm *.out

echo "This is program <Iteration with Ctrl-D>"

echo "Assemble the module assignment3.asm"
nasm -f elf64 -l assignment3.lis -o assign3.o assignment3.asm

echo "Compile the C++ module assignment3.cpp"
g++ -c -m64 -Wall -l assignment3.lis -o assignment3.o assignment3.cpp -fno-pie -no-pie

echo "Link the two object files already created"
g++ -m64 -o assignment3.out assignment3.o assign3.o -fno-pie -no-pie

echo "The program will run"
./assignment3.out

echo "The bash script file is now closing."

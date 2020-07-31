
/**************************************
Author:        Kien Truong
Program name:  Assignment 3
Course ID:     CPSC 240
***************************************/

#include <stdio.h>
extern "C" long int ctrl_D_mean_ints();

int main()
{
  long int return_code = 99;
  printf("%s", "Welcome to Statistical Numbers\n");
  printf("%s", "Brought to you by Kien Truong\n\n");
  return_code = ctrl_D_mean_ints();

  printf("%s%ld%s","\nThis is the C++ program responding. Here we received the number ",return_code,
         ". Have a nice day.\nThe C++ program will return a zero to the operating system.\n");

  return 0;
}

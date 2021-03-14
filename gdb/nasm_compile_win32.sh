#!/bin/bash

if [[ ${1: -4} == ".asm" || ${1: -5} == ".nasm" ]]; then

  ori=$1
  ori_obj=$ori.o

  if [ ${1: -4} == ".asm" ]; then
    ori_bin=`basename $ori .asm`
  else
    ori_bin=`basename $ori .nasm`
  fi

  echo  '[  nasm - win32  ]'  $ori    '-->'  $ori_obj
  nasm -f win32 -o $ori_obj $ori

  if [[ $? -ne 0 ]]; then
    echo '[ ERROR - win32 ]'
    exit 1;
  fi

  echo  '[  ld - win32    ]'  $ori_obj '-->' $ori_bin.exe
  ld -m i386pe -o $ori_bin.exe $ori_obj

  if [[ $? -ne 0 ]]; then
    echo '[ ERROR ]'
    exit 1;
  fi

  echo  '[  clean         ] removing -->' $ori_obj
  if [ -e $ori_obj ]; then
    rm $ori_obj
  fi

  echo  '[  win32 - Done! ]'

  # gdb -q ./$ori_bin

else

  echo 'not a valid nasm file extension [ .asm, .nasm ]'
  exit 0

fi

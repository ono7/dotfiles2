#!/bin/bash

if [[ ${1: -4} == ".asm" || ${1: -5} == ".nasm" ]]; then

  ori=$1
  ori_obj=$ori.o

  if [ ${1: -4} == ".asm" ]; then
    ori_bin=`basename $ori .asm`
  else
    ori_bin=`basename $ori .nasm`
  fi

  echo  '[  nasm  ]'  $ori    '-->'  $ori_obj
  nasm -f elf32 -o $ori_obj $ori

  if [[ $? -ne 0 ]]; then
    echo '[ ERROR ]'
    exit 1;
  fi

  echo  '[  ld    ]'  $ori_obj '-->' $ori_bin
  ld -o $ori_bin $ori_obj

  if [[ $? -ne 0 ]]; then
    echo '[ ERROR ]'
    exit 1;
  fi

  echo  '[  clean ] removing -->' $ori_obj
  if [ -e $ori_obj ]; then
    rm $ori_obj
  fi

  echo  '[  Done! ]'
  objdump -d $ori_bin -M intel32 > $ori_bin.objdump.md
  # gdb -q ./$ori_bin
  echo " "
  echo "hexified: "
  echo "\"$(objdump -d $ori_bin | grep '[0-9a-f]:' | cut -d$'\t' -f2 | grep -v 'file' | tr -d " \n" | sed 's/../\\x&/g')\""
  echo " "
  echo "binary_copy_paste:"
  echo "$(objdump -d $ori_bin | grep '[0-9a-f]:' | cut -d$'\t' -f2 | grep -v 'file' | tr -d " \n" )"
  echo " "
  rm $ori_bin
else

  echo 'not a valid nasm file extension [ .asm, .nasm ]'
  exit 0
  rm $ori_bin

fi

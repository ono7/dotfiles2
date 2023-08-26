# tr (linux command)

delete unwanted characters from stream

- only allows A-Za-z0-9, deletes everything else

  `echo '111131!@!@#abcarst' | tr -dc A-Za-z0-9`

  ret: 11131abcarst

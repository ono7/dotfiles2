# notes on Makefiles

```make
# variables

whoami    := $(shell whoami)  # shell commands
host-type := $(shell arch)

CC = cc
CFLAGS = -g

mytarget: cfiles.c
  ${CC} ${CFLAGS} cfiles.c -o test

```


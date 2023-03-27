# basic make file

### refs:

http://www.gnu.org/software/make/manual/html_node/Flavors.html#Flavors

## notes

make files are whitespace sensitive

`all:` - by it self runs every time you type make

### special variables

```sh
all: lib.cpp main.cpp
```

`$@` evaluates to all (current target, could also be a PHONY target)
`$<` evaluates to lib.cpp (first file)

```sh
hello.o: hello.c hello.h
  gcc -c $< -o $@

# hello.o is $@ (target) and hello.c is $< (first prerequisite)

```

`$^` evaluates to lib.cpp main.cpp (all files)
`$%` filename of element of an archive specficiation
`$?` names of all prerequisites that are newer than the target, separated by spaces
`$+` similar to `$^`, the names of all the prerequisites separated by spaces,
except that `$+` includes duplicates. This variable was created for specific
situations such as arguments to linkers where duplicate values have meaning
`$*` stem of the target filename, a stem is typically a filename without its
suffix, its used outside of pattern rules is discouraged

### make usefull commands

`make -p` - returns makefile database

### variables, simply expanded ':=' vs recursive '='

- recursive variables

```sh
foo = $(bar)
bar = $(ugh)
ugh = Huh?
all:;echo $(foo)
```

`CFLAGS = $(CFLAGS) -O` # this however will cause an infinite loop,
make cannot append something to the end of CFLAGS using = variable assignment

To avoid all the problems and inconveniences of recursively expanded variables,
there is another flavor: simply expanded variables. shell commands in variables

- simply expanded variables ':='

The value of a simply expanded variable is scanned once and for all, expanding
any references to other variables and functions, when the variable is defined.
The actual value of the simply expanded variable is the result of expanding the
text that you write. It does not contain any references to other variables; it
contains their values as of the time this variable was defined. Therefore,

```sh
x := foo
y := $(x) bar
x := later

# is the same as

y := foo bar
x := later
```

```sh
whoami    := $(shell whoami)
host-type := $(shell arch)
```

## assigments

````sh
SRCS = main.c
SRCS : = $(wildcard *.c)
SRCS ! = find-name *. c
SRCS : = $(shell find .-name '*.c')
CC_FLAGS +=-Wextra
CFLAGS ?= $(CC_FLAGS)
FOO : = $(BAR) # Comment

= Verbatim assignment
:= Simple expansion
!= Shell output
?= Conditional assignment
+= Append to

## builtin functions

Built in functions

```sh
$(SRCS:. C=. o)
$(addprefix build/, $(OBJS))
$(if ..) $(or ..) $(and..)
$(foreach var, list, text)
$(value (VARIABLE))
$(shell ..)
$(error ..)
$(warning ..)
$(info ..)
````

- The DEFILES recipe and the include
  line must be the last lines in the file
- Make will only rebuild prerequisites
  which have a newer timestamp than the
  generated dependency file

```
.PHONY: a

a: x
```

```sh
# only tabs allowed!
# each line is executed in its own shell
# must use \ for long commands for this reason
# running make with no targets executes the first target
# in the make file

LIBS2=$(wildcard libs2/*)

LIBS=lib/dir1 lib/dir2 lib/dir3 lib/dir5
libraries: <- name of a target
  mkdir libraries; \<- the target
  cd libraries; \
  for dir in $(LIBS); do \
    mkdir -p $$dir; \
    done

```

## basic example

```sh
all:
  @echo 'make tags: clean, make, build'

build:
  touch files.txt

clean:
  rm files.txt
```


## more compete example


```sh
# compiler and target program
CXX = g++
TARGET = program

# directories for .o and .d files
OBJDIR := obj/
DEPDIR := $(OBJDIR)deps/

# all source, object, and dependency files
SRCS := $(wildcard *.cpp)
OBJS := $(SRCS:%.cpp=$(OBJDIR)%.o)
DEPS := $(SRCS:%.cpp=$(DEPDIR)%.d)

# root target for linking compiled .o files into one binary
$(TARGET) : $(OBJS)
  $(CXX) $^ -o $@

# target to compile all .cpp files, generating .d files in the process
$(OBJDIR)%.o : %.cpp $(DEPDIR)%.d | $(DEPDIR)
  $(CXX) -MMD -MT $@ -MP -MF $(DEPDIR)$*.d -o $@ -c $<

# empty targets for handling missing .d files
$(DEPS):

# target to create object and dependency directories if they don't exist
$(DEPDIR): ; @mkdir -p $@

# delete .d files, compiled .o files, and linked binary leaving just the code
clean:
  $(RM) -r $(OBJDIR) $(TARGET)

# include all the dependency files
include $(wildcard $(DEPS))
```

### slice things by security boundaries or by deployment targets

1. are you distinguising by deployment targets or by security boundaries?



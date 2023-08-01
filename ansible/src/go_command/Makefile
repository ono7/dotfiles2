BINARY_NAME := go_command
OUTPUT_DIR := ../../library

all: build install

build:
	go build -o $(BINARY_NAME) main.go

install:
	cp $(BINARY_NAME) $(OUTPUT_DIR)/$(BINARY_NAME)

clean:
	rm -f $(BINARY_NAME)
	rm -f $(OUTPUT_DIR)/$(BINARY_NAME)

.PHONY: all build install clean

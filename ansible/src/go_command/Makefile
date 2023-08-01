BINARY_NAME := go_command
OUTPUT_DIR := ../../library

all: build install

build:
	mkdir -p build
	go build -o build/$(BINARY_NAME) main.go

install:
	cp build/$(BINARY_NAME) $(OUTPUT_DIR)/$(BINARY_NAME)

clean:
	rm -f build/$(BINARY_NAME)
	rm -f $(OUTPUT_DIR)/$(BINARY_NAME)

.PHONY: all build install clean

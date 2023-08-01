BINARY_NAME := go_command
OUTPUT_DIR := ../../library
BUILD_DIR := build

all: build install

build:
	mkdir -p $(BUILD_DIR)
	go $(BUILD_DIR) -o $(BUILD_DIR)/$(BINARY_NAME) main.go

install:
	cp $(BUILD_DIR)/$(BINARY_NAME) $(OUTPUT_DIR)/$(BINARY_NAME)

clean:
	rm -f $(BUILD_DIR)/$(BINARY_NAME)
	rm -f $(OUTPUT_DIR)/$(BINARY_NAME)

test:
	cd $(BUILD_DIR);./$(BINARY_NAME) 1.json

.PHONY: all build install clean test

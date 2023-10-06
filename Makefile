# Include configuration file 
CONFIG_FILE=project.cfg

-include $(CONFIG_FILE)

CONFIG_CONTENT := \
NAME="Name of project" \
AUTHOR="Author name <author@email.com>" \
DESCRIPTION="" \
GIT_REPO="https://github.com"

# Meta info
YEAR := $(shell date +%Y)

# ANSI color codes
BLACK=\033[0;30m
RED=\033[0;31m
GRAY=\033[1;30m
GREEN=\033[0;32m
YELLOW=\033[0;33m
BLUE=\033[0;34m
MAGENTA=\033[0;35m
CYAN=\033[0;36m
WHITE=\033[0;37m
BOLD=\033[1m
ITALIC=\033[3m
UNDERLINE=\033[4m
BG_RED=\033[41m
BG_GREEN=\033[42m
BG_YELLOW=\033[43m
BG_BLUE=\033[44m
BG_MAGENTA=\033[45m
BG_CYAN=\033[46m
BG_WHITE=\033[47m
NC=\033[0m

# Folders setup
SRC_DIR=./src
BUILD_DIR=./.build
ASSETS_DIR=./assets
TOOLS_DIR=./tools
STUBS_DIR=./tools/stubs

# Compiler setup
CC=cc
CFLAGS=-std=c99 -Wall -Werror -g
ENTRY_FILE=main
SRC_FILES:=$(wildcard $(SRC_DIR)/**/*.c) $(wildcard $(SRC_DIR)/**/*.h) $(wildcard $(SRC_DIR)/*.c) $(wildcard $(SRC_DIR)/*.h)
INCLUDES:=-I$(SRC_DIR)
ENTRY_FILES:=$(wildcard $(SRC_DIR)/**/*.c) $(wildcard $(SRC_DIR)/*.c)

define display_joke
	@echo "$(BOLD)Joke by ChatGPT: $(NC)$(GRAY)"
	@bash $(TOOLS_DIR)/random_joke
	@echo "$(NC)"
endef

all: compile run

compile:
	@clear
	$(call display_joke)
	@echo "$(YELLOW)Compiling program...$(NC)\n"
	@mkdir -p $(BUILD_DIR)
	$(CC) $(ENTRY_FILES) -o $(BUILD_DIR)/$(ENTRY_FILE) $(CFLAGS) $(INCLUDES)
	@echo "\n"

run:
	@clear
	$(call display_joke)
	@echo "$(YELLOW)Running program...$(NC)\n"
	@cd $(BUILD_DIR) && ./$(ENTRY_FILE)

help:
	@clear
	$(call display_joke)
	@echo "Project: $(GRAY)$(NAME)$(NC) \t Author: $(GRAY)$(AUTHOR)$(NC) \t Year: $(GRAY)$(YEAR)$(NC)"
	@echo "\n$(GRAY)$(DESCRIPTION)$(NC)\n"
	@echo "Usage: make $(GREEN)<command>$(NC) [ARGUMENT1=valuue1] [ARGUMENT2=value2] [...]\n"
	@echo "Commands:\n"

	@echo " $(GREEN)help$(NC) \t\t # Show this help messsage"
	@echo "\t\t # $(BLUE)\`make help\`$(NC)\n"

	@echo " $(GREEN)init$(NC) \t\t # Create $(GRAY)'$(CONFIG_FILE)'$(NC) file"
	@echo "\t\t # $(BLUE)\`make init\`$(NC)\n"

	@echo " $(GREEN)compile$(NC) \t # Compile the program"
	@echo "\t\t # $(BLUE)\`make compile\`$(NC)\n"

	@echo " $(GREEN)run$(NC) \t\t # Run the program"
	@echo "\t\t # $(BLUE)\`make run\`$(NC)\n"

	@echo " $(GREEN)all$(NC) \t\t # Compile and run the program"
	@echo "\t\t # $(BLUE)\`make\`$(NC)"
	@echo "\t\t # $(BLUE)\`make all\`$(NC)\n"

init:
	@clear
	@if [ ! -e $(CONFIG_FILE) ]; then \
		echo "\n$(GREEN)Config file '$(CONFIG_FILE)' created.$(NC)\n"; \
		for line in $(CONFIG_CONTENT); do \
			echo "$$line" >> $(CONFIG_FILE); \
		done \
	else \
		echo "\n$(BLUE)Config file '$(CONFIG_FILE)' exists.$(NC)\n"; \
	fi

# Generators to generate code snippets on more
generate.header:
	@clear
	$(call display_joke)
	@echo "$(YELLOW)Generate header comments...$(NC)\n"
	@for file in $(SRC_FILES); do \
		filename=$$(basename $$file); \
        if ! grep -q '/\*\*' $$file; then \
			current_date=$$(stat -c '%y' $$file | awk '{split($$1,a,"-"); print a[1]"-"a[3]"-"a[2]}'); \
        	header_with_author_and_filename=$$(echo '$(shell cat $(STUBS_DIR)/header.stub)' | sed 's/{{author}}/$(AUTHOR)/' | sed "s/{{filename}}/$$filename/" | sed "s/{{description}}/-/" | sed "s/{{date}}/$$current_date/" | sed "s/{{year}}/$(YEAR)/"); \
            echo "$$header_with_author_and_filename" | cat - $$file > $$file.tmp && mv $$file.tmp $$file; \
			echo "$(GREEN)Header comment was added to $(UNDERLINE)\`$$filename\`$(NC)\n"; \
        else \
			echo "$(BLUE)File $(UNDERLINE)\`$$filename\`$(BLUE) already contains header comment.$(NC)\n"; \
		fi; \
	done

# TODO: generate c_file by passing two params
# TODO: @param C_FILE_NAME - name of the file
# TODO: @param C_FILE_DIR - path to the directory where will be the file stored (default: SRC_FOLDER)
C_FILE_NAME?=
C_FILE_DIR?=$(SRC_DIR)

generate.c_file:
ifeq ($(strip $(C_FILE_NAME)),)
	@echo "\n$(RED)$(ITALIC)C_FILE_NAME$(RED) parameter is required.$(NC)\n"
else
ifeq ($(wildcard $(C_FILE_DIR)),)
	@echo "\n$(RED)$(ITALIC)C_FILE_DIR$(RED) $(C_FILE_DIR) does not exist.$(NC)\n"
else
	@if [ -e $(C_FILE_DIR)/$(C_FILE_NAME).c ]; then \
		echo "file already exists"; \
	else \
		echo "$$(echo '$(shell cat $(STUBS_DIR)/c_file.stub)' | sed 's/{{author}}/$(AUTHOR)/' | sed "s/{{filename}}/$(C_FILE_NAME).c/" | sed "s/{{c_file_name}}/$(C_FILE_NAME)/" | sed "s/{{description}}/-/")" > $(C_FILE_DIR)/$(C_FILE_NAME).c; \
	fi
endif
endif
	

# TODO: generate h_file by passing two params
# TODO: @param H_FILE_NAME - name of the file
# TODO: @param H_FILE_DIR - path to the directory where will be the file stored (default: SRC_FOLDER)
generate.h_file:
	@echo "h_file"

# TODO: generate module by passing two params
# TODO: @param MODULE_NAME - name of the module
# TODO: @param MODULE_DIR - path to the directory where will be the module stored (default to: SRC_FOLDER)
generate.module:
	@echo "h_file"
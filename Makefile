# Include configuration file 
CONFIG_FILE=project.cfg
CONFIG_EXISTS=0

ifeq ($(wildcard $(CONFIG_FILE)),)
	CONFIG_EXISTS=0
else
	CONFIG_EXISTS=1
    include $(CONFIG_FILE)
endif

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
BUILD_DIR=./build
ASSETS_DIR=./assets

# Compiler setup
CC=cc
CFLAGS=-std=c99 -Wall -Werror -g
INCLUDES=-I$(SRC_DIR)
ENTRY_FILE=main
SRC_FILES := $(wildcard $(SRC_DIR)/*.c) $(wildcard $(SRC_DIR)/*.h)

all: compile run

compile:
	@clear
	@echo "$(YELLOW)Compiling program...$(NC)\n"
	@mkdir -p $(BUILD_DIR)
	$(CC) $(SRC_DIR)/$(ENTRY_FILE).c -o $(BUILD_DIR)/$(ENTRY_FILE) $(CFLAGS) $(INCLUDES)
	@echo "\n"

run:
	@clear
	@echo "$(YELLOW)Running program...$(NC)\n"
	@cd $(BUILD_DIR) && ./$(ENTRY_FILE)

help:
	@clear
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
		echo "NAME=\"Name of project\"" >> $(CONFIG_FILE); \
		echo "AUTHOR=\"Author name \<author@email.com\>\"" >> $(CONFIG_FILE); \
		echo "DESCRIPTION=\"\"" >> $(CONFIG_FILE); \
		echo "GIT_REPO=\"https://github.com\"" >> $(CONFIG_FILE); \
		echo "\n$(GREEN)Config file '$(CONFIG_FILE)' created.$(NC)\n"; \
	else \
		echo "\n$(BLUE)Config file '$(CONFIG_FILE)' exists.$(NC)\n"; \
	fi
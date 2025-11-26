# Executable name
TARGET = kar-boy

# Compiler
CC = gcc

# Directories
SRC_DIR = src
BUILD_DIR = build

# Detect all .c files recursively
SRCS = $(shell find $(SRC_DIR) -type f -name '*.c')
OBJS = $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

# Includes — root includes src/ for headers
INC = -I$(SRC_DIR)

# SDL2 flags
SDL_CFLAGS  = $(shell sdl2-config --cflags)
SDL_LDFLAGS = $(shell sdl2-config --libs)

# Compiler flags
CFLAGS = -std=c17 -Wall -Wextra -Wno-unused-function $(INC) $(SDL_CFLAGS)

# Default build type = optimized
CFLAGS += -O2

# Linker flags
LDFLAGS = $(SDL_LDFLAGS) -lSDL2_ttf

# Default make = build
all: $(TARGET)

# Build target
$(TARGET): $(OBJS)
	@echo "Linking $(TARGET)…"
	@$(CC) $(OBJS) -o $(TARGET) $(LDFLAGS)

# Compile each object file
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	@echo "Compiling $<"
	@$(CC) $(CFLAGS) -c $< -o $@

# Debug mode
debug: CFLAGS = -std=c17 -Wall -Wextra -Wno-unused-function $(INC) $(SDL_CFLAGS) -O0 -g
debug: clean $(TARGET)
	@echo "Built in DEBUG mode"

# Run with ROM argument:
#   make run ROM=roms/game.gbc
run: $(TARGET)
	@if [ -z "$(ROM)" ]; then \
		echo "Usage: make run ROM=roms/game.gbc"; \
	else \
		./$(TARGET) $(ROM); \
	fi

# Clean
clean:
	@echo "Cleaning…"
	@rm -rf $(BUILD_DIR) $(TARGET)

.PHONY: all clean debug run

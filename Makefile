ARDUINO_DIR = $(HOME)/Applications/arduino-1.8.9

# System

MKDIR_P ?= mkdir -p

CORE=$(ARDUINO_DIR)/hardware/arduino/avr/cores/arduino
VARIANT=$(ARDUINO_DIR)/hardware/arduino/avr/variants/standard
AVR_DIR = $(ARDUINO_DIR)/hardware/tools/avr

CC = $(AVR_DIR)/bin/avr-gcc
CXX = $(AVR_DIR)/bin/avr-g++
SIZE = $(AVR_DIR)/bin/avr-size

# Project

F_CPU = 16000000
MCU = atmega328p

CPPFLAGS := -DF_CPU=$(F_CPU)UL -MMD

CFLAGS := -Os -Wall -ffunction-sections -fdata-sections -mmcu=$(MCU)
CXXFLAGS := $(CFLAGS) -fno-exceptions

LDFLAGS := -Wl,--gc-sections -mmcu=$(MCU)
LDLIBS := -lm

BUILD_DIR = build
SRC_DIR = src
INC_DIRS += -I$(CORE) -I$(VARIANT) -I$(SRC_DIR)

SRC = $(wildcard src/*.cpp) $(wildcard $(CORE)/*.c) $(wildcard $(CORE)/*.cpp)
OBJ = $(SRC:%=$(BUILD_DIR)/%.o)
DEP = $(SRC:%=$(BUILD_DIR)/%.d)

# Implicit rules

$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(INC_DIRS) -c $< -o $@

$(BUILD_DIR)/%.cpp.o: %.cpp
	$(MKDIR_P) $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(INC_DIRS) -c $< -o $@

# Explicit rules

.PHONY: all clean

all: $(BUILD_DIR)/girino.elf

$(BUILD_DIR)/girino.elf: $(OBJ)
	$(CXX) $(OBJ) $(LDFLAGS) -o $@ $(LDLIBS)
	$(SIZE) --format=avr --mcu=$(MCU) $@

clean:
	$(RM) -r $(BUILD_DIR)

# Generated dependencies

-include $(DEP)

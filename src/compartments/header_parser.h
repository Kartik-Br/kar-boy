#pragma once

#include "util.h"

typedef struct {
    uint8_t entry_point[4];
    uint8_t logo[0x30];
    char rom_title[16];
    uint8_t cbg_flag;
    uint16_t new_lic_code;
    uint8_t sgb_flag;
    uint8_t type;
    uint8_t rom_size;
    uint8_t ram_size;
    uint8_t dest_code;
    uint8_t lic_code;
    uint8_t version;
    uint8_t checksum;
    uint16_t global_checksum;
} rom_header;

bool load_rom(char *rom);

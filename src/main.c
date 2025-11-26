#include <stdio.h>
#include "compartments/util.h"
#include "compartments/header_parser.h"
#include "compartments/cpu.h"
#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>

typedef struct {
    bool paused;
    bool running;
    uint64_t tick;
} emu_context;

static emu_context ctx;

emu_context *emu_get_context() {
    return &ctx;
}

void delay(uint32_t ms) {
    SDL_Delay(ms);
}






int main(int argc, char** argv){
	if(argc < 2){
		printf("gurt");
		exit(1);
	}
    if(!load_rom(argv[1])){
        printf("yo");
        exit(2);
    }

    printf("Loaded rom yipee\n");

    SDL_Init(SDL_INIT_VIDEO);
    printf("SDL INIT\n");
    TTF_Init();
    printf("TTF INIT\n");

    cpu_init();

    ctx.running = true;
    ctx.paused = false;
    ctx.tick = 0;

    while(ctx.running) {
        if(ctx.paused) {
            delay(10);
            continue;
        }
        if(!cpu_step()){
            printf("CPU Stopped\n");
            return -3;
        }
        ctx.tick++;
    }
	return 0;
}

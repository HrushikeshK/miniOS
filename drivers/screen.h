#ifndef SCREEN_H
#define SCREEN_H

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
// Attribute byte 
#define WHITE_ON_BLACK 0x0f
#define RED_ON_WHITE 0x0f4

// Screen device I/O ports
#define REG_SCREEN_CTRL 0x3d4
#define REG_SCREEN_DATA 0x3d5

// public kernel api
void clear_screen();
void kprint_at(char* message, int col, int row);
void kprint(char* message);
void kprint_int(int data);
void kprint_backspace();

#endif
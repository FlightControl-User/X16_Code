
struct Sprite {
    char File[16];
    byte SpriteCount;
    byte SpriteOffset;
    word TotalSize;
    word SpriteSize;
    byte Height;
    byte Width;
    byte Zdepth;
    byte Hflip;
    byte Vflip;
    byte BPP;
    byte PaletteOffset; 
    dword BRAM_Address;
    dword VRAM_Address[16];
};



byte const SPRITE_PLAYER01_01_COUNT = 7;
struct Sprite SpritePlayer01 =       { "PLAYER01", SPRITE_PLAYER01_01_COUNT, 1, 32*32*SPRITE_PLAYER01_01_COUNT/2, 512, 32, 32, 3, 0, 0, 4, 1, 0x0, { 0x0 } };
byte const SPRITE_ENGINE01_01_COUNT = 16;
struct Sprite SpriteEngine01 =       { "ENGINE01", SPRITE_ENGINE01_01_COUNT, 8, 16*16*SPRITE_ENGINE01_01_COUNT/2, 128, 16, 16, 3, 0, 0, 4, 2, 0x0, { 0x0 } };


byte const SPRITE_TYPES = 2;
__mem struct Sprite *SpriteDB[2] = { &SpritePlayer01, &SpriteEngine01 };


// Work variables

byte const SPRITE_COUNT = SPRITE_PLAYER01_01_COUNT + SPRITE_ENGINE01_01_COUNT; 

byte const HEAP_SPRITES = 0;


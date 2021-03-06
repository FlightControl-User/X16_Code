//#pragma link("load.ld")

#include <cx16.h>
#include <conio.h>
#include <printf.h>
#include <mos6522.h>
#include <kernal.h>

// Address to load to banked memory.
dword const loadtext = 0x00002000;
char* const text = 0xA000;

void main() {
    // Load sprite file into memory
    clrscr();
    char status = cx16_load_ram_banked(1, 8, 0, "TEXT", loadtext);
    if(status!=0xff) printf("status = %x\n",status);
    printf("text = %s\n", text);
}


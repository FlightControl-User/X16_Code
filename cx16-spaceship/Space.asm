  // File Comments
// Example program for the Commander X16
  // Upstart
.cpu _65c02
  // Create CX16 files containing the program and a sprite file
.file [name="Space.prg", type="prg", segments="Program"]
//.file [name="PLAYER", type="bin", segments="Player"]
//.file [name="ENEMY2", type="bin", segments="Enemy2"]
//.file [name="TILES", type="bin", segments="TileS"]
//.file [name="SQUAREMETAL", type="bin", segments="SquareMetal"]
//.file [name="TILEMETAL", type="bin", segments="TileMetal"]
//.file [name="SQUARERASTER", type="bin", segments="SquareRaster"]
//.file [name="PALETTES", type="bin", segments="Palettes"]
.segmentdef Program [segments="Basic, Code, Data"]
.segmentdef Basic [start=$0801]
.segmentdef Code [start=$80d]
.segmentdef Data [startAfter="Code", align=$1000]
.segment Basic
:BasicUpstart(__start)
//.segmentdef Player 
//.segmentdef Enemy2 
//.segmentdef TileS 
//.segmentdef SquareMetal 
//.segmentdef TileMetal 
//.segmentdef SquareRaster 
//.segmentdef Palettes

  // Global Constants & labels
  // The colors of the CX16
  .const BLACK = 0
  .const WHITE = 1
  .const BLUE = 6
  .const VERA_INC_1 = $10
  .const VERA_DCSEL = 2
  .const VERA_ADDRSEL = 1
  .const VERA_VSYNC = 1
  .const VERA_SPRITES_ENABLE = $40
  .const VERA_LAYER1_ENABLE = $20
  .const VERA_LAYER0_ENABLE = $10
  .const VERA_LAYER_WIDTH_64 = $10
  .const VERA_LAYER_WIDTH_128 = $20
  .const VERA_LAYER_WIDTH_256 = $30
  .const VERA_LAYER_WIDTH_MASK = $30
  .const VERA_LAYER_HEIGHT_64 = $40
  .const VERA_LAYER_HEIGHT_128 = $80
  .const VERA_LAYER_HEIGHT_256 = $c0
  .const VERA_LAYER_HEIGHT_MASK = $c0
  // Bit 0-1: Color Depth (0: 1 bpp, 1: 2 bpp, 2: 4 bpp, 3: 8 bpp)
  .const VERA_LAYER_COLOR_DEPTH_1BPP = 0
  .const VERA_LAYER_COLOR_DEPTH_2BPP = 1
  .const VERA_LAYER_COLOR_DEPTH_4BPP = 2
  .const VERA_LAYER_COLOR_DEPTH_8BPP = 3
  .const VERA_LAYER_CONFIG_256C = 8
  .const VERA_TILEBASE_WIDTH_16 = 1
  .const VERA_TILEBASE_HEIGHT_16 = 2
  .const VERA_LAYER_TILEBASE_MASK = $fc
  // VERA Palette address in VRAM  $1FA00 - $1FBFF
  // 256 entries of 2 bytes
  // byte 0 bits 4-7: Green
  // byte 0 bits 0-3: Blue
  // byte 1 bits 0-3: Red
  .const VERA_PALETTE = $1fa00
  // Sprite Attributes address in VERA VRAM $1FC00 - $1FFFF
  .const VERA_SPRITE_ATTR = $1fc00
  .const VERA_SPRITE_WIDTH_32 = $20
  .const VERA_SPRITE_HEIGHT_32 = $80
  // Common CBM Kernal Routines
  .const CBM_SETNAM = $ffbd
  // Set the name of a file.
  .const CBM_SETLFS = $ffba
  // Set the logical file.
  .const CBM_OPEN = $ffc0
  // Open the file for the current logical file.
  .const CBM_CHKIN = $ffc6
  // Set the logical channel for input.
  .const CBM_READST = $ffb7
  // Check I/O errors.
  .const CBM_CHRIN = $ffcf
  // Read a character from the current channel for input.
  .const CBM_CLOSE = $ffc3
  // Close a logical file.
  .const CBM_CLRCHN = $ffcc
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH = 4
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT = 5
  .const BINARY = 2
  .const OCTAL = 8
  .const DECIMAL = $a
  .const HEXADECIMAL = $10
  .const NUM_PLAYER = $c
  .const NUM_ENEMY2 = $c
  .const NUM_TILES_SMALL = 4
  .const NUM_SQUAREMETAL = 4
  .const NUM_TILEMETAL = 4
  .const NUM_SQUARERASTER = 4
  // Addressed used for graphics in main banked memory.
  .const BANK_PLAYER = $2000
  .const BANK_ENEMY2 = $4000
  .const BANK_TILES_SMALL = $14000
  .const BANK_SQUAREMETAL = $16000
  .const BANK_TILEMETAL = $22000
  .const BANK_SQUARERASTER = $28000
  .const BANK_PALETTE = $34000
  // Addresses used to store graphics in VERA VRAM.
  .const VRAM_PLAYER = 0
  .const VRAM_ENEMY2 = $1800
  .const VRAM_TILES_SMALL = $3000
  .const VRAM_SQUAREMETAL = $3800
  .const VRAM_TILEMETAL = $5800
  .const VRAM_SQUARERASTER = $7800
  .const VRAM_TILEMAP = $10000
  .const SIZEOF_POINTER = 2
  .const SIZEOF_STRUCT_VERA_SPRITE = 8
  .const OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS = 1
  .const OFFSET_STRUCT_MOS6522_VIA_PORT_A = 1
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT = 1
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT = 8
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH = 6
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK = 3
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP = $b
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSHIFT = $a
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_DISPLAY_CURSOR = $d
  .const OFFSET_STRUCT_VERA_SPRITE_X = 2
  .const OFFSET_STRUCT_VERA_SPRITE_Y = 4
  .const OFFSET_STRUCT_VERA_SPRITE_CTRL2 = 7
  .const SIZEOF_STRUCT_CX16_CONIO = $e
  .const SIZEOF_STRUCT_PRINTF_BUFFER_NUMBER = $c
  // $9F20 VRAM Address (7:0)
  .label VERA_ADDRX_L = $9f20
  // $9F21 VRAM Address (15:8)
  .label VERA_ADDRX_M = $9f21
  // $9F22 VRAM Address (7:0)
  // Bit 4-7: Address Increment  The following is the amount incremented per value value:increment
  //                             0:0, 1:1, 2:2, 3:4, 4:8, 5:16, 6:32, 7:64, 8:128, 9:256, 10:512, 11:40, 12:80, 13:160, 14:320, 15:640
  // Bit 3: DECR Setting the DECR bit, will decrement instead of increment by the value set by the 'Address Increment' field.
  // Bit 0: VRAM Address (16)
  .label VERA_ADDRX_H = $9f22
  // $9F23	DATA0	VRAM Data port 0
  .label VERA_DATA0 = $9f23
  // $9F24	DATA1	VRAM Data port 1
  .label VERA_DATA1 = $9f24
  // $9F25	CTRL Control
  // Bit 7: Reset
  // Bit 1: DCSEL
  // Bit 2: ADDRSEL
  .label VERA_CTRL = $9f25
  // $9F26	IEN		Interrupt Enable
  // Bit 7: IRQ line (8)
  // Bit 3: AFLOW
  // Bit 2: SPRCOL
  // Bit 1: LINE
  // Bit 0: VSYNC
  .label VERA_IEN = $9f26
  // $9F27	ISR     Interrupt Status
  // Interrupts will be generated for the interrupt sources set in the lower 4 bits of IEN. ISR will indicate the interrupts that have occurred.
  // Writing a 1 to one of the lower 3 bits in ISR will clear that interrupt status. AFLOW can only be cleared by filling the audio FIFO for at least 1/4.
  // Bit 4-7: Sprite Collisions. This field indicates which groups of sprites have collided.
  // Bit 3: AFLOW
  // Bit 2: SPRCOL
  // Bit 1: LINE
  // Bit 0: VSYNC
  .label VERA_ISR = $9f27
  // $9F29	DC_VIDEO (DCSEL=0)
  // Bit 7: Current Field     Read-only bit which reflects the active interlaced field in composite and RGB modes. (0: even, 1: odd)
  // Bit 6: Sprites Enable	Enable output from the Sprites renderer
  // Bit 5: Layer1 Enable	    Enable output from the Layer1 renderer
  // Bit 4: Layer0 Enable	    Enable output from the Layer0 renderer
  // Bit 2: Chroma Disable    Setting 'Chroma Disable' disables output of chroma in NTSC composite mode and will give a better picture on a monochrome display. (Setting this bit will also disable the chroma output on the S-video output.)
  // Bit 0-1: Output Mode     0: Video disabled, 1: VGA output, 2: NTSC composite, 3: RGB interlaced, composite sync (via VGA connector)
  .label VERA_DC_VIDEO = $9f29
  // $9F2A	DC_HSCALE (DCSEL=0)	Active Display H-Scale
  .label VERA_DC_HSCALE = $9f2a
  // $9F2B	DC_VSCALE (DCSEL=0)	Active Display V-Scale
  .label VERA_DC_VSCALE = $9f2b
  // $9F2D	L0_CONFIG   Layer 0 Configuration
  .label VERA_L0_CONFIG = $9f2d
  // $9F2E	L0_MAPBASE	    Layer 0 Map Base Address (16:9)
  .label VERA_L0_MAPBASE = $9f2e
  // Bit 0:	Tile Width (0:8 pixels, 1:16 pixels)
  .label VERA_L0_TILEBASE = $9f2f
  // $9F32	L0_VSCROLL_L	Layer 0 V-Scroll (7:0)
  .label VERA_L0_VSCROLL_L = $9f32
  // $9F33	L0_VSCROLL_H    Layer 0 V-Scroll (11:8)
  .label VERA_L0_VSCROLL_H = $9f33
  // $9F34	L1_CONFIG   Layer 1 Configuration
  .label VERA_L1_CONFIG = $9f34
  // $9F35	L1_MAPBASE	    Layer 1 Map Base Address (16:9)
  .label VERA_L1_MAPBASE = $9f35
  // $9F36	L1_TILEBASE	    Layer 1 Tile Base
  // Bit 2-7: Tile Base Address (16:11)
  // Bit 1:   Tile Height (0:8 pixels, 1:16 pixels)
  // Bit 0:	Tile Width (0:8 pixels, 1:16 pixels)
  .label VERA_L1_TILEBASE = $9f36
  // $9F39	L1_VSCROLL_L	Layer 1 V-Scroll (7:0)
  .label VERA_L1_VSCROLL_L = $9f39
  // $9F3A	L1_VSCROLL_H	Layer 1 V-Scroll (11:8)
  .label VERA_L1_VSCROLL_H = $9f3a
  // to POKE the address space.
  // The VIA#1: ROM/RAM Bank Control
  // Port A Bits 0-7 RAM bank
  // Port B Bits 0-2 ROM bank
  // Port B Bits 3-7 [TBD]
  .label VIA1 = $9f60
  // $0314	(RAM) IRQ vector - The vector used when the KERNAL serves IRQ interrupts
  .label KERNEL_IRQ = $314
  .label GETIN = $ffe4
  .label i = $31
  .label j = $32
  .label a = $33
  .label vscroll = $34
  .label scroll_action = $36
  // The random state variable
  .label rand_state = $2c
.segment Code
  // __start
__start: {
    // __start::__init1
    // i = 0
    // [1] i = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z i
    // j = 0
    // [2] j = 0 -- vbuz1=vbuc1 
    sta.z j
    // a = 4
    // [3] a = 4 -- vbuz1=vbuc1 
    lda #4
    sta.z a
    // vscroll = 0
    // [4] vscroll = 0 -- vwuz1=vwuc1 
    lda #<0
    sta.z vscroll
    sta.z vscroll+1
    // scroll_action = 2
    // [5] scroll_action = 2 -- vwuz1=vwuc1 
    lda #<2
    sta.z scroll_action
    lda #>2
    sta.z scroll_action+1
    // #pragma constructor_for(conio_x16_init, cputc, clrscr, cscroll)
    // [6] call conio_x16_init 
    jsr conio_x16_init
    // [7] phi from __start::__init1 to __start::@1 [phi:__start::__init1->__start::@1]
    // __start::@1
    // [8] call main 
    jsr main
    // __start::@return
    // [9] return 
    rts
}
  // irq_vsync
//VSYNC Interrupt Routine
irq_vsync: {
    .label __2 = $38
    .label __16 = $3c
    .label vera_layer_set_vertical_scroll1_scroll = $3a
    .label c = 4
    .label r = 3
    // interrupt(isr_rom_sys_cx16_entry) -- isr_rom_sys_cx16_entry 
    // a--;
    // [11] a = -- a -- vbuz1=_dec_vbuz1 
    dec.z a
    // if(a==0)
    // [12] if(a!=0) goto irq_vsync::@1 -- vbuz1_neq_0_then_la1 
    lda.z a
    cmp #0
    bne __b1
    // irq_vsync::@3
    // a=4
    // [13] a = 4 -- vbuz1=vbuc1 
    lda #4
    sta.z a
    // rotate_sprites(0, i,NUM_PLAYER,PlayerSprites,40,100)
    // [14] rotate_sprites::rotate#0 = i -- vwuz1=vbuz2 
    lda.z i
    sta.z rotate_sprites.rotate
    lda #0
    sta.z rotate_sprites.rotate+1
    // [15] call rotate_sprites 
    // [205] phi from irq_vsync::@3 to rotate_sprites [phi:irq_vsync::@3->rotate_sprites]
    // [205] phi rotate_sprites::base#6 = 0 [phi:irq_vsync::@3->rotate_sprites#0] -- vwuz1=vbuc1 
    sta.z rotate_sprites.base
    sta.z rotate_sprites.base+1
    // [205] phi rotate_sprites::basex#6 = $28 [phi:irq_vsync::@3->rotate_sprites#1] -- vwuz1=vbuc1 
    lda #<$28
    sta.z rotate_sprites.basex
    lda #>$28
    sta.z rotate_sprites.basex+1
    // [205] phi rotate_sprites::spriteaddresses#6 = PlayerSprites [phi:irq_vsync::@3->rotate_sprites#2] -- pwuz1=pwuc1 
    lda #<PlayerSprites
    sta.z rotate_sprites.spriteaddresses
    lda #>PlayerSprites
    sta.z rotate_sprites.spriteaddresses+1
    // [205] phi rotate_sprites::rotate#4 = rotate_sprites::rotate#0 [phi:irq_vsync::@3->rotate_sprites#3] -- register_copy 
    // [205] phi rotate_sprites::max#5 = NUM_PLAYER [phi:irq_vsync::@3->rotate_sprites#4] -- vwuz1=vbuc1 
    lda #<NUM_PLAYER
    sta.z rotate_sprites.max
    lda #>NUM_PLAYER
    sta.z rotate_sprites.max+1
    jsr rotate_sprites
    // irq_vsync::@15
    // rotate_sprites(16, j,NUM_ENEMY2,Enemy2Sprites,340,100)
    // [16] rotate_sprites::rotate#1 = j -- vwuz1=vbuz2 
    lda.z j
    sta.z rotate_sprites.rotate
    lda #0
    sta.z rotate_sprites.rotate+1
    // [17] call rotate_sprites 
    // [205] phi from irq_vsync::@15 to rotate_sprites [phi:irq_vsync::@15->rotate_sprites]
    // [205] phi rotate_sprites::base#6 = $10 [phi:irq_vsync::@15->rotate_sprites#0] -- vwuz1=vbuc1 
    lda #<$10
    sta.z rotate_sprites.base
    lda #>$10
    sta.z rotate_sprites.base+1
    // [205] phi rotate_sprites::basex#6 = $154 [phi:irq_vsync::@15->rotate_sprites#1] -- vwuz1=vwuc1 
    lda #<$154
    sta.z rotate_sprites.basex
    lda #>$154
    sta.z rotate_sprites.basex+1
    // [205] phi rotate_sprites::spriteaddresses#6 = Enemy2Sprites [phi:irq_vsync::@15->rotate_sprites#2] -- pwuz1=pwuc1 
    lda #<Enemy2Sprites
    sta.z rotate_sprites.spriteaddresses
    lda #>Enemy2Sprites
    sta.z rotate_sprites.spriteaddresses+1
    // [205] phi rotate_sprites::rotate#4 = rotate_sprites::rotate#1 [phi:irq_vsync::@15->rotate_sprites#3] -- register_copy 
    // [205] phi rotate_sprites::max#5 = NUM_ENEMY2 [phi:irq_vsync::@15->rotate_sprites#4] -- vwuz1=vbuc1 
    lda #<NUM_ENEMY2
    sta.z rotate_sprites.max
    lda #>NUM_ENEMY2
    sta.z rotate_sprites.max+1
    jsr rotate_sprites
    // irq_vsync::@16
    // i++;
    // [18] i = ++ i -- vbuz1=_inc_vbuz1 
    inc.z i
    // if(i>=NUM_PLAYER)
    // [19] if(i<NUM_PLAYER) goto irq_vsync::@7 -- vbuz1_lt_vbuc1_then_la1 
    lda.z i
    cmp #NUM_PLAYER
    bcc __b7
    // irq_vsync::@4
    // i=0
    // [20] i = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z i
    // irq_vsync::@7
  __b7:
    // j++;
    // [21] j = ++ j -- vbuz1=_inc_vbuz1 
    inc.z j
    // if(j>=NUM_ENEMY2)
    // [22] if(j<NUM_ENEMY2) goto irq_vsync::@1 -- vbuz1_lt_vbuc1_then_la1 
    lda.z j
    cmp #NUM_ENEMY2
    bcc __b1
    // irq_vsync::@8
    // j=0
    // [23] j = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z j
    // irq_vsync::@1
  __b1:
    // if(scroll_action--)
    // [24] irq_vsync::$2 = scroll_action -- vwuz1=vwuz2 
    lda.z scroll_action
    sta.z __2
    lda.z scroll_action+1
    sta.z __2+1
    // [25] scroll_action = -- scroll_action -- vwuz1=_dec_vwuz1 
    lda.z scroll_action
    bne !+
    dec.z scroll_action+1
  !:
    dec.z scroll_action
    // [26] if(0==irq_vsync::$2) goto irq_vsync::@2 -- 0_eq_vwuz1_then_la1 
    lda.z __2
    ora.z __2+1
    beq __b2
    // irq_vsync::@5
    // scroll_action = 2
    // [27] scroll_action = 2 -- vwuz1=vbuc1 
    lda #<2
    sta.z scroll_action
    lda #>2
    sta.z scroll_action+1
    // vscroll++;
    // [28] vscroll = ++ vscroll -- vwuz1=_inc_vwuz1 
    inc.z vscroll
    bne !+
    inc.z vscroll+1
  !:
    // if(vscroll>(64)*2-1)
    // [29] if(vscroll<$40*2-1+1) goto irq_vsync::@9 -- vwuz1_lt_vbuc1_then_la1 
    lda.z vscroll+1
    bne !+
    lda.z vscroll
    cmp #$40*2-1+1
    bcc __b9
  !:
    // [30] phi from irq_vsync::@5 to irq_vsync::@6 [phi:irq_vsync::@5->irq_vsync::@6]
    // irq_vsync::@6
    // memcpy_in_vram(1, <VRAM_TILEMAP, VERA_INC_1, 1, (<VRAM_TILEMAP)+64*16, VERA_INC_1, 64*16*4)
    // [31] call memcpy_in_vram 
    // [231] phi from irq_vsync::@6 to memcpy_in_vram [phi:irq_vsync::@6->memcpy_in_vram]
    // [231] phi memcpy_in_vram::num#4 = (word)$40*$10*4 [phi:irq_vsync::@6->memcpy_in_vram#0] -- vwuz1=vwuc1 
    lda #<$40*$10*4
    sta.z memcpy_in_vram.num
    lda #>$40*$10*4
    sta.z memcpy_in_vram.num+1
    // [231] phi memcpy_in_vram::dest_bank#3 = 1 [phi:irq_vsync::@6->memcpy_in_vram#1] -- vbuz1=vbuc1 
    lda #1
    sta.z memcpy_in_vram.dest_bank
    // [231] phi memcpy_in_vram::dest#3 = (void*)0 [phi:irq_vsync::@6->memcpy_in_vram#2] -- pvoz1=pvoc1 
    lda #<0
    sta.z memcpy_in_vram.dest
    sta.z memcpy_in_vram.dest+1
    // [231] phi memcpy_in_vram::src_bank#3 = 1 [phi:irq_vsync::@6->memcpy_in_vram#3] -- vbuyy=vbuc1 
    ldy #1
    // [231] phi memcpy_in_vram::src#3 = (void*)(word)$40*$10 [phi:irq_vsync::@6->memcpy_in_vram#4] -- pvoz1=pvoc1 
    lda #<$40*$10
    sta.z memcpy_in_vram.src
    lda #>$40*$10
    sta.z memcpy_in_vram.src+1
    jsr memcpy_in_vram
    // [32] phi from irq_vsync::@6 to irq_vsync::@10 [phi:irq_vsync::@6->irq_vsync::@10]
    // [32] phi rand_state#43 = rand_state#30 [phi:irq_vsync::@6->irq_vsync::@10#0] -- register_copy 
    // [32] phi irq_vsync::r#2 = 4 [phi:irq_vsync::@6->irq_vsync::@10#1] -- vbuz1=vbuc1 
    lda #4
    sta.z r
    // irq_vsync::@10
  __b10:
    // for(byte r=4;r<5;r+=1)
    // [33] if(irq_vsync::r#2<5) goto irq_vsync::@12 -- vbuz1_lt_vbuc1_then_la1 
    lda.z r
    cmp #5
    bcc __b3
    // irq_vsync::@11
    // vscroll=0
    // [34] vscroll = 0 -- vwuz1=vbuc1 
    lda #<0
    sta.z vscroll
    sta.z vscroll+1
    // irq_vsync::@9
  __b9:
    // vera_layer_set_vertical_scroll(0,vscroll)
    // [35] irq_vsync::vera_layer_set_vertical_scroll1_scroll#0 = vscroll -- vwuz1=vwuz2 
    lda.z vscroll
    sta.z vera_layer_set_vertical_scroll1_scroll
    lda.z vscroll+1
    sta.z vera_layer_set_vertical_scroll1_scroll+1
    // irq_vsync::vera_layer_set_vertical_scroll1
    // <scroll
    // [36] irq_vsync::vera_layer_set_vertical_scroll1_$0 = < irq_vsync::vera_layer_set_vertical_scroll1_scroll#0 -- vbuaa=_lo_vwuz1 
    lda.z vera_layer_set_vertical_scroll1_scroll
    // *vera_layer_vscroll_l[layer] = <scroll
    // [37] *(*vera_layer_vscroll_l) = irq_vsync::vera_layer_set_vertical_scroll1_$0 -- _deref_(_deref_qbuc1)=vbuaa 
    ldy vera_layer_vscroll_l
    sty.z $fe
    ldy vera_layer_vscroll_l+1
    sty.z $ff
    ldy #0
    sta ($fe),y
    // >scroll
    // [38] irq_vsync::vera_layer_set_vertical_scroll1_$1 = > irq_vsync::vera_layer_set_vertical_scroll1_scroll#0 -- vbuaa=_hi_vwuz1 
    lda.z vera_layer_set_vertical_scroll1_scroll+1
    // *vera_layer_vscroll_h[layer] = >scroll
    // [39] *(*vera_layer_vscroll_h) = irq_vsync::vera_layer_set_vertical_scroll1_$1 -- _deref_(_deref_qbuc1)=vbuaa 
    ldy vera_layer_vscroll_h
    sty.z $fe
    ldy vera_layer_vscroll_h+1
    sty.z $ff
    ldy #0
    sta ($fe),y
    // irq_vsync::@2
  __b2:
    // *VERA_ISR = VERA_VSYNC
    // [40] *VERA_ISR = VERA_VSYNC -- _deref_pbuc1=vbuc2 
    // Reset the VSYNC interrupt
    lda #VERA_VSYNC
    sta VERA_ISR
    // irq_vsync::@return
    // }
    // [41] return 
    // interrupt(isr_rom_sys_cx16_exit) -- isr_rom_sys_cx16_exit 
    jmp $e034
    // [42] phi from irq_vsync::@10 to irq_vsync::@12 [phi:irq_vsync::@10->irq_vsync::@12]
  __b3:
    // [42] phi rand_state#23 = rand_state#43 [phi:irq_vsync::@10->irq_vsync::@12#0] -- register_copy 
    // [42] phi irq_vsync::c#2 = 0 [phi:irq_vsync::@10->irq_vsync::@12#1] -- vbuz1=vbuc1 
    lda #0
    sta.z c
    // irq_vsync::@12
  __b12:
    // for(byte c=0;c<5;c+=1)
    // [43] if(irq_vsync::c#2<5) goto irq_vsync::@13 -- vbuz1_lt_vbuc1_then_la1 
    lda.z c
    cmp #5
    bcc __b13
    // irq_vsync::@14
    // r+=1
    // [44] irq_vsync::r#1 = irq_vsync::r#2 + 1 -- vbuz1=vbuz1_plus_1 
    inc.z r
    // [32] phi from irq_vsync::@14 to irq_vsync::@10 [phi:irq_vsync::@14->irq_vsync::@10]
    // [32] phi rand_state#43 = rand_state#23 [phi:irq_vsync::@14->irq_vsync::@10#0] -- register_copy 
    // [32] phi irq_vsync::r#2 = irq_vsync::r#1 [phi:irq_vsync::@14->irq_vsync::@10#1] -- register_copy 
    jmp __b10
    // [45] phi from irq_vsync::@12 to irq_vsync::@13 [phi:irq_vsync::@12->irq_vsync::@13]
    // irq_vsync::@13
  __b13:
    // rand()
    // [46] call rand 
    // [251] phi from irq_vsync::@13 to rand [phi:irq_vsync::@13->rand]
    // [251] phi rand_state#13 = rand_state#23 [phi:irq_vsync::@13->rand#0] -- register_copy 
    jsr rand
    // rand()
    // [47] rand::return#2 = rand::return#0
    // irq_vsync::@17
    // modr16u(rand(),3,0)
    // [48] modr16u::dividend#1 = rand::return#2
    // [49] call modr16u 
    // [260] phi from irq_vsync::@17 to modr16u [phi:irq_vsync::@17->modr16u]
    // [260] phi modr16u::dividend#5 = modr16u::dividend#1 [phi:irq_vsync::@17->modr16u#0] -- register_copy 
    jsr modr16u
    // modr16u(rand(),3,0)
    // [50] modr16u::return#2 = modr16u::return#0
    // irq_vsync::@18
    // [51] irq_vsync::$16 = modr16u::return#2 -- vwuz1=vwuz2 
    lda.z modr16u.return
    sta.z __16
    lda.z modr16u.return+1
    sta.z __16+1
    // rnd = (byte)modr16u(rand(),3,0)
    // [52] irq_vsync::rnd#0 = (byte)irq_vsync::$16 -- vbuaa=_byte_vwuz1 
    lda.z __16
    // vera_tile_element( 0, c, r, 3, TileDB[rnd])
    // [53] irq_vsync::$19 = irq_vsync::rnd#0 << 1 -- vbuxx=vbuaa_rol_1 
    asl
    tax
    // [54] vera_tile_element::x#1 = irq_vsync::c#2 -- vbuz1=vbuz2 
    lda.z c
    sta.z vera_tile_element.x
    // [55] vera_tile_element::y#1 = irq_vsync::r#2 -- vbuz1=vbuz2 
    lda.z r
    sta.z vera_tile_element.y
    // [56] vera_tile_element::Tile#0 = TileDB[irq_vsync::$19] -- pbuz1=qbuc1_derefidx_vbuxx 
    lda TileDB,x
    sta.z vera_tile_element.Tile
    lda TileDB+1,x
    sta.z vera_tile_element.Tile+1
    // [57] call vera_tile_element 
    // [277] phi from irq_vsync::@18 to vera_tile_element [phi:irq_vsync::@18->vera_tile_element]
    // [277] phi vera_tile_element::y#3 = vera_tile_element::y#1 [phi:irq_vsync::@18->vera_tile_element#0] -- register_copy 
    // [277] phi vera_tile_element::x#3 = vera_tile_element::x#1 [phi:irq_vsync::@18->vera_tile_element#1] -- register_copy 
    // [277] phi vera_tile_element::Tile#2 = vera_tile_element::Tile#0 [phi:irq_vsync::@18->vera_tile_element#2] -- register_copy 
    jsr vera_tile_element
    // irq_vsync::@19
    // c+=1
    // [58] irq_vsync::c#1 = irq_vsync::c#2 + 1 -- vbuz1=vbuz1_plus_1 
    inc.z c
    // [42] phi from irq_vsync::@19 to irq_vsync::@12 [phi:irq_vsync::@19->irq_vsync::@12]
    // [42] phi rand_state#23 = rand_state#14 [phi:irq_vsync::@19->irq_vsync::@12#0] -- register_copy 
    // [42] phi irq_vsync::c#2 = irq_vsync::c#1 [phi:irq_vsync::@19->irq_vsync::@12#1] -- register_copy 
    jmp __b12
}
  // conio_x16_init
// Set initial cursor position
conio_x16_init: {
    // Position cursor at current line
    .label BASIC_CURSOR_LINE = $d6
    .label line = 5
    // line = *BASIC_CURSOR_LINE
    // [59] conio_x16_init::line#0 = *conio_x16_init::BASIC_CURSOR_LINE -- vbuz1=_deref_pbuc1 
    lda BASIC_CURSOR_LINE
    sta.z line
    // vera_layer_mode_text(1,(dword)0x00000,(dword)0x0F800,128,64,8,8,16)
    // [60] call vera_layer_mode_text 
    // [327] phi from conio_x16_init to vera_layer_mode_text [phi:conio_x16_init->vera_layer_mode_text]
    jsr vera_layer_mode_text
    // [61] phi from conio_x16_init to conio_x16_init::@3 [phi:conio_x16_init->conio_x16_init::@3]
    // conio_x16_init::@3
    // screensize(&cx16_conio.conio_screen_width, &cx16_conio.conio_screen_height)
    // [62] call screensize 
    jsr screensize
    // [63] phi from conio_x16_init::@3 to conio_x16_init::@4 [phi:conio_x16_init::@3->conio_x16_init::@4]
    // conio_x16_init::@4
    // screenlayer(1)
    // [64] call screenlayer 
    jsr screenlayer
    // [65] phi from conio_x16_init::@4 to conio_x16_init::@5 [phi:conio_x16_init::@4->conio_x16_init::@5]
    // conio_x16_init::@5
    // vera_layer_set_textcolor(1, WHITE)
    // [66] call vera_layer_set_textcolor 
    // [369] phi from conio_x16_init::@5 to vera_layer_set_textcolor [phi:conio_x16_init::@5->vera_layer_set_textcolor]
    // [369] phi vera_layer_set_textcolor::layer#2 = 1 [phi:conio_x16_init::@5->vera_layer_set_textcolor#0] -- vbuxx=vbuc1 
    ldx #1
    jsr vera_layer_set_textcolor
    // [67] phi from conio_x16_init::@5 to conio_x16_init::@6 [phi:conio_x16_init::@5->conio_x16_init::@6]
    // conio_x16_init::@6
    // vera_layer_set_backcolor(1, BLUE)
    // [68] call vera_layer_set_backcolor 
    // [372] phi from conio_x16_init::@6 to vera_layer_set_backcolor [phi:conio_x16_init::@6->vera_layer_set_backcolor]
    // [372] phi vera_layer_set_backcolor::color#2 = BLUE [phi:conio_x16_init::@6->vera_layer_set_backcolor#0] -- vbuaa=vbuc1 
    lda #BLUE
    // [372] phi vera_layer_set_backcolor::layer#2 = 1 [phi:conio_x16_init::@6->vera_layer_set_backcolor#1] -- vbuxx=vbuc1 
    ldx #1
    jsr vera_layer_set_backcolor
    // [69] phi from conio_x16_init::@6 to conio_x16_init::@7 [phi:conio_x16_init::@6->conio_x16_init::@7]
    // conio_x16_init::@7
    // vera_layer_set_mapbase(0,0x20)
    // [70] call vera_layer_set_mapbase 
    // [375] phi from conio_x16_init::@7 to vera_layer_set_mapbase [phi:conio_x16_init::@7->vera_layer_set_mapbase]
    // [375] phi vera_layer_set_mapbase::mapbase#3 = $20 [phi:conio_x16_init::@7->vera_layer_set_mapbase#0] -- vbuxx=vbuc1 
    ldx #$20
    // [375] phi vera_layer_set_mapbase::layer#3 = 0 [phi:conio_x16_init::@7->vera_layer_set_mapbase#1] -- vbuaa=vbuc1 
    lda #0
    jsr vera_layer_set_mapbase
    // [71] phi from conio_x16_init::@7 to conio_x16_init::@8 [phi:conio_x16_init::@7->conio_x16_init::@8]
    // conio_x16_init::@8
    // vera_layer_set_mapbase(1,0x00)
    // [72] call vera_layer_set_mapbase 
    // [375] phi from conio_x16_init::@8 to vera_layer_set_mapbase [phi:conio_x16_init::@8->vera_layer_set_mapbase]
    // [375] phi vera_layer_set_mapbase::mapbase#3 = 0 [phi:conio_x16_init::@8->vera_layer_set_mapbase#0] -- vbuxx=vbuc1 
    ldx #0
    // [375] phi vera_layer_set_mapbase::layer#3 = 1 [phi:conio_x16_init::@8->vera_layer_set_mapbase#1] -- vbuaa=vbuc1 
    lda #1
    jsr vera_layer_set_mapbase
    // [73] phi from conio_x16_init::@8 to conio_x16_init::@9 [phi:conio_x16_init::@8->conio_x16_init::@9]
    // conio_x16_init::@9
    // cursor(0)
    // [74] call cursor 
    jsr cursor
    // conio_x16_init::@10
    // if(line>=cx16_conio.conio_screen_height)
    // [75] if(conio_x16_init::line#0<*((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT)) goto conio_x16_init::@1 -- vbuz1_lt__deref_pbuc1_then_la1 
    lda.z line
    cmp cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT
    bcc __b1
    // conio_x16_init::@2
    // line=cx16_conio.conio_screen_height-1
    // [76] conio_x16_init::line#1 = *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT) - 1 -- vbuz1=_deref_pbuc1_minus_1 
    ldx cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT
    dex
    stx.z line
    // [77] phi from conio_x16_init::@10 conio_x16_init::@2 to conio_x16_init::@1 [phi:conio_x16_init::@10/conio_x16_init::@2->conio_x16_init::@1]
    // [77] phi conio_x16_init::line#3 = conio_x16_init::line#0 [phi:conio_x16_init::@10/conio_x16_init::@2->conio_x16_init::@1#0] -- register_copy 
    // conio_x16_init::@1
  __b1:
    // gotoxy(0, line)
    // [78] gotoxy::y#0 = conio_x16_init::line#3 -- vbuxx=vbuz1 
    ldx.z line
    // [79] call gotoxy 
    // [382] phi from conio_x16_init::@1 to gotoxy [phi:conio_x16_init::@1->gotoxy]
    // [382] phi gotoxy::y#3 = gotoxy::y#0 [phi:conio_x16_init::@1->gotoxy#0] -- register_copy 
    jsr gotoxy
    // conio_x16_init::@return
    // }
    // [80] return 
    rts
}
  // main
main: {
    .label status = $3e
    .label status_1 = $3f
    .label status_2 = $41
    .label status_3 = $42
    .label status_4 = $43
    .label status_5 = $44
    .label status_6 = $40
    // VIA1->PORT_B = 0
    // [81] *((byte*)VIA1) = 0 -- _deref_pbuc1=vbuc2 
    lda #0
    sta VIA1
    // memcpy_in_vram(1, 0xF000, VERA_INC_1, 0, 0xF800, VERA_INC_1, 256*8)
    // [82] call memcpy_in_vram 
    // [231] phi from main to memcpy_in_vram [phi:main->memcpy_in_vram]
    // [231] phi memcpy_in_vram::num#4 = $100*8 [phi:main->memcpy_in_vram#0] -- vwuz1=vwuc1 
    lda #<$100*8
    sta.z memcpy_in_vram.num
    lda #>$100*8
    sta.z memcpy_in_vram.num+1
    // [231] phi memcpy_in_vram::dest_bank#3 = 1 [phi:main->memcpy_in_vram#1] -- vbuz1=vbuc1 
    lda #1
    sta.z memcpy_in_vram.dest_bank
    // [231] phi memcpy_in_vram::dest#3 = (void*) 61440 [phi:main->memcpy_in_vram#2] -- pvoz1=pvoc1 
    lda #<$f000
    sta.z memcpy_in_vram.dest
    lda #>$f000
    sta.z memcpy_in_vram.dest+1
    // [231] phi memcpy_in_vram::src_bank#3 = 0 [phi:main->memcpy_in_vram#3] -- vbuyy=vbuc1 
    ldy #0
    // [231] phi memcpy_in_vram::src#3 = (void*) 63488 [phi:main->memcpy_in_vram#4] -- pvoz1=pvoc1 
    lda #<$f800
    sta.z memcpy_in_vram.src
    lda #>$f800
    sta.z memcpy_in_vram.src+1
    jsr memcpy_in_vram
    // [83] phi from main to main::@20 [phi:main->main::@20]
    // main::@20
    // vera_layer_mode_tile(1, (dword)0x1A000, (dword)0x1F000, 128, 64, 8, 8, 1)
    // [84] call vera_layer_mode_tile 
  // We copy the 128 character set of 8 bytes each.
    // [395] phi from main::@20 to vera_layer_mode_tile [phi:main::@20->vera_layer_mode_tile]
    // [395] phi vera_layer_mode_tile::tileheight#10 = 8 [phi:main::@20->vera_layer_mode_tile#0] -- vbuz1=vbuc1 
    lda #8
    sta.z vera_layer_mode_tile.tileheight
    // [395] phi vera_layer_mode_tile::tilewidth#10 = 8 [phi:main::@20->vera_layer_mode_tile#1] -- vbuz1=vbuc1 
    sta.z vera_layer_mode_tile.tilewidth
    // [395] phi vera_layer_mode_tile::tilebase_address#10 = $1f000 [phi:main::@20->vera_layer_mode_tile#2] -- vduz1=vduc1 
    lda #<$1f000
    sta.z vera_layer_mode_tile.tilebase_address
    lda #>$1f000
    sta.z vera_layer_mode_tile.tilebase_address+1
    lda #<$1f000>>$10
    sta.z vera_layer_mode_tile.tilebase_address+2
    lda #>$1f000>>$10
    sta.z vera_layer_mode_tile.tilebase_address+3
    // [395] phi vera_layer_mode_tile::mapbase_address#10 = $1a000 [phi:main::@20->vera_layer_mode_tile#3] -- vduz1=vduc1 
    lda #<$1a000
    sta.z vera_layer_mode_tile.mapbase_address
    lda #>$1a000
    sta.z vera_layer_mode_tile.mapbase_address+1
    lda #<$1a000>>$10
    sta.z vera_layer_mode_tile.mapbase_address+2
    lda #>$1a000>>$10
    sta.z vera_layer_mode_tile.mapbase_address+3
    // [395] phi vera_layer_mode_tile::mapheight#10 = $40 [phi:main::@20->vera_layer_mode_tile#4] -- vwuz1=vbuc1 
    lda #<$40
    sta.z vera_layer_mode_tile.mapheight
    lda #>$40
    sta.z vera_layer_mode_tile.mapheight+1
    // [395] phi vera_layer_mode_tile::layer#10 = 1 [phi:main::@20->vera_layer_mode_tile#5] -- vbuz1=vbuc1 
    lda #1
    sta.z vera_layer_mode_tile.layer
    // [395] phi vera_layer_mode_tile::mapwidth#10 = $80 [phi:main::@20->vera_layer_mode_tile#6] -- vwuz1=vbuc1 
    lda #<$80
    sta.z vera_layer_mode_tile.mapwidth
    lda #>$80
    sta.z vera_layer_mode_tile.mapwidth+1
    // [395] phi vera_layer_mode_tile::color_depth#3 = 1 [phi:main::@20->vera_layer_mode_tile#7] -- vbuxx=vbuc1 
    ldx #1
    jsr vera_layer_mode_tile
    // [85] phi from main::@20 to main::@21 [phi:main::@20->main::@21]
    // main::@21
    // screenlayer(1)
    // [86] call screenlayer 
    jsr screenlayer
    // main::textcolor1
    // vera_layer_set_textcolor(cx16_conio.conio_screen_layer, color)
    // [87] vera_layer_set_textcolor::layer#1 = *((byte*)&cx16_conio) -- vbuxx=_deref_pbuc1 
    ldx cx16_conio
    // [88] call vera_layer_set_textcolor 
    // [369] phi from main::textcolor1 to vera_layer_set_textcolor [phi:main::textcolor1->vera_layer_set_textcolor]
    // [369] phi vera_layer_set_textcolor::layer#2 = vera_layer_set_textcolor::layer#1 [phi:main::textcolor1->vera_layer_set_textcolor#0] -- register_copy 
    jsr vera_layer_set_textcolor
    // main::bgcolor1
    // vera_layer_set_backcolor(cx16_conio.conio_screen_layer, color)
    // [89] vera_layer_set_backcolor::layer#1 = *((byte*)&cx16_conio) -- vbuxx=_deref_pbuc1 
    ldx cx16_conio
    // [90] call vera_layer_set_backcolor 
    // [372] phi from main::bgcolor1 to vera_layer_set_backcolor [phi:main::bgcolor1->vera_layer_set_backcolor]
    // [372] phi vera_layer_set_backcolor::color#2 = BLACK [phi:main::bgcolor1->vera_layer_set_backcolor#0] -- vbuaa=vbuc1 
    lda #BLACK
    // [372] phi vera_layer_set_backcolor::layer#2 = vera_layer_set_backcolor::layer#1 [phi:main::bgcolor1->vera_layer_set_backcolor#1] -- register_copy 
    jsr vera_layer_set_backcolor
    // [91] phi from main::bgcolor1 to main::@17 [phi:main::bgcolor1->main::@17]
    // main::@17
    // clrscr()
    // [92] call clrscr 
    jsr clrscr
    // [93] phi from main::@17 to main::@22 [phi:main::@17->main::@22]
    // main::@22
    // vera_layer_mode_tile(0, (dword)VRAM_TILEMAP, VRAM_TILES_SMALL, 64, 64, 16, 16, 4)
    // [94] call vera_layer_mode_tile 
  // Now we activate the tile mode.
    // [395] phi from main::@22 to vera_layer_mode_tile [phi:main::@22->vera_layer_mode_tile]
    // [395] phi vera_layer_mode_tile::tileheight#10 = $10 [phi:main::@22->vera_layer_mode_tile#0] -- vbuz1=vbuc1 
    lda #$10
    sta.z vera_layer_mode_tile.tileheight
    // [395] phi vera_layer_mode_tile::tilewidth#10 = $10 [phi:main::@22->vera_layer_mode_tile#1] -- vbuz1=vbuc1 
    sta.z vera_layer_mode_tile.tilewidth
    // [395] phi vera_layer_mode_tile::tilebase_address#10 = VRAM_TILES_SMALL [phi:main::@22->vera_layer_mode_tile#2] -- vduz1=vduc1 
    lda #<VRAM_TILES_SMALL
    sta.z vera_layer_mode_tile.tilebase_address
    lda #>VRAM_TILES_SMALL
    sta.z vera_layer_mode_tile.tilebase_address+1
    lda #<VRAM_TILES_SMALL>>$10
    sta.z vera_layer_mode_tile.tilebase_address+2
    lda #>VRAM_TILES_SMALL>>$10
    sta.z vera_layer_mode_tile.tilebase_address+3
    // [395] phi vera_layer_mode_tile::mapbase_address#10 = VRAM_TILEMAP [phi:main::@22->vera_layer_mode_tile#3] -- vduz1=vduc1 
    lda #<VRAM_TILEMAP
    sta.z vera_layer_mode_tile.mapbase_address
    lda #>VRAM_TILEMAP
    sta.z vera_layer_mode_tile.mapbase_address+1
    lda #<VRAM_TILEMAP>>$10
    sta.z vera_layer_mode_tile.mapbase_address+2
    lda #>VRAM_TILEMAP>>$10
    sta.z vera_layer_mode_tile.mapbase_address+3
    // [395] phi vera_layer_mode_tile::mapheight#10 = $40 [phi:main::@22->vera_layer_mode_tile#4] -- vwuz1=vbuc1 
    lda #<$40
    sta.z vera_layer_mode_tile.mapheight
    lda #>$40
    sta.z vera_layer_mode_tile.mapheight+1
    // [395] phi vera_layer_mode_tile::layer#10 = 0 [phi:main::@22->vera_layer_mode_tile#5] -- vbuz1=vbuc1 
    lda #0
    sta.z vera_layer_mode_tile.layer
    // [395] phi vera_layer_mode_tile::mapwidth#10 = $40 [phi:main::@22->vera_layer_mode_tile#6] -- vwuz1=vbuc1 
    lda #<$40
    sta.z vera_layer_mode_tile.mapwidth
    lda #>$40
    sta.z vera_layer_mode_tile.mapwidth+1
    // [395] phi vera_layer_mode_tile::color_depth#3 = 4 [phi:main::@22->vera_layer_mode_tile#7] -- vbuxx=vbuc1 
    ldx #4
    jsr vera_layer_mode_tile
    // [95] phi from main::@22 to main::@23 [phi:main::@22->main::@23]
    // main::@23
    // cx16_load_ram_banked(1, 8, 0, FILE_SPRITES, (dword)BANK_PLAYER)
    // [96] call cx16_load_ram_banked 
    // [501] phi from main::@23 to cx16_load_ram_banked [phi:main::@23->cx16_load_ram_banked]
    // [501] phi cx16_load_ram_banked::filename#7 = FILE_SPRITES [phi:main::@23->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_SPRITES
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_SPRITES
    sta.z cx16_load_ram_banked.filename+1
    // [501] phi cx16_load_ram_banked::address#7 = BANK_PLAYER [phi:main::@23->cx16_load_ram_banked#1] -- vduz1=vduc1 
    lda #<BANK_PLAYER
    sta.z cx16_load_ram_banked.address
    lda #>BANK_PLAYER
    sta.z cx16_load_ram_banked.address+1
    lda #<BANK_PLAYER>>$10
    sta.z cx16_load_ram_banked.address+2
    lda #>BANK_PLAYER>>$10
    sta.z cx16_load_ram_banked.address+3
    jsr cx16_load_ram_banked
    // cx16_load_ram_banked(1, 8, 0, FILE_SPRITES, (dword)BANK_PLAYER)
    // [97] cx16_load_ram_banked::return#12 = cx16_load_ram_banked::return#1 -- vbuaa=vbuz1 
    lda.z cx16_load_ram_banked.return
    // main::@24
    // status = cx16_load_ram_banked(1, 8, 0, FILE_SPRITES, (dword)BANK_PLAYER)
    // [98] main::status#0 = cx16_load_ram_banked::return#12 -- vbuz1=vbuaa 
    sta.z status
    // if(status!=$ff)
    // [99] if(main::status#0==$ff) goto main::@1 -- vbuz1_eq_vbuc1_then_la1 
    lda #$ff
    cmp.z status
    beq __b1
    // [100] phi from main::@24 to main::@8 [phi:main::@24->main::@8]
    // main::@8
    // printf("error file_sprites: %x\n",status)
    // [101] call cputs 
    // [568] phi from main::@8 to cputs [phi:main::@8->cputs]
    // [568] phi cputs::s#16 = main::s [phi:main::@8->cputs#0] -- pbuz1=pbuc1 
    lda #<s
    sta.z cputs.s
    lda #>s
    sta.z cputs.s+1
    jsr cputs
    // main::@26
    // printf("error file_sprites: %x\n",status)
    // [102] printf_uchar::uvalue#0 = main::status#0 -- vbuxx=vbuz1 
    ldx.z status
    // [103] call printf_uchar 
    // [576] phi from main::@26 to printf_uchar [phi:main::@26->printf_uchar]
    // [576] phi printf_uchar::format_radix#10 = HEXADECIMAL [phi:main::@26->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #HEXADECIMAL
    // [576] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#0 [phi:main::@26->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [104] phi from main::@26 to main::@27 [phi:main::@26->main::@27]
    // main::@27
    // printf("error file_sprites: %x\n",status)
    // [105] call cputs 
    // [568] phi from main::@27 to cputs [phi:main::@27->cputs]
    // [568] phi cputs::s#16 = main::s1 [phi:main::@27->cputs#0] -- pbuz1=pbuc1 
    lda #<s1
    sta.z cputs.s
    lda #>s1
    sta.z cputs.s+1
    jsr cputs
    // [106] phi from main::@24 main::@27 to main::@1 [phi:main::@24/main::@27->main::@1]
    // main::@1
  __b1:
    // cx16_load_ram_banked(1, 8, 0, FILE_ENEMY2, (dword)BANK_ENEMY2)
    // [107] call cx16_load_ram_banked 
    // [501] phi from main::@1 to cx16_load_ram_banked [phi:main::@1->cx16_load_ram_banked]
    // [501] phi cx16_load_ram_banked::filename#7 = FILE_ENEMY2 [phi:main::@1->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_ENEMY2
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_ENEMY2
    sta.z cx16_load_ram_banked.filename+1
    // [501] phi cx16_load_ram_banked::address#7 = BANK_ENEMY2 [phi:main::@1->cx16_load_ram_banked#1] -- vduz1=vduc1 
    lda #<BANK_ENEMY2
    sta.z cx16_load_ram_banked.address
    lda #>BANK_ENEMY2
    sta.z cx16_load_ram_banked.address+1
    lda #<BANK_ENEMY2>>$10
    sta.z cx16_load_ram_banked.address+2
    lda #>BANK_ENEMY2>>$10
    sta.z cx16_load_ram_banked.address+3
    jsr cx16_load_ram_banked
    // cx16_load_ram_banked(1, 8, 0, FILE_ENEMY2, (dword)BANK_ENEMY2)
    // [108] cx16_load_ram_banked::return#13 = cx16_load_ram_banked::return#1 -- vbuaa=vbuz1 
    lda.z cx16_load_ram_banked.return
    // main::@25
    // status = cx16_load_ram_banked(1, 8, 0, FILE_ENEMY2, (dword)BANK_ENEMY2)
    // [109] main::status#1 = cx16_load_ram_banked::return#13 -- vbuz1=vbuaa 
    sta.z status_1
    // if(status!=$ff)
    // [110] if(main::status#1==$ff) goto main::@2 -- vbuz1_eq_vbuc1_then_la1 
    lda #$ff
    cmp.z status_1
    beq __b2
    // [111] phi from main::@25 to main::@9 [phi:main::@25->main::@9]
    // main::@9
    // printf("error file_enemy2 = %x\n",status)
    // [112] call cputs 
    // [568] phi from main::@9 to cputs [phi:main::@9->cputs]
    // [568] phi cputs::s#16 = main::s2 [phi:main::@9->cputs#0] -- pbuz1=pbuc1 
    lda #<s2
    sta.z cputs.s
    lda #>s2
    sta.z cputs.s+1
    jsr cputs
    // main::@29
    // printf("error file_enemy2 = %x\n",status)
    // [113] printf_uchar::uvalue#1 = main::status#1 -- vbuxx=vbuz1 
    ldx.z status_1
    // [114] call printf_uchar 
    // [576] phi from main::@29 to printf_uchar [phi:main::@29->printf_uchar]
    // [576] phi printf_uchar::format_radix#10 = HEXADECIMAL [phi:main::@29->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #HEXADECIMAL
    // [576] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#1 [phi:main::@29->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [115] phi from main::@29 to main::@30 [phi:main::@29->main::@30]
    // main::@30
    // printf("error file_enemy2 = %x\n",status)
    // [116] call cputs 
    // [568] phi from main::@30 to cputs [phi:main::@30->cputs]
    // [568] phi cputs::s#16 = main::s1 [phi:main::@30->cputs#0] -- pbuz1=pbuc1 
    lda #<s1
    sta.z cputs.s
    lda #>s1
    sta.z cputs.s+1
    jsr cputs
    // [117] phi from main::@25 main::@30 to main::@2 [phi:main::@25/main::@30->main::@2]
    // main::@2
  __b2:
    // cx16_load_ram_banked(1, 8, 0, FILE_TILES, (dword)BANK_TILES_SMALL)
    // [118] call cx16_load_ram_banked 
    // [501] phi from main::@2 to cx16_load_ram_banked [phi:main::@2->cx16_load_ram_banked]
    // [501] phi cx16_load_ram_banked::filename#7 = FILE_TILES [phi:main::@2->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_TILES
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_TILES
    sta.z cx16_load_ram_banked.filename+1
    // [501] phi cx16_load_ram_banked::address#7 = BANK_TILES_SMALL [phi:main::@2->cx16_load_ram_banked#1] -- vduz1=vduc1 
    lda #<BANK_TILES_SMALL
    sta.z cx16_load_ram_banked.address
    lda #>BANK_TILES_SMALL
    sta.z cx16_load_ram_banked.address+1
    lda #<BANK_TILES_SMALL>>$10
    sta.z cx16_load_ram_banked.address+2
    lda #>BANK_TILES_SMALL>>$10
    sta.z cx16_load_ram_banked.address+3
    jsr cx16_load_ram_banked
    // cx16_load_ram_banked(1, 8, 0, FILE_TILES, (dword)BANK_TILES_SMALL)
    // [119] cx16_load_ram_banked::return#14 = cx16_load_ram_banked::return#1 -- vbuaa=vbuz1 
    lda.z cx16_load_ram_banked.return
    // main::@28
    // status = cx16_load_ram_banked(1, 8, 0, FILE_TILES, (dword)BANK_TILES_SMALL)
    // [120] main::status#16 = cx16_load_ram_banked::return#14 -- vbuz1=vbuaa 
    sta.z status_6
    // if(status!=$ff)
    // [121] if(main::status#16==$ff) goto main::@3 -- vbuz1_eq_vbuc1_then_la1 
    lda #$ff
    cmp.z status_6
    beq __b3
    // [122] phi from main::@28 to main::@10 [phi:main::@28->main::@10]
    // main::@10
    // printf("error file_tiles = %x\n",status)
    // [123] call cputs 
    // [568] phi from main::@10 to cputs [phi:main::@10->cputs]
    // [568] phi cputs::s#16 = main::s4 [phi:main::@10->cputs#0] -- pbuz1=pbuc1 
    lda #<s4
    sta.z cputs.s
    lda #>s4
    sta.z cputs.s+1
    jsr cputs
    // main::@32
    // printf("error file_tiles = %x\n",status)
    // [124] printf_uchar::uvalue#2 = main::status#16 -- vbuxx=vbuz1 
    ldx.z status_6
    // [125] call printf_uchar 
    // [576] phi from main::@32 to printf_uchar [phi:main::@32->printf_uchar]
    // [576] phi printf_uchar::format_radix#10 = HEXADECIMAL [phi:main::@32->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #HEXADECIMAL
    // [576] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#2 [phi:main::@32->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [126] phi from main::@32 to main::@33 [phi:main::@32->main::@33]
    // main::@33
    // printf("error file_tiles = %x\n",status)
    // [127] call cputs 
    // [568] phi from main::@33 to cputs [phi:main::@33->cputs]
    // [568] phi cputs::s#16 = main::s1 [phi:main::@33->cputs#0] -- pbuz1=pbuc1 
    lda #<s1
    sta.z cputs.s
    lda #>s1
    sta.z cputs.s+1
    jsr cputs
    // [128] phi from main::@28 main::@33 to main::@3 [phi:main::@28/main::@33->main::@3]
    // main::@3
  __b3:
    // cx16_load_ram_banked(1, 8, 0, FILE_SQUAREMETAL, (dword)BANK_SQUAREMETAL)
    // [129] call cx16_load_ram_banked 
    // [501] phi from main::@3 to cx16_load_ram_banked [phi:main::@3->cx16_load_ram_banked]
    // [501] phi cx16_load_ram_banked::filename#7 = FILE_SQUAREMETAL [phi:main::@3->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_SQUAREMETAL
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_SQUAREMETAL
    sta.z cx16_load_ram_banked.filename+1
    // [501] phi cx16_load_ram_banked::address#7 = BANK_SQUAREMETAL [phi:main::@3->cx16_load_ram_banked#1] -- vduz1=vduc1 
    lda #<BANK_SQUAREMETAL
    sta.z cx16_load_ram_banked.address
    lda #>BANK_SQUAREMETAL
    sta.z cx16_load_ram_banked.address+1
    lda #<BANK_SQUAREMETAL>>$10
    sta.z cx16_load_ram_banked.address+2
    lda #>BANK_SQUAREMETAL>>$10
    sta.z cx16_load_ram_banked.address+3
    jsr cx16_load_ram_banked
    // cx16_load_ram_banked(1, 8, 0, FILE_SQUAREMETAL, (dword)BANK_SQUAREMETAL)
    // [130] cx16_load_ram_banked::return#15 = cx16_load_ram_banked::return#1 -- vbuaa=vbuz1 
    lda.z cx16_load_ram_banked.return
    // main::@31
    // status = cx16_load_ram_banked(1, 8, 0, FILE_SQUAREMETAL, (dword)BANK_SQUAREMETAL)
    // [131] main::status#10 = cx16_load_ram_banked::return#15 -- vbuz1=vbuaa 
    sta.z status_2
    // if(status!=$ff)
    // [132] if(main::status#10==$ff) goto main::@4 -- vbuz1_eq_vbuc1_then_la1 
    lda #$ff
    cmp.z status_2
    beq __b4
    // [133] phi from main::@31 to main::@11 [phi:main::@31->main::@11]
    // main::@11
    // printf("error file_squaremetal = %x\n",status)
    // [134] call cputs 
    // [568] phi from main::@11 to cputs [phi:main::@11->cputs]
    // [568] phi cputs::s#16 = main::s6 [phi:main::@11->cputs#0] -- pbuz1=pbuc1 
    lda #<s6
    sta.z cputs.s
    lda #>s6
    sta.z cputs.s+1
    jsr cputs
    // main::@35
    // printf("error file_squaremetal = %x\n",status)
    // [135] printf_uchar::uvalue#3 = main::status#10 -- vbuxx=vbuz1 
    ldx.z status_2
    // [136] call printf_uchar 
    // [576] phi from main::@35 to printf_uchar [phi:main::@35->printf_uchar]
    // [576] phi printf_uchar::format_radix#10 = HEXADECIMAL [phi:main::@35->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #HEXADECIMAL
    // [576] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#3 [phi:main::@35->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [137] phi from main::@35 to main::@36 [phi:main::@35->main::@36]
    // main::@36
    // printf("error file_squaremetal = %x\n",status)
    // [138] call cputs 
    // [568] phi from main::@36 to cputs [phi:main::@36->cputs]
    // [568] phi cputs::s#16 = main::s1 [phi:main::@36->cputs#0] -- pbuz1=pbuc1 
    lda #<s1
    sta.z cputs.s
    lda #>s1
    sta.z cputs.s+1
    jsr cputs
    // [139] phi from main::@31 main::@36 to main::@4 [phi:main::@31/main::@36->main::@4]
    // main::@4
  __b4:
    // cx16_load_ram_banked(1, 8, 0, FILE_TILEMETAL, (dword)BANK_TILEMETAL)
    // [140] call cx16_load_ram_banked 
    // [501] phi from main::@4 to cx16_load_ram_banked [phi:main::@4->cx16_load_ram_banked]
    // [501] phi cx16_load_ram_banked::filename#7 = FILE_TILEMETAL [phi:main::@4->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_TILEMETAL
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_TILEMETAL
    sta.z cx16_load_ram_banked.filename+1
    // [501] phi cx16_load_ram_banked::address#7 = BANK_TILEMETAL [phi:main::@4->cx16_load_ram_banked#1] -- vduz1=vduc1 
    lda #<BANK_TILEMETAL
    sta.z cx16_load_ram_banked.address
    lda #>BANK_TILEMETAL
    sta.z cx16_load_ram_banked.address+1
    lda #<BANK_TILEMETAL>>$10
    sta.z cx16_load_ram_banked.address+2
    lda #>BANK_TILEMETAL>>$10
    sta.z cx16_load_ram_banked.address+3
    jsr cx16_load_ram_banked
    // cx16_load_ram_banked(1, 8, 0, FILE_TILEMETAL, (dword)BANK_TILEMETAL)
    // [141] cx16_load_ram_banked::return#16 = cx16_load_ram_banked::return#1 -- vbuaa=vbuz1 
    lda.z cx16_load_ram_banked.return
    // main::@34
    // status = cx16_load_ram_banked(1, 8, 0, FILE_TILEMETAL, (dword)BANK_TILEMETAL)
    // [142] main::status#11 = cx16_load_ram_banked::return#16 -- vbuz1=vbuaa 
    sta.z status_3
    // if(status!=$ff)
    // [143] if(main::status#11==$ff) goto main::@5 -- vbuz1_eq_vbuc1_then_la1 
    lda #$ff
    cmp.z status_3
    beq __b5
    // [144] phi from main::@34 to main::@12 [phi:main::@34->main::@12]
    // main::@12
    // printf("error file_tilemetal = %x\n",status)
    // [145] call cputs 
    // [568] phi from main::@12 to cputs [phi:main::@12->cputs]
    // [568] phi cputs::s#16 = main::s8 [phi:main::@12->cputs#0] -- pbuz1=pbuc1 
    lda #<s8
    sta.z cputs.s
    lda #>s8
    sta.z cputs.s+1
    jsr cputs
    // main::@38
    // printf("error file_tilemetal = %x\n",status)
    // [146] printf_uchar::uvalue#4 = main::status#11 -- vbuxx=vbuz1 
    ldx.z status_3
    // [147] call printf_uchar 
    // [576] phi from main::@38 to printf_uchar [phi:main::@38->printf_uchar]
    // [576] phi printf_uchar::format_radix#10 = HEXADECIMAL [phi:main::@38->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #HEXADECIMAL
    // [576] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#4 [phi:main::@38->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [148] phi from main::@38 to main::@39 [phi:main::@38->main::@39]
    // main::@39
    // printf("error file_tilemetal = %x\n",status)
    // [149] call cputs 
    // [568] phi from main::@39 to cputs [phi:main::@39->cputs]
    // [568] phi cputs::s#16 = main::s1 [phi:main::@39->cputs#0] -- pbuz1=pbuc1 
    lda #<s1
    sta.z cputs.s
    lda #>s1
    sta.z cputs.s+1
    jsr cputs
    // [150] phi from main::@34 main::@39 to main::@5 [phi:main::@34/main::@39->main::@5]
    // main::@5
  __b5:
    // cx16_load_ram_banked(1, 8, 0, FILE_SQUARERASTER, (dword)BANK_SQUARERASTER)
    // [151] call cx16_load_ram_banked 
    // [501] phi from main::@5 to cx16_load_ram_banked [phi:main::@5->cx16_load_ram_banked]
    // [501] phi cx16_load_ram_banked::filename#7 = FILE_SQUARERASTER [phi:main::@5->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_SQUARERASTER
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_SQUARERASTER
    sta.z cx16_load_ram_banked.filename+1
    // [501] phi cx16_load_ram_banked::address#7 = BANK_SQUARERASTER [phi:main::@5->cx16_load_ram_banked#1] -- vduz1=vduc1 
    lda #<BANK_SQUARERASTER
    sta.z cx16_load_ram_banked.address
    lda #>BANK_SQUARERASTER
    sta.z cx16_load_ram_banked.address+1
    lda #<BANK_SQUARERASTER>>$10
    sta.z cx16_load_ram_banked.address+2
    lda #>BANK_SQUARERASTER>>$10
    sta.z cx16_load_ram_banked.address+3
    jsr cx16_load_ram_banked
    // cx16_load_ram_banked(1, 8, 0, FILE_SQUARERASTER, (dword)BANK_SQUARERASTER)
    // [152] cx16_load_ram_banked::return#17 = cx16_load_ram_banked::return#1 -- vbuaa=vbuz1 
    lda.z cx16_load_ram_banked.return
    // main::@37
    // status = cx16_load_ram_banked(1, 8, 0, FILE_SQUARERASTER, (dword)BANK_SQUARERASTER)
    // [153] main::status#12 = cx16_load_ram_banked::return#17 -- vbuz1=vbuaa 
    sta.z status_4
    // if(status!=$ff)
    // [154] if(main::status#12==$ff) goto main::@6 -- vbuz1_eq_vbuc1_then_la1 
    lda #$ff
    cmp.z status_4
    beq __b6
    // [155] phi from main::@37 to main::@13 [phi:main::@37->main::@13]
    // main::@13
    // printf("error file_squareraster = %x\n",status)
    // [156] call cputs 
    // [568] phi from main::@13 to cputs [phi:main::@13->cputs]
    // [568] phi cputs::s#16 = main::s10 [phi:main::@13->cputs#0] -- pbuz1=pbuc1 
    lda #<s10
    sta.z cputs.s
    lda #>s10
    sta.z cputs.s+1
    jsr cputs
    // main::@41
    // printf("error file_squareraster = %x\n",status)
    // [157] printf_uchar::uvalue#5 = main::status#12 -- vbuxx=vbuz1 
    ldx.z status_4
    // [158] call printf_uchar 
    // [576] phi from main::@41 to printf_uchar [phi:main::@41->printf_uchar]
    // [576] phi printf_uchar::format_radix#10 = HEXADECIMAL [phi:main::@41->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #HEXADECIMAL
    // [576] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#5 [phi:main::@41->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [159] phi from main::@41 to main::@42 [phi:main::@41->main::@42]
    // main::@42
    // printf("error file_squareraster = %x\n",status)
    // [160] call cputs 
    // [568] phi from main::@42 to cputs [phi:main::@42->cputs]
    // [568] phi cputs::s#16 = main::s1 [phi:main::@42->cputs#0] -- pbuz1=pbuc1 
    lda #<s1
    sta.z cputs.s
    lda #>s1
    sta.z cputs.s+1
    jsr cputs
    // [161] phi from main::@37 main::@42 to main::@6 [phi:main::@37/main::@42->main::@6]
    // main::@6
  __b6:
    // cx16_load_ram_banked(1, 8, 0, FILE_PALETTES, (dword)BANK_PALETTE)
    // [162] call cx16_load_ram_banked 
    // [501] phi from main::@6 to cx16_load_ram_banked [phi:main::@6->cx16_load_ram_banked]
    // [501] phi cx16_load_ram_banked::filename#7 = FILE_PALETTES [phi:main::@6->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_PALETTES
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_PALETTES
    sta.z cx16_load_ram_banked.filename+1
    // [501] phi cx16_load_ram_banked::address#7 = BANK_PALETTE [phi:main::@6->cx16_load_ram_banked#1] -- vduz1=vduc1 
    lda #<BANK_PALETTE
    sta.z cx16_load_ram_banked.address
    lda #>BANK_PALETTE
    sta.z cx16_load_ram_banked.address+1
    lda #<BANK_PALETTE>>$10
    sta.z cx16_load_ram_banked.address+2
    lda #>BANK_PALETTE>>$10
    sta.z cx16_load_ram_banked.address+3
    jsr cx16_load_ram_banked
    // cx16_load_ram_banked(1, 8, 0, FILE_PALETTES, (dword)BANK_PALETTE)
    // [163] cx16_load_ram_banked::return#10 = cx16_load_ram_banked::return#1 -- vbuaa=vbuz1 
    lda.z cx16_load_ram_banked.return
    // main::@40
    // status = cx16_load_ram_banked(1, 8, 0, FILE_PALETTES, (dword)BANK_PALETTE)
    // [164] main::status#13 = cx16_load_ram_banked::return#10 -- vbuz1=vbuaa 
    sta.z status_5
    // if(status!=$ff)
    // [165] if(main::status#13==$ff) goto main::@7 -- vbuz1_eq_vbuc1_then_la1 
    lda #$ff
    cmp.z status_5
    beq __b7
    // [166] phi from main::@40 to main::@14 [phi:main::@40->main::@14]
    // main::@14
    // printf("error file_palettes = %u",status)
    // [167] call cputs 
    // [568] phi from main::@14 to cputs [phi:main::@14->cputs]
    // [568] phi cputs::s#16 = main::s12 [phi:main::@14->cputs#0] -- pbuz1=pbuc1 
    lda #<s12
    sta.z cputs.s
    lda #>s12
    sta.z cputs.s+1
    jsr cputs
    // main::@52
    // printf("error file_palettes = %u",status)
    // [168] printf_uchar::uvalue#6 = main::status#13 -- vbuxx=vbuz1 
    ldx.z status_5
    // [169] call printf_uchar 
    // [576] phi from main::@52 to printf_uchar [phi:main::@52->printf_uchar]
    // [576] phi printf_uchar::format_radix#10 = DECIMAL [phi:main::@52->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #DECIMAL
    // [576] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#6 [phi:main::@52->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [170] phi from main::@40 main::@52 to main::@7 [phi:main::@40/main::@52->main::@7]
    // main::@7
  __b7:
    // bnkcpy_vram_address(VRAM_PLAYER, BANK_PLAYER, (dword)32*32*NUM_PLAYER/2)
    // [171] call bnkcpy_vram_address 
  // Copy graphics to the VERA VRAM.
    // [584] phi from main::@7 to bnkcpy_vram_address [phi:main::@7->bnkcpy_vram_address]
    // [584] phi bnkcpy_vram_address::num#7 = $20*$20*NUM_PLAYER/2 [phi:main::@7->bnkcpy_vram_address#0] -- vduz1=vduc1 
    lda #<$20*$20*NUM_PLAYER/2
    sta.z bnkcpy_vram_address.num
    lda #>$20*$20*NUM_PLAYER/2
    sta.z bnkcpy_vram_address.num+1
    lda #<$20*$20*NUM_PLAYER/2>>$10
    sta.z bnkcpy_vram_address.num+2
    lda #>$20*$20*NUM_PLAYER/2>>$10
    sta.z bnkcpy_vram_address.num+3
    // [584] phi bnkcpy_vram_address::beg#0 = BANK_PLAYER [phi:main::@7->bnkcpy_vram_address#1] -- vduz1=vduc1 
    lda #<BANK_PLAYER
    sta.z bnkcpy_vram_address.beg
    lda #>BANK_PLAYER
    sta.z bnkcpy_vram_address.beg+1
    lda #<BANK_PLAYER>>$10
    sta.z bnkcpy_vram_address.beg+2
    lda #>BANK_PLAYER>>$10
    sta.z bnkcpy_vram_address.beg+3
    // [584] phi bnkcpy_vram_address::vdest#7 = VRAM_PLAYER [phi:main::@7->bnkcpy_vram_address#2] -- vduz1=vduc1 
    lda #<VRAM_PLAYER
    sta.z bnkcpy_vram_address.vdest
    lda #>VRAM_PLAYER
    sta.z bnkcpy_vram_address.vdest+1
    lda #<VRAM_PLAYER>>$10
    sta.z bnkcpy_vram_address.vdest+2
    lda #>VRAM_PLAYER>>$10
    sta.z bnkcpy_vram_address.vdest+3
    jsr bnkcpy_vram_address
    // [172] phi from main::@7 to main::@43 [phi:main::@7->main::@43]
    // main::@43
    // bnkcpy_vram_address(VRAM_ENEMY2, BANK_ENEMY2, (dword)32*32*NUM_ENEMY2/2)
    // [173] call bnkcpy_vram_address 
    // [584] phi from main::@43 to bnkcpy_vram_address [phi:main::@43->bnkcpy_vram_address]
    // [584] phi bnkcpy_vram_address::num#7 = $20*$20*NUM_ENEMY2/2 [phi:main::@43->bnkcpy_vram_address#0] -- vduz1=vduc1 
    lda #<$20*$20*NUM_ENEMY2/2
    sta.z bnkcpy_vram_address.num
    lda #>$20*$20*NUM_ENEMY2/2
    sta.z bnkcpy_vram_address.num+1
    lda #<$20*$20*NUM_ENEMY2/2>>$10
    sta.z bnkcpy_vram_address.num+2
    lda #>$20*$20*NUM_ENEMY2/2>>$10
    sta.z bnkcpy_vram_address.num+3
    // [584] phi bnkcpy_vram_address::beg#0 = BANK_ENEMY2 [phi:main::@43->bnkcpy_vram_address#1] -- vduz1=vduc1 
    lda #<BANK_ENEMY2
    sta.z bnkcpy_vram_address.beg
    lda #>BANK_ENEMY2
    sta.z bnkcpy_vram_address.beg+1
    lda #<BANK_ENEMY2>>$10
    sta.z bnkcpy_vram_address.beg+2
    lda #>BANK_ENEMY2>>$10
    sta.z bnkcpy_vram_address.beg+3
    // [584] phi bnkcpy_vram_address::vdest#7 = VRAM_ENEMY2 [phi:main::@43->bnkcpy_vram_address#2] -- vduz1=vduc1 
    lda #<VRAM_ENEMY2
    sta.z bnkcpy_vram_address.vdest
    lda #>VRAM_ENEMY2
    sta.z bnkcpy_vram_address.vdest+1
    lda #<VRAM_ENEMY2>>$10
    sta.z bnkcpy_vram_address.vdest+2
    lda #>VRAM_ENEMY2>>$10
    sta.z bnkcpy_vram_address.vdest+3
    jsr bnkcpy_vram_address
    // [174] phi from main::@43 to main::@44 [phi:main::@43->main::@44]
    // main::@44
    // bnkcpy_vram_address(VRAM_TILES_SMALL, BANK_TILES_SMALL, (dword)32*32*(NUM_TILES_SMALL)/2)
    // [175] call bnkcpy_vram_address 
    // [584] phi from main::@44 to bnkcpy_vram_address [phi:main::@44->bnkcpy_vram_address]
    // [584] phi bnkcpy_vram_address::num#7 = $20*$20*NUM_TILES_SMALL/2 [phi:main::@44->bnkcpy_vram_address#0] -- vduz1=vduc1 
    lda #<$20*$20*NUM_TILES_SMALL/2
    sta.z bnkcpy_vram_address.num
    lda #>$20*$20*NUM_TILES_SMALL/2
    sta.z bnkcpy_vram_address.num+1
    lda #<$20*$20*NUM_TILES_SMALL/2>>$10
    sta.z bnkcpy_vram_address.num+2
    lda #>$20*$20*NUM_TILES_SMALL/2>>$10
    sta.z bnkcpy_vram_address.num+3
    // [584] phi bnkcpy_vram_address::beg#0 = BANK_TILES_SMALL [phi:main::@44->bnkcpy_vram_address#1] -- vduz1=vduc1 
    lda #<BANK_TILES_SMALL
    sta.z bnkcpy_vram_address.beg
    lda #>BANK_TILES_SMALL
    sta.z bnkcpy_vram_address.beg+1
    lda #<BANK_TILES_SMALL>>$10
    sta.z bnkcpy_vram_address.beg+2
    lda #>BANK_TILES_SMALL>>$10
    sta.z bnkcpy_vram_address.beg+3
    // [584] phi bnkcpy_vram_address::vdest#7 = VRAM_TILES_SMALL [phi:main::@44->bnkcpy_vram_address#2] -- vduz1=vduc1 
    lda #<VRAM_TILES_SMALL
    sta.z bnkcpy_vram_address.vdest
    lda #>VRAM_TILES_SMALL
    sta.z bnkcpy_vram_address.vdest+1
    lda #<VRAM_TILES_SMALL>>$10
    sta.z bnkcpy_vram_address.vdest+2
    lda #>VRAM_TILES_SMALL>>$10
    sta.z bnkcpy_vram_address.vdest+3
    jsr bnkcpy_vram_address
    // [176] phi from main::@44 to main::@45 [phi:main::@44->main::@45]
    // main::@45
    // bnkcpy_vram_address(VRAM_SQUAREMETAL, BANK_SQUAREMETAL, (dword)64*64*(NUM_SQUAREMETAL)/2)
    // [177] call bnkcpy_vram_address 
    // [584] phi from main::@45 to bnkcpy_vram_address [phi:main::@45->bnkcpy_vram_address]
    // [584] phi bnkcpy_vram_address::num#7 = $40*$40*NUM_SQUAREMETAL/2 [phi:main::@45->bnkcpy_vram_address#0] -- vduz1=vduc1 
    lda #<$40*$40*NUM_SQUAREMETAL/2
    sta.z bnkcpy_vram_address.num
    lda #>$40*$40*NUM_SQUAREMETAL/2
    sta.z bnkcpy_vram_address.num+1
    lda #<$40*$40*NUM_SQUAREMETAL/2>>$10
    sta.z bnkcpy_vram_address.num+2
    lda #>$40*$40*NUM_SQUAREMETAL/2>>$10
    sta.z bnkcpy_vram_address.num+3
    // [584] phi bnkcpy_vram_address::beg#0 = BANK_SQUAREMETAL [phi:main::@45->bnkcpy_vram_address#1] -- vduz1=vduc1 
    lda #<BANK_SQUAREMETAL
    sta.z bnkcpy_vram_address.beg
    lda #>BANK_SQUAREMETAL
    sta.z bnkcpy_vram_address.beg+1
    lda #<BANK_SQUAREMETAL>>$10
    sta.z bnkcpy_vram_address.beg+2
    lda #>BANK_SQUAREMETAL>>$10
    sta.z bnkcpy_vram_address.beg+3
    // [584] phi bnkcpy_vram_address::vdest#7 = VRAM_SQUAREMETAL [phi:main::@45->bnkcpy_vram_address#2] -- vduz1=vduc1 
    lda #<VRAM_SQUAREMETAL
    sta.z bnkcpy_vram_address.vdest
    lda #>VRAM_SQUAREMETAL
    sta.z bnkcpy_vram_address.vdest+1
    lda #<VRAM_SQUAREMETAL>>$10
    sta.z bnkcpy_vram_address.vdest+2
    lda #>VRAM_SQUAREMETAL>>$10
    sta.z bnkcpy_vram_address.vdest+3
    jsr bnkcpy_vram_address
    // [178] phi from main::@45 to main::@46 [phi:main::@45->main::@46]
    // main::@46
    // bnkcpy_vram_address(VRAM_TILEMETAL, BANK_TILEMETAL, (dword)64*64*(NUM_TILEMETAL)/2)
    // [179] call bnkcpy_vram_address 
    // [584] phi from main::@46 to bnkcpy_vram_address [phi:main::@46->bnkcpy_vram_address]
    // [584] phi bnkcpy_vram_address::num#7 = $40*$40*NUM_TILEMETAL/2 [phi:main::@46->bnkcpy_vram_address#0] -- vduz1=vduc1 
    lda #<$40*$40*NUM_TILEMETAL/2
    sta.z bnkcpy_vram_address.num
    lda #>$40*$40*NUM_TILEMETAL/2
    sta.z bnkcpy_vram_address.num+1
    lda #<$40*$40*NUM_TILEMETAL/2>>$10
    sta.z bnkcpy_vram_address.num+2
    lda #>$40*$40*NUM_TILEMETAL/2>>$10
    sta.z bnkcpy_vram_address.num+3
    // [584] phi bnkcpy_vram_address::beg#0 = BANK_TILEMETAL [phi:main::@46->bnkcpy_vram_address#1] -- vduz1=vduc1 
    lda #<BANK_TILEMETAL
    sta.z bnkcpy_vram_address.beg
    lda #>BANK_TILEMETAL
    sta.z bnkcpy_vram_address.beg+1
    lda #<BANK_TILEMETAL>>$10
    sta.z bnkcpy_vram_address.beg+2
    lda #>BANK_TILEMETAL>>$10
    sta.z bnkcpy_vram_address.beg+3
    // [584] phi bnkcpy_vram_address::vdest#7 = VRAM_TILEMETAL [phi:main::@46->bnkcpy_vram_address#2] -- vduz1=vduc1 
    lda #<VRAM_TILEMETAL
    sta.z bnkcpy_vram_address.vdest
    lda #>VRAM_TILEMETAL
    sta.z bnkcpy_vram_address.vdest+1
    lda #<VRAM_TILEMETAL>>$10
    sta.z bnkcpy_vram_address.vdest+2
    lda #>VRAM_TILEMETAL>>$10
    sta.z bnkcpy_vram_address.vdest+3
    jsr bnkcpy_vram_address
    // [180] phi from main::@46 to main::@47 [phi:main::@46->main::@47]
    // main::@47
    // bnkcpy_vram_address(VRAM_SQUARERASTER, BANK_SQUARERASTER, (dword)64*64*(NUM_SQUARERASTER)/2)
    // [181] call bnkcpy_vram_address 
    // [584] phi from main::@47 to bnkcpy_vram_address [phi:main::@47->bnkcpy_vram_address]
    // [584] phi bnkcpy_vram_address::num#7 = $40*$40*NUM_SQUARERASTER/2 [phi:main::@47->bnkcpy_vram_address#0] -- vduz1=vduc1 
    lda #<$40*$40*NUM_SQUARERASTER/2
    sta.z bnkcpy_vram_address.num
    lda #>$40*$40*NUM_SQUARERASTER/2
    sta.z bnkcpy_vram_address.num+1
    lda #<$40*$40*NUM_SQUARERASTER/2>>$10
    sta.z bnkcpy_vram_address.num+2
    lda #>$40*$40*NUM_SQUARERASTER/2>>$10
    sta.z bnkcpy_vram_address.num+3
    // [584] phi bnkcpy_vram_address::beg#0 = BANK_SQUARERASTER [phi:main::@47->bnkcpy_vram_address#1] -- vduz1=vduc1 
    lda #<BANK_SQUARERASTER
    sta.z bnkcpy_vram_address.beg
    lda #>BANK_SQUARERASTER
    sta.z bnkcpy_vram_address.beg+1
    lda #<BANK_SQUARERASTER>>$10
    sta.z bnkcpy_vram_address.beg+2
    lda #>BANK_SQUARERASTER>>$10
    sta.z bnkcpy_vram_address.beg+3
    // [584] phi bnkcpy_vram_address::vdest#7 = VRAM_SQUARERASTER [phi:main::@47->bnkcpy_vram_address#2] -- vduz1=vduc1 
    lda #<VRAM_SQUARERASTER
    sta.z bnkcpy_vram_address.vdest
    lda #>VRAM_SQUARERASTER
    sta.z bnkcpy_vram_address.vdest+1
    lda #<VRAM_SQUARERASTER>>$10
    sta.z bnkcpy_vram_address.vdest+2
    lda #>VRAM_SQUARERASTER>>$10
    sta.z bnkcpy_vram_address.vdest+3
    jsr bnkcpy_vram_address
    // [182] phi from main::@47 to main::@48 [phi:main::@47->main::@48]
    // main::@48
    // bnkcpy_vram_address(VERA_PALETTE+32, BANK_PALETTE, (dword)32*6)
    // [183] call bnkcpy_vram_address 
  // Load the palette in VERA palette registers, but keep the first 16 colors untouched.
    // [584] phi from main::@48 to bnkcpy_vram_address [phi:main::@48->bnkcpy_vram_address]
    // [584] phi bnkcpy_vram_address::num#7 = $20*6 [phi:main::@48->bnkcpy_vram_address#0] -- vduz1=vduc1 
    lda #<$20*6
    sta.z bnkcpy_vram_address.num
    lda #>$20*6
    sta.z bnkcpy_vram_address.num+1
    lda #<$20*6>>$10
    sta.z bnkcpy_vram_address.num+2
    lda #>$20*6>>$10
    sta.z bnkcpy_vram_address.num+3
    // [584] phi bnkcpy_vram_address::beg#0 = BANK_PALETTE [phi:main::@48->bnkcpy_vram_address#1] -- vduz1=vduc1 
    lda #<BANK_PALETTE
    sta.z bnkcpy_vram_address.beg
    lda #>BANK_PALETTE
    sta.z bnkcpy_vram_address.beg+1
    lda #<BANK_PALETTE>>$10
    sta.z bnkcpy_vram_address.beg+2
    lda #>BANK_PALETTE>>$10
    sta.z bnkcpy_vram_address.beg+3
    // [584] phi bnkcpy_vram_address::vdest#7 = VERA_PALETTE+$20 [phi:main::@48->bnkcpy_vram_address#2] -- vduz1=vduc1 
    lda #<VERA_PALETTE+$20
    sta.z bnkcpy_vram_address.vdest
    lda #>VERA_PALETTE+$20
    sta.z bnkcpy_vram_address.vdest+1
    lda #<VERA_PALETTE+$20>>$10
    sta.z bnkcpy_vram_address.vdest+2
    lda #>VERA_PALETTE+$20>>$10
    sta.z bnkcpy_vram_address.vdest+3
    jsr bnkcpy_vram_address
    // main::vera_layer_show1
    // *VERA_CTRL &= ~VERA_DCSEL
    // [184] *VERA_CTRL = *VERA_CTRL & ~VERA_DCSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_DCSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // *VERA_DC_VIDEO |= vera_layer_enable[layer]
    // [185] *VERA_DC_VIDEO = *VERA_DC_VIDEO | *vera_layer_enable -- _deref_pbuc1=_deref_pbuc1_bor__deref_pbuc2 
    lda VERA_DC_VIDEO
    ora vera_layer_enable
    sta VERA_DC_VIDEO
    // [186] phi from main::vera_layer_show1 to main::@18 [phi:main::vera_layer_show1->main::@18]
    // main::@18
    // tile_background()
    // [187] call tile_background 
    // [627] phi from main::@18 to tile_background [phi:main::@18->tile_background]
    jsr tile_background
    // [188] phi from main::@18 to main::@49 [phi:main::@18->main::@49]
    // main::@49
    // create_sprites_player()
    // [189] call create_sprites_player 
    // [648] phi from main::@49 to create_sprites_player [phi:main::@49->create_sprites_player]
    jsr create_sprites_player
    // [190] phi from main::@49 to main::@50 [phi:main::@49->main::@50]
    // main::@50
    // create_sprites_enemy2()
    // [191] call create_sprites_enemy2 
    // [671] phi from main::@50 to create_sprites_enemy2 [phi:main::@50->create_sprites_enemy2]
    jsr create_sprites_enemy2
    // main::@51
    // *VERA_CTRL &= ~VERA_DCSEL
    // [192] *VERA_CTRL = *VERA_CTRL & ~VERA_DCSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    // Enable sprites
    lda #VERA_DCSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // *VERA_DC_VIDEO |= VERA_SPRITES_ENABLE
    // [193] *VERA_DC_VIDEO = *VERA_DC_VIDEO | VERA_SPRITES_ENABLE -- _deref_pbuc1=_deref_pbuc1_bor_vbuc2 
    lda #VERA_SPRITES_ENABLE
    ora VERA_DC_VIDEO
    sta VERA_DC_VIDEO
    // main::SEI1
    // asm
    // asm { sei  }
    sei
    // main::@19
    // *KERNEL_IRQ = &irq_vsync
    // [195] *KERNEL_IRQ = &irq_vsync -- _deref_qprc1=pprc2 
    lda #<irq_vsync
    sta KERNEL_IRQ
    lda #>irq_vsync
    sta KERNEL_IRQ+1
    // *VERA_IEN = VERA_VSYNC
    // [196] *VERA_IEN = VERA_VSYNC -- _deref_pbuc1=vbuc2 
    lda #VERA_VSYNC
    sta VERA_IEN
    // main::CLI1
    // asm
    // asm { cli  }
    cli
    // [198] phi from main::@53 main::CLI1 to main::@15 [phi:main::@53/main::CLI1->main::@15]
    // main::@15
  __b15:
    // fgetc()
    // [199] call fgetc 
    jsr fgetc
    // [200] fgetc::return#2 = fgetc::return#1
    // main::@53
    // [201] main::$48 = fgetc::return#2
    // while(!fgetc())
    // [202] if(0==main::$48) goto main::@15 -- 0_eq_vbuaa_then_la1 
    cmp #0
    beq __b15
    // main::@16
    // VIA1->PORT_B = 4
    // [203] *((byte*)VIA1) = 4 -- _deref_pbuc1=vbuc2 
    lda #4
    sta VIA1
    // main::@return
    // }
    // [204] return 
    rts
  .segment Data
    s: .text "error file_sprites: "
    .byte 0
    s1: .text @"\n"
    .byte 0
    s2: .text "error file_enemy2 = "
    .byte 0
    s4: .text "error file_tiles = "
    .byte 0
    s6: .text "error file_squaremetal = "
    .byte 0
    s8: .text "error file_tilemetal = "
    .byte 0
    s10: .text "error file_squareraster = "
    .byte 0
    s12: .text "error file_palettes = "
    .byte 0
}
.segment Code
  // rotate_sprites
// rotate_sprites(word zp(8) base, word zp($3a) rotate, word zp($38) max, word* zp($3c) spriteaddresses, word zp(6) basex)
rotate_sprites: {
    .label __5 = $a
    .label __6 = $a
    .label __8 = $a
    .label __9 = $a
    .label __10 = $a
    .label __12 = $a
    .label __13 = $a
    .label __14 = $a
    .label i = $a
    .label s = 3
    .label rotate = $3a
    .label max = $38
    .label spriteaddresses = $3c
    .label basex = 6
    .label base = 8
    .label __15 = $a
    // [206] phi from rotate_sprites to rotate_sprites::@1 [phi:rotate_sprites->rotate_sprites::@1]
    // [206] phi rotate_sprites::s#2 = 0 [phi:rotate_sprites->rotate_sprites::@1#0] -- vbuz1=vbuc1 
    lda #0
    sta.z s
    // rotate_sprites::@1
  __b1:
    // for(byte s=0;s<max;s++)
    // [207] if(rotate_sprites::s#2<rotate_sprites::max#5) goto rotate_sprites::@2 -- vbuz1_lt_vwuz2_then_la1 
    lda.z max+1
    bne __b2
    lda.z s
    cmp.z max
    bcc __b2
    // rotate_sprites::@return
    // }
    // [208] return 
    rts
    // rotate_sprites::@2
  __b2:
    // i = s+rotate
    // [209] rotate_sprites::i#0 = rotate_sprites::s#2 + rotate_sprites::rotate#4 -- vwuz1=vbuz2_plus_vwuz3 
    lda.z s
    clc
    adc.z rotate
    sta.z i
    lda #0
    adc.z rotate+1
    sta.z i+1
    // if(i>=max)
    // [210] if(rotate_sprites::i#0<rotate_sprites::max#5) goto rotate_sprites::@3 -- vwuz1_lt_vwuz2_then_la1 
    cmp.z max+1
    bcc __b3
    bne !+
    lda.z i
    cmp.z max
    bcc __b3
  !:
    // rotate_sprites::@4
    // i-=max
    // [211] rotate_sprites::i#1 = rotate_sprites::i#0 - rotate_sprites::max#5 -- vwuz1=vwuz1_minus_vwuz2 
    lda.z i
    sec
    sbc.z max
    sta.z i
    lda.z i+1
    sbc.z max+1
    sta.z i+1
    // [212] phi from rotate_sprites::@2 rotate_sprites::@4 to rotate_sprites::@3 [phi:rotate_sprites::@2/rotate_sprites::@4->rotate_sprites::@3]
    // [212] phi rotate_sprites::i#2 = rotate_sprites::i#0 [phi:rotate_sprites::@2/rotate_sprites::@4->rotate_sprites::@3#0] -- register_copy 
    // rotate_sprites::@3
  __b3:
    // SPRITE_ATTR.ADDR = spriteaddresses[i]
    // [213] rotate_sprites::$12 = rotate_sprites::i#2 << 1 -- vwuz1=vwuz1_rol_1 
    asl.z __12
    rol.z __12+1
    // [214] rotate_sprites::$15 = rotate_sprites::spriteaddresses#6 + rotate_sprites::$12 -- pwuz1=pwuz2_plus_vwuz1 
    lda.z __15
    clc
    adc.z spriteaddresses
    sta.z __15
    lda.z __15+1
    adc.z spriteaddresses+1
    sta.z __15+1
    // [215] *((word*)&SPRITE_ATTR) = *rotate_sprites::$15 -- _deref_pwuc1=_deref_pwuz1 
    ldy #0
    lda (__15),y
    sta SPRITE_ATTR
    iny
    lda (__15),y
    sta SPRITE_ATTR+1
    // s&03
    // [216] rotate_sprites::$4 = rotate_sprites::s#2 & 3 -- vbuaa=vbuz1_band_vbuc1 
    lda #3
    and.z s
    // (word)(s&03)<<6
    // [217] rotate_sprites::$13 = (word)rotate_sprites::$4 -- vwuz1=_word_vbuaa 
    sta.z __13
    lda #0
    sta.z __13+1
    // [218] rotate_sprites::$5 = rotate_sprites::$13 << 6 -- vwuz1=vwuz1_rol_6 
    lda.z __5+1
    lsr
    sta.z $ff
    lda.z __5
    ror
    sta.z __5+1
    lda #0
    ror
    sta.z __5
    lsr.z $ff
    ror.z __5+1
    ror.z __5
    // basex+((word)(s&03)<<6)
    // [219] rotate_sprites::$6 = rotate_sprites::basex#6 + rotate_sprites::$5 -- vwuz1=vwuz2_plus_vwuz1 
    lda.z __6
    clc
    adc.z basex
    sta.z __6
    lda.z __6+1
    adc.z basex+1
    sta.z __6+1
    // SPRITE_ATTR.X = basex+((word)(s&03)<<6)
    // [220] *((word*)&SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_X) = rotate_sprites::$6 -- _deref_pwuc1=vwuz1 
    lda.z __6
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_X
    lda.z __6+1
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_X+1
    // s>>2
    // [221] rotate_sprites::$7 = rotate_sprites::s#2 >> 2 -- vbuaa=vbuz1_ror_2 
    lda.z s
    lsr
    lsr
    // (word)(s>>2)<<6
    // [222] rotate_sprites::$14 = (word)rotate_sprites::$7 -- vwuz1=_word_vbuaa 
    sta.z __14
    lda #0
    sta.z __14+1
    // [223] rotate_sprites::$8 = rotate_sprites::$14 << 6 -- vwuz1=vwuz1_rol_6 
    lda.z __8+1
    lsr
    sta.z $ff
    lda.z __8
    ror
    sta.z __8+1
    lda #0
    ror
    sta.z __8
    lsr.z $ff
    ror.z __8+1
    ror.z __8
    // basey+((word)(s>>2)<<6)
    // [224] rotate_sprites::$9 = $64 + rotate_sprites::$8 -- vwuz1=vbuc1_plus_vwuz1 
    lda #$64
    clc
    adc.z __9
    sta.z __9
    bcc !+
    inc.z __9+1
  !:
    // SPRITE_ATTR.Y = basey+((word)(s>>2)<<6)
    // [225] *((word*)&SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_Y) = rotate_sprites::$9 -- _deref_pwuc1=vwuz1 
    lda.z __9
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_Y
    lda.z __9+1
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_Y+1
    // s+base
    // [226] rotate_sprites::$10 = rotate_sprites::s#2 + rotate_sprites::base#6 -- vwuz1=vbuz2_plus_vwuz3 
    lda.z s
    clc
    adc.z base
    sta.z __10
    lda #0
    adc.z base+1
    sta.z __10+1
    // vera_sprite_attributes_set((byte)(s+base),SPRITE_ATTR)
    // [227] vera_sprite_attributes_set::sprite#0 = (byte)rotate_sprites::$10 -- vbuxx=_byte_vwuz1 
    lda.z __10
    tax
    // [228] *(&vera_sprite_attributes_set::sprite_attr) = memcpy(*(&SPRITE_ATTR), struct VERA_SPRITE, SIZEOF_STRUCT_VERA_SPRITE) -- _deref_pssc1=_deref_pssc2_memcpy_vbuc3 
    ldy #SIZEOF_STRUCT_VERA_SPRITE
  !:
    lda SPRITE_ATTR-1,y
    sta vera_sprite_attributes_set.sprite_attr-1,y
    dey
    bne !-
    // [229] call vera_sprite_attributes_set 
  // Copy sprite positions to VRAM (the 4 relevant bytes in VERA_SPRITE_ATTR)
    // [699] phi from rotate_sprites::@3 to vera_sprite_attributes_set [phi:rotate_sprites::@3->vera_sprite_attributes_set]
    // [699] phi vera_sprite_attributes_set::sprite#3 = vera_sprite_attributes_set::sprite#0 [phi:rotate_sprites::@3->vera_sprite_attributes_set#0] -- register_copy 
    jsr vera_sprite_attributes_set
    // rotate_sprites::@5
    // for(byte s=0;s<max;s++)
    // [230] rotate_sprites::s#1 = ++ rotate_sprites::s#2 -- vbuz1=_inc_vbuz1 
    inc.z s
    // [206] phi from rotate_sprites::@5 to rotate_sprites::@1 [phi:rotate_sprites::@5->rotate_sprites::@1]
    // [206] phi rotate_sprites::s#2 = rotate_sprites::s#1 [phi:rotate_sprites::@5->rotate_sprites::@1#0] -- register_copy 
    jmp __b1
}
  // memcpy_in_vram
// Copy block of memory (from VRAM to VRAM)
// Copies the values from the location pointed by src to the location pointed by dest.
// The method uses the VERA access ports 0 and 1 to copy data from and to in VRAM.
// - src_bank:  64K VRAM bank number to copy from (0/1).
// - src: pointer to the location to copy from. Note that the address is a 16 bit value!
// - src_increment: the increment indicator, VERA needs this because addressing increment is automated by VERA at each access.
// - dest_bank:  64K VRAM bank number to copy to (0/1).
// - dest: pointer to the location to copy to. Note that the address is a 16 bit value!
// - dest_increment: the increment indicator, VERA needs this because addressing increment is automated by VERA at each access.
// - num: The number of bytes to copy
// memcpy_in_vram(byte zp($e) dest_bank, void* zp($c) dest, byte register(Y) src_bank, byte* zp($4c) src, word zp($4a) num)
memcpy_in_vram: {
    .label i = $c
    .label dest = $c
    .label src = $4c
    .label num = $4a
    .label dest_bank = $e
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [232] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    // Select DATA0
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <src
    // [233] memcpy_in_vram::$0 = < memcpy_in_vram::src#3 -- vbuaa=_lo_pvoz1 
    lda.z src
    // *VERA_ADDRX_L = <src
    // [234] *VERA_ADDRX_L = memcpy_in_vram::$0 -- _deref_pbuc1=vbuaa 
    // Set address
    sta VERA_ADDRX_L
    // >src
    // [235] memcpy_in_vram::$1 = > memcpy_in_vram::src#3 -- vbuaa=_hi_pvoz1 
    lda.z src+1
    // *VERA_ADDRX_M = >src
    // [236] *VERA_ADDRX_M = memcpy_in_vram::$1 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // src_increment | src_bank
    // [237] memcpy_in_vram::$2 = VERA_INC_1 | memcpy_in_vram::src_bank#3 -- vbuaa=vbuc1_bor_vbuyy 
    tya
    ora #VERA_INC_1
    // *VERA_ADDRX_H = src_increment | src_bank
    // [238] *VERA_ADDRX_H = memcpy_in_vram::$2 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_H
    // *VERA_CTRL |= VERA_ADDRSEL
    // [239] *VERA_CTRL = *VERA_CTRL | VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_bor_vbuc2 
    // Select DATA1
    lda #VERA_ADDRSEL
    ora VERA_CTRL
    sta VERA_CTRL
    // <dest
    // [240] memcpy_in_vram::$3 = < memcpy_in_vram::dest#3 -- vbuaa=_lo_pvoz1 
    lda.z dest
    // *VERA_ADDRX_L = <dest
    // [241] *VERA_ADDRX_L = memcpy_in_vram::$3 -- _deref_pbuc1=vbuaa 
    // Set address
    sta VERA_ADDRX_L
    // >dest
    // [242] memcpy_in_vram::$4 = > memcpy_in_vram::dest#3 -- vbuaa=_hi_pvoz1 
    lda.z dest+1
    // *VERA_ADDRX_M = >dest
    // [243] *VERA_ADDRX_M = memcpy_in_vram::$4 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // dest_increment | dest_bank
    // [244] memcpy_in_vram::$5 = VERA_INC_1 | memcpy_in_vram::dest_bank#3 -- vbuaa=vbuc1_bor_vbuz1 
    lda #VERA_INC_1
    ora.z dest_bank
    // *VERA_ADDRX_H = dest_increment | dest_bank
    // [245] *VERA_ADDRX_H = memcpy_in_vram::$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_H
    // [246] phi from memcpy_in_vram to memcpy_in_vram::@1 [phi:memcpy_in_vram->memcpy_in_vram::@1]
    // [246] phi memcpy_in_vram::i#2 = 0 [phi:memcpy_in_vram->memcpy_in_vram::@1#0] -- vwuz1=vwuc1 
    lda #<0
    sta.z i
    sta.z i+1
  // Transfer the data
    // memcpy_in_vram::@1
  __b1:
    // for(unsigned int i=0; i<num; i++)
    // [247] if(memcpy_in_vram::i#2<memcpy_in_vram::num#4) goto memcpy_in_vram::@2 -- vwuz1_lt_vwuz2_then_la1 
    lda.z i+1
    cmp.z num+1
    bcc __b2
    bne !+
    lda.z i
    cmp.z num
    bcc __b2
  !:
    // memcpy_in_vram::@return
    // }
    // [248] return 
    rts
    // memcpy_in_vram::@2
  __b2:
    // *VERA_DATA1 = *VERA_DATA0
    // [249] *VERA_DATA1 = *VERA_DATA0 -- _deref_pbuc1=_deref_pbuc2 
    lda VERA_DATA0
    sta VERA_DATA1
    // for(unsigned int i=0; i<num; i++)
    // [250] memcpy_in_vram::i#1 = ++ memcpy_in_vram::i#2 -- vwuz1=_inc_vwuz1 
    inc.z i
    bne !+
    inc.z i+1
  !:
    // [246] phi from memcpy_in_vram::@2 to memcpy_in_vram::@1 [phi:memcpy_in_vram::@2->memcpy_in_vram::@1]
    // [246] phi memcpy_in_vram::i#2 = memcpy_in_vram::i#1 [phi:memcpy_in_vram::@2->memcpy_in_vram::@1#0] -- register_copy 
    jmp __b1
}
  // rand
// Returns a pseudo-random number in the range of 0 to RAND_MAX (65535)
// Uses an xorshift pseudorandom number generator that hits all different values
// Information https://en.wikipedia.org/wiki/Xorshift
// Source http://www.retroprogramming.com/2017/07/xorshift-pseudorandom-numbers-in-z80.html
rand: {
    .label __0 = $4c
    .label __1 = $4a
    .label __2 = $c
    .label return = $c
    // rand_state << 7
    // [252] rand::$0 = rand_state#13 << 7 -- vwuz1=vwuz2_rol_7 
    lda.z rand_state+1
    lsr
    lda.z rand_state
    ror
    sta.z __0+1
    lda #0
    ror
    sta.z __0
    // rand_state ^= rand_state << 7
    // [253] rand_state#0 = rand_state#13 ^ rand::$0 -- vwuz1=vwuz1_bxor_vwuz2 
    lda.z rand_state
    eor.z __0
    sta.z rand_state
    lda.z rand_state+1
    eor.z __0+1
    sta.z rand_state+1
    // rand_state >> 9
    // [254] rand::$1 = rand_state#0 >> 9 -- vwuz1=vwuz2_ror_9 
    lsr
    sta.z __1
    lda #0
    sta.z __1+1
    // rand_state ^= rand_state >> 9
    // [255] rand_state#1 = rand_state#0 ^ rand::$1 -- vwuz1=vwuz1_bxor_vwuz2 
    lda.z rand_state
    eor.z __1
    sta.z rand_state
    lda.z rand_state+1
    eor.z __1+1
    sta.z rand_state+1
    // rand_state << 8
    // [256] rand::$2 = rand_state#1 << 8 -- vwuz1=vwuz2_rol_8 
    lda.z rand_state
    sta.z __2+1
    lda #0
    sta.z __2
    // rand_state ^= rand_state << 8
    // [257] rand_state#14 = rand_state#1 ^ rand::$2 -- vwuz1=vwuz1_bxor_vwuz2 
    lda.z rand_state
    eor.z __2
    sta.z rand_state
    lda.z rand_state+1
    eor.z __2+1
    sta.z rand_state+1
    // return rand_state;
    // [258] rand::return#0 = rand_state#14 -- vwuz1=vwuz2 
    lda.z rand_state
    sta.z return
    lda.z rand_state+1
    sta.z return+1
    // rand::@return
    // }
    // [259] return 
    rts
}
  // modr16u
// Performs modulo on two 16 bit unsigned ints and an initial remainder
// Returns the remainder.
// The final remainder will be set into the global variable rem16u
// Implemented using simple binary division
// modr16u(word zp($c) dividend, word zp($4c) rem)
modr16u: {
    .label rem = $4c
    .label dividend = $c
    .label quotient = $4a
    .label return = $4c
    // [261] phi from modr16u to modr16u::@1 [phi:modr16u->modr16u::@1]
    // [261] phi modr16u::i#2 = 0 [phi:modr16u->modr16u::@1#0] -- vbuxx=vbuc1 
    ldx #0
    // [261] phi modr16u::quotient#3 = 0 [phi:modr16u->modr16u::@1#1] -- vwuz1=vwuc1 
    txa
    sta.z quotient
    sta.z quotient+1
    // [261] phi modr16u::dividend#3 = modr16u::dividend#5 [phi:modr16u->modr16u::@1#2] -- register_copy 
    // [261] phi modr16u::rem#5 = 0 [phi:modr16u->modr16u::@1#3] -- vwuz1=vbuc1 
    sta.z rem
    sta.z rem+1
    // [261] phi from modr16u::@3 to modr16u::@1 [phi:modr16u::@3->modr16u::@1]
    // [261] phi modr16u::i#2 = modr16u::i#1 [phi:modr16u::@3->modr16u::@1#0] -- register_copy 
    // [261] phi modr16u::quotient#3 = modr16u::quotient#7 [phi:modr16u::@3->modr16u::@1#1] -- register_copy 
    // [261] phi modr16u::dividend#3 = modr16u::dividend#0 [phi:modr16u::@3->modr16u::@1#2] -- register_copy 
    // [261] phi modr16u::rem#5 = modr16u::return#0 [phi:modr16u::@3->modr16u::@1#3] -- register_copy 
    // modr16u::@1
  __b1:
    // rem = rem << 1
    // [262] modr16u::rem#0 = modr16u::rem#5 << 1 -- vwuz1=vwuz1_rol_1 
    asl.z rem
    rol.z rem+1
    // >dividend
    // [263] modr16u::$1 = > modr16u::dividend#3 -- vbuaa=_hi_vwuz1 
    lda.z dividend+1
    // >dividend & $80
    // [264] modr16u::$2 = modr16u::$1 & $80 -- vbuaa=vbuaa_band_vbuc1 
    and #$80
    // if( (>dividend & $80) != 0 )
    // [265] if(modr16u::$2==0) goto modr16u::@2 -- vbuaa_eq_0_then_la1 
    cmp #0
    beq __b2
    // modr16u::@4
    // rem = rem | 1
    // [266] modr16u::rem#1 = modr16u::rem#0 | 1 -- vwuz1=vwuz1_bor_vbuc1 
    lda #1
    ora.z rem
    sta.z rem
    // [267] phi from modr16u::@1 modr16u::@4 to modr16u::@2 [phi:modr16u::@1/modr16u::@4->modr16u::@2]
    // [267] phi modr16u::rem#6 = modr16u::rem#0 [phi:modr16u::@1/modr16u::@4->modr16u::@2#0] -- register_copy 
    // modr16u::@2
  __b2:
    // dividend = dividend << 1
    // [268] modr16u::dividend#0 = modr16u::dividend#3 << 1 -- vwuz1=vwuz1_rol_1 
    asl.z dividend
    rol.z dividend+1
    // quotient = quotient << 1
    // [269] modr16u::quotient#1 = modr16u::quotient#3 << 1 -- vwuz1=vwuz1_rol_1 
    asl.z quotient
    rol.z quotient+1
    // if(rem>=divisor)
    // [270] if(modr16u::rem#6<3) goto modr16u::@3 -- vwuz1_lt_vbuc1_then_la1 
    lda.z rem+1
    bne !+
    lda.z rem
    cmp #3
    bcc __b3
  !:
    // modr16u::@5
    // quotient++;
    // [271] modr16u::quotient#2 = ++ modr16u::quotient#1 -- vwuz1=_inc_vwuz1 
    inc.z quotient
    bne !+
    inc.z quotient+1
  !:
    // rem = rem - divisor
    // [272] modr16u::rem#2 = modr16u::rem#6 - 3 -- vwuz1=vwuz1_minus_vbuc1 
    sec
    lda.z rem
    sbc #3
    sta.z rem
    lda.z rem+1
    sbc #0
    sta.z rem+1
    // [273] phi from modr16u::@2 modr16u::@5 to modr16u::@3 [phi:modr16u::@2/modr16u::@5->modr16u::@3]
    // [273] phi modr16u::quotient#7 = modr16u::quotient#1 [phi:modr16u::@2/modr16u::@5->modr16u::@3#0] -- register_copy 
    // [273] phi modr16u::return#0 = modr16u::rem#6 [phi:modr16u::@2/modr16u::@5->modr16u::@3#1] -- register_copy 
    // modr16u::@3
  __b3:
    // for( char i : 0..15)
    // [274] modr16u::i#1 = ++ modr16u::i#2 -- vbuxx=_inc_vbuxx 
    inx
    // [275] if(modr16u::i#1!=$10) goto modr16u::@1 -- vbuxx_neq_vbuc1_then_la1 
    cpx #$10
    bne __b1
    // modr16u::@return
    // }
    // [276] return 
    rts
}
  // vera_tile_element
// vera_tile_element(byte register(X) x, byte zp($f) y, byte* zp($c) Tile)
vera_tile_element: {
    .label __3 = $c
    .label __18 = $c
    .label vera_vram_address01___0 = $c
    .label vera_vram_address01___2 = $c
    .label vera_vram_address01___4 = $4c
    .label TileOffset = $45
    .label TileTotal = $46
    .label TileCount = $47
    .label TileColumns = $48
    .label PaletteOffset = $49
    .label y = $f
    .label mapbase = $10
    .label shift = $e
    .label rowskip = $4a
    .label j = $e
    .label i = $f
    .label r = $14
    .label x = $e
    .label Tile = $c
    // TileOffset = Tile[0]
    // [278] vera_tile_element::TileOffset#0 = *vera_tile_element::Tile#2 -- vbuz1=_deref_pbuz2 
    ldy #0
    lda (Tile),y
    sta.z TileOffset
    // TileTotal = Tile[1]
    // [279] vera_tile_element::TileTotal#0 = vera_tile_element::Tile#2[1] -- vbuz1=pbuz2_derefidx_vbuc1 
    ldy #1
    lda (Tile),y
    sta.z TileTotal
    // TileCount = Tile[2]
    // [280] vera_tile_element::TileCount#0 = vera_tile_element::Tile#2[2] -- vbuz1=pbuz2_derefidx_vbuc1 
    ldy #2
    lda (Tile),y
    sta.z TileCount
    // TileColumns = Tile[4]
    // [281] vera_tile_element::TileColumns#0 = vera_tile_element::Tile#2[4] -- vbuz1=pbuz2_derefidx_vbuc1 
    ldy #4
    lda (Tile),y
    sta.z TileColumns
    // PaletteOffset = Tile[5]
    // [282] vera_tile_element::PaletteOffset#0 = vera_tile_element::Tile#2[5] -- vbuz1=pbuz2_derefidx_vbuc1 
    ldy #5
    lda (Tile),y
    sta.z PaletteOffset
    // x = x << resolution
    // [283] vera_tile_element::x#0 = vera_tile_element::x#3 << 3 -- vbuxx=vbuz1_rol_3 
    lda.z x
    asl
    asl
    asl
    tax
    // y = y << resolution
    // [284] vera_tile_element::y#0 = vera_tile_element::y#3 << 3 -- vbuz1=vbuz1_rol_3 
    lda.z y
    asl
    asl
    asl
    sta.z y
    // mapbase = vera_mapbase_address[layer]
    // [285] vera_tile_element::mapbase#0 = *vera_mapbase_address -- vduz1=_deref_pduc1 
    lda vera_mapbase_address
    sta.z mapbase
    lda vera_mapbase_address+1
    sta.z mapbase+1
    lda vera_mapbase_address+2
    sta.z mapbase+2
    lda vera_mapbase_address+3
    sta.z mapbase+3
    // shift = vera_layer_rowshift[layer]
    // [286] vera_tile_element::shift#0 = *vera_layer_rowshift -- vbuz1=_deref_pbuc1 
    lda vera_layer_rowshift
    sta.z shift
    // rowskip = (word)1 << shift
    // [287] vera_tile_element::rowskip#0 = 1 << vera_tile_element::shift#0 -- vwuz1=vwuc1_rol_vbuz2 
    tay
    lda #<1
    sta.z rowskip
    lda #>1+1
    sta.z rowskip+1
    cpy #0
    beq !e+
  !:
    asl.z rowskip
    rol.z rowskip+1
    dey
    bne !-
  !e:
    // (word)y << shift
    // [288] vera_tile_element::$18 = (word)vera_tile_element::y#0 -- vwuz1=_word_vbuz2 
    lda.z y
    sta.z __18
    lda #0
    sta.z __18+1
    // [289] vera_tile_element::$3 = vera_tile_element::$18 << vera_tile_element::shift#0 -- vwuz1=vwuz1_rol_vbuz2 
    ldy.z shift
    beq !e+
  !:
    asl.z __3
    rol.z __3+1
    dey
    bne !-
  !e:
    // mapbase += ((word)y << shift)
    // [290] vera_tile_element::mapbase#1 = vera_tile_element::mapbase#0 + vera_tile_element::$3 -- vduz1=vduz1_plus_vwuz2 
    lda.z mapbase
    clc
    adc.z __3
    sta.z mapbase
    lda.z mapbase+1
    adc.z __3+1
    sta.z mapbase+1
    lda.z mapbase+2
    adc #0
    sta.z mapbase+2
    lda.z mapbase+3
    adc #0
    sta.z mapbase+3
    // x << 1
    // [291] vera_tile_element::$4 = vera_tile_element::x#0 << 1 -- vbuaa=vbuxx_rol_1 
    txa
    asl
    // mapbase += (x << 1)
    // [292] vera_tile_element::mapbase#2 = vera_tile_element::mapbase#1 + vera_tile_element::$4 -- vduz1=vduz1_plus_vbuaa 
    clc
    adc.z mapbase
    sta.z mapbase
    lda.z mapbase+1
    adc #0
    sta.z mapbase+1
    lda.z mapbase+2
    adc #0
    sta.z mapbase+2
    lda.z mapbase+3
    adc #0
    sta.z mapbase+3
    // [293] phi from vera_tile_element to vera_tile_element::@1 [phi:vera_tile_element->vera_tile_element::@1]
    // [293] phi vera_tile_element::mapbase#11 = vera_tile_element::mapbase#2 [phi:vera_tile_element->vera_tile_element::@1#0] -- register_copy 
    // [293] phi vera_tile_element::j#2 = 0 [phi:vera_tile_element->vera_tile_element::@1#1] -- vbuz1=vbuc1 
    lda #0
    sta.z j
    // vera_tile_element::@1
  __b1:
    // for(byte j=0;j<TileTotal;j+=(TileTotal>>1))
    // [294] if(vera_tile_element::j#2<vera_tile_element::TileTotal#0) goto vera_tile_element::@2 -- vbuz1_lt_vbuz2_then_la1 
    lda.z j
    cmp.z TileTotal
    bcc __b3
    // vera_tile_element::@return
    // }
    // [295] return 
    rts
    // [296] phi from vera_tile_element::@1 to vera_tile_element::@2 [phi:vera_tile_element::@1->vera_tile_element::@2]
  __b3:
    // [296] phi vera_tile_element::mapbase#10 = vera_tile_element::mapbase#11 [phi:vera_tile_element::@1->vera_tile_element::@2#0] -- register_copy 
    // [296] phi vera_tile_element::i#10 = 0 [phi:vera_tile_element::@1->vera_tile_element::@2#1] -- vbuz1=vbuc1 
    lda #0
    sta.z i
    // vera_tile_element::@2
  __b2:
    // for(byte i=0;i<TileCount;i+=(TileColumns))
    // [297] if(vera_tile_element::i#10<vera_tile_element::TileCount#0) goto vera_tile_element::vera_vram_address01 -- vbuz1_lt_vbuz2_then_la1 
    lda.z i
    cmp.z TileCount
    bcc vera_vram_address01
    // vera_tile_element::@3
    // TileTotal>>1
    // [298] vera_tile_element::$16 = vera_tile_element::TileTotal#0 >> 1 -- vbuaa=vbuz1_ror_1 
    lda.z TileTotal
    lsr
    // j+=(TileTotal>>1)
    // [299] vera_tile_element::j#1 = vera_tile_element::j#2 + vera_tile_element::$16 -- vbuz1=vbuz1_plus_vbuaa 
    clc
    adc.z j
    sta.z j
    // [293] phi from vera_tile_element::@3 to vera_tile_element::@1 [phi:vera_tile_element::@3->vera_tile_element::@1]
    // [293] phi vera_tile_element::mapbase#11 = vera_tile_element::mapbase#10 [phi:vera_tile_element::@3->vera_tile_element::@1#0] -- register_copy 
    // [293] phi vera_tile_element::j#2 = vera_tile_element::j#1 [phi:vera_tile_element::@3->vera_tile_element::@1#1] -- register_copy 
    jmp __b1
    // vera_tile_element::vera_vram_address01
  vera_vram_address01:
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [300] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <bankaddr
    // [301] vera_tile_element::vera_vram_address01_$0 = < vera_tile_element::mapbase#10 -- vwuz1=_lo_vduz2 
    lda.z mapbase
    sta.z vera_vram_address01___0
    lda.z mapbase+1
    sta.z vera_vram_address01___0+1
    // <(<bankaddr)
    // [302] vera_tile_element::vera_vram_address01_$1 = < vera_tile_element::vera_vram_address01_$0 -- vbuaa=_lo_vwuz1 
    lda.z vera_vram_address01___0
    // *VERA_ADDRX_L = <(<bankaddr)
    // [303] *VERA_ADDRX_L = vera_tile_element::vera_vram_address01_$1 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // <bankaddr
    // [304] vera_tile_element::vera_vram_address01_$2 = < vera_tile_element::mapbase#10 -- vwuz1=_lo_vduz2 
    lda.z mapbase
    sta.z vera_vram_address01___2
    lda.z mapbase+1
    sta.z vera_vram_address01___2+1
    // >(<bankaddr)
    // [305] vera_tile_element::vera_vram_address01_$3 = > vera_tile_element::vera_vram_address01_$2 -- vbuaa=_hi_vwuz1 
    // *VERA_ADDRX_M = >(<bankaddr)
    // [306] *VERA_ADDRX_M = vera_tile_element::vera_vram_address01_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // >bankaddr
    // [307] vera_tile_element::vera_vram_address01_$4 = > vera_tile_element::mapbase#10 -- vwuz1=_hi_vduz2 
    lda.z mapbase+2
    sta.z vera_vram_address01___4
    lda.z mapbase+3
    sta.z vera_vram_address01___4+1
    // <(>bankaddr)
    // [308] vera_tile_element::vera_vram_address01_$5 = < vera_tile_element::vera_vram_address01_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_vram_address01___4
    // <(>bankaddr) | incr
    // [309] vera_tile_element::vera_vram_address01_$6 = vera_tile_element::vera_vram_address01_$5 | VERA_INC_1 -- vbuaa=vbuaa_bor_vbuc1 
    ora #VERA_INC_1
    // *VERA_ADDRX_H = <(>bankaddr) | incr
    // [310] *VERA_ADDRX_H = vera_tile_element::vera_vram_address01_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_H
    // [311] phi from vera_tile_element::vera_vram_address01 to vera_tile_element::@4 [phi:vera_tile_element::vera_vram_address01->vera_tile_element::@4]
    // [311] phi vera_tile_element::r#2 = 0 [phi:vera_tile_element::vera_vram_address01->vera_tile_element::@4#0] -- vbuz1=vbuc1 
    lda #0
    sta.z r
    // vera_tile_element::@4
  __b4:
    // TileTotal>>1
    // [312] vera_tile_element::$8 = vera_tile_element::TileTotal#0 >> 1 -- vbuaa=vbuz1_ror_1 
    lda.z TileTotal
    lsr
    // for(byte r=0;r<(TileTotal>>1);r+=TileCount)
    // [313] if(vera_tile_element::r#2<vera_tile_element::$8) goto vera_tile_element::@6 -- vbuz1_lt_vbuaa_then_la1 
    cmp.z r
    beq !+
    bcs __b5
  !:
    // vera_tile_element::@5
    // mapbase += rowskip
    // [314] vera_tile_element::mapbase#3 = vera_tile_element::mapbase#10 + vera_tile_element::rowskip#0 -- vduz1=vduz1_plus_vwuz2 
    lda.z mapbase
    clc
    adc.z rowskip
    sta.z mapbase
    lda.z mapbase+1
    adc.z rowskip+1
    sta.z mapbase+1
    lda.z mapbase+2
    adc #0
    sta.z mapbase+2
    lda.z mapbase+3
    adc #0
    sta.z mapbase+3
    // i+=(TileColumns)
    // [315] vera_tile_element::i#1 = vera_tile_element::i#10 + vera_tile_element::TileColumns#0 -- vbuz1=vbuz1_plus_vbuz2 
    lda.z i
    clc
    adc.z TileColumns
    sta.z i
    // [296] phi from vera_tile_element::@5 to vera_tile_element::@2 [phi:vera_tile_element::@5->vera_tile_element::@2]
    // [296] phi vera_tile_element::mapbase#10 = vera_tile_element::mapbase#3 [phi:vera_tile_element::@5->vera_tile_element::@2#0] -- register_copy 
    // [296] phi vera_tile_element::i#10 = vera_tile_element::i#1 [phi:vera_tile_element::@5->vera_tile_element::@2#1] -- register_copy 
    jmp __b2
    // [316] phi from vera_tile_element::@4 to vera_tile_element::@6 [phi:vera_tile_element::@4->vera_tile_element::@6]
  __b5:
    // [316] phi vera_tile_element::c#2 = 0 [phi:vera_tile_element::@4->vera_tile_element::@6#0] -- vbuxx=vbuc1 
    ldx #0
    // vera_tile_element::@6
  __b6:
    // for(byte c=0;c<TileColumns;c+=1)
    // [317] if(vera_tile_element::c#2<vera_tile_element::TileColumns#0) goto vera_tile_element::@7 -- vbuxx_lt_vbuz1_then_la1 
    cpx.z TileColumns
    bcc __b7
    // vera_tile_element::@8
    // r+=TileCount
    // [318] vera_tile_element::r#1 = vera_tile_element::r#2 + vera_tile_element::TileCount#0 -- vbuz1=vbuz1_plus_vbuz2 
    lda.z r
    clc
    adc.z TileCount
    sta.z r
    // [311] phi from vera_tile_element::@8 to vera_tile_element::@4 [phi:vera_tile_element::@8->vera_tile_element::@4]
    // [311] phi vera_tile_element::r#2 = vera_tile_element::r#1 [phi:vera_tile_element::@8->vera_tile_element::@4#0] -- register_copy 
    jmp __b4
    // vera_tile_element::@7
  __b7:
    // TileOffset+c
    // [319] vera_tile_element::$11 = vera_tile_element::TileOffset#0 + vera_tile_element::c#2 -- vbuaa=vbuz1_plus_vbuxx 
    txa
    clc
    adc.z TileOffset
    // TileOffset+c+r
    // [320] vera_tile_element::$12 = vera_tile_element::$11 + vera_tile_element::r#2 -- vbuaa=vbuaa_plus_vbuz1 
    clc
    adc.z r
    // TileOffset+c+r+i
    // [321] vera_tile_element::$13 = vera_tile_element::$12 + vera_tile_element::i#10 -- vbuaa=vbuaa_plus_vbuz1 
    clc
    adc.z i
    // TileOffset+c+r+i+j
    // [322] vera_tile_element::$14 = vera_tile_element::$13 + vera_tile_element::j#2 -- vbuaa=vbuaa_plus_vbuz1 
    clc
    adc.z j
    // *VERA_DATA0 = TileOffset+c+r+i+j
    // [323] *VERA_DATA0 = vera_tile_element::$14 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // PaletteOffset << 4
    // [324] vera_tile_element::$15 = vera_tile_element::PaletteOffset#0 << 4 -- vbuaa=vbuz1_rol_4 
    lda.z PaletteOffset
    asl
    asl
    asl
    asl
    // *VERA_DATA0 = PaletteOffset << 4
    // [325] *VERA_DATA0 = vera_tile_element::$15 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // c+=1
    // [326] vera_tile_element::c#1 = vera_tile_element::c#2 + 1 -- vbuxx=vbuxx_plus_1 
    inx
    // [316] phi from vera_tile_element::@7 to vera_tile_element::@6 [phi:vera_tile_element::@7->vera_tile_element::@6]
    // [316] phi vera_tile_element::c#2 = vera_tile_element::c#1 [phi:vera_tile_element::@7->vera_tile_element::@6#0] -- register_copy 
    jmp __b6
}
  // vera_layer_mode_text
// Set a vera layer in text mode and configure the:
// - layer: Value of 0 or 1.
// - mapbase_address: A dword typed address (4 bytes), that specifies the full address of the map base.
//   The function does the translation from the dword that contains the 17 bit address,
//   to the respective mapbase vera register.
//   Note that the register only specifies bits 16:9 of the address,
//   so the resulting address in the VERA VRAM is always aligned to a multiple of 512 bytes.
// - tilebase_address: A dword typed address (4 bytes), that specifies the base address of the tile map.
//   The function does the translation from the dword that contains the 17 bit address,
//   to the respective tilebase vera register.
//   Note that the resulting vera register holds only specifies bits 16:11 of the address,
//   so the resulting address in the VERA VRAM is always aligned to a multiple of 2048 bytes!
// - mapwidth: The width of the map in number of tiles.
// - mapheight: The height of the map in number of tiles.
// - tilewidth: The width of a tile, which can be 8 or 16 pixels.
// - tileheight: The height of a tile, which can be 8 or 16 pixels.
// - color_mode: The color mode, which can be 16 or 256.
vera_layer_mode_text: {
    .const mapbase_address = 0
    .const tilebase_address = $f800
    .const mapwidth = $80
    .const mapheight = $40
    .const tilewidth = 8
    .const tileheight = 8
    .label layer = 1
    // vera_layer_mode_tile( layer, mapbase_address, tilebase_address, mapwidth, mapheight, tilewidth, tileheight, 1 )
    // [328] call vera_layer_mode_tile 
    // [395] phi from vera_layer_mode_text to vera_layer_mode_tile [phi:vera_layer_mode_text->vera_layer_mode_tile]
    // [395] phi vera_layer_mode_tile::tileheight#10 = vera_layer_mode_text::tileheight#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#0] -- vbuz1=vbuc1 
    lda #tileheight
    sta.z vera_layer_mode_tile.tileheight
    // [395] phi vera_layer_mode_tile::tilewidth#10 = vera_layer_mode_text::tilewidth#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#1] -- vbuz1=vbuc1 
    lda #tilewidth
    sta.z vera_layer_mode_tile.tilewidth
    // [395] phi vera_layer_mode_tile::tilebase_address#10 = vera_layer_mode_text::tilebase_address#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#2] -- vduz1=vduc1 
    lda #<tilebase_address
    sta.z vera_layer_mode_tile.tilebase_address
    lda #>tilebase_address
    sta.z vera_layer_mode_tile.tilebase_address+1
    lda #<tilebase_address>>$10
    sta.z vera_layer_mode_tile.tilebase_address+2
    lda #>tilebase_address>>$10
    sta.z vera_layer_mode_tile.tilebase_address+3
    // [395] phi vera_layer_mode_tile::mapbase_address#10 = vera_layer_mode_text::mapbase_address#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#3] -- vduz1=vduc1 
    lda #<mapbase_address
    sta.z vera_layer_mode_tile.mapbase_address
    lda #>mapbase_address
    sta.z vera_layer_mode_tile.mapbase_address+1
    lda #<mapbase_address>>$10
    sta.z vera_layer_mode_tile.mapbase_address+2
    lda #>mapbase_address>>$10
    sta.z vera_layer_mode_tile.mapbase_address+3
    // [395] phi vera_layer_mode_tile::mapheight#10 = vera_layer_mode_text::mapheight#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#4] -- vwuz1=vwuc1 
    lda #<mapheight
    sta.z vera_layer_mode_tile.mapheight
    lda #>mapheight
    sta.z vera_layer_mode_tile.mapheight+1
    // [395] phi vera_layer_mode_tile::layer#10 = vera_layer_mode_text::layer#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#5] -- vbuz1=vbuc1 
    lda #layer
    sta.z vera_layer_mode_tile.layer
    // [395] phi vera_layer_mode_tile::mapwidth#10 = vera_layer_mode_text::mapwidth#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#6] -- vwuz1=vwuc1 
    lda #<mapwidth
    sta.z vera_layer_mode_tile.mapwidth
    lda #>mapwidth
    sta.z vera_layer_mode_tile.mapwidth+1
    // [395] phi vera_layer_mode_tile::color_depth#3 = 1 [phi:vera_layer_mode_text->vera_layer_mode_tile#7] -- vbuxx=vbuc1 
    ldx #1
    jsr vera_layer_mode_tile
    // [329] phi from vera_layer_mode_text to vera_layer_mode_text::@1 [phi:vera_layer_mode_text->vera_layer_mode_text::@1]
    // vera_layer_mode_text::@1
    // vera_layer_set_text_color_mode( layer, VERA_LAYER_CONFIG_16C )
    // [330] call vera_layer_set_text_color_mode 
    jsr vera_layer_set_text_color_mode
    // vera_layer_mode_text::@return
    // }
    // [331] return 
    rts
}
  // screensize
// Return the current screen size.
screensize: {
    .label x = cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH
    .label y = cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT
    // hscale = (*VERA_DC_HSCALE) >> 7
    // [332] screensize::hscale#0 = *VERA_DC_HSCALE >> 7 -- vbuaa=_deref_pbuc1_ror_7 
    lda VERA_DC_HSCALE
    rol
    rol
    and #1
    // 40 << hscale
    // [333] screensize::$1 = $28 << screensize::hscale#0 -- vbuaa=vbuc1_rol_vbuaa 
    tay
    lda #$28
    cpy #0
    beq !e+
  !:
    asl
    dey
    bne !-
  !e:
    // *x = 40 << hscale
    // [334] *screensize::x#0 = screensize::$1 -- _deref_pbuc1=vbuaa 
    sta x
    // vscale = (*VERA_DC_VSCALE) >> 7
    // [335] screensize::vscale#0 = *VERA_DC_VSCALE >> 7 -- vbuaa=_deref_pbuc1_ror_7 
    lda VERA_DC_VSCALE
    rol
    rol
    and #1
    // 30 << vscale
    // [336] screensize::$3 = $1e << screensize::vscale#0 -- vbuaa=vbuc1_rol_vbuaa 
    tay
    lda #$1e
    cpy #0
    beq !e+
  !:
    asl
    dey
    bne !-
  !e:
    // *y = 30 << vscale
    // [337] *screensize::y#0 = screensize::$3 -- _deref_pbuc1=vbuaa 
    sta y
    // screensize::@return
    // }
    // [338] return 
    rts
}
  // screenlayer
// Set the layer with which the conio will interact.
// - layer: value of 0 or 1.
screenlayer: {
    .label __1 = $4e
    .label __5 = $4e
    .label vera_layer_get_width1_config = $50
    .label vera_layer_get_width1_return = $4e
    .label vera_layer_get_height1_config = $4e
    .label vera_layer_get_height1_return = $4e
    // cx16_conio.conio_screen_layer = layer
    // [339] *((byte*)&cx16_conio) = 1 -- _deref_pbuc1=vbuc2 
    lda #1
    sta cx16_conio
    // vera_layer_get_mapbase_bank(layer)
    // [340] call vera_layer_get_mapbase_bank 
    jsr vera_layer_get_mapbase_bank
    // [341] vera_layer_get_mapbase_bank::return#2 = vera_layer_get_mapbase_bank::return#0
    // screenlayer::@3
    // [342] screenlayer::$0 = vera_layer_get_mapbase_bank::return#2
    // cx16_conio.conio_screen_bank = vera_layer_get_mapbase_bank(layer)
    // [343] *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK) = screenlayer::$0 -- _deref_pbuc1=vbuaa 
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK
    // vera_layer_get_mapbase_offset(layer)
    // [344] call vera_layer_get_mapbase_offset 
    jsr vera_layer_get_mapbase_offset
    // [345] vera_layer_get_mapbase_offset::return#2 = vera_layer_get_mapbase_offset::return#0
    // screenlayer::@4
    // [346] screenlayer::$1 = vera_layer_get_mapbase_offset::return#2
    // cx16_conio.conio_screen_text = vera_layer_get_mapbase_offset(layer)
    // [347] *((byte**)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT) = (byte*)screenlayer::$1 -- _deref_qbuc1=pbuz1 
    lda.z __1
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT
    lda.z __1+1
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT+1
    // screenlayer::vera_layer_get_width1
    // config = vera_layer_config[layer]
    // [348] screenlayer::vera_layer_get_width1_config#0 = *(vera_layer_config+1<<1) -- pbuz1=_deref_qbuc1 
    lda vera_layer_config+(1<<1)
    sta.z vera_layer_get_width1_config
    lda vera_layer_config+(1<<1)+1
    sta.z vera_layer_get_width1_config+1
    // *config & VERA_LAYER_WIDTH_MASK
    // [349] screenlayer::vera_layer_get_width1_$0 = *screenlayer::vera_layer_get_width1_config#0 & VERA_LAYER_WIDTH_MASK -- vbuaa=_deref_pbuz1_band_vbuc1 
    lda #VERA_LAYER_WIDTH_MASK
    ldy #0
    and (vera_layer_get_width1_config),y
    // (*config & VERA_LAYER_WIDTH_MASK) >> 4
    // [350] screenlayer::vera_layer_get_width1_$1 = screenlayer::vera_layer_get_width1_$0 >> 4 -- vbuaa=vbuaa_ror_4 
    lsr
    lsr
    lsr
    lsr
    // return VERA_LAYER_WIDTH[ (*config & VERA_LAYER_WIDTH_MASK) >> 4];
    // [351] screenlayer::vera_layer_get_width1_$3 = screenlayer::vera_layer_get_width1_$1 << 1 -- vbuaa=vbuaa_rol_1 
    asl
    // [352] screenlayer::vera_layer_get_width1_return#0 = VERA_LAYER_WIDTH[screenlayer::vera_layer_get_width1_$3] -- vwuz1=pwuc1_derefidx_vbuaa 
    tay
    lda VERA_LAYER_WIDTH,y
    sta.z vera_layer_get_width1_return
    lda VERA_LAYER_WIDTH+1,y
    sta.z vera_layer_get_width1_return+1
    // screenlayer::@1
    // cx16_conio.conio_map_width = vera_layer_get_width(layer)
    // [353] *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH) = screenlayer::vera_layer_get_width1_return#0 -- _deref_pwuc1=vwuz1 
    lda.z vera_layer_get_width1_return
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH
    lda.z vera_layer_get_width1_return+1
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH+1
    // screenlayer::vera_layer_get_height1
    // config = vera_layer_config[layer]
    // [354] screenlayer::vera_layer_get_height1_config#0 = *(vera_layer_config+1<<1) -- pbuz1=_deref_qbuc1 
    lda vera_layer_config+(1<<1)
    sta.z vera_layer_get_height1_config
    lda vera_layer_config+(1<<1)+1
    sta.z vera_layer_get_height1_config+1
    // *config & VERA_LAYER_HEIGHT_MASK
    // [355] screenlayer::vera_layer_get_height1_$0 = *screenlayer::vera_layer_get_height1_config#0 & VERA_LAYER_HEIGHT_MASK -- vbuaa=_deref_pbuz1_band_vbuc1 
    lda #VERA_LAYER_HEIGHT_MASK
    ldy #0
    and (vera_layer_get_height1_config),y
    // (*config & VERA_LAYER_HEIGHT_MASK) >> 6
    // [356] screenlayer::vera_layer_get_height1_$1 = screenlayer::vera_layer_get_height1_$0 >> 6 -- vbuaa=vbuaa_ror_6 
    rol
    rol
    rol
    and #3
    // return VERA_LAYER_HEIGHT[ (*config & VERA_LAYER_HEIGHT_MASK) >> 6];
    // [357] screenlayer::vera_layer_get_height1_$3 = screenlayer::vera_layer_get_height1_$1 << 1 -- vbuaa=vbuaa_rol_1 
    asl
    // [358] screenlayer::vera_layer_get_height1_return#0 = VERA_LAYER_HEIGHT[screenlayer::vera_layer_get_height1_$3] -- vwuz1=pwuc1_derefidx_vbuaa 
    tay
    lda VERA_LAYER_HEIGHT,y
    sta.z vera_layer_get_height1_return
    lda VERA_LAYER_HEIGHT+1,y
    sta.z vera_layer_get_height1_return+1
    // screenlayer::@2
    // cx16_conio.conio_map_height = vera_layer_get_height(layer)
    // [359] *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT) = screenlayer::vera_layer_get_height1_return#0 -- _deref_pwuc1=vwuz1 
    lda.z vera_layer_get_height1_return
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT
    lda.z vera_layer_get_height1_return+1
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT+1
    // vera_layer_get_rowshift(layer)
    // [360] call vera_layer_get_rowshift 
    jsr vera_layer_get_rowshift
    // [361] vera_layer_get_rowshift::return#2 = vera_layer_get_rowshift::return#0
    // screenlayer::@5
    // [362] screenlayer::$4 = vera_layer_get_rowshift::return#2
    // cx16_conio.conio_rowshift = vera_layer_get_rowshift(layer)
    // [363] *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSHIFT) = screenlayer::$4 -- _deref_pbuc1=vbuaa 
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSHIFT
    // vera_layer_get_rowskip(layer)
    // [364] call vera_layer_get_rowskip 
    jsr vera_layer_get_rowskip
    // [365] vera_layer_get_rowskip::return#2 = vera_layer_get_rowskip::return#0
    // screenlayer::@6
    // [366] screenlayer::$5 = vera_layer_get_rowskip::return#2
    // cx16_conio.conio_rowskip = vera_layer_get_rowskip(layer)
    // [367] *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP) = screenlayer::$5 -- _deref_pwuc1=vwuz1 
    lda.z __5
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP
    lda.z __5+1
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP+1
    // screenlayer::@return
    // }
    // [368] return 
    rts
}
  // vera_layer_set_textcolor
// Set the front color for text output. The old front text color setting is returned.
// - layer: Value of 0 or 1.
// - color: a 4 bit value ( decimal between 0 and 15) when the VERA works in 16x16 color text mode.
//   An 8 bit value (decimal between 0 and 255) when the VERA works in 256 text mode.
//   Note that on the VERA, the transparent color has value 0.
// vera_layer_set_textcolor(byte register(X) layer)
vera_layer_set_textcolor: {
    // vera_layer_textcolor[layer] = color
    // [370] vera_layer_textcolor[vera_layer_set_textcolor::layer#2] = WHITE -- pbuc1_derefidx_vbuxx=vbuc2 
    lda #WHITE
    sta vera_layer_textcolor,x
    // vera_layer_set_textcolor::@return
    // }
    // [371] return 
    rts
}
  // vera_layer_set_backcolor
// Set the back color for text output. The old back text color setting is returned.
// - layer: Value of 0 or 1.
// - color: a 4 bit value ( decimal between 0 and 15).
//   This will only work when the VERA is in 16 color mode!
//   Note that on the VERA, the transparent color has value 0.
// vera_layer_set_backcolor(byte register(X) layer, byte register(A) color)
vera_layer_set_backcolor: {
    // vera_layer_backcolor[layer] = color
    // [373] vera_layer_backcolor[vera_layer_set_backcolor::layer#2] = vera_layer_set_backcolor::color#2 -- pbuc1_derefidx_vbuxx=vbuaa 
    sta vera_layer_backcolor,x
    // vera_layer_set_backcolor::@return
    // }
    // [374] return 
    rts
}
  // vera_layer_set_mapbase
// Set the base of the map layer with which the conio will interact.
// - layer: Value of 0 or 1.
// - mapbase: Specifies the base address of the tile map.
//   Note that the register only specifies bits 16:9 of the address,
//   so the resulting address in the VERA VRAM is always aligned to a multiple of 512 bytes.
// vera_layer_set_mapbase(byte register(A) layer, byte register(X) mapbase)
vera_layer_set_mapbase: {
    .label addr = $4e
    // addr = vera_layer_mapbase[layer]
    // [376] vera_layer_set_mapbase::$0 = vera_layer_set_mapbase::layer#3 << 1 -- vbuaa=vbuaa_rol_1 
    asl
    // [377] vera_layer_set_mapbase::addr#0 = vera_layer_mapbase[vera_layer_set_mapbase::$0] -- pbuz1=qbuc1_derefidx_vbuaa 
    tay
    lda vera_layer_mapbase,y
    sta.z addr
    lda vera_layer_mapbase+1,y
    sta.z addr+1
    // *addr = mapbase
    // [378] *vera_layer_set_mapbase::addr#0 = vera_layer_set_mapbase::mapbase#3 -- _deref_pbuz1=vbuxx 
    txa
    ldy #0
    sta (addr),y
    // vera_layer_set_mapbase::@return
    // }
    // [379] return 
    rts
}
  // cursor
// If onoff is 1, a cursor is displayed when waiting for keyboard input.
// If onoff is 0, the cursor is hidden when waiting for keyboard input.
// The function returns the old cursor setting.
cursor: {
    .const onoff = 0
    // cx16_conio.conio_display_cursor = onoff
    // [380] *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_DISPLAY_CURSOR) = cursor::onoff#0 -- _deref_pbuc1=vbuc2 
    lda #onoff
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_DISPLAY_CURSOR
    // cursor::@return
    // }
    // [381] return 
    rts
}
  // gotoxy
// Set the cursor to the specified position
// gotoxy(byte register(X) y)
gotoxy: {
    .label __6 = $4e
    .label line_offset = $4e
    // if(y>cx16_conio.conio_screen_height)
    // [383] if(gotoxy::y#3<=*((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT)) goto gotoxy::@4 -- vbuxx_le__deref_pbuc1_then_la1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT
    stx.z $ff
    cmp.z $ff
    bcs __b1
    // [385] phi from gotoxy to gotoxy::@1 [phi:gotoxy->gotoxy::@1]
    // [385] phi gotoxy::y#4 = 0 [phi:gotoxy->gotoxy::@1#0] -- vbuxx=vbuc1 
    ldx #0
    // [384] phi from gotoxy to gotoxy::@4 [phi:gotoxy->gotoxy::@4]
    // gotoxy::@4
    // [385] phi from gotoxy::@4 to gotoxy::@1 [phi:gotoxy::@4->gotoxy::@1]
    // [385] phi gotoxy::y#4 = gotoxy::y#3 [phi:gotoxy::@4->gotoxy::@1#0] -- register_copy 
    // gotoxy::@1
  __b1:
    // if(x>=cx16_conio.conio_screen_width)
    // [386] if(0<*((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH)) goto gotoxy::@2 -- 0_lt__deref_pbuc1_then_la1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH
    cmp #0
    // [387] phi from gotoxy::@1 to gotoxy::@3 [phi:gotoxy::@1->gotoxy::@3]
    // gotoxy::@3
    // gotoxy::@2
    // conio_cursor_x[cx16_conio.conio_screen_layer] = x
    // [388] conio_cursor_x[*((byte*)&cx16_conio)] = 0 -- pbuc1_derefidx_(_deref_pbuc2)=vbuc3 
    lda #0
    ldy cx16_conio
    sta conio_cursor_x,y
    // conio_cursor_y[cx16_conio.conio_screen_layer] = y
    // [389] conio_cursor_y[*((byte*)&cx16_conio)] = gotoxy::y#4 -- pbuc1_derefidx_(_deref_pbuc2)=vbuxx 
    txa
    sta conio_cursor_y,y
    // (unsigned int)y << cx16_conio.conio_rowshift
    // [390] gotoxy::$6 = (word)gotoxy::y#4 -- vwuz1=_word_vbuxx 
    txa
    sta.z __6
    lda #0
    sta.z __6+1
    // line_offset = (unsigned int)y << cx16_conio.conio_rowshift
    // [391] gotoxy::line_offset#0 = gotoxy::$6 << *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSHIFT) -- vwuz1=vwuz1_rol__deref_pbuc1 
    ldy cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSHIFT
    cpy #0
    beq !e+
  !:
    asl.z line_offset
    rol.z line_offset+1
    dey
    bne !-
  !e:
    // conio_line_text[cx16_conio.conio_screen_layer] = line_offset
    // [392] gotoxy::$5 = *((byte*)&cx16_conio) << 1 -- vbuaa=_deref_pbuc1_rol_1 
    lda cx16_conio
    asl
    // [393] conio_line_text[gotoxy::$5] = gotoxy::line_offset#0 -- pwuc1_derefidx_vbuaa=vwuz1 
    tay
    lda.z line_offset
    sta conio_line_text,y
    lda.z line_offset+1
    sta conio_line_text+1,y
    // gotoxy::@return
    // }
    // [394] return 
    rts
}
  // vera_layer_mode_tile
// Set a vera layer in tile mode and configure the:
// - layer: Value of 0 or 1.
// - mapbase_address: A dword typed address (4 bytes), that specifies the full address of the map base.
//   The function does the translation from the dword that contains the 17 bit address,
//   to the respective mapbase vera register.
//   Note that the register only specifies bits 16:9 of the address,
//   so the resulting address in the VERA VRAM is always aligned to a multiple of 512 bytes.
// - tilebase_address: A dword typed address (4 bytes), that specifies the base address of the tile map.
//   The function does the translation from the dword that contains the 17 bit address,
//   to the respective tilebase vera register.
//   Note that the resulting vera register holds only specifies bits 16:11 of the address,
//   so the resulting address in the VERA VRAM is always aligned to a multiple of 2048 bytes!
// - mapwidth: The width of the map in number of tiles.
// - mapheight: The height of the map in number of tiles.
// - tilewidth: The width of a tile, which can be 8 or 16 pixels.
// - tileheight: The height of a tile, which can be 8 or 16 pixels.
// - color_depth: The color depth in bits per pixel (BPP), which can be 1, 2, 4 or 8.
// vera_layer_mode_tile(byte zp($15) layer, dword zp($16) mapbase_address, dword zp($1a) tilebase_address, word zp($4e) mapwidth, word zp($50) mapheight, byte zp($1e) tilewidth, byte zp($1f) tileheight, byte register(X) color_depth)
vera_layer_mode_tile: {
    .label __1 = $4e
    .label __2 = $4e
    .label __4 = $4e
    .label __7 = $4e
    .label __8 = $4e
    .label __10 = $4e
    .label __19 = $52
    .label __20 = $53
    .label mapbase_address = $16
    .label tilebase_address = $1a
    .label layer = $15
    .label mapwidth = $4e
    .label mapheight = $50
    .label tilewidth = $1e
    .label tileheight = $1f
    // case 1:
    //             config |= VERA_LAYER_COLOR_DEPTH_1BPP;
    //             break;
    // [396] if(vera_layer_mode_tile::color_depth#3==1) goto vera_layer_mode_tile::@5 -- vbuxx_eq_vbuc1_then_la1 
    cpx #1
    beq __b1
    // vera_layer_mode_tile::@1
    // case 2:
    //             config |= VERA_LAYER_COLOR_DEPTH_2BPP;
    //             break;
    // [397] if(vera_layer_mode_tile::color_depth#3==2) goto vera_layer_mode_tile::@5 -- vbuxx_eq_vbuc1_then_la1 
    cpx #2
    beq __b2
    // vera_layer_mode_tile::@2
    // case 4:
    //             config |= VERA_LAYER_COLOR_DEPTH_4BPP;
    //             break;
    // [398] if(vera_layer_mode_tile::color_depth#3==4) goto vera_layer_mode_tile::@5 -- vbuxx_eq_vbuc1_then_la1 
    cpx #4
    beq __b3
    // vera_layer_mode_tile::@3
    // case 8:
    //             config |= VERA_LAYER_COLOR_DEPTH_8BPP;
    //             break;
    // [399] if(vera_layer_mode_tile::color_depth#3!=8) goto vera_layer_mode_tile::@5 -- vbuxx_neq_vbuc1_then_la1 
    cpx #8
    bne __b4
    // [400] phi from vera_layer_mode_tile::@3 to vera_layer_mode_tile::@4 [phi:vera_layer_mode_tile::@3->vera_layer_mode_tile::@4]
    // vera_layer_mode_tile::@4
    // [401] phi from vera_layer_mode_tile::@4 to vera_layer_mode_tile::@5 [phi:vera_layer_mode_tile::@4->vera_layer_mode_tile::@5]
    // [401] phi vera_layer_mode_tile::config#17 = VERA_LAYER_COLOR_DEPTH_8BPP [phi:vera_layer_mode_tile::@4->vera_layer_mode_tile::@5#0] -- vbuxx=vbuc1 
    ldx #VERA_LAYER_COLOR_DEPTH_8BPP
    jmp __b5
    // [401] phi from vera_layer_mode_tile to vera_layer_mode_tile::@5 [phi:vera_layer_mode_tile->vera_layer_mode_tile::@5]
  __b1:
    // [401] phi vera_layer_mode_tile::config#17 = VERA_LAYER_COLOR_DEPTH_1BPP [phi:vera_layer_mode_tile->vera_layer_mode_tile::@5#0] -- vbuxx=vbuc1 
    ldx #VERA_LAYER_COLOR_DEPTH_1BPP
    jmp __b5
    // [401] phi from vera_layer_mode_tile::@1 to vera_layer_mode_tile::@5 [phi:vera_layer_mode_tile::@1->vera_layer_mode_tile::@5]
  __b2:
    // [401] phi vera_layer_mode_tile::config#17 = VERA_LAYER_COLOR_DEPTH_2BPP [phi:vera_layer_mode_tile::@1->vera_layer_mode_tile::@5#0] -- vbuxx=vbuc1 
    ldx #VERA_LAYER_COLOR_DEPTH_2BPP
    jmp __b5
    // [401] phi from vera_layer_mode_tile::@2 to vera_layer_mode_tile::@5 [phi:vera_layer_mode_tile::@2->vera_layer_mode_tile::@5]
  __b3:
    // [401] phi vera_layer_mode_tile::config#17 = VERA_LAYER_COLOR_DEPTH_4BPP [phi:vera_layer_mode_tile::@2->vera_layer_mode_tile::@5#0] -- vbuxx=vbuc1 
    ldx #VERA_LAYER_COLOR_DEPTH_4BPP
    jmp __b5
    // [401] phi from vera_layer_mode_tile::@3 to vera_layer_mode_tile::@5 [phi:vera_layer_mode_tile::@3->vera_layer_mode_tile::@5]
  __b4:
    // [401] phi vera_layer_mode_tile::config#17 = 0 [phi:vera_layer_mode_tile::@3->vera_layer_mode_tile::@5#0] -- vbuxx=vbuc1 
    ldx #0
    // vera_layer_mode_tile::@5
  __b5:
    // case 32:
    //             config |= VERA_LAYER_WIDTH_32;
    //             vera_layer_rowshift[layer] = 6;
    //             vera_layer_rowskip[layer] = 64;
    //             break;
    // [402] if(vera_layer_mode_tile::mapwidth#10==$20) goto vera_layer_mode_tile::@9 -- vwuz1_eq_vbuc1_then_la1 
    lda #$20
    cmp.z mapwidth
    bne !+
    lda.z mapwidth+1
    bne !+
    jmp __b9
  !:
    // vera_layer_mode_tile::@6
    // case 64:
    //             config |= VERA_LAYER_WIDTH_64;
    //             vera_layer_rowshift[layer] = 7;
    //             vera_layer_rowskip[layer] = 128;
    //             break;
    // [403] if(vera_layer_mode_tile::mapwidth#10==$40) goto vera_layer_mode_tile::@10 -- vwuz1_eq_vbuc1_then_la1 
    lda #$40
    cmp.z mapwidth
    bne !+
    lda.z mapwidth+1
    bne !+
    jmp __b10
  !:
    // vera_layer_mode_tile::@7
    // case 128:
    //             config |= VERA_LAYER_WIDTH_128;
    //             vera_layer_rowshift[layer] = 8;
    //             vera_layer_rowskip[layer] = 256;
    //             break;
    // [404] if(vera_layer_mode_tile::mapwidth#10==$80) goto vera_layer_mode_tile::@11 -- vwuz1_eq_vbuc1_then_la1 
    lda #$80
    cmp.z mapwidth
    bne !+
    lda.z mapwidth+1
    bne !+
    jmp __b11
  !:
    // vera_layer_mode_tile::@8
    // case 256:
    //             config |= VERA_LAYER_WIDTH_256;
    //             vera_layer_rowshift[layer] = 9;
    //             vera_layer_rowskip[layer] = 512;
    //             break;
    // [405] if(vera_layer_mode_tile::mapwidth#10!=$100) goto vera_layer_mode_tile::@13 -- vwuz1_neq_vwuc1_then_la1 
    lda.z mapwidth+1
    cmp #>$100
    bne __b13
    lda.z mapwidth
    cmp #<$100
    bne __b13
    // vera_layer_mode_tile::@12
    // config |= VERA_LAYER_WIDTH_256
    // [406] vera_layer_mode_tile::config#8 = vera_layer_mode_tile::config#17 | VERA_LAYER_WIDTH_256 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_LAYER_WIDTH_256
    tax
    // vera_layer_rowshift[layer] = 9
    // [407] vera_layer_rowshift[vera_layer_mode_tile::layer#10] = 9 -- pbuc1_derefidx_vbuz1=vbuc2 
    lda #9
    ldy.z layer
    sta vera_layer_rowshift,y
    // vera_layer_rowskip[layer] = 512
    // [408] vera_layer_mode_tile::$16 = vera_layer_mode_tile::layer#10 << 1 -- vbuaa=vbuz1_rol_1 
    tya
    asl
    // [409] vera_layer_rowskip[vera_layer_mode_tile::$16] = $200 -- pwuc1_derefidx_vbuaa=vwuc2 
    tay
    lda #<$200
    sta vera_layer_rowskip,y
    lda #>$200
    sta vera_layer_rowskip+1,y
    // [410] phi from vera_layer_mode_tile::@10 vera_layer_mode_tile::@11 vera_layer_mode_tile::@12 vera_layer_mode_tile::@8 vera_layer_mode_tile::@9 to vera_layer_mode_tile::@13 [phi:vera_layer_mode_tile::@10/vera_layer_mode_tile::@11/vera_layer_mode_tile::@12/vera_layer_mode_tile::@8/vera_layer_mode_tile::@9->vera_layer_mode_tile::@13]
    // [410] phi vera_layer_mode_tile::config#21 = vera_layer_mode_tile::config#6 [phi:vera_layer_mode_tile::@10/vera_layer_mode_tile::@11/vera_layer_mode_tile::@12/vera_layer_mode_tile::@8/vera_layer_mode_tile::@9->vera_layer_mode_tile::@13#0] -- register_copy 
    // vera_layer_mode_tile::@13
  __b13:
    // case 32:
    //             config |= VERA_LAYER_HEIGHT_32;
    //             break;
    // [411] if(vera_layer_mode_tile::mapheight#10==$20) goto vera_layer_mode_tile::@20 -- vwuz1_eq_vbuc1_then_la1 
    lda #$20
    cmp.z mapheight
    bne !+
    lda.z mapheight+1
    bne !+
    jmp __b20
  !:
    // vera_layer_mode_tile::@14
    // case 64:
    //             config |= VERA_LAYER_HEIGHT_64;
    //             break;
    // [412] if(vera_layer_mode_tile::mapheight#10==$40) goto vera_layer_mode_tile::@17 -- vwuz1_eq_vbuc1_then_la1 
    lda #$40
    cmp.z mapheight
    bne !+
    lda.z mapheight+1
    bne !+
    jmp __b17
  !:
    // vera_layer_mode_tile::@15
    // case 128:
    //             config |= VERA_LAYER_HEIGHT_128;
    //             break;
    // [413] if(vera_layer_mode_tile::mapheight#10==$80) goto vera_layer_mode_tile::@18 -- vwuz1_eq_vbuc1_then_la1 
    lda #$80
    cmp.z mapheight
    bne !+
    lda.z mapheight+1
    bne !+
    jmp __b18
  !:
    // vera_layer_mode_tile::@16
    // case 256:
    //             config |= VERA_LAYER_HEIGHT_256;
    //             break;
    // [414] if(vera_layer_mode_tile::mapheight#10!=$100) goto vera_layer_mode_tile::@20 -- vwuz1_neq_vwuc1_then_la1 
    lda.z mapheight+1
    cmp #>$100
    bne __b20
    lda.z mapheight
    cmp #<$100
    bne __b20
    // vera_layer_mode_tile::@19
    // config |= VERA_LAYER_HEIGHT_256
    // [415] vera_layer_mode_tile::config#12 = vera_layer_mode_tile::config#21 | VERA_LAYER_HEIGHT_256 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_LAYER_HEIGHT_256
    tax
    // [416] phi from vera_layer_mode_tile::@13 vera_layer_mode_tile::@16 vera_layer_mode_tile::@17 vera_layer_mode_tile::@18 vera_layer_mode_tile::@19 to vera_layer_mode_tile::@20 [phi:vera_layer_mode_tile::@13/vera_layer_mode_tile::@16/vera_layer_mode_tile::@17/vera_layer_mode_tile::@18/vera_layer_mode_tile::@19->vera_layer_mode_tile::@20]
    // [416] phi vera_layer_mode_tile::config#25 = vera_layer_mode_tile::config#21 [phi:vera_layer_mode_tile::@13/vera_layer_mode_tile::@16/vera_layer_mode_tile::@17/vera_layer_mode_tile::@18/vera_layer_mode_tile::@19->vera_layer_mode_tile::@20#0] -- register_copy 
    // vera_layer_mode_tile::@20
  __b20:
    // vera_layer_set_config(layer, config)
    // [417] vera_layer_set_config::layer#0 = vera_layer_mode_tile::layer#10 -- vbuaa=vbuz1 
    lda.z layer
    // [418] vera_layer_set_config::config#0 = vera_layer_mode_tile::config#25
    // [419] call vera_layer_set_config 
    jsr vera_layer_set_config
    // vera_layer_mode_tile::@27
    // <mapbase_address
    // [420] vera_layer_mode_tile::$1 = < vera_layer_mode_tile::mapbase_address#10 -- vwuz1=_lo_vduz2 
    lda.z mapbase_address
    sta.z __1
    lda.z mapbase_address+1
    sta.z __1+1
    // vera_mapbase_offset[layer] = <mapbase_address
    // [421] vera_layer_mode_tile::$19 = vera_layer_mode_tile::layer#10 << 1 -- vbuz1=vbuz2_rol_1 
    lda.z layer
    asl
    sta.z __19
    // [422] vera_mapbase_offset[vera_layer_mode_tile::$19] = vera_layer_mode_tile::$1 -- pwuc1_derefidx_vbuz1=vwuz2 
    // mapbase
    tay
    lda.z __1
    sta vera_mapbase_offset,y
    lda.z __1+1
    sta vera_mapbase_offset+1,y
    // >mapbase_address
    // [423] vera_layer_mode_tile::$2 = > vera_layer_mode_tile::mapbase_address#10 -- vwuz1=_hi_vduz2 
    lda.z mapbase_address+2
    sta.z __2
    lda.z mapbase_address+3
    sta.z __2+1
    // vera_mapbase_bank[layer] = (byte)(>mapbase_address)
    // [424] vera_mapbase_bank[vera_layer_mode_tile::layer#10] = (byte)vera_layer_mode_tile::$2 -- pbuc1_derefidx_vbuz1=_byte_vwuz2 
    ldy.z layer
    lda.z __2
    sta vera_mapbase_bank,y
    // vera_mapbase_address[layer] = mapbase_address
    // [425] vera_layer_mode_tile::$20 = vera_layer_mode_tile::layer#10 << 2 -- vbuz1=vbuz2_rol_2 
    tya
    asl
    asl
    sta.z __20
    // [426] vera_mapbase_address[vera_layer_mode_tile::$20] = vera_layer_mode_tile::mapbase_address#10 -- pduc1_derefidx_vbuz1=vduz2 
    tay
    lda.z mapbase_address
    sta vera_mapbase_address,y
    lda.z mapbase_address+1
    sta vera_mapbase_address+1,y
    lda.z mapbase_address+2
    sta vera_mapbase_address+2,y
    lda.z mapbase_address+3
    sta vera_mapbase_address+3,y
    // mapbase_address = mapbase_address >> 1
    // [427] vera_layer_mode_tile::mapbase_address#0 = vera_layer_mode_tile::mapbase_address#10 >> 1 -- vduz1=vduz1_ror_1 
    lsr.z mapbase_address+3
    ror.z mapbase_address+2
    ror.z mapbase_address+1
    ror.z mapbase_address
    // <mapbase_address
    // [428] vera_layer_mode_tile::$4 = < vera_layer_mode_tile::mapbase_address#0 -- vwuz1=_lo_vduz2 
    lda.z mapbase_address
    sta.z __4
    lda.z mapbase_address+1
    sta.z __4+1
    // mapbase = >(<mapbase_address)
    // [429] vera_layer_mode_tile::mapbase#0 = > vera_layer_mode_tile::$4 -- vbuxx=_hi_vwuz1 
    tax
    // vera_layer_set_mapbase(layer,mapbase)
    // [430] vera_layer_set_mapbase::layer#0 = vera_layer_mode_tile::layer#10 -- vbuaa=vbuz1 
    lda.z layer
    // [431] vera_layer_set_mapbase::mapbase#0 = vera_layer_mode_tile::mapbase#0
    // [432] call vera_layer_set_mapbase 
    // [375] phi from vera_layer_mode_tile::@27 to vera_layer_set_mapbase [phi:vera_layer_mode_tile::@27->vera_layer_set_mapbase]
    // [375] phi vera_layer_set_mapbase::mapbase#3 = vera_layer_set_mapbase::mapbase#0 [phi:vera_layer_mode_tile::@27->vera_layer_set_mapbase#0] -- register_copy 
    // [375] phi vera_layer_set_mapbase::layer#3 = vera_layer_set_mapbase::layer#0 [phi:vera_layer_mode_tile::@27->vera_layer_set_mapbase#1] -- register_copy 
    jsr vera_layer_set_mapbase
    // vera_layer_mode_tile::@28
    // <tilebase_address
    // [433] vera_layer_mode_tile::$7 = < vera_layer_mode_tile::tilebase_address#10 -- vwuz1=_lo_vduz2 
    lda.z tilebase_address
    sta.z __7
    lda.z tilebase_address+1
    sta.z __7+1
    // vera_tilebase_offset[layer] = <tilebase_address
    // [434] vera_tilebase_offset[vera_layer_mode_tile::$19] = vera_layer_mode_tile::$7 -- pwuc1_derefidx_vbuz1=vwuz2 
    // tilebase
    ldy.z __19
    lda.z __7
    sta vera_tilebase_offset,y
    lda.z __7+1
    sta vera_tilebase_offset+1,y
    // >tilebase_address
    // [435] vera_layer_mode_tile::$8 = > vera_layer_mode_tile::tilebase_address#10 -- vwuz1=_hi_vduz2 
    lda.z tilebase_address+2
    sta.z __8
    lda.z tilebase_address+3
    sta.z __8+1
    // vera_tilebase_bank[layer] = (byte)>tilebase_address
    // [436] vera_tilebase_bank[vera_layer_mode_tile::layer#10] = (byte)vera_layer_mode_tile::$8 -- pbuc1_derefidx_vbuz1=_byte_vwuz2 
    ldy.z layer
    lda.z __8
    sta vera_tilebase_bank,y
    // vera_tilebase_address[layer] = tilebase_address
    // [437] vera_tilebase_address[vera_layer_mode_tile::$20] = vera_layer_mode_tile::tilebase_address#10 -- pduc1_derefidx_vbuz1=vduz2 
    ldy.z __20
    lda.z tilebase_address
    sta vera_tilebase_address,y
    lda.z tilebase_address+1
    sta vera_tilebase_address+1,y
    lda.z tilebase_address+2
    sta vera_tilebase_address+2,y
    lda.z tilebase_address+3
    sta vera_tilebase_address+3,y
    // tilebase_address = tilebase_address >> 1
    // [438] vera_layer_mode_tile::tilebase_address#0 = vera_layer_mode_tile::tilebase_address#10 >> 1 -- vduz1=vduz1_ror_1 
    lsr.z tilebase_address+3
    ror.z tilebase_address+2
    ror.z tilebase_address+1
    ror.z tilebase_address
    // <tilebase_address
    // [439] vera_layer_mode_tile::$10 = < vera_layer_mode_tile::tilebase_address#0 -- vwuz1=_lo_vduz2 
    lda.z tilebase_address
    sta.z __10
    lda.z tilebase_address+1
    sta.z __10+1
    // tilebase = >(<tilebase_address)
    // [440] vera_layer_mode_tile::tilebase#0 = > vera_layer_mode_tile::$10 -- vbuaa=_hi_vwuz1 
    // tilebase &= VERA_LAYER_TILEBASE_MASK
    // [441] vera_layer_mode_tile::tilebase#1 = vera_layer_mode_tile::tilebase#0 & VERA_LAYER_TILEBASE_MASK -- vbuxx=vbuaa_band_vbuc1 
    and #VERA_LAYER_TILEBASE_MASK
    tax
    // case 8:
    //             tilebase |= VERA_TILEBASE_WIDTH_8;
    //             break;
    // [442] if(vera_layer_mode_tile::tilewidth#10==8) goto vera_layer_mode_tile::@23 -- vbuz1_eq_vbuc1_then_la1 
    lda #8
    cmp.z tilewidth
    beq __b23
    // vera_layer_mode_tile::@21
    // case 16:
    //             tilebase |= VERA_TILEBASE_WIDTH_16;
    //             break;
    // [443] if(vera_layer_mode_tile::tilewidth#10!=$10) goto vera_layer_mode_tile::@23 -- vbuz1_neq_vbuc1_then_la1 
    lda #$10
    cmp.z tilewidth
    bne __b23
    // vera_layer_mode_tile::@22
    // tilebase |= VERA_TILEBASE_WIDTH_16
    // [444] vera_layer_mode_tile::tilebase#3 = vera_layer_mode_tile::tilebase#1 | VERA_TILEBASE_WIDTH_16 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_TILEBASE_WIDTH_16
    tax
    // [445] phi from vera_layer_mode_tile::@21 vera_layer_mode_tile::@22 vera_layer_mode_tile::@28 to vera_layer_mode_tile::@23 [phi:vera_layer_mode_tile::@21/vera_layer_mode_tile::@22/vera_layer_mode_tile::@28->vera_layer_mode_tile::@23]
    // [445] phi vera_layer_mode_tile::tilebase#12 = vera_layer_mode_tile::tilebase#1 [phi:vera_layer_mode_tile::@21/vera_layer_mode_tile::@22/vera_layer_mode_tile::@28->vera_layer_mode_tile::@23#0] -- register_copy 
    // vera_layer_mode_tile::@23
  __b23:
    // case 8:
    //             tilebase |= VERA_TILEBASE_HEIGHT_8;
    //             break;
    // [446] if(vera_layer_mode_tile::tileheight#10==8) goto vera_layer_mode_tile::@26 -- vbuz1_eq_vbuc1_then_la1 
    lda #8
    cmp.z tileheight
    beq __b26
    // vera_layer_mode_tile::@24
    // case 16:
    //             tilebase |= VERA_TILEBASE_HEIGHT_16;
    //             break;
    // [447] if(vera_layer_mode_tile::tileheight#10!=$10) goto vera_layer_mode_tile::@26 -- vbuz1_neq_vbuc1_then_la1 
    lda #$10
    cmp.z tileheight
    bne __b26
    // vera_layer_mode_tile::@25
    // tilebase |= VERA_TILEBASE_HEIGHT_16
    // [448] vera_layer_mode_tile::tilebase#5 = vera_layer_mode_tile::tilebase#12 | VERA_TILEBASE_HEIGHT_16 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_TILEBASE_HEIGHT_16
    tax
    // [449] phi from vera_layer_mode_tile::@23 vera_layer_mode_tile::@24 vera_layer_mode_tile::@25 to vera_layer_mode_tile::@26 [phi:vera_layer_mode_tile::@23/vera_layer_mode_tile::@24/vera_layer_mode_tile::@25->vera_layer_mode_tile::@26]
    // [449] phi vera_layer_mode_tile::tilebase#10 = vera_layer_mode_tile::tilebase#12 [phi:vera_layer_mode_tile::@23/vera_layer_mode_tile::@24/vera_layer_mode_tile::@25->vera_layer_mode_tile::@26#0] -- register_copy 
    // vera_layer_mode_tile::@26
  __b26:
    // vera_layer_set_tilebase(layer,tilebase)
    // [450] vera_layer_set_tilebase::layer#0 = vera_layer_mode_tile::layer#10 -- vbuaa=vbuz1 
    lda.z layer
    // [451] vera_layer_set_tilebase::tilebase#0 = vera_layer_mode_tile::tilebase#10
    // [452] call vera_layer_set_tilebase 
    jsr vera_layer_set_tilebase
    // vera_layer_mode_tile::@return
    // }
    // [453] return 
    rts
    // vera_layer_mode_tile::@18
  __b18:
    // config |= VERA_LAYER_HEIGHT_128
    // [454] vera_layer_mode_tile::config#11 = vera_layer_mode_tile::config#21 | VERA_LAYER_HEIGHT_128 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_LAYER_HEIGHT_128
    tax
    jmp __b20
    // vera_layer_mode_tile::@17
  __b17:
    // config |= VERA_LAYER_HEIGHT_64
    // [455] vera_layer_mode_tile::config#10 = vera_layer_mode_tile::config#21 | VERA_LAYER_HEIGHT_64 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_LAYER_HEIGHT_64
    tax
    jmp __b20
    // vera_layer_mode_tile::@11
  __b11:
    // config |= VERA_LAYER_WIDTH_128
    // [456] vera_layer_mode_tile::config#7 = vera_layer_mode_tile::config#17 | VERA_LAYER_WIDTH_128 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_LAYER_WIDTH_128
    tax
    // vera_layer_rowshift[layer] = 8
    // [457] vera_layer_rowshift[vera_layer_mode_tile::layer#10] = 8 -- pbuc1_derefidx_vbuz1=vbuc2 
    lda #8
    ldy.z layer
    sta vera_layer_rowshift,y
    // vera_layer_rowskip[layer] = 256
    // [458] vera_layer_mode_tile::$15 = vera_layer_mode_tile::layer#10 << 1 -- vbuaa=vbuz1_rol_1 
    tya
    asl
    // [459] vera_layer_rowskip[vera_layer_mode_tile::$15] = $100 -- pwuc1_derefidx_vbuaa=vwuc2 
    tay
    lda #<$100
    sta vera_layer_rowskip,y
    lda #>$100
    sta vera_layer_rowskip+1,y
    jmp __b13
    // vera_layer_mode_tile::@10
  __b10:
    // config |= VERA_LAYER_WIDTH_64
    // [460] vera_layer_mode_tile::config#6 = vera_layer_mode_tile::config#17 | VERA_LAYER_WIDTH_64 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_LAYER_WIDTH_64
    tax
    // vera_layer_rowshift[layer] = 7
    // [461] vera_layer_rowshift[vera_layer_mode_tile::layer#10] = 7 -- pbuc1_derefidx_vbuz1=vbuc2 
    lda #7
    ldy.z layer
    sta vera_layer_rowshift,y
    // vera_layer_rowskip[layer] = 128
    // [462] vera_layer_mode_tile::$14 = vera_layer_mode_tile::layer#10 << 1 -- vbuaa=vbuz1_rol_1 
    tya
    asl
    // [463] vera_layer_rowskip[vera_layer_mode_tile::$14] = $80 -- pwuc1_derefidx_vbuaa=vbuc2 
    tay
    lda #$80
    sta vera_layer_rowskip,y
    lda #0
    sta vera_layer_rowskip+1,y
    jmp __b13
    // vera_layer_mode_tile::@9
  __b9:
    // vera_layer_rowshift[layer] = 6
    // [464] vera_layer_rowshift[vera_layer_mode_tile::layer#10] = 6 -- pbuc1_derefidx_vbuz1=vbuc2 
    lda #6
    ldy.z layer
    sta vera_layer_rowshift,y
    // vera_layer_rowskip[layer] = 64
    // [465] vera_layer_mode_tile::$13 = vera_layer_mode_tile::layer#10 << 1 -- vbuaa=vbuz1_rol_1 
    tya
    asl
    // [466] vera_layer_rowskip[vera_layer_mode_tile::$13] = $40 -- pwuc1_derefidx_vbuaa=vbuc2 
    tay
    lda #$40
    sta vera_layer_rowskip,y
    lda #0
    sta vera_layer_rowskip+1,y
    jmp __b13
}
  // clrscr
// clears the screen and moves the cursor to the upper left-hand corner of the screen.
clrscr: {
    .label __1 = $2e
    .label line_text = $66
    .label color = $2e
    .label conio_map_height = $64
    .label conio_map_width = $5b
    // line_text = cx16_conio.conio_screen_text
    // [467] clrscr::line_text#0 = *((byte**)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT) -- pbuz1=_deref_qbuc1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT
    sta.z line_text
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT+1
    sta.z line_text+1
    // vera_layer_get_backcolor(cx16_conio.conio_screen_layer)
    // [468] vera_layer_get_backcolor::layer#0 = *((byte*)&cx16_conio) -- vbuxx=_deref_pbuc1 
    ldx cx16_conio
    // [469] call vera_layer_get_backcolor 
    jsr vera_layer_get_backcolor
    // [470] vera_layer_get_backcolor::return#2 = vera_layer_get_backcolor::return#0
    // clrscr::@7
    // [471] clrscr::$0 = vera_layer_get_backcolor::return#2
    // vera_layer_get_backcolor(cx16_conio.conio_screen_layer) << 4
    // [472] clrscr::$1 = clrscr::$0 << 4 -- vbuz1=vbuaa_rol_4 
    asl
    asl
    asl
    asl
    sta.z __1
    // vera_layer_get_textcolor(cx16_conio.conio_screen_layer)
    // [473] vera_layer_get_textcolor::layer#0 = *((byte*)&cx16_conio) -- vbuxx=_deref_pbuc1 
    ldx cx16_conio
    // [474] call vera_layer_get_textcolor 
    jsr vera_layer_get_textcolor
    // [475] vera_layer_get_textcolor::return#2 = vera_layer_get_textcolor::return#0
    // clrscr::@8
    // [476] clrscr::$2 = vera_layer_get_textcolor::return#2
    // color = ( vera_layer_get_backcolor(cx16_conio.conio_screen_layer) << 4 ) | vera_layer_get_textcolor(cx16_conio.conio_screen_layer)
    // [477] clrscr::color#0 = clrscr::$1 | clrscr::$2 -- vbuz1=vbuz1_bor_vbuaa 
    ora.z color
    sta.z color
    // conio_map_height = cx16_conio.conio_map_height
    // [478] clrscr::conio_map_height#0 = *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT) -- vwuz1=_deref_pwuc1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT
    sta.z conio_map_height
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT+1
    sta.z conio_map_height+1
    // conio_map_width = cx16_conio.conio_map_width
    // [479] clrscr::conio_map_width#0 = *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH) -- vwuz1=_deref_pwuc1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH
    sta.z conio_map_width
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH+1
    sta.z conio_map_width+1
    // [480] phi from clrscr::@8 to clrscr::@1 [phi:clrscr::@8->clrscr::@1]
    // [480] phi clrscr::line_text#2 = clrscr::line_text#0 [phi:clrscr::@8->clrscr::@1#0] -- register_copy 
    // [480] phi clrscr::l#2 = 0 [phi:clrscr::@8->clrscr::@1#1] -- vbuxx=vbuc1 
    ldx #0
    // clrscr::@1
  __b1:
    // for( char l=0;l<conio_map_height; l++ )
    // [481] if(clrscr::l#2<clrscr::conio_map_height#0) goto clrscr::@2 -- vbuxx_lt_vwuz1_then_la1 
    lda.z conio_map_height+1
    bne __b2
    cpx.z conio_map_height
    bcc __b2
    // clrscr::@3
    // conio_cursor_x[cx16_conio.conio_screen_layer] = 0
    // [482] conio_cursor_x[*((byte*)&cx16_conio)] = 0 -- pbuc1_derefidx_(_deref_pbuc2)=vbuc3 
    lda #0
    ldy cx16_conio
    sta conio_cursor_x,y
    // conio_cursor_y[cx16_conio.conio_screen_layer] = 0
    // [483] conio_cursor_y[*((byte*)&cx16_conio)] = 0 -- pbuc1_derefidx_(_deref_pbuc2)=vbuc3 
    sta conio_cursor_y,y
    // conio_line_text[cx16_conio.conio_screen_layer] = 0
    // [484] clrscr::$9 = *((byte*)&cx16_conio) << 1 -- vbuaa=_deref_pbuc1_rol_1 
    tya
    asl
    // [485] conio_line_text[clrscr::$9] = 0 -- pwuc1_derefidx_vbuaa=vbuc2 
    tay
    lda #0
    sta conio_line_text,y
    sta conio_line_text+1,y
    // clrscr::@return
    // }
    // [486] return 
    rts
    // clrscr::@2
  __b2:
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [487] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    // Select DATA0
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <ch
    // [488] clrscr::$5 = < clrscr::line_text#2 -- vbuaa=_lo_pbuz1 
    lda.z line_text
    // *VERA_ADDRX_L = <ch
    // [489] *VERA_ADDRX_L = clrscr::$5 -- _deref_pbuc1=vbuaa 
    // Set address
    sta VERA_ADDRX_L
    // >ch
    // [490] clrscr::$6 = > clrscr::line_text#2 -- vbuaa=_hi_pbuz1 
    lda.z line_text+1
    // *VERA_ADDRX_M = >ch
    // [491] *VERA_ADDRX_M = clrscr::$6 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // cx16_conio.conio_screen_bank | VERA_INC_1
    // [492] clrscr::$7 = *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK) | VERA_INC_1 -- vbuaa=_deref_pbuc1_bor_vbuc2 
    lda #VERA_INC_1
    ora cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK
    // *VERA_ADDRX_H = cx16_conio.conio_screen_bank | VERA_INC_1
    // [493] *VERA_ADDRX_H = clrscr::$7 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_H
    // [494] phi from clrscr::@2 to clrscr::@4 [phi:clrscr::@2->clrscr::@4]
    // [494] phi clrscr::c#2 = 0 [phi:clrscr::@2->clrscr::@4#0] -- vbuyy=vbuc1 
    ldy #0
    // clrscr::@4
  __b4:
    // for( char c=0;c<conio_map_width; c++ )
    // [495] if(clrscr::c#2<clrscr::conio_map_width#0) goto clrscr::@5 -- vbuyy_lt_vwuz1_then_la1 
    lda.z conio_map_width+1
    bne __b5
    cpy.z conio_map_width
    bcc __b5
    // clrscr::@6
    // line_text += cx16_conio.conio_rowskip
    // [496] clrscr::line_text#1 = clrscr::line_text#2 + *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP) -- pbuz1=pbuz1_plus__deref_pwuc1 
    clc
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP
    adc.z line_text
    sta.z line_text
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP+1
    adc.z line_text+1
    sta.z line_text+1
    // for( char l=0;l<conio_map_height; l++ )
    // [497] clrscr::l#1 = ++ clrscr::l#2 -- vbuxx=_inc_vbuxx 
    inx
    // [480] phi from clrscr::@6 to clrscr::@1 [phi:clrscr::@6->clrscr::@1]
    // [480] phi clrscr::line_text#2 = clrscr::line_text#1 [phi:clrscr::@6->clrscr::@1#0] -- register_copy 
    // [480] phi clrscr::l#2 = clrscr::l#1 [phi:clrscr::@6->clrscr::@1#1] -- register_copy 
    jmp __b1
    // clrscr::@5
  __b5:
    // *VERA_DATA0 = ' '
    // [498] *VERA_DATA0 = ' ' -- _deref_pbuc1=vbuc2 
    lda #' '
    sta VERA_DATA0
    // *VERA_DATA0 = color
    // [499] *VERA_DATA0 = clrscr::color#0 -- _deref_pbuc1=vbuz1 
    lda.z color
    sta VERA_DATA0
    // for( char c=0;c<conio_map_width; c++ )
    // [500] clrscr::c#1 = ++ clrscr::c#2 -- vbuyy=_inc_vbuyy 
    iny
    // [494] phi from clrscr::@5 to clrscr::@4 [phi:clrscr::@5->clrscr::@4]
    // [494] phi clrscr::c#2 = clrscr::c#1 [phi:clrscr::@5->clrscr::@4#0] -- register_copy 
    jmp __b4
}
  // cx16_load_ram_banked
// Load a file to cx16 banked RAM at address A000-BFFF.
// Returns a status:
// - 0xff: Success
// - other: Kernal Error Code (https://commodore.ca/manuals/pdfs/commodore_error_messages.pdf)
// cx16_load_ram_banked(byte* zp($66) filename, dword zp($20) address)
cx16_load_ram_banked: {
    .label __0 = $64
    .label __1 = $64
    .label __3 = $5b
    .label __5 = $2f
    .label __6 = $2f
    .label __7 = $64
    .label __8 = $64
    .label __10 = $2f
    .label __11 = $5b
    .label __33 = $2f
    .label __34 = $64
    .label bank = $3f
    // select the bank
    .label addr = $5b
    .label status = $2e
    .label return = $2e
    .label ch = $3e
    .label address = $20
    .label filename = $66
    // >address
    // [502] cx16_load_ram_banked::$0 = > cx16_load_ram_banked::address#7 -- vwuz1=_hi_vduz2 
    lda.z address+2
    sta.z __0
    lda.z address+3
    sta.z __0+1
    // (>address)<<8
    // [503] cx16_load_ram_banked::$1 = cx16_load_ram_banked::$0 << 8 -- vwuz1=vwuz1_rol_8 
    lda.z __1
    sta.z __1+1
    lda #0
    sta.z __1
    // <(>address)<<8
    // [504] cx16_load_ram_banked::$2 = < cx16_load_ram_banked::$1 -- vbuxx=_lo_vwuz1 
    tax
    // <address
    // [505] cx16_load_ram_banked::$3 = < cx16_load_ram_banked::address#7 -- vwuz1=_lo_vduz2 
    lda.z address
    sta.z __3
    lda.z address+1
    sta.z __3+1
    // >(<address)
    // [506] cx16_load_ram_banked::$4 = > cx16_load_ram_banked::$3 -- vbuyy=_hi_vwuz1 
    tay
    // ((word)<(>address)<<8)|>(<address)
    // [507] cx16_load_ram_banked::$33 = (word)cx16_load_ram_banked::$2 -- vwuz1=_word_vbuxx 
    txa
    sta.z __33
    sta.z __33+1
    // [508] cx16_load_ram_banked::$5 = cx16_load_ram_banked::$33 | cx16_load_ram_banked::$4 -- vwuz1=vwuz1_bor_vbuyy 
    tya
    ora.z __5
    sta.z __5
    // (((word)<(>address)<<8)|>(<address))>>5
    // [509] cx16_load_ram_banked::$6 = cx16_load_ram_banked::$5 >> 5 -- vwuz1=vwuz1_ror_5 
    lsr.z __6+1
    ror.z __6
    lsr.z __6+1
    ror.z __6
    lsr.z __6+1
    ror.z __6
    lsr.z __6+1
    ror.z __6
    lsr.z __6+1
    ror.z __6
    // >address
    // [510] cx16_load_ram_banked::$7 = > cx16_load_ram_banked::address#7 -- vwuz1=_hi_vduz2 
    lda.z address+2
    sta.z __7
    lda.z address+3
    sta.z __7+1
    // (>address)<<3
    // [511] cx16_load_ram_banked::$8 = cx16_load_ram_banked::$7 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z __8
    rol.z __8+1
    asl.z __8
    rol.z __8+1
    asl.z __8
    rol.z __8+1
    // <(>address)<<3
    // [512] cx16_load_ram_banked::$9 = < cx16_load_ram_banked::$8 -- vbuaa=_lo_vwuz1 
    lda.z __8
    // ((((word)<(>address)<<8)|>(<address))>>5)+((word)<(>address)<<3)
    // [513] cx16_load_ram_banked::$34 = (word)cx16_load_ram_banked::$9 -- vwuz1=_word_vbuaa 
    sta.z __34
    txa
    sta.z __34+1
    // [514] cx16_load_ram_banked::$10 = cx16_load_ram_banked::$6 + cx16_load_ram_banked::$34 -- vwuz1=vwuz1_plus_vwuz2 
    lda.z __10
    clc
    adc.z __34
    sta.z __10
    lda.z __10+1
    adc.z __34+1
    sta.z __10+1
    // bank = (byte)(((((word)<(>address)<<8)|>(<address))>>5)+((word)<(>address)<<3))
    // [515] cx16_load_ram_banked::bank#0 = (byte)cx16_load_ram_banked::$10 -- vbuz1=_byte_vwuz2 
    lda.z __10
    sta.z bank
    // <address
    // [516] cx16_load_ram_banked::$11 = < cx16_load_ram_banked::address#7 -- vwuz1=_lo_vduz2 
    lda.z address
    sta.z __11
    lda.z address+1
    sta.z __11+1
    // (<address)&0x1FFF
    // [517] cx16_load_ram_banked::addr#0 = cx16_load_ram_banked::$11 & $1fff -- vwuz1=vwuz1_band_vwuc1 
    lda.z addr
    and #<$1fff
    sta.z addr
    lda.z addr+1
    and #>$1fff
    sta.z addr+1
    // addr += 0xA000
    // [518] cx16_load_ram_banked::addr#1 = (byte*)cx16_load_ram_banked::addr#0 + $a000 -- pbuz1=pbuz1_plus_vwuc1 
    // stip off the top 3 bits, which are representing the bank of the word!
    clc
    lda.z addr
    adc #<$a000
    sta.z addr
    lda.z addr+1
    adc #>$a000
    sta.z addr+1
    // cx16_ram_bank(bank)
    // [519] cx16_ram_bank::bank#0 = cx16_load_ram_banked::bank#0 -- vbuaa=vbuz1 
    lda.z bank
    // [520] call cx16_ram_bank 
    // [730] phi from cx16_load_ram_banked to cx16_ram_bank [phi:cx16_load_ram_banked->cx16_ram_bank]
    // [730] phi cx16_ram_bank::bank#5 = cx16_ram_bank::bank#0 [phi:cx16_load_ram_banked->cx16_ram_bank#0] -- register_copy 
    jsr cx16_ram_bank
    // cx16_load_ram_banked::@8
    // cbm_k_setnam(filename)
    // [521] cbm_k_setnam::filename = cx16_load_ram_banked::filename#7 -- pbuz1=pbuz2 
    lda.z filename
    sta.z cbm_k_setnam.filename
    lda.z filename+1
    sta.z cbm_k_setnam.filename+1
    // [522] call cbm_k_setnam 
    jsr cbm_k_setnam
    // cx16_load_ram_banked::@9
    // cbm_k_setlfs(channel, device, secondary)
    // [523] cbm_k_setlfs::channel = 1 -- vbuz1=vbuc1 
    lda #1
    sta.z cbm_k_setlfs.channel
    // [524] cbm_k_setlfs::device = 8 -- vbuz1=vbuc1 
    lda #8
    sta.z cbm_k_setlfs.device
    // [525] cbm_k_setlfs::secondary = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z cbm_k_setlfs.secondary
    // [526] call cbm_k_setlfs 
    jsr cbm_k_setlfs
    // [527] phi from cx16_load_ram_banked::@9 to cx16_load_ram_banked::@10 [phi:cx16_load_ram_banked::@9->cx16_load_ram_banked::@10]
    // cx16_load_ram_banked::@10
    // cbm_k_open()
    // [528] call cbm_k_open 
    jsr cbm_k_open
    // [529] cbm_k_open::return#2 = cbm_k_open::return#1
    // cx16_load_ram_banked::@11
    // [530] cx16_load_ram_banked::status#1 = cbm_k_open::return#2 -- vbuz1=vbuaa 
    sta.z status
    // if(status!=$FF)
    // [531] if(cx16_load_ram_banked::status#1==$ff) goto cx16_load_ram_banked::@1 -- vbuz1_eq_vbuc1_then_la1 
    lda #$ff
    cmp.z status
    beq __b1
    // [532] phi from cx16_load_ram_banked::@11 cx16_load_ram_banked::@12 cx16_load_ram_banked::@16 to cx16_load_ram_banked::@return [phi:cx16_load_ram_banked::@11/cx16_load_ram_banked::@12/cx16_load_ram_banked::@16->cx16_load_ram_banked::@return]
    // [532] phi cx16_load_ram_banked::return#1 = cx16_load_ram_banked::status#1 [phi:cx16_load_ram_banked::@11/cx16_load_ram_banked::@12/cx16_load_ram_banked::@16->cx16_load_ram_banked::@return#0] -- register_copy 
    // cx16_load_ram_banked::@return
    // }
    // [533] return 
    rts
    // cx16_load_ram_banked::@1
  __b1:
    // cbm_k_chkin(channel)
    // [534] cbm_k_chkin::channel = 1 -- vbuz1=vbuc1 
    lda #1
    sta.z cbm_k_chkin.channel
    // [535] call cbm_k_chkin 
    jsr cbm_k_chkin
    // [536] cbm_k_chkin::return#2 = cbm_k_chkin::return#1
    // cx16_load_ram_banked::@12
    // [537] cx16_load_ram_banked::status#2 = cbm_k_chkin::return#2 -- vbuz1=vbuaa 
    sta.z status
    // if(status!=$FF)
    // [538] if(cx16_load_ram_banked::status#2==$ff) goto cx16_load_ram_banked::@2 -- vbuz1_eq_vbuc1_then_la1 
    lda #$ff
    cmp.z status
    beq __b2
    rts
    // [539] phi from cx16_load_ram_banked::@12 to cx16_load_ram_banked::@2 [phi:cx16_load_ram_banked::@12->cx16_load_ram_banked::@2]
    // cx16_load_ram_banked::@2
  __b2:
    // cbm_k_chrin()
    // [540] call cbm_k_chrin 
    jsr cbm_k_chrin
    // [541] cbm_k_chrin::return#2 = cbm_k_chrin::return#1
    // cx16_load_ram_banked::@13
    // ch = cbm_k_chrin()
    // [542] cx16_load_ram_banked::ch#1 = cbm_k_chrin::return#2 -- vbuz1=vbuaa 
    sta.z ch
    // cbm_k_readst()
    // [543] call cbm_k_readst 
    jsr cbm_k_readst
    // [544] cbm_k_readst::return#2 = cbm_k_readst::return#1
    // cx16_load_ram_banked::@14
    // status = cbm_k_readst()
    // [545] cx16_load_ram_banked::status#3 = cbm_k_readst::return#2
    // [546] phi from cx16_load_ram_banked::@14 cx16_load_ram_banked::@18 to cx16_load_ram_banked::@3 [phi:cx16_load_ram_banked::@14/cx16_load_ram_banked::@18->cx16_load_ram_banked::@3]
    // [546] phi cx16_load_ram_banked::bank#2 = cx16_load_ram_banked::bank#0 [phi:cx16_load_ram_banked::@14/cx16_load_ram_banked::@18->cx16_load_ram_banked::@3#0] -- register_copy 
    // [546] phi cx16_load_ram_banked::ch#3 = cx16_load_ram_banked::ch#1 [phi:cx16_load_ram_banked::@14/cx16_load_ram_banked::@18->cx16_load_ram_banked::@3#1] -- register_copy 
    // [546] phi cx16_load_ram_banked::addr#4 = cx16_load_ram_banked::addr#1 [phi:cx16_load_ram_banked::@14/cx16_load_ram_banked::@18->cx16_load_ram_banked::@3#2] -- register_copy 
    // [546] phi cx16_load_ram_banked::status#8 = cx16_load_ram_banked::status#3 [phi:cx16_load_ram_banked::@14/cx16_load_ram_banked::@18->cx16_load_ram_banked::@3#3] -- register_copy 
    // cx16_load_ram_banked::@3
  __b3:
    // while (!status)
    // [547] if(0==cx16_load_ram_banked::status#8) goto cx16_load_ram_banked::@4 -- 0_eq_vbuaa_then_la1 
    cmp #0
    beq __b4
    // cx16_load_ram_banked::@5
    // cbm_k_close(channel)
    // [548] cbm_k_close::channel = 1 -- vbuz1=vbuc1 
    lda #1
    sta.z cbm_k_close.channel
    // [549] call cbm_k_close 
    jsr cbm_k_close
    // [550] cbm_k_close::return#2 = cbm_k_close::return#1
    // cx16_load_ram_banked::@15
    // [551] cx16_load_ram_banked::status#10 = cbm_k_close::return#2 -- vbuz1=vbuaa 
    sta.z status
    // cbm_k_clrchn()
    // [552] call cbm_k_clrchn 
    jsr cbm_k_clrchn
    // [553] phi from cx16_load_ram_banked::@15 to cx16_load_ram_banked::@16 [phi:cx16_load_ram_banked::@15->cx16_load_ram_banked::@16]
    // cx16_load_ram_banked::@16
    // cx16_ram_bank(1)
    // [554] call cx16_ram_bank 
    // [730] phi from cx16_load_ram_banked::@16 to cx16_ram_bank [phi:cx16_load_ram_banked::@16->cx16_ram_bank]
    // [730] phi cx16_ram_bank::bank#5 = 1 [phi:cx16_load_ram_banked::@16->cx16_ram_bank#0] -- vbuaa=vbuc1 
    lda #1
    jsr cx16_ram_bank
    rts
    // cx16_load_ram_banked::@4
  __b4:
    // if(addr == 0xC000)
    // [555] if(cx16_load_ram_banked::addr#4!=$c000) goto cx16_load_ram_banked::@6 -- pbuz1_neq_vwuc1_then_la1 
    lda.z addr+1
    cmp #>$c000
    bne __b6
    lda.z addr
    cmp #<$c000
    bne __b6
    // cx16_load_ram_banked::@7
    // bank++;
    // [556] cx16_load_ram_banked::bank#1 = ++ cx16_load_ram_banked::bank#2 -- vbuz1=_inc_vbuz1 
    inc.z bank
    // cx16_ram_bank(bank)
    // [557] cx16_ram_bank::bank#2 = cx16_load_ram_banked::bank#1 -- vbuaa=vbuz1 
    lda.z bank
    // [558] call cx16_ram_bank 
  //printf(", %u", (word)bank);
    // [730] phi from cx16_load_ram_banked::@7 to cx16_ram_bank [phi:cx16_load_ram_banked::@7->cx16_ram_bank]
    // [730] phi cx16_ram_bank::bank#5 = cx16_ram_bank::bank#2 [phi:cx16_load_ram_banked::@7->cx16_ram_bank#0] -- register_copy 
    jsr cx16_ram_bank
    // [559] phi from cx16_load_ram_banked::@7 to cx16_load_ram_banked::@6 [phi:cx16_load_ram_banked::@7->cx16_load_ram_banked::@6]
    // [559] phi cx16_load_ram_banked::bank#10 = cx16_load_ram_banked::bank#1 [phi:cx16_load_ram_banked::@7->cx16_load_ram_banked::@6#0] -- register_copy 
    // [559] phi cx16_load_ram_banked::addr#5 = (byte*) 40960 [phi:cx16_load_ram_banked::@7->cx16_load_ram_banked::@6#1] -- pbuz1=pbuc1 
    lda #<$a000
    sta.z addr
    lda #>$a000
    sta.z addr+1
    // [559] phi from cx16_load_ram_banked::@4 to cx16_load_ram_banked::@6 [phi:cx16_load_ram_banked::@4->cx16_load_ram_banked::@6]
    // [559] phi cx16_load_ram_banked::bank#10 = cx16_load_ram_banked::bank#2 [phi:cx16_load_ram_banked::@4->cx16_load_ram_banked::@6#0] -- register_copy 
    // [559] phi cx16_load_ram_banked::addr#5 = cx16_load_ram_banked::addr#4 [phi:cx16_load_ram_banked::@4->cx16_load_ram_banked::@6#1] -- register_copy 
    // cx16_load_ram_banked::@6
  __b6:
    // *addr = ch
    // [560] *cx16_load_ram_banked::addr#5 = cx16_load_ram_banked::ch#3 -- _deref_pbuz1=vbuz2 
    lda.z ch
    ldy #0
    sta (addr),y
    // addr++;
    // [561] cx16_load_ram_banked::addr#10 = ++ cx16_load_ram_banked::addr#5 -- pbuz1=_inc_pbuz1 
    inc.z addr
    bne !+
    inc.z addr+1
  !:
    // cbm_k_chrin()
    // [562] call cbm_k_chrin 
    jsr cbm_k_chrin
    // [563] cbm_k_chrin::return#3 = cbm_k_chrin::return#1
    // cx16_load_ram_banked::@17
    // ch = cbm_k_chrin()
    // [564] cx16_load_ram_banked::ch#2 = cbm_k_chrin::return#3 -- vbuz1=vbuaa 
    sta.z ch
    // cbm_k_readst()
    // [565] call cbm_k_readst 
    jsr cbm_k_readst
    // [566] cbm_k_readst::return#3 = cbm_k_readst::return#1
    // cx16_load_ram_banked::@18
    // status = cbm_k_readst()
    // [567] cx16_load_ram_banked::status#5 = cbm_k_readst::return#3
    jmp __b3
}
  // cputs
// Output a NUL-terminated string at the current cursor position
// cputs(byte* zp($5b) s)
cputs: {
    .label s = $5b
    // [569] phi from cputs cputs::@2 to cputs::@1 [phi:cputs/cputs::@2->cputs::@1]
    // [569] phi cputs::s#15 = cputs::s#16 [phi:cputs/cputs::@2->cputs::@1#0] -- register_copy 
    // cputs::@1
  __b1:
    // while(c=*s++)
    // [570] cputs::c#1 = *cputs::s#15 -- vbuaa=_deref_pbuz1 
    ldy #0
    lda (s),y
    // [571] cputs::s#0 = ++ cputs::s#15 -- pbuz1=_inc_pbuz1 
    inc.z s
    bne !+
    inc.z s+1
  !:
    // [572] if(0!=cputs::c#1) goto cputs::@2 -- 0_neq_vbuaa_then_la1 
    cmp #0
    bne __b2
    // cputs::@return
    // }
    // [573] return 
    rts
    // cputs::@2
  __b2:
    // cputc(c)
    // [574] cputc::c#0 = cputs::c#1 -- vbuz1=vbuaa 
    sta.z cputc.c
    // [575] call cputc 
    // [769] phi from cputs::@2 to cputc [phi:cputs::@2->cputc]
    // [769] phi cputc::c#3 = cputc::c#0 [phi:cputs::@2->cputc#0] -- register_copy 
    jsr cputc
    jmp __b1
}
  // printf_uchar
// Print an unsigned char using a specific format
// printf_uchar(byte register(X) uvalue, byte register(Y) format_radix)
printf_uchar: {
    // printf_uchar::@1
    // printf_buffer.sign = format.sign_always?'+':0
    // [577] *((byte*)&printf_buffer) = 0 -- _deref_pbuc1=vbuc2 
    // Handle any sign
    lda #0
    sta printf_buffer
    // uctoa(uvalue, printf_buffer.digits, format.radix)
    // [578] uctoa::value#1 = printf_uchar::uvalue#10
    // [579] uctoa::radix#0 = printf_uchar::format_radix#10
    // [580] call uctoa 
    // Format number into buffer
    jsr uctoa
    // printf_uchar::@2
    // printf_number_buffer(printf_buffer, format)
    // [581] printf_number_buffer::buffer_sign#0 = *((byte*)&printf_buffer) -- vbuaa=_deref_pbuc1 
    lda printf_buffer
    // [582] call printf_number_buffer 
  // Print using format
    // [831] phi from printf_uchar::@2 to printf_number_buffer [phi:printf_uchar::@2->printf_number_buffer]
    jsr printf_number_buffer
    // printf_uchar::@return
    // }
    // [583] return 
    rts
}
  // bnkcpy_vram_address
// Copy block of banked internal memory (256 banks at A000-BFFF) to VERA VRAM.
// Copies the values of num bytes from the location pointed to by source directly to the memory block pointed to by destination in VRAM.
// - vdest: dword of the destination address in VRAM
// - src: dword of source banked address in RAM. This address is a linair project of the banked memory of 512K to 2048K.
// - num: dword of the number of bytes to copy
// bnkcpy_vram_address(dword zp($20) vdest, dword zp($24) num)
bnkcpy_vram_address: {
    .label __0 = $2f
    .label __2 = $64
    .label __4 = $64
    .label __7 = $5b
    .label __8 = $5b
    .label __10 = $5b
    .label __12 = $66
    .label __13 = $66
    .label __14 = $64
    .label __15 = $64
    .label __17 = $66
    .label __18 = $2f
    .label __25 = $66
    .label __26 = $2f
    .label beg = $28
    .label end = $24
    // select the bank
    .label addr = $2f
    .label pos = $28
    .label vdest = $20
    .label num = $24
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [585] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    // Select DATA0
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <vdest
    // [586] bnkcpy_vram_address::$0 = < bnkcpy_vram_address::vdest#7 -- vwuz1=_lo_vduz2 
    lda.z vdest
    sta.z __0
    lda.z vdest+1
    sta.z __0+1
    // <(<vdest)
    // [587] bnkcpy_vram_address::$1 = < bnkcpy_vram_address::$0 -- vbuaa=_lo_vwuz1 
    lda.z __0
    // *VERA_ADDRX_L = <(<vdest)
    // [588] *VERA_ADDRX_L = bnkcpy_vram_address::$1 -- _deref_pbuc1=vbuaa 
    // Set address
    sta VERA_ADDRX_L
    // <vdest
    // [589] bnkcpy_vram_address::$2 = < bnkcpy_vram_address::vdest#7 -- vwuz1=_lo_vduz2 
    lda.z vdest
    sta.z __2
    lda.z vdest+1
    sta.z __2+1
    // >(<vdest)
    // [590] bnkcpy_vram_address::$3 = > bnkcpy_vram_address::$2 -- vbuaa=_hi_vwuz1 
    // *VERA_ADDRX_M = >(<vdest)
    // [591] *VERA_ADDRX_M = bnkcpy_vram_address::$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // >vdest
    // [592] bnkcpy_vram_address::$4 = > bnkcpy_vram_address::vdest#7 -- vwuz1=_hi_vduz2 
    lda.z vdest+2
    sta.z __4
    lda.z vdest+3
    sta.z __4+1
    // <(>vdest)
    // [593] bnkcpy_vram_address::$5 = < bnkcpy_vram_address::$4 -- vbuaa=_lo_vwuz1 
    lda.z __4
    // *VERA_ADDRX_H = <(>vdest)
    // [594] *VERA_ADDRX_H = bnkcpy_vram_address::$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_H
    // *VERA_ADDRX_H |= VERA_INC_1
    // [595] *VERA_ADDRX_H = *VERA_ADDRX_H | VERA_INC_1 -- _deref_pbuc1=_deref_pbuc1_bor_vbuc2 
    lda #VERA_INC_1
    ora VERA_ADDRX_H
    sta VERA_ADDRX_H
    // end = src+num
    // [596] bnkcpy_vram_address::end#0 = bnkcpy_vram_address::beg#0 + bnkcpy_vram_address::num#7 -- vduz1=vduz2_plus_vduz1 
    lda.z end
    clc
    adc.z beg
    sta.z end
    lda.z end+1
    adc.z beg+1
    sta.z end+1
    lda.z end+2
    adc.z beg+2
    sta.z end+2
    lda.z end+3
    adc.z beg+3
    sta.z end+3
    // >beg
    // [597] bnkcpy_vram_address::$7 = > bnkcpy_vram_address::beg#0 -- vwuz1=_hi_vduz2 
    lda.z beg+2
    sta.z __7
    lda.z beg+3
    sta.z __7+1
    // (>beg)<<8
    // [598] bnkcpy_vram_address::$8 = bnkcpy_vram_address::$7 << 8 -- vwuz1=vwuz1_rol_8 
    lda.z __8
    sta.z __8+1
    lda #0
    sta.z __8
    // <(>beg)<<8
    // [599] bnkcpy_vram_address::$9 = < bnkcpy_vram_address::$8 -- vbuyy=_lo_vwuz1 
    tay
    // <beg
    // [600] bnkcpy_vram_address::$10 = < bnkcpy_vram_address::beg#0 -- vwuz1=_lo_vduz2 
    lda.z beg
    sta.z __10
    lda.z beg+1
    sta.z __10+1
    // >(<beg)
    // [601] bnkcpy_vram_address::$11 = > bnkcpy_vram_address::$10 -- vbuxx=_hi_vwuz1 
    tax
    // ((word)<(>beg)<<8)|>(<beg)
    // [602] bnkcpy_vram_address::$25 = (word)bnkcpy_vram_address::$9 -- vwuz1=_word_vbuyy 
    tya
    sta.z __25
    sta.z __25+1
    // [603] bnkcpy_vram_address::$12 = bnkcpy_vram_address::$25 | bnkcpy_vram_address::$11 -- vwuz1=vwuz1_bor_vbuxx 
    txa
    ora.z __12
    sta.z __12
    // (((word)<(>beg)<<8)|>(<beg))>>5
    // [604] bnkcpy_vram_address::$13 = bnkcpy_vram_address::$12 >> 5 -- vwuz1=vwuz1_ror_5 
    lsr.z __13+1
    ror.z __13
    lsr.z __13+1
    ror.z __13
    lsr.z __13+1
    ror.z __13
    lsr.z __13+1
    ror.z __13
    lsr.z __13+1
    ror.z __13
    // >beg
    // [605] bnkcpy_vram_address::$14 = > bnkcpy_vram_address::beg#0 -- vwuz1=_hi_vduz2 
    lda.z beg+2
    sta.z __14
    lda.z beg+3
    sta.z __14+1
    // (>beg)<<3
    // [606] bnkcpy_vram_address::$15 = bnkcpy_vram_address::$14 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z __15
    rol.z __15+1
    asl.z __15
    rol.z __15+1
    asl.z __15
    rol.z __15+1
    // <(>beg)<<3
    // [607] bnkcpy_vram_address::$16 = < bnkcpy_vram_address::$15 -- vbuaa=_lo_vwuz1 
    lda.z __15
    // ((((word)<(>beg)<<8)|>(<beg))>>5)+((word)<(>beg)<<3)
    // [608] bnkcpy_vram_address::$26 = (word)bnkcpy_vram_address::$16 -- vwuz1=_word_vbuaa 
    sta.z __26
    tya
    sta.z __26+1
    // [609] bnkcpy_vram_address::$17 = bnkcpy_vram_address::$13 + bnkcpy_vram_address::$26 -- vwuz1=vwuz1_plus_vwuz2 
    lda.z __17
    clc
    adc.z __26
    sta.z __17
    lda.z __17+1
    adc.z __26+1
    sta.z __17+1
    // bank = (byte)(((((word)<(>beg)<<8)|>(<beg))>>5)+((word)<(>beg)<<3))
    // [610] bnkcpy_vram_address::bank#0 = (byte)bnkcpy_vram_address::$17 -- vbuxx=_byte_vwuz1 
    lda.z __17
    tax
    // <beg
    // [611] bnkcpy_vram_address::$18 = < bnkcpy_vram_address::beg#0 -- vwuz1=_lo_vduz2 
    lda.z beg
    sta.z __18
    lda.z beg+1
    sta.z __18+1
    // (<beg)&0x1FFF
    // [612] bnkcpy_vram_address::addr#0 = bnkcpy_vram_address::$18 & $1fff -- vwuz1=vwuz1_band_vwuc1 
    lda.z addr
    and #<$1fff
    sta.z addr
    lda.z addr+1
    and #>$1fff
    sta.z addr+1
    // addr += 0xA000
    // [613] bnkcpy_vram_address::addr#1 = (byte*)bnkcpy_vram_address::addr#0 + $a000 -- pbuz1=pbuz1_plus_vwuc1 
    // strip off the top 3 bits, which are representing the bank of the word!
    clc
    lda.z addr
    adc #<$a000
    sta.z addr
    lda.z addr+1
    adc #>$a000
    sta.z addr+1
    // cx16_ram_bank(bank)
    // [614] cx16_ram_bank::bank#3 = bnkcpy_vram_address::bank#0 -- vbuaa=vbuxx 
    txa
    // [615] call cx16_ram_bank 
  //printf("bank = %u\n", (word)bank);
    // [730] phi from bnkcpy_vram_address to cx16_ram_bank [phi:bnkcpy_vram_address->cx16_ram_bank]
    // [730] phi cx16_ram_bank::bank#5 = cx16_ram_bank::bank#3 [phi:bnkcpy_vram_address->cx16_ram_bank#0] -- register_copy 
    jsr cx16_ram_bank
    // [616] phi from bnkcpy_vram_address bnkcpy_vram_address::@3 to bnkcpy_vram_address::@1 [phi:bnkcpy_vram_address/bnkcpy_vram_address::@3->bnkcpy_vram_address::@1]
  __b1:
    // [616] phi bnkcpy_vram_address::bank#2 = bnkcpy_vram_address::bank#0 [phi:bnkcpy_vram_address/bnkcpy_vram_address::@3->bnkcpy_vram_address::@1#0] -- register_copy 
    // [616] phi bnkcpy_vram_address::addr#4 = bnkcpy_vram_address::addr#1 [phi:bnkcpy_vram_address/bnkcpy_vram_address::@3->bnkcpy_vram_address::@1#1] -- register_copy 
    // [616] phi bnkcpy_vram_address::pos#2 = bnkcpy_vram_address::beg#0 [phi:bnkcpy_vram_address/bnkcpy_vram_address::@3->bnkcpy_vram_address::@1#2] -- register_copy 
  // select the bank
    // bnkcpy_vram_address::@1
    // for(dword pos=beg; pos<end; pos++)
    // [617] if(bnkcpy_vram_address::pos#2<bnkcpy_vram_address::end#0) goto bnkcpy_vram_address::@2 -- vduz1_lt_vduz2_then_la1 
    lda.z pos+3
    cmp.z end+3
    bcc __b2
    bne !+
    lda.z pos+2
    cmp.z end+2
    bcc __b2
    bne !+
    lda.z pos+1
    cmp.z end+1
    bcc __b2
    bne !+
    lda.z pos
    cmp.z end
    bcc __b2
  !:
    // bnkcpy_vram_address::@return
    // }
    // [618] return 
    rts
    // bnkcpy_vram_address::@2
  __b2:
    // if(addr == 0xC000)
    // [619] if(bnkcpy_vram_address::addr#4!=$c000) goto bnkcpy_vram_address::@3 -- pbuz1_neq_vwuc1_then_la1 
    lda.z addr+1
    cmp #>$c000
    bne __b3
    lda.z addr
    cmp #<$c000
    bne __b3
    // bnkcpy_vram_address::@4
    // cx16_ram_bank(++bank);
    // [620] bnkcpy_vram_address::bank#1 = ++ bnkcpy_vram_address::bank#2 -- vbuxx=_inc_vbuxx 
    inx
    // cx16_ram_bank(++bank)
    // [621] cx16_ram_bank::bank#4 = bnkcpy_vram_address::bank#1 -- vbuaa=vbuxx 
    txa
    // [622] call cx16_ram_bank 
    // [730] phi from bnkcpy_vram_address::@4 to cx16_ram_bank [phi:bnkcpy_vram_address::@4->cx16_ram_bank]
    // [730] phi cx16_ram_bank::bank#5 = cx16_ram_bank::bank#4 [phi:bnkcpy_vram_address::@4->cx16_ram_bank#0] -- register_copy 
    jsr cx16_ram_bank
    // [623] phi from bnkcpy_vram_address::@4 to bnkcpy_vram_address::@3 [phi:bnkcpy_vram_address::@4->bnkcpy_vram_address::@3]
    // [623] phi bnkcpy_vram_address::bank#5 = bnkcpy_vram_address::bank#1 [phi:bnkcpy_vram_address::@4->bnkcpy_vram_address::@3#0] -- register_copy 
    // [623] phi bnkcpy_vram_address::addr#5 = (byte*) 40960 [phi:bnkcpy_vram_address::@4->bnkcpy_vram_address::@3#1] -- pbuz1=pbuc1 
    lda #<$a000
    sta.z addr
    lda #>$a000
    sta.z addr+1
    // [623] phi from bnkcpy_vram_address::@2 to bnkcpy_vram_address::@3 [phi:bnkcpy_vram_address::@2->bnkcpy_vram_address::@3]
    // [623] phi bnkcpy_vram_address::bank#5 = bnkcpy_vram_address::bank#2 [phi:bnkcpy_vram_address::@2->bnkcpy_vram_address::@3#0] -- register_copy 
    // [623] phi bnkcpy_vram_address::addr#5 = bnkcpy_vram_address::addr#4 [phi:bnkcpy_vram_address::@2->bnkcpy_vram_address::@3#1] -- register_copy 
    // bnkcpy_vram_address::@3
  __b3:
    // *VERA_DATA0 = *addr
    // [624] *VERA_DATA0 = *bnkcpy_vram_address::addr#5 -- _deref_pbuc1=_deref_pbuz1 
    ldy #0
    lda (addr),y
    sta VERA_DATA0
    // addr++;
    // [625] bnkcpy_vram_address::addr#2 = ++ bnkcpy_vram_address::addr#5 -- pbuz1=_inc_pbuz1 
    inc.z addr
    bne !+
    inc.z addr+1
  !:
    // for(dword pos=beg; pos<end; pos++)
    // [626] bnkcpy_vram_address::pos#1 = ++ bnkcpy_vram_address::pos#2 -- vduz1=_inc_vduz1 
    inc.z pos
    bne !+
    inc.z pos+1
    bne !+
    inc.z pos+2
    bne !+
    inc.z pos+3
  !:
    jmp __b1
}
  // tile_background
tile_background: {
    .label __3 = $5b
    .label c = $3e
    .label r = $2e
    // [628] phi from tile_background to tile_background::@1 [phi:tile_background->tile_background::@1]
    // [628] phi rand_state#18 = 1 [phi:tile_background->tile_background::@1#0] -- vwuz1=vwuc1 
    lda #<1
    sta.z rand_state
    lda #>1
    sta.z rand_state+1
    // [628] phi tile_background::r#2 = 0 [phi:tile_background->tile_background::@1#1] -- vbuz1=vbuc1 
    sta.z r
    // tile_background::@1
  __b1:
    // for(byte r=0;r<6;r+=1)
    // [629] if(tile_background::r#2<6) goto tile_background::@2 -- vbuz1_lt_vbuc1_then_la1 
    lda.z r
    cmp #6
    bcc __b4
    // tile_background::@return
    // }
    // [630] return 
    rts
    // [631] phi from tile_background::@1 to tile_background::@2 [phi:tile_background::@1->tile_background::@2]
  __b4:
    // [631] phi rand_state#24 = rand_state#18 [phi:tile_background::@1->tile_background::@2#0] -- register_copy 
    // [631] phi tile_background::c#2 = 0 [phi:tile_background::@1->tile_background::@2#1] -- vbuz1=vbuc1 
    lda #0
    sta.z c
    // tile_background::@2
  __b2:
    // for(byte c=0;c<5;c+=1)
    // [632] if(tile_background::c#2<5) goto tile_background::@3 -- vbuz1_lt_vbuc1_then_la1 
    lda.z c
    cmp #5
    bcc __b3
    // tile_background::@4
    // r+=1
    // [633] tile_background::r#1 = tile_background::r#2 + 1 -- vbuz1=vbuz1_plus_1 
    inc.z r
    // [628] phi from tile_background::@4 to tile_background::@1 [phi:tile_background::@4->tile_background::@1]
    // [628] phi rand_state#18 = rand_state#24 [phi:tile_background::@4->tile_background::@1#0] -- register_copy 
    // [628] phi tile_background::r#2 = tile_background::r#1 [phi:tile_background::@4->tile_background::@1#1] -- register_copy 
    jmp __b1
    // [634] phi from tile_background::@2 to tile_background::@3 [phi:tile_background::@2->tile_background::@3]
    // tile_background::@3
  __b3:
    // rand()
    // [635] call rand 
    // [251] phi from tile_background::@3 to rand [phi:tile_background::@3->rand]
    // [251] phi rand_state#13 = rand_state#24 [phi:tile_background::@3->rand#0] -- register_copy 
    jsr rand
    // rand()
    // [636] rand::return#3 = rand::return#0
    // tile_background::@5
    // modr16u(rand(),3,0)
    // [637] modr16u::dividend#2 = rand::return#3
    // [638] call modr16u 
    // [260] phi from tile_background::@5 to modr16u [phi:tile_background::@5->modr16u]
    // [260] phi modr16u::dividend#5 = modr16u::dividend#2 [phi:tile_background::@5->modr16u#0] -- register_copy 
    jsr modr16u
    // modr16u(rand(),3,0)
    // [639] modr16u::return#3 = modr16u::return#0
    // tile_background::@6
    // [640] tile_background::$3 = modr16u::return#3 -- vwuz1=vwuz2 
    lda.z modr16u.return
    sta.z __3
    lda.z modr16u.return+1
    sta.z __3+1
    // rnd = (byte)modr16u(rand(),3,0)
    // [641] tile_background::rnd#0 = (byte)tile_background::$3 -- vbuaa=_byte_vwuz1 
    lda.z __3
    // vera_tile_element( 0, c, r, 3, TileDB[rnd])
    // [642] tile_background::$5 = tile_background::rnd#0 << 1 -- vbuxx=vbuaa_rol_1 
    asl
    tax
    // [643] vera_tile_element::x#2 = tile_background::c#2 -- vbuz1=vbuz2 
    lda.z c
    sta.z vera_tile_element.x
    // [644] vera_tile_element::y#2 = tile_background::r#2 -- vbuz1=vbuz2 
    lda.z r
    sta.z vera_tile_element.y
    // [645] vera_tile_element::Tile#1 = TileDB[tile_background::$5] -- pbuz1=qbuc1_derefidx_vbuxx 
    lda TileDB,x
    sta.z vera_tile_element.Tile
    lda TileDB+1,x
    sta.z vera_tile_element.Tile+1
    // [646] call vera_tile_element 
    // [277] phi from tile_background::@6 to vera_tile_element [phi:tile_background::@6->vera_tile_element]
    // [277] phi vera_tile_element::y#3 = vera_tile_element::y#2 [phi:tile_background::@6->vera_tile_element#0] -- register_copy 
    // [277] phi vera_tile_element::x#3 = vera_tile_element::x#2 [phi:tile_background::@6->vera_tile_element#1] -- register_copy 
    // [277] phi vera_tile_element::Tile#2 = vera_tile_element::Tile#1 [phi:tile_background::@6->vera_tile_element#2] -- register_copy 
    jsr vera_tile_element
    // tile_background::@7
    // c+=1
    // [647] tile_background::c#1 = tile_background::c#2 + 1 -- vbuz1=vbuz1_plus_1 
    inc.z c
    // [631] phi from tile_background::@7 to tile_background::@2 [phi:tile_background::@7->tile_background::@2]
    // [631] phi rand_state#24 = rand_state#14 [phi:tile_background::@7->tile_background::@2#0] -- register_copy 
    // [631] phi tile_background::c#2 = tile_background::c#1 [phi:tile_background::@7->tile_background::@2#1] -- register_copy 
    jmp __b2
}
  // create_sprites_player
create_sprites_player: {
    .label __5 = $5b
    .label __6 = $66
    .label __9 = $5b
    .label __10 = $66
    .label x = $5b
    .label y = $66
    // Copy sprite palette to VRAM
    // Copy 8* sprite attributes to VRAM    
    .label PLAYER_SPRITE_OFFSET = $2f
    .label s = $3f
    // [649] phi from create_sprites_player to create_sprites_player::@1 [phi:create_sprites_player->create_sprites_player::@1]
    // [649] phi create_sprites_player::PLAYER_SPRITE_OFFSET#2 = 0 [phi:create_sprites_player->create_sprites_player::@1#0] -- vwuz1=vwuc1 
    lda #<0
    sta.z PLAYER_SPRITE_OFFSET
    sta.z PLAYER_SPRITE_OFFSET+1
    // [649] phi create_sprites_player::s#2 = 0 [phi:create_sprites_player->create_sprites_player::@1#1] -- vbuz1=vbuc1 
    sta.z s
    // create_sprites_player::@1
  __b1:
    // for(char s=0;s<NUM_PLAYER;s++)
    // [650] if(create_sprites_player::s#2<NUM_PLAYER) goto create_sprites_player::@2 -- vbuz1_lt_vbuc1_then_la1 
    lda.z s
    cmp #NUM_PLAYER
    bcc __b2
    // create_sprites_player::@return
    // }
    // [651] return 
    rts
    // create_sprites_player::@2
  __b2:
    // s&03
    // [652] create_sprites_player::$1 = create_sprites_player::s#2 & 3 -- vbuaa=vbuz1_band_vbuc1 
    lda #3
    and.z s
    // (word)(s&03)<<6
    // [653] create_sprites_player::$9 = (word)create_sprites_player::$1 -- vwuz1=_word_vbuaa 
    sta.z __9
    lda #0
    sta.z __9+1
    // x = ((word)(s&03)<<6)
    // [654] create_sprites_player::x#0 = create_sprites_player::$9 << 6 -- vwuz1=vwuz1_rol_6 
    lda.z x+1
    lsr
    sta.z $ff
    lda.z x
    ror
    sta.z x+1
    lda #0
    ror
    sta.z x
    lsr.z $ff
    ror.z x+1
    ror.z x
    // s>>2
    // [655] create_sprites_player::$3 = create_sprites_player::s#2 >> 2 -- vbuaa=vbuz1_ror_2 
    lda.z s
    lsr
    lsr
    // (word)(s>>2)<<6
    // [656] create_sprites_player::$10 = (word)create_sprites_player::$3 -- vwuz1=_word_vbuaa 
    sta.z __10
    lda #0
    sta.z __10+1
    // y = ((word)(s>>2)<<6)
    // [657] create_sprites_player::y#0 = create_sprites_player::$10 << 6 -- vwuz1=vwuz1_rol_6 
    lda.z y+1
    lsr
    sta.z $ff
    lda.z y
    ror
    sta.z y+1
    lda #0
    ror
    sta.z y
    lsr.z $ff
    ror.z y+1
    ror.z y
    // PlayerSprites[s] = PLAYER_SPRITE_OFFSET
    // [658] create_sprites_player::$8 = create_sprites_player::s#2 << 1 -- vbuaa=vbuz1_rol_1 
    lda.z s
    asl
    // [659] PlayerSprites[create_sprites_player::$8] = create_sprites_player::PLAYER_SPRITE_OFFSET#2 -- pwuc1_derefidx_vbuaa=vwuz1 
    tay
    lda.z PLAYER_SPRITE_OFFSET
    sta PlayerSprites,y
    lda.z PLAYER_SPRITE_OFFSET+1
    sta PlayerSprites+1,y
    // SPRITE_ATTR.ADDR = PLAYER_SPRITE_OFFSET
    // [660] *((word*)&SPRITE_ATTR) = create_sprites_player::PLAYER_SPRITE_OFFSET#2 -- _deref_pwuc1=vwuz1 
    lda.z PLAYER_SPRITE_OFFSET
    sta SPRITE_ATTR
    lda.z PLAYER_SPRITE_OFFSET+1
    sta SPRITE_ATTR+1
    // 40+x
    // [661] create_sprites_player::$5 = $28 + create_sprites_player::x#0 -- vwuz1=vbuc1_plus_vwuz1 
    lda #$28
    clc
    adc.z __5
    sta.z __5
    bcc !+
    inc.z __5+1
  !:
    // SPRITE_ATTR.X = 40+x
    // [662] *((word*)&SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_X) = create_sprites_player::$5 -- _deref_pwuc1=vwuz1 
    lda.z __5
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_X
    lda.z __5+1
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_X+1
    // 100+y
    // [663] create_sprites_player::$6 = $64 + create_sprites_player::y#0 -- vwuz1=vbuc1_plus_vwuz1 
    lda #$64
    clc
    adc.z __6
    sta.z __6
    bcc !+
    inc.z __6+1
  !:
    // SPRITE_ATTR.Y = 100+y
    // [664] *((word*)&SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_Y) = create_sprites_player::$6 -- _deref_pwuc1=vwuz1 
    lda.z __6
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_Y
    lda.z __6+1
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_Y+1
    // SPRITE_ATTR.CTRL2 = VERA_SPRITE_WIDTH_32 | VERA_SPRITE_HEIGHT_32 | 0x1
    // [665] *((byte*)&SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_CTRL2) = VERA_SPRITE_WIDTH_32|VERA_SPRITE_HEIGHT_32|1 -- _deref_pbuc1=vbuc2 
    lda #VERA_SPRITE_WIDTH_32|VERA_SPRITE_HEIGHT_32|1
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_CTRL2
    // vera_sprite_attributes_set(s,SPRITE_ATTR)
    // [666] vera_sprite_attributes_set::sprite#1 = create_sprites_player::s#2 -- vbuxx=vbuz1 
    ldx.z s
    // [667] *(&vera_sprite_attributes_set::sprite_attr) = memcpy(*(&SPRITE_ATTR), struct VERA_SPRITE, SIZEOF_STRUCT_VERA_SPRITE) -- _deref_pssc1=_deref_pssc2_memcpy_vbuc3 
    ldy #SIZEOF_STRUCT_VERA_SPRITE
  !:
    lda SPRITE_ATTR-1,y
    sta vera_sprite_attributes_set.sprite_attr-1,y
    dey
    bne !-
    // [668] call vera_sprite_attributes_set 
    // [699] phi from create_sprites_player::@2 to vera_sprite_attributes_set [phi:create_sprites_player::@2->vera_sprite_attributes_set]
    // [699] phi vera_sprite_attributes_set::sprite#3 = vera_sprite_attributes_set::sprite#1 [phi:create_sprites_player::@2->vera_sprite_attributes_set#0] -- register_copy 
    jsr vera_sprite_attributes_set
    // create_sprites_player::@3
    // PLAYER_SPRITE_OFFSET += 16
    // [669] create_sprites_player::PLAYER_SPRITE_OFFSET#1 = create_sprites_player::PLAYER_SPRITE_OFFSET#2 + $10 -- vwuz1=vwuz1_plus_vbuc1 
    lda #$10
    clc
    adc.z PLAYER_SPRITE_OFFSET
    sta.z PLAYER_SPRITE_OFFSET
    bcc !+
    inc.z PLAYER_SPRITE_OFFSET+1
  !:
    // for(char s=0;s<NUM_PLAYER;s++)
    // [670] create_sprites_player::s#1 = ++ create_sprites_player::s#2 -- vbuz1=_inc_vbuz1 
    inc.z s
    // [649] phi from create_sprites_player::@3 to create_sprites_player::@1 [phi:create_sprites_player::@3->create_sprites_player::@1]
    // [649] phi create_sprites_player::PLAYER_SPRITE_OFFSET#2 = create_sprites_player::PLAYER_SPRITE_OFFSET#1 [phi:create_sprites_player::@3->create_sprites_player::@1#0] -- register_copy 
    // [649] phi create_sprites_player::s#2 = create_sprites_player::s#1 [phi:create_sprites_player::@3->create_sprites_player::@1#1] -- register_copy 
    jmp __b1
}
  // create_sprites_enemy2
create_sprites_enemy2: {
    .label __5 = $64
    .label __6 = $2f
    .label __10 = $64
    .label __11 = $2f
    .label x = $64
    .label y = $2f
    .label ENEMY2_SPRITE_OFFSET = $66
    .label s = $2e
    // [672] phi from create_sprites_enemy2 to create_sprites_enemy2::@1 [phi:create_sprites_enemy2->create_sprites_enemy2::@1]
    // [672] phi create_sprites_enemy2::ENEMY2_SPRITE_OFFSET#2 = <VRAM_ENEMY2/$20 [phi:create_sprites_enemy2->create_sprites_enemy2::@1#0] -- vwuz1=vwuc1 
    lda #<VRAM_ENEMY2/$20&$ffff
    sta.z ENEMY2_SPRITE_OFFSET
    lda #>VRAM_ENEMY2/$20&$ffff
    sta.z ENEMY2_SPRITE_OFFSET+1
    // [672] phi create_sprites_enemy2::s#2 = 0 [phi:create_sprites_enemy2->create_sprites_enemy2::@1#1] -- vbuz1=vbuc1 
    lda #0
    sta.z s
    // create_sprites_enemy2::@1
  __b1:
    // for(char s=0;s<NUM_ENEMY2;s++)
    // [673] if(create_sprites_enemy2::s#2<NUM_ENEMY2) goto create_sprites_enemy2::@2 -- vbuz1_lt_vbuc1_then_la1 
    lda.z s
    cmp #NUM_ENEMY2
    bcc __b2
    // create_sprites_enemy2::@return
    // }
    // [674] return 
    rts
    // create_sprites_enemy2::@2
  __b2:
    // s&03
    // [675] create_sprites_enemy2::$1 = create_sprites_enemy2::s#2 & 3 -- vbuaa=vbuz1_band_vbuc1 
    lda #3
    and.z s
    // (word)(s&03)<<6
    // [676] create_sprites_enemy2::$10 = (word)create_sprites_enemy2::$1 -- vwuz1=_word_vbuaa 
    sta.z __10
    lda #0
    sta.z __10+1
    // x = ((word)(s&03)<<6)
    // [677] create_sprites_enemy2::x#0 = create_sprites_enemy2::$10 << 6 -- vwuz1=vwuz1_rol_6 
    lda.z x+1
    lsr
    sta.z $ff
    lda.z x
    ror
    sta.z x+1
    lda #0
    ror
    sta.z x
    lsr.z $ff
    ror.z x+1
    ror.z x
    // s>>2
    // [678] create_sprites_enemy2::$3 = create_sprites_enemy2::s#2 >> 2 -- vbuaa=vbuz1_ror_2 
    lda.z s
    lsr
    lsr
    // (word)(s>>2)<<6
    // [679] create_sprites_enemy2::$11 = (word)create_sprites_enemy2::$3 -- vwuz1=_word_vbuaa 
    sta.z __11
    lda #0
    sta.z __11+1
    // y = ((word)(s>>2)<<6)
    // [680] create_sprites_enemy2::y#0 = create_sprites_enemy2::$11 << 6 -- vwuz1=vwuz1_rol_6 
    lda.z y+1
    lsr
    sta.z $ff
    lda.z y
    ror
    sta.z y+1
    lda #0
    ror
    sta.z y
    lsr.z $ff
    ror.z y+1
    ror.z y
    // Enemy2Sprites[s] = ENEMY2_SPRITE_OFFSET
    // [681] create_sprites_enemy2::$9 = create_sprites_enemy2::s#2 << 1 -- vbuaa=vbuz1_rol_1 
    lda.z s
    asl
    // [682] Enemy2Sprites[create_sprites_enemy2::$9] = create_sprites_enemy2::ENEMY2_SPRITE_OFFSET#2 -- pwuc1_derefidx_vbuaa=vwuz1 
    tay
    lda.z ENEMY2_SPRITE_OFFSET
    sta Enemy2Sprites,y
    lda.z ENEMY2_SPRITE_OFFSET+1
    sta Enemy2Sprites+1,y
    // SPRITE_ATTR.ADDR = ENEMY2_SPRITE_OFFSET
    // [683] *((word*)&SPRITE_ATTR) = create_sprites_enemy2::ENEMY2_SPRITE_OFFSET#2 -- _deref_pwuc1=vwuz1 
    lda.z ENEMY2_SPRITE_OFFSET
    sta SPRITE_ATTR
    lda.z ENEMY2_SPRITE_OFFSET+1
    sta SPRITE_ATTR+1
    // 340+x
    // [684] create_sprites_enemy2::$5 = $154 + create_sprites_enemy2::x#0 -- vwuz1=vwuc1_plus_vwuz1 
    clc
    lda.z __5
    adc #<$154
    sta.z __5
    lda.z __5+1
    adc #>$154
    sta.z __5+1
    // SPRITE_ATTR.X = 340+x
    // [685] *((word*)&SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_X) = create_sprites_enemy2::$5 -- _deref_pwuc1=vwuz1 
    lda.z __5
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_X
    lda.z __5+1
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_X+1
    // 100+y
    // [686] create_sprites_enemy2::$6 = $64 + create_sprites_enemy2::y#0 -- vwuz1=vbuc1_plus_vwuz1 
    lda #$64
    clc
    adc.z __6
    sta.z __6
    bcc !+
    inc.z __6+1
  !:
    // SPRITE_ATTR.Y = 100+y
    // [687] *((word*)&SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_Y) = create_sprites_enemy2::$6 -- _deref_pwuc1=vwuz1 
    lda.z __6
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_Y
    lda.z __6+1
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_Y+1
    // SPRITE_ATTR.CTRL2 = VERA_SPRITE_WIDTH_32 | VERA_SPRITE_HEIGHT_32 | 0x2
    // [688] *((byte*)&SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_CTRL2) = VERA_SPRITE_WIDTH_32|VERA_SPRITE_HEIGHT_32|2 -- _deref_pbuc1=vbuc2 
    lda #VERA_SPRITE_WIDTH_32|VERA_SPRITE_HEIGHT_32|2
    sta SPRITE_ATTR+OFFSET_STRUCT_VERA_SPRITE_CTRL2
    // vera_sprite_attributes_set(s+16,SPRITE_ATTR)
    // [689] vera_sprite_attributes_set::sprite#2 = create_sprites_enemy2::s#2 + $10 -- vbuxx=vbuz1_plus_vbuc1 
    lda #$10
    clc
    adc.z s
    tax
    // [690] *(&vera_sprite_attributes_set::sprite_attr) = memcpy(*(&SPRITE_ATTR), struct VERA_SPRITE, SIZEOF_STRUCT_VERA_SPRITE) -- _deref_pssc1=_deref_pssc2_memcpy_vbuc3 
    ldy #SIZEOF_STRUCT_VERA_SPRITE
  !:
    lda SPRITE_ATTR-1,y
    sta vera_sprite_attributes_set.sprite_attr-1,y
    dey
    bne !-
    // [691] call vera_sprite_attributes_set 
    // [699] phi from create_sprites_enemy2::@2 to vera_sprite_attributes_set [phi:create_sprites_enemy2::@2->vera_sprite_attributes_set]
    // [699] phi vera_sprite_attributes_set::sprite#3 = vera_sprite_attributes_set::sprite#2 [phi:create_sprites_enemy2::@2->vera_sprite_attributes_set#0] -- register_copy 
    jsr vera_sprite_attributes_set
    // create_sprites_enemy2::@3
    // ENEMY2_SPRITE_OFFSET += 16
    // [692] create_sprites_enemy2::ENEMY2_SPRITE_OFFSET#1 = create_sprites_enemy2::ENEMY2_SPRITE_OFFSET#2 + $10 -- vwuz1=vwuz1_plus_vbuc1 
    lda #$10
    clc
    adc.z ENEMY2_SPRITE_OFFSET
    sta.z ENEMY2_SPRITE_OFFSET
    bcc !+
    inc.z ENEMY2_SPRITE_OFFSET+1
  !:
    // for(char s=0;s<NUM_ENEMY2;s++)
    // [693] create_sprites_enemy2::s#1 = ++ create_sprites_enemy2::s#2 -- vbuz1=_inc_vbuz1 
    inc.z s
    // [672] phi from create_sprites_enemy2::@3 to create_sprites_enemy2::@1 [phi:create_sprites_enemy2::@3->create_sprites_enemy2::@1]
    // [672] phi create_sprites_enemy2::ENEMY2_SPRITE_OFFSET#2 = create_sprites_enemy2::ENEMY2_SPRITE_OFFSET#1 [phi:create_sprites_enemy2::@3->create_sprites_enemy2::@1#0] -- register_copy 
    // [672] phi create_sprites_enemy2::s#2 = create_sprites_enemy2::s#1 [phi:create_sprites_enemy2::@3->create_sprites_enemy2::@1#1] -- register_copy 
    jmp __b1
}
  // fgetc
fgetc: {
    .label ch = $5d
    // ch
    // [694] fgetc::ch = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z ch
    // asm
    // asm { jsrGETIN stach  }
    jsr GETIN
    sta ch
    // return ch;
    // [696] fgetc::return#0 = fgetc::ch -- vbuaa=vbuz1 
    // fgetc::@return
    // }
    // [697] fgetc::return#1 = fgetc::return#0
    // [698] return 
    rts
}
  // vera_sprite_attributes_set
// vera_sprite_attributes_set(byte register(X) sprite, struct VERA_SPRITE zp($69) sprite_attr)
vera_sprite_attributes_set: {
    .label sprite_attr = $69
    .label __0 = $c
    .label __4 = $c
    .label sprite_offset = $c
    // (word)sprite << 3
    // [700] vera_sprite_attributes_set::$4 = (word)vera_sprite_attributes_set::sprite#3 -- vwuz1=_word_vbuxx 
    txa
    sta.z __4
    lda #0
    sta.z __4+1
    // [701] vera_sprite_attributes_set::$0 = vera_sprite_attributes_set::$4 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z __0
    rol.z __0+1
    asl.z __0
    rol.z __0+1
    asl.z __0
    rol.z __0+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [702] vera_sprite_attributes_set::sprite_offset#0 = <VERA_SPRITE_ATTR + vera_sprite_attributes_set::$0 -- vwuz1=vwuc1_plus_vwuz1 
    clc
    lda.z sprite_offset
    adc #<VERA_SPRITE_ATTR&$ffff
    sta.z sprite_offset
    lda.z sprite_offset+1
    adc #>VERA_SPRITE_ATTR&$ffff
    sta.z sprite_offset+1
    // memcpy_to_vram(1, sprite_offset, &sprite_attr, sizeof(sprite_attr))
    // [703] memcpy_to_vram::vdest#0 = (void*)vera_sprite_attributes_set::sprite_offset#0
    // [704] call memcpy_to_vram 
    // The sprite structure is 8 bytes line, so we multiply by 8 to get the offset of the sprite control.
    jsr memcpy_to_vram
    // vera_sprite_attributes_set::@return
    // }
    // [705] return 
    rts
}
  // vera_layer_set_text_color_mode
// Set the configuration of the layer text color mode.
// - layer: Value of 0 or 1.
// - color_mode: Specifies the color mode to be VERA_LAYER_CONFIG_16 or VERA_LAYER_CONFIG_256 for text mode.
vera_layer_set_text_color_mode: {
    .label addr = $4e
    // addr = vera_layer_config[layer]
    // [706] vera_layer_set_text_color_mode::addr#0 = *(vera_layer_config+vera_layer_mode_text::layer#0*SIZEOF_POINTER) -- pbuz1=_deref_qbuc1 
    lda vera_layer_config+vera_layer_mode_text.layer*SIZEOF_POINTER
    sta.z addr
    lda vera_layer_config+vera_layer_mode_text.layer*SIZEOF_POINTER+1
    sta.z addr+1
    // *addr &= ~VERA_LAYER_CONFIG_256C
    // [707] *vera_layer_set_text_color_mode::addr#0 = *vera_layer_set_text_color_mode::addr#0 & ~VERA_LAYER_CONFIG_256C -- _deref_pbuz1=_deref_pbuz1_band_vbuc1 
    lda #VERA_LAYER_CONFIG_256C^$ff
    ldy #0
    and (addr),y
    sta (addr),y
    // *addr |= color_mode
    // [708] *vera_layer_set_text_color_mode::addr#0 = *vera_layer_set_text_color_mode::addr#0 -- _deref_pbuz1=_deref_pbuz1 
    lda (addr),y
    sta (addr),y
    // vera_layer_set_text_color_mode::@return
    // }
    // [709] return 
    rts
}
  // vera_layer_get_mapbase_bank
// Get the map base bank of the tiles for the layer.
// - layer: Value of 0 or 1.
// - return: Bank in vera vram.
vera_layer_get_mapbase_bank: {
    .const layer = 1
    // return vera_mapbase_bank[layer];
    // [710] vera_layer_get_mapbase_bank::return#0 = *(vera_mapbase_bank+vera_layer_get_mapbase_bank::layer#0) -- vbuaa=_deref_pbuc1 
    lda vera_mapbase_bank+layer
    // vera_layer_get_mapbase_bank::@return
    // }
    // [711] return 
    rts
}
  // vera_layer_get_mapbase_offset
// Get the map base lower 16-bit address (offset) of the tiles for the layer.
// - layer: Value of 0 or 1.
// - return: Offset in vera vram of the specified bank.
vera_layer_get_mapbase_offset: {
    .const layer = 1
    .label return = $4e
    // return vera_mapbase_offset[layer];
    // [712] vera_layer_get_mapbase_offset::return#0 = *(vera_mapbase_offset+vera_layer_get_mapbase_offset::layer#0<<1) -- vwuz1=_deref_pwuc1 
    lda vera_mapbase_offset+(layer<<1)
    sta.z return
    lda vera_mapbase_offset+(layer<<1)+1
    sta.z return+1
    // vera_layer_get_mapbase_offset::@return
    // }
    // [713] return 
    rts
}
  // vera_layer_get_rowshift
// Get the bit shift value required to skip a whole line fast.
// - layer: Value of 0 or 1.
// - return: Rowshift value to calculate fast from a y value to line offset in tile mode.
vera_layer_get_rowshift: {
    .const layer = 1
    // return vera_layer_rowshift[layer];
    // [714] vera_layer_get_rowshift::return#0 = *(vera_layer_rowshift+vera_layer_get_rowshift::layer#0) -- vbuaa=_deref_pbuc1 
    lda vera_layer_rowshift+layer
    // vera_layer_get_rowshift::@return
    // }
    // [715] return 
    rts
}
  // vera_layer_get_rowskip
// Get the value required to skip a whole line fast.
// - layer: Value of 0 or 1.
// - return: Skip value to calculate fast from a y value to line offset in tile mode.
vera_layer_get_rowskip: {
    .const layer = 1
    .label return = $4e
    // return vera_layer_rowskip[layer];
    // [716] vera_layer_get_rowskip::return#0 = *(vera_layer_rowskip+vera_layer_get_rowskip::layer#0<<1) -- vwuz1=_deref_pwuc1 
    lda vera_layer_rowskip+(layer<<1)
    sta.z return
    lda vera_layer_rowskip+(layer<<1)+1
    sta.z return+1
    // vera_layer_get_rowskip::@return
    // }
    // [717] return 
    rts
}
  // vera_layer_set_config
// Set the configuration of the layer.
// - layer: Value of 0 or 1.
// - config: Specifies the modes which are specified using T256C / 'Bitmap Mode' / 'Color Depth'.
// vera_layer_set_config(byte register(A) layer, byte register(X) config)
vera_layer_set_config: {
    .label addr = $4e
    // addr = vera_layer_config[layer]
    // [718] vera_layer_set_config::$0 = vera_layer_set_config::layer#0 << 1 -- vbuaa=vbuaa_rol_1 
    asl
    // [719] vera_layer_set_config::addr#0 = vera_layer_config[vera_layer_set_config::$0] -- pbuz1=qbuc1_derefidx_vbuaa 
    tay
    lda vera_layer_config,y
    sta.z addr
    lda vera_layer_config+1,y
    sta.z addr+1
    // *addr = config
    // [720] *vera_layer_set_config::addr#0 = vera_layer_set_config::config#0 -- _deref_pbuz1=vbuxx 
    txa
    ldy #0
    sta (addr),y
    // vera_layer_set_config::@return
    // }
    // [721] return 
    rts
}
  // vera_layer_set_tilebase
// Set the base of the tiles for the layer with which the conio will interact.
// - layer: Value of 0 or 1.
// - tilebase: Specifies the base address of the tile map.
//   Note that the register only specifies bits 16:11 of the address,
//   so the resulting address in the VERA VRAM is always aligned to a multiple of 2048 bytes!
// vera_layer_set_tilebase(byte register(A) layer, byte register(X) tilebase)
vera_layer_set_tilebase: {
    .label addr = $4e
    // addr = vera_layer_tilebase[layer]
    // [722] vera_layer_set_tilebase::$0 = vera_layer_set_tilebase::layer#0 << 1 -- vbuaa=vbuaa_rol_1 
    asl
    // [723] vera_layer_set_tilebase::addr#0 = vera_layer_tilebase[vera_layer_set_tilebase::$0] -- pbuz1=qbuc1_derefidx_vbuaa 
    tay
    lda vera_layer_tilebase,y
    sta.z addr
    lda vera_layer_tilebase+1,y
    sta.z addr+1
    // *addr = tilebase
    // [724] *vera_layer_set_tilebase::addr#0 = vera_layer_set_tilebase::tilebase#0 -- _deref_pbuz1=vbuxx 
    txa
    ldy #0
    sta (addr),y
    // vera_layer_set_tilebase::@return
    // }
    // [725] return 
    rts
}
  // vera_layer_get_backcolor
// Get the back color for text output. The old back text color setting is returned.
// - layer: Value of 0 or 1.
// - return: a 4 bit value ( decimal between 0 and 15).
//   This will only work when the VERA is in 16 color mode!
//   Note that on the VERA, the transparent color has value 0.
// vera_layer_get_backcolor(byte register(X) layer)
vera_layer_get_backcolor: {
    // return vera_layer_backcolor[layer];
    // [726] vera_layer_get_backcolor::return#0 = vera_layer_backcolor[vera_layer_get_backcolor::layer#0] -- vbuaa=pbuc1_derefidx_vbuxx 
    lda vera_layer_backcolor,x
    // vera_layer_get_backcolor::@return
    // }
    // [727] return 
    rts
}
  // vera_layer_get_textcolor
// Get the front color for text output. The old front text color setting is returned.
// - layer: Value of 0 or 1.
// - return: a 4 bit value ( decimal between 0 and 15).
//   This will only work when the VERA is in 16 color mode!
//   Note that on the VERA, the transparent color has value 0.
// vera_layer_get_textcolor(byte register(X) layer)
vera_layer_get_textcolor: {
    // return vera_layer_textcolor[layer];
    // [728] vera_layer_get_textcolor::return#0 = vera_layer_textcolor[vera_layer_get_textcolor::layer#0] -- vbuaa=pbuc1_derefidx_vbuxx 
    lda vera_layer_textcolor,x
    // vera_layer_get_textcolor::@return
    // }
    // [729] return 
    rts
}
  // cx16_ram_bank
// Configure the bank of a banked ram.
// cx16_ram_bank(byte register(A) bank)
cx16_ram_bank: {
    // VIA1->PORT_A = bank
    // [731] *((byte*)VIA1+OFFSET_STRUCT_MOS6522_VIA_PORT_A) = cx16_ram_bank::bank#5 -- _deref_pbuc1=vbuaa 
    sta VIA1+OFFSET_STRUCT_MOS6522_VIA_PORT_A
    // cx16_ram_bank::@return
    // }
    // [732] return 
    rts
}
  // cbm_k_setnam
/*
B-30. Function Name: SETNAM

  Purpose: Set file name
  Call address: $FFBD (hex) 65469 (decimal)
  Communication registers: A, X, Y
  Preparatory routines:
  Stack requirements: 2
  Registers affected:

  Description: This routine is used to set up the file name for the OPEN,
SAVE, or LOAD routines. The accumulator must be loaded with the length of
the file name. The X and Y registers must be loaded with the address of
the file name, in standard 6502 low-byte/high-byte format. The address
can be any valid memory address in the system where a string of
characters for the file name is stored. If no file name is desired, the
accumulator must be set to 0, representing a zero file length. The X and
Y registers can be set to any memory address in that case.

How to Use:

  1) Load the accumulator with the length of the file name.
  2) Load the X index register with the low order address of the file
     name.
  3) Load the Y index register with the high order address.
  4) Call this routine.

EXAMPLE:

  LDA #NAME2-NAME     ;LOAD LENGTH OF FILE NAME
  LDX #<NAME          ;LOAD ADDRESS OF FILE NAME
  LDY #>NAME
  JSR SETNAM
*/
// cbm_k_setnam(byte* zp($54) filename)
cbm_k_setnam: {
    .label filename = $54
    .label filename_len = $5e
    .label __0 = $64
    // strlen(filename)
    // [733] strlen::str#1 = cbm_k_setnam::filename -- pbuz1=pbuz2 
    lda.z filename
    sta.z strlen.str
    lda.z filename+1
    sta.z strlen.str+1
    // [734] call strlen 
    // [849] phi from cbm_k_setnam to strlen [phi:cbm_k_setnam->strlen]
    jsr strlen
    // strlen(filename)
    // [735] strlen::return#2 = strlen::len#2
    // cbm_k_setnam::@1
    // [736] cbm_k_setnam::$0 = strlen::return#2
    // filename_len = (char)strlen(filename)
    // [737] cbm_k_setnam::filename_len = (byte)cbm_k_setnam::$0 -- vbuz1=_byte_vwuz2 
    lda.z __0
    sta.z filename_len
    // asm
    // asm { ldafilename_len ldxfilename ldyfilename+1 jsrCBM_SETNAM  }
    ldx filename
    ldy filename+1
    jsr CBM_SETNAM
    // cbm_k_setnam::@return
    // }
    // [739] return 
    rts
}
  // cbm_k_setlfs
/*
B-28. Function Name: SETLFS

  Purpose: Set up a logical file
  Call address: $FFBA (hex) 65466 (decimal)
  Communication registers: A, X, Y
  Preparatory routines: None
  Error returns: None
  Stack requirements: 2
  Registers affected: None


  Description: This routine sets the logical file number, device address,
and secondary address (command number) for other KERNAL routines.
  The logical file number is used by the system as a key to the file
table created by the OPEN file routine. Device addresses can range from 0
to 31. The following codes are used by the Commodore 64 to stand for the
CBM devices listed below:


                ADDRESS          DEVICE

                   0            Keyboard
                   1            Datassette(TM)
                   2            RS-232C device
                   3            CRT display
                   4            Serial bus printer
                   8            CBM serial bus disk drive


  Device numbers 4 or greater automatically refer to devices on the
serial bus.
  A command to the device is sent as a secondary address on the serial
bus after the device number is sent during the serial attention
handshaking sequence. If no secondary address is to be sent, the Y index
register should be set to 255.

How to Use:

  1) Load the accumulator with the logical file number.
  2) Load the X index register with the device number.
  3) Load the Y index register with the command.

EXAMPLE:

  FOR LOGICAL FILE 32, DEVICE #4, AND NO COMMAND:
  LDA #32
  LDX #4
  LDY #255
  JSR SETLFS
*/
// cbm_k_setlfs(byte zp($56) channel, byte zp($57) device, byte zp($58) secondary)
cbm_k_setlfs: {
    .label channel = $56
    .label device = $57
    .label secondary = $58
    // asm
    // asm { ldxdevice ldachannel ldysecondary jsrCBM_SETLFS  }
    ldx device
    lda channel
    ldy secondary
    jsr CBM_SETLFS
    // cbm_k_setlfs::@return
    // }
    // [741] return 
    rts
}
  // cbm_k_open
/*
B-18. Function Name: OPEN

  Purpose: Open a logical file
  Call address: $FFC0 (hex) 65472 (decimal)
  Communication registers: None
  Preparatory routines: SETLFS, SETNAM
  Error returns: 1,2,4,5,6,240, READST
  Stack requirements: None
  Registers affected: A, X, Y

  Description: This routine is used to OPEN a logical file. Once the
logical file is set up, it can be used for input/output operations. Most
of the I/O KERNAL routines call on this routine to create the logical
files to operate on. No arguments need to be set up to use this routine,
but both the SETLFS and SETNAM KERNAL routines must be called before
using this routine.

How to Use:

  0) Use the SETLFS routine.
  1) Use the SETNAM routine.
  2) Call this routine.
*/
cbm_k_open: {
    .label status = $5f
    // status
    // [742] cbm_k_open::status = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z status
    // asm
    // asm { jsrCBM_OPEN bcs!error+ lda#$ff !error: stastatus  }
    jsr CBM_OPEN
    bcs !error+
    lda #$ff
  !error:
    sta status
    // return status;
    // [744] cbm_k_open::return#0 = cbm_k_open::status -- vbuaa=vbuz1 
    // cbm_k_open::@return
    // }
    // [745] cbm_k_open::return#1 = cbm_k_open::return#0
    // [746] return 
    rts
}
  // cbm_k_chkin
/*
B-2. Function Name: CHKIN

  Purpose: Open a channel for input
  Call address: $FFC6 (hex) 65478 (decimal)
  Communication registers: X
  Preparatory routines: (OPEN)
  Error returns:
  Stack requirements: None
  Registers affected: A, X

  Description: Any logical file that has already been opened by the
KERNAL OPEN routine can be defined as an input channel by this routine.
Naturally, the device on the channel must be an input device. Otherwise
an error will occur, and the routine will abort.
  If you are getting data from anywhere other than the keyboard, this
routine must be called before using either the CHRIN or the GETIN KERNAL
routines for data input. If you want to use the input from the keyboard,
and no other input channels are opened, then the calls to this routine,
and to the OPEN routine are not needed.
  When this routine is used with a device on the serial bus, it auto-
matically sends the talk address (and the secondary address if one was
specified by the OPEN routine) over the bus.

How to Use:

  0) OPEN the logical file (if necessary; see description above).
  1) Load the X register with number of the logical file to be used.
  2) Call this routine (using a JSR command).

Possible errors are:

  #3: File not open
  #5: Device not present
  #6: File not an input file
*/
// cbm_k_chkin(byte zp($59) channel)
cbm_k_chkin: {
    .label channel = $59
    .label status = $60
    // status
    // [747] cbm_k_chkin::status = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z status
    // asm
    // asm { ldxchannel jsrCBM_CHKIN bcs!error+ lda#$ff !error: stastatus  }
    ldx channel
    jsr CBM_CHKIN
    bcs !error+
    lda #$ff
  !error:
    sta status
    // return status;
    // [749] cbm_k_chkin::return#0 = cbm_k_chkin::status -- vbuaa=vbuz1 
    // cbm_k_chkin::@return
    // }
    // [750] cbm_k_chkin::return#1 = cbm_k_chkin::return#0
    // [751] return 
    rts
}
  // cbm_k_chrin
/*
B-4. Function Name: CHRIN

  Purpose: Get a character from the input channel
  Call address: $FFCF (hex) 65487 (decimal)
  Communication registers: A
  Preparatory routines: (OPEN, CHKIN)
  Error returns: 0 (See READST)
  Stack requirements: 7+
  Registers affected: A, X

  Description: This routine gets a byte of data from a channel already
set up as the input channel by the KERNAL routine CHKIN. If the CHKIN has
NOT been used to define another input channel, then all your data is
expected from the keyboard. The data byte is returned in the accumulator.
The channel remains open after the call.
  Input from the keyboard is handled in a special way. First, the cursor
is turned on, and blinks until a carriage return is typed on the
keyboard. All characters on the line (up to 88 characters) are stored in
the BASIC input buffer. These characters can be retrieved one at a time
by calling this routine once for each character. When the carriage return
is retrieved, the entire line has been processed. The next time this
routine is called, the whole process begins again, i.e., by flashing the
cursor.

How to Use:

FROM THE KEYBOARD

  1) Retrieve a byte of data by calling this routine.
  2) Store the data byte.
  3) Check if it is the last data byte (is it a CR?)
  4) If not, go to step 1.

FROM OTHER DEVICES

  0) Use the KERNAL OPEN and CHKIN routines.
  1) Call this routine (using a JSR instruction).
  2) Store the data.
*/
cbm_k_chrin: {
    .label value = $61
    // value
    // [752] cbm_k_chrin::value = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z value
    // asm
    // asm { jsrCBM_CHRIN stavalue  }
    jsr CBM_CHRIN
    sta value
    // return value;
    // [754] cbm_k_chrin::return#0 = cbm_k_chrin::value -- vbuaa=vbuz1 
    // cbm_k_chrin::@return
    // }
    // [755] cbm_k_chrin::return#1 = cbm_k_chrin::return#0
    // [756] return 
    rts
}
  // cbm_k_readst
/*
B-22. Function Name: READST

  Purpose: Read status word
  Call address: $FFB7 (hex) 65463 (decimal)
  Communication registers: A
  Preparatory routines: None
  Error returns: None
  Stack requirements: 2
  Registers affected: A

  Description: This routine returns the current status of the I/O devices
in the accumulator. The routine is usually called after new communication
to an I/O device. The routine gives you information about device status,
or errors that have occurred during the I/O operation.
  The bits returned in the accumulator contain the following information:
(see table below)

+---------+------------+---------------+------------+-------------------+
|  ST Bit | ST Numeric |    Cassette   |   Serial   |    Tape Verify    |
| Position|    Value   |      Read     |  Bus R/W   |      + Load       |
+---------+------------+---------------+------------+-------------------+
|    0    |      1     |               |  time out  |                   |
|         |            |               |  write     |                   |
+---------+------------+---------------+------------+-------------------+
|    1    |      2     |               |  time out  |                   |
|         |            |               |    read    |                   |
+---------+------------+---------------+------------+-------------------+
|    2    |      4     |  short block  |            |    short block    |
+---------+------------+---------------+------------+-------------------+
|    3    |      8     |   long block  |            |    long block     |
+---------+------------+---------------+------------+-------------------+
|    4    |     16     | unrecoverable |            |   any mismatch    |
|         |            |   read error  |            |                   |
+---------+------------+---------------+------------+-------------------+
|    5    |     32     |    checksum   |            |     checksum      |
|         |            |     error     |            |       error       |
+---------+------------+---------------+------------+-------------------+
|    6    |     64     |  end of file  |  EOI line  |                   |
+---------+------------+---------------+------------+-------------------+
|    7    |   -128     |  end of tape  | device not |    end of tape    |
|         |            |               |   present  |                   |
+---------+------------+---------------+------------+-------------------+

How to Use:

  1) Call this routine.
  2) Decode the information in the A register as it refers to your pro-
     gram.
*/
cbm_k_readst: {
    .label status = $62
    // status
    // [757] cbm_k_readst::status = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z status
    // asm
    // asm { jsrCBM_READST stastatus  }
    jsr CBM_READST
    sta status
    // return status;
    // [759] cbm_k_readst::return#0 = cbm_k_readst::status -- vbuaa=vbuz1 
    // cbm_k_readst::@return
    // }
    // [760] cbm_k_readst::return#1 = cbm_k_readst::return#0
    // [761] return 
    rts
}
  // cbm_k_close
/*
B-9. Function Name: CLOSE

  Purpose: Close a logical file
  Call address: $FFC3 (hex) 65475 (decimal)
  Communication registers: A
  Preparatory routines: None
  Error returns: 0,240 (See READST)
  Stack requirements: 2+
  Registers affected: A, X, Y

  Description: This routine is used to close a logical file after all I/O
operations have been completed on that file. This routine is called after
the accumulator is loaded with the logical file number to be closed (the
same number used when the file was opened using the OPEN routine).

How to Use:

  1) Load the accumulator with the number of the logical file to be
     closed.
  2) Call this routine.
*/
// cbm_k_close(byte zp($5a) channel)
cbm_k_close: {
    .label channel = $5a
    .label status = $63
    // status
    // [762] cbm_k_close::status = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z status
    // asm
    // asm { ldachannel jsrCBM_CLOSE bcs!error+ lda#$ff !error: stastatus  }
    lda channel
    jsr CBM_CLOSE
    bcs !error+
    lda #$ff
  !error:
    sta status
    // return status;
    // [764] cbm_k_close::return#0 = cbm_k_close::status -- vbuaa=vbuz1 
    // cbm_k_close::@return
    // }
    // [765] cbm_k_close::return#1 = cbm_k_close::return#0
    // [766] return 
    rts
}
  // cbm_k_clrchn
/*
B-10. Function Name: CLRCHN

  Purpose: Clear I/O channels
  Call address: $FFCC (hex) 65484 (decimal)
  Communication registers: None
  Preparatory routines: None
  Error returns:
  Stack requirements: 9
  Registers affected: A, X

  Description: This routine is called to clear all open channels and re-
store the I/O channels to their original default values. It is usually
called after opening other I/O channels (like a tape or disk drive) and
using them for input/output operations. The default input device is 0
(keyboard). The default output device is 3 (the Commodore 64 screen).
  If one of the channels to be closed is to the serial port, an UNTALK
signal is sent first to clear the input channel or an UNLISTEN is sent to
clear the output channel. By not calling this routine (and leaving lis-
tener(s) active on the serial bus) several devices can receive the same
data from the Commodore 64 at the same time. One way to take advantage
of this would be to command the printer to TALK and the disk to LISTEN.
This would allow direct printing of a disk file.
  This routine is automatically called when the KERNAL CLALL routine is
executed.

How to Use:
  1) Call this routine using the JSR instruction.
*/
cbm_k_clrchn: {
    // asm
    // asm { jsrCBM_CLRCHN  }
    jsr CBM_CLRCHN
    // cbm_k_clrchn::@return
    // }
    // [768] return 
    rts
}
  // cputc
// Output one character at the current cursor position
// Moves the cursor forward. Scrolls the entire screen if needed
// cputc(byte zp($2e) c)
cputc: {
    .label __16 = $64
    .label conio_screen_text = $64
    .label conio_map_width = $2f
    .label conio_addr = $64
    .label c = $2e
    // vera_layer_get_color(cx16_conio.conio_screen_layer)
    // [770] vera_layer_get_color::layer#0 = *((byte*)&cx16_conio) -- vbuxx=_deref_pbuc1 
    ldx cx16_conio
    // [771] call vera_layer_get_color 
    // [855] phi from cputc to vera_layer_get_color [phi:cputc->vera_layer_get_color]
    // [855] phi vera_layer_get_color::layer#2 = vera_layer_get_color::layer#0 [phi:cputc->vera_layer_get_color#0] -- register_copy 
    jsr vera_layer_get_color
    // vera_layer_get_color(cx16_conio.conio_screen_layer)
    // [772] vera_layer_get_color::return#3 = vera_layer_get_color::return#2
    // cputc::@7
    // color = vera_layer_get_color(cx16_conio.conio_screen_layer)
    // [773] cputc::color#0 = vera_layer_get_color::return#3 -- vbuxx=vbuaa 
    tax
    // conio_screen_text = cx16_conio.conio_screen_text
    // [774] cputc::conio_screen_text#0 = *((byte**)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT) -- pbuz1=_deref_qbuc1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT
    sta.z conio_screen_text
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT+1
    sta.z conio_screen_text+1
    // conio_map_width = cx16_conio.conio_map_width
    // [775] cputc::conio_map_width#0 = *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH) -- vwuz1=_deref_pwuc1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH
    sta.z conio_map_width
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH+1
    sta.z conio_map_width+1
    // conio_screen_text + conio_line_text[cx16_conio.conio_screen_layer]
    // [776] cputc::$15 = *((byte*)&cx16_conio) << 1 -- vbuaa=_deref_pbuc1_rol_1 
    lda cx16_conio
    asl
    // conio_addr = conio_screen_text + conio_line_text[cx16_conio.conio_screen_layer]
    // [777] cputc::conio_addr#0 = cputc::conio_screen_text#0 + conio_line_text[cputc::$15] -- pbuz1=pbuz1_plus_pwuc1_derefidx_vbuaa 
    tay
    clc
    lda.z conio_addr
    adc conio_line_text,y
    sta.z conio_addr
    lda.z conio_addr+1
    adc conio_line_text+1,y
    sta.z conio_addr+1
    // conio_cursor_x[cx16_conio.conio_screen_layer] << 1
    // [778] cputc::$2 = conio_cursor_x[*((byte*)&cx16_conio)] << 1 -- vbuaa=pbuc1_derefidx_(_deref_pbuc2)_rol_1 
    ldy cx16_conio
    lda conio_cursor_x,y
    asl
    // conio_addr += conio_cursor_x[cx16_conio.conio_screen_layer] << 1
    // [779] cputc::conio_addr#1 = cputc::conio_addr#0 + cputc::$2 -- pbuz1=pbuz1_plus_vbuaa 
    clc
    adc.z conio_addr
    sta.z conio_addr
    bcc !+
    inc.z conio_addr+1
  !:
    // if(c=='\n')
    // [780] if(cputc::c#3==' ') goto cputc::@1 -- vbuz1_eq_vbuc1_then_la1 
    lda #'\n'
    cmp.z c
    beq __b1
    // cputc::@2
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [781] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    // Select DATA0
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <conio_addr
    // [782] cputc::$4 = < cputc::conio_addr#1 -- vbuaa=_lo_pbuz1 
    lda.z conio_addr
    // *VERA_ADDRX_L = <conio_addr
    // [783] *VERA_ADDRX_L = cputc::$4 -- _deref_pbuc1=vbuaa 
    // Set address
    sta VERA_ADDRX_L
    // >conio_addr
    // [784] cputc::$5 = > cputc::conio_addr#1 -- vbuaa=_hi_pbuz1 
    lda.z conio_addr+1
    // *VERA_ADDRX_M = >conio_addr
    // [785] *VERA_ADDRX_M = cputc::$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // cx16_conio.conio_screen_bank | VERA_INC_1
    // [786] cputc::$6 = *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK) | VERA_INC_1 -- vbuaa=_deref_pbuc1_bor_vbuc2 
    lda #VERA_INC_1
    ora cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK
    // *VERA_ADDRX_H = cx16_conio.conio_screen_bank | VERA_INC_1
    // [787] *VERA_ADDRX_H = cputc::$6 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_H
    // *VERA_DATA0 = c
    // [788] *VERA_DATA0 = cputc::c#3 -- _deref_pbuc1=vbuz1 
    lda.z c
    sta VERA_DATA0
    // *VERA_DATA0 = color
    // [789] *VERA_DATA0 = cputc::color#0 -- _deref_pbuc1=vbuxx 
    stx VERA_DATA0
    // conio_cursor_x[cx16_conio.conio_screen_layer]++;
    // [790] conio_cursor_x[*((byte*)&cx16_conio)] = ++ conio_cursor_x[*((byte*)&cx16_conio)] -- pbuc1_derefidx_(_deref_pbuc2)=_inc_pbuc1_derefidx_(_deref_pbuc2) 
    ldx cx16_conio
    ldy cx16_conio
    lda conio_cursor_x,x
    inc
    sta conio_cursor_x,y
    // scroll_enable = conio_scroll_enable[cx16_conio.conio_screen_layer]
    // [791] cputc::scroll_enable#0 = conio_scroll_enable[*((byte*)&cx16_conio)] -- vbuaa=pbuc1_derefidx_(_deref_pbuc2) 
    lda conio_scroll_enable,y
    // if(scroll_enable)
    // [792] if(0!=cputc::scroll_enable#0) goto cputc::@5 -- 0_neq_vbuaa_then_la1 
    cmp #0
    bne __b5
    // cputc::@3
    // (unsigned int)conio_cursor_x[cx16_conio.conio_screen_layer] == conio_map_width
    // [793] cputc::$16 = (word)conio_cursor_x[*((byte*)&cx16_conio)] -- vwuz1=_word_pbuc1_derefidx_(_deref_pbuc2) 
    lda conio_cursor_x,y
    sta.z __16
    lda #0
    sta.z __16+1
    // if((unsigned int)conio_cursor_x[cx16_conio.conio_screen_layer] == conio_map_width)
    // [794] if(cputc::$16!=cputc::conio_map_width#0) goto cputc::@return -- vwuz1_neq_vwuz2_then_la1 
    cmp.z conio_map_width+1
    bne __breturn
    lda.z __16
    cmp.z conio_map_width
    bne __breturn
    // [795] phi from cputc::@3 to cputc::@4 [phi:cputc::@3->cputc::@4]
    // cputc::@4
    // cputln()
    // [796] call cputln 
    jsr cputln
    // cputc::@return
  __breturn:
    // }
    // [797] return 
    rts
    // cputc::@5
  __b5:
    // if(conio_cursor_x[cx16_conio.conio_screen_layer] == cx16_conio.conio_screen_width)
    // [798] if(conio_cursor_x[*((byte*)&cx16_conio)]!=*((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH)) goto cputc::@return -- pbuc1_derefidx_(_deref_pbuc2)_neq__deref_pbuc3_then_la1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH
    ldy cx16_conio
    cmp conio_cursor_x,y
    bne __breturn
    // [799] phi from cputc::@5 to cputc::@6 [phi:cputc::@5->cputc::@6]
    // cputc::@6
    // cputln()
    // [800] call cputln 
    jsr cputln
    rts
    // [801] phi from cputc::@7 to cputc::@1 [phi:cputc::@7->cputc::@1]
    // cputc::@1
  __b1:
    // cputln()
    // [802] call cputln 
    jsr cputln
    rts
}
  // uctoa
// Converts unsigned number value to a string representing it in RADIX format.
// If the leading digits are zero they are not included in the string.
// - value : The number to be converted to RADIX
// - buffer : receives the string representing the number and zero-termination.
// - radix : The radix to convert the number to (from the enum RADIX)
// uctoa(byte register(X) value, byte* zp($2f) buffer, byte register(Y) radix)
uctoa: {
    .label buffer = $2f
    .label digit = $3f
    .label started = $40
    .label max_digits = $3e
    .label digit_values = $66
    // if(radix==DECIMAL)
    // [803] if(uctoa::radix#0==DECIMAL) goto uctoa::@1 -- vbuyy_eq_vbuc1_then_la1 
    cpy #DECIMAL
    beq __b2
    // uctoa::@2
    // if(radix==HEXADECIMAL)
    // [804] if(uctoa::radix#0==HEXADECIMAL) goto uctoa::@1 -- vbuyy_eq_vbuc1_then_la1 
    cpy #HEXADECIMAL
    beq __b3
    // uctoa::@3
    // if(radix==OCTAL)
    // [805] if(uctoa::radix#0==OCTAL) goto uctoa::@1 -- vbuyy_eq_vbuc1_then_la1 
    cpy #OCTAL
    beq __b4
    // uctoa::@4
    // if(radix==BINARY)
    // [806] if(uctoa::radix#0==BINARY) goto uctoa::@1 -- vbuyy_eq_vbuc1_then_la1 
    cpy #BINARY
    beq __b5
    // uctoa::@5
    // *buffer++ = 'e'
    // [807] *((byte*)&printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS) = 'e' -- _deref_pbuc1=vbuc2 
    // Unknown radix
    lda #'e'
    sta printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS
    // *buffer++ = 'r'
    // [808] *((byte*)&printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS+1) = 'r' -- _deref_pbuc1=vbuc2 
    lda #'r'
    sta printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS+1
    // [809] *((byte*)&printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS+2) = 'r' -- _deref_pbuc1=vbuc2 
    sta printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS+2
    // *buffer = 0
    // [810] *((byte*)&printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS+3) = 0 -- _deref_pbuc1=vbuc2 
    lda #0
    sta printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS+3
    // uctoa::@return
    // }
    // [811] return 
    rts
    // [812] phi from uctoa to uctoa::@1 [phi:uctoa->uctoa::@1]
  __b2:
    // [812] phi uctoa::digit_values#8 = RADIX_DECIMAL_VALUES_CHAR [phi:uctoa->uctoa::@1#0] -- pbuz1=pbuc1 
    lda #<RADIX_DECIMAL_VALUES_CHAR
    sta.z digit_values
    lda #>RADIX_DECIMAL_VALUES_CHAR
    sta.z digit_values+1
    // [812] phi uctoa::max_digits#7 = 3 [phi:uctoa->uctoa::@1#1] -- vbuz1=vbuc1 
    lda #3
    sta.z max_digits
    jmp __b1
    // [812] phi from uctoa::@2 to uctoa::@1 [phi:uctoa::@2->uctoa::@1]
  __b3:
    // [812] phi uctoa::digit_values#8 = RADIX_HEXADECIMAL_VALUES_CHAR [phi:uctoa::@2->uctoa::@1#0] -- pbuz1=pbuc1 
    lda #<RADIX_HEXADECIMAL_VALUES_CHAR
    sta.z digit_values
    lda #>RADIX_HEXADECIMAL_VALUES_CHAR
    sta.z digit_values+1
    // [812] phi uctoa::max_digits#7 = 2 [phi:uctoa::@2->uctoa::@1#1] -- vbuz1=vbuc1 
    lda #2
    sta.z max_digits
    jmp __b1
    // [812] phi from uctoa::@3 to uctoa::@1 [phi:uctoa::@3->uctoa::@1]
  __b4:
    // [812] phi uctoa::digit_values#8 = RADIX_OCTAL_VALUES_CHAR [phi:uctoa::@3->uctoa::@1#0] -- pbuz1=pbuc1 
    lda #<RADIX_OCTAL_VALUES_CHAR
    sta.z digit_values
    lda #>RADIX_OCTAL_VALUES_CHAR
    sta.z digit_values+1
    // [812] phi uctoa::max_digits#7 = 3 [phi:uctoa::@3->uctoa::@1#1] -- vbuz1=vbuc1 
    lda #3
    sta.z max_digits
    jmp __b1
    // [812] phi from uctoa::@4 to uctoa::@1 [phi:uctoa::@4->uctoa::@1]
  __b5:
    // [812] phi uctoa::digit_values#8 = RADIX_BINARY_VALUES_CHAR [phi:uctoa::@4->uctoa::@1#0] -- pbuz1=pbuc1 
    lda #<RADIX_BINARY_VALUES_CHAR
    sta.z digit_values
    lda #>RADIX_BINARY_VALUES_CHAR
    sta.z digit_values+1
    // [812] phi uctoa::max_digits#7 = 8 [phi:uctoa::@4->uctoa::@1#1] -- vbuz1=vbuc1 
    lda #8
    sta.z max_digits
    // uctoa::@1
  __b1:
    // [813] phi from uctoa::@1 to uctoa::@6 [phi:uctoa::@1->uctoa::@6]
    // [813] phi uctoa::buffer#11 = (byte*)&printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS [phi:uctoa::@1->uctoa::@6#0] -- pbuz1=pbuc1 
    lda #<printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS
    sta.z buffer
    lda #>printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS
    sta.z buffer+1
    // [813] phi uctoa::started#2 = 0 [phi:uctoa::@1->uctoa::@6#1] -- vbuz1=vbuc1 
    lda #0
    sta.z started
    // [813] phi uctoa::value#2 = uctoa::value#1 [phi:uctoa::@1->uctoa::@6#2] -- register_copy 
    // [813] phi uctoa::digit#2 = 0 [phi:uctoa::@1->uctoa::@6#3] -- vbuz1=vbuc1 
    sta.z digit
    // uctoa::@6
  __b6:
    // max_digits-1
    // [814] uctoa::$4 = uctoa::max_digits#7 - 1 -- vbuaa=vbuz1_minus_1 
    lda.z max_digits
    sec
    sbc #1
    // for( char digit=0; digit<max_digits-1; digit++ )
    // [815] if(uctoa::digit#2<uctoa::$4) goto uctoa::@7 -- vbuz1_lt_vbuaa_then_la1 
    cmp.z digit
    beq !+
    bcs __b7
  !:
    // uctoa::@8
    // *buffer++ = DIGITS[(char)value]
    // [816] *uctoa::buffer#11 = DIGITS[uctoa::value#2] -- _deref_pbuz1=pbuc1_derefidx_vbuxx 
    lda DIGITS,x
    ldy #0
    sta (buffer),y
    // *buffer++ = DIGITS[(char)value];
    // [817] uctoa::buffer#3 = ++ uctoa::buffer#11 -- pbuz1=_inc_pbuz1 
    inc.z buffer
    bne !+
    inc.z buffer+1
  !:
    // *buffer = 0
    // [818] *uctoa::buffer#3 = 0 -- _deref_pbuz1=vbuc1 
    lda #0
    tay
    sta (buffer),y
    rts
    // uctoa::@7
  __b7:
    // digit_value = digit_values[digit]
    // [819] uctoa::digit_value#0 = uctoa::digit_values#8[uctoa::digit#2] -- vbuyy=pbuz1_derefidx_vbuz2 
    ldy.z digit
    lda (digit_values),y
    tay
    // if (started || value >= digit_value)
    // [820] if(0!=uctoa::started#2) goto uctoa::@10 -- 0_neq_vbuz1_then_la1 
    lda.z started
    cmp #0
    bne __b10
    // uctoa::@12
    // [821] if(uctoa::value#2>=uctoa::digit_value#0) goto uctoa::@10 -- vbuxx_ge_vbuyy_then_la1 
    sty.z $ff
    cpx.z $ff
    bcs __b10
    // [822] phi from uctoa::@12 to uctoa::@9 [phi:uctoa::@12->uctoa::@9]
    // [822] phi uctoa::buffer#14 = uctoa::buffer#11 [phi:uctoa::@12->uctoa::@9#0] -- register_copy 
    // [822] phi uctoa::started#4 = uctoa::started#2 [phi:uctoa::@12->uctoa::@9#1] -- register_copy 
    // [822] phi uctoa::value#6 = uctoa::value#2 [phi:uctoa::@12->uctoa::@9#2] -- register_copy 
    // uctoa::@9
  __b9:
    // for( char digit=0; digit<max_digits-1; digit++ )
    // [823] uctoa::digit#1 = ++ uctoa::digit#2 -- vbuz1=_inc_vbuz1 
    inc.z digit
    // [813] phi from uctoa::@9 to uctoa::@6 [phi:uctoa::@9->uctoa::@6]
    // [813] phi uctoa::buffer#11 = uctoa::buffer#14 [phi:uctoa::@9->uctoa::@6#0] -- register_copy 
    // [813] phi uctoa::started#2 = uctoa::started#4 [phi:uctoa::@9->uctoa::@6#1] -- register_copy 
    // [813] phi uctoa::value#2 = uctoa::value#6 [phi:uctoa::@9->uctoa::@6#2] -- register_copy 
    // [813] phi uctoa::digit#2 = uctoa::digit#1 [phi:uctoa::@9->uctoa::@6#3] -- register_copy 
    jmp __b6
    // uctoa::@10
  __b10:
    // uctoa_append(buffer++, value, digit_value)
    // [824] uctoa_append::buffer#0 = uctoa::buffer#11 -- pbuz1=pbuz2 
    lda.z buffer
    sta.z uctoa_append.buffer
    lda.z buffer+1
    sta.z uctoa_append.buffer+1
    // [825] uctoa_append::value#0 = uctoa::value#2
    // [826] uctoa_append::sub#0 = uctoa::digit_value#0 -- vbuz1=vbuyy 
    sty.z uctoa_append.sub
    // [827] call uctoa_append 
    // [874] phi from uctoa::@10 to uctoa_append [phi:uctoa::@10->uctoa_append]
    jsr uctoa_append
    // uctoa_append(buffer++, value, digit_value)
    // [828] uctoa_append::return#0 = uctoa_append::value#2
    // uctoa::@11
    // value = uctoa_append(buffer++, value, digit_value)
    // [829] uctoa::value#0 = uctoa_append::return#0
    // value = uctoa_append(buffer++, value, digit_value);
    // [830] uctoa::buffer#4 = ++ uctoa::buffer#11 -- pbuz1=_inc_pbuz1 
    inc.z buffer
    bne !+
    inc.z buffer+1
  !:
    // [822] phi from uctoa::@11 to uctoa::@9 [phi:uctoa::@11->uctoa::@9]
    // [822] phi uctoa::buffer#14 = uctoa::buffer#4 [phi:uctoa::@11->uctoa::@9#0] -- register_copy 
    // [822] phi uctoa::started#4 = 1 [phi:uctoa::@11->uctoa::@9#1] -- vbuz1=vbuc1 
    lda #1
    sta.z started
    // [822] phi uctoa::value#6 = uctoa::value#0 [phi:uctoa::@11->uctoa::@9#2] -- register_copy 
    jmp __b9
}
  // printf_number_buffer
// Print the contents of the number buffer using a specific format.
// This handles minimum length, zero-filling, and left/right justification from the format
// printf_number_buffer(byte register(A) buffer_sign)
printf_number_buffer: {
    .label buffer_digits = printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS
    // printf_number_buffer::@1
    // if(buffer.sign)
    // [832] if(0==printf_number_buffer::buffer_sign#0) goto printf_number_buffer::@2 -- 0_eq_vbuaa_then_la1 
    cmp #0
    beq __b2
    // printf_number_buffer::@3
    // cputc(buffer.sign)
    // [833] cputc::c#2 = printf_number_buffer::buffer_sign#0 -- vbuz1=vbuaa 
    sta.z cputc.c
    // [834] call cputc 
    // [769] phi from printf_number_buffer::@3 to cputc [phi:printf_number_buffer::@3->cputc]
    // [769] phi cputc::c#3 = cputc::c#2 [phi:printf_number_buffer::@3->cputc#0] -- register_copy 
    jsr cputc
    // [835] phi from printf_number_buffer::@1 printf_number_buffer::@3 to printf_number_buffer::@2 [phi:printf_number_buffer::@1/printf_number_buffer::@3->printf_number_buffer::@2]
    // printf_number_buffer::@2
  __b2:
    // cputs(buffer.digits)
    // [836] call cputs 
    // [568] phi from printf_number_buffer::@2 to cputs [phi:printf_number_buffer::@2->cputs]
    // [568] phi cputs::s#16 = printf_number_buffer::buffer_digits#0 [phi:printf_number_buffer::@2->cputs#0] -- pbuz1=pbuc1 
    lda #<buffer_digits
    sta.z cputs.s
    lda #>buffer_digits
    sta.z cputs.s+1
    jsr cputs
    // printf_number_buffer::@return
    // }
    // [837] return 
    rts
}
  // memcpy_to_vram
// Copy block of memory (from RAM to VRAM)
// Copies the values of num bytes from the location pointed to by source directly to the memory block pointed to by destination in VRAM.
// - vbank: Which 64K VRAM bank to put data into (0/1)
// - vdest: The destination address in VRAM
// - src: The source address in RAM
// - num: The number of bytes to copy
// memcpy_to_vram(void* zp($c) vdest)
memcpy_to_vram: {
    .const vbank = 1
    .label src = vera_sprite_attributes_set.sprite_attr
    .label end = src+SIZEOF_STRUCT_VERA_SPRITE
    .label s = $4c
    .label vdest = $c
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [838] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    // Select DATA0
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <vdest
    // [839] memcpy_to_vram::$0 = < memcpy_to_vram::vdest#0 -- vbuaa=_lo_pvoz1 
    lda.z vdest
    // *VERA_ADDRX_L = <vdest
    // [840] *VERA_ADDRX_L = memcpy_to_vram::$0 -- _deref_pbuc1=vbuaa 
    // Set address
    sta VERA_ADDRX_L
    // >vdest
    // [841] memcpy_to_vram::$1 = > memcpy_to_vram::vdest#0 -- vbuaa=_hi_pvoz1 
    lda.z vdest+1
    // *VERA_ADDRX_M = >vdest
    // [842] *VERA_ADDRX_M = memcpy_to_vram::$1 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_1 | vbank
    // [843] *VERA_ADDRX_H = VERA_INC_1|memcpy_to_vram::vbank#0 -- _deref_pbuc1=vbuc2 
    lda #VERA_INC_1|vbank
    sta VERA_ADDRX_H
    // [844] phi from memcpy_to_vram to memcpy_to_vram::@1 [phi:memcpy_to_vram->memcpy_to_vram::@1]
    // [844] phi memcpy_to_vram::s#2 = (byte*)memcpy_to_vram::src#0 [phi:memcpy_to_vram->memcpy_to_vram::@1#0] -- pbuz1=pbuc1 
    lda #<src
    sta.z s
    lda #>src
    sta.z s+1
    // memcpy_to_vram::@1
  __b1:
    // for(char *s = src; s!=end; s++)
    // [845] if(memcpy_to_vram::s#2!=memcpy_to_vram::end#0) goto memcpy_to_vram::@2 -- pbuz1_neq_pbuc1_then_la1 
    lda.z s+1
    cmp #>end
    bne __b2
    lda.z s
    cmp #<end
    bne __b2
    // memcpy_to_vram::@return
    // }
    // [846] return 
    rts
    // memcpy_to_vram::@2
  __b2:
    // *VERA_DATA0 = *s
    // [847] *VERA_DATA0 = *memcpy_to_vram::s#2 -- _deref_pbuc1=_deref_pbuz1 
    ldy #0
    lda (s),y
    sta VERA_DATA0
    // for(char *s = src; s!=end; s++)
    // [848] memcpy_to_vram::s#1 = ++ memcpy_to_vram::s#2 -- pbuz1=_inc_pbuz1 
    inc.z s
    bne !+
    inc.z s+1
  !:
    // [844] phi from memcpy_to_vram::@2 to memcpy_to_vram::@1 [phi:memcpy_to_vram::@2->memcpy_to_vram::@1]
    // [844] phi memcpy_to_vram::s#2 = memcpy_to_vram::s#1 [phi:memcpy_to_vram::@2->memcpy_to_vram::@1#0] -- register_copy 
    jmp __b1
}
  // strlen
// Computes the length of the string str up to but not including the terminating null character.
// strlen(byte* zp($2f) str)
strlen: {
    .label len = $64
    .label str = $2f
    .label return = $64
    // [850] phi from strlen to strlen::@1 [phi:strlen->strlen::@1]
    // [850] phi strlen::len#2 = 0 [phi:strlen->strlen::@1#0] -- vwuz1=vwuc1 
    lda #<0
    sta.z len
    sta.z len+1
    // [850] phi strlen::str#3 = strlen::str#1 [phi:strlen->strlen::@1#1] -- register_copy 
    // strlen::@1
  __b1:
    // while(*str)
    // [851] if(0!=*strlen::str#3) goto strlen::@2 -- 0_neq__deref_pbuz1_then_la1 
    ldy #0
    lda (str),y
    cmp #0
    bne __b2
    // strlen::@return
    // }
    // [852] return 
    rts
    // strlen::@2
  __b2:
    // len++;
    // [853] strlen::len#1 = ++ strlen::len#2 -- vwuz1=_inc_vwuz1 
    inc.z len
    bne !+
    inc.z len+1
  !:
    // str++;
    // [854] strlen::str#0 = ++ strlen::str#3 -- pbuz1=_inc_pbuz1 
    inc.z str
    bne !+
    inc.z str+1
  !:
    // [850] phi from strlen::@2 to strlen::@1 [phi:strlen::@2->strlen::@1]
    // [850] phi strlen::len#2 = strlen::len#1 [phi:strlen::@2->strlen::@1#0] -- register_copy 
    // [850] phi strlen::str#3 = strlen::str#0 [phi:strlen::@2->strlen::@1#1] -- register_copy 
    jmp __b1
}
  // vera_layer_get_color
// Get the text and back color for text output in 16 color mode.
// - layer: Value of 0 or 1.
// - return: an 8 bit value with bit 7:4 containing the back color and bit 3:0 containing the front color.
//   This will only work when the VERA is in 16 color mode!
//   Note that on the VERA, the transparent color has value 0.
// vera_layer_get_color(byte register(X) layer)
vera_layer_get_color: {
    .label addr = $66
    // addr = vera_layer_config[layer]
    // [856] vera_layer_get_color::$3 = vera_layer_get_color::layer#2 << 1 -- vbuaa=vbuxx_rol_1 
    txa
    asl
    // [857] vera_layer_get_color::addr#0 = vera_layer_config[vera_layer_get_color::$3] -- pbuz1=qbuc1_derefidx_vbuaa 
    tay
    lda vera_layer_config,y
    sta.z addr
    lda vera_layer_config+1,y
    sta.z addr+1
    // *addr & VERA_LAYER_CONFIG_256C
    // [858] vera_layer_get_color::$0 = *vera_layer_get_color::addr#0 & VERA_LAYER_CONFIG_256C -- vbuaa=_deref_pbuz1_band_vbuc1 
    lda #VERA_LAYER_CONFIG_256C
    ldy #0
    and (addr),y
    // if( *addr & VERA_LAYER_CONFIG_256C )
    // [859] if(0!=vera_layer_get_color::$0) goto vera_layer_get_color::@1 -- 0_neq_vbuaa_then_la1 
    cmp #0
    bne __b1
    // vera_layer_get_color::@2
    // vera_layer_backcolor[layer] << 4
    // [860] vera_layer_get_color::$1 = vera_layer_backcolor[vera_layer_get_color::layer#2] << 4 -- vbuaa=pbuc1_derefidx_vbuxx_rol_4 
    lda vera_layer_backcolor,x
    asl
    asl
    asl
    asl
    // return ((vera_layer_backcolor[layer] << 4) | vera_layer_textcolor[layer]);
    // [861] vera_layer_get_color::return#1 = vera_layer_get_color::$1 | vera_layer_textcolor[vera_layer_get_color::layer#2] -- vbuaa=vbuaa_bor_pbuc1_derefidx_vbuxx 
    ora vera_layer_textcolor,x
    // [862] phi from vera_layer_get_color::@1 vera_layer_get_color::@2 to vera_layer_get_color::@return [phi:vera_layer_get_color::@1/vera_layer_get_color::@2->vera_layer_get_color::@return]
    // [862] phi vera_layer_get_color::return#2 = vera_layer_get_color::return#0 [phi:vera_layer_get_color::@1/vera_layer_get_color::@2->vera_layer_get_color::@return#0] -- register_copy 
    // vera_layer_get_color::@return
    // }
    // [863] return 
    rts
    // vera_layer_get_color::@1
  __b1:
    // return (vera_layer_textcolor[layer]);
    // [864] vera_layer_get_color::return#0 = vera_layer_textcolor[vera_layer_get_color::layer#2] -- vbuaa=pbuc1_derefidx_vbuxx 
    lda vera_layer_textcolor,x
    rts
}
  // cputln
// Print a newline
cputln: {
    .label temp = $66
    // temp = conio_line_text[cx16_conio.conio_screen_layer]
    // [865] cputln::$2 = *((byte*)&cx16_conio) << 1 -- vbuaa=_deref_pbuc1_rol_1 
    lda cx16_conio
    asl
    // [866] cputln::temp#0 = conio_line_text[cputln::$2] -- vwuz1=pwuc1_derefidx_vbuaa 
    // TODO: This needs to be optimized! other variations don't compile because of sections not available!
    tay
    lda conio_line_text,y
    sta.z temp
    lda conio_line_text+1,y
    sta.z temp+1
    // temp += cx16_conio.conio_rowskip
    // [867] cputln::temp#1 = cputln::temp#0 + *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP) -- vwuz1=vwuz1_plus__deref_pwuc1 
    clc
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP
    adc.z temp
    sta.z temp
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP+1
    adc.z temp+1
    sta.z temp+1
    // conio_line_text[cx16_conio.conio_screen_layer] = temp
    // [868] cputln::$3 = *((byte*)&cx16_conio) << 1 -- vbuaa=_deref_pbuc1_rol_1 
    lda cx16_conio
    asl
    // [869] conio_line_text[cputln::$3] = cputln::temp#1 -- pwuc1_derefidx_vbuaa=vwuz1 
    tay
    lda.z temp
    sta conio_line_text,y
    lda.z temp+1
    sta conio_line_text+1,y
    // conio_cursor_x[cx16_conio.conio_screen_layer] = 0
    // [870] conio_cursor_x[*((byte*)&cx16_conio)] = 0 -- pbuc1_derefidx_(_deref_pbuc2)=vbuc3 
    lda #0
    ldy cx16_conio
    sta conio_cursor_x,y
    // conio_cursor_y[cx16_conio.conio_screen_layer]++;
    // [871] conio_cursor_y[*((byte*)&cx16_conio)] = ++ conio_cursor_y[*((byte*)&cx16_conio)] -- pbuc1_derefidx_(_deref_pbuc2)=_inc_pbuc1_derefidx_(_deref_pbuc2) 
    ldx cx16_conio
    lda conio_cursor_y,x
    inc
    sta conio_cursor_y,y
    // cscroll()
    // [872] call cscroll 
    jsr cscroll
    // cputln::@return
    // }
    // [873] return 
    rts
}
  // uctoa_append
// Used to convert a single digit of an unsigned number value to a string representation
// Counts a single digit up from '0' as long as the value is larger than sub.
// Each time the digit is increased sub is subtracted from value.
// - buffer : pointer to the char that receives the digit
// - value : The value where the digit will be derived from
// - sub : the value of a '1' in the digit. Subtracted continually while the digit is increased.
//        (For decimal the subs used are 10000, 1000, 100, 10, 1)
// returns : the value reduced by sub * digit so that it is less than sub.
// uctoa_append(byte* zp($64) buffer, byte register(X) value, byte zp($2e) sub)
uctoa_append: {
    .label buffer = $64
    .label sub = $2e
    // [875] phi from uctoa_append to uctoa_append::@1 [phi:uctoa_append->uctoa_append::@1]
    // [875] phi uctoa_append::digit#2 = 0 [phi:uctoa_append->uctoa_append::@1#0] -- vbuyy=vbuc1 
    ldy #0
    // [875] phi uctoa_append::value#2 = uctoa_append::value#0 [phi:uctoa_append->uctoa_append::@1#1] -- register_copy 
    // uctoa_append::@1
  __b1:
    // while (value >= sub)
    // [876] if(uctoa_append::value#2>=uctoa_append::sub#0) goto uctoa_append::@2 -- vbuxx_ge_vbuz1_then_la1 
    cpx.z sub
    bcs __b2
    // uctoa_append::@3
    // *buffer = DIGITS[digit]
    // [877] *uctoa_append::buffer#0 = DIGITS[uctoa_append::digit#2] -- _deref_pbuz1=pbuc1_derefidx_vbuyy 
    lda DIGITS,y
    ldy #0
    sta (buffer),y
    // uctoa_append::@return
    // }
    // [878] return 
    rts
    // uctoa_append::@2
  __b2:
    // digit++;
    // [879] uctoa_append::digit#1 = ++ uctoa_append::digit#2 -- vbuyy=_inc_vbuyy 
    iny
    // value -= sub
    // [880] uctoa_append::value#1 = uctoa_append::value#2 - uctoa_append::sub#0 -- vbuxx=vbuxx_minus_vbuz1 
    txa
    sec
    sbc.z sub
    tax
    // [875] phi from uctoa_append::@2 to uctoa_append::@1 [phi:uctoa_append::@2->uctoa_append::@1]
    // [875] phi uctoa_append::digit#2 = uctoa_append::digit#1 [phi:uctoa_append::@2->uctoa_append::@1#0] -- register_copy 
    // [875] phi uctoa_append::value#2 = uctoa_append::value#1 [phi:uctoa_append::@2->uctoa_append::@1#1] -- register_copy 
    jmp __b1
}
  // cscroll
// Scroll the entire screen if the cursor is beyond the last line
cscroll: {
    // if(conio_cursor_y[cx16_conio.conio_screen_layer]>=cx16_conio.conio_screen_height)
    // [881] if(conio_cursor_y[*((byte*)&cx16_conio)]<*((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT)) goto cscroll::@return -- pbuc1_derefidx_(_deref_pbuc2)_lt__deref_pbuc3_then_la1 
    ldy cx16_conio
    lda conio_cursor_y,y
    cmp cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT
    bcc __b3
    // cscroll::@1
    // if(conio_scroll_enable[cx16_conio.conio_screen_layer])
    // [882] if(0!=conio_scroll_enable[*((byte*)&cx16_conio)]) goto cscroll::@4 -- 0_neq_pbuc1_derefidx_(_deref_pbuc2)_then_la1 
    lda conio_scroll_enable,y
    cmp #0
    bne __b4
    // cscroll::@2
    // if(conio_cursor_y[cx16_conio.conio_screen_layer]>=cx16_conio.conio_screen_height)
    // [883] if(conio_cursor_y[*((byte*)&cx16_conio)]<*((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT)) goto cscroll::@return -- pbuc1_derefidx_(_deref_pbuc2)_lt__deref_pbuc3_then_la1 
    lda conio_cursor_y,y
    cmp cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT
    // [884] phi from cscroll::@2 to cscroll::@3 [phi:cscroll::@2->cscroll::@3]
    // cscroll::@3
  __b3:
    // cscroll::@return
    // }
    // [885] return 
    rts
    // [886] phi from cscroll::@1 to cscroll::@4 [phi:cscroll::@1->cscroll::@4]
    // cscroll::@4
  __b4:
    // insertup()
    // [887] call insertup 
    jsr insertup
    // cscroll::@5
    // gotoxy( 0, cx16_conio.conio_screen_height-1)
    // [888] gotoxy::y#2 = *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT) - 1 -- vbuxx=_deref_pbuc1_minus_1 
    ldx cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT
    dex
    // [889] call gotoxy 
    // [382] phi from cscroll::@5 to gotoxy [phi:cscroll::@5->gotoxy]
    // [382] phi gotoxy::y#3 = gotoxy::y#2 [phi:cscroll::@5->gotoxy#0] -- register_copy 
    jsr gotoxy
    rts
}
  // insertup
// Insert a new line, and scroll the upper part of the screen up.
insertup: {
    .label cy = $2e
    .label width = $68
    .label line = $64
    .label start = $64
    // cy = conio_cursor_y[cx16_conio.conio_screen_layer]
    // [890] insertup::cy#0 = conio_cursor_y[*((byte*)&cx16_conio)] -- vbuz1=pbuc1_derefidx_(_deref_pbuc2) 
    ldy cx16_conio
    lda conio_cursor_y,y
    sta.z cy
    // width = cx16_conio.conio_screen_width * 2
    // [891] insertup::width#0 = *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH) << 1 -- vbuz1=_deref_pbuc1_rol_1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH
    asl
    sta.z width
    // [892] phi from insertup to insertup::@1 [phi:insertup->insertup::@1]
    // [892] phi insertup::i#2 = 1 [phi:insertup->insertup::@1#0] -- vbuxx=vbuc1 
    ldx #1
    // insertup::@1
  __b1:
    // for(unsigned byte i=1; i<=cy; i++)
    // [893] if(insertup::i#2<=insertup::cy#0) goto insertup::@2 -- vbuxx_le_vbuz1_then_la1 
    lda.z cy
    stx.z $ff
    cmp.z $ff
    bcs __b2
    // [894] phi from insertup::@1 to insertup::@3 [phi:insertup::@1->insertup::@3]
    // insertup::@3
    // clearline()
    // [895] call clearline 
    jsr clearline
    // insertup::@return
    // }
    // [896] return 
    rts
    // insertup::@2
  __b2:
    // i-1
    // [897] insertup::$3 = insertup::i#2 - 1 -- vbuaa=vbuxx_minus_1 
    txa
    sec
    sbc #1
    // line = (i-1) << cx16_conio.conio_rowshift
    // [898] insertup::line#0 = insertup::$3 << *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSHIFT) -- vwuz1=vbuaa_rol__deref_pbuc1 
    ldy cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSHIFT
    sta.z line
    lda #0
    sta.z line+1
    cpy #0
    beq !e+
  !:
    asl.z line
    rol.z line+1
    dey
    bne !-
  !e:
    // start = cx16_conio.conio_screen_text + line
    // [899] insertup::start#0 = *((byte**)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT) + insertup::line#0 -- pbuz1=_deref_qbuc1_plus_vwuz1 
    clc
    lda.z start
    adc cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT
    sta.z start
    lda.z start+1
    adc cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT+1
    sta.z start+1
    // start+cx16_conio.conio_rowskip
    // [900] memcpy_in_vram::src#0 = insertup::start#0 + *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP) -- pbuz1=pbuz2_plus__deref_pwuc1 
    clc
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP
    adc.z start
    sta.z memcpy_in_vram.src
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP+1
    adc.z start+1
    sta.z memcpy_in_vram.src+1
    // memcpy_in_vram(0, start, VERA_INC_1,  0, start+cx16_conio.conio_rowskip, VERA_INC_1, width)
    // [901] memcpy_in_vram::dest#0 = (void*)insertup::start#0 -- pvoz1=pvoz2 
    lda.z start
    sta.z memcpy_in_vram.dest
    lda.z start+1
    sta.z memcpy_in_vram.dest+1
    // [902] memcpy_in_vram::num#0 = insertup::width#0 -- vwuz1=vbuz2 
    lda.z width
    sta.z memcpy_in_vram.num
    lda #0
    sta.z memcpy_in_vram.num+1
    // [903] memcpy_in_vram::src#4 = (void*)memcpy_in_vram::src#0
    // memcpy_in_vram(0, start, VERA_INC_1,  0, start+cx16_conio.conio_rowskip, VERA_INC_1, width)
    // [904] call memcpy_in_vram 
    // [231] phi from insertup::@2 to memcpy_in_vram [phi:insertup::@2->memcpy_in_vram]
    // [231] phi memcpy_in_vram::num#4 = memcpy_in_vram::num#0 [phi:insertup::@2->memcpy_in_vram#0] -- register_copy 
    // [231] phi memcpy_in_vram::dest_bank#3 = 0 [phi:insertup::@2->memcpy_in_vram#1] -- vbuz1=vbuc1 
    sta.z memcpy_in_vram.dest_bank
    // [231] phi memcpy_in_vram::dest#3 = memcpy_in_vram::dest#0 [phi:insertup::@2->memcpy_in_vram#2] -- register_copy 
    // [231] phi memcpy_in_vram::src_bank#3 = 0 [phi:insertup::@2->memcpy_in_vram#3] -- vbuyy=vbuc1 
    tay
    // [231] phi memcpy_in_vram::src#3 = memcpy_in_vram::src#4 [phi:insertup::@2->memcpy_in_vram#4] -- register_copy 
    jsr memcpy_in_vram
    // insertup::@4
    // for(unsigned byte i=1; i<=cy; i++)
    // [905] insertup::i#1 = ++ insertup::i#2 -- vbuxx=_inc_vbuxx 
    inx
    // [892] phi from insertup::@4 to insertup::@1 [phi:insertup::@4->insertup::@1]
    // [892] phi insertup::i#2 = insertup::i#1 [phi:insertup::@4->insertup::@1#0] -- register_copy 
    jmp __b1
}
  // clearline
clearline: {
    .label conio_line = $2f
    .label addr = $2f
    .label c = $64
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [906] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    // Select DATA0
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // conio_line = conio_line_text[cx16_conio.conio_screen_layer]
    // [907] clearline::$5 = *((byte*)&cx16_conio) << 1 -- vbuaa=_deref_pbuc1_rol_1 
    lda cx16_conio
    asl
    // [908] clearline::conio_line#0 = conio_line_text[clearline::$5] -- vwuz1=pwuc1_derefidx_vbuaa 
    tay
    lda conio_line_text,y
    sta.z conio_line
    lda conio_line_text+1,y
    sta.z conio_line+1
    // conio_screen_text + conio_line
    // [909] clearline::addr#0 = (word)*((byte**)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT) + clearline::conio_line#0 -- vwuz1=_deref_pwuc1_plus_vwuz1 
    clc
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT
    adc.z addr
    sta.z addr
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT+1
    adc.z addr+1
    sta.z addr+1
    // <addr
    // [910] clearline::$1 = < (byte*)clearline::addr#0 -- vbuaa=_lo_pbuz1 
    lda.z addr
    // *VERA_ADDRX_L = <addr
    // [911] *VERA_ADDRX_L = clearline::$1 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >addr
    // [912] clearline::$2 = > (byte*)clearline::addr#0 -- vbuaa=_hi_pbuz1 
    lda.z addr+1
    // *VERA_ADDRX_M = >addr
    // [913] *VERA_ADDRX_M = clearline::$2 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_1
    // [914] *VERA_ADDRX_H = VERA_INC_1 -- _deref_pbuc1=vbuc2 
    lda #VERA_INC_1
    sta VERA_ADDRX_H
    // vera_layer_get_color(cx16_conio.conio_screen_layer)
    // [915] vera_layer_get_color::layer#1 = *((byte*)&cx16_conio) -- vbuxx=_deref_pbuc1 
    ldx cx16_conio
    // [916] call vera_layer_get_color 
    // [855] phi from clearline to vera_layer_get_color [phi:clearline->vera_layer_get_color]
    // [855] phi vera_layer_get_color::layer#2 = vera_layer_get_color::layer#1 [phi:clearline->vera_layer_get_color#0] -- register_copy 
    jsr vera_layer_get_color
    // vera_layer_get_color(cx16_conio.conio_screen_layer)
    // [917] vera_layer_get_color::return#4 = vera_layer_get_color::return#2
    // clearline::@4
    // color = vera_layer_get_color(cx16_conio.conio_screen_layer)
    // [918] clearline::color#0 = vera_layer_get_color::return#4 -- vbuxx=vbuaa 
    tax
    // [919] phi from clearline::@4 to clearline::@1 [phi:clearline::@4->clearline::@1]
    // [919] phi clearline::c#2 = 0 [phi:clearline::@4->clearline::@1#0] -- vwuz1=vwuc1 
    lda #<0
    sta.z c
    sta.z c+1
    // clearline::@1
  __b1:
    // for( unsigned int c=0;c<cx16_conio.conio_screen_width; c++ )
    // [920] if(clearline::c#2<*((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH)) goto clearline::@2 -- vwuz1_lt__deref_pbuc1_then_la1 
    ldy cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH
    lda.z c+1
    bne !+
    sty.z $ff
    lda.z c
    cmp.z $ff
    bcc __b2
  !:
    // clearline::@3
    // conio_cursor_x[cx16_conio.conio_screen_layer] = 0
    // [921] conio_cursor_x[*((byte*)&cx16_conio)] = 0 -- pbuc1_derefidx_(_deref_pbuc2)=vbuc3 
    lda #0
    ldy cx16_conio
    sta conio_cursor_x,y
    // clearline::@return
    // }
    // [922] return 
    rts
    // clearline::@2
  __b2:
    // *VERA_DATA0 = ' '
    // [923] *VERA_DATA0 = ' ' -- _deref_pbuc1=vbuc2 
    // Set data
    lda #' '
    sta VERA_DATA0
    // *VERA_DATA0 = color
    // [924] *VERA_DATA0 = clearline::color#0 -- _deref_pbuc1=vbuxx 
    stx VERA_DATA0
    // for( unsigned int c=0;c<cx16_conio.conio_screen_width; c++ )
    // [925] clearline::c#1 = ++ clearline::c#2 -- vwuz1=_inc_vwuz1 
    inc.z c
    bne !+
    inc.z c+1
  !:
    // [919] phi from clearline::@2 to clearline::@1 [phi:clearline::@2->clearline::@1]
    // [919] phi clearline::c#2 = clearline::c#1 [phi:clearline::@2->clearline::@1#0] -- register_copy 
    jmp __b1
}
  // File Data
.segment Data
  VERA_LAYER_WIDTH: .word $20, $40, $80, $100
  VERA_LAYER_HEIGHT: .word $20, $40, $80, $100
  // --- VERA function encapsulation ---
  vera_mapbase_offset: .word 0, 0
  vera_mapbase_bank: .byte 0, 0
  vera_mapbase_address: .dword 0, 0
  vera_tilebase_offset: .word 0, 0
  vera_tilebase_bank: .byte 0, 0
  vera_tilebase_address: .dword 0, 0
  vera_layer_rowshift: .byte 0, 0
  vera_layer_rowskip: .word 0, 0
  vera_layer_config: .word VERA_L0_CONFIG, VERA_L1_CONFIG
  vera_layer_enable: .byte VERA_LAYER0_ENABLE, VERA_LAYER1_ENABLE
  vera_layer_mapbase: .word VERA_L0_MAPBASE, VERA_L1_MAPBASE
  vera_layer_tilebase: .word VERA_L0_TILEBASE, VERA_L1_TILEBASE
  vera_layer_vscroll_l: .word VERA_L0_VSCROLL_L, VERA_L1_VSCROLL_L
  vera_layer_vscroll_h: .word VERA_L0_VSCROLL_H, VERA_L1_VSCROLL_H
  vera_layer_textcolor: .byte WHITE, WHITE
  vera_layer_backcolor: .byte BLUE, BLUE
  // The current cursor x-position
  conio_cursor_x: .byte 0, 0
  // The current cursor y-position
  conio_cursor_y: .byte 0, 0
  // The current text cursor line start
  conio_line_text: .word 0, 0
  // Is scrolling enabled when outputting beyond the end of the screen (1: yes, 0: no).
  // If disabled the cursor just moves back to (0,0) instead
  conio_scroll_enable: .byte 1, 1
  // The digits used for numbers
  DIGITS: .text "0123456789abcdef"
  // Values of binary digits
  RADIX_BINARY_VALUES_CHAR: .byte $80, $40, $20, $10, 8, 4, 2
  // Values of octal digits
  RADIX_OCTAL_VALUES_CHAR: .byte $40, 8
  // Values of decimal digits
  RADIX_DECIMAL_VALUES_CHAR: .byte $64, $a
  // Values of hexadecimal digits
  RADIX_HEXADECIMAL_VALUES_CHAR: .byte $10
  SquareMetal: .byte $10, $40, $10, 4, 4, 4
  TileMetal: .byte $10+$40, $40, $10, 4, 4, 5
  SquareRaster: .byte $10+$40+$40, $40, $10, 4, 4, 6
  TileDB: .word SquareMetal, TileMetal, SquareRaster
  PlayerSprites: .fill 2*NUM_PLAYER, 0
  Enemy2Sprites: .fill 2*NUM_ENEMY2, 0
  FILE_SPRITES: .text "PLAYER"
  .byte 0
  FILE_ENEMY2: .text "ENEMY2"
  .byte 0
  FILE_TILES: .text "TILES"
  .byte 0
  FILE_TILEMETAL: .text "TILEMETAL"
  .byte 0
  FILE_SQUARERASTER: .text "SQUARERASTER"
  .byte 0
  FILE_SQUAREMETAL: .text "SQUAREMETAL"
  .byte 0
  FILE_PALETTES: .text "PALETTES"
  .byte 0
  cx16_conio: .fill SIZEOF_STRUCT_CX16_CONIO, 0
  // Buffer used for stringified number being printed
  printf_buffer: .fill SIZEOF_STRUCT_PRINTF_BUFFER_NUMBER, 0
  // Sprite attributes: 4bpp, in front, 32x32, address SPRITE_PIXELS_VRAM
  SPRITE_ATTR: .word 0, $140-$20, $f0-$20
  .byte $c, VERA_SPRITE_WIDTH_32|VERA_SPRITE_HEIGHT_32|1

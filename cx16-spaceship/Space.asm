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
  .const VERA_SPRITE_8BPP = $8000
  // Sprite flip
  .const VERA_SPRITE_HFLIP = 1
  .const VERA_SPRITE_VFLIP = 2
  .const VERA_SPRITE_ZDEPTH_IN_FRONT = $c
  .const VERA_SPRITE_ZDEPTH_MASK = $c
  .const VERA_SPRITE_WIDTH_32 = $20
  .const VERA_SPRITE_WIDTH_MASK = $30
  .const VERA_SPRITE_HEIGHT_32 = $80
  .const VERA_SPRITE_HEIGHT_MASK = $c0
  .const VERA_SPRITE_PALETTE_OFFSET_MASK = $f
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
  .const OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS = 1
  .const OFFSET_STRUCT_MOS6522_VIA_PORT_A = 1
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT = 1
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT = 8
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH = 6
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK = 3
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP = $b
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSHIFT = $a
  .const OFFSET_STRUCT_CX16_CONIO_CONIO_DISPLAY_CURSOR = $d
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
  // The VIA#1: ROM/RAM Bank Control
  // Port A Bits 0-7 RAM bank
  // Port B Bits 0-2 ROM bank
  // Port B Bits 3-7 [TBD]
  .label VIA1 = $9f60
  // $0314	(RAM) IRQ vector - The vector used when the KERNAL serves IRQ interrupts
  .label KERNEL_IRQ = $314
  .label i = $2e
  .label j = $2f
  .label a = $30
  .label vscroll = $31
  .label scroll_action = $33
  // The random state variable
  .label rand_state = $22
  // Remainder after unsigned 16-bit division
  .label rem16u = $2c
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
    .label __2 = $35
    .label __16 = $39
    .label vera_layer_set_vertical_scroll1_scroll = $37
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
    // [205] phi rotate_sprites::basex#8 = $28 [phi:irq_vsync::@3->rotate_sprites#0] -- vwuz1=vbuc1 
    lda #<$28
    sta.z rotate_sprites.basex
    lda #>$28
    sta.z rotate_sprites.basex+1
    // [205] phi rotate_sprites::spriteaddresses#6 = PlayerSprites [phi:irq_vsync::@3->rotate_sprites#1] -- pduz1=pduc1 
    lda #<PlayerSprites
    sta.z rotate_sprites.spriteaddresses
    lda #>PlayerSprites
    sta.z rotate_sprites.spriteaddresses+1
    // [205] phi rotate_sprites::base#8 = 0 [phi:irq_vsync::@3->rotate_sprites#2] -- vbuz1=vbuc1 
    lda #0
    sta.z rotate_sprites.base
    // [205] phi rotate_sprites::rotate#4 = rotate_sprites::rotate#0 [phi:irq_vsync::@3->rotate_sprites#3] -- register_copy 
    // [205] phi rotate_sprites::max#5 = NUM_PLAYER [phi:irq_vsync::@3->rotate_sprites#4] -- vwuz1=vbuc1 
    lda #<NUM_PLAYER
    sta.z rotate_sprites.max
    lda #>NUM_PLAYER
    sta.z rotate_sprites.max+1
    jsr rotate_sprites
    // irq_vsync::@15
    // rotate_sprites(12, j,NUM_ENEMY2,Enemy2Sprites,340,100)
    // [16] rotate_sprites::rotate#1 = j -- vwuz1=vbuz2 
    lda.z j
    sta.z rotate_sprites.rotate
    lda #0
    sta.z rotate_sprites.rotate+1
    // [17] call rotate_sprites 
    // [205] phi from irq_vsync::@15 to rotate_sprites [phi:irq_vsync::@15->rotate_sprites]
    // [205] phi rotate_sprites::basex#8 = $154 [phi:irq_vsync::@15->rotate_sprites#0] -- vwuz1=vwuc1 
    lda #<$154
    sta.z rotate_sprites.basex
    lda #>$154
    sta.z rotate_sprites.basex+1
    // [205] phi rotate_sprites::spriteaddresses#6 = Enemy2Sprites [phi:irq_vsync::@15->rotate_sprites#1] -- pduz1=pduc1 
    lda #<Enemy2Sprites
    sta.z rotate_sprites.spriteaddresses
    lda #>Enemy2Sprites
    sta.z rotate_sprites.spriteaddresses+1
    // [205] phi rotate_sprites::base#8 = $c [phi:irq_vsync::@15->rotate_sprites#2] -- vbuz1=vbuc1 
    lda #$c
    sta.z rotate_sprites.base
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
    // [264] phi from irq_vsync::@6 to memcpy_in_vram [phi:irq_vsync::@6->memcpy_in_vram]
    // [264] phi memcpy_in_vram::num#4 = (word)$40*$10*4 [phi:irq_vsync::@6->memcpy_in_vram#0] -- vwuz1=vwuc1 
    lda #<$40*$10*4
    sta.z memcpy_in_vram.num
    lda #>$40*$10*4
    sta.z memcpy_in_vram.num+1
    // [264] phi memcpy_in_vram::dest_bank#3 = 1 [phi:irq_vsync::@6->memcpy_in_vram#1] -- vbuz1=vbuc1 
    lda #1
    sta.z memcpy_in_vram.dest_bank
    // [264] phi memcpy_in_vram::dest#3 = (void*)0 [phi:irq_vsync::@6->memcpy_in_vram#2] -- pvoz1=pvoc1 
    lda #<0
    sta.z memcpy_in_vram.dest
    sta.z memcpy_in_vram.dest+1
    // [264] phi memcpy_in_vram::src_bank#3 = 1 [phi:irq_vsync::@6->memcpy_in_vram#3] -- vbuyy=vbuc1 
    ldy #1
    // [264] phi memcpy_in_vram::src#3 = (void*)(word)$40*$10 [phi:irq_vsync::@6->memcpy_in_vram#4] -- pvoz1=pvoc1 
    lda #<$40*$10
    sta.z memcpy_in_vram.src
    lda #>$40*$10
    sta.z memcpy_in_vram.src+1
    jsr memcpy_in_vram
    // [32] phi from irq_vsync::@6 to irq_vsync::@10 [phi:irq_vsync::@6->irq_vsync::@10]
    // [32] phi rem16u#51 = rem16u#32 [phi:irq_vsync::@6->irq_vsync::@10#0] -- register_copy 
    // [32] phi rand_state#43 = rand_state#30 [phi:irq_vsync::@6->irq_vsync::@10#1] -- register_copy 
    // [32] phi irq_vsync::r#2 = 4 [phi:irq_vsync::@6->irq_vsync::@10#2] -- vbuz1=vbuc1 
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
    // [42] phi rem16u#25 = rem16u#51 [phi:irq_vsync::@10->irq_vsync::@12#0] -- register_copy 
    // [42] phi rand_state#23 = rand_state#43 [phi:irq_vsync::@10->irq_vsync::@12#1] -- register_copy 
    // [42] phi irq_vsync::c#2 = 0 [phi:irq_vsync::@10->irq_vsync::@12#2] -- vbuz1=vbuc1 
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
    // [32] phi rem16u#51 = rem16u#25 [phi:irq_vsync::@14->irq_vsync::@10#0] -- register_copy 
    // [32] phi rand_state#43 = rand_state#23 [phi:irq_vsync::@14->irq_vsync::@10#1] -- register_copy 
    // [32] phi irq_vsync::r#2 = irq_vsync::r#1 [phi:irq_vsync::@14->irq_vsync::@10#2] -- register_copy 
    jmp __b10
    // [45] phi from irq_vsync::@12 to irq_vsync::@13 [phi:irq_vsync::@12->irq_vsync::@13]
    // irq_vsync::@13
  __b13:
    // rand()
    // [46] call rand 
    // [284] phi from irq_vsync::@13 to rand [phi:irq_vsync::@13->rand]
    // [284] phi rand_state#13 = rand_state#23 [phi:irq_vsync::@13->rand#0] -- register_copy 
    jsr rand
    // rand()
    // [47] rand::return#2 = rand::return#0
    // irq_vsync::@17
    // modr16u(rand(),3,0)
    // [48] modr16u::dividend#0 = rand::return#2
    // [49] call modr16u 
    // [293] phi from irq_vsync::@17 to modr16u [phi:irq_vsync::@17->modr16u]
    // [293] phi modr16u::dividend#2 = modr16u::dividend#0 [phi:irq_vsync::@17->modr16u#0] -- register_copy 
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
    // [298] phi from irq_vsync::@18 to vera_tile_element [phi:irq_vsync::@18->vera_tile_element]
    // [298] phi vera_tile_element::y#3 = vera_tile_element::y#1 [phi:irq_vsync::@18->vera_tile_element#0] -- register_copy 
    // [298] phi vera_tile_element::x#3 = vera_tile_element::x#1 [phi:irq_vsync::@18->vera_tile_element#1] -- register_copy 
    // [298] phi vera_tile_element::Tile#2 = vera_tile_element::Tile#0 [phi:irq_vsync::@18->vera_tile_element#2] -- register_copy 
    jsr vera_tile_element
    // irq_vsync::@19
    // c+=1
    // [58] irq_vsync::c#1 = irq_vsync::c#2 + 1 -- vbuz1=vbuz1_plus_1 
    inc.z c
    // [42] phi from irq_vsync::@19 to irq_vsync::@12 [phi:irq_vsync::@19->irq_vsync::@12]
    // [42] phi rem16u#25 = divr16u::rem#10 [phi:irq_vsync::@19->irq_vsync::@12#0] -- register_copy 
    // [42] phi rand_state#23 = rand_state#14 [phi:irq_vsync::@19->irq_vsync::@12#1] -- register_copy 
    // [42] phi irq_vsync::c#2 = irq_vsync::c#1 [phi:irq_vsync::@19->irq_vsync::@12#2] -- register_copy 
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
    // [348] phi from conio_x16_init to vera_layer_mode_text [phi:conio_x16_init->vera_layer_mode_text]
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
    // [390] phi from conio_x16_init::@5 to vera_layer_set_textcolor [phi:conio_x16_init::@5->vera_layer_set_textcolor]
    // [390] phi vera_layer_set_textcolor::layer#2 = 1 [phi:conio_x16_init::@5->vera_layer_set_textcolor#0] -- vbuxx=vbuc1 
    ldx #1
    jsr vera_layer_set_textcolor
    // [67] phi from conio_x16_init::@5 to conio_x16_init::@6 [phi:conio_x16_init::@5->conio_x16_init::@6]
    // conio_x16_init::@6
    // vera_layer_set_backcolor(1, BLUE)
    // [68] call vera_layer_set_backcolor 
    // [393] phi from conio_x16_init::@6 to vera_layer_set_backcolor [phi:conio_x16_init::@6->vera_layer_set_backcolor]
    // [393] phi vera_layer_set_backcolor::color#2 = BLUE [phi:conio_x16_init::@6->vera_layer_set_backcolor#0] -- vbuaa=vbuc1 
    lda #BLUE
    // [393] phi vera_layer_set_backcolor::layer#2 = 1 [phi:conio_x16_init::@6->vera_layer_set_backcolor#1] -- vbuxx=vbuc1 
    ldx #1
    jsr vera_layer_set_backcolor
    // [69] phi from conio_x16_init::@6 to conio_x16_init::@7 [phi:conio_x16_init::@6->conio_x16_init::@7]
    // conio_x16_init::@7
    // vera_layer_set_mapbase(0,0x20)
    // [70] call vera_layer_set_mapbase 
    // [396] phi from conio_x16_init::@7 to vera_layer_set_mapbase [phi:conio_x16_init::@7->vera_layer_set_mapbase]
    // [396] phi vera_layer_set_mapbase::mapbase#3 = $20 [phi:conio_x16_init::@7->vera_layer_set_mapbase#0] -- vbuxx=vbuc1 
    ldx #$20
    // [396] phi vera_layer_set_mapbase::layer#3 = 0 [phi:conio_x16_init::@7->vera_layer_set_mapbase#1] -- vbuaa=vbuc1 
    lda #0
    jsr vera_layer_set_mapbase
    // [71] phi from conio_x16_init::@7 to conio_x16_init::@8 [phi:conio_x16_init::@7->conio_x16_init::@8]
    // conio_x16_init::@8
    // vera_layer_set_mapbase(1,0x00)
    // [72] call vera_layer_set_mapbase 
    // [396] phi from conio_x16_init::@8 to vera_layer_set_mapbase [phi:conio_x16_init::@8->vera_layer_set_mapbase]
    // [396] phi vera_layer_set_mapbase::mapbase#3 = 0 [phi:conio_x16_init::@8->vera_layer_set_mapbase#0] -- vbuxx=vbuc1 
    ldx #0
    // [396] phi vera_layer_set_mapbase::layer#3 = 1 [phi:conio_x16_init::@8->vera_layer_set_mapbase#1] -- vbuaa=vbuc1 
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
    // [403] phi from conio_x16_init::@1 to gotoxy [phi:conio_x16_init::@1->gotoxy]
    // [403] phi gotoxy::y#3 = gotoxy::y#0 [phi:conio_x16_init::@1->gotoxy#0] -- register_copy 
    jsr gotoxy
    // conio_x16_init::@return
    // }
    // [80] return 
    rts
}
  // main
main: {
    .label status = $3b
    .label status_1 = $3c
    .label status_2 = $3e
    .label status_3 = $3f
    .label status_4 = $40
    .label status_5 = $41
    .label status_6 = $3d
    // VIA1->PORT_B = 0
    // [81] *((byte*)VIA1) = 0 -- _deref_pbuc1=vbuc2 
    lda #0
    sta VIA1
    // memcpy_in_vram(1, 0xF000, VERA_INC_1, 0, 0xF800, VERA_INC_1, 256*8)
    // [82] call memcpy_in_vram 
    // [264] phi from main to memcpy_in_vram [phi:main->memcpy_in_vram]
    // [264] phi memcpy_in_vram::num#4 = $100*8 [phi:main->memcpy_in_vram#0] -- vwuz1=vwuc1 
    lda #<$100*8
    sta.z memcpy_in_vram.num
    lda #>$100*8
    sta.z memcpy_in_vram.num+1
    // [264] phi memcpy_in_vram::dest_bank#3 = 1 [phi:main->memcpy_in_vram#1] -- vbuz1=vbuc1 
    lda #1
    sta.z memcpy_in_vram.dest_bank
    // [264] phi memcpy_in_vram::dest#3 = (void*) 61440 [phi:main->memcpy_in_vram#2] -- pvoz1=pvoc1 
    lda #<$f000
    sta.z memcpy_in_vram.dest
    lda #>$f000
    sta.z memcpy_in_vram.dest+1
    // [264] phi memcpy_in_vram::src_bank#3 = 0 [phi:main->memcpy_in_vram#3] -- vbuyy=vbuc1 
    ldy #0
    // [264] phi memcpy_in_vram::src#3 = (void*) 63488 [phi:main->memcpy_in_vram#4] -- pvoz1=pvoc1 
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
    // [416] phi from main::@20 to vera_layer_mode_tile [phi:main::@20->vera_layer_mode_tile]
    // [416] phi vera_layer_mode_tile::tileheight#10 = 8 [phi:main::@20->vera_layer_mode_tile#0] -- vbuz1=vbuc1 
    lda #8
    sta.z vera_layer_mode_tile.tileheight
    // [416] phi vera_layer_mode_tile::tilewidth#10 = 8 [phi:main::@20->vera_layer_mode_tile#1] -- vbuz1=vbuc1 
    sta.z vera_layer_mode_tile.tilewidth
    // [416] phi vera_layer_mode_tile::tilebase_address#10 = $1f000 [phi:main::@20->vera_layer_mode_tile#2] -- vduz1=vduc1 
    lda #<$1f000
    sta.z vera_layer_mode_tile.tilebase_address
    lda #>$1f000
    sta.z vera_layer_mode_tile.tilebase_address+1
    lda #<$1f000>>$10
    sta.z vera_layer_mode_tile.tilebase_address+2
    lda #>$1f000>>$10
    sta.z vera_layer_mode_tile.tilebase_address+3
    // [416] phi vera_layer_mode_tile::mapbase_address#10 = $1a000 [phi:main::@20->vera_layer_mode_tile#3] -- vduz1=vduc1 
    lda #<$1a000
    sta.z vera_layer_mode_tile.mapbase_address
    lda #>$1a000
    sta.z vera_layer_mode_tile.mapbase_address+1
    lda #<$1a000>>$10
    sta.z vera_layer_mode_tile.mapbase_address+2
    lda #>$1a000>>$10
    sta.z vera_layer_mode_tile.mapbase_address+3
    // [416] phi vera_layer_mode_tile::mapheight#10 = $40 [phi:main::@20->vera_layer_mode_tile#4] -- vwuz1=vbuc1 
    lda #<$40
    sta.z vera_layer_mode_tile.mapheight
    lda #>$40
    sta.z vera_layer_mode_tile.mapheight+1
    // [416] phi vera_layer_mode_tile::layer#10 = 1 [phi:main::@20->vera_layer_mode_tile#5] -- vbuz1=vbuc1 
    lda #1
    sta.z vera_layer_mode_tile.layer
    // [416] phi vera_layer_mode_tile::mapwidth#10 = $80 [phi:main::@20->vera_layer_mode_tile#6] -- vwuz1=vbuc1 
    lda #<$80
    sta.z vera_layer_mode_tile.mapwidth
    lda #>$80
    sta.z vera_layer_mode_tile.mapwidth+1
    // [416] phi vera_layer_mode_tile::color_depth#3 = 1 [phi:main::@20->vera_layer_mode_tile#7] -- vbuxx=vbuc1 
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
    // [390] phi from main::textcolor1 to vera_layer_set_textcolor [phi:main::textcolor1->vera_layer_set_textcolor]
    // [390] phi vera_layer_set_textcolor::layer#2 = vera_layer_set_textcolor::layer#1 [phi:main::textcolor1->vera_layer_set_textcolor#0] -- register_copy 
    jsr vera_layer_set_textcolor
    // main::bgcolor1
    // vera_layer_set_backcolor(cx16_conio.conio_screen_layer, color)
    // [89] vera_layer_set_backcolor::layer#1 = *((byte*)&cx16_conio) -- vbuxx=_deref_pbuc1 
    ldx cx16_conio
    // [90] call vera_layer_set_backcolor 
    // [393] phi from main::bgcolor1 to vera_layer_set_backcolor [phi:main::bgcolor1->vera_layer_set_backcolor]
    // [393] phi vera_layer_set_backcolor::color#2 = BLACK [phi:main::bgcolor1->vera_layer_set_backcolor#0] -- vbuaa=vbuc1 
    lda #BLACK
    // [393] phi vera_layer_set_backcolor::layer#2 = vera_layer_set_backcolor::layer#1 [phi:main::bgcolor1->vera_layer_set_backcolor#1] -- register_copy 
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
    // [416] phi from main::@22 to vera_layer_mode_tile [phi:main::@22->vera_layer_mode_tile]
    // [416] phi vera_layer_mode_tile::tileheight#10 = $10 [phi:main::@22->vera_layer_mode_tile#0] -- vbuz1=vbuc1 
    lda #$10
    sta.z vera_layer_mode_tile.tileheight
    // [416] phi vera_layer_mode_tile::tilewidth#10 = $10 [phi:main::@22->vera_layer_mode_tile#1] -- vbuz1=vbuc1 
    sta.z vera_layer_mode_tile.tilewidth
    // [416] phi vera_layer_mode_tile::tilebase_address#10 = VRAM_TILES_SMALL [phi:main::@22->vera_layer_mode_tile#2] -- vduz1=vduc1 
    lda #<VRAM_TILES_SMALL
    sta.z vera_layer_mode_tile.tilebase_address
    lda #>VRAM_TILES_SMALL
    sta.z vera_layer_mode_tile.tilebase_address+1
    lda #<VRAM_TILES_SMALL>>$10
    sta.z vera_layer_mode_tile.tilebase_address+2
    lda #>VRAM_TILES_SMALL>>$10
    sta.z vera_layer_mode_tile.tilebase_address+3
    // [416] phi vera_layer_mode_tile::mapbase_address#10 = VRAM_TILEMAP [phi:main::@22->vera_layer_mode_tile#3] -- vduz1=vduc1 
    lda #<VRAM_TILEMAP
    sta.z vera_layer_mode_tile.mapbase_address
    lda #>VRAM_TILEMAP
    sta.z vera_layer_mode_tile.mapbase_address+1
    lda #<VRAM_TILEMAP>>$10
    sta.z vera_layer_mode_tile.mapbase_address+2
    lda #>VRAM_TILEMAP>>$10
    sta.z vera_layer_mode_tile.mapbase_address+3
    // [416] phi vera_layer_mode_tile::mapheight#10 = $40 [phi:main::@22->vera_layer_mode_tile#4] -- vwuz1=vbuc1 
    lda #<$40
    sta.z vera_layer_mode_tile.mapheight
    lda #>$40
    sta.z vera_layer_mode_tile.mapheight+1
    // [416] phi vera_layer_mode_tile::layer#10 = 0 [phi:main::@22->vera_layer_mode_tile#5] -- vbuz1=vbuc1 
    lda #0
    sta.z vera_layer_mode_tile.layer
    // [416] phi vera_layer_mode_tile::mapwidth#10 = $40 [phi:main::@22->vera_layer_mode_tile#6] -- vwuz1=vbuc1 
    lda #<$40
    sta.z vera_layer_mode_tile.mapwidth
    lda #>$40
    sta.z vera_layer_mode_tile.mapwidth+1
    // [416] phi vera_layer_mode_tile::color_depth#3 = 4 [phi:main::@22->vera_layer_mode_tile#7] -- vbuxx=vbuc1 
    ldx #4
    jsr vera_layer_mode_tile
    // [95] phi from main::@22 to main::@23 [phi:main::@22->main::@23]
    // main::@23
    // cx16_load_ram_banked(1, 8, 0, FILE_SPRITES, (dword)BANK_PLAYER)
    // [96] call cx16_load_ram_banked 
    // [522] phi from main::@23 to cx16_load_ram_banked [phi:main::@23->cx16_load_ram_banked]
    // [522] phi cx16_load_ram_banked::filename#7 = FILE_SPRITES [phi:main::@23->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_SPRITES
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_SPRITES
    sta.z cx16_load_ram_banked.filename+1
    // [522] phi cx16_load_ram_banked::address#7 = BANK_PLAYER [phi:main::@23->cx16_load_ram_banked#1] -- vduz1=vduc1 
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
    // [589] phi from main::@8 to cputs [phi:main::@8->cputs]
    // [589] phi cputs::s#16 = main::s [phi:main::@8->cputs#0] -- pbuz1=pbuc1 
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
    // [597] phi from main::@26 to printf_uchar [phi:main::@26->printf_uchar]
    // [597] phi printf_uchar::format_radix#10 = HEXADECIMAL [phi:main::@26->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #HEXADECIMAL
    // [597] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#0 [phi:main::@26->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [104] phi from main::@26 to main::@27 [phi:main::@26->main::@27]
    // main::@27
    // printf("error file_sprites: %x\n",status)
    // [105] call cputs 
    // [589] phi from main::@27 to cputs [phi:main::@27->cputs]
    // [589] phi cputs::s#16 = main::s1 [phi:main::@27->cputs#0] -- pbuz1=pbuc1 
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
    // [522] phi from main::@1 to cx16_load_ram_banked [phi:main::@1->cx16_load_ram_banked]
    // [522] phi cx16_load_ram_banked::filename#7 = FILE_ENEMY2 [phi:main::@1->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_ENEMY2
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_ENEMY2
    sta.z cx16_load_ram_banked.filename+1
    // [522] phi cx16_load_ram_banked::address#7 = BANK_ENEMY2 [phi:main::@1->cx16_load_ram_banked#1] -- vduz1=vduc1 
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
    // [589] phi from main::@9 to cputs [phi:main::@9->cputs]
    // [589] phi cputs::s#16 = main::s2 [phi:main::@9->cputs#0] -- pbuz1=pbuc1 
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
    // [597] phi from main::@29 to printf_uchar [phi:main::@29->printf_uchar]
    // [597] phi printf_uchar::format_radix#10 = HEXADECIMAL [phi:main::@29->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #HEXADECIMAL
    // [597] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#1 [phi:main::@29->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [115] phi from main::@29 to main::@30 [phi:main::@29->main::@30]
    // main::@30
    // printf("error file_enemy2 = %x\n",status)
    // [116] call cputs 
    // [589] phi from main::@30 to cputs [phi:main::@30->cputs]
    // [589] phi cputs::s#16 = main::s1 [phi:main::@30->cputs#0] -- pbuz1=pbuc1 
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
    // [522] phi from main::@2 to cx16_load_ram_banked [phi:main::@2->cx16_load_ram_banked]
    // [522] phi cx16_load_ram_banked::filename#7 = FILE_TILES [phi:main::@2->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_TILES
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_TILES
    sta.z cx16_load_ram_banked.filename+1
    // [522] phi cx16_load_ram_banked::address#7 = BANK_TILES_SMALL [phi:main::@2->cx16_load_ram_banked#1] -- vduz1=vduc1 
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
    // [589] phi from main::@10 to cputs [phi:main::@10->cputs]
    // [589] phi cputs::s#16 = main::s4 [phi:main::@10->cputs#0] -- pbuz1=pbuc1 
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
    // [597] phi from main::@32 to printf_uchar [phi:main::@32->printf_uchar]
    // [597] phi printf_uchar::format_radix#10 = HEXADECIMAL [phi:main::@32->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #HEXADECIMAL
    // [597] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#2 [phi:main::@32->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [126] phi from main::@32 to main::@33 [phi:main::@32->main::@33]
    // main::@33
    // printf("error file_tiles = %x\n",status)
    // [127] call cputs 
    // [589] phi from main::@33 to cputs [phi:main::@33->cputs]
    // [589] phi cputs::s#16 = main::s1 [phi:main::@33->cputs#0] -- pbuz1=pbuc1 
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
    // [522] phi from main::@3 to cx16_load_ram_banked [phi:main::@3->cx16_load_ram_banked]
    // [522] phi cx16_load_ram_banked::filename#7 = FILE_SQUAREMETAL [phi:main::@3->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_SQUAREMETAL
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_SQUAREMETAL
    sta.z cx16_load_ram_banked.filename+1
    // [522] phi cx16_load_ram_banked::address#7 = BANK_SQUAREMETAL [phi:main::@3->cx16_load_ram_banked#1] -- vduz1=vduc1 
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
    // [589] phi from main::@11 to cputs [phi:main::@11->cputs]
    // [589] phi cputs::s#16 = main::s6 [phi:main::@11->cputs#0] -- pbuz1=pbuc1 
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
    // [597] phi from main::@35 to printf_uchar [phi:main::@35->printf_uchar]
    // [597] phi printf_uchar::format_radix#10 = HEXADECIMAL [phi:main::@35->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #HEXADECIMAL
    // [597] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#3 [phi:main::@35->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [137] phi from main::@35 to main::@36 [phi:main::@35->main::@36]
    // main::@36
    // printf("error file_squaremetal = %x\n",status)
    // [138] call cputs 
    // [589] phi from main::@36 to cputs [phi:main::@36->cputs]
    // [589] phi cputs::s#16 = main::s1 [phi:main::@36->cputs#0] -- pbuz1=pbuc1 
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
    // [522] phi from main::@4 to cx16_load_ram_banked [phi:main::@4->cx16_load_ram_banked]
    // [522] phi cx16_load_ram_banked::filename#7 = FILE_TILEMETAL [phi:main::@4->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_TILEMETAL
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_TILEMETAL
    sta.z cx16_load_ram_banked.filename+1
    // [522] phi cx16_load_ram_banked::address#7 = BANK_TILEMETAL [phi:main::@4->cx16_load_ram_banked#1] -- vduz1=vduc1 
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
    // [589] phi from main::@12 to cputs [phi:main::@12->cputs]
    // [589] phi cputs::s#16 = main::s8 [phi:main::@12->cputs#0] -- pbuz1=pbuc1 
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
    // [597] phi from main::@38 to printf_uchar [phi:main::@38->printf_uchar]
    // [597] phi printf_uchar::format_radix#10 = HEXADECIMAL [phi:main::@38->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #HEXADECIMAL
    // [597] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#4 [phi:main::@38->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [148] phi from main::@38 to main::@39 [phi:main::@38->main::@39]
    // main::@39
    // printf("error file_tilemetal = %x\n",status)
    // [149] call cputs 
    // [589] phi from main::@39 to cputs [phi:main::@39->cputs]
    // [589] phi cputs::s#16 = main::s1 [phi:main::@39->cputs#0] -- pbuz1=pbuc1 
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
    // [522] phi from main::@5 to cx16_load_ram_banked [phi:main::@5->cx16_load_ram_banked]
    // [522] phi cx16_load_ram_banked::filename#7 = FILE_SQUARERASTER [phi:main::@5->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_SQUARERASTER
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_SQUARERASTER
    sta.z cx16_load_ram_banked.filename+1
    // [522] phi cx16_load_ram_banked::address#7 = BANK_SQUARERASTER [phi:main::@5->cx16_load_ram_banked#1] -- vduz1=vduc1 
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
    // [589] phi from main::@13 to cputs [phi:main::@13->cputs]
    // [589] phi cputs::s#16 = main::s10 [phi:main::@13->cputs#0] -- pbuz1=pbuc1 
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
    // [597] phi from main::@41 to printf_uchar [phi:main::@41->printf_uchar]
    // [597] phi printf_uchar::format_radix#10 = HEXADECIMAL [phi:main::@41->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #HEXADECIMAL
    // [597] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#5 [phi:main::@41->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [159] phi from main::@41 to main::@42 [phi:main::@41->main::@42]
    // main::@42
    // printf("error file_squareraster = %x\n",status)
    // [160] call cputs 
    // [589] phi from main::@42 to cputs [phi:main::@42->cputs]
    // [589] phi cputs::s#16 = main::s1 [phi:main::@42->cputs#0] -- pbuz1=pbuc1 
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
    // [522] phi from main::@6 to cx16_load_ram_banked [phi:main::@6->cx16_load_ram_banked]
    // [522] phi cx16_load_ram_banked::filename#7 = FILE_PALETTES [phi:main::@6->cx16_load_ram_banked#0] -- pbuz1=pbuc1 
    lda #<FILE_PALETTES
    sta.z cx16_load_ram_banked.filename
    lda #>FILE_PALETTES
    sta.z cx16_load_ram_banked.filename+1
    // [522] phi cx16_load_ram_banked::address#7 = BANK_PALETTE [phi:main::@6->cx16_load_ram_banked#1] -- vduz1=vduc1 
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
    // [589] phi from main::@14 to cputs [phi:main::@14->cputs]
    // [589] phi cputs::s#16 = main::s12 [phi:main::@14->cputs#0] -- pbuz1=pbuc1 
    lda #<s12
    sta.z cputs.s
    lda #>s12
    sta.z cputs.s+1
    jsr cputs
    // main::@51
    // printf("error file_palettes = %u",status)
    // [168] printf_uchar::uvalue#6 = main::status#13 -- vbuxx=vbuz1 
    ldx.z status_5
    // [169] call printf_uchar 
    // [597] phi from main::@51 to printf_uchar [phi:main::@51->printf_uchar]
    // [597] phi printf_uchar::format_radix#10 = DECIMAL [phi:main::@51->printf_uchar#0] -- vbuyy=vbuc1 
    ldy #DECIMAL
    // [597] phi printf_uchar::uvalue#10 = printf_uchar::uvalue#6 [phi:main::@51->printf_uchar#1] -- register_copy 
    jsr printf_uchar
    // [170] phi from main::@40 main::@51 to main::@7 [phi:main::@40/main::@51->main::@7]
    // main::@7
  __b7:
    // memcpy_bank_to_vram(VRAM_PLAYER, BANK_PLAYER, (dword)32*32*NUM_PLAYER/2)
    // [171] call memcpy_bank_to_vram 
  // Copy graphics to the VERA VRAM.
    // [605] phi from main::@7 to memcpy_bank_to_vram [phi:main::@7->memcpy_bank_to_vram]
    // [605] phi memcpy_bank_to_vram::num#7 = $20*$20*NUM_PLAYER/2 [phi:main::@7->memcpy_bank_to_vram#0] -- vduz1=vduc1 
    lda #<$20*$20*NUM_PLAYER/2
    sta.z memcpy_bank_to_vram.num
    lda #>$20*$20*NUM_PLAYER/2
    sta.z memcpy_bank_to_vram.num+1
    lda #<$20*$20*NUM_PLAYER/2>>$10
    sta.z memcpy_bank_to_vram.num+2
    lda #>$20*$20*NUM_PLAYER/2>>$10
    sta.z memcpy_bank_to_vram.num+3
    // [605] phi memcpy_bank_to_vram::beg#0 = BANK_PLAYER [phi:main::@7->memcpy_bank_to_vram#1] -- vduz1=vduc1 
    lda #<BANK_PLAYER
    sta.z memcpy_bank_to_vram.beg
    lda #>BANK_PLAYER
    sta.z memcpy_bank_to_vram.beg+1
    lda #<BANK_PLAYER>>$10
    sta.z memcpy_bank_to_vram.beg+2
    lda #>BANK_PLAYER>>$10
    sta.z memcpy_bank_to_vram.beg+3
    // [605] phi memcpy_bank_to_vram::vdest#7 = VRAM_PLAYER [phi:main::@7->memcpy_bank_to_vram#2] -- vduz1=vduc1 
    lda #<VRAM_PLAYER
    sta.z memcpy_bank_to_vram.vdest
    lda #>VRAM_PLAYER
    sta.z memcpy_bank_to_vram.vdest+1
    lda #<VRAM_PLAYER>>$10
    sta.z memcpy_bank_to_vram.vdest+2
    lda #>VRAM_PLAYER>>$10
    sta.z memcpy_bank_to_vram.vdest+3
    jsr memcpy_bank_to_vram
    // [172] phi from main::@7 to main::@43 [phi:main::@7->main::@43]
    // main::@43
    // memcpy_bank_to_vram(VRAM_ENEMY2, BANK_ENEMY2, (dword)32*32*NUM_ENEMY2/2)
    // [173] call memcpy_bank_to_vram 
    // [605] phi from main::@43 to memcpy_bank_to_vram [phi:main::@43->memcpy_bank_to_vram]
    // [605] phi memcpy_bank_to_vram::num#7 = $20*$20*NUM_ENEMY2/2 [phi:main::@43->memcpy_bank_to_vram#0] -- vduz1=vduc1 
    lda #<$20*$20*NUM_ENEMY2/2
    sta.z memcpy_bank_to_vram.num
    lda #>$20*$20*NUM_ENEMY2/2
    sta.z memcpy_bank_to_vram.num+1
    lda #<$20*$20*NUM_ENEMY2/2>>$10
    sta.z memcpy_bank_to_vram.num+2
    lda #>$20*$20*NUM_ENEMY2/2>>$10
    sta.z memcpy_bank_to_vram.num+3
    // [605] phi memcpy_bank_to_vram::beg#0 = BANK_ENEMY2 [phi:main::@43->memcpy_bank_to_vram#1] -- vduz1=vduc1 
    lda #<BANK_ENEMY2
    sta.z memcpy_bank_to_vram.beg
    lda #>BANK_ENEMY2
    sta.z memcpy_bank_to_vram.beg+1
    lda #<BANK_ENEMY2>>$10
    sta.z memcpy_bank_to_vram.beg+2
    lda #>BANK_ENEMY2>>$10
    sta.z memcpy_bank_to_vram.beg+3
    // [605] phi memcpy_bank_to_vram::vdest#7 = VRAM_ENEMY2 [phi:main::@43->memcpy_bank_to_vram#2] -- vduz1=vduc1 
    lda #<VRAM_ENEMY2
    sta.z memcpy_bank_to_vram.vdest
    lda #>VRAM_ENEMY2
    sta.z memcpy_bank_to_vram.vdest+1
    lda #<VRAM_ENEMY2>>$10
    sta.z memcpy_bank_to_vram.vdest+2
    lda #>VRAM_ENEMY2>>$10
    sta.z memcpy_bank_to_vram.vdest+3
    jsr memcpy_bank_to_vram
    // [174] phi from main::@43 to main::@44 [phi:main::@43->main::@44]
    // main::@44
    // memcpy_bank_to_vram(VRAM_TILES_SMALL, BANK_TILES_SMALL, (dword)32*32*(NUM_TILES_SMALL)/2)
    // [175] call memcpy_bank_to_vram 
    // [605] phi from main::@44 to memcpy_bank_to_vram [phi:main::@44->memcpy_bank_to_vram]
    // [605] phi memcpy_bank_to_vram::num#7 = $20*$20*NUM_TILES_SMALL/2 [phi:main::@44->memcpy_bank_to_vram#0] -- vduz1=vduc1 
    lda #<$20*$20*NUM_TILES_SMALL/2
    sta.z memcpy_bank_to_vram.num
    lda #>$20*$20*NUM_TILES_SMALL/2
    sta.z memcpy_bank_to_vram.num+1
    lda #<$20*$20*NUM_TILES_SMALL/2>>$10
    sta.z memcpy_bank_to_vram.num+2
    lda #>$20*$20*NUM_TILES_SMALL/2>>$10
    sta.z memcpy_bank_to_vram.num+3
    // [605] phi memcpy_bank_to_vram::beg#0 = BANK_TILES_SMALL [phi:main::@44->memcpy_bank_to_vram#1] -- vduz1=vduc1 
    lda #<BANK_TILES_SMALL
    sta.z memcpy_bank_to_vram.beg
    lda #>BANK_TILES_SMALL
    sta.z memcpy_bank_to_vram.beg+1
    lda #<BANK_TILES_SMALL>>$10
    sta.z memcpy_bank_to_vram.beg+2
    lda #>BANK_TILES_SMALL>>$10
    sta.z memcpy_bank_to_vram.beg+3
    // [605] phi memcpy_bank_to_vram::vdest#7 = VRAM_TILES_SMALL [phi:main::@44->memcpy_bank_to_vram#2] -- vduz1=vduc1 
    lda #<VRAM_TILES_SMALL
    sta.z memcpy_bank_to_vram.vdest
    lda #>VRAM_TILES_SMALL
    sta.z memcpy_bank_to_vram.vdest+1
    lda #<VRAM_TILES_SMALL>>$10
    sta.z memcpy_bank_to_vram.vdest+2
    lda #>VRAM_TILES_SMALL>>$10
    sta.z memcpy_bank_to_vram.vdest+3
    jsr memcpy_bank_to_vram
    // [176] phi from main::@44 to main::@45 [phi:main::@44->main::@45]
    // main::@45
    // memcpy_bank_to_vram(VRAM_SQUAREMETAL, BANK_SQUAREMETAL, (dword)64*64*(NUM_SQUAREMETAL)/2)
    // [177] call memcpy_bank_to_vram 
    // [605] phi from main::@45 to memcpy_bank_to_vram [phi:main::@45->memcpy_bank_to_vram]
    // [605] phi memcpy_bank_to_vram::num#7 = $40*$40*NUM_SQUAREMETAL/2 [phi:main::@45->memcpy_bank_to_vram#0] -- vduz1=vduc1 
    lda #<$40*$40*NUM_SQUAREMETAL/2
    sta.z memcpy_bank_to_vram.num
    lda #>$40*$40*NUM_SQUAREMETAL/2
    sta.z memcpy_bank_to_vram.num+1
    lda #<$40*$40*NUM_SQUAREMETAL/2>>$10
    sta.z memcpy_bank_to_vram.num+2
    lda #>$40*$40*NUM_SQUAREMETAL/2>>$10
    sta.z memcpy_bank_to_vram.num+3
    // [605] phi memcpy_bank_to_vram::beg#0 = BANK_SQUAREMETAL [phi:main::@45->memcpy_bank_to_vram#1] -- vduz1=vduc1 
    lda #<BANK_SQUAREMETAL
    sta.z memcpy_bank_to_vram.beg
    lda #>BANK_SQUAREMETAL
    sta.z memcpy_bank_to_vram.beg+1
    lda #<BANK_SQUAREMETAL>>$10
    sta.z memcpy_bank_to_vram.beg+2
    lda #>BANK_SQUAREMETAL>>$10
    sta.z memcpy_bank_to_vram.beg+3
    // [605] phi memcpy_bank_to_vram::vdest#7 = VRAM_SQUAREMETAL [phi:main::@45->memcpy_bank_to_vram#2] -- vduz1=vduc1 
    lda #<VRAM_SQUAREMETAL
    sta.z memcpy_bank_to_vram.vdest
    lda #>VRAM_SQUAREMETAL
    sta.z memcpy_bank_to_vram.vdest+1
    lda #<VRAM_SQUAREMETAL>>$10
    sta.z memcpy_bank_to_vram.vdest+2
    lda #>VRAM_SQUAREMETAL>>$10
    sta.z memcpy_bank_to_vram.vdest+3
    jsr memcpy_bank_to_vram
    // [178] phi from main::@45 to main::@46 [phi:main::@45->main::@46]
    // main::@46
    // memcpy_bank_to_vram(VRAM_TILEMETAL, BANK_TILEMETAL, (dword)64*64*(NUM_TILEMETAL)/2)
    // [179] call memcpy_bank_to_vram 
    // [605] phi from main::@46 to memcpy_bank_to_vram [phi:main::@46->memcpy_bank_to_vram]
    // [605] phi memcpy_bank_to_vram::num#7 = $40*$40*NUM_TILEMETAL/2 [phi:main::@46->memcpy_bank_to_vram#0] -- vduz1=vduc1 
    lda #<$40*$40*NUM_TILEMETAL/2
    sta.z memcpy_bank_to_vram.num
    lda #>$40*$40*NUM_TILEMETAL/2
    sta.z memcpy_bank_to_vram.num+1
    lda #<$40*$40*NUM_TILEMETAL/2>>$10
    sta.z memcpy_bank_to_vram.num+2
    lda #>$40*$40*NUM_TILEMETAL/2>>$10
    sta.z memcpy_bank_to_vram.num+3
    // [605] phi memcpy_bank_to_vram::beg#0 = BANK_TILEMETAL [phi:main::@46->memcpy_bank_to_vram#1] -- vduz1=vduc1 
    lda #<BANK_TILEMETAL
    sta.z memcpy_bank_to_vram.beg
    lda #>BANK_TILEMETAL
    sta.z memcpy_bank_to_vram.beg+1
    lda #<BANK_TILEMETAL>>$10
    sta.z memcpy_bank_to_vram.beg+2
    lda #>BANK_TILEMETAL>>$10
    sta.z memcpy_bank_to_vram.beg+3
    // [605] phi memcpy_bank_to_vram::vdest#7 = VRAM_TILEMETAL [phi:main::@46->memcpy_bank_to_vram#2] -- vduz1=vduc1 
    lda #<VRAM_TILEMETAL
    sta.z memcpy_bank_to_vram.vdest
    lda #>VRAM_TILEMETAL
    sta.z memcpy_bank_to_vram.vdest+1
    lda #<VRAM_TILEMETAL>>$10
    sta.z memcpy_bank_to_vram.vdest+2
    lda #>VRAM_TILEMETAL>>$10
    sta.z memcpy_bank_to_vram.vdest+3
    jsr memcpy_bank_to_vram
    // [180] phi from main::@46 to main::@47 [phi:main::@46->main::@47]
    // main::@47
    // memcpy_bank_to_vram(VRAM_SQUARERASTER, BANK_SQUARERASTER, (dword)64*64*(NUM_SQUARERASTER)/2)
    // [181] call memcpy_bank_to_vram 
    // [605] phi from main::@47 to memcpy_bank_to_vram [phi:main::@47->memcpy_bank_to_vram]
    // [605] phi memcpy_bank_to_vram::num#7 = $40*$40*NUM_SQUARERASTER/2 [phi:main::@47->memcpy_bank_to_vram#0] -- vduz1=vduc1 
    lda #<$40*$40*NUM_SQUARERASTER/2
    sta.z memcpy_bank_to_vram.num
    lda #>$40*$40*NUM_SQUARERASTER/2
    sta.z memcpy_bank_to_vram.num+1
    lda #<$40*$40*NUM_SQUARERASTER/2>>$10
    sta.z memcpy_bank_to_vram.num+2
    lda #>$40*$40*NUM_SQUARERASTER/2>>$10
    sta.z memcpy_bank_to_vram.num+3
    // [605] phi memcpy_bank_to_vram::beg#0 = BANK_SQUARERASTER [phi:main::@47->memcpy_bank_to_vram#1] -- vduz1=vduc1 
    lda #<BANK_SQUARERASTER
    sta.z memcpy_bank_to_vram.beg
    lda #>BANK_SQUARERASTER
    sta.z memcpy_bank_to_vram.beg+1
    lda #<BANK_SQUARERASTER>>$10
    sta.z memcpy_bank_to_vram.beg+2
    lda #>BANK_SQUARERASTER>>$10
    sta.z memcpy_bank_to_vram.beg+3
    // [605] phi memcpy_bank_to_vram::vdest#7 = VRAM_SQUARERASTER [phi:main::@47->memcpy_bank_to_vram#2] -- vduz1=vduc1 
    lda #<VRAM_SQUARERASTER
    sta.z memcpy_bank_to_vram.vdest
    lda #>VRAM_SQUARERASTER
    sta.z memcpy_bank_to_vram.vdest+1
    lda #<VRAM_SQUARERASTER>>$10
    sta.z memcpy_bank_to_vram.vdest+2
    lda #>VRAM_SQUARERASTER>>$10
    sta.z memcpy_bank_to_vram.vdest+3
    jsr memcpy_bank_to_vram
    // [182] phi from main::@47 to main::@48 [phi:main::@47->main::@48]
    // main::@48
    // memcpy_bank_to_vram(VERA_PALETTE+32, BANK_PALETTE, (dword)32*6)
    // [183] call memcpy_bank_to_vram 
  // Load the palette in VERA palette registers, but keep the first 16 colors untouched.
    // [605] phi from main::@48 to memcpy_bank_to_vram [phi:main::@48->memcpy_bank_to_vram]
    // [605] phi memcpy_bank_to_vram::num#7 = $20*6 [phi:main::@48->memcpy_bank_to_vram#0] -- vduz1=vduc1 
    lda #<$20*6
    sta.z memcpy_bank_to_vram.num
    lda #>$20*6
    sta.z memcpy_bank_to_vram.num+1
    lda #<$20*6>>$10
    sta.z memcpy_bank_to_vram.num+2
    lda #>$20*6>>$10
    sta.z memcpy_bank_to_vram.num+3
    // [605] phi memcpy_bank_to_vram::beg#0 = BANK_PALETTE [phi:main::@48->memcpy_bank_to_vram#1] -- vduz1=vduc1 
    lda #<BANK_PALETTE
    sta.z memcpy_bank_to_vram.beg
    lda #>BANK_PALETTE
    sta.z memcpy_bank_to_vram.beg+1
    lda #<BANK_PALETTE>>$10
    sta.z memcpy_bank_to_vram.beg+2
    lda #>BANK_PALETTE>>$10
    sta.z memcpy_bank_to_vram.beg+3
    // [605] phi memcpy_bank_to_vram::vdest#7 = VERA_PALETTE+$20 [phi:main::@48->memcpy_bank_to_vram#2] -- vduz1=vduc1 
    lda #<VERA_PALETTE+$20
    sta.z memcpy_bank_to_vram.vdest
    lda #>VERA_PALETTE+$20
    sta.z memcpy_bank_to_vram.vdest+1
    lda #<VERA_PALETTE+$20>>$10
    sta.z memcpy_bank_to_vram.vdest+2
    lda #>VERA_PALETTE+$20>>$10
    sta.z memcpy_bank_to_vram.vdest+3
    jsr memcpy_bank_to_vram
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
    // [648] phi from main::@18 to tile_background [phi:main::@18->tile_background]
    jsr tile_background
    // [188] phi from main::@18 to main::@49 [phi:main::@18->main::@49]
    // main::@49
    // create_sprites_player()
    // [189] call create_sprites_player 
    // [669] phi from main::@49 to create_sprites_player [phi:main::@49->create_sprites_player]
    jsr create_sprites_player
    // [190] phi from main::@49 to main::@50 [phi:main::@49->main::@50]
    // main::@50
    // create_sprites_enemy2()
    // [191] call create_sprites_enemy2 
    // [804] phi from main::@50 to create_sprites_enemy2 [phi:main::@50->create_sprites_enemy2]
    jsr create_sprites_enemy2
    // main::vera_sprite_on1
    // *VERA_CTRL &= ~VERA_DCSEL
    // [192] *VERA_CTRL = *VERA_CTRL & ~VERA_DCSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
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
    // [198] phi from main::@52 main::CLI1 to main::@15 [phi:main::@52/main::CLI1->main::@15]
    // main::@15
  __b15:
    // kbhit()
    // [199] call kbhit 
    jsr kbhit
    // [200] kbhit::return#2 = kbhit::return#1
    // main::@52
    // [201] main::$49 = kbhit::return#2
    // while(!kbhit())
    // [202] if(0==main::$49) goto main::@15 -- 0_eq_vbuaa_then_la1 
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
// rotate_sprites(byte zp(3) base, word zp($37) rotate, word zp($35) max, dword* zp($39) spriteaddresses, word zp(6) basex)
rotate_sprites: {
    .label __8 = 8
    .label __11 = $47
    .label __14 = 8
    .label __15 = 8
    .label __16 = $47
    .label vera_sprite_address1___0 = 8
    .label vera_sprite_address1___4 = 8
    .label vera_sprite_address1___5 = 8
    .label vera_sprite_address1___7 = 8
    .label vera_sprite_address1___9 = $46
    .label vera_sprite_address1___10 = 8
    .label vera_sprite_address1___14 = 8
    .label vera_sprite_xy1___4 = $49
    .label vera_sprite_xy1___10 = $49
    .label i = 8
    .label vera_sprite_address1_address = $42
    .label vera_sprite_address1_sprite_offset = 8
    .label vera_sprite_xy1_sprite = 4
    .label vera_sprite_xy1_x = 8
    .label vera_sprite_xy1_y = $47
    .label vera_sprite_xy1_sprite_offset = $49
    .label rotate = $37
    .label max = $35
    .label base = 3
    .label spriteaddresses = $39
    .label basex = 6
    .label __17 = 8
    // [206] phi from rotate_sprites to rotate_sprites::@1 [phi:rotate_sprites->rotate_sprites::@1]
    // [206] phi rotate_sprites::s#2 = 0 [phi:rotate_sprites->rotate_sprites::@1#0] -- vbuxx=vbuc1 
    ldx #0
    // rotate_sprites::@1
  __b1:
    // for(byte s=0;s<max;s++)
    // [207] if(rotate_sprites::s#2<rotate_sprites::max#5) goto rotate_sprites::@2 -- vbuxx_lt_vwuz1_then_la1 
    lda.z max+1
    bne __b2
    cpx.z max
    bcc __b2
    // rotate_sprites::@return
    // }
    // [208] return 
    rts
    // rotate_sprites::@2
  __b2:
    // i = s+rotate
    // [209] rotate_sprites::i#0 = rotate_sprites::s#2 + rotate_sprites::rotate#4 -- vwuz1=vbuxx_plus_vwuz2 
    txa
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
    // vera_sprite_address(s+base, spriteaddresses[i])
    // [213] rotate_sprites::vera_sprite_xy1_sprite#0 = rotate_sprites::s#2 + rotate_sprites::base#8 -- vbuz1=vbuxx_plus_vbuz2 
    txa
    clc
    adc.z base
    sta.z vera_sprite_xy1_sprite
    // [214] rotate_sprites::$14 = rotate_sprites::i#2 << 2 -- vwuz1=vwuz1_rol_2 
    asl.z __14
    rol.z __14+1
    asl.z __14
    rol.z __14+1
    // [215] rotate_sprites::$17 = rotate_sprites::spriteaddresses#6 + rotate_sprites::$14 -- pduz1=pduz2_plus_vwuz1 
    lda.z __17
    clc
    adc.z spriteaddresses
    sta.z __17
    lda.z __17+1
    adc.z spriteaddresses+1
    sta.z __17+1
    // [216] rotate_sprites::vera_sprite_address1_address#0 = *rotate_sprites::$17 -- vduz1=_deref_pduz2 
    ldy #0
    lda (__17),y
    sta.z vera_sprite_address1_address
    iny
    lda (__17),y
    sta.z vera_sprite_address1_address+1
    iny
    lda (__17),y
    sta.z vera_sprite_address1_address+2
    iny
    lda (__17),y
    sta.z vera_sprite_address1_address+3
    // rotate_sprites::vera_sprite_address1
    // (word)sprite << 3
    // [217] rotate_sprites::vera_sprite_address1_$14 = (word)rotate_sprites::vera_sprite_xy1_sprite#0 -- vwuz1=_word_vbuz2 
    lda.z vera_sprite_xy1_sprite
    sta.z vera_sprite_address1___14
    lda #0
    sta.z vera_sprite_address1___14+1
    // [218] rotate_sprites::vera_sprite_address1_$0 = rotate_sprites::vera_sprite_address1_$14 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_address1___0
    rol.z vera_sprite_address1___0+1
    asl.z vera_sprite_address1___0
    rol.z vera_sprite_address1___0+1
    asl.z vera_sprite_address1___0
    rol.z vera_sprite_address1___0+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [219] rotate_sprites::vera_sprite_address1_sprite_offset#0 = <VERA_SPRITE_ATTR + rotate_sprites::vera_sprite_address1_$0 -- vwuz1=vwuc1_plus_vwuz1 
    clc
    lda.z vera_sprite_address1_sprite_offset
    adc #<VERA_SPRITE_ATTR&$ffff
    sta.z vera_sprite_address1_sprite_offset
    lda.z vera_sprite_address1_sprite_offset+1
    adc #>VERA_SPRITE_ATTR&$ffff
    sta.z vera_sprite_address1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [220] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <sprite_offset
    // [221] rotate_sprites::vera_sprite_address1_$2 = < rotate_sprites::vera_sprite_address1_sprite_offset#0 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_address1_sprite_offset
    // *VERA_ADDRX_L = <sprite_offset
    // [222] *VERA_ADDRX_L = rotate_sprites::vera_sprite_address1_$2 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset
    // [223] rotate_sprites::vera_sprite_address1_$3 = > rotate_sprites::vera_sprite_address1_sprite_offset#0 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_address1_sprite_offset+1
    // *VERA_ADDRX_M = >sprite_offset
    // [224] *VERA_ADDRX_M = rotate_sprites::vera_sprite_address1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_1 | <(>VERA_SPRITE_ATTR)
    // [225] *VERA_ADDRX_H = VERA_INC_1|<>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #VERA_INC_1|(<(VERA_SPRITE_ATTR>>$10))
    sta VERA_ADDRX_H
    // <address
    // [226] rotate_sprites::vera_sprite_address1_$4 = < rotate_sprites::vera_sprite_address1_address#0 -- vwuz1=_lo_vduz2 
    lda.z vera_sprite_address1_address
    sta.z vera_sprite_address1___4
    lda.z vera_sprite_address1_address+1
    sta.z vera_sprite_address1___4+1
    // (<address)>>5
    // [227] rotate_sprites::vera_sprite_address1_$5 = rotate_sprites::vera_sprite_address1_$4 >> 5 -- vwuz1=vwuz1_ror_5 
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    // <((<address)>>5)
    // [228] rotate_sprites::vera_sprite_address1_$6 = < rotate_sprites::vera_sprite_address1_$5 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_address1___5
    // *VERA_DATA0 = <((<address)>>5)
    // [229] *VERA_DATA0 = rotate_sprites::vera_sprite_address1_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // <address
    // [230] rotate_sprites::vera_sprite_address1_$7 = < rotate_sprites::vera_sprite_address1_address#0 -- vwuz1=_lo_vduz2 
    lda.z vera_sprite_address1_address
    sta.z vera_sprite_address1___7
    lda.z vera_sprite_address1_address+1
    sta.z vera_sprite_address1___7+1
    // >(<address)
    // [231] rotate_sprites::vera_sprite_address1_$8 = > rotate_sprites::vera_sprite_address1_$7 -- vbuaa=_hi_vwuz1 
    // (>(<address))>>5
    // [232] rotate_sprites::vera_sprite_address1_$9 = rotate_sprites::vera_sprite_address1_$8 >> 5 -- vbuz1=vbuaa_ror_5 
    lsr
    lsr
    lsr
    lsr
    lsr
    sta.z vera_sprite_address1___9
    // >address
    // [233] rotate_sprites::vera_sprite_address1_$10 = > rotate_sprites::vera_sprite_address1_address#0 -- vwuz1=_hi_vduz2 
    lda.z vera_sprite_address1_address+2
    sta.z vera_sprite_address1___10
    lda.z vera_sprite_address1_address+3
    sta.z vera_sprite_address1___10+1
    // <(>address)
    // [234] rotate_sprites::vera_sprite_address1_$11 = < rotate_sprites::vera_sprite_address1_$10 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_address1___10
    // (<(>address))<<3
    // [235] rotate_sprites::vera_sprite_address1_$12 = rotate_sprites::vera_sprite_address1_$11 << 3 -- vbuaa=vbuaa_rol_3 
    asl
    asl
    asl
    // ((>(<address))>>5)|((<(>address))<<3)
    // [236] rotate_sprites::vera_sprite_address1_$13 = rotate_sprites::vera_sprite_address1_$9 | rotate_sprites::vera_sprite_address1_$12 -- vbuaa=vbuz1_bor_vbuaa 
    ora.z vera_sprite_address1___9
    // *VERA_DATA0 = ((>(<address))>>5)|((<(>address))<<3)
    // [237] *VERA_DATA0 = rotate_sprites::vera_sprite_address1_$13 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // rotate_sprites::@5
    // s&03
    // [238] rotate_sprites::$7 = rotate_sprites::s#2 & 3 -- vbuaa=vbuxx_band_vbuc1 
    txa
    and #3
    // (word)(s&03)<<6
    // [239] rotate_sprites::$15 = (word)rotate_sprites::$7 -- vwuz1=_word_vbuaa 
    sta.z __15
    lda #0
    sta.z __15+1
    // [240] rotate_sprites::$8 = rotate_sprites::$15 << 6 -- vwuz1=vwuz1_rol_6 
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
    // vera_sprite_xy(s+base, basex+((word)(s&03)<<6), basey+((word)(s>>2)<<6))
    // [241] rotate_sprites::vera_sprite_xy1_x#0 = rotate_sprites::basex#8 + rotate_sprites::$8 -- vwuz1=vwuz2_plus_vwuz1 
    lda.z vera_sprite_xy1_x
    clc
    adc.z basex
    sta.z vera_sprite_xy1_x
    lda.z vera_sprite_xy1_x+1
    adc.z basex+1
    sta.z vera_sprite_xy1_x+1
    // s>>2
    // [242] rotate_sprites::$10 = rotate_sprites::s#2 >> 2 -- vbuaa=vbuxx_ror_2 
    txa
    lsr
    lsr
    // (word)(s>>2)<<6
    // [243] rotate_sprites::$16 = (word)rotate_sprites::$10 -- vwuz1=_word_vbuaa 
    sta.z __16
    lda #0
    sta.z __16+1
    // [244] rotate_sprites::$11 = rotate_sprites::$16 << 6 -- vwuz1=vwuz1_rol_6 
    lda.z __11+1
    lsr
    sta.z $ff
    lda.z __11
    ror
    sta.z __11+1
    lda #0
    ror
    sta.z __11
    lsr.z $ff
    ror.z __11+1
    ror.z __11
    // vera_sprite_xy(s+base, basex+((word)(s&03)<<6), basey+((word)(s>>2)<<6))
    // [245] rotate_sprites::vera_sprite_xy1_y#0 = $64 + rotate_sprites::$11 -- vwuz1=vbuc1_plus_vwuz1 
    lda #$64
    clc
    adc.z vera_sprite_xy1_y
    sta.z vera_sprite_xy1_y
    bcc !+
    inc.z vera_sprite_xy1_y+1
  !:
    // rotate_sprites::vera_sprite_xy1
    // (word)sprite << 3
    // [246] rotate_sprites::vera_sprite_xy1_$10 = (word)rotate_sprites::vera_sprite_xy1_sprite#0 -- vwuz1=_word_vbuz2 
    lda.z vera_sprite_xy1_sprite
    sta.z vera_sprite_xy1___10
    lda #0
    sta.z vera_sprite_xy1___10+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [247] rotate_sprites::vera_sprite_xy1_sprite_offset#0 = rotate_sprites::vera_sprite_xy1_$10 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_xy1_sprite_offset
    rol.z vera_sprite_xy1_sprite_offset+1
    asl.z vera_sprite_xy1_sprite_offset
    rol.z vera_sprite_xy1_sprite_offset+1
    asl.z vera_sprite_xy1_sprite_offset
    rol.z vera_sprite_xy1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [248] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+2
    // [249] rotate_sprites::vera_sprite_xy1_$4 = rotate_sprites::vera_sprite_xy1_sprite_offset#0 + <VERA_SPRITE_ATTR+2 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_xy1___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+2
    sta.z vera_sprite_xy1___4
    lda.z vera_sprite_xy1___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+2
    sta.z vera_sprite_xy1___4+1
    // <sprite_offset+2
    // [250] rotate_sprites::vera_sprite_xy1_$3 = < rotate_sprites::vera_sprite_xy1_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_xy1___4
    // *VERA_ADDRX_L = <sprite_offset+2
    // [251] *VERA_ADDRX_L = rotate_sprites::vera_sprite_xy1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+2
    // [252] rotate_sprites::vera_sprite_xy1_$5 = > rotate_sprites::vera_sprite_xy1_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_xy1___4+1
    // *VERA_ADDRX_M = >sprite_offset+2
    // [253] *VERA_ADDRX_M = rotate_sprites::vera_sprite_xy1_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_1 | <(>VERA_SPRITE_ATTR)
    // [254] *VERA_ADDRX_H = VERA_INC_1|<>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #VERA_INC_1|(<(VERA_SPRITE_ATTR>>$10))
    sta VERA_ADDRX_H
    // <x
    // [255] rotate_sprites::vera_sprite_xy1_$6 = < rotate_sprites::vera_sprite_xy1_x#0 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_xy1_x
    // *VERA_DATA0 = <x
    // [256] *VERA_DATA0 = rotate_sprites::vera_sprite_xy1_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // >x
    // [257] rotate_sprites::vera_sprite_xy1_$7 = > rotate_sprites::vera_sprite_xy1_x#0 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_xy1_x+1
    // *VERA_DATA0 = >x
    // [258] *VERA_DATA0 = rotate_sprites::vera_sprite_xy1_$7 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // <y
    // [259] rotate_sprites::vera_sprite_xy1_$8 = < rotate_sprites::vera_sprite_xy1_y#0 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_xy1_y
    // *VERA_DATA0 = <y
    // [260] *VERA_DATA0 = rotate_sprites::vera_sprite_xy1_$8 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // >y
    // [261] rotate_sprites::vera_sprite_xy1_$9 = > rotate_sprites::vera_sprite_xy1_y#0 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_xy1_y+1
    // *VERA_DATA0 = >y
    // [262] *VERA_DATA0 = rotate_sprites::vera_sprite_xy1_$9 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // rotate_sprites::@6
    // for(byte s=0;s<max;s++)
    // [263] rotate_sprites::s#1 = ++ rotate_sprites::s#2 -- vbuxx=_inc_vbuxx 
    inx
    // [206] phi from rotate_sprites::@6 to rotate_sprites::@1 [phi:rotate_sprites::@6->rotate_sprites::@1]
    // [206] phi rotate_sprites::s#2 = rotate_sprites::s#1 [phi:rotate_sprites::@6->rotate_sprites::@1#0] -- register_copy 
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
// memcpy_in_vram(byte zp($c) dest_bank, void* zp($a) dest, byte register(Y) src_bank, byte* zp($52) src, word zp($50) num)
memcpy_in_vram: {
    .label i = $a
    .label dest = $a
    .label src = $52
    .label num = $50
    .label dest_bank = $c
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [265] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    // Select DATA0
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <src
    // [266] memcpy_in_vram::$0 = < memcpy_in_vram::src#3 -- vbuaa=_lo_pvoz1 
    lda.z src
    // *VERA_ADDRX_L = <src
    // [267] *VERA_ADDRX_L = memcpy_in_vram::$0 -- _deref_pbuc1=vbuaa 
    // Set address
    sta VERA_ADDRX_L
    // >src
    // [268] memcpy_in_vram::$1 = > memcpy_in_vram::src#3 -- vbuaa=_hi_pvoz1 
    lda.z src+1
    // *VERA_ADDRX_M = >src
    // [269] *VERA_ADDRX_M = memcpy_in_vram::$1 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // src_increment | src_bank
    // [270] memcpy_in_vram::$2 = VERA_INC_1 | memcpy_in_vram::src_bank#3 -- vbuaa=vbuc1_bor_vbuyy 
    tya
    ora #VERA_INC_1
    // *VERA_ADDRX_H = src_increment | src_bank
    // [271] *VERA_ADDRX_H = memcpy_in_vram::$2 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_H
    // *VERA_CTRL |= VERA_ADDRSEL
    // [272] *VERA_CTRL = *VERA_CTRL | VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_bor_vbuc2 
    // Select DATA1
    lda #VERA_ADDRSEL
    ora VERA_CTRL
    sta VERA_CTRL
    // <dest
    // [273] memcpy_in_vram::$3 = < memcpy_in_vram::dest#3 -- vbuaa=_lo_pvoz1 
    lda.z dest
    // *VERA_ADDRX_L = <dest
    // [274] *VERA_ADDRX_L = memcpy_in_vram::$3 -- _deref_pbuc1=vbuaa 
    // Set address
    sta VERA_ADDRX_L
    // >dest
    // [275] memcpy_in_vram::$4 = > memcpy_in_vram::dest#3 -- vbuaa=_hi_pvoz1 
    lda.z dest+1
    // *VERA_ADDRX_M = >dest
    // [276] *VERA_ADDRX_M = memcpy_in_vram::$4 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // dest_increment | dest_bank
    // [277] memcpy_in_vram::$5 = VERA_INC_1 | memcpy_in_vram::dest_bank#3 -- vbuaa=vbuc1_bor_vbuz1 
    lda #VERA_INC_1
    ora.z dest_bank
    // *VERA_ADDRX_H = dest_increment | dest_bank
    // [278] *VERA_ADDRX_H = memcpy_in_vram::$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_H
    // [279] phi from memcpy_in_vram to memcpy_in_vram::@1 [phi:memcpy_in_vram->memcpy_in_vram::@1]
    // [279] phi memcpy_in_vram::i#2 = 0 [phi:memcpy_in_vram->memcpy_in_vram::@1#0] -- vwuz1=vwuc1 
    lda #<0
    sta.z i
    sta.z i+1
  // Transfer the data
    // memcpy_in_vram::@1
  __b1:
    // for(unsigned int i=0; i<num; i++)
    // [280] if(memcpy_in_vram::i#2<memcpy_in_vram::num#4) goto memcpy_in_vram::@2 -- vwuz1_lt_vwuz2_then_la1 
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
    // [281] return 
    rts
    // memcpy_in_vram::@2
  __b2:
    // *VERA_DATA1 = *VERA_DATA0
    // [282] *VERA_DATA1 = *VERA_DATA0 -- _deref_pbuc1=_deref_pbuc2 
    lda VERA_DATA0
    sta VERA_DATA1
    // for(unsigned int i=0; i<num; i++)
    // [283] memcpy_in_vram::i#1 = ++ memcpy_in_vram::i#2 -- vwuz1=_inc_vwuz1 
    inc.z i
    bne !+
    inc.z i+1
  !:
    // [279] phi from memcpy_in_vram::@2 to memcpy_in_vram::@1 [phi:memcpy_in_vram::@2->memcpy_in_vram::@1]
    // [279] phi memcpy_in_vram::i#2 = memcpy_in_vram::i#1 [phi:memcpy_in_vram::@2->memcpy_in_vram::@1#0] -- register_copy 
    jmp __b1
}
  // rand
// Returns a pseudo-random number in the range of 0 to RAND_MAX (65535)
// Uses an xorshift pseudorandom number generator that hits all different values
// Information https://en.wikipedia.org/wiki/Xorshift
// Source http://www.retroprogramming.com/2017/07/xorshift-pseudorandom-numbers-in-z80.html
rand: {
    .label __0 = $50
    .label __1 = $a
    .label __2 = $a
    .label return = $52
    // rand_state << 7
    // [285] rand::$0 = rand_state#13 << 7 -- vwuz1=vwuz2_rol_7 
    lda.z rand_state+1
    lsr
    lda.z rand_state
    ror
    sta.z __0+1
    lda #0
    ror
    sta.z __0
    // rand_state ^= rand_state << 7
    // [286] rand_state#0 = rand_state#13 ^ rand::$0 -- vwuz1=vwuz1_bxor_vwuz2 
    lda.z rand_state
    eor.z __0
    sta.z rand_state
    lda.z rand_state+1
    eor.z __0+1
    sta.z rand_state+1
    // rand_state >> 9
    // [287] rand::$1 = rand_state#0 >> 9 -- vwuz1=vwuz2_ror_9 
    lsr
    sta.z __1
    lda #0
    sta.z __1+1
    // rand_state ^= rand_state >> 9
    // [288] rand_state#1 = rand_state#0 ^ rand::$1 -- vwuz1=vwuz1_bxor_vwuz2 
    lda.z rand_state
    eor.z __1
    sta.z rand_state
    lda.z rand_state+1
    eor.z __1+1
    sta.z rand_state+1
    // rand_state << 8
    // [289] rand::$2 = rand_state#1 << 8 -- vwuz1=vwuz2_rol_8 
    lda.z rand_state
    sta.z __2+1
    lda #0
    sta.z __2
    // rand_state ^= rand_state << 8
    // [290] rand_state#14 = rand_state#1 ^ rand::$2 -- vwuz1=vwuz1_bxor_vwuz2 
    lda.z rand_state
    eor.z __2
    sta.z rand_state
    lda.z rand_state+1
    eor.z __2+1
    sta.z rand_state+1
    // return rand_state;
    // [291] rand::return#0 = rand_state#14 -- vwuz1=vwuz2 
    lda.z rand_state
    sta.z return
    lda.z rand_state+1
    sta.z return+1
    // rand::@return
    // }
    // [292] return 
    rts
}
  // modr16u
// Performs modulo on two 16 bit unsigned ints and an initial remainder
// Returns the remainder.
// Implemented using simple binary division
// modr16u(word zp($52) dividend)
modr16u: {
    .label return = $a
    .label dividend = $52
    // divr16u(dividend, divisor, rem)
    // [294] divr16u::dividend#1 = modr16u::dividend#2
    // [295] call divr16u 
    // [953] phi from modr16u to divr16u [phi:modr16u->divr16u]
    jsr divr16u
    // modr16u::@1
    // return rem16u;
    // [296] modr16u::return#0 = divr16u::rem#10 -- vwuz1=vwuz2 
    lda.z divr16u.rem
    sta.z return
    lda.z divr16u.rem+1
    sta.z return+1
    // modr16u::@return
    // }
    // [297] return 
    rts
}
  // vera_tile_element
// vera_tile_element(byte register(X) x, byte zp($d) y, byte* zp($a) Tile)
vera_tile_element: {
    .label __3 = $a
    .label __18 = $a
    .label vera_vram_address01___0 = $a
    .label vera_vram_address01___2 = $52
    .label vera_vram_address01___4 = $a
    .label TileOffset = $4b
    .label TileTotal = $4c
    .label TileCount = $4d
    .label TileColumns = $4e
    .label PaletteOffset = $4f
    .label y = $d
    .label mapbase = $e
    .label shift = $c
    .label rowskip = $50
    .label j = $c
    .label i = $d
    .label r = $12
    .label x = $c
    .label Tile = $a
    // TileOffset = Tile[0]
    // [299] vera_tile_element::TileOffset#0 = *vera_tile_element::Tile#2 -- vbuz1=_deref_pbuz2 
    ldy #0
    lda (Tile),y
    sta.z TileOffset
    // TileTotal = Tile[1]
    // [300] vera_tile_element::TileTotal#0 = vera_tile_element::Tile#2[1] -- vbuz1=pbuz2_derefidx_vbuc1 
    ldy #1
    lda (Tile),y
    sta.z TileTotal
    // TileCount = Tile[2]
    // [301] vera_tile_element::TileCount#0 = vera_tile_element::Tile#2[2] -- vbuz1=pbuz2_derefidx_vbuc1 
    ldy #2
    lda (Tile),y
    sta.z TileCount
    // TileColumns = Tile[4]
    // [302] vera_tile_element::TileColumns#0 = vera_tile_element::Tile#2[4] -- vbuz1=pbuz2_derefidx_vbuc1 
    ldy #4
    lda (Tile),y
    sta.z TileColumns
    // PaletteOffset = Tile[5]
    // [303] vera_tile_element::PaletteOffset#0 = vera_tile_element::Tile#2[5] -- vbuz1=pbuz2_derefidx_vbuc1 
    ldy #5
    lda (Tile),y
    sta.z PaletteOffset
    // x = x << resolution
    // [304] vera_tile_element::x#0 = vera_tile_element::x#3 << 3 -- vbuxx=vbuz1_rol_3 
    lda.z x
    asl
    asl
    asl
    tax
    // y = y << resolution
    // [305] vera_tile_element::y#0 = vera_tile_element::y#3 << 3 -- vbuz1=vbuz1_rol_3 
    lda.z y
    asl
    asl
    asl
    sta.z y
    // mapbase = vera_mapbase_address[layer]
    // [306] vera_tile_element::mapbase#0 = *vera_mapbase_address -- vduz1=_deref_pduc1 
    lda vera_mapbase_address
    sta.z mapbase
    lda vera_mapbase_address+1
    sta.z mapbase+1
    lda vera_mapbase_address+2
    sta.z mapbase+2
    lda vera_mapbase_address+3
    sta.z mapbase+3
    // shift = vera_layer_rowshift[layer]
    // [307] vera_tile_element::shift#0 = *vera_layer_rowshift -- vbuz1=_deref_pbuc1 
    lda vera_layer_rowshift
    sta.z shift
    // rowskip = (word)1 << shift
    // [308] vera_tile_element::rowskip#0 = 1 << vera_tile_element::shift#0 -- vwuz1=vwuc1_rol_vbuz2 
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
    // [309] vera_tile_element::$18 = (word)vera_tile_element::y#0 -- vwuz1=_word_vbuz2 
    lda.z y
    sta.z __18
    lda #0
    sta.z __18+1
    // [310] vera_tile_element::$3 = vera_tile_element::$18 << vera_tile_element::shift#0 -- vwuz1=vwuz1_rol_vbuz2 
    ldy.z shift
    beq !e+
  !:
    asl.z __3
    rol.z __3+1
    dey
    bne !-
  !e:
    // mapbase += ((word)y << shift)
    // [311] vera_tile_element::mapbase#1 = vera_tile_element::mapbase#0 + vera_tile_element::$3 -- vduz1=vduz1_plus_vwuz2 
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
    // [312] vera_tile_element::$4 = vera_tile_element::x#0 << 1 -- vbuaa=vbuxx_rol_1 
    txa
    asl
    // mapbase += (x << 1)
    // [313] vera_tile_element::mapbase#2 = vera_tile_element::mapbase#1 + vera_tile_element::$4 -- vduz1=vduz1_plus_vbuaa 
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
    // [314] phi from vera_tile_element to vera_tile_element::@1 [phi:vera_tile_element->vera_tile_element::@1]
    // [314] phi vera_tile_element::mapbase#11 = vera_tile_element::mapbase#2 [phi:vera_tile_element->vera_tile_element::@1#0] -- register_copy 
    // [314] phi vera_tile_element::j#2 = 0 [phi:vera_tile_element->vera_tile_element::@1#1] -- vbuz1=vbuc1 
    lda #0
    sta.z j
    // vera_tile_element::@1
  __b1:
    // for(byte j=0;j<TileTotal;j+=(TileTotal>>1))
    // [315] if(vera_tile_element::j#2<vera_tile_element::TileTotal#0) goto vera_tile_element::@2 -- vbuz1_lt_vbuz2_then_la1 
    lda.z j
    cmp.z TileTotal
    bcc __b3
    // vera_tile_element::@return
    // }
    // [316] return 
    rts
    // [317] phi from vera_tile_element::@1 to vera_tile_element::@2 [phi:vera_tile_element::@1->vera_tile_element::@2]
  __b3:
    // [317] phi vera_tile_element::mapbase#10 = vera_tile_element::mapbase#11 [phi:vera_tile_element::@1->vera_tile_element::@2#0] -- register_copy 
    // [317] phi vera_tile_element::i#10 = 0 [phi:vera_tile_element::@1->vera_tile_element::@2#1] -- vbuz1=vbuc1 
    lda #0
    sta.z i
    // vera_tile_element::@2
  __b2:
    // for(byte i=0;i<TileCount;i+=(TileColumns))
    // [318] if(vera_tile_element::i#10<vera_tile_element::TileCount#0) goto vera_tile_element::vera_vram_address01 -- vbuz1_lt_vbuz2_then_la1 
    lda.z i
    cmp.z TileCount
    bcc vera_vram_address01
    // vera_tile_element::@3
    // TileTotal>>1
    // [319] vera_tile_element::$16 = vera_tile_element::TileTotal#0 >> 1 -- vbuaa=vbuz1_ror_1 
    lda.z TileTotal
    lsr
    // j+=(TileTotal>>1)
    // [320] vera_tile_element::j#1 = vera_tile_element::j#2 + vera_tile_element::$16 -- vbuz1=vbuz1_plus_vbuaa 
    clc
    adc.z j
    sta.z j
    // [314] phi from vera_tile_element::@3 to vera_tile_element::@1 [phi:vera_tile_element::@3->vera_tile_element::@1]
    // [314] phi vera_tile_element::mapbase#11 = vera_tile_element::mapbase#10 [phi:vera_tile_element::@3->vera_tile_element::@1#0] -- register_copy 
    // [314] phi vera_tile_element::j#2 = vera_tile_element::j#1 [phi:vera_tile_element::@3->vera_tile_element::@1#1] -- register_copy 
    jmp __b1
    // vera_tile_element::vera_vram_address01
  vera_vram_address01:
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [321] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <bankaddr
    // [322] vera_tile_element::vera_vram_address01_$0 = < vera_tile_element::mapbase#10 -- vwuz1=_lo_vduz2 
    lda.z mapbase
    sta.z vera_vram_address01___0
    lda.z mapbase+1
    sta.z vera_vram_address01___0+1
    // <(<bankaddr)
    // [323] vera_tile_element::vera_vram_address01_$1 = < vera_tile_element::vera_vram_address01_$0 -- vbuaa=_lo_vwuz1 
    lda.z vera_vram_address01___0
    // *VERA_ADDRX_L = <(<bankaddr)
    // [324] *VERA_ADDRX_L = vera_tile_element::vera_vram_address01_$1 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // <bankaddr
    // [325] vera_tile_element::vera_vram_address01_$2 = < vera_tile_element::mapbase#10 -- vwuz1=_lo_vduz2 
    lda.z mapbase
    sta.z vera_vram_address01___2
    lda.z mapbase+1
    sta.z vera_vram_address01___2+1
    // >(<bankaddr)
    // [326] vera_tile_element::vera_vram_address01_$3 = > vera_tile_element::vera_vram_address01_$2 -- vbuaa=_hi_vwuz1 
    // *VERA_ADDRX_M = >(<bankaddr)
    // [327] *VERA_ADDRX_M = vera_tile_element::vera_vram_address01_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // >bankaddr
    // [328] vera_tile_element::vera_vram_address01_$4 = > vera_tile_element::mapbase#10 -- vwuz1=_hi_vduz2 
    lda.z mapbase+2
    sta.z vera_vram_address01___4
    lda.z mapbase+3
    sta.z vera_vram_address01___4+1
    // <(>bankaddr)
    // [329] vera_tile_element::vera_vram_address01_$5 = < vera_tile_element::vera_vram_address01_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_vram_address01___4
    // <(>bankaddr) | incr
    // [330] vera_tile_element::vera_vram_address01_$6 = vera_tile_element::vera_vram_address01_$5 | VERA_INC_1 -- vbuaa=vbuaa_bor_vbuc1 
    ora #VERA_INC_1
    // *VERA_ADDRX_H = <(>bankaddr) | incr
    // [331] *VERA_ADDRX_H = vera_tile_element::vera_vram_address01_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_H
    // [332] phi from vera_tile_element::vera_vram_address01 to vera_tile_element::@4 [phi:vera_tile_element::vera_vram_address01->vera_tile_element::@4]
    // [332] phi vera_tile_element::r#2 = 0 [phi:vera_tile_element::vera_vram_address01->vera_tile_element::@4#0] -- vbuz1=vbuc1 
    lda #0
    sta.z r
    // vera_tile_element::@4
  __b4:
    // TileTotal>>1
    // [333] vera_tile_element::$8 = vera_tile_element::TileTotal#0 >> 1 -- vbuaa=vbuz1_ror_1 
    lda.z TileTotal
    lsr
    // for(byte r=0;r<(TileTotal>>1);r+=TileCount)
    // [334] if(vera_tile_element::r#2<vera_tile_element::$8) goto vera_tile_element::@6 -- vbuz1_lt_vbuaa_then_la1 
    cmp.z r
    beq !+
    bcs __b5
  !:
    // vera_tile_element::@5
    // mapbase += rowskip
    // [335] vera_tile_element::mapbase#3 = vera_tile_element::mapbase#10 + vera_tile_element::rowskip#0 -- vduz1=vduz1_plus_vwuz2 
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
    // [336] vera_tile_element::i#1 = vera_tile_element::i#10 + vera_tile_element::TileColumns#0 -- vbuz1=vbuz1_plus_vbuz2 
    lda.z i
    clc
    adc.z TileColumns
    sta.z i
    // [317] phi from vera_tile_element::@5 to vera_tile_element::@2 [phi:vera_tile_element::@5->vera_tile_element::@2]
    // [317] phi vera_tile_element::mapbase#10 = vera_tile_element::mapbase#3 [phi:vera_tile_element::@5->vera_tile_element::@2#0] -- register_copy 
    // [317] phi vera_tile_element::i#10 = vera_tile_element::i#1 [phi:vera_tile_element::@5->vera_tile_element::@2#1] -- register_copy 
    jmp __b2
    // [337] phi from vera_tile_element::@4 to vera_tile_element::@6 [phi:vera_tile_element::@4->vera_tile_element::@6]
  __b5:
    // [337] phi vera_tile_element::c#2 = 0 [phi:vera_tile_element::@4->vera_tile_element::@6#0] -- vbuxx=vbuc1 
    ldx #0
    // vera_tile_element::@6
  __b6:
    // for(byte c=0;c<TileColumns;c+=1)
    // [338] if(vera_tile_element::c#2<vera_tile_element::TileColumns#0) goto vera_tile_element::@7 -- vbuxx_lt_vbuz1_then_la1 
    cpx.z TileColumns
    bcc __b7
    // vera_tile_element::@8
    // r+=TileCount
    // [339] vera_tile_element::r#1 = vera_tile_element::r#2 + vera_tile_element::TileCount#0 -- vbuz1=vbuz1_plus_vbuz2 
    lda.z r
    clc
    adc.z TileCount
    sta.z r
    // [332] phi from vera_tile_element::@8 to vera_tile_element::@4 [phi:vera_tile_element::@8->vera_tile_element::@4]
    // [332] phi vera_tile_element::r#2 = vera_tile_element::r#1 [phi:vera_tile_element::@8->vera_tile_element::@4#0] -- register_copy 
    jmp __b4
    // vera_tile_element::@7
  __b7:
    // TileOffset+c
    // [340] vera_tile_element::$11 = vera_tile_element::TileOffset#0 + vera_tile_element::c#2 -- vbuaa=vbuz1_plus_vbuxx 
    txa
    clc
    adc.z TileOffset
    // TileOffset+c+r
    // [341] vera_tile_element::$12 = vera_tile_element::$11 + vera_tile_element::r#2 -- vbuaa=vbuaa_plus_vbuz1 
    clc
    adc.z r
    // TileOffset+c+r+i
    // [342] vera_tile_element::$13 = vera_tile_element::$12 + vera_tile_element::i#10 -- vbuaa=vbuaa_plus_vbuz1 
    clc
    adc.z i
    // TileOffset+c+r+i+j
    // [343] vera_tile_element::$14 = vera_tile_element::$13 + vera_tile_element::j#2 -- vbuaa=vbuaa_plus_vbuz1 
    clc
    adc.z j
    // *VERA_DATA0 = TileOffset+c+r+i+j
    // [344] *VERA_DATA0 = vera_tile_element::$14 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // PaletteOffset << 4
    // [345] vera_tile_element::$15 = vera_tile_element::PaletteOffset#0 << 4 -- vbuaa=vbuz1_rol_4 
    lda.z PaletteOffset
    asl
    asl
    asl
    asl
    // *VERA_DATA0 = PaletteOffset << 4
    // [346] *VERA_DATA0 = vera_tile_element::$15 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // c+=1
    // [347] vera_tile_element::c#1 = vera_tile_element::c#2 + 1 -- vbuxx=vbuxx_plus_1 
    inx
    // [337] phi from vera_tile_element::@7 to vera_tile_element::@6 [phi:vera_tile_element::@7->vera_tile_element::@6]
    // [337] phi vera_tile_element::c#2 = vera_tile_element::c#1 [phi:vera_tile_element::@7->vera_tile_element::@6#0] -- register_copy 
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
    // [349] call vera_layer_mode_tile 
    // [416] phi from vera_layer_mode_text to vera_layer_mode_tile [phi:vera_layer_mode_text->vera_layer_mode_tile]
    // [416] phi vera_layer_mode_tile::tileheight#10 = vera_layer_mode_text::tileheight#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#0] -- vbuz1=vbuc1 
    lda #tileheight
    sta.z vera_layer_mode_tile.tileheight
    // [416] phi vera_layer_mode_tile::tilewidth#10 = vera_layer_mode_text::tilewidth#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#1] -- vbuz1=vbuc1 
    lda #tilewidth
    sta.z vera_layer_mode_tile.tilewidth
    // [416] phi vera_layer_mode_tile::tilebase_address#10 = vera_layer_mode_text::tilebase_address#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#2] -- vduz1=vduc1 
    lda #<tilebase_address
    sta.z vera_layer_mode_tile.tilebase_address
    lda #>tilebase_address
    sta.z vera_layer_mode_tile.tilebase_address+1
    lda #<tilebase_address>>$10
    sta.z vera_layer_mode_tile.tilebase_address+2
    lda #>tilebase_address>>$10
    sta.z vera_layer_mode_tile.tilebase_address+3
    // [416] phi vera_layer_mode_tile::mapbase_address#10 = vera_layer_mode_text::mapbase_address#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#3] -- vduz1=vduc1 
    lda #<mapbase_address
    sta.z vera_layer_mode_tile.mapbase_address
    lda #>mapbase_address
    sta.z vera_layer_mode_tile.mapbase_address+1
    lda #<mapbase_address>>$10
    sta.z vera_layer_mode_tile.mapbase_address+2
    lda #>mapbase_address>>$10
    sta.z vera_layer_mode_tile.mapbase_address+3
    // [416] phi vera_layer_mode_tile::mapheight#10 = vera_layer_mode_text::mapheight#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#4] -- vwuz1=vwuc1 
    lda #<mapheight
    sta.z vera_layer_mode_tile.mapheight
    lda #>mapheight
    sta.z vera_layer_mode_tile.mapheight+1
    // [416] phi vera_layer_mode_tile::layer#10 = vera_layer_mode_text::layer#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#5] -- vbuz1=vbuc1 
    lda #layer
    sta.z vera_layer_mode_tile.layer
    // [416] phi vera_layer_mode_tile::mapwidth#10 = vera_layer_mode_text::mapwidth#0 [phi:vera_layer_mode_text->vera_layer_mode_tile#6] -- vwuz1=vwuc1 
    lda #<mapwidth
    sta.z vera_layer_mode_tile.mapwidth
    lda #>mapwidth
    sta.z vera_layer_mode_tile.mapwidth+1
    // [416] phi vera_layer_mode_tile::color_depth#3 = 1 [phi:vera_layer_mode_text->vera_layer_mode_tile#7] -- vbuxx=vbuc1 
    ldx #1
    jsr vera_layer_mode_tile
    // [350] phi from vera_layer_mode_text to vera_layer_mode_text::@1 [phi:vera_layer_mode_text->vera_layer_mode_text::@1]
    // vera_layer_mode_text::@1
    // vera_layer_set_text_color_mode( layer, VERA_LAYER_CONFIG_16C )
    // [351] call vera_layer_set_text_color_mode 
    jsr vera_layer_set_text_color_mode
    // vera_layer_mode_text::@return
    // }
    // [352] return 
    rts
}
  // screensize
// Return the current screen size.
screensize: {
    .label x = cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH
    .label y = cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT
    // hscale = (*VERA_DC_HSCALE) >> 7
    // [353] screensize::hscale#0 = *VERA_DC_HSCALE >> 7 -- vbuaa=_deref_pbuc1_ror_7 
    lda VERA_DC_HSCALE
    rol
    rol
    and #1
    // 40 << hscale
    // [354] screensize::$1 = $28 << screensize::hscale#0 -- vbuaa=vbuc1_rol_vbuaa 
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
    // [355] *screensize::x#0 = screensize::$1 -- _deref_pbuc1=vbuaa 
    sta x
    // vscale = (*VERA_DC_VSCALE) >> 7
    // [356] screensize::vscale#0 = *VERA_DC_VSCALE >> 7 -- vbuaa=_deref_pbuc1_ror_7 
    lda VERA_DC_VSCALE
    rol
    rol
    and #1
    // 30 << vscale
    // [357] screensize::$3 = $1e << screensize::vscale#0 -- vbuaa=vbuc1_rol_vbuaa 
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
    // [358] *screensize::y#0 = screensize::$3 -- _deref_pbuc1=vbuaa 
    sta y
    // screensize::@return
    // }
    // [359] return 
    rts
}
  // screenlayer
// Set the layer with which the conio will interact.
// - layer: value of 0 or 1.
screenlayer: {
    .label __1 = $54
    .label __5 = $54
    .label vera_layer_get_width1_config = $56
    .label vera_layer_get_width1_return = $54
    .label vera_layer_get_height1_config = $54
    .label vera_layer_get_height1_return = $54
    // cx16_conio.conio_screen_layer = layer
    // [360] *((byte*)&cx16_conio) = 1 -- _deref_pbuc1=vbuc2 
    lda #1
    sta cx16_conio
    // vera_layer_get_mapbase_bank(layer)
    // [361] call vera_layer_get_mapbase_bank 
    jsr vera_layer_get_mapbase_bank
    // [362] vera_layer_get_mapbase_bank::return#2 = vera_layer_get_mapbase_bank::return#0
    // screenlayer::@3
    // [363] screenlayer::$0 = vera_layer_get_mapbase_bank::return#2
    // cx16_conio.conio_screen_bank = vera_layer_get_mapbase_bank(layer)
    // [364] *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK) = screenlayer::$0 -- _deref_pbuc1=vbuaa 
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK
    // vera_layer_get_mapbase_offset(layer)
    // [365] call vera_layer_get_mapbase_offset 
    jsr vera_layer_get_mapbase_offset
    // [366] vera_layer_get_mapbase_offset::return#2 = vera_layer_get_mapbase_offset::return#0
    // screenlayer::@4
    // [367] screenlayer::$1 = vera_layer_get_mapbase_offset::return#2
    // cx16_conio.conio_screen_text = vera_layer_get_mapbase_offset(layer)
    // [368] *((byte**)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT) = (byte*)screenlayer::$1 -- _deref_qbuc1=pbuz1 
    lda.z __1
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT
    lda.z __1+1
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT+1
    // screenlayer::vera_layer_get_width1
    // config = vera_layer_config[layer]
    // [369] screenlayer::vera_layer_get_width1_config#0 = *(vera_layer_config+1<<1) -- pbuz1=_deref_qbuc1 
    lda vera_layer_config+(1<<1)
    sta.z vera_layer_get_width1_config
    lda vera_layer_config+(1<<1)+1
    sta.z vera_layer_get_width1_config+1
    // *config & VERA_LAYER_WIDTH_MASK
    // [370] screenlayer::vera_layer_get_width1_$0 = *screenlayer::vera_layer_get_width1_config#0 & VERA_LAYER_WIDTH_MASK -- vbuaa=_deref_pbuz1_band_vbuc1 
    lda #VERA_LAYER_WIDTH_MASK
    ldy #0
    and (vera_layer_get_width1_config),y
    // (*config & VERA_LAYER_WIDTH_MASK) >> 4
    // [371] screenlayer::vera_layer_get_width1_$1 = screenlayer::vera_layer_get_width1_$0 >> 4 -- vbuaa=vbuaa_ror_4 
    lsr
    lsr
    lsr
    lsr
    // return VERA_LAYER_WIDTH[ (*config & VERA_LAYER_WIDTH_MASK) >> 4];
    // [372] screenlayer::vera_layer_get_width1_$3 = screenlayer::vera_layer_get_width1_$1 << 1 -- vbuaa=vbuaa_rol_1 
    asl
    // [373] screenlayer::vera_layer_get_width1_return#0 = VERA_LAYER_WIDTH[screenlayer::vera_layer_get_width1_$3] -- vwuz1=pwuc1_derefidx_vbuaa 
    tay
    lda VERA_LAYER_WIDTH,y
    sta.z vera_layer_get_width1_return
    lda VERA_LAYER_WIDTH+1,y
    sta.z vera_layer_get_width1_return+1
    // screenlayer::@1
    // cx16_conio.conio_map_width = vera_layer_get_width(layer)
    // [374] *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH) = screenlayer::vera_layer_get_width1_return#0 -- _deref_pwuc1=vwuz1 
    lda.z vera_layer_get_width1_return
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH
    lda.z vera_layer_get_width1_return+1
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH+1
    // screenlayer::vera_layer_get_height1
    // config = vera_layer_config[layer]
    // [375] screenlayer::vera_layer_get_height1_config#0 = *(vera_layer_config+1<<1) -- pbuz1=_deref_qbuc1 
    lda vera_layer_config+(1<<1)
    sta.z vera_layer_get_height1_config
    lda vera_layer_config+(1<<1)+1
    sta.z vera_layer_get_height1_config+1
    // *config & VERA_LAYER_HEIGHT_MASK
    // [376] screenlayer::vera_layer_get_height1_$0 = *screenlayer::vera_layer_get_height1_config#0 & VERA_LAYER_HEIGHT_MASK -- vbuaa=_deref_pbuz1_band_vbuc1 
    lda #VERA_LAYER_HEIGHT_MASK
    ldy #0
    and (vera_layer_get_height1_config),y
    // (*config & VERA_LAYER_HEIGHT_MASK) >> 6
    // [377] screenlayer::vera_layer_get_height1_$1 = screenlayer::vera_layer_get_height1_$0 >> 6 -- vbuaa=vbuaa_ror_6 
    rol
    rol
    rol
    and #3
    // return VERA_LAYER_HEIGHT[ (*config & VERA_LAYER_HEIGHT_MASK) >> 6];
    // [378] screenlayer::vera_layer_get_height1_$3 = screenlayer::vera_layer_get_height1_$1 << 1 -- vbuaa=vbuaa_rol_1 
    asl
    // [379] screenlayer::vera_layer_get_height1_return#0 = VERA_LAYER_HEIGHT[screenlayer::vera_layer_get_height1_$3] -- vwuz1=pwuc1_derefidx_vbuaa 
    tay
    lda VERA_LAYER_HEIGHT,y
    sta.z vera_layer_get_height1_return
    lda VERA_LAYER_HEIGHT+1,y
    sta.z vera_layer_get_height1_return+1
    // screenlayer::@2
    // cx16_conio.conio_map_height = vera_layer_get_height(layer)
    // [380] *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT) = screenlayer::vera_layer_get_height1_return#0 -- _deref_pwuc1=vwuz1 
    lda.z vera_layer_get_height1_return
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT
    lda.z vera_layer_get_height1_return+1
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT+1
    // vera_layer_get_rowshift(layer)
    // [381] call vera_layer_get_rowshift 
    jsr vera_layer_get_rowshift
    // [382] vera_layer_get_rowshift::return#2 = vera_layer_get_rowshift::return#0
    // screenlayer::@5
    // [383] screenlayer::$4 = vera_layer_get_rowshift::return#2
    // cx16_conio.conio_rowshift = vera_layer_get_rowshift(layer)
    // [384] *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSHIFT) = screenlayer::$4 -- _deref_pbuc1=vbuaa 
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSHIFT
    // vera_layer_get_rowskip(layer)
    // [385] call vera_layer_get_rowskip 
    jsr vera_layer_get_rowskip
    // [386] vera_layer_get_rowskip::return#2 = vera_layer_get_rowskip::return#0
    // screenlayer::@6
    // [387] screenlayer::$5 = vera_layer_get_rowskip::return#2
    // cx16_conio.conio_rowskip = vera_layer_get_rowskip(layer)
    // [388] *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP) = screenlayer::$5 -- _deref_pwuc1=vwuz1 
    lda.z __5
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP
    lda.z __5+1
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP+1
    // screenlayer::@return
    // }
    // [389] return 
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
    // [391] vera_layer_textcolor[vera_layer_set_textcolor::layer#2] = WHITE -- pbuc1_derefidx_vbuxx=vbuc2 
    lda #WHITE
    sta vera_layer_textcolor,x
    // vera_layer_set_textcolor::@return
    // }
    // [392] return 
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
    // [394] vera_layer_backcolor[vera_layer_set_backcolor::layer#2] = vera_layer_set_backcolor::color#2 -- pbuc1_derefidx_vbuxx=vbuaa 
    sta vera_layer_backcolor,x
    // vera_layer_set_backcolor::@return
    // }
    // [395] return 
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
    .label addr = $54
    // addr = vera_layer_mapbase[layer]
    // [397] vera_layer_set_mapbase::$0 = vera_layer_set_mapbase::layer#3 << 1 -- vbuaa=vbuaa_rol_1 
    asl
    // [398] vera_layer_set_mapbase::addr#0 = vera_layer_mapbase[vera_layer_set_mapbase::$0] -- pbuz1=qbuc1_derefidx_vbuaa 
    tay
    lda vera_layer_mapbase,y
    sta.z addr
    lda vera_layer_mapbase+1,y
    sta.z addr+1
    // *addr = mapbase
    // [399] *vera_layer_set_mapbase::addr#0 = vera_layer_set_mapbase::mapbase#3 -- _deref_pbuz1=vbuxx 
    txa
    ldy #0
    sta (addr),y
    // vera_layer_set_mapbase::@return
    // }
    // [400] return 
    rts
}
  // cursor
// If onoff is 1, a cursor is displayed when waiting for keyboard input.
// If onoff is 0, the cursor is hidden when waiting for keyboard input.
// The function returns the old cursor setting.
cursor: {
    .const onoff = 0
    // cx16_conio.conio_display_cursor = onoff
    // [401] *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_DISPLAY_CURSOR) = cursor::onoff#0 -- _deref_pbuc1=vbuc2 
    lda #onoff
    sta cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_DISPLAY_CURSOR
    // cursor::@return
    // }
    // [402] return 
    rts
}
  // gotoxy
// Set the cursor to the specified position
// gotoxy(byte register(X) y)
gotoxy: {
    .label __6 = $54
    .label line_offset = $54
    // if(y>cx16_conio.conio_screen_height)
    // [404] if(gotoxy::y#3<=*((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT)) goto gotoxy::@4 -- vbuxx_le__deref_pbuc1_then_la1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT
    stx.z $ff
    cmp.z $ff
    bcs __b1
    // [406] phi from gotoxy to gotoxy::@1 [phi:gotoxy->gotoxy::@1]
    // [406] phi gotoxy::y#4 = 0 [phi:gotoxy->gotoxy::@1#0] -- vbuxx=vbuc1 
    ldx #0
    // [405] phi from gotoxy to gotoxy::@4 [phi:gotoxy->gotoxy::@4]
    // gotoxy::@4
    // [406] phi from gotoxy::@4 to gotoxy::@1 [phi:gotoxy::@4->gotoxy::@1]
    // [406] phi gotoxy::y#4 = gotoxy::y#3 [phi:gotoxy::@4->gotoxy::@1#0] -- register_copy 
    // gotoxy::@1
  __b1:
    // if(x>=cx16_conio.conio_screen_width)
    // [407] if(0<*((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH)) goto gotoxy::@2 -- 0_lt__deref_pbuc1_then_la1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH
    cmp #0
    // [408] phi from gotoxy::@1 to gotoxy::@3 [phi:gotoxy::@1->gotoxy::@3]
    // gotoxy::@3
    // gotoxy::@2
    // conio_cursor_x[cx16_conio.conio_screen_layer] = x
    // [409] conio_cursor_x[*((byte*)&cx16_conio)] = 0 -- pbuc1_derefidx_(_deref_pbuc2)=vbuc3 
    lda #0
    ldy cx16_conio
    sta conio_cursor_x,y
    // conio_cursor_y[cx16_conio.conio_screen_layer] = y
    // [410] conio_cursor_y[*((byte*)&cx16_conio)] = gotoxy::y#4 -- pbuc1_derefidx_(_deref_pbuc2)=vbuxx 
    txa
    sta conio_cursor_y,y
    // (unsigned int)y << cx16_conio.conio_rowshift
    // [411] gotoxy::$6 = (word)gotoxy::y#4 -- vwuz1=_word_vbuxx 
    txa
    sta.z __6
    lda #0
    sta.z __6+1
    // line_offset = (unsigned int)y << cx16_conio.conio_rowshift
    // [412] gotoxy::line_offset#0 = gotoxy::$6 << *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSHIFT) -- vwuz1=vwuz1_rol__deref_pbuc1 
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
    // [413] gotoxy::$5 = *((byte*)&cx16_conio) << 1 -- vbuaa=_deref_pbuc1_rol_1 
    lda cx16_conio
    asl
    // [414] conio_line_text[gotoxy::$5] = gotoxy::line_offset#0 -- pwuc1_derefidx_vbuaa=vwuz1 
    tay
    lda.z line_offset
    sta conio_line_text,y
    lda.z line_offset+1
    sta conio_line_text+1,y
    // gotoxy::@return
    // }
    // [415] return 
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
// vera_layer_mode_tile(byte zp($13) layer, dword zp($14) mapbase_address, dword zp($18) tilebase_address, word zp($54) mapwidth, word zp($56) mapheight, byte zp($1c) tilewidth, byte zp($1d) tileheight, byte register(X) color_depth)
vera_layer_mode_tile: {
    .label __1 = $54
    .label __2 = $54
    .label __4 = $54
    .label __7 = $54
    .label __8 = $54
    .label __10 = $54
    .label __19 = $58
    .label __20 = $59
    .label mapbase_address = $14
    .label tilebase_address = $18
    .label layer = $13
    .label mapwidth = $54
    .label mapheight = $56
    .label tilewidth = $1c
    .label tileheight = $1d
    // case 1:
    //             config |= VERA_LAYER_COLOR_DEPTH_1BPP;
    //             break;
    // [417] if(vera_layer_mode_tile::color_depth#3==1) goto vera_layer_mode_tile::@5 -- vbuxx_eq_vbuc1_then_la1 
    cpx #1
    beq __b1
    // vera_layer_mode_tile::@1
    // case 2:
    //             config |= VERA_LAYER_COLOR_DEPTH_2BPP;
    //             break;
    // [418] if(vera_layer_mode_tile::color_depth#3==2) goto vera_layer_mode_tile::@5 -- vbuxx_eq_vbuc1_then_la1 
    cpx #2
    beq __b2
    // vera_layer_mode_tile::@2
    // case 4:
    //             config |= VERA_LAYER_COLOR_DEPTH_4BPP;
    //             break;
    // [419] if(vera_layer_mode_tile::color_depth#3==4) goto vera_layer_mode_tile::@5 -- vbuxx_eq_vbuc1_then_la1 
    cpx #4
    beq __b3
    // vera_layer_mode_tile::@3
    // case 8:
    //             config |= VERA_LAYER_COLOR_DEPTH_8BPP;
    //             break;
    // [420] if(vera_layer_mode_tile::color_depth#3!=8) goto vera_layer_mode_tile::@5 -- vbuxx_neq_vbuc1_then_la1 
    cpx #8
    bne __b4
    // [421] phi from vera_layer_mode_tile::@3 to vera_layer_mode_tile::@4 [phi:vera_layer_mode_tile::@3->vera_layer_mode_tile::@4]
    // vera_layer_mode_tile::@4
    // [422] phi from vera_layer_mode_tile::@4 to vera_layer_mode_tile::@5 [phi:vera_layer_mode_tile::@4->vera_layer_mode_tile::@5]
    // [422] phi vera_layer_mode_tile::config#17 = VERA_LAYER_COLOR_DEPTH_8BPP [phi:vera_layer_mode_tile::@4->vera_layer_mode_tile::@5#0] -- vbuxx=vbuc1 
    ldx #VERA_LAYER_COLOR_DEPTH_8BPP
    jmp __b5
    // [422] phi from vera_layer_mode_tile to vera_layer_mode_tile::@5 [phi:vera_layer_mode_tile->vera_layer_mode_tile::@5]
  __b1:
    // [422] phi vera_layer_mode_tile::config#17 = VERA_LAYER_COLOR_DEPTH_1BPP [phi:vera_layer_mode_tile->vera_layer_mode_tile::@5#0] -- vbuxx=vbuc1 
    ldx #VERA_LAYER_COLOR_DEPTH_1BPP
    jmp __b5
    // [422] phi from vera_layer_mode_tile::@1 to vera_layer_mode_tile::@5 [phi:vera_layer_mode_tile::@1->vera_layer_mode_tile::@5]
  __b2:
    // [422] phi vera_layer_mode_tile::config#17 = VERA_LAYER_COLOR_DEPTH_2BPP [phi:vera_layer_mode_tile::@1->vera_layer_mode_tile::@5#0] -- vbuxx=vbuc1 
    ldx #VERA_LAYER_COLOR_DEPTH_2BPP
    jmp __b5
    // [422] phi from vera_layer_mode_tile::@2 to vera_layer_mode_tile::@5 [phi:vera_layer_mode_tile::@2->vera_layer_mode_tile::@5]
  __b3:
    // [422] phi vera_layer_mode_tile::config#17 = VERA_LAYER_COLOR_DEPTH_4BPP [phi:vera_layer_mode_tile::@2->vera_layer_mode_tile::@5#0] -- vbuxx=vbuc1 
    ldx #VERA_LAYER_COLOR_DEPTH_4BPP
    jmp __b5
    // [422] phi from vera_layer_mode_tile::@3 to vera_layer_mode_tile::@5 [phi:vera_layer_mode_tile::@3->vera_layer_mode_tile::@5]
  __b4:
    // [422] phi vera_layer_mode_tile::config#17 = 0 [phi:vera_layer_mode_tile::@3->vera_layer_mode_tile::@5#0] -- vbuxx=vbuc1 
    ldx #0
    // vera_layer_mode_tile::@5
  __b5:
    // case 32:
    //             config |= VERA_LAYER_WIDTH_32;
    //             vera_layer_rowshift[layer] = 6;
    //             vera_layer_rowskip[layer] = 64;
    //             break;
    // [423] if(vera_layer_mode_tile::mapwidth#10==$20) goto vera_layer_mode_tile::@9 -- vwuz1_eq_vbuc1_then_la1 
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
    // [424] if(vera_layer_mode_tile::mapwidth#10==$40) goto vera_layer_mode_tile::@10 -- vwuz1_eq_vbuc1_then_la1 
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
    // [425] if(vera_layer_mode_tile::mapwidth#10==$80) goto vera_layer_mode_tile::@11 -- vwuz1_eq_vbuc1_then_la1 
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
    // [426] if(vera_layer_mode_tile::mapwidth#10!=$100) goto vera_layer_mode_tile::@13 -- vwuz1_neq_vwuc1_then_la1 
    lda.z mapwidth+1
    cmp #>$100
    bne __b13
    lda.z mapwidth
    cmp #<$100
    bne __b13
    // vera_layer_mode_tile::@12
    // config |= VERA_LAYER_WIDTH_256
    // [427] vera_layer_mode_tile::config#8 = vera_layer_mode_tile::config#17 | VERA_LAYER_WIDTH_256 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_LAYER_WIDTH_256
    tax
    // vera_layer_rowshift[layer] = 9
    // [428] vera_layer_rowshift[vera_layer_mode_tile::layer#10] = 9 -- pbuc1_derefidx_vbuz1=vbuc2 
    lda #9
    ldy.z layer
    sta vera_layer_rowshift,y
    // vera_layer_rowskip[layer] = 512
    // [429] vera_layer_mode_tile::$16 = vera_layer_mode_tile::layer#10 << 1 -- vbuaa=vbuz1_rol_1 
    tya
    asl
    // [430] vera_layer_rowskip[vera_layer_mode_tile::$16] = $200 -- pwuc1_derefidx_vbuaa=vwuc2 
    tay
    lda #<$200
    sta vera_layer_rowskip,y
    lda #>$200
    sta vera_layer_rowskip+1,y
    // [431] phi from vera_layer_mode_tile::@10 vera_layer_mode_tile::@11 vera_layer_mode_tile::@12 vera_layer_mode_tile::@8 vera_layer_mode_tile::@9 to vera_layer_mode_tile::@13 [phi:vera_layer_mode_tile::@10/vera_layer_mode_tile::@11/vera_layer_mode_tile::@12/vera_layer_mode_tile::@8/vera_layer_mode_tile::@9->vera_layer_mode_tile::@13]
    // [431] phi vera_layer_mode_tile::config#21 = vera_layer_mode_tile::config#6 [phi:vera_layer_mode_tile::@10/vera_layer_mode_tile::@11/vera_layer_mode_tile::@12/vera_layer_mode_tile::@8/vera_layer_mode_tile::@9->vera_layer_mode_tile::@13#0] -- register_copy 
    // vera_layer_mode_tile::@13
  __b13:
    // case 32:
    //             config |= VERA_LAYER_HEIGHT_32;
    //             break;
    // [432] if(vera_layer_mode_tile::mapheight#10==$20) goto vera_layer_mode_tile::@20 -- vwuz1_eq_vbuc1_then_la1 
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
    // [433] if(vera_layer_mode_tile::mapheight#10==$40) goto vera_layer_mode_tile::@17 -- vwuz1_eq_vbuc1_then_la1 
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
    // [434] if(vera_layer_mode_tile::mapheight#10==$80) goto vera_layer_mode_tile::@18 -- vwuz1_eq_vbuc1_then_la1 
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
    // [435] if(vera_layer_mode_tile::mapheight#10!=$100) goto vera_layer_mode_tile::@20 -- vwuz1_neq_vwuc1_then_la1 
    lda.z mapheight+1
    cmp #>$100
    bne __b20
    lda.z mapheight
    cmp #<$100
    bne __b20
    // vera_layer_mode_tile::@19
    // config |= VERA_LAYER_HEIGHT_256
    // [436] vera_layer_mode_tile::config#12 = vera_layer_mode_tile::config#21 | VERA_LAYER_HEIGHT_256 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_LAYER_HEIGHT_256
    tax
    // [437] phi from vera_layer_mode_tile::@13 vera_layer_mode_tile::@16 vera_layer_mode_tile::@17 vera_layer_mode_tile::@18 vera_layer_mode_tile::@19 to vera_layer_mode_tile::@20 [phi:vera_layer_mode_tile::@13/vera_layer_mode_tile::@16/vera_layer_mode_tile::@17/vera_layer_mode_tile::@18/vera_layer_mode_tile::@19->vera_layer_mode_tile::@20]
    // [437] phi vera_layer_mode_tile::config#25 = vera_layer_mode_tile::config#21 [phi:vera_layer_mode_tile::@13/vera_layer_mode_tile::@16/vera_layer_mode_tile::@17/vera_layer_mode_tile::@18/vera_layer_mode_tile::@19->vera_layer_mode_tile::@20#0] -- register_copy 
    // vera_layer_mode_tile::@20
  __b20:
    // vera_layer_set_config(layer, config)
    // [438] vera_layer_set_config::layer#0 = vera_layer_mode_tile::layer#10 -- vbuaa=vbuz1 
    lda.z layer
    // [439] vera_layer_set_config::config#0 = vera_layer_mode_tile::config#25
    // [440] call vera_layer_set_config 
    jsr vera_layer_set_config
    // vera_layer_mode_tile::@27
    // <mapbase_address
    // [441] vera_layer_mode_tile::$1 = < vera_layer_mode_tile::mapbase_address#10 -- vwuz1=_lo_vduz2 
    lda.z mapbase_address
    sta.z __1
    lda.z mapbase_address+1
    sta.z __1+1
    // vera_mapbase_offset[layer] = <mapbase_address
    // [442] vera_layer_mode_tile::$19 = vera_layer_mode_tile::layer#10 << 1 -- vbuz1=vbuz2_rol_1 
    lda.z layer
    asl
    sta.z __19
    // [443] vera_mapbase_offset[vera_layer_mode_tile::$19] = vera_layer_mode_tile::$1 -- pwuc1_derefidx_vbuz1=vwuz2 
    // mapbase
    tay
    lda.z __1
    sta vera_mapbase_offset,y
    lda.z __1+1
    sta vera_mapbase_offset+1,y
    // >mapbase_address
    // [444] vera_layer_mode_tile::$2 = > vera_layer_mode_tile::mapbase_address#10 -- vwuz1=_hi_vduz2 
    lda.z mapbase_address+2
    sta.z __2
    lda.z mapbase_address+3
    sta.z __2+1
    // vera_mapbase_bank[layer] = (byte)(>mapbase_address)
    // [445] vera_mapbase_bank[vera_layer_mode_tile::layer#10] = (byte)vera_layer_mode_tile::$2 -- pbuc1_derefidx_vbuz1=_byte_vwuz2 
    ldy.z layer
    lda.z __2
    sta vera_mapbase_bank,y
    // vera_mapbase_address[layer] = mapbase_address
    // [446] vera_layer_mode_tile::$20 = vera_layer_mode_tile::layer#10 << 2 -- vbuz1=vbuz2_rol_2 
    tya
    asl
    asl
    sta.z __20
    // [447] vera_mapbase_address[vera_layer_mode_tile::$20] = vera_layer_mode_tile::mapbase_address#10 -- pduc1_derefidx_vbuz1=vduz2 
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
    // [448] vera_layer_mode_tile::mapbase_address#0 = vera_layer_mode_tile::mapbase_address#10 >> 1 -- vduz1=vduz1_ror_1 
    lsr.z mapbase_address+3
    ror.z mapbase_address+2
    ror.z mapbase_address+1
    ror.z mapbase_address
    // <mapbase_address
    // [449] vera_layer_mode_tile::$4 = < vera_layer_mode_tile::mapbase_address#0 -- vwuz1=_lo_vduz2 
    lda.z mapbase_address
    sta.z __4
    lda.z mapbase_address+1
    sta.z __4+1
    // mapbase = >(<mapbase_address)
    // [450] vera_layer_mode_tile::mapbase#0 = > vera_layer_mode_tile::$4 -- vbuxx=_hi_vwuz1 
    tax
    // vera_layer_set_mapbase(layer,mapbase)
    // [451] vera_layer_set_mapbase::layer#0 = vera_layer_mode_tile::layer#10 -- vbuaa=vbuz1 
    lda.z layer
    // [452] vera_layer_set_mapbase::mapbase#0 = vera_layer_mode_tile::mapbase#0
    // [453] call vera_layer_set_mapbase 
    // [396] phi from vera_layer_mode_tile::@27 to vera_layer_set_mapbase [phi:vera_layer_mode_tile::@27->vera_layer_set_mapbase]
    // [396] phi vera_layer_set_mapbase::mapbase#3 = vera_layer_set_mapbase::mapbase#0 [phi:vera_layer_mode_tile::@27->vera_layer_set_mapbase#0] -- register_copy 
    // [396] phi vera_layer_set_mapbase::layer#3 = vera_layer_set_mapbase::layer#0 [phi:vera_layer_mode_tile::@27->vera_layer_set_mapbase#1] -- register_copy 
    jsr vera_layer_set_mapbase
    // vera_layer_mode_tile::@28
    // <tilebase_address
    // [454] vera_layer_mode_tile::$7 = < vera_layer_mode_tile::tilebase_address#10 -- vwuz1=_lo_vduz2 
    lda.z tilebase_address
    sta.z __7
    lda.z tilebase_address+1
    sta.z __7+1
    // vera_tilebase_offset[layer] = <tilebase_address
    // [455] vera_tilebase_offset[vera_layer_mode_tile::$19] = vera_layer_mode_tile::$7 -- pwuc1_derefidx_vbuz1=vwuz2 
    // tilebase
    ldy.z __19
    lda.z __7
    sta vera_tilebase_offset,y
    lda.z __7+1
    sta vera_tilebase_offset+1,y
    // >tilebase_address
    // [456] vera_layer_mode_tile::$8 = > vera_layer_mode_tile::tilebase_address#10 -- vwuz1=_hi_vduz2 
    lda.z tilebase_address+2
    sta.z __8
    lda.z tilebase_address+3
    sta.z __8+1
    // vera_tilebase_bank[layer] = (byte)>tilebase_address
    // [457] vera_tilebase_bank[vera_layer_mode_tile::layer#10] = (byte)vera_layer_mode_tile::$8 -- pbuc1_derefidx_vbuz1=_byte_vwuz2 
    ldy.z layer
    lda.z __8
    sta vera_tilebase_bank,y
    // vera_tilebase_address[layer] = tilebase_address
    // [458] vera_tilebase_address[vera_layer_mode_tile::$20] = vera_layer_mode_tile::tilebase_address#10 -- pduc1_derefidx_vbuz1=vduz2 
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
    // [459] vera_layer_mode_tile::tilebase_address#0 = vera_layer_mode_tile::tilebase_address#10 >> 1 -- vduz1=vduz1_ror_1 
    lsr.z tilebase_address+3
    ror.z tilebase_address+2
    ror.z tilebase_address+1
    ror.z tilebase_address
    // <tilebase_address
    // [460] vera_layer_mode_tile::$10 = < vera_layer_mode_tile::tilebase_address#0 -- vwuz1=_lo_vduz2 
    lda.z tilebase_address
    sta.z __10
    lda.z tilebase_address+1
    sta.z __10+1
    // tilebase = >(<tilebase_address)
    // [461] vera_layer_mode_tile::tilebase#0 = > vera_layer_mode_tile::$10 -- vbuaa=_hi_vwuz1 
    // tilebase &= VERA_LAYER_TILEBASE_MASK
    // [462] vera_layer_mode_tile::tilebase#1 = vera_layer_mode_tile::tilebase#0 & VERA_LAYER_TILEBASE_MASK -- vbuxx=vbuaa_band_vbuc1 
    and #VERA_LAYER_TILEBASE_MASK
    tax
    // case 8:
    //             tilebase |= VERA_TILEBASE_WIDTH_8;
    //             break;
    // [463] if(vera_layer_mode_tile::tilewidth#10==8) goto vera_layer_mode_tile::@23 -- vbuz1_eq_vbuc1_then_la1 
    lda #8
    cmp.z tilewidth
    beq __b23
    // vera_layer_mode_tile::@21
    // case 16:
    //             tilebase |= VERA_TILEBASE_WIDTH_16;
    //             break;
    // [464] if(vera_layer_mode_tile::tilewidth#10!=$10) goto vera_layer_mode_tile::@23 -- vbuz1_neq_vbuc1_then_la1 
    lda #$10
    cmp.z tilewidth
    bne __b23
    // vera_layer_mode_tile::@22
    // tilebase |= VERA_TILEBASE_WIDTH_16
    // [465] vera_layer_mode_tile::tilebase#3 = vera_layer_mode_tile::tilebase#1 | VERA_TILEBASE_WIDTH_16 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_TILEBASE_WIDTH_16
    tax
    // [466] phi from vera_layer_mode_tile::@21 vera_layer_mode_tile::@22 vera_layer_mode_tile::@28 to vera_layer_mode_tile::@23 [phi:vera_layer_mode_tile::@21/vera_layer_mode_tile::@22/vera_layer_mode_tile::@28->vera_layer_mode_tile::@23]
    // [466] phi vera_layer_mode_tile::tilebase#12 = vera_layer_mode_tile::tilebase#1 [phi:vera_layer_mode_tile::@21/vera_layer_mode_tile::@22/vera_layer_mode_tile::@28->vera_layer_mode_tile::@23#0] -- register_copy 
    // vera_layer_mode_tile::@23
  __b23:
    // case 8:
    //             tilebase |= VERA_TILEBASE_HEIGHT_8;
    //             break;
    // [467] if(vera_layer_mode_tile::tileheight#10==8) goto vera_layer_mode_tile::@26 -- vbuz1_eq_vbuc1_then_la1 
    lda #8
    cmp.z tileheight
    beq __b26
    // vera_layer_mode_tile::@24
    // case 16:
    //             tilebase |= VERA_TILEBASE_HEIGHT_16;
    //             break;
    // [468] if(vera_layer_mode_tile::tileheight#10!=$10) goto vera_layer_mode_tile::@26 -- vbuz1_neq_vbuc1_then_la1 
    lda #$10
    cmp.z tileheight
    bne __b26
    // vera_layer_mode_tile::@25
    // tilebase |= VERA_TILEBASE_HEIGHT_16
    // [469] vera_layer_mode_tile::tilebase#5 = vera_layer_mode_tile::tilebase#12 | VERA_TILEBASE_HEIGHT_16 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_TILEBASE_HEIGHT_16
    tax
    // [470] phi from vera_layer_mode_tile::@23 vera_layer_mode_tile::@24 vera_layer_mode_tile::@25 to vera_layer_mode_tile::@26 [phi:vera_layer_mode_tile::@23/vera_layer_mode_tile::@24/vera_layer_mode_tile::@25->vera_layer_mode_tile::@26]
    // [470] phi vera_layer_mode_tile::tilebase#10 = vera_layer_mode_tile::tilebase#12 [phi:vera_layer_mode_tile::@23/vera_layer_mode_tile::@24/vera_layer_mode_tile::@25->vera_layer_mode_tile::@26#0] -- register_copy 
    // vera_layer_mode_tile::@26
  __b26:
    // vera_layer_set_tilebase(layer,tilebase)
    // [471] vera_layer_set_tilebase::layer#0 = vera_layer_mode_tile::layer#10 -- vbuaa=vbuz1 
    lda.z layer
    // [472] vera_layer_set_tilebase::tilebase#0 = vera_layer_mode_tile::tilebase#10
    // [473] call vera_layer_set_tilebase 
    jsr vera_layer_set_tilebase
    // vera_layer_mode_tile::@return
    // }
    // [474] return 
    rts
    // vera_layer_mode_tile::@18
  __b18:
    // config |= VERA_LAYER_HEIGHT_128
    // [475] vera_layer_mode_tile::config#11 = vera_layer_mode_tile::config#21 | VERA_LAYER_HEIGHT_128 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_LAYER_HEIGHT_128
    tax
    jmp __b20
    // vera_layer_mode_tile::@17
  __b17:
    // config |= VERA_LAYER_HEIGHT_64
    // [476] vera_layer_mode_tile::config#10 = vera_layer_mode_tile::config#21 | VERA_LAYER_HEIGHT_64 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_LAYER_HEIGHT_64
    tax
    jmp __b20
    // vera_layer_mode_tile::@11
  __b11:
    // config |= VERA_LAYER_WIDTH_128
    // [477] vera_layer_mode_tile::config#7 = vera_layer_mode_tile::config#17 | VERA_LAYER_WIDTH_128 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_LAYER_WIDTH_128
    tax
    // vera_layer_rowshift[layer] = 8
    // [478] vera_layer_rowshift[vera_layer_mode_tile::layer#10] = 8 -- pbuc1_derefidx_vbuz1=vbuc2 
    lda #8
    ldy.z layer
    sta vera_layer_rowshift,y
    // vera_layer_rowskip[layer] = 256
    // [479] vera_layer_mode_tile::$15 = vera_layer_mode_tile::layer#10 << 1 -- vbuaa=vbuz1_rol_1 
    tya
    asl
    // [480] vera_layer_rowskip[vera_layer_mode_tile::$15] = $100 -- pwuc1_derefidx_vbuaa=vwuc2 
    tay
    lda #<$100
    sta vera_layer_rowskip,y
    lda #>$100
    sta vera_layer_rowskip+1,y
    jmp __b13
    // vera_layer_mode_tile::@10
  __b10:
    // config |= VERA_LAYER_WIDTH_64
    // [481] vera_layer_mode_tile::config#6 = vera_layer_mode_tile::config#17 | VERA_LAYER_WIDTH_64 -- vbuxx=vbuxx_bor_vbuc1 
    txa
    ora #VERA_LAYER_WIDTH_64
    tax
    // vera_layer_rowshift[layer] = 7
    // [482] vera_layer_rowshift[vera_layer_mode_tile::layer#10] = 7 -- pbuc1_derefidx_vbuz1=vbuc2 
    lda #7
    ldy.z layer
    sta vera_layer_rowshift,y
    // vera_layer_rowskip[layer] = 128
    // [483] vera_layer_mode_tile::$14 = vera_layer_mode_tile::layer#10 << 1 -- vbuaa=vbuz1_rol_1 
    tya
    asl
    // [484] vera_layer_rowskip[vera_layer_mode_tile::$14] = $80 -- pwuc1_derefidx_vbuaa=vbuc2 
    tay
    lda #$80
    sta vera_layer_rowskip,y
    lda #0
    sta vera_layer_rowskip+1,y
    jmp __b13
    // vera_layer_mode_tile::@9
  __b9:
    // vera_layer_rowshift[layer] = 6
    // [485] vera_layer_rowshift[vera_layer_mode_tile::layer#10] = 6 -- pbuc1_derefidx_vbuz1=vbuc2 
    lda #6
    ldy.z layer
    sta vera_layer_rowshift,y
    // vera_layer_rowskip[layer] = 64
    // [486] vera_layer_mode_tile::$13 = vera_layer_mode_tile::layer#10 << 1 -- vbuaa=vbuz1_rol_1 
    tya
    asl
    // [487] vera_layer_rowskip[vera_layer_mode_tile::$13] = $40 -- pwuc1_derefidx_vbuaa=vbuc2 
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
    .label __1 = $61
    .label line_text = $68
    .label color = $61
    .label conio_map_height = $64
    .label conio_map_width = $66
    // line_text = cx16_conio.conio_screen_text
    // [488] clrscr::line_text#0 = *((byte**)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT) -- pbuz1=_deref_qbuc1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT
    sta.z line_text
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT+1
    sta.z line_text+1
    // vera_layer_get_backcolor(cx16_conio.conio_screen_layer)
    // [489] vera_layer_get_backcolor::layer#0 = *((byte*)&cx16_conio) -- vbuxx=_deref_pbuc1 
    ldx cx16_conio
    // [490] call vera_layer_get_backcolor 
    jsr vera_layer_get_backcolor
    // [491] vera_layer_get_backcolor::return#2 = vera_layer_get_backcolor::return#0
    // clrscr::@7
    // [492] clrscr::$0 = vera_layer_get_backcolor::return#2
    // vera_layer_get_backcolor(cx16_conio.conio_screen_layer) << 4
    // [493] clrscr::$1 = clrscr::$0 << 4 -- vbuz1=vbuaa_rol_4 
    asl
    asl
    asl
    asl
    sta.z __1
    // vera_layer_get_textcolor(cx16_conio.conio_screen_layer)
    // [494] vera_layer_get_textcolor::layer#0 = *((byte*)&cx16_conio) -- vbuxx=_deref_pbuc1 
    ldx cx16_conio
    // [495] call vera_layer_get_textcolor 
    jsr vera_layer_get_textcolor
    // [496] vera_layer_get_textcolor::return#2 = vera_layer_get_textcolor::return#0
    // clrscr::@8
    // [497] clrscr::$2 = vera_layer_get_textcolor::return#2
    // color = ( vera_layer_get_backcolor(cx16_conio.conio_screen_layer) << 4 ) | vera_layer_get_textcolor(cx16_conio.conio_screen_layer)
    // [498] clrscr::color#0 = clrscr::$1 | clrscr::$2 -- vbuz1=vbuz1_bor_vbuaa 
    ora.z color
    sta.z color
    // conio_map_height = cx16_conio.conio_map_height
    // [499] clrscr::conio_map_height#0 = *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT) -- vwuz1=_deref_pwuc1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT
    sta.z conio_map_height
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_HEIGHT+1
    sta.z conio_map_height+1
    // conio_map_width = cx16_conio.conio_map_width
    // [500] clrscr::conio_map_width#0 = *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH) -- vwuz1=_deref_pwuc1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH
    sta.z conio_map_width
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH+1
    sta.z conio_map_width+1
    // [501] phi from clrscr::@8 to clrscr::@1 [phi:clrscr::@8->clrscr::@1]
    // [501] phi clrscr::line_text#2 = clrscr::line_text#0 [phi:clrscr::@8->clrscr::@1#0] -- register_copy 
    // [501] phi clrscr::l#2 = 0 [phi:clrscr::@8->clrscr::@1#1] -- vbuxx=vbuc1 
    ldx #0
    // clrscr::@1
  __b1:
    // for( char l=0;l<conio_map_height; l++ )
    // [502] if(clrscr::l#2<clrscr::conio_map_height#0) goto clrscr::@2 -- vbuxx_lt_vwuz1_then_la1 
    lda.z conio_map_height+1
    bne __b2
    cpx.z conio_map_height
    bcc __b2
    // clrscr::@3
    // conio_cursor_x[cx16_conio.conio_screen_layer] = 0
    // [503] conio_cursor_x[*((byte*)&cx16_conio)] = 0 -- pbuc1_derefidx_(_deref_pbuc2)=vbuc3 
    lda #0
    ldy cx16_conio
    sta conio_cursor_x,y
    // conio_cursor_y[cx16_conio.conio_screen_layer] = 0
    // [504] conio_cursor_y[*((byte*)&cx16_conio)] = 0 -- pbuc1_derefidx_(_deref_pbuc2)=vbuc3 
    sta conio_cursor_y,y
    // conio_line_text[cx16_conio.conio_screen_layer] = 0
    // [505] clrscr::$9 = *((byte*)&cx16_conio) << 1 -- vbuaa=_deref_pbuc1_rol_1 
    tya
    asl
    // [506] conio_line_text[clrscr::$9] = 0 -- pwuc1_derefidx_vbuaa=vbuc2 
    tay
    lda #0
    sta conio_line_text,y
    sta conio_line_text+1,y
    // clrscr::@return
    // }
    // [507] return 
    rts
    // clrscr::@2
  __b2:
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [508] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    // Select DATA0
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <ch
    // [509] clrscr::$5 = < clrscr::line_text#2 -- vbuaa=_lo_pbuz1 
    lda.z line_text
    // *VERA_ADDRX_L = <ch
    // [510] *VERA_ADDRX_L = clrscr::$5 -- _deref_pbuc1=vbuaa 
    // Set address
    sta VERA_ADDRX_L
    // >ch
    // [511] clrscr::$6 = > clrscr::line_text#2 -- vbuaa=_hi_pbuz1 
    lda.z line_text+1
    // *VERA_ADDRX_M = >ch
    // [512] *VERA_ADDRX_M = clrscr::$6 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // cx16_conio.conio_screen_bank | VERA_INC_1
    // [513] clrscr::$7 = *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK) | VERA_INC_1 -- vbuaa=_deref_pbuc1_bor_vbuc2 
    lda #VERA_INC_1
    ora cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK
    // *VERA_ADDRX_H = cx16_conio.conio_screen_bank | VERA_INC_1
    // [514] *VERA_ADDRX_H = clrscr::$7 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_H
    // [515] phi from clrscr::@2 to clrscr::@4 [phi:clrscr::@2->clrscr::@4]
    // [515] phi clrscr::c#2 = 0 [phi:clrscr::@2->clrscr::@4#0] -- vbuyy=vbuc1 
    ldy #0
    // clrscr::@4
  __b4:
    // for( char c=0;c<conio_map_width; c++ )
    // [516] if(clrscr::c#2<clrscr::conio_map_width#0) goto clrscr::@5 -- vbuyy_lt_vwuz1_then_la1 
    lda.z conio_map_width+1
    bne __b5
    cpy.z conio_map_width
    bcc __b5
    // clrscr::@6
    // line_text += cx16_conio.conio_rowskip
    // [517] clrscr::line_text#1 = clrscr::line_text#2 + *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP) -- pbuz1=pbuz1_plus__deref_pwuc1 
    clc
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP
    adc.z line_text
    sta.z line_text
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP+1
    adc.z line_text+1
    sta.z line_text+1
    // for( char l=0;l<conio_map_height; l++ )
    // [518] clrscr::l#1 = ++ clrscr::l#2 -- vbuxx=_inc_vbuxx 
    inx
    // [501] phi from clrscr::@6 to clrscr::@1 [phi:clrscr::@6->clrscr::@1]
    // [501] phi clrscr::line_text#2 = clrscr::line_text#1 [phi:clrscr::@6->clrscr::@1#0] -- register_copy 
    // [501] phi clrscr::l#2 = clrscr::l#1 [phi:clrscr::@6->clrscr::@1#1] -- register_copy 
    jmp __b1
    // clrscr::@5
  __b5:
    // *VERA_DATA0 = ' '
    // [519] *VERA_DATA0 = ' ' -- _deref_pbuc1=vbuc2 
    lda #' '
    sta VERA_DATA0
    // *VERA_DATA0 = color
    // [520] *VERA_DATA0 = clrscr::color#0 -- _deref_pbuc1=vbuz1 
    lda.z color
    sta VERA_DATA0
    // for( char c=0;c<conio_map_width; c++ )
    // [521] clrscr::c#1 = ++ clrscr::c#2 -- vbuyy=_inc_vbuyy 
    iny
    // [515] phi from clrscr::@5 to clrscr::@4 [phi:clrscr::@5->clrscr::@4]
    // [515] phi clrscr::c#2 = clrscr::c#1 [phi:clrscr::@5->clrscr::@4#0] -- register_copy 
    jmp __b4
}
  // cx16_load_ram_banked
// Load a file to cx16 banked RAM at address A000-BFFF.
// Returns a status:
// - 0xff: Success
// - other: Kernal Error Code (https://commodore.ca/manuals/pdfs/commodore_error_messages.pdf)
// cx16_load_ram_banked(byte* zp($68) filename, dword zp($1e) address)
cx16_load_ram_banked: {
    .label __0 = $64
    .label __1 = $64
    .label __3 = $66
    .label __5 = $62
    .label __6 = $62
    .label __7 = $64
    .label __8 = $64
    .label __10 = $62
    .label __11 = $71
    .label __33 = $62
    .label __34 = $66
    .label bank = $61
    // select the bank
    .label addr = $71
    .label status = $3b
    .label return = $3b
    .label ch = $3c
    .label address = $1e
    .label filename = $68
    // >address
    // [523] cx16_load_ram_banked::$0 = > cx16_load_ram_banked::address#7 -- vwuz1=_hi_vduz2 
    lda.z address+2
    sta.z __0
    lda.z address+3
    sta.z __0+1
    // (>address)<<8
    // [524] cx16_load_ram_banked::$1 = cx16_load_ram_banked::$0 << 8 -- vwuz1=vwuz1_rol_8 
    lda.z __1
    sta.z __1+1
    lda #0
    sta.z __1
    // <(>address)<<8
    // [525] cx16_load_ram_banked::$2 = < cx16_load_ram_banked::$1 -- vbuxx=_lo_vwuz1 
    tax
    // <address
    // [526] cx16_load_ram_banked::$3 = < cx16_load_ram_banked::address#7 -- vwuz1=_lo_vduz2 
    lda.z address
    sta.z __3
    lda.z address+1
    sta.z __3+1
    // >(<address)
    // [527] cx16_load_ram_banked::$4 = > cx16_load_ram_banked::$3 -- vbuyy=_hi_vwuz1 
    tay
    // ((word)<(>address)<<8)|>(<address)
    // [528] cx16_load_ram_banked::$33 = (word)cx16_load_ram_banked::$2 -- vwuz1=_word_vbuxx 
    txa
    sta.z __33
    sta.z __33+1
    // [529] cx16_load_ram_banked::$5 = cx16_load_ram_banked::$33 | cx16_load_ram_banked::$4 -- vwuz1=vwuz1_bor_vbuyy 
    tya
    ora.z __5
    sta.z __5
    // (((word)<(>address)<<8)|>(<address))>>5
    // [530] cx16_load_ram_banked::$6 = cx16_load_ram_banked::$5 >> 5 -- vwuz1=vwuz1_ror_5 
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
    // [531] cx16_load_ram_banked::$7 = > cx16_load_ram_banked::address#7 -- vwuz1=_hi_vduz2 
    lda.z address+2
    sta.z __7
    lda.z address+3
    sta.z __7+1
    // (>address)<<3
    // [532] cx16_load_ram_banked::$8 = cx16_load_ram_banked::$7 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z __8
    rol.z __8+1
    asl.z __8
    rol.z __8+1
    asl.z __8
    rol.z __8+1
    // <(>address)<<3
    // [533] cx16_load_ram_banked::$9 = < cx16_load_ram_banked::$8 -- vbuaa=_lo_vwuz1 
    lda.z __8
    // ((((word)<(>address)<<8)|>(<address))>>5)+((word)<(>address)<<3)
    // [534] cx16_load_ram_banked::$34 = (word)cx16_load_ram_banked::$9 -- vwuz1=_word_vbuaa 
    sta.z __34
    txa
    sta.z __34+1
    // [535] cx16_load_ram_banked::$10 = cx16_load_ram_banked::$6 + cx16_load_ram_banked::$34 -- vwuz1=vwuz1_plus_vwuz2 
    lda.z __10
    clc
    adc.z __34
    sta.z __10
    lda.z __10+1
    adc.z __34+1
    sta.z __10+1
    // bank = (byte)(((((word)<(>address)<<8)|>(<address))>>5)+((word)<(>address)<<3))
    // [536] cx16_load_ram_banked::bank#0 = (byte)cx16_load_ram_banked::$10 -- vbuz1=_byte_vwuz2 
    lda.z __10
    sta.z bank
    // <address
    // [537] cx16_load_ram_banked::$11 = < cx16_load_ram_banked::address#7 -- vwuz1=_lo_vduz2 
    lda.z address
    sta.z __11
    lda.z address+1
    sta.z __11+1
    // (<address)&0x1FFF
    // [538] cx16_load_ram_banked::addr#0 = cx16_load_ram_banked::$11 & $1fff -- vwuz1=vwuz1_band_vwuc1 
    lda.z addr
    and #<$1fff
    sta.z addr
    lda.z addr+1
    and #>$1fff
    sta.z addr+1
    // addr += 0xA000
    // [539] cx16_load_ram_banked::addr#1 = (byte*)cx16_load_ram_banked::addr#0 + $a000 -- pbuz1=pbuz1_plus_vwuc1 
    // stip off the top 3 bits, which are representing the bank of the word!
    clc
    lda.z addr
    adc #<$a000
    sta.z addr
    lda.z addr+1
    adc #>$a000
    sta.z addr+1
    // cx16_ram_bank(bank)
    // [540] cx16_ram_bank::bank#0 = cx16_load_ram_banked::bank#0 -- vbuaa=vbuz1 
    lda.z bank
    // [541] call cx16_ram_bank 
    // [994] phi from cx16_load_ram_banked to cx16_ram_bank [phi:cx16_load_ram_banked->cx16_ram_bank]
    // [994] phi cx16_ram_bank::bank#5 = cx16_ram_bank::bank#0 [phi:cx16_load_ram_banked->cx16_ram_bank#0] -- register_copy 
    jsr cx16_ram_bank
    // cx16_load_ram_banked::@8
    // cbm_k_setnam(filename)
    // [542] cbm_k_setnam::filename = cx16_load_ram_banked::filename#7 -- pbuz1=pbuz2 
    lda.z filename
    sta.z cbm_k_setnam.filename
    lda.z filename+1
    sta.z cbm_k_setnam.filename+1
    // [543] call cbm_k_setnam 
    jsr cbm_k_setnam
    // cx16_load_ram_banked::@9
    // cbm_k_setlfs(channel, device, secondary)
    // [544] cbm_k_setlfs::channel = 1 -- vbuz1=vbuc1 
    lda #1
    sta.z cbm_k_setlfs.channel
    // [545] cbm_k_setlfs::device = 8 -- vbuz1=vbuc1 
    lda #8
    sta.z cbm_k_setlfs.device
    // [546] cbm_k_setlfs::secondary = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z cbm_k_setlfs.secondary
    // [547] call cbm_k_setlfs 
    jsr cbm_k_setlfs
    // [548] phi from cx16_load_ram_banked::@9 to cx16_load_ram_banked::@10 [phi:cx16_load_ram_banked::@9->cx16_load_ram_banked::@10]
    // cx16_load_ram_banked::@10
    // cbm_k_open()
    // [549] call cbm_k_open 
    jsr cbm_k_open
    // [550] cbm_k_open::return#2 = cbm_k_open::return#1
    // cx16_load_ram_banked::@11
    // [551] cx16_load_ram_banked::status#1 = cbm_k_open::return#2 -- vbuz1=vbuaa 
    sta.z status
    // if(status!=$FF)
    // [552] if(cx16_load_ram_banked::status#1==$ff) goto cx16_load_ram_banked::@1 -- vbuz1_eq_vbuc1_then_la1 
    lda #$ff
    cmp.z status
    beq __b1
    // [553] phi from cx16_load_ram_banked::@11 cx16_load_ram_banked::@12 cx16_load_ram_banked::@16 to cx16_load_ram_banked::@return [phi:cx16_load_ram_banked::@11/cx16_load_ram_banked::@12/cx16_load_ram_banked::@16->cx16_load_ram_banked::@return]
    // [553] phi cx16_load_ram_banked::return#1 = cx16_load_ram_banked::status#1 [phi:cx16_load_ram_banked::@11/cx16_load_ram_banked::@12/cx16_load_ram_banked::@16->cx16_load_ram_banked::@return#0] -- register_copy 
    // cx16_load_ram_banked::@return
    // }
    // [554] return 
    rts
    // cx16_load_ram_banked::@1
  __b1:
    // cbm_k_chkin(channel)
    // [555] cbm_k_chkin::channel = 1 -- vbuz1=vbuc1 
    lda #1
    sta.z cbm_k_chkin.channel
    // [556] call cbm_k_chkin 
    jsr cbm_k_chkin
    // [557] cbm_k_chkin::return#2 = cbm_k_chkin::return#1
    // cx16_load_ram_banked::@12
    // [558] cx16_load_ram_banked::status#2 = cbm_k_chkin::return#2 -- vbuz1=vbuaa 
    sta.z status
    // if(status!=$FF)
    // [559] if(cx16_load_ram_banked::status#2==$ff) goto cx16_load_ram_banked::@2 -- vbuz1_eq_vbuc1_then_la1 
    lda #$ff
    cmp.z status
    beq __b2
    rts
    // [560] phi from cx16_load_ram_banked::@12 to cx16_load_ram_banked::@2 [phi:cx16_load_ram_banked::@12->cx16_load_ram_banked::@2]
    // cx16_load_ram_banked::@2
  __b2:
    // cbm_k_chrin()
    // [561] call cbm_k_chrin 
    jsr cbm_k_chrin
    // [562] cbm_k_chrin::return#2 = cbm_k_chrin::return#1
    // cx16_load_ram_banked::@13
    // ch = cbm_k_chrin()
    // [563] cx16_load_ram_banked::ch#1 = cbm_k_chrin::return#2 -- vbuz1=vbuaa 
    sta.z ch
    // cbm_k_readst()
    // [564] call cbm_k_readst 
    jsr cbm_k_readst
    // [565] cbm_k_readst::return#2 = cbm_k_readst::return#1
    // cx16_load_ram_banked::@14
    // status = cbm_k_readst()
    // [566] cx16_load_ram_banked::status#3 = cbm_k_readst::return#2
    // [567] phi from cx16_load_ram_banked::@14 cx16_load_ram_banked::@18 to cx16_load_ram_banked::@3 [phi:cx16_load_ram_banked::@14/cx16_load_ram_banked::@18->cx16_load_ram_banked::@3]
    // [567] phi cx16_load_ram_banked::bank#2 = cx16_load_ram_banked::bank#0 [phi:cx16_load_ram_banked::@14/cx16_load_ram_banked::@18->cx16_load_ram_banked::@3#0] -- register_copy 
    // [567] phi cx16_load_ram_banked::ch#3 = cx16_load_ram_banked::ch#1 [phi:cx16_load_ram_banked::@14/cx16_load_ram_banked::@18->cx16_load_ram_banked::@3#1] -- register_copy 
    // [567] phi cx16_load_ram_banked::addr#4 = cx16_load_ram_banked::addr#1 [phi:cx16_load_ram_banked::@14/cx16_load_ram_banked::@18->cx16_load_ram_banked::@3#2] -- register_copy 
    // [567] phi cx16_load_ram_banked::status#8 = cx16_load_ram_banked::status#3 [phi:cx16_load_ram_banked::@14/cx16_load_ram_banked::@18->cx16_load_ram_banked::@3#3] -- register_copy 
    // cx16_load_ram_banked::@3
  __b3:
    // while (!status)
    // [568] if(0==cx16_load_ram_banked::status#8) goto cx16_load_ram_banked::@4 -- 0_eq_vbuaa_then_la1 
    cmp #0
    beq __b4
    // cx16_load_ram_banked::@5
    // cbm_k_close(channel)
    // [569] cbm_k_close::channel = 1 -- vbuz1=vbuc1 
    lda #1
    sta.z cbm_k_close.channel
    // [570] call cbm_k_close 
    jsr cbm_k_close
    // [571] cbm_k_close::return#2 = cbm_k_close::return#1
    // cx16_load_ram_banked::@15
    // [572] cx16_load_ram_banked::status#10 = cbm_k_close::return#2 -- vbuz1=vbuaa 
    sta.z status
    // cbm_k_clrchn()
    // [573] call cbm_k_clrchn 
    jsr cbm_k_clrchn
    // [574] phi from cx16_load_ram_banked::@15 to cx16_load_ram_banked::@16 [phi:cx16_load_ram_banked::@15->cx16_load_ram_banked::@16]
    // cx16_load_ram_banked::@16
    // cx16_ram_bank(1)
    // [575] call cx16_ram_bank 
    // [994] phi from cx16_load_ram_banked::@16 to cx16_ram_bank [phi:cx16_load_ram_banked::@16->cx16_ram_bank]
    // [994] phi cx16_ram_bank::bank#5 = 1 [phi:cx16_load_ram_banked::@16->cx16_ram_bank#0] -- vbuaa=vbuc1 
    lda #1
    jsr cx16_ram_bank
    rts
    // cx16_load_ram_banked::@4
  __b4:
    // if(addr == 0xC000)
    // [576] if(cx16_load_ram_banked::addr#4!=$c000) goto cx16_load_ram_banked::@6 -- pbuz1_neq_vwuc1_then_la1 
    lda.z addr+1
    cmp #>$c000
    bne __b6
    lda.z addr
    cmp #<$c000
    bne __b6
    // cx16_load_ram_banked::@7
    // bank++;
    // [577] cx16_load_ram_banked::bank#1 = ++ cx16_load_ram_banked::bank#2 -- vbuz1=_inc_vbuz1 
    inc.z bank
    // cx16_ram_bank(bank)
    // [578] cx16_ram_bank::bank#2 = cx16_load_ram_banked::bank#1 -- vbuaa=vbuz1 
    lda.z bank
    // [579] call cx16_ram_bank 
  //printf(", %u", (word)bank);
    // [994] phi from cx16_load_ram_banked::@7 to cx16_ram_bank [phi:cx16_load_ram_banked::@7->cx16_ram_bank]
    // [994] phi cx16_ram_bank::bank#5 = cx16_ram_bank::bank#2 [phi:cx16_load_ram_banked::@7->cx16_ram_bank#0] -- register_copy 
    jsr cx16_ram_bank
    // [580] phi from cx16_load_ram_banked::@7 to cx16_load_ram_banked::@6 [phi:cx16_load_ram_banked::@7->cx16_load_ram_banked::@6]
    // [580] phi cx16_load_ram_banked::bank#10 = cx16_load_ram_banked::bank#1 [phi:cx16_load_ram_banked::@7->cx16_load_ram_banked::@6#0] -- register_copy 
    // [580] phi cx16_load_ram_banked::addr#5 = (byte*) 40960 [phi:cx16_load_ram_banked::@7->cx16_load_ram_banked::@6#1] -- pbuz1=pbuc1 
    lda #<$a000
    sta.z addr
    lda #>$a000
    sta.z addr+1
    // [580] phi from cx16_load_ram_banked::@4 to cx16_load_ram_banked::@6 [phi:cx16_load_ram_banked::@4->cx16_load_ram_banked::@6]
    // [580] phi cx16_load_ram_banked::bank#10 = cx16_load_ram_banked::bank#2 [phi:cx16_load_ram_banked::@4->cx16_load_ram_banked::@6#0] -- register_copy 
    // [580] phi cx16_load_ram_banked::addr#5 = cx16_load_ram_banked::addr#4 [phi:cx16_load_ram_banked::@4->cx16_load_ram_banked::@6#1] -- register_copy 
    // cx16_load_ram_banked::@6
  __b6:
    // *addr = ch
    // [581] *cx16_load_ram_banked::addr#5 = cx16_load_ram_banked::ch#3 -- _deref_pbuz1=vbuz2 
    lda.z ch
    ldy #0
    sta (addr),y
    // addr++;
    // [582] cx16_load_ram_banked::addr#10 = ++ cx16_load_ram_banked::addr#5 -- pbuz1=_inc_pbuz1 
    inc.z addr
    bne !+
    inc.z addr+1
  !:
    // cbm_k_chrin()
    // [583] call cbm_k_chrin 
    jsr cbm_k_chrin
    // [584] cbm_k_chrin::return#3 = cbm_k_chrin::return#1
    // cx16_load_ram_banked::@17
    // ch = cbm_k_chrin()
    // [585] cx16_load_ram_banked::ch#2 = cbm_k_chrin::return#3 -- vbuz1=vbuaa 
    sta.z ch
    // cbm_k_readst()
    // [586] call cbm_k_readst 
    jsr cbm_k_readst
    // [587] cbm_k_readst::return#3 = cbm_k_readst::return#1
    // cx16_load_ram_banked::@18
    // status = cbm_k_readst()
    // [588] cx16_load_ram_banked::status#5 = cbm_k_readst::return#3
    jmp __b3
}
  // cputs
// Output a NUL-terminated string at the current cursor position
// cputs(byte* zp($71) s)
cputs: {
    .label s = $71
    // [590] phi from cputs cputs::@2 to cputs::@1 [phi:cputs/cputs::@2->cputs::@1]
    // [590] phi cputs::s#15 = cputs::s#16 [phi:cputs/cputs::@2->cputs::@1#0] -- register_copy 
    // cputs::@1
  __b1:
    // while(c=*s++)
    // [591] cputs::c#1 = *cputs::s#15 -- vbuaa=_deref_pbuz1 
    ldy #0
    lda (s),y
    // [592] cputs::s#0 = ++ cputs::s#15 -- pbuz1=_inc_pbuz1 
    inc.z s
    bne !+
    inc.z s+1
  !:
    // [593] if(0!=cputs::c#1) goto cputs::@2 -- 0_neq_vbuaa_then_la1 
    cmp #0
    bne __b2
    // cputs::@return
    // }
    // [594] return 
    rts
    // cputs::@2
  __b2:
    // cputc(c)
    // [595] cputc::c#0 = cputs::c#1 -- vbuz1=vbuaa 
    sta.z cputc.c
    // [596] call cputc 
    // [1033] phi from cputs::@2 to cputc [phi:cputs::@2->cputc]
    // [1033] phi cputc::c#3 = cputc::c#0 [phi:cputs::@2->cputc#0] -- register_copy 
    jsr cputc
    jmp __b1
}
  // printf_uchar
// Print an unsigned char using a specific format
// printf_uchar(byte register(X) uvalue, byte register(Y) format_radix)
printf_uchar: {
    // printf_uchar::@1
    // printf_buffer.sign = format.sign_always?'+':0
    // [598] *((byte*)&printf_buffer) = 0 -- _deref_pbuc1=vbuc2 
    // Handle any sign
    lda #0
    sta printf_buffer
    // uctoa(uvalue, printf_buffer.digits, format.radix)
    // [599] uctoa::value#1 = printf_uchar::uvalue#10
    // [600] uctoa::radix#0 = printf_uchar::format_radix#10
    // [601] call uctoa 
    // Format number into buffer
    jsr uctoa
    // printf_uchar::@2
    // printf_number_buffer(printf_buffer, format)
    // [602] printf_number_buffer::buffer_sign#0 = *((byte*)&printf_buffer) -- vbuaa=_deref_pbuc1 
    lda printf_buffer
    // [603] call printf_number_buffer 
  // Print using format
    // [1095] phi from printf_uchar::@2 to printf_number_buffer [phi:printf_uchar::@2->printf_number_buffer]
    jsr printf_number_buffer
    // printf_uchar::@return
    // }
    // [604] return 
    rts
}
  // memcpy_bank_to_vram
// Copy block of banked internal memory (256 banks at A000-BFFF) to VERA VRAM.
// Copies the values of num bytes from the location pointed to by source directly to the memory block pointed to by destination in VRAM.
// - vdest: absolute address in VRAM
// - src: absolute address in the banked RAM  of the CX16.
// - num: dword of the number of bytes to copy
// Note: This function can switch RAM bank during copying to copy data from multiple RAM banks.
// memcpy_bank_to_vram(dword zp($1e) vdest, dword zp($24) num)
memcpy_bank_to_vram: {
    .label __0 = $62
    .label __2 = $64
    .label __4 = $66
    .label __7 = $68
    .label __8 = $68
    .label __10 = $71
    .label __12 = $66
    .label __13 = $66
    .label __14 = $62
    .label __15 = $62
    .label __17 = $66
    .label __18 = $62
    .label __25 = $66
    .label __26 = $64
    .label beg = $28
    .label end = $24
    // select the bank
    .label addr = $62
    .label pos = $28
    .label vdest = $1e
    .label num = $24
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [606] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    // Select DATA0
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <vdest
    // [607] memcpy_bank_to_vram::$0 = < memcpy_bank_to_vram::vdest#7 -- vwuz1=_lo_vduz2 
    lda.z vdest
    sta.z __0
    lda.z vdest+1
    sta.z __0+1
    // <(<vdest)
    // [608] memcpy_bank_to_vram::$1 = < memcpy_bank_to_vram::$0 -- vbuaa=_lo_vwuz1 
    lda.z __0
    // *VERA_ADDRX_L = <(<vdest)
    // [609] *VERA_ADDRX_L = memcpy_bank_to_vram::$1 -- _deref_pbuc1=vbuaa 
    // Set address
    sta VERA_ADDRX_L
    // <vdest
    // [610] memcpy_bank_to_vram::$2 = < memcpy_bank_to_vram::vdest#7 -- vwuz1=_lo_vduz2 
    lda.z vdest
    sta.z __2
    lda.z vdest+1
    sta.z __2+1
    // >(<vdest)
    // [611] memcpy_bank_to_vram::$3 = > memcpy_bank_to_vram::$2 -- vbuaa=_hi_vwuz1 
    // *VERA_ADDRX_M = >(<vdest)
    // [612] *VERA_ADDRX_M = memcpy_bank_to_vram::$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // >vdest
    // [613] memcpy_bank_to_vram::$4 = > memcpy_bank_to_vram::vdest#7 -- vwuz1=_hi_vduz2 
    lda.z vdest+2
    sta.z __4
    lda.z vdest+3
    sta.z __4+1
    // <(>vdest)
    // [614] memcpy_bank_to_vram::$5 = < memcpy_bank_to_vram::$4 -- vbuaa=_lo_vwuz1 
    lda.z __4
    // *VERA_ADDRX_H = <(>vdest)
    // [615] *VERA_ADDRX_H = memcpy_bank_to_vram::$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_H
    // *VERA_ADDRX_H |= VERA_INC_1
    // [616] *VERA_ADDRX_H = *VERA_ADDRX_H | VERA_INC_1 -- _deref_pbuc1=_deref_pbuc1_bor_vbuc2 
    lda #VERA_INC_1
    ora VERA_ADDRX_H
    sta VERA_ADDRX_H
    // end = src+num
    // [617] memcpy_bank_to_vram::end#0 = memcpy_bank_to_vram::beg#0 + memcpy_bank_to_vram::num#7 -- vduz1=vduz2_plus_vduz1 
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
    // [618] memcpy_bank_to_vram::$7 = > memcpy_bank_to_vram::beg#0 -- vwuz1=_hi_vduz2 
    lda.z beg+2
    sta.z __7
    lda.z beg+3
    sta.z __7+1
    // (>beg)<<8
    // [619] memcpy_bank_to_vram::$8 = memcpy_bank_to_vram::$7 << 8 -- vwuz1=vwuz1_rol_8 
    lda.z __8
    sta.z __8+1
    lda #0
    sta.z __8
    // <(>beg)<<8
    // [620] memcpy_bank_to_vram::$9 = < memcpy_bank_to_vram::$8 -- vbuyy=_lo_vwuz1 
    tay
    // <beg
    // [621] memcpy_bank_to_vram::$10 = < memcpy_bank_to_vram::beg#0 -- vwuz1=_lo_vduz2 
    lda.z beg
    sta.z __10
    lda.z beg+1
    sta.z __10+1
    // >(<beg)
    // [622] memcpy_bank_to_vram::$11 = > memcpy_bank_to_vram::$10 -- vbuxx=_hi_vwuz1 
    tax
    // ((word)<(>beg)<<8)|>(<beg)
    // [623] memcpy_bank_to_vram::$25 = (word)memcpy_bank_to_vram::$9 -- vwuz1=_word_vbuyy 
    tya
    sta.z __25
    sta.z __25+1
    // [624] memcpy_bank_to_vram::$12 = memcpy_bank_to_vram::$25 | memcpy_bank_to_vram::$11 -- vwuz1=vwuz1_bor_vbuxx 
    txa
    ora.z __12
    sta.z __12
    // (((word)<(>beg)<<8)|>(<beg))>>5
    // [625] memcpy_bank_to_vram::$13 = memcpy_bank_to_vram::$12 >> 5 -- vwuz1=vwuz1_ror_5 
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
    // [626] memcpy_bank_to_vram::$14 = > memcpy_bank_to_vram::beg#0 -- vwuz1=_hi_vduz2 
    lda.z beg+2
    sta.z __14
    lda.z beg+3
    sta.z __14+1
    // (>beg)<<3
    // [627] memcpy_bank_to_vram::$15 = memcpy_bank_to_vram::$14 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z __15
    rol.z __15+1
    asl.z __15
    rol.z __15+1
    asl.z __15
    rol.z __15+1
    // <(>beg)<<3
    // [628] memcpy_bank_to_vram::$16 = < memcpy_bank_to_vram::$15 -- vbuaa=_lo_vwuz1 
    lda.z __15
    // ((((word)<(>beg)<<8)|>(<beg))>>5)+((word)<(>beg)<<3)
    // [629] memcpy_bank_to_vram::$26 = (word)memcpy_bank_to_vram::$16 -- vwuz1=_word_vbuaa 
    sta.z __26
    tya
    sta.z __26+1
    // [630] memcpy_bank_to_vram::$17 = memcpy_bank_to_vram::$13 + memcpy_bank_to_vram::$26 -- vwuz1=vwuz1_plus_vwuz2 
    lda.z __17
    clc
    adc.z __26
    sta.z __17
    lda.z __17+1
    adc.z __26+1
    sta.z __17+1
    // bank = (byte)(((((word)<(>beg)<<8)|>(<beg))>>5)+((word)<(>beg)<<3))
    // [631] memcpy_bank_to_vram::bank#0 = (byte)memcpy_bank_to_vram::$17 -- vbuxx=_byte_vwuz1 
    lda.z __17
    tax
    // <beg
    // [632] memcpy_bank_to_vram::$18 = < memcpy_bank_to_vram::beg#0 -- vwuz1=_lo_vduz2 
    lda.z beg
    sta.z __18
    lda.z beg+1
    sta.z __18+1
    // (<beg)&0x1FFF
    // [633] memcpy_bank_to_vram::addr#0 = memcpy_bank_to_vram::$18 & $1fff -- vwuz1=vwuz1_band_vwuc1 
    lda.z addr
    and #<$1fff
    sta.z addr
    lda.z addr+1
    and #>$1fff
    sta.z addr+1
    // addr += 0xA000
    // [634] memcpy_bank_to_vram::addr#1 = (byte*)memcpy_bank_to_vram::addr#0 + $a000 -- pbuz1=pbuz1_plus_vwuc1 
    // strip off the top 3 bits, which are representing the bank of the word!
    clc
    lda.z addr
    adc #<$a000
    sta.z addr
    lda.z addr+1
    adc #>$a000
    sta.z addr+1
    // cx16_ram_bank(bank)
    // [635] cx16_ram_bank::bank#3 = memcpy_bank_to_vram::bank#0 -- vbuaa=vbuxx 
    txa
    // [636] call cx16_ram_bank 
  //printf("bank = %u\n", (word)bank);
    // [994] phi from memcpy_bank_to_vram to cx16_ram_bank [phi:memcpy_bank_to_vram->cx16_ram_bank]
    // [994] phi cx16_ram_bank::bank#5 = cx16_ram_bank::bank#3 [phi:memcpy_bank_to_vram->cx16_ram_bank#0] -- register_copy 
    jsr cx16_ram_bank
    // [637] phi from memcpy_bank_to_vram memcpy_bank_to_vram::@3 to memcpy_bank_to_vram::@1 [phi:memcpy_bank_to_vram/memcpy_bank_to_vram::@3->memcpy_bank_to_vram::@1]
  __b1:
    // [637] phi memcpy_bank_to_vram::bank#2 = memcpy_bank_to_vram::bank#0 [phi:memcpy_bank_to_vram/memcpy_bank_to_vram::@3->memcpy_bank_to_vram::@1#0] -- register_copy 
    // [637] phi memcpy_bank_to_vram::addr#4 = memcpy_bank_to_vram::addr#1 [phi:memcpy_bank_to_vram/memcpy_bank_to_vram::@3->memcpy_bank_to_vram::@1#1] -- register_copy 
    // [637] phi memcpy_bank_to_vram::pos#2 = memcpy_bank_to_vram::beg#0 [phi:memcpy_bank_to_vram/memcpy_bank_to_vram::@3->memcpy_bank_to_vram::@1#2] -- register_copy 
  // select the bank
    // memcpy_bank_to_vram::@1
    // for(dword pos=beg; pos<end; pos++)
    // [638] if(memcpy_bank_to_vram::pos#2<memcpy_bank_to_vram::end#0) goto memcpy_bank_to_vram::@2 -- vduz1_lt_vduz2_then_la1 
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
    // memcpy_bank_to_vram::@return
    // }
    // [639] return 
    rts
    // memcpy_bank_to_vram::@2
  __b2:
    // if(addr == 0xC000)
    // [640] if(memcpy_bank_to_vram::addr#4!=$c000) goto memcpy_bank_to_vram::@3 -- pbuz1_neq_vwuc1_then_la1 
    lda.z addr+1
    cmp #>$c000
    bne __b3
    lda.z addr
    cmp #<$c000
    bne __b3
    // memcpy_bank_to_vram::@4
    // cx16_ram_bank(++bank);
    // [641] memcpy_bank_to_vram::bank#1 = ++ memcpy_bank_to_vram::bank#2 -- vbuxx=_inc_vbuxx 
    inx
    // cx16_ram_bank(++bank)
    // [642] cx16_ram_bank::bank#4 = memcpy_bank_to_vram::bank#1 -- vbuaa=vbuxx 
    txa
    // [643] call cx16_ram_bank 
    // [994] phi from memcpy_bank_to_vram::@4 to cx16_ram_bank [phi:memcpy_bank_to_vram::@4->cx16_ram_bank]
    // [994] phi cx16_ram_bank::bank#5 = cx16_ram_bank::bank#4 [phi:memcpy_bank_to_vram::@4->cx16_ram_bank#0] -- register_copy 
    jsr cx16_ram_bank
    // [644] phi from memcpy_bank_to_vram::@4 to memcpy_bank_to_vram::@3 [phi:memcpy_bank_to_vram::@4->memcpy_bank_to_vram::@3]
    // [644] phi memcpy_bank_to_vram::bank#5 = memcpy_bank_to_vram::bank#1 [phi:memcpy_bank_to_vram::@4->memcpy_bank_to_vram::@3#0] -- register_copy 
    // [644] phi memcpy_bank_to_vram::addr#5 = (byte*) 40960 [phi:memcpy_bank_to_vram::@4->memcpy_bank_to_vram::@3#1] -- pbuz1=pbuc1 
    lda #<$a000
    sta.z addr
    lda #>$a000
    sta.z addr+1
    // [644] phi from memcpy_bank_to_vram::@2 to memcpy_bank_to_vram::@3 [phi:memcpy_bank_to_vram::@2->memcpy_bank_to_vram::@3]
    // [644] phi memcpy_bank_to_vram::bank#5 = memcpy_bank_to_vram::bank#2 [phi:memcpy_bank_to_vram::@2->memcpy_bank_to_vram::@3#0] -- register_copy 
    // [644] phi memcpy_bank_to_vram::addr#5 = memcpy_bank_to_vram::addr#4 [phi:memcpy_bank_to_vram::@2->memcpy_bank_to_vram::@3#1] -- register_copy 
    // memcpy_bank_to_vram::@3
  __b3:
    // *VERA_DATA0 = *addr
    // [645] *VERA_DATA0 = *memcpy_bank_to_vram::addr#5 -- _deref_pbuc1=_deref_pbuz1 
    ldy #0
    lda (addr),y
    sta VERA_DATA0
    // addr++;
    // [646] memcpy_bank_to_vram::addr#2 = ++ memcpy_bank_to_vram::addr#5 -- pbuz1=_inc_pbuz1 
    inc.z addr
    bne !+
    inc.z addr+1
  !:
    // for(dword pos=beg; pos<end; pos++)
    // [647] memcpy_bank_to_vram::pos#1 = ++ memcpy_bank_to_vram::pos#2 -- vduz1=_inc_vduz1 
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
    .label __3 = $68
    .label c = $3c
    .label r = $3b
    // [649] phi from tile_background to tile_background::@1 [phi:tile_background->tile_background::@1]
    // [649] phi rem16u#19 = 0 [phi:tile_background->tile_background::@1#0] -- vwuz1=vwuc1 
    lda #<0
    sta.z rem16u
    sta.z rem16u+1
    // [649] phi rand_state#18 = 1 [phi:tile_background->tile_background::@1#1] -- vwuz1=vwuc1 
    lda #<1
    sta.z rand_state
    lda #>1
    sta.z rand_state+1
    // [649] phi tile_background::r#2 = 0 [phi:tile_background->tile_background::@1#2] -- vbuz1=vbuc1 
    sta.z r
    // tile_background::@1
  __b1:
    // for(byte r=0;r<6;r+=1)
    // [650] if(tile_background::r#2<6) goto tile_background::@2 -- vbuz1_lt_vbuc1_then_la1 
    lda.z r
    cmp #6
    bcc __b4
    // tile_background::@return
    // }
    // [651] return 
    rts
    // [652] phi from tile_background::@1 to tile_background::@2 [phi:tile_background::@1->tile_background::@2]
  __b4:
    // [652] phi rem16u#27 = rem16u#19 [phi:tile_background::@1->tile_background::@2#0] -- register_copy 
    // [652] phi rand_state#24 = rand_state#18 [phi:tile_background::@1->tile_background::@2#1] -- register_copy 
    // [652] phi tile_background::c#2 = 0 [phi:tile_background::@1->tile_background::@2#2] -- vbuz1=vbuc1 
    lda #0
    sta.z c
    // tile_background::@2
  __b2:
    // for(byte c=0;c<5;c+=1)
    // [653] if(tile_background::c#2<5) goto tile_background::@3 -- vbuz1_lt_vbuc1_then_la1 
    lda.z c
    cmp #5
    bcc __b3
    // tile_background::@4
    // r+=1
    // [654] tile_background::r#1 = tile_background::r#2 + 1 -- vbuz1=vbuz1_plus_1 
    inc.z r
    // [649] phi from tile_background::@4 to tile_background::@1 [phi:tile_background::@4->tile_background::@1]
    // [649] phi rem16u#19 = rem16u#27 [phi:tile_background::@4->tile_background::@1#0] -- register_copy 
    // [649] phi rand_state#18 = rand_state#24 [phi:tile_background::@4->tile_background::@1#1] -- register_copy 
    // [649] phi tile_background::r#2 = tile_background::r#1 [phi:tile_background::@4->tile_background::@1#2] -- register_copy 
    jmp __b1
    // [655] phi from tile_background::@2 to tile_background::@3 [phi:tile_background::@2->tile_background::@3]
    // tile_background::@3
  __b3:
    // rand()
    // [656] call rand 
    // [284] phi from tile_background::@3 to rand [phi:tile_background::@3->rand]
    // [284] phi rand_state#13 = rand_state#24 [phi:tile_background::@3->rand#0] -- register_copy 
    jsr rand
    // rand()
    // [657] rand::return#3 = rand::return#0
    // tile_background::@5
    // modr16u(rand(),3,0)
    // [658] modr16u::dividend#1 = rand::return#3
    // [659] call modr16u 
    // [293] phi from tile_background::@5 to modr16u [phi:tile_background::@5->modr16u]
    // [293] phi modr16u::dividend#2 = modr16u::dividend#1 [phi:tile_background::@5->modr16u#0] -- register_copy 
    jsr modr16u
    // modr16u(rand(),3,0)
    // [660] modr16u::return#3 = modr16u::return#0
    // tile_background::@6
    // [661] tile_background::$3 = modr16u::return#3 -- vwuz1=vwuz2 
    lda.z modr16u.return
    sta.z __3
    lda.z modr16u.return+1
    sta.z __3+1
    // rnd = (byte)modr16u(rand(),3,0)
    // [662] tile_background::rnd#0 = (byte)tile_background::$3 -- vbuaa=_byte_vwuz1 
    lda.z __3
    // vera_tile_element( 0, c, r, 3, TileDB[rnd])
    // [663] tile_background::$5 = tile_background::rnd#0 << 1 -- vbuxx=vbuaa_rol_1 
    asl
    tax
    // [664] vera_tile_element::x#2 = tile_background::c#2 -- vbuz1=vbuz2 
    lda.z c
    sta.z vera_tile_element.x
    // [665] vera_tile_element::y#2 = tile_background::r#2 -- vbuz1=vbuz2 
    lda.z r
    sta.z vera_tile_element.y
    // [666] vera_tile_element::Tile#1 = TileDB[tile_background::$5] -- pbuz1=qbuc1_derefidx_vbuxx 
    lda TileDB,x
    sta.z vera_tile_element.Tile
    lda TileDB+1,x
    sta.z vera_tile_element.Tile+1
    // [667] call vera_tile_element 
    // [298] phi from tile_background::@6 to vera_tile_element [phi:tile_background::@6->vera_tile_element]
    // [298] phi vera_tile_element::y#3 = vera_tile_element::y#2 [phi:tile_background::@6->vera_tile_element#0] -- register_copy 
    // [298] phi vera_tile_element::x#3 = vera_tile_element::x#2 [phi:tile_background::@6->vera_tile_element#1] -- register_copy 
    // [298] phi vera_tile_element::Tile#2 = vera_tile_element::Tile#1 [phi:tile_background::@6->vera_tile_element#2] -- register_copy 
    jsr vera_tile_element
    // tile_background::@7
    // c+=1
    // [668] tile_background::c#1 = tile_background::c#2 + 1 -- vbuz1=vbuz1_plus_1 
    inc.z c
    // [652] phi from tile_background::@7 to tile_background::@2 [phi:tile_background::@7->tile_background::@2]
    // [652] phi rem16u#27 = divr16u::rem#10 [phi:tile_background::@7->tile_background::@2#0] -- register_copy 
    // [652] phi rand_state#24 = rand_state#14 [phi:tile_background::@7->tile_background::@2#1] -- register_copy 
    // [652] phi tile_background::c#2 = tile_background::c#1 [phi:tile_background::@7->tile_background::@2#2] -- register_copy 
    jmp __b2
}
  // create_sprites_player
create_sprites_player: {
    .const vera_sprite_palette_offset1_palette_offset = 1
    .label __4 = $64
    .label __7 = $66
    .label __17 = $64
    .label __18 = $66
    .label vera_sprite_4bpp1___4 = $71
    .label vera_sprite_4bpp1___7 = $71
    .label vera_sprite_address1___0 = $66
    .label vera_sprite_address1___4 = $62
    .label vera_sprite_address1___5 = $62
    .label vera_sprite_address1___7 = $64
    .label vera_sprite_address1___9 = $61
    .label vera_sprite_address1___10 = $62
    .label vera_sprite_address1___14 = $66
    .label vera_sprite_xy1___4 = $62
    .label vera_sprite_xy1___10 = $62
    .label vera_sprite_height_321___4 = $62
    .label vera_sprite_height_321___8 = $62
    .label vera_sprite_width_321___4 = $66
    .label vera_sprite_width_321___8 = $66
    .label vera_sprite_zdepth_in_front1___4 = $62
    .label vera_sprite_zdepth_in_front1___8 = $62
    .label vera_sprite_VFlip_off1___4 = $64
    .label vera_sprite_VFlip_off1___7 = $64
    .label vera_sprite_HFlip_off1___4 = $68
    .label vera_sprite_HFlip_off1___7 = $68
    .label vera_sprite_palette_offset1___4 = $62
    .label vera_sprite_palette_offset1___8 = $62
    .label vera_sprite_4bpp1_sprite_offset = $71
    .label vera_sprite_address1_sprite_offset = $66
    .label vera_sprite_xy1_x = $64
    .label vera_sprite_xy1_y = $66
    .label vera_sprite_xy1_sprite_offset = $62
    .label vera_sprite_height_321_sprite_offset = $62
    .label vera_sprite_width_321_sprite_offset = $66
    .label vera_sprite_zdepth_in_front1_sprite_offset = $62
    .label vera_sprite_VFlip_off1_sprite_offset = $64
    .label vera_sprite_HFlip_off1_sprite_offset = $68
    .label vera_sprite_palette_offset1_sprite_offset = $62
    // Copy sprite palette to VRAM
    // Copy 8* sprite attributes to VRAM    
    .label player_sprite_address = $24
    // [670] phi from create_sprites_player to create_sprites_player::@1 [phi:create_sprites_player->create_sprites_player::@1]
    // [670] phi create_sprites_player::player_sprite_address#10 = VRAM_PLAYER [phi:create_sprites_player->create_sprites_player::@1#0] -- vduz1=vduc1 
    lda #<VRAM_PLAYER
    sta.z player_sprite_address
    lda #>VRAM_PLAYER
    sta.z player_sprite_address+1
    lda #<VRAM_PLAYER>>$10
    sta.z player_sprite_address+2
    lda #>VRAM_PLAYER>>$10
    sta.z player_sprite_address+3
    // [670] phi create_sprites_player::s#10 = 0 [phi:create_sprites_player->create_sprites_player::@1#1] -- vbuxx=vbuc1 
    ldx #0
    // create_sprites_player::@1
  __b1:
    // for(byte s=0;s<NUM_PLAYER;s++)
    // [671] if(create_sprites_player::s#10<NUM_PLAYER) goto create_sprites_player::vera_sprite_4bpp1 -- vbuxx_lt_vbuc1_then_la1 
    cpx #NUM_PLAYER
    bcc vera_sprite_4bpp1
    // create_sprites_player::@return
    // }
    // [672] return 
    rts
    // create_sprites_player::vera_sprite_4bpp1
  vera_sprite_4bpp1:
    // (word)sprite << 3
    // [673] create_sprites_player::vera_sprite_4bpp1_$7 = (word)create_sprites_player::s#10 -- vwuz1=_word_vbuxx 
    txa
    sta.z vera_sprite_4bpp1___7
    lda #0
    sta.z vera_sprite_4bpp1___7+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [674] create_sprites_player::vera_sprite_4bpp1_sprite_offset#0 = create_sprites_player::vera_sprite_4bpp1_$7 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_4bpp1_sprite_offset
    rol.z vera_sprite_4bpp1_sprite_offset+1
    asl.z vera_sprite_4bpp1_sprite_offset
    rol.z vera_sprite_4bpp1_sprite_offset+1
    asl.z vera_sprite_4bpp1_sprite_offset
    rol.z vera_sprite_4bpp1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [675] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+1
    // [676] create_sprites_player::vera_sprite_4bpp1_$4 = create_sprites_player::vera_sprite_4bpp1_sprite_offset#0 + <VERA_SPRITE_ATTR+1 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_4bpp1___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+1
    sta.z vera_sprite_4bpp1___4
    lda.z vera_sprite_4bpp1___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+1
    sta.z vera_sprite_4bpp1___4+1
    // <sprite_offset+1
    // [677] create_sprites_player::vera_sprite_4bpp1_$3 = < create_sprites_player::vera_sprite_4bpp1_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_4bpp1___4
    // *VERA_ADDRX_L = <sprite_offset+1
    // [678] *VERA_ADDRX_L = create_sprites_player::vera_sprite_4bpp1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+1
    // [679] create_sprites_player::vera_sprite_4bpp1_$5 = > create_sprites_player::vera_sprite_4bpp1_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_4bpp1___4+1
    // *VERA_ADDRX_M = >sprite_offset+1
    // [680] *VERA_ADDRX_M = create_sprites_player::vera_sprite_4bpp1_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [681] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~>VERA_SPRITE_8BPP
    // [682] create_sprites_player::vera_sprite_4bpp1_$6 = *VERA_DATA0 & ~>VERA_SPRITE_8BPP -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #(>VERA_SPRITE_8BPP)^$ff
    and VERA_DATA0
    // *VERA_DATA0 = *VERA_DATA0 & ~>VERA_SPRITE_8BPP
    // [683] *VERA_DATA0 = create_sprites_player::vera_sprite_4bpp1_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_player::@2
    // PlayerSprites[s] = player_sprite_address
    // [684] create_sprites_player::$16 = create_sprites_player::s#10 << 2 -- vbuaa=vbuxx_rol_2 
    txa
    asl
    asl
    // [685] PlayerSprites[create_sprites_player::$16] = create_sprites_player::player_sprite_address#10 -- pduc1_derefidx_vbuaa=vduz1 
    tay
    lda.z player_sprite_address
    sta PlayerSprites,y
    lda.z player_sprite_address+1
    sta PlayerSprites+1,y
    lda.z player_sprite_address+2
    sta PlayerSprites+2,y
    lda.z player_sprite_address+3
    sta PlayerSprites+3,y
    // create_sprites_player::vera_sprite_address1
    // (word)sprite << 3
    // [686] create_sprites_player::vera_sprite_address1_$14 = (word)create_sprites_player::s#10 -- vwuz1=_word_vbuxx 
    txa
    sta.z vera_sprite_address1___14
    lda #0
    sta.z vera_sprite_address1___14+1
    // [687] create_sprites_player::vera_sprite_address1_$0 = create_sprites_player::vera_sprite_address1_$14 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_address1___0
    rol.z vera_sprite_address1___0+1
    asl.z vera_sprite_address1___0
    rol.z vera_sprite_address1___0+1
    asl.z vera_sprite_address1___0
    rol.z vera_sprite_address1___0+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [688] create_sprites_player::vera_sprite_address1_sprite_offset#0 = <VERA_SPRITE_ATTR + create_sprites_player::vera_sprite_address1_$0 -- vwuz1=vwuc1_plus_vwuz1 
    clc
    lda.z vera_sprite_address1_sprite_offset
    adc #<VERA_SPRITE_ATTR&$ffff
    sta.z vera_sprite_address1_sprite_offset
    lda.z vera_sprite_address1_sprite_offset+1
    adc #>VERA_SPRITE_ATTR&$ffff
    sta.z vera_sprite_address1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [689] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <sprite_offset
    // [690] create_sprites_player::vera_sprite_address1_$2 = < create_sprites_player::vera_sprite_address1_sprite_offset#0 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_address1_sprite_offset
    // *VERA_ADDRX_L = <sprite_offset
    // [691] *VERA_ADDRX_L = create_sprites_player::vera_sprite_address1_$2 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset
    // [692] create_sprites_player::vera_sprite_address1_$3 = > create_sprites_player::vera_sprite_address1_sprite_offset#0 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_address1_sprite_offset+1
    // *VERA_ADDRX_M = >sprite_offset
    // [693] *VERA_ADDRX_M = create_sprites_player::vera_sprite_address1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_1 | <(>VERA_SPRITE_ATTR)
    // [694] *VERA_ADDRX_H = VERA_INC_1|<>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #VERA_INC_1|(<(VERA_SPRITE_ATTR>>$10))
    sta VERA_ADDRX_H
    // <address
    // [695] create_sprites_player::vera_sprite_address1_$4 = < create_sprites_player::player_sprite_address#10 -- vwuz1=_lo_vduz2 
    lda.z player_sprite_address
    sta.z vera_sprite_address1___4
    lda.z player_sprite_address+1
    sta.z vera_sprite_address1___4+1
    // (<address)>>5
    // [696] create_sprites_player::vera_sprite_address1_$5 = create_sprites_player::vera_sprite_address1_$4 >> 5 -- vwuz1=vwuz1_ror_5 
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    // <((<address)>>5)
    // [697] create_sprites_player::vera_sprite_address1_$6 = < create_sprites_player::vera_sprite_address1_$5 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_address1___5
    // *VERA_DATA0 = <((<address)>>5)
    // [698] *VERA_DATA0 = create_sprites_player::vera_sprite_address1_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // <address
    // [699] create_sprites_player::vera_sprite_address1_$7 = < create_sprites_player::player_sprite_address#10 -- vwuz1=_lo_vduz2 
    lda.z player_sprite_address
    sta.z vera_sprite_address1___7
    lda.z player_sprite_address+1
    sta.z vera_sprite_address1___7+1
    // >(<address)
    // [700] create_sprites_player::vera_sprite_address1_$8 = > create_sprites_player::vera_sprite_address1_$7 -- vbuaa=_hi_vwuz1 
    // (>(<address))>>5
    // [701] create_sprites_player::vera_sprite_address1_$9 = create_sprites_player::vera_sprite_address1_$8 >> 5 -- vbuz1=vbuaa_ror_5 
    lsr
    lsr
    lsr
    lsr
    lsr
    sta.z vera_sprite_address1___9
    // >address
    // [702] create_sprites_player::vera_sprite_address1_$10 = > create_sprites_player::player_sprite_address#10 -- vwuz1=_hi_vduz2 
    lda.z player_sprite_address+2
    sta.z vera_sprite_address1___10
    lda.z player_sprite_address+3
    sta.z vera_sprite_address1___10+1
    // <(>address)
    // [703] create_sprites_player::vera_sprite_address1_$11 = < create_sprites_player::vera_sprite_address1_$10 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_address1___10
    // (<(>address))<<3
    // [704] create_sprites_player::vera_sprite_address1_$12 = create_sprites_player::vera_sprite_address1_$11 << 3 -- vbuaa=vbuaa_rol_3 
    asl
    asl
    asl
    // ((>(<address))>>5)|((<(>address))<<3)
    // [705] create_sprites_player::vera_sprite_address1_$13 = create_sprites_player::vera_sprite_address1_$9 | create_sprites_player::vera_sprite_address1_$12 -- vbuaa=vbuz1_bor_vbuaa 
    ora.z vera_sprite_address1___9
    // *VERA_DATA0 = ((>(<address))>>5)|((<(>address))<<3)
    // [706] *VERA_DATA0 = create_sprites_player::vera_sprite_address1_$13 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_player::@3
    // s&03
    // [707] create_sprites_player::$3 = create_sprites_player::s#10 & 3 -- vbuaa=vbuxx_band_vbuc1 
    txa
    and #3
    // (word)(s&03)<<6
    // [708] create_sprites_player::$17 = (word)create_sprites_player::$3 -- vwuz1=_word_vbuaa 
    sta.z __17
    lda #0
    sta.z __17+1
    // [709] create_sprites_player::$4 = create_sprites_player::$17 << 6 -- vwuz1=vwuz1_rol_6 
    lda.z __4+1
    lsr
    sta.z $ff
    lda.z __4
    ror
    sta.z __4+1
    lda #0
    ror
    sta.z __4
    lsr.z $ff
    ror.z __4+1
    ror.z __4
    // vera_sprite_xy(s, 40+((word)(s&03)<<6), 100+((word)(s>>2)<<6))
    // [710] create_sprites_player::vera_sprite_xy1_x#0 = $28 + create_sprites_player::$4 -- vwuz1=vbuc1_plus_vwuz1 
    lda #$28
    clc
    adc.z vera_sprite_xy1_x
    sta.z vera_sprite_xy1_x
    bcc !+
    inc.z vera_sprite_xy1_x+1
  !:
    // s>>2
    // [711] create_sprites_player::$6 = create_sprites_player::s#10 >> 2 -- vbuaa=vbuxx_ror_2 
    txa
    lsr
    lsr
    // (word)(s>>2)<<6
    // [712] create_sprites_player::$18 = (word)create_sprites_player::$6 -- vwuz1=_word_vbuaa 
    sta.z __18
    lda #0
    sta.z __18+1
    // [713] create_sprites_player::$7 = create_sprites_player::$18 << 6 -- vwuz1=vwuz1_rol_6 
    lda.z __7+1
    lsr
    sta.z $ff
    lda.z __7
    ror
    sta.z __7+1
    lda #0
    ror
    sta.z __7
    lsr.z $ff
    ror.z __7+1
    ror.z __7
    // vera_sprite_xy(s, 40+((word)(s&03)<<6), 100+((word)(s>>2)<<6))
    // [714] create_sprites_player::vera_sprite_xy1_y#0 = $64 + create_sprites_player::$7 -- vwuz1=vbuc1_plus_vwuz1 
    lda #$64
    clc
    adc.z vera_sprite_xy1_y
    sta.z vera_sprite_xy1_y
    bcc !+
    inc.z vera_sprite_xy1_y+1
  !:
    // create_sprites_player::vera_sprite_xy1
    // (word)sprite << 3
    // [715] create_sprites_player::vera_sprite_xy1_$10 = (word)create_sprites_player::s#10 -- vwuz1=_word_vbuxx 
    txa
    sta.z vera_sprite_xy1___10
    lda #0
    sta.z vera_sprite_xy1___10+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [716] create_sprites_player::vera_sprite_xy1_sprite_offset#0 = create_sprites_player::vera_sprite_xy1_$10 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_xy1_sprite_offset
    rol.z vera_sprite_xy1_sprite_offset+1
    asl.z vera_sprite_xy1_sprite_offset
    rol.z vera_sprite_xy1_sprite_offset+1
    asl.z vera_sprite_xy1_sprite_offset
    rol.z vera_sprite_xy1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [717] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+2
    // [718] create_sprites_player::vera_sprite_xy1_$4 = create_sprites_player::vera_sprite_xy1_sprite_offset#0 + <VERA_SPRITE_ATTR+2 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_xy1___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+2
    sta.z vera_sprite_xy1___4
    lda.z vera_sprite_xy1___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+2
    sta.z vera_sprite_xy1___4+1
    // <sprite_offset+2
    // [719] create_sprites_player::vera_sprite_xy1_$3 = < create_sprites_player::vera_sprite_xy1_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_xy1___4
    // *VERA_ADDRX_L = <sprite_offset+2
    // [720] *VERA_ADDRX_L = create_sprites_player::vera_sprite_xy1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+2
    // [721] create_sprites_player::vera_sprite_xy1_$5 = > create_sprites_player::vera_sprite_xy1_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_xy1___4+1
    // *VERA_ADDRX_M = >sprite_offset+2
    // [722] *VERA_ADDRX_M = create_sprites_player::vera_sprite_xy1_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_1 | <(>VERA_SPRITE_ATTR)
    // [723] *VERA_ADDRX_H = VERA_INC_1|<>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #VERA_INC_1|(<(VERA_SPRITE_ATTR>>$10))
    sta VERA_ADDRX_H
    // <x
    // [724] create_sprites_player::vera_sprite_xy1_$6 = < create_sprites_player::vera_sprite_xy1_x#0 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_xy1_x
    // *VERA_DATA0 = <x
    // [725] *VERA_DATA0 = create_sprites_player::vera_sprite_xy1_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // >x
    // [726] create_sprites_player::vera_sprite_xy1_$7 = > create_sprites_player::vera_sprite_xy1_x#0 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_xy1_x+1
    // *VERA_DATA0 = >x
    // [727] *VERA_DATA0 = create_sprites_player::vera_sprite_xy1_$7 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // <y
    // [728] create_sprites_player::vera_sprite_xy1_$8 = < create_sprites_player::vera_sprite_xy1_y#0 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_xy1_y
    // *VERA_DATA0 = <y
    // [729] *VERA_DATA0 = create_sprites_player::vera_sprite_xy1_$8 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // >y
    // [730] create_sprites_player::vera_sprite_xy1_$9 = > create_sprites_player::vera_sprite_xy1_y#0 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_xy1_y+1
    // *VERA_DATA0 = >y
    // [731] *VERA_DATA0 = create_sprites_player::vera_sprite_xy1_$9 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_player::vera_sprite_height_321
    // (word)sprite << 3
    // [732] create_sprites_player::vera_sprite_height_321_$8 = (word)create_sprites_player::s#10 -- vwuz1=_word_vbuxx 
    txa
    sta.z vera_sprite_height_321___8
    lda #0
    sta.z vera_sprite_height_321___8+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [733] create_sprites_player::vera_sprite_height_321_sprite_offset#0 = create_sprites_player::vera_sprite_height_321_$8 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_height_321_sprite_offset
    rol.z vera_sprite_height_321_sprite_offset+1
    asl.z vera_sprite_height_321_sprite_offset
    rol.z vera_sprite_height_321_sprite_offset+1
    asl.z vera_sprite_height_321_sprite_offset
    rol.z vera_sprite_height_321_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [734] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+7
    // [735] create_sprites_player::vera_sprite_height_321_$4 = create_sprites_player::vera_sprite_height_321_sprite_offset#0 + <VERA_SPRITE_ATTR+7 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_height_321___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+7
    sta.z vera_sprite_height_321___4
    lda.z vera_sprite_height_321___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+7
    sta.z vera_sprite_height_321___4+1
    // <sprite_offset+7
    // [736] create_sprites_player::vera_sprite_height_321_$3 = < create_sprites_player::vera_sprite_height_321_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_height_321___4
    // *VERA_ADDRX_L = <sprite_offset+7
    // [737] *VERA_ADDRX_L = create_sprites_player::vera_sprite_height_321_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+7
    // [738] create_sprites_player::vera_sprite_height_321_$5 = > create_sprites_player::vera_sprite_height_321_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_height_321___4+1
    // *VERA_ADDRX_M = >sprite_offset+7
    // [739] *VERA_ADDRX_M = create_sprites_player::vera_sprite_height_321_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [740] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~VERA_SPRITE_HEIGHT_MASK
    // [741] create_sprites_player::vera_sprite_height_321_$6 = *VERA_DATA0 & ~VERA_SPRITE_HEIGHT_MASK -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #VERA_SPRITE_HEIGHT_MASK^$ff
    and VERA_DATA0
    // *VERA_DATA0 & ~VERA_SPRITE_HEIGHT_MASK | VERA_SPRITE_HEIGHT_32
    // [742] create_sprites_player::vera_sprite_height_321_$7 = create_sprites_player::vera_sprite_height_321_$6 | VERA_SPRITE_HEIGHT_32 -- vbuaa=vbuaa_bor_vbuc1 
    ora #VERA_SPRITE_HEIGHT_32
    // *VERA_DATA0 = *VERA_DATA0 & ~VERA_SPRITE_HEIGHT_MASK | VERA_SPRITE_HEIGHT_32
    // [743] *VERA_DATA0 = create_sprites_player::vera_sprite_height_321_$7 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_player::vera_sprite_width_321
    // (word)sprite << 3
    // [744] create_sprites_player::vera_sprite_width_321_$8 = (word)create_sprites_player::s#10 -- vwuz1=_word_vbuxx 
    txa
    sta.z vera_sprite_width_321___8
    lda #0
    sta.z vera_sprite_width_321___8+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [745] create_sprites_player::vera_sprite_width_321_sprite_offset#0 = create_sprites_player::vera_sprite_width_321_$8 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_width_321_sprite_offset
    rol.z vera_sprite_width_321_sprite_offset+1
    asl.z vera_sprite_width_321_sprite_offset
    rol.z vera_sprite_width_321_sprite_offset+1
    asl.z vera_sprite_width_321_sprite_offset
    rol.z vera_sprite_width_321_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [746] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+7
    // [747] create_sprites_player::vera_sprite_width_321_$4 = create_sprites_player::vera_sprite_width_321_sprite_offset#0 + <VERA_SPRITE_ATTR+7 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_width_321___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+7
    sta.z vera_sprite_width_321___4
    lda.z vera_sprite_width_321___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+7
    sta.z vera_sprite_width_321___4+1
    // <sprite_offset+7
    // [748] create_sprites_player::vera_sprite_width_321_$3 = < create_sprites_player::vera_sprite_width_321_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_width_321___4
    // *VERA_ADDRX_L = <sprite_offset+7
    // [749] *VERA_ADDRX_L = create_sprites_player::vera_sprite_width_321_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+7
    // [750] create_sprites_player::vera_sprite_width_321_$5 = > create_sprites_player::vera_sprite_width_321_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_width_321___4+1
    // *VERA_ADDRX_M = >sprite_offset+7
    // [751] *VERA_ADDRX_M = create_sprites_player::vera_sprite_width_321_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [752] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~VERA_SPRITE_WIDTH_MASK
    // [753] create_sprites_player::vera_sprite_width_321_$6 = *VERA_DATA0 & ~VERA_SPRITE_WIDTH_MASK -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #VERA_SPRITE_WIDTH_MASK^$ff
    and VERA_DATA0
    // *VERA_DATA0 & ~VERA_SPRITE_WIDTH_MASK | VERA_SPRITE_WIDTH_32
    // [754] create_sprites_player::vera_sprite_width_321_$7 = create_sprites_player::vera_sprite_width_321_$6 | VERA_SPRITE_WIDTH_32 -- vbuaa=vbuaa_bor_vbuc1 
    ora #VERA_SPRITE_WIDTH_32
    // *VERA_DATA0 = *VERA_DATA0 & ~VERA_SPRITE_WIDTH_MASK | VERA_SPRITE_WIDTH_32
    // [755] *VERA_DATA0 = create_sprites_player::vera_sprite_width_321_$7 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_player::vera_sprite_zdepth_in_front1
    // (word)sprite << 3
    // [756] create_sprites_player::vera_sprite_zdepth_in_front1_$8 = (word)create_sprites_player::s#10 -- vwuz1=_word_vbuxx 
    txa
    sta.z vera_sprite_zdepth_in_front1___8
    lda #0
    sta.z vera_sprite_zdepth_in_front1___8+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [757] create_sprites_player::vera_sprite_zdepth_in_front1_sprite_offset#0 = create_sprites_player::vera_sprite_zdepth_in_front1_$8 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_zdepth_in_front1_sprite_offset
    rol.z vera_sprite_zdepth_in_front1_sprite_offset+1
    asl.z vera_sprite_zdepth_in_front1_sprite_offset
    rol.z vera_sprite_zdepth_in_front1_sprite_offset+1
    asl.z vera_sprite_zdepth_in_front1_sprite_offset
    rol.z vera_sprite_zdepth_in_front1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [758] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+6
    // [759] create_sprites_player::vera_sprite_zdepth_in_front1_$4 = create_sprites_player::vera_sprite_zdepth_in_front1_sprite_offset#0 + <VERA_SPRITE_ATTR+6 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_zdepth_in_front1___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+6
    sta.z vera_sprite_zdepth_in_front1___4
    lda.z vera_sprite_zdepth_in_front1___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+6
    sta.z vera_sprite_zdepth_in_front1___4+1
    // <sprite_offset+6
    // [760] create_sprites_player::vera_sprite_zdepth_in_front1_$3 = < create_sprites_player::vera_sprite_zdepth_in_front1_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_zdepth_in_front1___4
    // *VERA_ADDRX_L = <sprite_offset+6
    // [761] *VERA_ADDRX_L = create_sprites_player::vera_sprite_zdepth_in_front1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+6
    // [762] create_sprites_player::vera_sprite_zdepth_in_front1_$5 = > create_sprites_player::vera_sprite_zdepth_in_front1_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_zdepth_in_front1___4+1
    // *VERA_ADDRX_M = >sprite_offset+6
    // [763] *VERA_ADDRX_M = create_sprites_player::vera_sprite_zdepth_in_front1_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [764] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~VERA_SPRITE_ZDEPTH_MASK
    // [765] create_sprites_player::vera_sprite_zdepth_in_front1_$6 = *VERA_DATA0 & ~VERA_SPRITE_ZDEPTH_MASK -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #VERA_SPRITE_ZDEPTH_MASK^$ff
    and VERA_DATA0
    // *VERA_DATA0 & ~VERA_SPRITE_ZDEPTH_MASK | VERA_SPRITE_ZDEPTH_IN_FRONT
    // [766] create_sprites_player::vera_sprite_zdepth_in_front1_$7 = create_sprites_player::vera_sprite_zdepth_in_front1_$6 | VERA_SPRITE_ZDEPTH_IN_FRONT -- vbuaa=vbuaa_bor_vbuc1 
    ora #VERA_SPRITE_ZDEPTH_IN_FRONT
    // *VERA_DATA0 = *VERA_DATA0 & ~VERA_SPRITE_ZDEPTH_MASK | VERA_SPRITE_ZDEPTH_IN_FRONT
    // [767] *VERA_DATA0 = create_sprites_player::vera_sprite_zdepth_in_front1_$7 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_player::vera_sprite_VFlip_off1
    // (word)sprite << 3
    // [768] create_sprites_player::vera_sprite_VFlip_off1_$7 = (word)create_sprites_player::s#10 -- vwuz1=_word_vbuxx 
    txa
    sta.z vera_sprite_VFlip_off1___7
    lda #0
    sta.z vera_sprite_VFlip_off1___7+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [769] create_sprites_player::vera_sprite_VFlip_off1_sprite_offset#0 = create_sprites_player::vera_sprite_VFlip_off1_$7 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_VFlip_off1_sprite_offset
    rol.z vera_sprite_VFlip_off1_sprite_offset+1
    asl.z vera_sprite_VFlip_off1_sprite_offset
    rol.z vera_sprite_VFlip_off1_sprite_offset+1
    asl.z vera_sprite_VFlip_off1_sprite_offset
    rol.z vera_sprite_VFlip_off1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [770] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+6
    // [771] create_sprites_player::vera_sprite_VFlip_off1_$4 = create_sprites_player::vera_sprite_VFlip_off1_sprite_offset#0 + <VERA_SPRITE_ATTR+6 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_VFlip_off1___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+6
    sta.z vera_sprite_VFlip_off1___4
    lda.z vera_sprite_VFlip_off1___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+6
    sta.z vera_sprite_VFlip_off1___4+1
    // <sprite_offset+6
    // [772] create_sprites_player::vera_sprite_VFlip_off1_$3 = < create_sprites_player::vera_sprite_VFlip_off1_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_VFlip_off1___4
    // *VERA_ADDRX_L = <sprite_offset+6
    // [773] *VERA_ADDRX_L = create_sprites_player::vera_sprite_VFlip_off1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+6
    // [774] create_sprites_player::vera_sprite_VFlip_off1_$5 = > create_sprites_player::vera_sprite_VFlip_off1_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_VFlip_off1___4+1
    // *VERA_ADDRX_M = >sprite_offset+6
    // [775] *VERA_ADDRX_M = create_sprites_player::vera_sprite_VFlip_off1_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [776] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~VERA_SPRITE_VFLIP
    // [777] create_sprites_player::vera_sprite_VFlip_off1_$6 = *VERA_DATA0 & ~VERA_SPRITE_VFLIP -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #VERA_SPRITE_VFLIP^$ff
    and VERA_DATA0
    // *VERA_DATA0 = *VERA_DATA0 & ~VERA_SPRITE_VFLIP
    // [778] *VERA_DATA0 = create_sprites_player::vera_sprite_VFlip_off1_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_player::vera_sprite_HFlip_off1
    // (word)sprite << 3
    // [779] create_sprites_player::vera_sprite_HFlip_off1_$7 = (word)create_sprites_player::s#10 -- vwuz1=_word_vbuxx 
    txa
    sta.z vera_sprite_HFlip_off1___7
    lda #0
    sta.z vera_sprite_HFlip_off1___7+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [780] create_sprites_player::vera_sprite_HFlip_off1_sprite_offset#0 = create_sprites_player::vera_sprite_HFlip_off1_$7 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_HFlip_off1_sprite_offset
    rol.z vera_sprite_HFlip_off1_sprite_offset+1
    asl.z vera_sprite_HFlip_off1_sprite_offset
    rol.z vera_sprite_HFlip_off1_sprite_offset+1
    asl.z vera_sprite_HFlip_off1_sprite_offset
    rol.z vera_sprite_HFlip_off1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [781] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+6
    // [782] create_sprites_player::vera_sprite_HFlip_off1_$4 = create_sprites_player::vera_sprite_HFlip_off1_sprite_offset#0 + <VERA_SPRITE_ATTR+6 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_HFlip_off1___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+6
    sta.z vera_sprite_HFlip_off1___4
    lda.z vera_sprite_HFlip_off1___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+6
    sta.z vera_sprite_HFlip_off1___4+1
    // <sprite_offset+6
    // [783] create_sprites_player::vera_sprite_HFlip_off1_$3 = < create_sprites_player::vera_sprite_HFlip_off1_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_HFlip_off1___4
    // *VERA_ADDRX_L = <sprite_offset+6
    // [784] *VERA_ADDRX_L = create_sprites_player::vera_sprite_HFlip_off1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+6
    // [785] create_sprites_player::vera_sprite_HFlip_off1_$5 = > create_sprites_player::vera_sprite_HFlip_off1_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_HFlip_off1___4+1
    // *VERA_ADDRX_M = >sprite_offset+6
    // [786] *VERA_ADDRX_M = create_sprites_player::vera_sprite_HFlip_off1_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [787] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~VERA_SPRITE_HFLIP
    // [788] create_sprites_player::vera_sprite_HFlip_off1_$6 = *VERA_DATA0 & ~VERA_SPRITE_HFLIP -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #VERA_SPRITE_HFLIP^$ff
    and VERA_DATA0
    // *VERA_DATA0 = *VERA_DATA0 & ~VERA_SPRITE_HFLIP
    // [789] *VERA_DATA0 = create_sprites_player::vera_sprite_HFlip_off1_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_player::vera_sprite_palette_offset1
    // (word)sprite << 3
    // [790] create_sprites_player::vera_sprite_palette_offset1_$8 = (word)create_sprites_player::s#10 -- vwuz1=_word_vbuxx 
    txa
    sta.z vera_sprite_palette_offset1___8
    lda #0
    sta.z vera_sprite_palette_offset1___8+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [791] create_sprites_player::vera_sprite_palette_offset1_sprite_offset#0 = create_sprites_player::vera_sprite_palette_offset1_$8 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_palette_offset1_sprite_offset
    rol.z vera_sprite_palette_offset1_sprite_offset+1
    asl.z vera_sprite_palette_offset1_sprite_offset
    rol.z vera_sprite_palette_offset1_sprite_offset+1
    asl.z vera_sprite_palette_offset1_sprite_offset
    rol.z vera_sprite_palette_offset1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [792] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+7
    // [793] create_sprites_player::vera_sprite_palette_offset1_$4 = create_sprites_player::vera_sprite_palette_offset1_sprite_offset#0 + <VERA_SPRITE_ATTR+7 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_palette_offset1___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+7
    sta.z vera_sprite_palette_offset1___4
    lda.z vera_sprite_palette_offset1___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+7
    sta.z vera_sprite_palette_offset1___4+1
    // <sprite_offset+7
    // [794] create_sprites_player::vera_sprite_palette_offset1_$3 = < create_sprites_player::vera_sprite_palette_offset1_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_palette_offset1___4
    // *VERA_ADDRX_L = <sprite_offset+7
    // [795] *VERA_ADDRX_L = create_sprites_player::vera_sprite_palette_offset1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+7
    // [796] create_sprites_player::vera_sprite_palette_offset1_$5 = > create_sprites_player::vera_sprite_palette_offset1_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_palette_offset1___4+1
    // *VERA_ADDRX_M = >sprite_offset+7
    // [797] *VERA_ADDRX_M = create_sprites_player::vera_sprite_palette_offset1_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [798] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~VERA_SPRITE_PALETTE_OFFSET_MASK
    // [799] create_sprites_player::vera_sprite_palette_offset1_$6 = *VERA_DATA0 & ~VERA_SPRITE_PALETTE_OFFSET_MASK -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #VERA_SPRITE_PALETTE_OFFSET_MASK^$ff
    and VERA_DATA0
    // *VERA_DATA0 & ~VERA_SPRITE_PALETTE_OFFSET_MASK | palette_offset
    // [800] create_sprites_player::vera_sprite_palette_offset1_$7 = create_sprites_player::vera_sprite_palette_offset1_$6 | create_sprites_player::vera_sprite_palette_offset1_palette_offset#0 -- vbuaa=vbuaa_bor_vbuc1 
    ora #vera_sprite_palette_offset1_palette_offset
    // *VERA_DATA0 = *VERA_DATA0 & ~VERA_SPRITE_PALETTE_OFFSET_MASK | palette_offset
    // [801] *VERA_DATA0 = create_sprites_player::vera_sprite_palette_offset1_$7 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_player::@4
    // player_sprite_address += 32*32/2
    // [802] create_sprites_player::player_sprite_address#1 = create_sprites_player::player_sprite_address#10 + (word)$20*$20/2 -- vduz1=vduz1_plus_vwuc1 
    lda.z player_sprite_address
    clc
    adc #<$20*$20/2
    sta.z player_sprite_address
    lda.z player_sprite_address+1
    adc #>$20*$20/2
    sta.z player_sprite_address+1
    lda.z player_sprite_address+2
    adc #0
    sta.z player_sprite_address+2
    lda.z player_sprite_address+3
    adc #0
    sta.z player_sprite_address+3
    // for(byte s=0;s<NUM_PLAYER;s++)
    // [803] create_sprites_player::s#1 = ++ create_sprites_player::s#10 -- vbuxx=_inc_vbuxx 
    inx
    // [670] phi from create_sprites_player::@4 to create_sprites_player::@1 [phi:create_sprites_player::@4->create_sprites_player::@1]
    // [670] phi create_sprites_player::player_sprite_address#10 = create_sprites_player::player_sprite_address#1 [phi:create_sprites_player::@4->create_sprites_player::@1#0] -- register_copy 
    // [670] phi create_sprites_player::s#10 = create_sprites_player::s#1 [phi:create_sprites_player::@4->create_sprites_player::@1#1] -- register_copy 
    jmp __b1
}
  // create_sprites_enemy2
create_sprites_enemy2: {
    .const base = $c
    .const vera_sprite_palette_offset1_palette_offset = 2
    .label __7 = $66
    .label __10 = $62
    .label __26 = $66
    .label __27 = $62
    .label vera_sprite_4bpp1___4 = $62
    .label vera_sprite_4bpp1___7 = $62
    .label vera_sprite_address1___0 = $64
    .label vera_sprite_address1___4 = $66
    .label vera_sprite_address1___5 = $66
    .label vera_sprite_address1___7 = $62
    .label vera_sprite_address1___9 = $61
    .label vera_sprite_address1___10 = $62
    .label vera_sprite_address1___14 = $64
    .label vera_sprite_xy1___4 = $64
    .label vera_sprite_xy1___10 = $64
    .label vera_sprite_height_321___4 = $68
    .label vera_sprite_height_321___8 = $68
    .label vera_sprite_width_321___4 = $62
    .label vera_sprite_width_321___8 = $62
    .label vera_sprite_zdepth_in_front1___4 = $62
    .label vera_sprite_zdepth_in_front1___8 = $62
    .label vera_sprite_VFlip_off1___4 = $64
    .label vera_sprite_VFlip_off1___7 = $64
    .label vera_sprite_HFlip_off1___4 = $66
    .label vera_sprite_HFlip_off1___7 = $66
    .label vera_sprite_palette_offset1___4 = $71
    .label vera_sprite_palette_offset1___8 = $71
    .label vera_sprite_4bpp1_sprite_offset = $62
    .label vera_sprite_address1_sprite_offset = $64
    .label vera_sprite_xy1_x = $66
    .label vera_sprite_xy1_y = $62
    .label vera_sprite_xy1_sprite_offset = $64
    .label vera_sprite_height_321_sprite_offset = $68
    .label vera_sprite_width_321_sprite_offset = $62
    .label vera_sprite_zdepth_in_front1_sprite_offset = $62
    .label vera_sprite_VFlip_off1_sprite_offset = $64
    .label vera_sprite_HFlip_off1_sprite_offset = $66
    .label vera_sprite_palette_offset1_sprite_offset = $71
    .label enemy2_sprite_address = $28
    // [805] phi from create_sprites_enemy2 to create_sprites_enemy2::@1 [phi:create_sprites_enemy2->create_sprites_enemy2::@1]
    // [805] phi create_sprites_enemy2::enemy2_sprite_address#10 = VRAM_ENEMY2 [phi:create_sprites_enemy2->create_sprites_enemy2::@1#0] -- vduz1=vduc1 
    lda #<VRAM_ENEMY2
    sta.z enemy2_sprite_address
    lda #>VRAM_ENEMY2
    sta.z enemy2_sprite_address+1
    lda #<VRAM_ENEMY2>>$10
    sta.z enemy2_sprite_address+2
    lda #>VRAM_ENEMY2>>$10
    sta.z enemy2_sprite_address+3
    // [805] phi create_sprites_enemy2::s#10 = 0 [phi:create_sprites_enemy2->create_sprites_enemy2::@1#1] -- vbuxx=vbuc1 
    ldx #0
    // create_sprites_enemy2::@1
  __b1:
    // for(byte s=0;s<NUM_ENEMY2;s++)
    // [806] if(create_sprites_enemy2::s#10<NUM_ENEMY2) goto create_sprites_enemy2::@2 -- vbuxx_lt_vbuc1_then_la1 
    cpx #NUM_ENEMY2
    bcc __b2
    // create_sprites_enemy2::@return
    // }
    // [807] return 
    rts
    // create_sprites_enemy2::@2
  __b2:
    // vera_sprite_4bpp(s+base)
    // [808] create_sprites_enemy2::vera_sprite_4bpp1_sprite#0 = create_sprites_enemy2::s#10 + create_sprites_enemy2::base -- vbuaa=vbuxx_plus_vbuc1 
    txa
    clc
    adc #base
    // create_sprites_enemy2::vera_sprite_4bpp1
    // (word)sprite << 3
    // [809] create_sprites_enemy2::vera_sprite_4bpp1_$7 = (word)create_sprites_enemy2::vera_sprite_4bpp1_sprite#0 -- vwuz1=_word_vbuaa 
    sta.z vera_sprite_4bpp1___7
    lda #0
    sta.z vera_sprite_4bpp1___7+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [810] create_sprites_enemy2::vera_sprite_4bpp1_sprite_offset#0 = create_sprites_enemy2::vera_sprite_4bpp1_$7 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_4bpp1_sprite_offset
    rol.z vera_sprite_4bpp1_sprite_offset+1
    asl.z vera_sprite_4bpp1_sprite_offset
    rol.z vera_sprite_4bpp1_sprite_offset+1
    asl.z vera_sprite_4bpp1_sprite_offset
    rol.z vera_sprite_4bpp1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [811] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+1
    // [812] create_sprites_enemy2::vera_sprite_4bpp1_$4 = create_sprites_enemy2::vera_sprite_4bpp1_sprite_offset#0 + <VERA_SPRITE_ATTR+1 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_4bpp1___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+1
    sta.z vera_sprite_4bpp1___4
    lda.z vera_sprite_4bpp1___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+1
    sta.z vera_sprite_4bpp1___4+1
    // <sprite_offset+1
    // [813] create_sprites_enemy2::vera_sprite_4bpp1_$3 = < create_sprites_enemy2::vera_sprite_4bpp1_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_4bpp1___4
    // *VERA_ADDRX_L = <sprite_offset+1
    // [814] *VERA_ADDRX_L = create_sprites_enemy2::vera_sprite_4bpp1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+1
    // [815] create_sprites_enemy2::vera_sprite_4bpp1_$5 = > create_sprites_enemy2::vera_sprite_4bpp1_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_4bpp1___4+1
    // *VERA_ADDRX_M = >sprite_offset+1
    // [816] *VERA_ADDRX_M = create_sprites_enemy2::vera_sprite_4bpp1_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [817] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~>VERA_SPRITE_8BPP
    // [818] create_sprites_enemy2::vera_sprite_4bpp1_$6 = *VERA_DATA0 & ~>VERA_SPRITE_8BPP -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #(>VERA_SPRITE_8BPP)^$ff
    and VERA_DATA0
    // *VERA_DATA0 = *VERA_DATA0 & ~>VERA_SPRITE_8BPP
    // [819] *VERA_DATA0 = create_sprites_enemy2::vera_sprite_4bpp1_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_enemy2::@3
    // Enemy2Sprites[s] = enemy2_sprite_address
    // [820] create_sprites_enemy2::$25 = create_sprites_enemy2::s#10 << 2 -- vbuaa=vbuxx_rol_2 
    txa
    asl
    asl
    // [821] Enemy2Sprites[create_sprites_enemy2::$25] = create_sprites_enemy2::enemy2_sprite_address#10 -- pduc1_derefidx_vbuaa=vduz1 
    tay
    lda.z enemy2_sprite_address
    sta Enemy2Sprites,y
    lda.z enemy2_sprite_address+1
    sta Enemy2Sprites+1,y
    lda.z enemy2_sprite_address+2
    sta Enemy2Sprites+2,y
    lda.z enemy2_sprite_address+3
    sta Enemy2Sprites+3,y
    // vera_sprite_address(s+base, enemy2_sprite_address)
    // [822] create_sprites_enemy2::vera_sprite_address1_sprite#0 = create_sprites_enemy2::s#10 + create_sprites_enemy2::base -- vbuaa=vbuxx_plus_vbuc1 
    txa
    clc
    adc #base
    // create_sprites_enemy2::vera_sprite_address1
    // (word)sprite << 3
    // [823] create_sprites_enemy2::vera_sprite_address1_$14 = (word)create_sprites_enemy2::vera_sprite_address1_sprite#0 -- vwuz1=_word_vbuaa 
    sta.z vera_sprite_address1___14
    lda #0
    sta.z vera_sprite_address1___14+1
    // [824] create_sprites_enemy2::vera_sprite_address1_$0 = create_sprites_enemy2::vera_sprite_address1_$14 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_address1___0
    rol.z vera_sprite_address1___0+1
    asl.z vera_sprite_address1___0
    rol.z vera_sprite_address1___0+1
    asl.z vera_sprite_address1___0
    rol.z vera_sprite_address1___0+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [825] create_sprites_enemy2::vera_sprite_address1_sprite_offset#0 = <VERA_SPRITE_ATTR + create_sprites_enemy2::vera_sprite_address1_$0 -- vwuz1=vwuc1_plus_vwuz1 
    clc
    lda.z vera_sprite_address1_sprite_offset
    adc #<VERA_SPRITE_ATTR&$ffff
    sta.z vera_sprite_address1_sprite_offset
    lda.z vera_sprite_address1_sprite_offset+1
    adc #>VERA_SPRITE_ATTR&$ffff
    sta.z vera_sprite_address1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [826] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <sprite_offset
    // [827] create_sprites_enemy2::vera_sprite_address1_$2 = < create_sprites_enemy2::vera_sprite_address1_sprite_offset#0 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_address1_sprite_offset
    // *VERA_ADDRX_L = <sprite_offset
    // [828] *VERA_ADDRX_L = create_sprites_enemy2::vera_sprite_address1_$2 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset
    // [829] create_sprites_enemy2::vera_sprite_address1_$3 = > create_sprites_enemy2::vera_sprite_address1_sprite_offset#0 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_address1_sprite_offset+1
    // *VERA_ADDRX_M = >sprite_offset
    // [830] *VERA_ADDRX_M = create_sprites_enemy2::vera_sprite_address1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_1 | <(>VERA_SPRITE_ATTR)
    // [831] *VERA_ADDRX_H = VERA_INC_1|<>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #VERA_INC_1|(<(VERA_SPRITE_ATTR>>$10))
    sta VERA_ADDRX_H
    // <address
    // [832] create_sprites_enemy2::vera_sprite_address1_$4 = < create_sprites_enemy2::enemy2_sprite_address#10 -- vwuz1=_lo_vduz2 
    lda.z enemy2_sprite_address
    sta.z vera_sprite_address1___4
    lda.z enemy2_sprite_address+1
    sta.z vera_sprite_address1___4+1
    // (<address)>>5
    // [833] create_sprites_enemy2::vera_sprite_address1_$5 = create_sprites_enemy2::vera_sprite_address1_$4 >> 5 -- vwuz1=vwuz1_ror_5 
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    lsr.z vera_sprite_address1___5+1
    ror.z vera_sprite_address1___5
    // <((<address)>>5)
    // [834] create_sprites_enemy2::vera_sprite_address1_$6 = < create_sprites_enemy2::vera_sprite_address1_$5 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_address1___5
    // *VERA_DATA0 = <((<address)>>5)
    // [835] *VERA_DATA0 = create_sprites_enemy2::vera_sprite_address1_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // <address
    // [836] create_sprites_enemy2::vera_sprite_address1_$7 = < create_sprites_enemy2::enemy2_sprite_address#10 -- vwuz1=_lo_vduz2 
    lda.z enemy2_sprite_address
    sta.z vera_sprite_address1___7
    lda.z enemy2_sprite_address+1
    sta.z vera_sprite_address1___7+1
    // >(<address)
    // [837] create_sprites_enemy2::vera_sprite_address1_$8 = > create_sprites_enemy2::vera_sprite_address1_$7 -- vbuaa=_hi_vwuz1 
    // (>(<address))>>5
    // [838] create_sprites_enemy2::vera_sprite_address1_$9 = create_sprites_enemy2::vera_sprite_address1_$8 >> 5 -- vbuz1=vbuaa_ror_5 
    lsr
    lsr
    lsr
    lsr
    lsr
    sta.z vera_sprite_address1___9
    // >address
    // [839] create_sprites_enemy2::vera_sprite_address1_$10 = > create_sprites_enemy2::enemy2_sprite_address#10 -- vwuz1=_hi_vduz2 
    lda.z enemy2_sprite_address+2
    sta.z vera_sprite_address1___10
    lda.z enemy2_sprite_address+3
    sta.z vera_sprite_address1___10+1
    // <(>address)
    // [840] create_sprites_enemy2::vera_sprite_address1_$11 = < create_sprites_enemy2::vera_sprite_address1_$10 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_address1___10
    // (<(>address))<<3
    // [841] create_sprites_enemy2::vera_sprite_address1_$12 = create_sprites_enemy2::vera_sprite_address1_$11 << 3 -- vbuaa=vbuaa_rol_3 
    asl
    asl
    asl
    // ((>(<address))>>5)|((<(>address))<<3)
    // [842] create_sprites_enemy2::vera_sprite_address1_$13 = create_sprites_enemy2::vera_sprite_address1_$9 | create_sprites_enemy2::vera_sprite_address1_$12 -- vbuaa=vbuz1_bor_vbuaa 
    ora.z vera_sprite_address1___9
    // *VERA_DATA0 = ((>(<address))>>5)|((<(>address))<<3)
    // [843] *VERA_DATA0 = create_sprites_enemy2::vera_sprite_address1_$13 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_enemy2::@4
    // vera_sprite_xy(s+base, 40+((word)(s&03)<<6), 340+((word)(s>>2)<<6))
    // [844] create_sprites_enemy2::vera_sprite_xy1_sprite#0 = create_sprites_enemy2::s#10 + create_sprites_enemy2::base -- vbuyy=vbuxx_plus_vbuc1 
    txa
    clc
    adc #base
    tay
    // s&03
    // [845] create_sprites_enemy2::$6 = create_sprites_enemy2::s#10 & 3 -- vbuaa=vbuxx_band_vbuc1 
    txa
    and #3
    // (word)(s&03)<<6
    // [846] create_sprites_enemy2::$26 = (word)create_sprites_enemy2::$6 -- vwuz1=_word_vbuaa 
    sta.z __26
    lda #0
    sta.z __26+1
    // [847] create_sprites_enemy2::$7 = create_sprites_enemy2::$26 << 6 -- vwuz1=vwuz1_rol_6 
    lda.z __7+1
    lsr
    sta.z $ff
    lda.z __7
    ror
    sta.z __7+1
    lda #0
    ror
    sta.z __7
    lsr.z $ff
    ror.z __7+1
    ror.z __7
    // vera_sprite_xy(s+base, 40+((word)(s&03)<<6), 340+((word)(s>>2)<<6))
    // [848] create_sprites_enemy2::vera_sprite_xy1_x#0 = $28 + create_sprites_enemy2::$7 -- vwuz1=vbuc1_plus_vwuz1 
    lda #$28
    clc
    adc.z vera_sprite_xy1_x
    sta.z vera_sprite_xy1_x
    bcc !+
    inc.z vera_sprite_xy1_x+1
  !:
    // s>>2
    // [849] create_sprites_enemy2::$9 = create_sprites_enemy2::s#10 >> 2 -- vbuaa=vbuxx_ror_2 
    txa
    lsr
    lsr
    // (word)(s>>2)<<6
    // [850] create_sprites_enemy2::$27 = (word)create_sprites_enemy2::$9 -- vwuz1=_word_vbuaa 
    sta.z __27
    lda #0
    sta.z __27+1
    // [851] create_sprites_enemy2::$10 = create_sprites_enemy2::$27 << 6 -- vwuz1=vwuz1_rol_6 
    lda.z __10+1
    lsr
    sta.z $ff
    lda.z __10
    ror
    sta.z __10+1
    lda #0
    ror
    sta.z __10
    lsr.z $ff
    ror.z __10+1
    ror.z __10
    // vera_sprite_xy(s+base, 40+((word)(s&03)<<6), 340+((word)(s>>2)<<6))
    // [852] create_sprites_enemy2::vera_sprite_xy1_y#0 = $154 + create_sprites_enemy2::$10 -- vwuz1=vwuc1_plus_vwuz1 
    clc
    lda.z vera_sprite_xy1_y
    adc #<$154
    sta.z vera_sprite_xy1_y
    lda.z vera_sprite_xy1_y+1
    adc #>$154
    sta.z vera_sprite_xy1_y+1
    // create_sprites_enemy2::vera_sprite_xy1
    // (word)sprite << 3
    // [853] create_sprites_enemy2::vera_sprite_xy1_$10 = (word)create_sprites_enemy2::vera_sprite_xy1_sprite#0 -- vwuz1=_word_vbuyy 
    tya
    sta.z vera_sprite_xy1___10
    lda #0
    sta.z vera_sprite_xy1___10+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [854] create_sprites_enemy2::vera_sprite_xy1_sprite_offset#0 = create_sprites_enemy2::vera_sprite_xy1_$10 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_xy1_sprite_offset
    rol.z vera_sprite_xy1_sprite_offset+1
    asl.z vera_sprite_xy1_sprite_offset
    rol.z vera_sprite_xy1_sprite_offset+1
    asl.z vera_sprite_xy1_sprite_offset
    rol.z vera_sprite_xy1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [855] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+2
    // [856] create_sprites_enemy2::vera_sprite_xy1_$4 = create_sprites_enemy2::vera_sprite_xy1_sprite_offset#0 + <VERA_SPRITE_ATTR+2 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_xy1___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+2
    sta.z vera_sprite_xy1___4
    lda.z vera_sprite_xy1___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+2
    sta.z vera_sprite_xy1___4+1
    // <sprite_offset+2
    // [857] create_sprites_enemy2::vera_sprite_xy1_$3 = < create_sprites_enemy2::vera_sprite_xy1_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_xy1___4
    // *VERA_ADDRX_L = <sprite_offset+2
    // [858] *VERA_ADDRX_L = create_sprites_enemy2::vera_sprite_xy1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+2
    // [859] create_sprites_enemy2::vera_sprite_xy1_$5 = > create_sprites_enemy2::vera_sprite_xy1_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_xy1___4+1
    // *VERA_ADDRX_M = >sprite_offset+2
    // [860] *VERA_ADDRX_M = create_sprites_enemy2::vera_sprite_xy1_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_1 | <(>VERA_SPRITE_ATTR)
    // [861] *VERA_ADDRX_H = VERA_INC_1|<>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #VERA_INC_1|(<(VERA_SPRITE_ATTR>>$10))
    sta VERA_ADDRX_H
    // <x
    // [862] create_sprites_enemy2::vera_sprite_xy1_$6 = < create_sprites_enemy2::vera_sprite_xy1_x#0 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_xy1_x
    // *VERA_DATA0 = <x
    // [863] *VERA_DATA0 = create_sprites_enemy2::vera_sprite_xy1_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // >x
    // [864] create_sprites_enemy2::vera_sprite_xy1_$7 = > create_sprites_enemy2::vera_sprite_xy1_x#0 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_xy1_x+1
    // *VERA_DATA0 = >x
    // [865] *VERA_DATA0 = create_sprites_enemy2::vera_sprite_xy1_$7 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // <y
    // [866] create_sprites_enemy2::vera_sprite_xy1_$8 = < create_sprites_enemy2::vera_sprite_xy1_y#0 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_xy1_y
    // *VERA_DATA0 = <y
    // [867] *VERA_DATA0 = create_sprites_enemy2::vera_sprite_xy1_$8 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // >y
    // [868] create_sprites_enemy2::vera_sprite_xy1_$9 = > create_sprites_enemy2::vera_sprite_xy1_y#0 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_xy1_y+1
    // *VERA_DATA0 = >y
    // [869] *VERA_DATA0 = create_sprites_enemy2::vera_sprite_xy1_$9 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_enemy2::@5
    // vera_sprite_height_32(s+base)
    // [870] create_sprites_enemy2::vera_sprite_height_321_sprite#0 = create_sprites_enemy2::s#10 + create_sprites_enemy2::base -- vbuaa=vbuxx_plus_vbuc1 
    txa
    clc
    adc #base
    // create_sprites_enemy2::vera_sprite_height_321
    // (word)sprite << 3
    // [871] create_sprites_enemy2::vera_sprite_height_321_$8 = (word)create_sprites_enemy2::vera_sprite_height_321_sprite#0 -- vwuz1=_word_vbuaa 
    sta.z vera_sprite_height_321___8
    lda #0
    sta.z vera_sprite_height_321___8+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [872] create_sprites_enemy2::vera_sprite_height_321_sprite_offset#0 = create_sprites_enemy2::vera_sprite_height_321_$8 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_height_321_sprite_offset
    rol.z vera_sprite_height_321_sprite_offset+1
    asl.z vera_sprite_height_321_sprite_offset
    rol.z vera_sprite_height_321_sprite_offset+1
    asl.z vera_sprite_height_321_sprite_offset
    rol.z vera_sprite_height_321_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [873] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+7
    // [874] create_sprites_enemy2::vera_sprite_height_321_$4 = create_sprites_enemy2::vera_sprite_height_321_sprite_offset#0 + <VERA_SPRITE_ATTR+7 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_height_321___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+7
    sta.z vera_sprite_height_321___4
    lda.z vera_sprite_height_321___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+7
    sta.z vera_sprite_height_321___4+1
    // <sprite_offset+7
    // [875] create_sprites_enemy2::vera_sprite_height_321_$3 = < create_sprites_enemy2::vera_sprite_height_321_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_height_321___4
    // *VERA_ADDRX_L = <sprite_offset+7
    // [876] *VERA_ADDRX_L = create_sprites_enemy2::vera_sprite_height_321_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+7
    // [877] create_sprites_enemy2::vera_sprite_height_321_$5 = > create_sprites_enemy2::vera_sprite_height_321_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_height_321___4+1
    // *VERA_ADDRX_M = >sprite_offset+7
    // [878] *VERA_ADDRX_M = create_sprites_enemy2::vera_sprite_height_321_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [879] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~VERA_SPRITE_HEIGHT_MASK
    // [880] create_sprites_enemy2::vera_sprite_height_321_$6 = *VERA_DATA0 & ~VERA_SPRITE_HEIGHT_MASK -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #VERA_SPRITE_HEIGHT_MASK^$ff
    and VERA_DATA0
    // *VERA_DATA0 & ~VERA_SPRITE_HEIGHT_MASK | VERA_SPRITE_HEIGHT_32
    // [881] create_sprites_enemy2::vera_sprite_height_321_$7 = create_sprites_enemy2::vera_sprite_height_321_$6 | VERA_SPRITE_HEIGHT_32 -- vbuaa=vbuaa_bor_vbuc1 
    ora #VERA_SPRITE_HEIGHT_32
    // *VERA_DATA0 = *VERA_DATA0 & ~VERA_SPRITE_HEIGHT_MASK | VERA_SPRITE_HEIGHT_32
    // [882] *VERA_DATA0 = create_sprites_enemy2::vera_sprite_height_321_$7 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_enemy2::@6
    // vera_sprite_width_32(s+base)
    // [883] create_sprites_enemy2::vera_sprite_width_321_sprite#0 = create_sprites_enemy2::s#10 + create_sprites_enemy2::base -- vbuaa=vbuxx_plus_vbuc1 
    txa
    clc
    adc #base
    // create_sprites_enemy2::vera_sprite_width_321
    // (word)sprite << 3
    // [884] create_sprites_enemy2::vera_sprite_width_321_$8 = (word)create_sprites_enemy2::vera_sprite_width_321_sprite#0 -- vwuz1=_word_vbuaa 
    sta.z vera_sprite_width_321___8
    lda #0
    sta.z vera_sprite_width_321___8+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [885] create_sprites_enemy2::vera_sprite_width_321_sprite_offset#0 = create_sprites_enemy2::vera_sprite_width_321_$8 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_width_321_sprite_offset
    rol.z vera_sprite_width_321_sprite_offset+1
    asl.z vera_sprite_width_321_sprite_offset
    rol.z vera_sprite_width_321_sprite_offset+1
    asl.z vera_sprite_width_321_sprite_offset
    rol.z vera_sprite_width_321_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [886] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+7
    // [887] create_sprites_enemy2::vera_sprite_width_321_$4 = create_sprites_enemy2::vera_sprite_width_321_sprite_offset#0 + <VERA_SPRITE_ATTR+7 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_width_321___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+7
    sta.z vera_sprite_width_321___4
    lda.z vera_sprite_width_321___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+7
    sta.z vera_sprite_width_321___4+1
    // <sprite_offset+7
    // [888] create_sprites_enemy2::vera_sprite_width_321_$3 = < create_sprites_enemy2::vera_sprite_width_321_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_width_321___4
    // *VERA_ADDRX_L = <sprite_offset+7
    // [889] *VERA_ADDRX_L = create_sprites_enemy2::vera_sprite_width_321_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+7
    // [890] create_sprites_enemy2::vera_sprite_width_321_$5 = > create_sprites_enemy2::vera_sprite_width_321_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_width_321___4+1
    // *VERA_ADDRX_M = >sprite_offset+7
    // [891] *VERA_ADDRX_M = create_sprites_enemy2::vera_sprite_width_321_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [892] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~VERA_SPRITE_WIDTH_MASK
    // [893] create_sprites_enemy2::vera_sprite_width_321_$6 = *VERA_DATA0 & ~VERA_SPRITE_WIDTH_MASK -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #VERA_SPRITE_WIDTH_MASK^$ff
    and VERA_DATA0
    // *VERA_DATA0 & ~VERA_SPRITE_WIDTH_MASK | VERA_SPRITE_WIDTH_32
    // [894] create_sprites_enemy2::vera_sprite_width_321_$7 = create_sprites_enemy2::vera_sprite_width_321_$6 | VERA_SPRITE_WIDTH_32 -- vbuaa=vbuaa_bor_vbuc1 
    ora #VERA_SPRITE_WIDTH_32
    // *VERA_DATA0 = *VERA_DATA0 & ~VERA_SPRITE_WIDTH_MASK | VERA_SPRITE_WIDTH_32
    // [895] *VERA_DATA0 = create_sprites_enemy2::vera_sprite_width_321_$7 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_enemy2::@7
    // vera_sprite_zdepth_in_front(s+base)
    // [896] create_sprites_enemy2::vera_sprite_zdepth_in_front1_sprite#0 = create_sprites_enemy2::s#10 + create_sprites_enemy2::base -- vbuaa=vbuxx_plus_vbuc1 
    txa
    clc
    adc #base
    // create_sprites_enemy2::vera_sprite_zdepth_in_front1
    // (word)sprite << 3
    // [897] create_sprites_enemy2::vera_sprite_zdepth_in_front1_$8 = (word)create_sprites_enemy2::vera_sprite_zdepth_in_front1_sprite#0 -- vwuz1=_word_vbuaa 
    sta.z vera_sprite_zdepth_in_front1___8
    lda #0
    sta.z vera_sprite_zdepth_in_front1___8+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [898] create_sprites_enemy2::vera_sprite_zdepth_in_front1_sprite_offset#0 = create_sprites_enemy2::vera_sprite_zdepth_in_front1_$8 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_zdepth_in_front1_sprite_offset
    rol.z vera_sprite_zdepth_in_front1_sprite_offset+1
    asl.z vera_sprite_zdepth_in_front1_sprite_offset
    rol.z vera_sprite_zdepth_in_front1_sprite_offset+1
    asl.z vera_sprite_zdepth_in_front1_sprite_offset
    rol.z vera_sprite_zdepth_in_front1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [899] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+6
    // [900] create_sprites_enemy2::vera_sprite_zdepth_in_front1_$4 = create_sprites_enemy2::vera_sprite_zdepth_in_front1_sprite_offset#0 + <VERA_SPRITE_ATTR+6 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_zdepth_in_front1___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+6
    sta.z vera_sprite_zdepth_in_front1___4
    lda.z vera_sprite_zdepth_in_front1___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+6
    sta.z vera_sprite_zdepth_in_front1___4+1
    // <sprite_offset+6
    // [901] create_sprites_enemy2::vera_sprite_zdepth_in_front1_$3 = < create_sprites_enemy2::vera_sprite_zdepth_in_front1_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_zdepth_in_front1___4
    // *VERA_ADDRX_L = <sprite_offset+6
    // [902] *VERA_ADDRX_L = create_sprites_enemy2::vera_sprite_zdepth_in_front1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+6
    // [903] create_sprites_enemy2::vera_sprite_zdepth_in_front1_$5 = > create_sprites_enemy2::vera_sprite_zdepth_in_front1_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_zdepth_in_front1___4+1
    // *VERA_ADDRX_M = >sprite_offset+6
    // [904] *VERA_ADDRX_M = create_sprites_enemy2::vera_sprite_zdepth_in_front1_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [905] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~VERA_SPRITE_ZDEPTH_MASK
    // [906] create_sprites_enemy2::vera_sprite_zdepth_in_front1_$6 = *VERA_DATA0 & ~VERA_SPRITE_ZDEPTH_MASK -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #VERA_SPRITE_ZDEPTH_MASK^$ff
    and VERA_DATA0
    // *VERA_DATA0 & ~VERA_SPRITE_ZDEPTH_MASK | VERA_SPRITE_ZDEPTH_IN_FRONT
    // [907] create_sprites_enemy2::vera_sprite_zdepth_in_front1_$7 = create_sprites_enemy2::vera_sprite_zdepth_in_front1_$6 | VERA_SPRITE_ZDEPTH_IN_FRONT -- vbuaa=vbuaa_bor_vbuc1 
    ora #VERA_SPRITE_ZDEPTH_IN_FRONT
    // *VERA_DATA0 = *VERA_DATA0 & ~VERA_SPRITE_ZDEPTH_MASK | VERA_SPRITE_ZDEPTH_IN_FRONT
    // [908] *VERA_DATA0 = create_sprites_enemy2::vera_sprite_zdepth_in_front1_$7 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_enemy2::@8
    // vera_sprite_VFlip_off(s+base)
    // [909] create_sprites_enemy2::vera_sprite_VFlip_off1_sprite#0 = create_sprites_enemy2::s#10 + create_sprites_enemy2::base -- vbuaa=vbuxx_plus_vbuc1 
    txa
    clc
    adc #base
    // create_sprites_enemy2::vera_sprite_VFlip_off1
    // (word)sprite << 3
    // [910] create_sprites_enemy2::vera_sprite_VFlip_off1_$7 = (word)create_sprites_enemy2::vera_sprite_VFlip_off1_sprite#0 -- vwuz1=_word_vbuaa 
    sta.z vera_sprite_VFlip_off1___7
    lda #0
    sta.z vera_sprite_VFlip_off1___7+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [911] create_sprites_enemy2::vera_sprite_VFlip_off1_sprite_offset#0 = create_sprites_enemy2::vera_sprite_VFlip_off1_$7 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_VFlip_off1_sprite_offset
    rol.z vera_sprite_VFlip_off1_sprite_offset+1
    asl.z vera_sprite_VFlip_off1_sprite_offset
    rol.z vera_sprite_VFlip_off1_sprite_offset+1
    asl.z vera_sprite_VFlip_off1_sprite_offset
    rol.z vera_sprite_VFlip_off1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [912] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+6
    // [913] create_sprites_enemy2::vera_sprite_VFlip_off1_$4 = create_sprites_enemy2::vera_sprite_VFlip_off1_sprite_offset#0 + <VERA_SPRITE_ATTR+6 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_VFlip_off1___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+6
    sta.z vera_sprite_VFlip_off1___4
    lda.z vera_sprite_VFlip_off1___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+6
    sta.z vera_sprite_VFlip_off1___4+1
    // <sprite_offset+6
    // [914] create_sprites_enemy2::vera_sprite_VFlip_off1_$3 = < create_sprites_enemy2::vera_sprite_VFlip_off1_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_VFlip_off1___4
    // *VERA_ADDRX_L = <sprite_offset+6
    // [915] *VERA_ADDRX_L = create_sprites_enemy2::vera_sprite_VFlip_off1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+6
    // [916] create_sprites_enemy2::vera_sprite_VFlip_off1_$5 = > create_sprites_enemy2::vera_sprite_VFlip_off1_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_VFlip_off1___4+1
    // *VERA_ADDRX_M = >sprite_offset+6
    // [917] *VERA_ADDRX_M = create_sprites_enemy2::vera_sprite_VFlip_off1_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [918] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~VERA_SPRITE_VFLIP
    // [919] create_sprites_enemy2::vera_sprite_VFlip_off1_$6 = *VERA_DATA0 & ~VERA_SPRITE_VFLIP -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #VERA_SPRITE_VFLIP^$ff
    and VERA_DATA0
    // *VERA_DATA0 = *VERA_DATA0 & ~VERA_SPRITE_VFLIP
    // [920] *VERA_DATA0 = create_sprites_enemy2::vera_sprite_VFlip_off1_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_enemy2::@9
    // vera_sprite_HFlip_off(s+base)
    // [921] create_sprites_enemy2::vera_sprite_HFlip_off1_sprite#0 = create_sprites_enemy2::s#10 + create_sprites_enemy2::base -- vbuaa=vbuxx_plus_vbuc1 
    txa
    clc
    adc #base
    // create_sprites_enemy2::vera_sprite_HFlip_off1
    // (word)sprite << 3
    // [922] create_sprites_enemy2::vera_sprite_HFlip_off1_$7 = (word)create_sprites_enemy2::vera_sprite_HFlip_off1_sprite#0 -- vwuz1=_word_vbuaa 
    sta.z vera_sprite_HFlip_off1___7
    lda #0
    sta.z vera_sprite_HFlip_off1___7+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [923] create_sprites_enemy2::vera_sprite_HFlip_off1_sprite_offset#0 = create_sprites_enemy2::vera_sprite_HFlip_off1_$7 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_HFlip_off1_sprite_offset
    rol.z vera_sprite_HFlip_off1_sprite_offset+1
    asl.z vera_sprite_HFlip_off1_sprite_offset
    rol.z vera_sprite_HFlip_off1_sprite_offset+1
    asl.z vera_sprite_HFlip_off1_sprite_offset
    rol.z vera_sprite_HFlip_off1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [924] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+6
    // [925] create_sprites_enemy2::vera_sprite_HFlip_off1_$4 = create_sprites_enemy2::vera_sprite_HFlip_off1_sprite_offset#0 + <VERA_SPRITE_ATTR+6 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_HFlip_off1___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+6
    sta.z vera_sprite_HFlip_off1___4
    lda.z vera_sprite_HFlip_off1___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+6
    sta.z vera_sprite_HFlip_off1___4+1
    // <sprite_offset+6
    // [926] create_sprites_enemy2::vera_sprite_HFlip_off1_$3 = < create_sprites_enemy2::vera_sprite_HFlip_off1_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_HFlip_off1___4
    // *VERA_ADDRX_L = <sprite_offset+6
    // [927] *VERA_ADDRX_L = create_sprites_enemy2::vera_sprite_HFlip_off1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+6
    // [928] create_sprites_enemy2::vera_sprite_HFlip_off1_$5 = > create_sprites_enemy2::vera_sprite_HFlip_off1_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_HFlip_off1___4+1
    // *VERA_ADDRX_M = >sprite_offset+6
    // [929] *VERA_ADDRX_M = create_sprites_enemy2::vera_sprite_HFlip_off1_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [930] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~VERA_SPRITE_HFLIP
    // [931] create_sprites_enemy2::vera_sprite_HFlip_off1_$6 = *VERA_DATA0 & ~VERA_SPRITE_HFLIP -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #VERA_SPRITE_HFLIP^$ff
    and VERA_DATA0
    // *VERA_DATA0 = *VERA_DATA0 & ~VERA_SPRITE_HFLIP
    // [932] *VERA_DATA0 = create_sprites_enemy2::vera_sprite_HFlip_off1_$6 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_enemy2::@10
    // vera_sprite_palette_offset(s+base,2)
    // [933] create_sprites_enemy2::vera_sprite_palette_offset1_sprite#0 = create_sprites_enemy2::s#10 + create_sprites_enemy2::base -- vbuaa=vbuxx_plus_vbuc1 
    txa
    clc
    adc #base
    // create_sprites_enemy2::vera_sprite_palette_offset1
    // (word)sprite << 3
    // [934] create_sprites_enemy2::vera_sprite_palette_offset1_$8 = (word)create_sprites_enemy2::vera_sprite_palette_offset1_sprite#0 -- vwuz1=_word_vbuaa 
    sta.z vera_sprite_palette_offset1___8
    lda #0
    sta.z vera_sprite_palette_offset1___8+1
    // sprite_offset = (<VERA_SPRITE_ATTR)+(word)sprite << 3
    // [935] create_sprites_enemy2::vera_sprite_palette_offset1_sprite_offset#0 = create_sprites_enemy2::vera_sprite_palette_offset1_$8 << 3 -- vwuz1=vwuz1_rol_3 
    asl.z vera_sprite_palette_offset1_sprite_offset
    rol.z vera_sprite_palette_offset1_sprite_offset+1
    asl.z vera_sprite_palette_offset1_sprite_offset
    rol.z vera_sprite_palette_offset1_sprite_offset+1
    asl.z vera_sprite_palette_offset1_sprite_offset
    rol.z vera_sprite_palette_offset1_sprite_offset+1
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [936] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // sprite_offset+7
    // [937] create_sprites_enemy2::vera_sprite_palette_offset1_$4 = create_sprites_enemy2::vera_sprite_palette_offset1_sprite_offset#0 + <VERA_SPRITE_ATTR+7 -- vwuz1=vwuz1_plus_vwuc1 
    clc
    lda.z vera_sprite_palette_offset1___4
    adc #<((VERA_SPRITE_ATTR&$ffff))+7
    sta.z vera_sprite_palette_offset1___4
    lda.z vera_sprite_palette_offset1___4+1
    adc #>((VERA_SPRITE_ATTR&$ffff))+7
    sta.z vera_sprite_palette_offset1___4+1
    // <sprite_offset+7
    // [938] create_sprites_enemy2::vera_sprite_palette_offset1_$3 = < create_sprites_enemy2::vera_sprite_palette_offset1_$4 -- vbuaa=_lo_vwuz1 
    lda.z vera_sprite_palette_offset1___4
    // *VERA_ADDRX_L = <sprite_offset+7
    // [939] *VERA_ADDRX_L = create_sprites_enemy2::vera_sprite_palette_offset1_$3 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >sprite_offset+7
    // [940] create_sprites_enemy2::vera_sprite_palette_offset1_$5 = > create_sprites_enemy2::vera_sprite_palette_offset1_$4 -- vbuaa=_hi_vwuz1 
    lda.z vera_sprite_palette_offset1___4+1
    // *VERA_ADDRX_M = >sprite_offset+7
    // [941] *VERA_ADDRX_M = create_sprites_enemy2::vera_sprite_palette_offset1_$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_0 | <(>VERA_SPRITE_ATTR)
    // [942] *VERA_ADDRX_H = <>VERA_SPRITE_ATTR -- _deref_pbuc1=vbuc2 
    lda #<VERA_SPRITE_ATTR>>$10
    sta VERA_ADDRX_H
    // *VERA_DATA0 & ~VERA_SPRITE_PALETTE_OFFSET_MASK
    // [943] create_sprites_enemy2::vera_sprite_palette_offset1_$6 = *VERA_DATA0 & ~VERA_SPRITE_PALETTE_OFFSET_MASK -- vbuaa=_deref_pbuc1_band_vbuc2 
    lda #VERA_SPRITE_PALETTE_OFFSET_MASK^$ff
    and VERA_DATA0
    // *VERA_DATA0 & ~VERA_SPRITE_PALETTE_OFFSET_MASK | palette_offset
    // [944] create_sprites_enemy2::vera_sprite_palette_offset1_$7 = create_sprites_enemy2::vera_sprite_palette_offset1_$6 | create_sprites_enemy2::vera_sprite_palette_offset1_palette_offset#0 -- vbuaa=vbuaa_bor_vbuc1 
    ora #vera_sprite_palette_offset1_palette_offset
    // *VERA_DATA0 = *VERA_DATA0 & ~VERA_SPRITE_PALETTE_OFFSET_MASK | palette_offset
    // [945] *VERA_DATA0 = create_sprites_enemy2::vera_sprite_palette_offset1_$7 -- _deref_pbuc1=vbuaa 
    sta VERA_DATA0
    // create_sprites_enemy2::@11
    // enemy2_sprite_address += 32*32/2
    // [946] create_sprites_enemy2::enemy2_sprite_address#1 = create_sprites_enemy2::enemy2_sprite_address#10 + (word)$20*$20/2 -- vduz1=vduz1_plus_vwuc1 
    lda.z enemy2_sprite_address
    clc
    adc #<$20*$20/2
    sta.z enemy2_sprite_address
    lda.z enemy2_sprite_address+1
    adc #>$20*$20/2
    sta.z enemy2_sprite_address+1
    lda.z enemy2_sprite_address+2
    adc #0
    sta.z enemy2_sprite_address+2
    lda.z enemy2_sprite_address+3
    adc #0
    sta.z enemy2_sprite_address+3
    // for(byte s=0;s<NUM_ENEMY2;s++)
    // [947] create_sprites_enemy2::s#1 = ++ create_sprites_enemy2::s#10 -- vbuxx=_inc_vbuxx 
    inx
    // [805] phi from create_sprites_enemy2::@11 to create_sprites_enemy2::@1 [phi:create_sprites_enemy2::@11->create_sprites_enemy2::@1]
    // [805] phi create_sprites_enemy2::enemy2_sprite_address#10 = create_sprites_enemy2::enemy2_sprite_address#1 [phi:create_sprites_enemy2::@11->create_sprites_enemy2::@1#0] -- register_copy 
    // [805] phi create_sprites_enemy2::s#10 = create_sprites_enemy2::s#1 [phi:create_sprites_enemy2::@11->create_sprites_enemy2::@1#1] -- register_copy 
    jmp __b1
}
  // kbhit
// Return true if there's a key waiting, return false if not
kbhit: {
    .label chptr = ch
    .label IN_DEV = $28a
    // Current input device number
    .label GETIN = $ffe4
    .label ch = $6a
    // ch = 0
    // [948] kbhit::ch = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z ch
    // kickasm
    // kickasm( uses kbhit::chptr uses kbhit::IN_DEV uses kbhit::GETIN) {{ jsr _kbhit         bne L3          jmp continue1          .var via1 = $9f60                  //VIA#1         .var d1pra = via1+1      _kbhit:         ldy     d1pra       // The count of keys pressed is stored in RAM bank 0.         stz     d1pra       // Set d1pra to zero to access RAM bank 0.         lda     $A00A       // Get number of characters from this address in the ROM of the CX16 (ROM 38).         sty     d1pra       // Set d1pra to previous value.         rts      L3:         ldy     IN_DEV          // Save current input device         stz     IN_DEV          // Keyboard         phy         jsr     GETIN           // Read char, and return in .A         ply         sta     chptr           // Store the character read in ch         sty     IN_DEV          // Restore input device         ldx     #>$0000         rts      continue1:         nop       }}
    // CBM GETIN API
    jsr _kbhit
        bne L3

        jmp continue1

        .var via1 = $9f60                  //VIA#1
        .var d1pra = via1+1

    _kbhit:
        ldy     d1pra       // The count of keys pressed is stored in RAM bank 0.
        stz     d1pra       // Set d1pra to zero to access RAM bank 0.
        lda     $A00A       // Get number of characters from this address in the ROM of the CX16 (ROM 38).
        sty     d1pra       // Set d1pra to previous value.
        rts

    L3:
        ldy     IN_DEV          // Save current input device
        stz     IN_DEV          // Keyboard
        phy
        jsr     GETIN           // Read char, and return in .A
        ply
        sta     chptr           // Store the character read in ch
        sty     IN_DEV          // Restore input device
        ldx     #>$0000
        rts

    continue1:
        nop
     
    // return ch;
    // [950] kbhit::return#0 = kbhit::ch -- vbuaa=vbuz1 
    // kbhit::@return
    // }
    // [951] kbhit::return#1 = kbhit::return#0
    // [952] return 
    rts
}
  // divr16u
// Performs division on two 16 bit unsigned ints and an initial remainder
// Returns the quotient dividend/divisor.
// The final remainder will be set into the global variable rem16u
// Implemented using simple binary division
// divr16u(word zp($52) dividend, word zp($2c) rem)
divr16u: {
    .const divisor = 3
    .label rem = $2c
    .label dividend = $52
    .label quotient = $50
    .label return = $50
    // [954] phi from divr16u to divr16u::@1 [phi:divr16u->divr16u::@1]
    // [954] phi divr16u::i#2 = 0 [phi:divr16u->divr16u::@1#0] -- vbuxx=vbuc1 
    ldx #0
    // [954] phi divr16u::quotient#3 = 0 [phi:divr16u->divr16u::@1#1] -- vwuz1=vwuc1 
    txa
    sta.z quotient
    sta.z quotient+1
    // [954] phi divr16u::dividend#2 = divr16u::dividend#1 [phi:divr16u->divr16u::@1#2] -- register_copy 
    // [954] phi divr16u::rem#4 = 0 [phi:divr16u->divr16u::@1#3] -- vwuz1=vbuc1 
    sta.z rem
    sta.z rem+1
    // [954] phi from divr16u::@3 to divr16u::@1 [phi:divr16u::@3->divr16u::@1]
    // [954] phi divr16u::i#2 = divr16u::i#1 [phi:divr16u::@3->divr16u::@1#0] -- register_copy 
    // [954] phi divr16u::quotient#3 = divr16u::return#0 [phi:divr16u::@3->divr16u::@1#1] -- register_copy 
    // [954] phi divr16u::dividend#2 = divr16u::dividend#0 [phi:divr16u::@3->divr16u::@1#2] -- register_copy 
    // [954] phi divr16u::rem#4 = divr16u::rem#10 [phi:divr16u::@3->divr16u::@1#3] -- register_copy 
    // divr16u::@1
  __b1:
    // rem = rem << 1
    // [955] divr16u::rem#0 = divr16u::rem#4 << 1 -- vwuz1=vwuz1_rol_1 
    asl.z rem
    rol.z rem+1
    // >dividend
    // [956] divr16u::$1 = > divr16u::dividend#2 -- vbuaa=_hi_vwuz1 
    lda.z dividend+1
    // >dividend & $80
    // [957] divr16u::$2 = divr16u::$1 & $80 -- vbuaa=vbuaa_band_vbuc1 
    and #$80
    // if( (>dividend & $80) != 0 )
    // [958] if(divr16u::$2==0) goto divr16u::@2 -- vbuaa_eq_0_then_la1 
    cmp #0
    beq __b2
    // divr16u::@4
    // rem = rem | 1
    // [959] divr16u::rem#1 = divr16u::rem#0 | 1 -- vwuz1=vwuz1_bor_vbuc1 
    lda #1
    ora.z rem
    sta.z rem
    // [960] phi from divr16u::@1 divr16u::@4 to divr16u::@2 [phi:divr16u::@1/divr16u::@4->divr16u::@2]
    // [960] phi divr16u::rem#5 = divr16u::rem#0 [phi:divr16u::@1/divr16u::@4->divr16u::@2#0] -- register_copy 
    // divr16u::@2
  __b2:
    // dividend = dividend << 1
    // [961] divr16u::dividend#0 = divr16u::dividend#2 << 1 -- vwuz1=vwuz1_rol_1 
    asl.z dividend
    rol.z dividend+1
    // quotient = quotient << 1
    // [962] divr16u::quotient#1 = divr16u::quotient#3 << 1 -- vwuz1=vwuz1_rol_1 
    asl.z quotient
    rol.z quotient+1
    // if(rem>=divisor)
    // [963] if(divr16u::rem#5<divr16u::divisor#0) goto divr16u::@3 -- vwuz1_lt_vwuc1_then_la1 
    lda.z rem+1
    cmp #>divisor
    bcc __b3
    bne !+
    lda.z rem
    cmp #<divisor
    bcc __b3
  !:
    // divr16u::@5
    // quotient++;
    // [964] divr16u::quotient#2 = ++ divr16u::quotient#1 -- vwuz1=_inc_vwuz1 
    inc.z quotient
    bne !+
    inc.z quotient+1
  !:
    // rem = rem - divisor
    // [965] divr16u::rem#2 = divr16u::rem#5 - divr16u::divisor#0 -- vwuz1=vwuz1_minus_vwuc1 
    lda.z rem
    sec
    sbc #<divisor
    sta.z rem
    lda.z rem+1
    sbc #>divisor
    sta.z rem+1
    // [966] phi from divr16u::@2 divr16u::@5 to divr16u::@3 [phi:divr16u::@2/divr16u::@5->divr16u::@3]
    // [966] phi divr16u::return#0 = divr16u::quotient#1 [phi:divr16u::@2/divr16u::@5->divr16u::@3#0] -- register_copy 
    // [966] phi divr16u::rem#10 = divr16u::rem#5 [phi:divr16u::@2/divr16u::@5->divr16u::@3#1] -- register_copy 
    // divr16u::@3
  __b3:
    // for( char i : 0..15)
    // [967] divr16u::i#1 = ++ divr16u::i#2 -- vbuxx=_inc_vbuxx 
    inx
    // [968] if(divr16u::i#1!=$10) goto divr16u::@1 -- vbuxx_neq_vbuc1_then_la1 
    cpx #$10
    bne __b1
    // divr16u::@return
    // }
    // [969] return 
    rts
}
  // vera_layer_set_text_color_mode
// Set the configuration of the layer text color mode.
// - layer: Value of 0 or 1.
// - color_mode: Specifies the color mode to be VERA_LAYER_CONFIG_16 or VERA_LAYER_CONFIG_256 for text mode.
vera_layer_set_text_color_mode: {
    .label addr = $54
    // addr = vera_layer_config[layer]
    // [970] vera_layer_set_text_color_mode::addr#0 = *(vera_layer_config+vera_layer_mode_text::layer#0*SIZEOF_POINTER) -- pbuz1=_deref_qbuc1 
    lda vera_layer_config+vera_layer_mode_text.layer*SIZEOF_POINTER
    sta.z addr
    lda vera_layer_config+vera_layer_mode_text.layer*SIZEOF_POINTER+1
    sta.z addr+1
    // *addr &= ~VERA_LAYER_CONFIG_256C
    // [971] *vera_layer_set_text_color_mode::addr#0 = *vera_layer_set_text_color_mode::addr#0 & ~VERA_LAYER_CONFIG_256C -- _deref_pbuz1=_deref_pbuz1_band_vbuc1 
    lda #VERA_LAYER_CONFIG_256C^$ff
    ldy #0
    and (addr),y
    sta (addr),y
    // *addr |= color_mode
    // [972] *vera_layer_set_text_color_mode::addr#0 = *vera_layer_set_text_color_mode::addr#0 -- _deref_pbuz1=_deref_pbuz1 
    lda (addr),y
    sta (addr),y
    // vera_layer_set_text_color_mode::@return
    // }
    // [973] return 
    rts
}
  // vera_layer_get_mapbase_bank
// Get the map base bank of the tiles for the layer.
// - layer: Value of 0 or 1.
// - return: Bank in vera vram.
vera_layer_get_mapbase_bank: {
    .const layer = 1
    // return vera_mapbase_bank[layer];
    // [974] vera_layer_get_mapbase_bank::return#0 = *(vera_mapbase_bank+vera_layer_get_mapbase_bank::layer#0) -- vbuaa=_deref_pbuc1 
    lda vera_mapbase_bank+layer
    // vera_layer_get_mapbase_bank::@return
    // }
    // [975] return 
    rts
}
  // vera_layer_get_mapbase_offset
// Get the map base lower 16-bit address (offset) of the tiles for the layer.
// - layer: Value of 0 or 1.
// - return: Offset in vera vram of the specified bank.
vera_layer_get_mapbase_offset: {
    .const layer = 1
    .label return = $54
    // return vera_mapbase_offset[layer];
    // [976] vera_layer_get_mapbase_offset::return#0 = *(vera_mapbase_offset+vera_layer_get_mapbase_offset::layer#0<<1) -- vwuz1=_deref_pwuc1 
    lda vera_mapbase_offset+(layer<<1)
    sta.z return
    lda vera_mapbase_offset+(layer<<1)+1
    sta.z return+1
    // vera_layer_get_mapbase_offset::@return
    // }
    // [977] return 
    rts
}
  // vera_layer_get_rowshift
// Get the bit shift value required to skip a whole line fast.
// - layer: Value of 0 or 1.
// - return: Rowshift value to calculate fast from a y value to line offset in tile mode.
vera_layer_get_rowshift: {
    .const layer = 1
    // return vera_layer_rowshift[layer];
    // [978] vera_layer_get_rowshift::return#0 = *(vera_layer_rowshift+vera_layer_get_rowshift::layer#0) -- vbuaa=_deref_pbuc1 
    lda vera_layer_rowshift+layer
    // vera_layer_get_rowshift::@return
    // }
    // [979] return 
    rts
}
  // vera_layer_get_rowskip
// Get the value required to skip a whole line fast.
// - layer: Value of 0 or 1.
// - return: Skip value to calculate fast from a y value to line offset in tile mode.
vera_layer_get_rowskip: {
    .const layer = 1
    .label return = $54
    // return vera_layer_rowskip[layer];
    // [980] vera_layer_get_rowskip::return#0 = *(vera_layer_rowskip+vera_layer_get_rowskip::layer#0<<1) -- vwuz1=_deref_pwuc1 
    lda vera_layer_rowskip+(layer<<1)
    sta.z return
    lda vera_layer_rowskip+(layer<<1)+1
    sta.z return+1
    // vera_layer_get_rowskip::@return
    // }
    // [981] return 
    rts
}
  // vera_layer_set_config
// Set the configuration of the layer.
// - layer: Value of 0 or 1.
// - config: Specifies the modes which are specified using T256C / 'Bitmap Mode' / 'Color Depth'.
// vera_layer_set_config(byte register(A) layer, byte register(X) config)
vera_layer_set_config: {
    .label addr = $54
    // addr = vera_layer_config[layer]
    // [982] vera_layer_set_config::$0 = vera_layer_set_config::layer#0 << 1 -- vbuaa=vbuaa_rol_1 
    asl
    // [983] vera_layer_set_config::addr#0 = vera_layer_config[vera_layer_set_config::$0] -- pbuz1=qbuc1_derefidx_vbuaa 
    tay
    lda vera_layer_config,y
    sta.z addr
    lda vera_layer_config+1,y
    sta.z addr+1
    // *addr = config
    // [984] *vera_layer_set_config::addr#0 = vera_layer_set_config::config#0 -- _deref_pbuz1=vbuxx 
    txa
    ldy #0
    sta (addr),y
    // vera_layer_set_config::@return
    // }
    // [985] return 
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
    .label addr = $54
    // addr = vera_layer_tilebase[layer]
    // [986] vera_layer_set_tilebase::$0 = vera_layer_set_tilebase::layer#0 << 1 -- vbuaa=vbuaa_rol_1 
    asl
    // [987] vera_layer_set_tilebase::addr#0 = vera_layer_tilebase[vera_layer_set_tilebase::$0] -- pbuz1=qbuc1_derefidx_vbuaa 
    tay
    lda vera_layer_tilebase,y
    sta.z addr
    lda vera_layer_tilebase+1,y
    sta.z addr+1
    // *addr = tilebase
    // [988] *vera_layer_set_tilebase::addr#0 = vera_layer_set_tilebase::tilebase#0 -- _deref_pbuz1=vbuxx 
    txa
    ldy #0
    sta (addr),y
    // vera_layer_set_tilebase::@return
    // }
    // [989] return 
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
    // [990] vera_layer_get_backcolor::return#0 = vera_layer_backcolor[vera_layer_get_backcolor::layer#0] -- vbuaa=pbuc1_derefidx_vbuxx 
    lda vera_layer_backcolor,x
    // vera_layer_get_backcolor::@return
    // }
    // [991] return 
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
    // [992] vera_layer_get_textcolor::return#0 = vera_layer_textcolor[vera_layer_get_textcolor::layer#0] -- vbuaa=pbuc1_derefidx_vbuxx 
    lda vera_layer_textcolor,x
    // vera_layer_get_textcolor::@return
    // }
    // [993] return 
    rts
}
  // cx16_ram_bank
// Configure the bank of a banked ram.
// cx16_ram_bank(byte register(A) bank)
cx16_ram_bank: {
    // VIA1->PORT_A = bank
    // [995] *((byte*)VIA1+OFFSET_STRUCT_MOS6522_VIA_PORT_A) = cx16_ram_bank::bank#5 -- _deref_pbuc1=vbuaa 
    sta VIA1+OFFSET_STRUCT_MOS6522_VIA_PORT_A
    // cx16_ram_bank::@return
    // }
    // [996] return 
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
// cbm_k_setnam(byte* zp($5a) filename)
cbm_k_setnam: {
    .label filename = $5a
    .label filename_len = $6b
    .label __0 = $62
    // strlen(filename)
    // [997] strlen::str#1 = cbm_k_setnam::filename -- pbuz1=pbuz2 
    lda.z filename
    sta.z strlen.str
    lda.z filename+1
    sta.z strlen.str+1
    // [998] call strlen 
    // [1102] phi from cbm_k_setnam to strlen [phi:cbm_k_setnam->strlen]
    jsr strlen
    // strlen(filename)
    // [999] strlen::return#2 = strlen::len#2
    // cbm_k_setnam::@1
    // [1000] cbm_k_setnam::$0 = strlen::return#2
    // filename_len = (char)strlen(filename)
    // [1001] cbm_k_setnam::filename_len = (byte)cbm_k_setnam::$0 -- vbuz1=_byte_vwuz2 
    lda.z __0
    sta.z filename_len
    // asm
    // asm { ldafilename_len ldxfilename ldyfilename+1 jsrCBM_SETNAM  }
    ldx filename
    ldy filename+1
    jsr CBM_SETNAM
    // cbm_k_setnam::@return
    // }
    // [1003] return 
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
// cbm_k_setlfs(byte zp($5c) channel, byte zp($5d) device, byte zp($5e) secondary)
cbm_k_setlfs: {
    .label channel = $5c
    .label device = $5d
    .label secondary = $5e
    // asm
    // asm { ldxdevice ldachannel ldysecondary jsrCBM_SETLFS  }
    ldx device
    lda channel
    ldy secondary
    jsr CBM_SETLFS
    // cbm_k_setlfs::@return
    // }
    // [1005] return 
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
    .label status = $6c
    // status
    // [1006] cbm_k_open::status = 0 -- vbuz1=vbuc1 
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
    // [1008] cbm_k_open::return#0 = cbm_k_open::status -- vbuaa=vbuz1 
    // cbm_k_open::@return
    // }
    // [1009] cbm_k_open::return#1 = cbm_k_open::return#0
    // [1010] return 
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
// cbm_k_chkin(byte zp($5f) channel)
cbm_k_chkin: {
    .label channel = $5f
    .label status = $6d
    // status
    // [1011] cbm_k_chkin::status = 0 -- vbuz1=vbuc1 
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
    // [1013] cbm_k_chkin::return#0 = cbm_k_chkin::status -- vbuaa=vbuz1 
    // cbm_k_chkin::@return
    // }
    // [1014] cbm_k_chkin::return#1 = cbm_k_chkin::return#0
    // [1015] return 
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
    .label value = $6e
    // value
    // [1016] cbm_k_chrin::value = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z value
    // asm
    // asm { jsrCBM_CHRIN stavalue  }
    jsr CBM_CHRIN
    sta value
    // return value;
    // [1018] cbm_k_chrin::return#0 = cbm_k_chrin::value -- vbuaa=vbuz1 
    // cbm_k_chrin::@return
    // }
    // [1019] cbm_k_chrin::return#1 = cbm_k_chrin::return#0
    // [1020] return 
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
    .label status = $6f
    // status
    // [1021] cbm_k_readst::status = 0 -- vbuz1=vbuc1 
    lda #0
    sta.z status
    // asm
    // asm { jsrCBM_READST stastatus  }
    jsr CBM_READST
    sta status
    // return status;
    // [1023] cbm_k_readst::return#0 = cbm_k_readst::status -- vbuaa=vbuz1 
    // cbm_k_readst::@return
    // }
    // [1024] cbm_k_readst::return#1 = cbm_k_readst::return#0
    // [1025] return 
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
// cbm_k_close(byte zp($60) channel)
cbm_k_close: {
    .label channel = $60
    .label status = $70
    // status
    // [1026] cbm_k_close::status = 0 -- vbuz1=vbuc1 
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
    // [1028] cbm_k_close::return#0 = cbm_k_close::status -- vbuaa=vbuz1 
    // cbm_k_close::@return
    // }
    // [1029] cbm_k_close::return#1 = cbm_k_close::return#0
    // [1030] return 
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
    // [1032] return 
    rts
}
  // cputc
// Output one character at the current cursor position
// Moves the cursor forward. Scrolls the entire screen if needed
// cputc(byte zp($61) c)
cputc: {
    .label __16 = $66
    .label conio_screen_text = $62
    .label conio_map_width = $64
    .label conio_addr = $62
    .label c = $61
    // vera_layer_get_color(cx16_conio.conio_screen_layer)
    // [1034] vera_layer_get_color::layer#0 = *((byte*)&cx16_conio) -- vbuxx=_deref_pbuc1 
    ldx cx16_conio
    // [1035] call vera_layer_get_color 
    // [1108] phi from cputc to vera_layer_get_color [phi:cputc->vera_layer_get_color]
    // [1108] phi vera_layer_get_color::layer#2 = vera_layer_get_color::layer#0 [phi:cputc->vera_layer_get_color#0] -- register_copy 
    jsr vera_layer_get_color
    // vera_layer_get_color(cx16_conio.conio_screen_layer)
    // [1036] vera_layer_get_color::return#3 = vera_layer_get_color::return#2
    // cputc::@7
    // color = vera_layer_get_color(cx16_conio.conio_screen_layer)
    // [1037] cputc::color#0 = vera_layer_get_color::return#3 -- vbuxx=vbuaa 
    tax
    // conio_screen_text = cx16_conio.conio_screen_text
    // [1038] cputc::conio_screen_text#0 = *((byte**)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT) -- pbuz1=_deref_qbuc1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT
    sta.z conio_screen_text
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT+1
    sta.z conio_screen_text+1
    // conio_map_width = cx16_conio.conio_map_width
    // [1039] cputc::conio_map_width#0 = *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH) -- vwuz1=_deref_pwuc1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH
    sta.z conio_map_width
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_MAP_WIDTH+1
    sta.z conio_map_width+1
    // conio_screen_text + conio_line_text[cx16_conio.conio_screen_layer]
    // [1040] cputc::$15 = *((byte*)&cx16_conio) << 1 -- vbuaa=_deref_pbuc1_rol_1 
    lda cx16_conio
    asl
    // conio_addr = conio_screen_text + conio_line_text[cx16_conio.conio_screen_layer]
    // [1041] cputc::conio_addr#0 = cputc::conio_screen_text#0 + conio_line_text[cputc::$15] -- pbuz1=pbuz1_plus_pwuc1_derefidx_vbuaa 
    tay
    clc
    lda.z conio_addr
    adc conio_line_text,y
    sta.z conio_addr
    lda.z conio_addr+1
    adc conio_line_text+1,y
    sta.z conio_addr+1
    // conio_cursor_x[cx16_conio.conio_screen_layer] << 1
    // [1042] cputc::$2 = conio_cursor_x[*((byte*)&cx16_conio)] << 1 -- vbuaa=pbuc1_derefidx_(_deref_pbuc2)_rol_1 
    ldy cx16_conio
    lda conio_cursor_x,y
    asl
    // conio_addr += conio_cursor_x[cx16_conio.conio_screen_layer] << 1
    // [1043] cputc::conio_addr#1 = cputc::conio_addr#0 + cputc::$2 -- pbuz1=pbuz1_plus_vbuaa 
    clc
    adc.z conio_addr
    sta.z conio_addr
    bcc !+
    inc.z conio_addr+1
  !:
    // if(c=='\n')
    // [1044] if(cputc::c#3==' ') goto cputc::@1 -- vbuz1_eq_vbuc1_then_la1 
    lda #'\n'
    cmp.z c
    beq __b1
    // cputc::@2
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [1045] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    // Select DATA0
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // <conio_addr
    // [1046] cputc::$4 = < cputc::conio_addr#1 -- vbuaa=_lo_pbuz1 
    lda.z conio_addr
    // *VERA_ADDRX_L = <conio_addr
    // [1047] *VERA_ADDRX_L = cputc::$4 -- _deref_pbuc1=vbuaa 
    // Set address
    sta VERA_ADDRX_L
    // >conio_addr
    // [1048] cputc::$5 = > cputc::conio_addr#1 -- vbuaa=_hi_pbuz1 
    lda.z conio_addr+1
    // *VERA_ADDRX_M = >conio_addr
    // [1049] *VERA_ADDRX_M = cputc::$5 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // cx16_conio.conio_screen_bank | VERA_INC_1
    // [1050] cputc::$6 = *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK) | VERA_INC_1 -- vbuaa=_deref_pbuc1_bor_vbuc2 
    lda #VERA_INC_1
    ora cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_BANK
    // *VERA_ADDRX_H = cx16_conio.conio_screen_bank | VERA_INC_1
    // [1051] *VERA_ADDRX_H = cputc::$6 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_H
    // *VERA_DATA0 = c
    // [1052] *VERA_DATA0 = cputc::c#3 -- _deref_pbuc1=vbuz1 
    lda.z c
    sta VERA_DATA0
    // *VERA_DATA0 = color
    // [1053] *VERA_DATA0 = cputc::color#0 -- _deref_pbuc1=vbuxx 
    stx VERA_DATA0
    // conio_cursor_x[cx16_conio.conio_screen_layer]++;
    // [1054] conio_cursor_x[*((byte*)&cx16_conio)] = ++ conio_cursor_x[*((byte*)&cx16_conio)] -- pbuc1_derefidx_(_deref_pbuc2)=_inc_pbuc1_derefidx_(_deref_pbuc2) 
    ldx cx16_conio
    ldy cx16_conio
    lda conio_cursor_x,x
    inc
    sta conio_cursor_x,y
    // scroll_enable = conio_scroll_enable[cx16_conio.conio_screen_layer]
    // [1055] cputc::scroll_enable#0 = conio_scroll_enable[*((byte*)&cx16_conio)] -- vbuaa=pbuc1_derefidx_(_deref_pbuc2) 
    lda conio_scroll_enable,y
    // if(scroll_enable)
    // [1056] if(0!=cputc::scroll_enable#0) goto cputc::@5 -- 0_neq_vbuaa_then_la1 
    cmp #0
    bne __b5
    // cputc::@3
    // (unsigned int)conio_cursor_x[cx16_conio.conio_screen_layer] == conio_map_width
    // [1057] cputc::$16 = (word)conio_cursor_x[*((byte*)&cx16_conio)] -- vwuz1=_word_pbuc1_derefidx_(_deref_pbuc2) 
    lda conio_cursor_x,y
    sta.z __16
    lda #0
    sta.z __16+1
    // if((unsigned int)conio_cursor_x[cx16_conio.conio_screen_layer] == conio_map_width)
    // [1058] if(cputc::$16!=cputc::conio_map_width#0) goto cputc::@return -- vwuz1_neq_vwuz2_then_la1 
    cmp.z conio_map_width+1
    bne __breturn
    lda.z __16
    cmp.z conio_map_width
    bne __breturn
    // [1059] phi from cputc::@3 to cputc::@4 [phi:cputc::@3->cputc::@4]
    // cputc::@4
    // cputln()
    // [1060] call cputln 
    jsr cputln
    // cputc::@return
  __breturn:
    // }
    // [1061] return 
    rts
    // cputc::@5
  __b5:
    // if(conio_cursor_x[cx16_conio.conio_screen_layer] == cx16_conio.conio_screen_width)
    // [1062] if(conio_cursor_x[*((byte*)&cx16_conio)]!=*((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH)) goto cputc::@return -- pbuc1_derefidx_(_deref_pbuc2)_neq__deref_pbuc3_then_la1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH
    ldy cx16_conio
    cmp conio_cursor_x,y
    bne __breturn
    // [1063] phi from cputc::@5 to cputc::@6 [phi:cputc::@5->cputc::@6]
    // cputc::@6
    // cputln()
    // [1064] call cputln 
    jsr cputln
    rts
    // [1065] phi from cputc::@7 to cputc::@1 [phi:cputc::@7->cputc::@1]
    // cputc::@1
  __b1:
    // cputln()
    // [1066] call cputln 
    jsr cputln
    rts
}
  // uctoa
// Converts unsigned number value to a string representing it in RADIX format.
// If the leading digits are zero they are not included in the string.
// - value : The number to be converted to RADIX
// - buffer : receives the string representing the number and zero-termination.
// - radix : The radix to convert the number to (from the enum RADIX)
// uctoa(byte register(X) value, byte* zp($64) buffer, byte register(Y) radix)
uctoa: {
    .label buffer = $64
    .label digit = $3c
    .label started = $3d
    .label max_digits = $3b
    .label digit_values = $62
    // if(radix==DECIMAL)
    // [1067] if(uctoa::radix#0==DECIMAL) goto uctoa::@1 -- vbuyy_eq_vbuc1_then_la1 
    cpy #DECIMAL
    beq __b2
    // uctoa::@2
    // if(radix==HEXADECIMAL)
    // [1068] if(uctoa::radix#0==HEXADECIMAL) goto uctoa::@1 -- vbuyy_eq_vbuc1_then_la1 
    cpy #HEXADECIMAL
    beq __b3
    // uctoa::@3
    // if(radix==OCTAL)
    // [1069] if(uctoa::radix#0==OCTAL) goto uctoa::@1 -- vbuyy_eq_vbuc1_then_la1 
    cpy #OCTAL
    beq __b4
    // uctoa::@4
    // if(radix==BINARY)
    // [1070] if(uctoa::radix#0==BINARY) goto uctoa::@1 -- vbuyy_eq_vbuc1_then_la1 
    cpy #BINARY
    beq __b5
    // uctoa::@5
    // *buffer++ = 'e'
    // [1071] *((byte*)&printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS) = 'e' -- _deref_pbuc1=vbuc2 
    // Unknown radix
    lda #'e'
    sta printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS
    // *buffer++ = 'r'
    // [1072] *((byte*)&printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS+1) = 'r' -- _deref_pbuc1=vbuc2 
    lda #'r'
    sta printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS+1
    // [1073] *((byte*)&printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS+2) = 'r' -- _deref_pbuc1=vbuc2 
    sta printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS+2
    // *buffer = 0
    // [1074] *((byte*)&printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS+3) = 0 -- _deref_pbuc1=vbuc2 
    lda #0
    sta printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS+3
    // uctoa::@return
    // }
    // [1075] return 
    rts
    // [1076] phi from uctoa to uctoa::@1 [phi:uctoa->uctoa::@1]
  __b2:
    // [1076] phi uctoa::digit_values#8 = RADIX_DECIMAL_VALUES_CHAR [phi:uctoa->uctoa::@1#0] -- pbuz1=pbuc1 
    lda #<RADIX_DECIMAL_VALUES_CHAR
    sta.z digit_values
    lda #>RADIX_DECIMAL_VALUES_CHAR
    sta.z digit_values+1
    // [1076] phi uctoa::max_digits#7 = 3 [phi:uctoa->uctoa::@1#1] -- vbuz1=vbuc1 
    lda #3
    sta.z max_digits
    jmp __b1
    // [1076] phi from uctoa::@2 to uctoa::@1 [phi:uctoa::@2->uctoa::@1]
  __b3:
    // [1076] phi uctoa::digit_values#8 = RADIX_HEXADECIMAL_VALUES_CHAR [phi:uctoa::@2->uctoa::@1#0] -- pbuz1=pbuc1 
    lda #<RADIX_HEXADECIMAL_VALUES_CHAR
    sta.z digit_values
    lda #>RADIX_HEXADECIMAL_VALUES_CHAR
    sta.z digit_values+1
    // [1076] phi uctoa::max_digits#7 = 2 [phi:uctoa::@2->uctoa::@1#1] -- vbuz1=vbuc1 
    lda #2
    sta.z max_digits
    jmp __b1
    // [1076] phi from uctoa::@3 to uctoa::@1 [phi:uctoa::@3->uctoa::@1]
  __b4:
    // [1076] phi uctoa::digit_values#8 = RADIX_OCTAL_VALUES_CHAR [phi:uctoa::@3->uctoa::@1#0] -- pbuz1=pbuc1 
    lda #<RADIX_OCTAL_VALUES_CHAR
    sta.z digit_values
    lda #>RADIX_OCTAL_VALUES_CHAR
    sta.z digit_values+1
    // [1076] phi uctoa::max_digits#7 = 3 [phi:uctoa::@3->uctoa::@1#1] -- vbuz1=vbuc1 
    lda #3
    sta.z max_digits
    jmp __b1
    // [1076] phi from uctoa::@4 to uctoa::@1 [phi:uctoa::@4->uctoa::@1]
  __b5:
    // [1076] phi uctoa::digit_values#8 = RADIX_BINARY_VALUES_CHAR [phi:uctoa::@4->uctoa::@1#0] -- pbuz1=pbuc1 
    lda #<RADIX_BINARY_VALUES_CHAR
    sta.z digit_values
    lda #>RADIX_BINARY_VALUES_CHAR
    sta.z digit_values+1
    // [1076] phi uctoa::max_digits#7 = 8 [phi:uctoa::@4->uctoa::@1#1] -- vbuz1=vbuc1 
    lda #8
    sta.z max_digits
    // uctoa::@1
  __b1:
    // [1077] phi from uctoa::@1 to uctoa::@6 [phi:uctoa::@1->uctoa::@6]
    // [1077] phi uctoa::buffer#11 = (byte*)&printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS [phi:uctoa::@1->uctoa::@6#0] -- pbuz1=pbuc1 
    lda #<printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS
    sta.z buffer
    lda #>printf_buffer+OFFSET_STRUCT_PRINTF_BUFFER_NUMBER_DIGITS
    sta.z buffer+1
    // [1077] phi uctoa::started#2 = 0 [phi:uctoa::@1->uctoa::@6#1] -- vbuz1=vbuc1 
    lda #0
    sta.z started
    // [1077] phi uctoa::value#2 = uctoa::value#1 [phi:uctoa::@1->uctoa::@6#2] -- register_copy 
    // [1077] phi uctoa::digit#2 = 0 [phi:uctoa::@1->uctoa::@6#3] -- vbuz1=vbuc1 
    sta.z digit
    // uctoa::@6
  __b6:
    // max_digits-1
    // [1078] uctoa::$4 = uctoa::max_digits#7 - 1 -- vbuaa=vbuz1_minus_1 
    lda.z max_digits
    sec
    sbc #1
    // for( char digit=0; digit<max_digits-1; digit++ )
    // [1079] if(uctoa::digit#2<uctoa::$4) goto uctoa::@7 -- vbuz1_lt_vbuaa_then_la1 
    cmp.z digit
    beq !+
    bcs __b7
  !:
    // uctoa::@8
    // *buffer++ = DIGITS[(char)value]
    // [1080] *uctoa::buffer#11 = DIGITS[uctoa::value#2] -- _deref_pbuz1=pbuc1_derefidx_vbuxx 
    lda DIGITS,x
    ldy #0
    sta (buffer),y
    // *buffer++ = DIGITS[(char)value];
    // [1081] uctoa::buffer#3 = ++ uctoa::buffer#11 -- pbuz1=_inc_pbuz1 
    inc.z buffer
    bne !+
    inc.z buffer+1
  !:
    // *buffer = 0
    // [1082] *uctoa::buffer#3 = 0 -- _deref_pbuz1=vbuc1 
    lda #0
    tay
    sta (buffer),y
    rts
    // uctoa::@7
  __b7:
    // digit_value = digit_values[digit]
    // [1083] uctoa::digit_value#0 = uctoa::digit_values#8[uctoa::digit#2] -- vbuyy=pbuz1_derefidx_vbuz2 
    ldy.z digit
    lda (digit_values),y
    tay
    // if (started || value >= digit_value)
    // [1084] if(0!=uctoa::started#2) goto uctoa::@10 -- 0_neq_vbuz1_then_la1 
    lda.z started
    cmp #0
    bne __b10
    // uctoa::@12
    // [1085] if(uctoa::value#2>=uctoa::digit_value#0) goto uctoa::@10 -- vbuxx_ge_vbuyy_then_la1 
    sty.z $ff
    cpx.z $ff
    bcs __b10
    // [1086] phi from uctoa::@12 to uctoa::@9 [phi:uctoa::@12->uctoa::@9]
    // [1086] phi uctoa::buffer#14 = uctoa::buffer#11 [phi:uctoa::@12->uctoa::@9#0] -- register_copy 
    // [1086] phi uctoa::started#4 = uctoa::started#2 [phi:uctoa::@12->uctoa::@9#1] -- register_copy 
    // [1086] phi uctoa::value#6 = uctoa::value#2 [phi:uctoa::@12->uctoa::@9#2] -- register_copy 
    // uctoa::@9
  __b9:
    // for( char digit=0; digit<max_digits-1; digit++ )
    // [1087] uctoa::digit#1 = ++ uctoa::digit#2 -- vbuz1=_inc_vbuz1 
    inc.z digit
    // [1077] phi from uctoa::@9 to uctoa::@6 [phi:uctoa::@9->uctoa::@6]
    // [1077] phi uctoa::buffer#11 = uctoa::buffer#14 [phi:uctoa::@9->uctoa::@6#0] -- register_copy 
    // [1077] phi uctoa::started#2 = uctoa::started#4 [phi:uctoa::@9->uctoa::@6#1] -- register_copy 
    // [1077] phi uctoa::value#2 = uctoa::value#6 [phi:uctoa::@9->uctoa::@6#2] -- register_copy 
    // [1077] phi uctoa::digit#2 = uctoa::digit#1 [phi:uctoa::@9->uctoa::@6#3] -- register_copy 
    jmp __b6
    // uctoa::@10
  __b10:
    // uctoa_append(buffer++, value, digit_value)
    // [1088] uctoa_append::buffer#0 = uctoa::buffer#11 -- pbuz1=pbuz2 
    lda.z buffer
    sta.z uctoa_append.buffer
    lda.z buffer+1
    sta.z uctoa_append.buffer+1
    // [1089] uctoa_append::value#0 = uctoa::value#2
    // [1090] uctoa_append::sub#0 = uctoa::digit_value#0 -- vbuz1=vbuyy 
    sty.z uctoa_append.sub
    // [1091] call uctoa_append 
    // [1127] phi from uctoa::@10 to uctoa_append [phi:uctoa::@10->uctoa_append]
    jsr uctoa_append
    // uctoa_append(buffer++, value, digit_value)
    // [1092] uctoa_append::return#0 = uctoa_append::value#2
    // uctoa::@11
    // value = uctoa_append(buffer++, value, digit_value)
    // [1093] uctoa::value#0 = uctoa_append::return#0
    // value = uctoa_append(buffer++, value, digit_value);
    // [1094] uctoa::buffer#4 = ++ uctoa::buffer#11 -- pbuz1=_inc_pbuz1 
    inc.z buffer
    bne !+
    inc.z buffer+1
  !:
    // [1086] phi from uctoa::@11 to uctoa::@9 [phi:uctoa::@11->uctoa::@9]
    // [1086] phi uctoa::buffer#14 = uctoa::buffer#4 [phi:uctoa::@11->uctoa::@9#0] -- register_copy 
    // [1086] phi uctoa::started#4 = 1 [phi:uctoa::@11->uctoa::@9#1] -- vbuz1=vbuc1 
    lda #1
    sta.z started
    // [1086] phi uctoa::value#6 = uctoa::value#0 [phi:uctoa::@11->uctoa::@9#2] -- register_copy 
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
    // [1096] if(0==printf_number_buffer::buffer_sign#0) goto printf_number_buffer::@2 -- 0_eq_vbuaa_then_la1 
    cmp #0
    beq __b2
    // printf_number_buffer::@3
    // cputc(buffer.sign)
    // [1097] cputc::c#2 = printf_number_buffer::buffer_sign#0 -- vbuz1=vbuaa 
    sta.z cputc.c
    // [1098] call cputc 
    // [1033] phi from printf_number_buffer::@3 to cputc [phi:printf_number_buffer::@3->cputc]
    // [1033] phi cputc::c#3 = cputc::c#2 [phi:printf_number_buffer::@3->cputc#0] -- register_copy 
    jsr cputc
    // [1099] phi from printf_number_buffer::@1 printf_number_buffer::@3 to printf_number_buffer::@2 [phi:printf_number_buffer::@1/printf_number_buffer::@3->printf_number_buffer::@2]
    // printf_number_buffer::@2
  __b2:
    // cputs(buffer.digits)
    // [1100] call cputs 
    // [589] phi from printf_number_buffer::@2 to cputs [phi:printf_number_buffer::@2->cputs]
    // [589] phi cputs::s#16 = printf_number_buffer::buffer_digits#0 [phi:printf_number_buffer::@2->cputs#0] -- pbuz1=pbuc1 
    lda #<buffer_digits
    sta.z cputs.s
    lda #>buffer_digits
    sta.z cputs.s+1
    jsr cputs
    // printf_number_buffer::@return
    // }
    // [1101] return 
    rts
}
  // strlen
// Computes the length of the string str up to but not including the terminating null character.
// strlen(byte* zp($64) str)
strlen: {
    .label len = $62
    .label str = $64
    .label return = $62
    // [1103] phi from strlen to strlen::@1 [phi:strlen->strlen::@1]
    // [1103] phi strlen::len#2 = 0 [phi:strlen->strlen::@1#0] -- vwuz1=vwuc1 
    lda #<0
    sta.z len
    sta.z len+1
    // [1103] phi strlen::str#3 = strlen::str#1 [phi:strlen->strlen::@1#1] -- register_copy 
    // strlen::@1
  __b1:
    // while(*str)
    // [1104] if(0!=*strlen::str#3) goto strlen::@2 -- 0_neq__deref_pbuz1_then_la1 
    ldy #0
    lda (str),y
    cmp #0
    bne __b2
    // strlen::@return
    // }
    // [1105] return 
    rts
    // strlen::@2
  __b2:
    // len++;
    // [1106] strlen::len#1 = ++ strlen::len#2 -- vwuz1=_inc_vwuz1 
    inc.z len
    bne !+
    inc.z len+1
  !:
    // str++;
    // [1107] strlen::str#0 = ++ strlen::str#3 -- pbuz1=_inc_pbuz1 
    inc.z str
    bne !+
    inc.z str+1
  !:
    // [1103] phi from strlen::@2 to strlen::@1 [phi:strlen::@2->strlen::@1]
    // [1103] phi strlen::len#2 = strlen::len#1 [phi:strlen::@2->strlen::@1#0] -- register_copy 
    // [1103] phi strlen::str#3 = strlen::str#0 [phi:strlen::@2->strlen::@1#1] -- register_copy 
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
    .label addr = $62
    // addr = vera_layer_config[layer]
    // [1109] vera_layer_get_color::$3 = vera_layer_get_color::layer#2 << 1 -- vbuaa=vbuxx_rol_1 
    txa
    asl
    // [1110] vera_layer_get_color::addr#0 = vera_layer_config[vera_layer_get_color::$3] -- pbuz1=qbuc1_derefidx_vbuaa 
    tay
    lda vera_layer_config,y
    sta.z addr
    lda vera_layer_config+1,y
    sta.z addr+1
    // *addr & VERA_LAYER_CONFIG_256C
    // [1111] vera_layer_get_color::$0 = *vera_layer_get_color::addr#0 & VERA_LAYER_CONFIG_256C -- vbuaa=_deref_pbuz1_band_vbuc1 
    lda #VERA_LAYER_CONFIG_256C
    ldy #0
    and (addr),y
    // if( *addr & VERA_LAYER_CONFIG_256C )
    // [1112] if(0!=vera_layer_get_color::$0) goto vera_layer_get_color::@1 -- 0_neq_vbuaa_then_la1 
    cmp #0
    bne __b1
    // vera_layer_get_color::@2
    // vera_layer_backcolor[layer] << 4
    // [1113] vera_layer_get_color::$1 = vera_layer_backcolor[vera_layer_get_color::layer#2] << 4 -- vbuaa=pbuc1_derefidx_vbuxx_rol_4 
    lda vera_layer_backcolor,x
    asl
    asl
    asl
    asl
    // return ((vera_layer_backcolor[layer] << 4) | vera_layer_textcolor[layer]);
    // [1114] vera_layer_get_color::return#1 = vera_layer_get_color::$1 | vera_layer_textcolor[vera_layer_get_color::layer#2] -- vbuaa=vbuaa_bor_pbuc1_derefidx_vbuxx 
    ora vera_layer_textcolor,x
    // [1115] phi from vera_layer_get_color::@1 vera_layer_get_color::@2 to vera_layer_get_color::@return [phi:vera_layer_get_color::@1/vera_layer_get_color::@2->vera_layer_get_color::@return]
    // [1115] phi vera_layer_get_color::return#2 = vera_layer_get_color::return#0 [phi:vera_layer_get_color::@1/vera_layer_get_color::@2->vera_layer_get_color::@return#0] -- register_copy 
    // vera_layer_get_color::@return
    // }
    // [1116] return 
    rts
    // vera_layer_get_color::@1
  __b1:
    // return (vera_layer_textcolor[layer]);
    // [1117] vera_layer_get_color::return#0 = vera_layer_textcolor[vera_layer_get_color::layer#2] -- vbuaa=pbuc1_derefidx_vbuxx 
    lda vera_layer_textcolor,x
    rts
}
  // cputln
// Print a newline
cputln: {
    .label temp = $62
    // temp = conio_line_text[cx16_conio.conio_screen_layer]
    // [1118] cputln::$2 = *((byte*)&cx16_conio) << 1 -- vbuaa=_deref_pbuc1_rol_1 
    lda cx16_conio
    asl
    // [1119] cputln::temp#0 = conio_line_text[cputln::$2] -- vwuz1=pwuc1_derefidx_vbuaa 
    // TODO: This needs to be optimized! other variations don't compile because of sections not available!
    tay
    lda conio_line_text,y
    sta.z temp
    lda conio_line_text+1,y
    sta.z temp+1
    // temp += cx16_conio.conio_rowskip
    // [1120] cputln::temp#1 = cputln::temp#0 + *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP) -- vwuz1=vwuz1_plus__deref_pwuc1 
    clc
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP
    adc.z temp
    sta.z temp
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP+1
    adc.z temp+1
    sta.z temp+1
    // conio_line_text[cx16_conio.conio_screen_layer] = temp
    // [1121] cputln::$3 = *((byte*)&cx16_conio) << 1 -- vbuaa=_deref_pbuc1_rol_1 
    lda cx16_conio
    asl
    // [1122] conio_line_text[cputln::$3] = cputln::temp#1 -- pwuc1_derefidx_vbuaa=vwuz1 
    tay
    lda.z temp
    sta conio_line_text,y
    lda.z temp+1
    sta conio_line_text+1,y
    // conio_cursor_x[cx16_conio.conio_screen_layer] = 0
    // [1123] conio_cursor_x[*((byte*)&cx16_conio)] = 0 -- pbuc1_derefidx_(_deref_pbuc2)=vbuc3 
    lda #0
    ldy cx16_conio
    sta conio_cursor_x,y
    // conio_cursor_y[cx16_conio.conio_screen_layer]++;
    // [1124] conio_cursor_y[*((byte*)&cx16_conio)] = ++ conio_cursor_y[*((byte*)&cx16_conio)] -- pbuc1_derefidx_(_deref_pbuc2)=_inc_pbuc1_derefidx_(_deref_pbuc2) 
    ldx cx16_conio
    lda conio_cursor_y,x
    inc
    sta conio_cursor_y,y
    // cscroll()
    // [1125] call cscroll 
    jsr cscroll
    // cputln::@return
    // }
    // [1126] return 
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
// uctoa_append(byte* zp($71) buffer, byte register(X) value, byte zp($61) sub)
uctoa_append: {
    .label buffer = $71
    .label sub = $61
    // [1128] phi from uctoa_append to uctoa_append::@1 [phi:uctoa_append->uctoa_append::@1]
    // [1128] phi uctoa_append::digit#2 = 0 [phi:uctoa_append->uctoa_append::@1#0] -- vbuyy=vbuc1 
    ldy #0
    // [1128] phi uctoa_append::value#2 = uctoa_append::value#0 [phi:uctoa_append->uctoa_append::@1#1] -- register_copy 
    // uctoa_append::@1
  __b1:
    // while (value >= sub)
    // [1129] if(uctoa_append::value#2>=uctoa_append::sub#0) goto uctoa_append::@2 -- vbuxx_ge_vbuz1_then_la1 
    cpx.z sub
    bcs __b2
    // uctoa_append::@3
    // *buffer = DIGITS[digit]
    // [1130] *uctoa_append::buffer#0 = DIGITS[uctoa_append::digit#2] -- _deref_pbuz1=pbuc1_derefidx_vbuyy 
    lda DIGITS,y
    ldy #0
    sta (buffer),y
    // uctoa_append::@return
    // }
    // [1131] return 
    rts
    // uctoa_append::@2
  __b2:
    // digit++;
    // [1132] uctoa_append::digit#1 = ++ uctoa_append::digit#2 -- vbuyy=_inc_vbuyy 
    iny
    // value -= sub
    // [1133] uctoa_append::value#1 = uctoa_append::value#2 - uctoa_append::sub#0 -- vbuxx=vbuxx_minus_vbuz1 
    txa
    sec
    sbc.z sub
    tax
    // [1128] phi from uctoa_append::@2 to uctoa_append::@1 [phi:uctoa_append::@2->uctoa_append::@1]
    // [1128] phi uctoa_append::digit#2 = uctoa_append::digit#1 [phi:uctoa_append::@2->uctoa_append::@1#0] -- register_copy 
    // [1128] phi uctoa_append::value#2 = uctoa_append::value#1 [phi:uctoa_append::@2->uctoa_append::@1#1] -- register_copy 
    jmp __b1
}
  // cscroll
// Scroll the entire screen if the cursor is beyond the last line
cscroll: {
    // if(conio_cursor_y[cx16_conio.conio_screen_layer]>=cx16_conio.conio_screen_height)
    // [1134] if(conio_cursor_y[*((byte*)&cx16_conio)]<*((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT)) goto cscroll::@return -- pbuc1_derefidx_(_deref_pbuc2)_lt__deref_pbuc3_then_la1 
    ldy cx16_conio
    lda conio_cursor_y,y
    cmp cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT
    bcc __b3
    // cscroll::@1
    // if(conio_scroll_enable[cx16_conio.conio_screen_layer])
    // [1135] if(0!=conio_scroll_enable[*((byte*)&cx16_conio)]) goto cscroll::@4 -- 0_neq_pbuc1_derefidx_(_deref_pbuc2)_then_la1 
    lda conio_scroll_enable,y
    cmp #0
    bne __b4
    // cscroll::@2
    // if(conio_cursor_y[cx16_conio.conio_screen_layer]>=cx16_conio.conio_screen_height)
    // [1136] if(conio_cursor_y[*((byte*)&cx16_conio)]<*((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT)) goto cscroll::@return -- pbuc1_derefidx_(_deref_pbuc2)_lt__deref_pbuc3_then_la1 
    lda conio_cursor_y,y
    cmp cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT
    // [1137] phi from cscroll::@2 to cscroll::@3 [phi:cscroll::@2->cscroll::@3]
    // cscroll::@3
  __b3:
    // cscroll::@return
    // }
    // [1138] return 
    rts
    // [1139] phi from cscroll::@1 to cscroll::@4 [phi:cscroll::@1->cscroll::@4]
    // cscroll::@4
  __b4:
    // insertup()
    // [1140] call insertup 
    jsr insertup
    // cscroll::@5
    // gotoxy( 0, cx16_conio.conio_screen_height-1)
    // [1141] gotoxy::y#2 = *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT) - 1 -- vbuxx=_deref_pbuc1_minus_1 
    ldx cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_HEIGHT
    dex
    // [1142] call gotoxy 
    // [403] phi from cscroll::@5 to gotoxy [phi:cscroll::@5->gotoxy]
    // [403] phi gotoxy::y#3 = gotoxy::y#2 [phi:cscroll::@5->gotoxy#0] -- register_copy 
    jsr gotoxy
    rts
}
  // insertup
// Insert a new line, and scroll the upper part of the screen up.
insertup: {
    .label cy = $61
    .label width = $73
    .label line = $62
    .label start = $62
    // cy = conio_cursor_y[cx16_conio.conio_screen_layer]
    // [1143] insertup::cy#0 = conio_cursor_y[*((byte*)&cx16_conio)] -- vbuz1=pbuc1_derefidx_(_deref_pbuc2) 
    ldy cx16_conio
    lda conio_cursor_y,y
    sta.z cy
    // width = cx16_conio.conio_screen_width * 2
    // [1144] insertup::width#0 = *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH) << 1 -- vbuz1=_deref_pbuc1_rol_1 
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH
    asl
    sta.z width
    // [1145] phi from insertup to insertup::@1 [phi:insertup->insertup::@1]
    // [1145] phi insertup::i#2 = 1 [phi:insertup->insertup::@1#0] -- vbuxx=vbuc1 
    ldx #1
    // insertup::@1
  __b1:
    // for(unsigned byte i=1; i<=cy; i++)
    // [1146] if(insertup::i#2<=insertup::cy#0) goto insertup::@2 -- vbuxx_le_vbuz1_then_la1 
    lda.z cy
    stx.z $ff
    cmp.z $ff
    bcs __b2
    // [1147] phi from insertup::@1 to insertup::@3 [phi:insertup::@1->insertup::@3]
    // insertup::@3
    // clearline()
    // [1148] call clearline 
    jsr clearline
    // insertup::@return
    // }
    // [1149] return 
    rts
    // insertup::@2
  __b2:
    // i-1
    // [1150] insertup::$3 = insertup::i#2 - 1 -- vbuaa=vbuxx_minus_1 
    txa
    sec
    sbc #1
    // line = (i-1) << cx16_conio.conio_rowshift
    // [1151] insertup::line#0 = insertup::$3 << *((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSHIFT) -- vwuz1=vbuaa_rol__deref_pbuc1 
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
    // [1152] insertup::start#0 = *((byte**)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT) + insertup::line#0 -- pbuz1=_deref_qbuc1_plus_vwuz1 
    clc
    lda.z start
    adc cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT
    sta.z start
    lda.z start+1
    adc cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT+1
    sta.z start+1
    // start+cx16_conio.conio_rowskip
    // [1153] memcpy_in_vram::src#0 = insertup::start#0 + *((word*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP) -- pbuz1=pbuz2_plus__deref_pwuc1 
    clc
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP
    adc.z start
    sta.z memcpy_in_vram.src
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_ROWSKIP+1
    adc.z start+1
    sta.z memcpy_in_vram.src+1
    // memcpy_in_vram(0, start, VERA_INC_1,  0, start+cx16_conio.conio_rowskip, VERA_INC_1, width)
    // [1154] memcpy_in_vram::dest#0 = (void*)insertup::start#0 -- pvoz1=pvoz2 
    lda.z start
    sta.z memcpy_in_vram.dest
    lda.z start+1
    sta.z memcpy_in_vram.dest+1
    // [1155] memcpy_in_vram::num#0 = insertup::width#0 -- vwuz1=vbuz2 
    lda.z width
    sta.z memcpy_in_vram.num
    lda #0
    sta.z memcpy_in_vram.num+1
    // [1156] memcpy_in_vram::src#4 = (void*)memcpy_in_vram::src#0
    // memcpy_in_vram(0, start, VERA_INC_1,  0, start+cx16_conio.conio_rowskip, VERA_INC_1, width)
    // [1157] call memcpy_in_vram 
    // [264] phi from insertup::@2 to memcpy_in_vram [phi:insertup::@2->memcpy_in_vram]
    // [264] phi memcpy_in_vram::num#4 = memcpy_in_vram::num#0 [phi:insertup::@2->memcpy_in_vram#0] -- register_copy 
    // [264] phi memcpy_in_vram::dest_bank#3 = 0 [phi:insertup::@2->memcpy_in_vram#1] -- vbuz1=vbuc1 
    sta.z memcpy_in_vram.dest_bank
    // [264] phi memcpy_in_vram::dest#3 = memcpy_in_vram::dest#0 [phi:insertup::@2->memcpy_in_vram#2] -- register_copy 
    // [264] phi memcpy_in_vram::src_bank#3 = 0 [phi:insertup::@2->memcpy_in_vram#3] -- vbuyy=vbuc1 
    tay
    // [264] phi memcpy_in_vram::src#3 = memcpy_in_vram::src#4 [phi:insertup::@2->memcpy_in_vram#4] -- register_copy 
    jsr memcpy_in_vram
    // insertup::@4
    // for(unsigned byte i=1; i<=cy; i++)
    // [1158] insertup::i#1 = ++ insertup::i#2 -- vbuxx=_inc_vbuxx 
    inx
    // [1145] phi from insertup::@4 to insertup::@1 [phi:insertup::@4->insertup::@1]
    // [1145] phi insertup::i#2 = insertup::i#1 [phi:insertup::@4->insertup::@1#0] -- register_copy 
    jmp __b1
}
  // clearline
clearline: {
    .label conio_line = $66
    .label addr = $66
    .label c = $62
    // *VERA_CTRL &= ~VERA_ADDRSEL
    // [1159] *VERA_CTRL = *VERA_CTRL & ~VERA_ADDRSEL -- _deref_pbuc1=_deref_pbuc1_band_vbuc2 
    // Select DATA0
    lda #VERA_ADDRSEL^$ff
    and VERA_CTRL
    sta VERA_CTRL
    // conio_line = conio_line_text[cx16_conio.conio_screen_layer]
    // [1160] clearline::$5 = *((byte*)&cx16_conio) << 1 -- vbuaa=_deref_pbuc1_rol_1 
    lda cx16_conio
    asl
    // [1161] clearline::conio_line#0 = conio_line_text[clearline::$5] -- vwuz1=pwuc1_derefidx_vbuaa 
    tay
    lda conio_line_text,y
    sta.z conio_line
    lda conio_line_text+1,y
    sta.z conio_line+1
    // conio_screen_text + conio_line
    // [1162] clearline::addr#0 = (word)*((byte**)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT) + clearline::conio_line#0 -- vwuz1=_deref_pwuc1_plus_vwuz1 
    clc
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT
    adc.z addr
    sta.z addr
    lda cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_TEXT+1
    adc.z addr+1
    sta.z addr+1
    // <addr
    // [1163] clearline::$1 = < (byte*)clearline::addr#0 -- vbuaa=_lo_pbuz1 
    lda.z addr
    // *VERA_ADDRX_L = <addr
    // [1164] *VERA_ADDRX_L = clearline::$1 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_L
    // >addr
    // [1165] clearline::$2 = > (byte*)clearline::addr#0 -- vbuaa=_hi_pbuz1 
    lda.z addr+1
    // *VERA_ADDRX_M = >addr
    // [1166] *VERA_ADDRX_M = clearline::$2 -- _deref_pbuc1=vbuaa 
    sta VERA_ADDRX_M
    // *VERA_ADDRX_H = VERA_INC_1
    // [1167] *VERA_ADDRX_H = VERA_INC_1 -- _deref_pbuc1=vbuc2 
    lda #VERA_INC_1
    sta VERA_ADDRX_H
    // vera_layer_get_color(cx16_conio.conio_screen_layer)
    // [1168] vera_layer_get_color::layer#1 = *((byte*)&cx16_conio) -- vbuxx=_deref_pbuc1 
    ldx cx16_conio
    // [1169] call vera_layer_get_color 
    // [1108] phi from clearline to vera_layer_get_color [phi:clearline->vera_layer_get_color]
    // [1108] phi vera_layer_get_color::layer#2 = vera_layer_get_color::layer#1 [phi:clearline->vera_layer_get_color#0] -- register_copy 
    jsr vera_layer_get_color
    // vera_layer_get_color(cx16_conio.conio_screen_layer)
    // [1170] vera_layer_get_color::return#4 = vera_layer_get_color::return#2
    // clearline::@4
    // color = vera_layer_get_color(cx16_conio.conio_screen_layer)
    // [1171] clearline::color#0 = vera_layer_get_color::return#4 -- vbuxx=vbuaa 
    tax
    // [1172] phi from clearline::@4 to clearline::@1 [phi:clearline::@4->clearline::@1]
    // [1172] phi clearline::c#2 = 0 [phi:clearline::@4->clearline::@1#0] -- vwuz1=vwuc1 
    lda #<0
    sta.z c
    sta.z c+1
    // clearline::@1
  __b1:
    // for( unsigned int c=0;c<cx16_conio.conio_screen_width; c++ )
    // [1173] if(clearline::c#2<*((byte*)&cx16_conio+OFFSET_STRUCT_CX16_CONIO_CONIO_SCREEN_WIDTH)) goto clearline::@2 -- vwuz1_lt__deref_pbuc1_then_la1 
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
    // [1174] conio_cursor_x[*((byte*)&cx16_conio)] = 0 -- pbuc1_derefidx_(_deref_pbuc2)=vbuc3 
    lda #0
    ldy cx16_conio
    sta conio_cursor_x,y
    // clearline::@return
    // }
    // [1175] return 
    rts
    // clearline::@2
  __b2:
    // *VERA_DATA0 = ' '
    // [1176] *VERA_DATA0 = ' ' -- _deref_pbuc1=vbuc2 
    // Set data
    lda #' '
    sta VERA_DATA0
    // *VERA_DATA0 = color
    // [1177] *VERA_DATA0 = clearline::color#0 -- _deref_pbuc1=vbuxx 
    stx VERA_DATA0
    // for( unsigned int c=0;c<cx16_conio.conio_screen_width; c++ )
    // [1178] clearline::c#1 = ++ clearline::c#2 -- vwuz1=_inc_vwuz1 
    inc.z c
    bne !+
    inc.z c+1
  !:
    // [1172] phi from clearline::@2 to clearline::@1 [phi:clearline::@2->clearline::@1]
    // [1172] phi clearline::c#2 = clearline::c#1 [phi:clearline::@2->clearline::@1#0] -- register_copy 
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
  PlayerSprites: .fill 4*NUM_PLAYER, 0
  Enemy2Sprites: .fill 4*NUM_ENEMY2, 0
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

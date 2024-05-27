INCLUDE "src/main/utils/hardware.inc"
INCLUDE "src/main/utils/macros/text-macros.inc"

SECTION "StoryStateASM", ROM0

InitStoryState::

    ; Turn the LCD on
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJ16
    ld [rLCDC], a

    ret

Story:
    .Line1 db "the galactic empire", 255
    .Line2 db "rules the galaxy", 255
    .Line3 db "with an iron", 255
    .Line4 db "fist.", 255
    .Line5 db "the rebel forces", 255
    .Line6 db "remain hopeful of", 255
    .Line7 db "freedoms light.", 255

UpdateStoryState::
    call ClearBackground

    ld de, $9821
    ld hl, Story.Line1
    call DrawText_WithTypewriterEffect

    ld de, $9861
    ld hl, Story.Line2
    call DrawText_WithTypewriterEffect

    ld de, $98A1
    ld hl, Story.Line3
    call DrawText_WithTypewriterEffect

    ld de, $98E1
    ld hl, Story.Line4
    call DrawText_WithTypewriterEffect

    ; Wait for A
    ld a, PADF_A
    ld [mWaitKey], a

    call WaitForKeyFunction

    call ClearBackground

    ld de, $9821
    ld hl, Story.Line5
    call DrawText_WithTypewriterEffect

    ld de, $9861
    ld hl, Story.Line6
    call DrawText_WithTypewriterEffect

    ld de, $98A1
    ld hl, Story.Line7
    call DrawText_WithTypewriterEffect

    ; Wait for A
    ld a, PADF_A
    ld [mWaitKey], a

    call WaitForKeyFunction

    ld a, 2
    ld [wGameState], a
    jp NextGameState
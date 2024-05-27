INCLUDE "src/main/utils/hardware.inc"
INCLUDE "src/main/utils/macros/text-macros.inc"

SECTION "TitleScreenState", ROM0

wPressPlayText:: db "press a to play", 255

titleScreenTileData: INCBIN "src/generated/backgrounds/title-screen.2bpp"
titleScreenTileDataEnd:

titleScreenTileMap: INCBIN "src/generated/backgrounds/title-screen.tilemap"
titleScreenTileMapEnd:

InitTitleScreenState::
    call DrawTitleScreen

    ; Call our functino that draws text onto background/window tiles
    ld de, $99C3
    ld hl, wPressPlayText
    call DrawTextTilesLoop

    ; Turn the LCD on
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON | LCDCF_OBJ16
    ld [rLCDC], a

    ret

DrawTextTilesLoop:
    ; Check for the end of string character 255
    ld a, [hl]
    cp 255
    ret z

    ; Write the current character (in hl) to the address
    ; on the tilemap (in de)
    ld a, [hl]
    ld [de], a

    ; Move to the next character and background tile
    inc hl
    inc de

    jp DrawTextTilesLoop

DrawTitleScreen::
    ; Copy the tile data
    ld de, titleScreenTileData
    ld hl, $9340
    ld bc, titleScreenTileDataEnd - titleScreenTileData
    call CopyDEintoMemoryAtHL

    ; Copy the tile map
    ld de, titleScreenTileMap
    ld hl, $9800
    ld bc, titleScreenTileMapEnd - titleScreenTileMap
    jp CopyDEintoMemoryAtHL_With52Offset

UpdateTitleScreenState::
    ; Save the pressed value into the variable: mWaitKey
    ; The WaitForKeyFunction always checks against this variable
    ld a, PADF_A
    ld [mWaitKey], a

    call WaitForKeyFunction

    ld a, 1
    ld [wGameState], a
    jp NextGameState
SMODS.Atlas({key = 'stakes', path = 'stakes.png', px = 29, py = 29})
SMODS.Stake({
    name = "entr-Entropic Stake",
    key = "entropic",
    pos = { x = 0, y = 0 },
    atlas = "stakes",
    applied_stakes = { "cry_ascendant" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stickers",
    sticker_pos = {x=0,y=1},
    modifiers = function()
        G.GAME.modifiers.entropic = true
    end,
    shiny=true,
    order = 9999,
    colour = HEX("ff0000")
})
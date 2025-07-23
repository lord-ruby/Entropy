local copper = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	object_type = "Stake",
    order = 1,
    key = "copper",
    pos = { x = 0, y = 0 },
    atlas = "stakes",
    applied_stakes = { "gold" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=0,y=0},
    modifiers = function()
        G.GAME.modifiers.entr_copper = true
    end,
    shiny = true,
    colour = HEX("ff7747")
}


local ref = copy_card
function copy_card(old, new, ...)
    local ret = ref(old, new, ...)
    if not G.SETTINGS.paused and G.deck and G.GAME.modifiers.entr_copper and pseudorandom("entr_copper_stake") < 0.33 and (ret.config.center.set == "Default" or ret.config.center.set == "Enhanced") then
        ret:set_ability(G.P_CENTERS.m_entr_disavowed)
    end
    return ret
end

local platinum = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	object_type = "Stake",
    order = 2,
    key = "platinum",
    pos = { x = 1, y = 0 },
    atlas = "stakes",
    applied_stakes = { "entr_copper" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=1,y=0},
    modifiers = function()
        G.GAME.modifiers.entr_platinum = 1.2
    end,
    shiny = true,
    colour = HEX("aebac1")
}

local meteorite = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	object_type = "Stake",
    order = 3,
    key = "meteorite",
    pos = { x = 2, y = 0 },
    atlas = "stakes",
    applied_stakes = { "entr_platinum" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=2,y=0},
    modifiers = function()
        G.GAME.modifiers.entr_meteorite = 0.33
    end,
    shiny = true,
    colour = HEX("983443")
}

local level_up_handref = level_up_hand
function level_up_hand(card, hand, ...)
    if G.GAME.modifiers.entr_meteorite and pseudorandom("entr_platinum_stake") < G.GAME.modifiers.entr_meteorite  then
        if card then
            card_eval_status_text(
                card,
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_nope_ex"), colour = HEX("983443") }
            )
        end
    else
        return level_up_handref(card, hand, ...)
    end
end

local iridium = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	object_type = "Stake",
    order = 4,
    key = "iridium",
    pos = { x = 3, y = 0 },
    atlas = "stakes",
    applied_stakes = { "entr_meteorite" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=3,y=0},
    modifiers = function()
        G.GAME.win_ante = 10
    end,
    colour = HEX("983443"),
    shiny = true,
}

local zenith = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	object_type = "Stake",
    order = 5,
    key = "zenith",
    pos = { x = 4, y = 0 },
    atlas = "stakes",
    applied_stakes = { "entr_iridium" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=4,y=0},
    modifiers = function()
        G.GAME.modifiers.zenith = true
    end,
    colour = HEX("ff00ff")
}

return {
    items = {
        copper,
        platinum,
        meteorite,
        iridium,
        zenith
    }
}
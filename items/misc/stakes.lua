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

local obsidian = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	object_type = "Stake",
    order = 4,
    key = "obsidian",
    pos = { x = 3, y = 0 },
    atlas = "stakes",
    applied_stakes = { "entr_meteorite" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=3,y=0},
    modifiers = function()
        G.GAME.curse_rate_mod = 1
    end,
    colour = HEX("583175"),
    shiny = true,
}

Entropy.curses = {
    ["entr_blind"] = {
        key = "k_curse_blind",
        desc_key = "k_curse_blind_desc"
    },
    ["entr_darkness"] = {
        key = "k_curse_darkness",
        desc_key = "k_curse_darkness_desc"
    },
    ["entr_lost"] = {
        key = "k_curse_lost",
        desc_key = "k_curse_lost_desc"
    },
    ["entr_maze"] = {
        key = "k_curse_maze",
        desc_key = "k_curse_maze_desc"
    }
}

function Entropy.get_curse_rate()
    if to_big(G.GAME.round_resets.ante) <= to_big(8) then return 0 end
    local key = G.GAME.selected_back and G.GAME.selected_back.effect.center.original_key
    local wins = G.PROFILES and G.SETTINGS.profile and G.PROFILES[G.SETTINGS.profile].deck_usage and G.PROFILES[G.SETTINGS.profile].deck_usage[key] and G.PROFILES[G.SETTINGS.profile].deck_usage[key].wins or {}
    if wins[8] ~= 0 then 
        return 0.1 + (G.GAME.entr_alt and 0.05 or 0)
    else    
        return 0.02  + (G.GAME.entr_alt and 0.08 or 0)
    end
end

local dft = Blind.defeat
function Blind:defeat(s)
    dft(self, s)
    if G.GAME.blind_on_deck == "Boss" then
        G.GAME.curse_rate = (G.GAME.curse_rate_mod or Entropy.get_curse_rate()) * G.GAME.round_resets.ante
        if to_big(G.GAME.curse_rate_mod) < to_big(1) and to_big(G.GAME.round_resets.ante) <= to_big(8) then G.GAME.curse_rate = 0 end
        if not (MP and MP.LOBBY and MP.LOBBY.code) then
            if pseudorandom("entr_curse") < G.GAME.curse_rate then
                G.GAME.entr_maze_applied = nil
                local curses = {}
                for i, v in pairs(Entropy.curses) do
                    curses[#curses+1] = i
                end
                G.GAME.curse = pseudorandom_element(curses, pseudoseed("entr_curse"))
                attention_text({
                    scale = 1,
                    text = localize(Entropy.curses[G.GAME.curse].key),
                    hold = 8,
                    align = "cm",
                    offset = { x = 0, y = -2.7 },
                    major = G.play,
                })
                attention_text({
                    scale = 0.7,
                    text = localize(Entropy.curses[G.GAME.curse].desc_key),
                    hold = 8,
                    align = "cm",
                    offset = { x = 0, y = -1.8 },
                    major = G.play,
                })
                if G.GAME.curse == "entr_lost" then
                    G.GAME.modifiers.cry_no_small_blind_last = G.GAME.modifiers.cry_no_small_blind
                    G.GAME.modifiers.cry_no_small_blind = true
                else
                    G.GAME.modifiers.cry_no_small_blind = G.GAME.modifiers.cry_no_small_blind_last
                    G.GAME.modifiers.cry_no_small_blind_last = nil
                end
            else
                G.GAME.entr_maze_applied = nil
                G.GAME.curse = nil
            end
        end
    end
end

local ccfs = create_card_for_shop
function create_card_for_shop(area)
    local card = ccfs(area)
    if G.GAME.curse == "entr_blind" then
        if pseudorandom("entr_blind_curse") < 0.5 then
            card.cry_flipped = true
        end
    end
    return card
end

local iridium = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	object_type = "Stake",
    order = 5,
    key = "iridium",
    pos = { x = 4, y = 0 },
    atlas = "stakes",
    applied_stakes = { "entr_obsidian" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=4,y=0},
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
    order = 6,
    key = "zenith",
    pos = { x = 5, y = 0 },
    atlas = "stakes",
    applied_stakes = { "entr_iridium" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=5,y=0},
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
        obsidian,
        iridium,
        zenith
    }
}
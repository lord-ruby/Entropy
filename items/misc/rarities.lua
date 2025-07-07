Entropy.entropic_gradient = SMODS.Gradient {
    key = "entropic_gradient",
    colours = {
        G.C.RED,
        G.C.GOLD,
        G.C.GREEN,
        G.C.BLUE,
        G.C.PURPLE
    }
}

Entropy.reverse_legendary_gradient = SMODS.Gradient {
    key = "reverse_legendary_gradient",
    colours = {
        HEX("ff00c4"),
        HEX("FF00FF"),
        HEX("FF0000"),
    }
}

Entropy.zenith_gradient = SMODS.Gradient{
    key = "zenith_gradient",
    colours = {
        HEX("a20000"),
        HEX("a15000"),
        HEX("a3a101"),
        HEX("626262"),
        HEX("416600"),
        HEX("028041"),
        HEX("008284"),
        HEX("005683"),
        HEX("000056"),
        HEX("2b0157"),
        HEX("6a016a"),
        HEX("77003c"),
    }
}


SMODS.Rarity {
    key = "entropic",
    badge_colour = Entropy.entropic_gradient
}

SMODS.Rarity {
    key = "reverse_legendary",
    badge_colour = Entropy.reverse_legendary_gradient
}

SMODS.Rarity {
    key = "zenith",
    badge_colour = Entropy.zenith_gradient
}


local loc_colour_ref = loc_colour
function loc_colour(_c, default)
    if not G.ARGS.LOC_COLOURS then
        loc_colour_ref(_c, default)
    elseif not G.ARGS.LOC_COLOURS.entr_colours then
        G.ARGS.LOC_COLOURS.entr_colours = true
        local new_colors = {
            entr_entropic = Entropy.entropic_gradient,
            entr_reverse_legendary = Entropy.reverse_legendary_gradient,
            entr_omen = G.C.Entropy.Omen,
            entr_zenith = Entropy.zenith_gradient,
            entr_eqmult = HEX("cb7f7f"),
            entr_eqchips = HEX("5b89a6"),
            entr_freaky = HEX("ff00ea")
        }

        for k, v in pairs(new_colors) do
            G.ARGS.LOC_COLOURS[k] = v
        end
    end

    return loc_colour_ref(_c, default)
end

function add_rune(_tag)
    G.HUD_runes = G.HUD_runes or {}
    local tag_sprite_ui = _tag:generate_UI(1)
    G.HUD_runes[#G.HUD_runes+1] = UIBox{
        definition = {n=G.UIT.ROOT, config={align = "cm",padding = 0.05, colour = G.C.CLEAR}, nodes={
          tag_sprite_ui
        }},
        config = {
          align = G.HUD_runes[1] and 'tm' or 'bri',
          offset = G.HUD_runes[1] and {x=0,y=0} or {x=0.7,y=0},
          major = G.HUD_runes[1] and G.HUD_runes[#G.HUD_runes] or G.ROOM_ATTACH}
    }
    discover_card(G.P_RUNES[_tag.key])
  
    for i = 1, #G.GAME.runes do
      G.GAME.runes[i]:apply_to_run({type = 'tag_add', tag = _tag})
    end
    
    G.GAME.runes[#G.GAME.runes+1] = _tag
    _tag.HUD_tag = G.HUD_runes[#G.HUD_runes]
end
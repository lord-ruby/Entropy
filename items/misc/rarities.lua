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
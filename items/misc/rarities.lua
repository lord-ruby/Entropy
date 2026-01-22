SMODS.Rarity {
    key = "entropic",
    badge_colour = Entropy.entropic_gradient
}

SMODS.Rarity {
    key = "zenith",
    badge_colour = Entropy.zenith_gradient
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
            entr_freaky = HEX("ff00ea"),
            entr_transparent = {0,0,0,0},
            entr_trans = Entropy.transgender_gradient,
        }

        for k, v in pairs(new_colors) do
            G.ARGS.LOC_COLOURS[k] = v
        end
    end

    return loc_colour_ref(_c, default)
end

local ease_colour_ref = ease_colour
function ease_colour(orig, new, ...)
    if new.colours then orig = new return end
    return ease_colour_ref(orig, new, ...)
end
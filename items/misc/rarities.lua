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

local ease_colour_ref = ease_colour
function ease_colour(orig, new, ...)
    if new.colours then orig = new return end
    return ease_colour_ref(orig, new, ...)
end

SMODS.Rarity {
    key = "void",
    badge_colour = Entropy.void_gradient,
    default_weight = 0,
	pools = { ["Joker"] = true },
	get_weight = function(self, weight, object_type)
        if G.GAME.entr_alt then
            return 0.03
        end
        return 0
	end,
}

loc_colour()
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

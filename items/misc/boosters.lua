local pack = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
	object_type = "Booster",
    order = 40,
    key = "twisted_pack_normal",
    set = "Booster",
    config = { extra = 3, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    HEX("851628")
                }
            },
        }
    end,
    atlas = 'booster', pos = { x = 0, y = 0 },
    group_key = "k_inverted_pack",
    cost = 4,
    draw_hand = true,
    weight = 0.75,
    hidden = true,
    kind = "Inverted",
    create_card = function (self, card, i) 
        return create_inverted_card()
    end,
    ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, HEX("851628"))
		ease_background_colour({ new_colour = HEX("3c020b"), special_colour = HEX("3c020b"), contrast = 2 })
	end,
    cry_digital_hallucinations = {
		colour = G.C.RED,
		loc_key = "k_twisted_pack",
		create = function()
			local ccard = create_inverted_card()
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end,
	},
}
local jumbo = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
	object_type = "Booster",
    order = 41,
    key = "twisted_pack_jumbo",
    set = "Booster",
    config = { extra = 5, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    HEX("851628")
                }
            },
        }
    end,
    atlas = 'booster', pos = { x = 1, y = 0 },
    group_key = "k_inverted_pack",
    cost = 6,
    draw_hand = true,
    weight = 0.5,
    hidden = true,
    kind = "Inverted",
    create_card = function (self, card, i) 
        return create_inverted_card()
    end,
    ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, HEX("851628"))
		ease_background_colour({ new_colour = HEX("3c020b"), special_colour = HEX("3c020b"), contrast = 2 })
	end,
    cry_digital_hallucinations = {
		colour = G.C.RED,
		loc_key = "k_twisted_pack",
		create = function()
			local ccard = create_inverted_card()
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end,
	},
}
local mega = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
	object_type = "Booster",
    order = 42,
    key = "twisted_pack_mega",
    set = "Booster",
    config = { extra = 5, choose = 2 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    HEX("851628")
                }
            },
        }
    end,
    atlas = 'booster', pos = { x = 2, y = 0 },
    group_key = "k_inverted_pack",
    cost = 8,
    draw_hand = true,
    weight = 0.25,
    hidden = true,
    kind = "Inverted",
    create_card = function (self, card, i) 
        return create_inverted_card()
    end,
    ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, HEX("851628"))
		ease_background_colour({ new_colour = HEX("3c020b"), special_colour = HEX("3c020b"), contrast = 2 })
	end,
    cry_digital_hallucinations = {
		colour = G.C.RED,
		loc_key = "k_twisted_pack",
		create = function()
			local ccard = create_inverted_card()
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end,
	},
}



function create_inverted_card(area, seed)
    local num = pseudorandom("twisted_rare")
    if num - 0.01 <= 0 then
        local c = pseudorandom_element(Entropy.RareInversions, pseudoseed(seed or "twisted"))
        return create_card(G.P_CENTERS[c].set, area or G.pack_cards, nil, nil, true, true, c)
    end
    return create_card("Twisted", area or G.pack_cards, nil, nil, true, true, nil, "twisted")
end

return {
    items = {
        pack,
        jumbo,
        mega
    }
}
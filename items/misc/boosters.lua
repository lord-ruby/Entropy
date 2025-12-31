local pack = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
	object_type = "Booster",
    order = -1006,
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
    get_weight = function()
        return 0.5 * (G.GAME.entr_alt and 2 or 1)
    end,
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
    entr_credits = {art = {"LFMoth"}}
}

local pack2 = copy_table(pack)
pack2.pos.y = 1
pack2.entr_credits = {art = {"Lil. Mr. Slipstream"}}
pack2.key = "twisted_pack_normal_2"
pack2.order = -1005

local jumbo = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
	object_type = "Booster",
    order = -1004,
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
    kind = "Inverted",
    get_weight = function()
        return 0.3 * (G.GAME.entr_alt and 2.25 or 1)
    end,
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
    entr_credits = {art = {"Lil. Mr. Slipstream"}}
}
local jumbo2 = copy_table(jumbo)
jumbo2.pos.y = 1
jumbo2.entr_credits = {art = {"Binary"}}
jumbo2.key = "twisted_pack_jumbo_2"
jumbo2.order = -1003

local mega = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
	object_type = "Booster",
    order = -1002,
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
    get_weight = function()
        return 0.2 * (G.GAME.entr_alt and 2.5 or 1)
    end,
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
    entr_credits = {art = {"Lil. Mr. Slipstream"}}
}
local mega2 = copy_table(mega)
mega2.pos.y = 1
mega2.key = "twisted_pack_mega_2"
mega2.order = -1001

function Entropy.get_rare_inversion(seed)
    local pool = {}
    for i, k in pairs(Entropy.RareInversions) do
        local v = G.P_CENTERS[k]
        if not (G.GAME.used_jokers[v.key] and not SMODS.showman(v.key) and not v.can_repeat_soul) and (not v.in_pool or (type(v.in_pool) ~= "function") or v:in_pool({})) then
            pool[#pool+1] = k
        end
    end
    if #pool > 0 then
        return pseudorandom_element(pool, pseudoseed(seed or "entr_twisted_rare")), pool
    end
end

function create_inverted_card(area, seed)
    local num = pseudorandom("twisted_rare")
    if G.GAME.interpolate_cards and #G.GAME.interpolate_cards > 0 then
        for i, v in pairs(G.GAME.interpolate_cards) do
            local num = pseudorandom("twisted_interpolate")
            if num <= 0.03 then
                local c = v
                return create_card(G.P_CENTERS[c].set, area or G.pack_cards, nil, nil, true, true, c)
            end
        end
    end
    if Entropy.has_rune("rune_entr_oss") and not Entropy.has_rune("rune_entr_oss").triggered then
        local c = Entropy.get_rare_inversion("rune_entr_oss")
        if c then
            calculate_runes({generate_rare_consumable = true})
            Entropy.has_rune("rune_entr_oss").triggered = true
            return create_card(G.P_CENTERS[c].set, area or G.pack_cards, nil, nil, true, true, c)
        end
    else
        if Entropy.has_rune("rune_entr_mannaz") and (Entropy.has_rune("rune_entr_mannaz").num_triggered or 0) <= 1 then
            Entropy.has_rune("rune_entr_mannaz").num_triggered = (Entropy.has_rune("rune_entr_mannaz").num_triggered or 0) + 1
            if Entropy.has_rune("rune_entr_mannaz").num_triggered > 1 or not G.GAME.providence then
                Entropy.has_rune("rune_entr_mannaz").num_triggered = 2
                Entropy.has_rune("rune_entr_mannaz").triggered = true
            end
            return create_card("Spectral", area or G.pack_cards, nil, nil, true, true, nil, "rune_entr_mannaz", true)
        end
    end
    if num - 0.003 <= 0 then
        local c = Entropy.get_rare_inversion()
        if c then
            return create_card(G.P_CENTERS[c].set, area or G.pack_cards, nil, nil, true, true, c)
        end
    end
    local rune
    if pseudorandom("entr_generate_rune") < 0.06 then rune = true end
    if G.GAME.entr_diviner then
        if pseudorandom("entr_generate_rune") < 0.06 then rune = true end
    end
    if rune then
        return create_card("Pact", G.pack_cards, nil, nil, true, true, nil, "spe")
    end
    return create_card("Twisted", area or G.pack_cards, nil, nil, true, true, nil, "twisted_card")
end

local voucher = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
	object_type = "Booster",
    order = -990.1,
    key = "voucher_pack",
    set = "Booster",
    config = { extra = 5, choose = 2 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    HEX("ff00cd")
                }
            },
        }
    end,
    atlas = 'booster', pos = { x = 6, y = 0 },
    group_key = "k_voucher_pack",
    cost = 10,
    draw_hand = false,
    weight = 0,
    kind = "Voucher",
    create_card = function (self, card, i) 
        return create_card("Voucher", G.pack_cards)
    end,
    ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, HEX("ff00cd"))
		ease_background_colour({ new_colour = HEX("ff00cd"), special_colour = HEX("ff00cd"), contrast = 2 })
	end,
    cry_digital_hallucinations = {
		colour = HEX("ff00cd"),
		loc_key = "k_voucher_pack",
		create = function()
			local ccard = create_card("Voucher", G.pack_cards)
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end,
	},
}

return {
    items = {
        pack,
        pack2,
        jumbo,
        jumbo2,
        mega,
        mega2,
        voucher
    }
}
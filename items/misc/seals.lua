local crimson = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 3001,
    key="entr_crimson",
    atlas = "seals",
    pos = {x=0,y=0},
    badge_colour = HEX("8a0050"),
    calculate = function(self, card, context)
    end,
}

local sapphire = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 3002,
    key="entr_sapphire",
    atlas = "seals",
    pos = {x=1,y=0},
    badge_colour = HEX("8653ff"),
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            local pkey = "regulus"
            for i, v in pairs(Entropy.ReversePlanets) do
                if v.name == text then pkey = v.new_key end
            end
            local key = "c_entr_"..pkey
            if G.consumeables.config.card_count < G.consumeables.config.card_limit then
                local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
                c:add_to_deck()
                G.consumeables:emplace(c)
            end
        end
        if context.forcetrigger then
            local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
            c:add_to_deck()
            G.consumeables:emplace(c)
        end
    end,
}

local silver = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 3003,
    key="entr_silver",
    atlas = "seals",
    pos = {x=2,y=0},
    badge_colour = HEX("84a5b7"),
    calculate = function(self, card, context)
		if context.cardarea == "unscored" and context.main_scoring then
            ease_dollars(4)
        end
        if context.forcetrigger then
            ease_dollars(4)
        end
    end,
    draw = function(self, card, layer)
		G.shared_seals["entr_silver"].role.draw_major = card
        G.shared_seals["entr_silver"]:draw_shader('dissolve', nil, nil, nil, card.children.center)
		G.shared_seals["entr_silver"]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end,
}

local pink = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 3004,
    key="entr_pink",
    atlas = "seals",
    pos = {x=3,y=0},
    badge_colour = HEX("cc48be"),
    calculate = function(self, card, context)
        if context.pre_discard and context.cardarea == G.hand and card.highlighted then
            card.ability.temporary2 = true
            card:remove_from_deck()
            card:start_dissolve()
            if G.consumeables.config.card_count < G.consumeables.config.card_limit then
                local c = create_card("Twisted", G.consumeables, nil, nil, true, true, nil, "twisted") 
                c:add_to_deck()
                G.consumeables:emplace(c)
            end
            SMODS.calculate_context({remove_playing_cards = true, removed={card}})
        end
        if context.forcetrigger then
            local c = create_card("Twisted", G.consumeables, nil, nil, true, true, nil, "twisted") 
            c:add_to_deck()
            G.consumeables:emplace(c)
        end
    end,
}

local verdant = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 3005,
    key="entr_verdant",
    atlas = "seals",
    pos = {x=4,y=0},
    badge_colour = HEX("75bb62"),
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            if #scoring_hand == 1 then
                if G.consumeables.config.card_count < G.consumeables.config.card_limit then
                    local c = create_card("RCode", G.consumeables, nil, nil, nil, nil, nil) 
                    c:add_to_deck()
                    G.consumeables:emplace(c)
                end
            end
        end
        if context.forcetrigger then
            local key = pseudorandom_element(Entropy.FlipsideInversions, pseudoseed("verdant"))
            while G.P_CENTERS[key].set ~= "RCode" do key = pseudorandom_element(Entropy.FlipsideInversions, pseudoseed("verdant")) end
            local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
            c:add_to_deck()
            G.consumeables:emplace(c)
        end
    end,
}

local cerulean = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 3006,
    key="entr_cerulean",
    atlas = "seals",
    pos = {x=5,y=0},
    badge_colour = HEX("4078e6"),
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            local pkey = "regulus"
            for i, v in pairs(Entropy.ReversePlanets) do
                if v.name == text then pkey = v.new_key end
            end
            local key = "c_entr_"..pkey
            for i = 1, 3 do
                    local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
                    c:add_to_deck()
                    c:set_edition("e_negative")
                    G.consumeables:emplace(c)
                end
            for i, v in pairs(scoring_hand) do
                v.ability.temporary2 = true
            end
            SMODS.calculate_context({remove_playing_cards = true, removed=scoring_hand})
        end
        if context.forcetrigger then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            local pkey = "pluto"
            for i, v in pairs(Entropy.ReversePlanets) do
                if v.name == text then pkey = v.key end
            end
            local key = "c_entr_"..pkey
            for i = 1, 3 do
                local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
                c:add_to_deck()
                c:set_edition("e_negative")
                G.consumeables:emplace(c)
            end
        end
    end,
}

return {
    items = {
        crimson,
        sapphire,
        silver,
        pink,
        verdant,
        cerulean
    }
}

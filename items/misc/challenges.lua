local hyperbolic_chamber = {
	object_type = "Challenge",
	key = "hyperbolic_chamber",
	order = 1,
	rules = {
        custom = {
			{ id = "entr_starting_ante_mten" },
            { id = "entr_reverse_redeo" },
        }
	},
	restrictions = {
		banned_cards = {
			{ id = "c_cry_analog" },
		},
		banned_other = {
            { id = "bl_cry_joke", type = "blind" },
        },
	},
    jokers = {
		{ id = "j_cry_redeo", stickers = { "entr_aleph" } },
        { id = "j_entr_xekanos", stickers = { "entr_aleph" } },
	},
	deck = {
		type = "Challenge Deck",
	},
}

local gsr = Game.start_run
function Game:start_run(args)
        G.butterfly_jokers = CardArea(
            9999, 9999,
            0,
            0, 
            {card_limit = 9999, type = 'joker', highlight_limit = 0}
        )
	gsr(self, args)
	if G.GAME.modifiers.entr_starting_ante_mten and not args.savetext then
        ease_ante(-11, nil, true)
	end
    for i, v in pairs(G.butterfly_jokers.cards) do
        v:add_to_deck()
    end
    if Entropy.DeckOrSleeve("doc") then
        -- G.HUD:remove()
        -- G.HUD = nil
        -- G.HUD = UIBox{
        --     definition = create_UIBox_HUD(),
        --     config = {align=('cli'), offset = {x=-1.3,y=0},major = G.ROOM_ATTACH}
        -- }
        -- G.HUD_blind:remove()
        -- G.HUD_blind = UIBox{
        --     definition = create_UIBox_HUD_blind(),
        --     config = {major = G.HUD:get_UIE_by_ID('row_blind'), align = 'cm', offset = {x=0,y=-10}, bond = 'Weak'}
        -- }
        -- for i, v in pairs(G.hand_text_area) do
        --     G.hand_text_area[i] = G.HUD:get_UIE_by_ID(v.config.id)
        -- end
    end
    G.HUD_runes = {}
    local saveTable = args.savetext or nil
    G.GAME.runes = {}
    if saveTable then
        local tags = saveTable.runes or {}
        G.E_MANAGER:add_event(
            Event{
                func = function()
                    for k, v in ipairs(tags) do
                        local _tag = Tag(type(v) == "table" and v.key or v)
                        if type(v) == "table" then _tag.ability = v.ability or _tag.ability end
                        add_rune(_tag, nil, true)
                    end
                    return true
                end
            }
        )
    end
    if not G.GAME.rune_rate then G.GAME.rune_rate = 0 end
    if G.GAME.cry_percrate and not G.GAME.cry_percrate["rune"] then G.GAME.cry_percrate["rune"] = 0 end
    G.jokers.config.highlighted_limit = 1e100
    G.consumeables.config.highlighted_limit = 1e100
end

local set_abilityref = Card.set_ability
function Card:set_ability(center, initial, delay)
    set_abilityref(self, center, initial, delay)
    if (G.GAME.modifiers.entr_reverse_redeo or G.GAME.ReverseRedeo) and self.config.center.key == "j_cry_redeo" then
        self.ability.extra.ante_reduction = -1
    end
end

local change_ref = G.FUNCS.change_challenge_description
G.FUNCS.change_challenge_description = function(e)
    change_ref(e)
    local hyperbolic
    for i, v in ipairs(G.CHALLENGES) do
        if v.key == "c_entr_hyperbolic_chamber" then
            hyperbolic = i
        end
    end
    if e.config.id == hyperbolic then G.GAME.ReverseRedeo = true else G.GAME.ReverseRedeo = false end
end


if not (SMODS.Mods["Cryptid"] or {}).can_load then
    SMODS.Sticker({
        badge_colour = HEX("e8c500"),
        prefix_config = { key = false },
        key = "banana",
        atlas = "cry_banana",
        pos = { x = 0, y = 0 },
        should_apply = false,
        loc_vars = function(self, info_queue, card)
            if card.ability.consumeable then
                return { key = "cry_banana_consumeable", vars = { G.GAME.probabilities.normal or 1, 4 } }
            elseif card.ability.set == "Voucher" then
                return { key = "cry_banana_voucher", vars = { G.GAME.probabilities.normal or 1, 12 } }
            elseif card.ability.set == "Booster" then
                return { key = "cry_banana_booster" }
            else
                return { vars = { G.GAME.probabilities.normal or 1, 10 } }
            end
        end,
        calculate = function(self, card, context)
            if
                context.end_of_round
                and not context.repetition
                and not context.playing_card_end_of_round
                and not context.individual
            then
                if card.ability.set == "Voucher" then
                    if pseudorandom("byebyevoucher") < G.GAME.probabilities.normal / G.GAME.cry_voucher_banana_odds then
                        local area
                        if G.STATE == G.STATES.HAND_PLAYED then
                            if not G.redeemed_vouchers_during_hand then
                                G.redeemed_vouchers_during_hand = CardArea(
                                    G.play.T.x,
                                    G.play.T.y,
                                    G.play.T.w,
                                    G.play.T.h,
                                    { type = "play", card_limit = 5 }
                                )
                            end
                            area = G.redeemed_vouchers_during_hand
                        else
                            area = G.play
                        end
    
                        local _card = copy_card(card)
                        _card.ability.extra = copy_table(card.ability.extra)
                        if _card.facing == "back" then
                            _card:flip()
                        end
    
                        _card:start_materialize()
                        area:emplace(_card)
                        _card.cost = 0
                        _card.shop_voucher = false
                        _card:unredeem()
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0,
                            func = function()
                                _card:start_dissolve()
                                card:start_dissolve()
                                return true
                            end,
                        }))
                    end
                end
            end
        end,
    })
end

local lifelight = {
    object_type = "Challenge",
	key = "lifelight",
	order = 2,
	restrictions = {
		banned_cards = {
			{ id = "c_strength" },
		},
	},
    jokers = {
		{ id = "j_entr_jestradiol", stickers = { "entr_aleph" } },
        { id = "j_shoot_the_moon", stickers = { "entr_aleph" } },
	},
	deck = {
		type = "Challenge Deck",
	},
}

local vesuvius = {
    object_type = "Challenge",
	key = "vesuvius",
	order = 3,
    jokers = {
		{ id = "j_burnt", stickers = { "entr_aleph" } },
        { id = "j_entr_fused_lens", stickers = { "entr_aleph" } },
	},
	deck = {
		type = "Challenge Deck",
	},
    rules = {
        custom = {
			{ id = "entr_no_planets" },
        }
	},
    restrictions = {
       banned_cards = {
            {id = "p_celestial_normal_1"},
            {id = "p_celestial_normal_2"},
            {id = "p_celestial_jumbo_1"},
            {id = "p_celestial_jumbo_2"},
            {id = "p_celestial_mega_1"},
            {id = "p_celestial_mega_2"},
            {id = "c_high_priestess"},
        }
    },
    apply = function()
        G.GAME.planet_rate = 0
    end
}

return {
    items = {
        lifelight,
        vesuvius,
        (SMODS.Mods["Cryptid"] or {}).can_load and hyperbolic_chamber or nil
    }
}

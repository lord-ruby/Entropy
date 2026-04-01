if (SMODS.Mods["Cryptid"] or {}).can_load then
SMODS.Challenge{
	
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
end

local gsr = Game.start_run
function Game:start_run(args)
    G.C.UI.HANDS = copy_table(G.C.BLUE)
    G.C.UI.DISCARDS = copy_table(G.C.RED)
    G.GAME.EE_SCREEN = nil
        G.butterfly_jokers = CardArea(
            9999, 9999,
            0,
            0, 
            {card_limit = 9999, type = 'joker', highlight_limit = 0}
        )
    G.HUD_runes = {}
    G.HUD_curses = {}
    G.runes = {}
	gsr(self, args)
    if not args.savetext then
        G.GAME.round_resets.blind_choices.Small = get_new_small() or G.GAME.round_resets.blind_choices.Small
        G.GAME.round_resets.blind_choices.Big = get_new_big() or G.GAME.round_resets.blind_choices.Big
    end
	if G.GAME.modifiers.entr_starting_ante_mten and not args.savetext then
        ease_ante(-11, nil, true)
	end
    for i, v in pairs(G.butterfly_jokers.cards) do
        v:add_to_deck()
    end
    if G.GAME.curse then
        add_curse_icon(Tag("tag_entr_curse_indicator"))
        local atlas = Entropy.curses[G.GAME.curse].atlas or "entr_curse_icons"
        local pos = Entropy.curses[G.GAME.curse].sprite_pos or {x = 0, y = 0}
        local sprite = G.HUD_curses[1].actual.HUD_sprite
        sprite.atlas = G.ASSET_ATLAS[atlas]
        sprite:set_sprite_pos(pos)
    end
    if Entropy.deck_or_sleeve("doc") then
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
    if not G.GAME.rune_rate then G.GAME.rune_rate = 0 end
    if G.GAME.cry_percrate and not G.GAME.cry_percrate["rune"] then G.GAME.cry_percrate["rune"] = 0 end
    G.jokers.config.highlighted_limit = 1e100
    G.consumeables.config.highlighted_limit = 1e100
    if G.SPLASH_EE and not Entropy.is_EE() then
        G.SPLASH_EE:remove()
        G.SPLASH_EE = nil
    end
    if Entropy.is_EE() then
       Entropy.create_ee_splash()
    end
    if not G.GAME.blind.disabled and Spectrallib.blind_is("bl_entr_sigma") then
        ease_colour(G.C.UI.HANDS, {0.8, 0.45, 0.85, 1})
        ease_colour(G.C.UI.DISCARDS, {0.8, 0.45, 0.85, 1})
    end
    if G.GAME.entr_dating_start then
        local key = G.GAME.entr_current_dialog
        Entropy.clean_up_dating_sim()
        Entropy.setup_dating_sim(key)
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

SMODS.Challenge{
    
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

SMODS.Challenge{
    
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

SMODS.Challenge{
    
	key = "hyperaccelerated_bongcloud_opening",
	order = 3,
    jokers = {
		{ id = "j_entr_masterful_gambit", stickers = { "entr_aleph" } },
        { id = "j_entr_masterful_gambit", stickers = { "entr_aleph" } },
        { id = "j_entr_masterful_gambit", stickers = { "entr_aleph" } },
        { id = "j_entr_masterful_gambit", stickers = { "entr_aleph" } },
	},
	deck = {
		type = "Challenge Deck",
	},
}

SMODS.Challenge{
    
	key = "paycheck_to_paycheck",
	order = 4,
    custom = {
                {id = 'no_reward'},
                {id = 'no_extra_hand_money'},
    },
    jokers = {
		{ id = "j_entr_tenner", stickers = { "entr_aleph" } },
        { id = "j_credit_card", stickers = { "entr_aleph" } },
        { id = "j_entr_debit_card", stickers = { "entr_aleph" } },
	},
    consumeables = {
        { id = "c_entr_strength", stickers = { "eternal" } },
        { id = "c_entr_dreams", stickers = { "eternal" } },
    },
	deck = {
		type = "Challenge Deck",
	},
}


SMODS.Challenge{
    
	key = "variety_content",
	order = 5,
    jokers = {
		{ id = "j_entr_spiral_of_ants", stickers = { "entr_aleph" } },
        { id = "j_entr_hash_miner", stickers = { "entr_aleph" } },
        { id = "j_obelisk", stickers = { "entr_aleph" } },
        { id = "j_entr_overpump", stickers = { "entr_aleph" } },
        { id = "j_entr_antipattern", stickers = { "entr_aleph" } },
	},
    consumeables = {
        { id = "c_temperance", edition = "negative" },
        { id = "c_entr_statue" },
        { id = "c_entr_mason" },
    },
	deck = {
		type = "Challenge Deck",
	},
}


SMODS.Challenge{
    
	key = "riffle_shuffle",
	order = 5,
    jokers = {
		{ id = "j_entr_meridian", stickers = { "entr_aleph" } },
        { id = "j_entr_broadcast", stickers = { "entr_aleph" } },
        { id = "j_entr_roulette", stickers = { "entr_aleph" } },
        { id = "j_entr_crimson_flask", stickers = { "entr_aleph", "entr_pure" }, edition = "entr_lowres" },
	},
    consumeables = {
        { id = "c_entr_ingwaz" },
        { id = "c_entr_loyalty" },
    },
	deck = {
		type = "Challenge Deck",
	},
}

SMODS.Challenge{
    
	key = "phantom_hand_syndrome",
	order = 6,
    rules = {
        modifiers = {
            {id = "discards", value = -32},
        }
    },
    jokers = {
		{ id = "j_entr_jack_off", stickers = { "entr_aleph" } },
        { id = "j_entr_nucleotide", stickers = { "entr_aleph" } },
        { id = "j_castle", stickers = { "entr_aleph" } },
        { id = "j_selzer" },
	},
    consumeables = {
        { id = "c_medium" },
        { id = "c_medium" },
    },
	deck = {
		type = "Challenge Deck",
	},
}

SMODS.Challenge{
    
	key = "eco_friendly",
	order = 7,
    rules = {
            custom = {
                {id = 'no_reward'},
                {id = 'no_extra_hand_money'},
                {id = 'no_interest'}
            },
            modifiers = {
            {id = "dollars", value = 20},
        }
        },
    jokers = {
		{ id = "j_entr_solar_panel", stickers = { "entr_aleph" } },
        { id = "j_entr_car_battery", stickers = { "entr_aleph" } },
        { id = "j_entr_recycling_bin", stickers = { "entr_aleph" } },
	},
    consumeables = {
        { id = "c_entr_comet", stickers = { "eternal" } },
        { id = "c_entr_comet", stickers = { "eternal" } },
        { id = "c_entr_comet" },
    },
    vouchers = {
        { id = "v_crystal_ball" },
    },
	deck = {
		type = "Challenge Deck",
	},
}
SMODS.ConsumableType{
	key = "CBlind",
	primary_colour = HEX("ab3a3e"),
	secondary_colour = HEX("ab3a3e"),
	--collection_rows = { 4, 5 },
	shop_rate = 0.0,
	default = "c_entr_bl_small",
    hidden=true,
}

SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "RCode",
	primary_colour = HEX("ff0000"),
	secondary_colour = HEX("ff0000"),
	collection_rows = { 4, 4 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_memory_leak"
})

local memory_leak = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 1,
    key = "memory_leak",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {

    },
    no_collection = true,
    pos = {x=0,y=1},
    use = function(self, card, area, copier)
        error("\nx.x\nAw Snap!\nSomething went wrong whilst displaying this webpage.\n\nLearn More.")
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)

    end
}

local root_kit = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 2,
    key = "root_kit",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=1,y=1},
    use = function(self, card, area, copier)
        G.GAME.RootKit = (G.GAME.RootKit or 0) + card.ability.extra.selected
    end,
    bulk_use = function(self, card, area, copier, number)
		G.GAME.RootKit = (G.GAME.RootKit or 0) + card.ability.extra.selected * number
	end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                (G.GAME.RootKit or 0) + (card.ability and card.ability.extra.selected or 10)
            }
        }
    end
}

local bootstrap = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3,
    key = "bootstrap",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=2,y=1},
    use = function(self, card, area, copier)
        G.GAME.UsingBootstrap = true
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)

    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}
local main_ref = evaluate_play_main
function evaluate_play_main(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    local m = G.GAME.hands[text].mult
    local c = G.GAME.hands[text].chips
    if G.GAME.Bootstrap then
        if poker_hands[text] then
            poker_hands[text].mult = G.GAME.Bootstrap.Mult
            poker_hands[text].chips = G.GAME.Bootstrap.Chips
        end
        G.GAME.hands[text].mult = G.GAME.Bootstrap.Mult
        G.GAME.hands[text].chips = G.GAME.Bootstrap.Chips
        G.GAME.Bootstrap = nil
    end
    main_ref(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    if G.GAME.UsingBootstrap then
        G.GAME.Bootstrap = {
            Mult = mult,
            Chips = hand_chips
        }
        G.GAME.UsingBootstrap = nil
    end
    G.GAME.hands[text].mult = m
    G.GAME.hands[text].chips = c
    if poker_hands[text] then
        poker_hands[text].mult = m
        poker_hands[text].chips = c
    end
end
local quickload = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 4,
    key = "quickload",
    set = "RCode",
    can_stack = true,
	can_divide = true,

    atlas = "miscc",
    pos = {x=3,y=1},
    use = function(self, card, area, copier)
        G.STATE = 8
        G.STATE_COMPLETE = false
        if G.SHOP_SIGN then     
            G.SHOP_SIGN:remove()
        end
    end,
    can_use = function(self, card)
        return G.STATE == 5
	end,
    loc_vars = function(self, q, card)
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}
local break_timer = 0
local break_card = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 5,
    key = "break",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=5,y=1},
    use = function(self, card, area, copier)
        for i, v in pairs(G.GAME.round_resets.blind_states) do
            if v == "Current" then v = "Upcoming" end
        end
        G.E_MANAGER:add_event(Event({
			trigger = "immediate",
			func = function()
                G.STATE = 7
				--G.GAME.USING_RUN = true
				--G.GAME.RUN_STATE_COMPLETE = 0
				G.STATE_COMPLETE = false
                G.GAME.USING_BREAK = true
                break_timer = 0
                G.FUNCS.draw_from_hand_to_deck()
				return true
			end,
		}))
    end,
    can_use = function(self, card)
        for i, v in pairs(G.GAME.round_resets.blind_states) do
            if v == "Current" then return true end
        end
        return false
	end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

local new = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 6,
    key = "new",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=0,y=2},
    use = function(self, card, area, copier)
        G.GAME.round_resets.red_room = true
        G.GAME.round_resets.blind_states['Red'] = "Select"
        if G.blind_select then        
            G.blind_select:remove()
            G.blind_prompt_box:remove()
            G.STATE_COMPLETE = false
        end
    end,
    can_use = function(self, card)
        return not G.GAME.round_resets.red_room and G.blind_select
	end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
}
SMODS.Atlas({key = 'blinds', path = 'blinds.png', px = 34, py = 34, frames = 21, atlas_table = 'ANIMATION_ATLAS'})
local rr = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Blind",
    order = 999,
	name = "entr-red",
	key = "red",
	pos = { x = 0, y = 0 },
	atlas = "blinds",
	boss_colour = HEX("FF0000"),
    mult=1,
    boss = {min=1,max=9999},
    dollars = 3,
    in_pool = function(self) return false end
}

local interference = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 7,
    key = "interference",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=1,y=2},
    use = function(self, card, area, copier)
        G.GAME.blind.chips = G.GAME.blind.chips * pseudorandom("interference")+0.22
        G.GAME.InterferencePayoutMod = pseudorandom("interference")+0.85
        G.GAME.Interfered = true
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
}
local constant = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 8,
    key = "constant",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    pos = {x=2,y=2},
    use = function(self, card, area, copier)
        for i, v in pairs(G.discard.cards) do
            if v.base.id == G.hand.highlighted[1].base.id then
                copy_card(G.hand.highlighted[1],v)
            end
        end
        for i, v in pairs(G.hand.cards) do
            if v.base.id == G.hand.highlighted[1].base.id then
                copy_card(G.hand.highlighted[1],v)
            end
        end
        for i, v in pairs(G.deck.cards) do
            if v.base.id == G.hand.highlighted[1].base.id then
                copy_card(G.hand.highlighted[1],v)
            end
        end
    end,
    can_use = function(self, card)
        return Entropy.GetHighlightedCards({G.hand}, nil, card) == 1
	end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
}
local pseudorandom = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "entr_pseudorandom"
        }
    },
    object_type = "Consumable",
    order = 9,
    key = "pseudorandom",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    pos = {x=3,y=2},
    use = function(self, card, area, copier)
        local allowed = {
            ["hand"]=true,
            ["jokers"]=true,
            ["consumeables"]=true,
            ["shop_jokers"]=true,
            ["shop_booster"]=true,
            ["shop_vouchers"]=true
        }
        for i, v in pairs(allowed) do
            for ind, card in pairs(G[i].cards) do
                Entropy.ApplySticker(card, "entr_pseudorandom")
            end
        end
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "entr_pseudorandom", set="Other"}
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

local pseudorandom_sticker = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Sticker",
    order = 1,
    atlas = "entr_stickers",
    pos = { x = 5, y = 0 },
    key = "entr_pseudorandom",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("FF0000"),
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        if not G.shared_stickers["entr_pseudorandom2"] then
            G.shared_stickers["entr_pseudorandom2"] =
                Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["entr_stickers"], { x = 4, y = 0 })
        end -- no matter how late i init this, it's always late, so i'm doing it in the damn draw function

        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers["entr_pseudorandom2"].role.draw_major = card

        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)

        card.hover_tilt = card.hover_tilt / 2 -- call it spaghetti, but it's what hologram does so...
        G.shared_stickers["entr_pseudorandom2"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
        G.shared_stickers["entr_pseudorandom2"]:draw_shader(
            "hologram",
            nil,
            card.ARGS.send_to_shader,
            notilt,
            card.children.center
        ) -- this doesn't really do much tbh, but the slight effect is nice
        card.hover_tilt = card.hover_tilt * 2
    end,
    apply = function(self,card,val)
        card.ability.entr_pseudorandom = true
        if card.area then
        card.ability.cry_rigged = true
        end
    end,
}
SMODS.Sticker:take_ownership("cry_rigged",{
    draw = function(self, card)
        if not card.ability.entr_pseudorandom then
            local notilt = nil
            if card.area and card.area.config.type == "deck" then
                notilt = true
            end
            if not G.shared_stickers["cry_rigged2"] then
                G.shared_stickers["cry_rigged2"] =
                    Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["cry_sticker"], { x = 5, y = 1 })
            end -- no matter how late i init this, it's always late, so i'm doing it in the damn draw function

            G.shared_stickers[self.key].role.draw_major = card
            G.shared_stickers["cry_rigged2"].role.draw_major = card

            G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)

            card.hover_tilt = card.hover_tilt / 2 -- call it spaghetti, but it's what hologram does so...
            G.shared_stickers["cry_rigged2"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
            G.shared_stickers["cry_rigged2"]:draw_shader(
                "hologram",
                nil,
                card.ARGS.send_to_shader,
                notilt,
                card.children.center
            ) -- this doesn't really do much tbh, but the slight
            card.hover_tilt = card.hover_tilt * 2
        end
    end
},true)
local inherit = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 10,
    key = "inherit",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    pos = {x=4,y=2},
    use = function(self, card, area, copier)
        G.GAME.USING_CODE = true
		G.ENTERED_ENH = ""
		G.CHOOSE_ENH = UIBox({
			definition = create_UIBox_inherit(card),
			config = {
				align = "cm",
				offset = { x = 0, y = 10 },
				major = G.ROOM_ATTACH,
				bond = "Weak",
				instance_type = "POPUP",
			},
		})
		G.CHOOSE_ENH.alignment.offset.y = 0
		G.ROOM.jiggle = G.ROOM.jiggle + 1
		G.CHOOSE_ENH:align_to_major()
    end,
    can_use = function(self, card)
        return Entropy.GetHighlightedCards({G.hand}, {c_base=true}, card) == 1
	end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

function create_UIBox_inherit(card)
    G.E_MANAGER:add_event(Event({
        blockable = false,
        func = function()
            G.REFRESH_ALERTS = true
            return true
        end,
    }))
    local t = create_UIBox_generic_options({
        no_back = true,
        colour = HEX("04200c"),
        outline_colour = HEX("FF0000"),
        contents = {
            {
                n = G.UIT.R,
                nodes = {
                    create_text_input({
                        colour = HEX("FF0000"),
                        hooked_colour = darken(copy_table(HEX("FF0000")), 0.3),
                        w = 4.5,
                        h = 1,
                        max_length = 16,
                        prompt_text = localize("cry_code_enh"),
                        ref_table = G,
                        ref_value = "ENTERED_ENH",
                        keyboard_offset = 1,
                    }),
                },
            },
            {
                n = G.UIT.R,
                nodes = {
                    UIBox_button({
                        colour = HEX("FF0000"),
                        button = "inherit_apply",
                        label = { localize("cry_code_apply") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
            {
                n = G.UIT.R,
                nodes = {
                    UIBox_button({
                        colour = G.C.RED,
                        button = "inherit_apply_previous",
                        label = { localize("cry_code_apply_previous") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
            {
                n = G.UIT.R,
                nodes = {
                    UIBox_button({
                        colour = G.C.RED,
                        button = "inherit_cancel",
                        label = { localize("cry_code_cancel") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
        },
    })
    return t
end

G.FUNCS.inherit_apply_previous = function()
    if G.PREVIOUS_ENTERED_ENH then
        G.ENTERED_ENH = G.PREVIOUS_ENTERED_ENH or ""
    end
    G.FUNCS.inherit_apply()
end
--todo: mod support
G.FUNCS.inherit_apply = function()
    local base_enh = G.hand.highlighted[1].config.center.key
    local enh_table = {
        m_bonus = { "bonus" },
        m_mult = { "mult", "red" },
        m_wild = { "wild", "suit" },
        m_glass = { "glass", "xmult" },
        m_steel = { "steel", "metal", "grey" },
        m_stone = { "stone", "chip", "chips" },
        m_gold = { "gold", "money", "yellow" },
        m_lucky = { "lucky", "rng" },
        m_cry_echo = { "echo", "retrigger", "retriggers" },
        m_cry_light = { "light" },
        c_base = {"base", "default", "none"},
        ccd = { "ccd" },
        null = { "nil" },
    }

    local enh_suffix = nil

    for i, v in pairs(enh_table) do
        for j, k in pairs(v) do
            if string.lower(G.ENTERED_ENH) == string.lower(k) then
                enh_suffix = i
            end
        end
    end

    if enh_suffix and base_enh ~= "c_base" then
        G.PREVIOUS_ENTERED_ENH = G.ENTERED_ENH
        G.GAME.USING_CODE = false
        Entropy.ChangeEnhancements({G.discard, G.deck, G.hand}, enh_suffix, base_enh, true)
        G.CHOOSE_ENH:remove()
    end
end

G.FUNCS.inherit_cancel = function()
    G.GAME.USING_CODE = false
    G.CHOOSE_ENH:remove()
end

local hand_dt = 0
local hand_dt2 = 0
local set_textref = Blind.draw
function Blind:draw()
    if G.GAME.Interfered then
        G.GAME.blind.chip_text = G.GAME.InterferedText
    end
    set_textref(self)
end
local update_ref = Game.update
function Game:update(dt)
    update_ref(self, dt)
    if G.RPerkeoPack and G.STATE ~= 999 then
        G.RPerkeoPack = false
    end
    hand_dt = (hand_dt or 0) + dt
    hand_dt2 = (hand_dt2 or 0) + dt
    if G.hand_text_area and hand_dt > 0.05 and G.GAME.Interfered then
        G.TAROT_INTERRUPT_PULSE = true
        G.TAROT_INTERRUPT = true
        update_hand_text_random(
        { nopulse = true, immediate=true },
        { handname = srandom(math.random(5,15)), mult = srandom(3), chips = srandom(3)}
        )
        G.TAROT_INTERRUPT_PULSE = false
        G.TAROT_INTERRUPT = false
        G.GAME.InterferedText = srandom(math.random(3,5))
        hand_dt = 0
        --G.GAME.blind.chip_text = srandom(math.random(3,4))
        --G.HUD_blind:recalculate(false)
    end
    if hand_dt2 > 0.05 and G.jokers then
        if CanCreateRuby() then
            local card = FindPush()
            if card and card.config.center.key == "c_entr_push" and CanCreateRuby() then
                if not card.ability.rubysjuice then
                    juice_card_until(card, function(card)
                        return not card.REMOVED
                    end, true)
                    card.ability.rubysjuice = true
                end
            end
        end
        if G.GAME.Ruby then
            G.GAME.RubyAnteTextNum = srandom(1)
        end
        hand_dt2 = 0
    end
    if G.STATE == nil and (G.pack_cards == nil or #G.pack_cards == 0) and G.GAME.DefineBoosterState then
        G.STATE = G.GAME.DefineBoosterState
        G.STATE_COMPLETE = false
        G.GAME.DefineBoosterState = nil
    end
    if G.STATE == nil and not G.DefineBoosterState then
        G.STATE = 1
        G.STATE_COMPLETE = false
    end 
    if G.hand and #G.hand.highlighted <= 0 and G.play and #G.play.cards <= 0 then
        if G.GAME.current_round.current_hand.entr_trans_num_text ~= "" or G.GAME.current_round.current_hand.cry_asc_num_text ~= "" then
            ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.3)
            ease_colour(G.C.UI_MULT, G.C.RED, 0.3)
        end
        G.GAME.current_round.current_hand.entr_trans_num_text = ""
        
    end
end
function FindPush()
    local card = Entropy.GetHighlightedCard({G.hand, G.consumeables, G.pack_cards})
    if card and card.config.center.key == "c_entr_push" then return card end
    for i, v in pairs(G.consumeables.cards) do
        if v.config.center.key == "c_entr_push" then return v end
    end
end
function update_hand_text_random(config, vals)
    G.E_MANAGER:add_event(Event({--This is the Hand name text for the poker hand
    trigger = 'before',
    blockable = not config.immediate,
    delay = config.delay or 0.8,
    func = function()
        local col = G.C.GREEN
        if vals.chips and G.GAME.current_round.current_hand.chips ~= vals.chips then
            local delta = (is_number(vals.chips) and is_number(G.GAME.current_round.current_hand.chips)) and (vals.chips - G.GAME.current_round.current_hand.chips) or 0
            if to_big(delta) < to_big(0) then delta = number_format(delta); col = G.C.RED
            elseif to_big(delta) > to_big(0) then delta = '+'..number_format(delta)
            else delta = number_format(delta)
            end
            if type(vals.chips) == 'string' then delta = vals.chips end
            G.GAME.current_round.current_hand.chips = vals.chips
            G.hand_text_area.chips:update(0)
        end
        if vals.mult and G.GAME.current_round.current_hand.mult ~= vals.mult then
            local delta = (is_number(vals.mult) and is_number(G.GAME.current_round.current_hand.mult))and (vals.mult - G.GAME.current_round.current_hand.mult) or 0
            if to_big(delta) < to_big(0) then delta = number_format(delta); col = G.C.RED
            elseif to_big(delta) > to_big(0) then delta = '+'..number_format(delta)
            else delta = number_format(delta)
            end
            if type(vals.mult) == 'string' then delta = vals.mult end
            G.GAME.current_round.current_hand.mult = vals.mult
            G.hand_text_area.mult:update(0)
        end
        if vals.handname and G.GAME.current_round.current_hand.handname ~= vals.handname then
            G.GAME.current_round.current_hand.handname = vals.handname
        end
        return true
    end}))
end
    
local fork = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 11,
    key = "fork",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
        extra = 1
    },
    pos = {x=0,y=3},
    use = function(self, card, area, copier)
        if area then
			area:remove_from_highlighted(card)
		end
        local total, cards = Entropy.GetHighlightedCards({G.hand, G.pack_cards}, nil, card)
        if total > 0 then
            for i, orig in pairs(cards) do
                local card = copy_card(orig)
                G.E_MANAGER:add_event(Event({
                    trigger="immediate",
                    func = function()
                        local ed = pseudorandom_element(G.P_CENTERS)
                        while ed.set ~= "Enhanced" do
                            ed = pseudorandom_element(G.P_CENTERS)
                        end
                        card:set_ability(ed)
                        card:set_edition({
                            cry_glitched = true,
                        })
                        card:add_to_deck()
                        table.insert(G.playing_cards, card)
                        orig.area:emplace(card)
                        playing_card_joker_effects({ card })
                        return true
                    end,
                }))
            end
        end
    end,
    can_use = function(self, card)
        local num, cards = Entropy.GetHighlightedCards({G.hand, G.pack_cards}, nil, card)
        for i, v in pairs(cards) do
            if v.area == G.pack_cards and not v.base.suit then num = num - 1 end
        end
        return num <= card.ability.extra and num > 0
    end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
}
local push = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 12,
    key = "push",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
        extra = 1
    },
    pos = {x=1,y=3},
    use = function(self, card, area, copier)
        if not CanCreateRuby() then
            for i, v in pairs(G.jokers.cards) do
                if not v.ability or (not v.ability.eternal and not v.ability.cry_absolute) then
                    G.jokers.cards[i]:start_dissolve()
                end
            end
            local rarity = GetJokerSumRarity()
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                local rare = ({
                    [1] = "Common",
                    [2] = "Uncommon",
                    [3] = "Rare",
                    [4] = "Legendary"
                })[rarity] or rarity
                local card = create_card("Joker", G.jokers, nil, rare, nil, nil, nil, "entr_beyond")
                --create_card("Joker", G.jokers, nil, 2, nil, nil, nil, "entr_beyond")
                card:add_to_deck()
                G.jokers:emplace(card)
                card:juice_up(0.3, 0.5)
                return true
            end}))
        else    
            for i, v in pairs(G.jokers.cards) do v:start_dissolve() end
            local key = pseudorandom_element(Entropy.Zeniths, pseudoseed("zenith"))
            add_joker(key):add_to_deck()
            G.jokers.config.card_limit = 1
        end
    end,
    can_use = function(self, card)
        if G.jokers and #G.jokers.cards > 0 then
            for i, v in pairs(G.jokers.cards) do
                if not v.ability or (not v.ability.eternal and not v.ability.cry_absolute) then
                    return true
                end
            end
        end
	end,
    loc_vars = function(self, q, card)
        local mstart = {
            Entropy.randomchar({"(Current rarity: "})
        }
        if CanCreateRuby() then
            for i = 0, 10 do
                mstart[#mstart+1] = Entropy.randomchar(Entropy.stringsplit(Entropy.charset))
            end
        else
            mstart[#mstart+1] = Entropy.randomchar({GetJokerSumRarity(true) or "none"})
        end
        mstart[#mstart+1] = Entropy.randomchar({")"})
        return {
            main_end = mstart,
            vars = {
                CanCreateRuby() and srandom(10) or GetJokerSumRarity(true),
                colours = {
                    {0.6969,0.6969,0.6969,1}
                }
            }
        }
    end,
    
}
function Entropy.randomchar(arr)
    return {
        n = G.UIT.O,
        config = {
            object = DynaText({
                string = arr,
                colours = { HEX("b1b1b1") },
                pop_in_rate = 9999999,
                silent = true,
                random_element = true,
                pop_delay = 0.1,
                scale = 0.3,
                min_cycle_time = 0,
            }),
        },
    }
end
local editions = ({
    ["e_foil"] = 1.25,
    ["e_holo"] = 1.45,
    ["e_polychrome"] = 2,
    ["e_negative"] = 2.1,
    ["e_cry_glitched"] = 1.4,
    ["e_cry_mosaic"] = 2.2,
    ["e_cry_oversaturated"] = 1.5,
    ["e_cry_fragile"] = 1.8,
    ["e_cry_gold"] = 1.7,
    ["e_cry_blurred"] = 1.5,
    ["e_cry_noisy"] = 1.7,
    ["e_cry_astral"] = 2.2,
    ["e_cry_m"] = 1.45
})
function CanCreateRuby()
    if SMODS.Mods.jen and SMODS.Mods.jen.can_load then return false end
    if #G.jokers.cards < 29 then return false end
    local has_all_exotics = true
    for i, v in pairs(G.P_CENTERS) do
        if v.rarity == "cry_exotic" or v.rarity == "entr_hyper_exotic" then
            if not HasJoker(v.key) then has_all_exotics = false end
        end
    end
    local has_all_editions = true
    local num_editions = #editions
    if G.jokers then
        for i, v in pairs(editions) do
            for i2, v2 in pairs(G.jokers.cards) do
                if v2.edition and v2.edition.key == i then num_editions = num_editions - 1 end
            end
            for i2, v2 in pairs(G.consumeables.cards) do
                if v2.edition and v2.edition.key == i then num_editions = num_editions - 1 end
            end
        end
        if num_editions > 0 then has_all_editions = false end
    end
    return has_all_exotics and has_all_editions and to_big(G.GAME.dollars):gt(to_big(10^300):tetrate(2))
end
local e_round = end_round
function end_round()
    e_round()
    local remove_temp = {}
    for i, v in pairs({G.jokers, G.hand, G.consumeables, G.discard, G.deck}) do
            for ind, card in pairs(v.cards) do
                if card.ability then
                    if card.ability.entr_hotfix then
                        card.ability.entr_hotfix_rounds = (card.ability.entr_hotfix_rounds or 5) - 1
                        if card.ability.entr_hotfix_rounds <= 0 then
                            card.ability.entr_hotfix = false
                            
                            card:set_edition({
                                cry_glitched = true,
                            })
                        end
                    end
                    if card.ability.temporary or card.ability.temporary2 then
                        if card.area ~= G.hand and card.area ~= G.play and card.area ~= G.jokers and card.area ~= G.consumeables then card.states.visible = false end
                        card:remove_from_deck()
                        card:start_dissolve()
                        if card.ability.temporary then remove_temp[#remove_temp+1]=card end
                    end
                    if card.ability.entr_yellow_sign then card.ability.entr_yellow_sign = nil end
                    if card.ability.superego then
                        card.ability.superego_copies = (card.ability.superego_copies or 0) + 0.5
                    end
                    card.perma_debuff = nil
                    if card.ability.entr_pseudorandom then
                        card.ability.entr_pseudorandom = false
                        card.ability.cry_rigged = false
                    end
                end
            end
    end
    if #remove_temp > 0 then
        SMODS.calculate_context({remove_playing_cards = true, removed=remove_temp})
    end
end
local increment = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 13,
    key = "increment",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
        extra = 1
    },
    pos = {x=2,y=3},
    use = function(self, card, area, copier)
        local mod = math.floor(card and card.ability.extra or self.config.extra)
        G.E_MANAGER:add_event(Event({
			func = function() --card slot
				-- why is this in an event?
				change_shop_size(mod)
				return true
			end,
		}))
        G.GAME.Increment = (G.GAME.Increment or 0) + mod
        G.GAME.IncrementAnte = G.GAME.round_resets.ante
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                math.floor(card and card.ability.extra or self.config.extra)
            }
        }
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}
local decrement = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 14,
    key = "decrement",
    set = "RCode",
    can_stack = true,
	can_divide = true,

    atlas = "miscc",
    config = {
        extra = 1
    },
    pos = {x=3,y=3},
    use = function(self, card, area, copier)
        for i, v in pairs(G.jokers.cards) do
            if v.highlighted and i > GetAreaIndex(G.jokers.cards, card) 
            and not v.ability.cry_absolute then --you cannot run, you cannot hide
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                    --local c = create_card("Joker", G.jokers, nil, nil, nil, nil, key) 
                    --c:add_to_deck()    
                    --G.jokers:emplace(c)
                    --v:start_dissolve()#
                    local v2 = G.jokers.cards[i]
                    if G.P_CENTER_POOLS["Joker"][ReductionIndex(v2, "Joker")-1] then
                        key = G.P_CENTER_POOLS["Joker"][ReductionIndex(v2, "Joker")-1].key
                        --local c = create_card("Joker", G.jokers, nil, nil, nil, nil, key) 
                        --c:add_to_deck()    
                        v2:start_dissolve()
                        G.jokers:remove_from_highlighted(v2, true)
                        local edition = v.edition
                        local sticker = v.sticker
                        v2 = create_card("Joker", G.jokers, nil, nil, nil, nil, key) 
                        v2:add_to_deck()
                        v2:set_card_area(G.jokers)
                        v2.edition = edition
                        v2.sticker = sticker
                        G.jokers.cards[i] = v2
                    end
                    return true
                end
                }))
            end
        end
    end,
    can_use = function(self, card)
        return #G.jokers.highlighted == math.floor(card.ability.extra)
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.extra,
                math.floor(card.ability.extra) > 1 and "s" or "",
                math.floor(card.ability.extra) > 1 and "them" or "it"
            }
        }
    end
}
local invariant = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "entr_pinned"
        }
    },
    object_type = "Consumable",
    order = 15,
    key = "invariant",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
        extra = 1
    },
    pos = {x=4,y=3},
    use = function(self, card, area, copier)
        Entropy.ApplySticker(Entropy.GetHighlightedCard({G.shop_jokers, G.shop_booster, G.shop_vouchers}, nil, card), "entr_pinned")
    end,
    can_use = function(self, card)
        return Entropy.GetHighlightedCard({G.shop_jokers, G.shop_booster, G.shop_vouchers}, nil, card)
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "entr_pinned", set="Other"}
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}
SMODS.Atlas { key = 'entr_stickers', path = 'stickers.png', px = 71, py = 95 }
local pinned = {
    object_type="Sticker",
    order=2,
    atlas = "entr_stickers",
    pos = { x = 1, y = 0 },
    key = "entr_pinned",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("FF0000"),
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        if not G.shared_stickers["entr_pinned2"] then
            G.shared_stickers["entr_pinned2"] =
                Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["entr_stickers"], { x = 0, y = 0 })
        end -- no matter how late i init this, it's always late, so i'm doing it in the damn draw function

        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers["entr_pinned2"].role.draw_major = card

        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)

        card.hover_tilt = card.hover_tilt / 2 -- call it spaghetti, but it's what hologram does so...
        G.shared_stickers["entr_pinned2"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
        G.shared_stickers["entr_pinned2"]:draw_shader(
            "hologram",
            nil,
            card.ARGS.send_to_shader,
            notilt,
            card.children.center
        ) -- this doesn't really do much tbh, but the slight effect is nice
        card.hover_tilt = card.hover_tilt * 2
    end,
    apply = function(self,card,val) 
        card.ability.entr_pinned_round = G.GAME.round
        card.ability.entr_pinned = true
        if not G.GAME.entr_pinned_cards then G.GAME.entr_pinned_cards = {} end
        if card.area then
            G.GAME.entr_pinned_cards[#G.GAME.entr_pinned_cards+1] = {
                area = Entropy.GetAreaName(card.area),
                card = card.config.center.key,
                pos = Entropy.GetIdxInArea(card)
            }
        end
    end,
    calculate = function(self, card, context)

    end
}
local use_cardref= G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
    local val = use_cardref(e, mute, nosave)
    if e.config.ref_table.ability.entr_pinned then
        for i, v in pairs(G.GAME.entr_pinned_cards or {}) do
            if v.card == e.config.ref_table.config.center.key then 
                G.GAME.entr_pinned_cards[i] = nil
                return val 
            end
        end
    end
    return val
end
G.FUNCS.reroll_shop = function(e) 
    stop_use()
    G.CONTROLLER.locks.shop_reroll = true
    if G.CONTROLLER:save_cardarea_focus('shop_jokers') then G.CONTROLLER.interrupt.focus = true end
    if G.GAME.current_round.reroll_cost > 0 then 
      inc_career_stat('c_shop_dollars_spent', G.GAME.current_round.reroll_cost)
      inc_career_stat('c_shop_rerolls', 1)
    end
    ease_dollars(-G.GAME.current_round.reroll_cost)
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          local final_free = G.GAME.current_round.free_rerolls > 0
          G.GAME.current_round.free_rerolls = math.max(G.GAME.current_round.free_rerolls - 1, 0)
          G.GAME.round_scores.times_rerolled.amt = G.GAME.round_scores.times_rerolled.amt + 1

          calculate_reroll_cost(final_free)
          for i = #G.shop_jokers.cards,1, -1 do
            local c  =G.shop_jokers.cards[i]
            if not c.ability.entr_pinned or c.ability.entr_pinned_round ~= G.GAME.round then
                c = G.shop_jokers:remove_card(G.shop_jokers.cards[i])
                c:remove()
                c = nil
            end
          end

          --save_run()

          play_sound('coin2')
          play_sound('other1')
          
          for i = 1, G.GAME.shop.joker_max - #G.shop_jokers.cards do
            local new_shop_card = create_card_for_shop(G.shop_jokers)
            G.shop_jokers:emplace(new_shop_card)
            new_shop_card:juice_up()
          end
          return true
        end
      }))
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.3,
        func = function()
        G.E_MANAGER:add_event(Event({
          func = function()
            G.CONTROLLER.interrupt.focus = false
            G.CONTROLLER.locks.shop_reroll = false
            G.CONTROLLER:recall_cardarea_focus('shop_jokers')
            SMODS.calculate_context({reroll_shop = true, cost = reroll_cost})
            return true
          end
        }))
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({ func = function() save_run(); return true end}))
  end

local cookies = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "set_cry_spooky"
        }
    },
    object_type = "Consumable",
    order = 17,
    key = "cookies",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
    },
    pos = {x=5,y=3},
    use = function(self, card, area, copier)
        local card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "entr_beyond")
		card:set_edition({
            negative = true,
            key = "e_negative",
            type = "negative",
            card_limit = 1
        })
		card:add_to_deck()
		G.jokers:emplace(card)
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
    end
}
local segfault = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 18,
    key = "segfault",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
        extra = 1
    },
    pos = {x=0,y=4},
    use = function(self, card, area, copier)
        local key = ""
        local ptype = pseudorandom_element({
            "Booster",
            "Voucher",
            "Tarot",
            "Joker",
            "Consumeable",
        }, pseudoseed("segfault"))
        if ptype == "Consumeable" then
            key = Cryptid.random_consumable("entr_segfault", nil, "c_entr_segfault").key
        else
            key = pseudorandom_element(G.P_CENTERS, pseudoseed("segfault"))
            while key.set ~= ptype do
                key = pseudorandom_element(G.P_CENTERS, pseudoseed("segfault"))
            end
            key = key.key
        end
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        local _card = create_card("Base", G.deck, nil, nil, nil, nil, nil, "segfault")
        SMODS.change_base(_card,pseudorandom_element({"Spades","Hearts","Clubs","Diamonds"}, pseudoseed("entropy")),pseudorandom_element({"2", "3", "4", "5", "6", "7", "8", "9", "10", "Ace", "King", "Queen", "Jack"}, pseudoseed("segfault")))
        if G.P_CENTERS[key] then _card:set_ability(G.P_CENTERS[key]) else print(key) end
        _card:add_to_deck()
        table.insert(G.playing_cards, _card)
        G.deck:emplace(_card)
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {card.ability.extra}
        }
    end,
}
local sudo = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 19,
    key = "sudo",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=1,y=4},
    use = function(self, card, area, copier)
        G.GAME.USING_CODE = true
		G.ENTERED_HAND = ""
		G.CHOOSE_HAND = UIBox({
			definition = create_UIBox_sudo(card),
			config = {
				align = "cm",
				offset = { x = 0, y = 10 },
				major = G.ROOM_ATTACH,
				bond = "Weak",
				instance_type = "POPUP",
			},
		})
        G.GAME.USINGSUDO = true
		G.CHOOSE_HAND.alignment.offset.y = 0
		G.ROOM.jiggle = G.ROOM.jiggle + 1
		G.CHOOSE_HAND:align_to_major()
    end,
    can_use = function(self, card)
        local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
        G.FUNCS.get_poker_hand_info(G.hand.highlighted)
        return text and text ~= "NULL"
	end,
    loc_vars = function(self, q, card)
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}
function create_UIBox_sudo(card)
    G.E_MANAGER:add_event(Event({
        blockable = false,
        func = function()
            G.REFRESH_ALERTS = true
            return true
        end,
    }))
    local t = create_UIBox_generic_options({
        no_back = true,
        colour = HEX("04200c"),
        outline_colour = HEX("FF0000"),
        contents = {
            {
                n = G.UIT.R,
                nodes = {
                    create_text_input({
                        colour = HEX("FF0000"),
                        hooked_colour = darken(copy_table(G.C.SET.RCode), 0.3),
                        w = 4.5,
                        h = 1,
                        max_length = 24,
                        extended_corpus = true,
                        prompt_text = localize("cry_code_hand"),
                        ref_table = G,
                        ref_value = "ENTERED_HAND",
                        keyboard_offset = 1,
                    }),
                },
            },
            {
                n = G.UIT.R,
                nodes = {
                    UIBox_button({
                        colour = HEX("FF0000"),
                        button = "sudo_apply",
                        label = { localize("entr_code_sudo") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
            {
                n = G.UIT.R,
                nodes = {
                    UIBox_button({
                        colour = HEX("FF0000"),
                        button = "sudo_apply_previous",
                        label = { localize("entr_code_sudo_previous") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
            {
                n = G.UIT.R,
                nodes = {
                    UIBox_button({
                        colour = G.C.RED,
                        button = "sudo_cancel",
                        label = { localize("cry_code_cancel") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
        },
    })
    return t
end
G.FUNCS.sudo_apply_previous = function()
    if G.PREVIOUS_ENTERED_HAND then
        G.ENTERED_HAND = G.PREVIOUS_ENTERED_HAND or ""
    end
    G.FUNCS.sudo_apply()
end
G.FUNCS.sudo_apply = function()
    local hand_table = {
        ["High Card"] = { "high card", "high", "1oak", "1 of a kind", "haha one" },
        ["Pair"] = { "pair", "2oak", "2 of a kind", "m" },
        ["Two Pair"] = { "two pair", "2 pair", "mm", "pairpair" },
        ["Three of a Kind"] = { "three of a kind", "3 of a kind", "3oak", "trips", "triangle" },
        ["Straight"] = { "straight", "lesbian", "gay", "bisexual", "asexual" },
        ["Flush"] = { "flush", "skibidi", "toilet", "floosh" },
        ["Full House"] = {
            "full house",
            "full",
            "that 70s show",
            "modern family",
            "family matters",
            "the middle",
        },
        ["Four of a Kind"] = {
            "four of a kind",
            "4 of a kind",
            "4oak",
            "22oakoak",
            "quads",
            "four to the floor",
        },
        ["Straight Flush"] = { "straight flush", "strush", "slush", "slushie", "slushy" },
        ["Five of a Kind"] = { "five of a kind", "5 of a kind", "5oak", "quints" },
        ["Flush House"] = { "flush house", "flouse", "outhouse" },
        ["Flush Five"] = { "flush five", "fish", "you know what that means", "five of a flush" },
        ["cry_Bulwark"] = { "bulwark", "flush rock", "stoned", "stone flush", "flush stone" },
        ["cry_Clusterfuck"] = { "clusterfuck", "fuck", "wtf" },
        ["cry_UltPair"] = { "ultimate pair", "ultpair", "ult pair", "pairpairpair" },
        ["cry_WholeDeck"] = { "the entire fucking deck", "deck", "tefd", "fifty-two", "you are fuck deck" },
    }
    local current_hand = nil
    for k, v in pairs(SMODS.PokerHands) do
        local index = v.key
        local current_name = G.localization.misc.poker_hands[index]
        if not hand_table[v.key] then
            hand_table[v.key] = { current_name }
        end
    end
    for i, v in pairs(hand_table) do
        for j, k in pairs(v) do
            if string.lower(G.ENTERED_HAND) == string.lower(k) then
                current_hand = i
            end
        end
    end
    if current_hand == "cry_WholeDeck" then current_hand = nil end
    if current_hand then
        G.PREVIOUS_ENTERED_HAND = G.ENTERED_HAND
        local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
        G.FUNCS.get_poker_hand_info(G.hand.highlighted)
        if not G.GAME.SudoHand then G.GAME.SudoHand = {} end
        G.GAME.SudoHand[text] = current_hand
        G.FUNCS.sudo_cancel()
        return
    end
end
G.FUNCS.sudo_cancel = function()
    G.CHOOSE_HAND:remove()
    G.GAME.USING_CODE = false
    G.GAME.USINGSUDO = nil
end
-- mess with poker hand evaluation
local evaluate_poker_hand_ref = evaluate_poker_hand
function evaluate_poker_hand(hand)
    local results = evaluate_poker_hand_ref(hand)
    for i, v in ipairs(G.handlist) do
        if G.GAME.SudoHand and G.GAME.SudoHand[v] and not G.GAME.USINGSUDO then
            results[G.GAME.SudoHand[v]] = results[v]
        end
        if G.GAME.Interfered then
            results[v] = results[pseudorandom_element(G.handlist, pseudoseed("interfered"))]
        end
    end
    return results
end
local htuis = G.FUNCS.hand_text_UI_set
G.FUNCS.hand_text_UI_set = function(e)
    htuis(e)
    if G.GAME.cry_exploit_override then
        e.config.object.colours = { G.C.SET.RCode }
    else
        e.config.object.colours = { G.C.UI.TEXT_LIGHT }
    end
    e.config.object:update_text()
end
local overflow = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "set_cry_poker_hand_stuff"
        }
    },
    object_type = "Consumable",
    order = 20,
    key = "overflow",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=2,y=4},
    use = function(self, card, area, copier)
        G.GAME.Overflow = G.hand.config.highlighted_limit
        G.hand.config.highlighted_limit = 9999
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

local refactor = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 21,
    key = "refactor",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
    },
    pos = {x=3,y=4},
    use = function(self, card, area, copier)
        local edition = G.jokers.highlighted[1].edition
        local card = pseudorandom_element(G.jokers.cards, pseudoseed("refactor"))
        local tries = 0
        while card.unique_val == G.jokers.highlighted[1].unique_val and tries < 50 do
            card = pseudorandom_element(G.jokers.cards, pseudoseed("refactor"))
            tries = tries + 1
        end
        G.E_MANAGER:add_event(Event({
            trigger="after",
            delay = 0.15,
            func = function() 
                card:flip()
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger="after",
            delay = 1,
            func = function() 
                card:remove_from_deck()
                card:set_edition(edition)
                card:add_to_deck()
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger="after",
            delay = 0.15,
            func = function() 
                card:flip()
                return true
            end,
        }))
    end,
    can_use = function(self, card)
        return #G.jokers.highlighted == 1
	end,
    loc_vars = function(self, q, card)
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}
--hotfix
local hotfix = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "entr_hotfix"
        }
    },
    object_type = "Consumable",
    order = 22,
    key = "hotfix",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    pos = {x=1,y=5},
    use = function(self, card, area, copier)
        Entropy.ApplySticker(Entropy.GetHighlightedCard({G.hand, G.jokers, G.consumeables}, nil, card), "entr_hotfix")
    end,
    can_use = function(self, card)
        return Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables}, nil, card) == 1
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "entr_hotfix", set="Other"}
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}
local hotfix_sticker = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Sticker",
    order=3,
    atlas = "entr_stickers",
    pos = { x = 3, y = 0 },
    key = "entr_hotfix",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("FF0000"),
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        if not G.shared_stickers["entr_hotfix2"] then
            G.shared_stickers["entr_hotfix2"] =
                Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["entr_stickers"], { x = 2, y = 0 })
        end -- no matter how late i init this, it's always late, so i'm doing it in the damn draw function

        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers["entr_hotfix2"].role.draw_major = card

        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)

        card.hover_tilt = card.hover_tilt / 2 -- call it spaghetti, but it's what hologram does so...
        G.shared_stickers["entr_hotfix2"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
        G.shared_stickers["entr_hotfix2"]:draw_shader(
            "hologram",
            nil,
            card.ARGS.send_to_shader,
            notilt,
            card.children.center
        ) -- this doesn't really do much tbh, but the slight effect is nice
        card.hover_tilt = card.hover_tilt * 2
    end,
    apply = function(self,card,val) 
        card.ability.entr_hotfix = true
        if card.area then
        if card.debuff then card.debuff = false end
        card.ability.entr_hotfix_rounds = pseudorandom_element({5,6,7,8,9,10,11,12,13,14,15}, pseudoseed("hotfix"))
        end
    end,
    calculate = function(self, card, context)
        if card.debuff then card.debuff = false end
    end
}
local debuff_ref = Card.set_debuff
function Card:set_debuff(should_debuff)
    if not self.ability.entr_hotfix then
        debuff_ref(self, should_debuff)
    end
end
local ctrl_x = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 23,
    key = "ctrl_x",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    pos = {x=2,y=5},
    use = function(self, card, area, copier)
        if G.GAME.ControlXCard then
            local card = paste_card(G.GAME.ControlXCard.card)
            local area = G[G.GAME.ControlXCard.area]

            card:add_to_deck()
            if not area then 
                if card.set == "Joker" then area = G.jokers
                elseif card.set == "Default" or card.set == "Enhanced" then area = G.hand
                else area = G.consumeables end
            end
            area:emplace(card)
            if area == G.hand then
                table.insert(G.playing_cards, card)
            end
            if area == G.shop_vouchers or area == G.shop_jokers then
                area.config.card_limit = area.config.card_limit + 1
            end
            area:align_cards()
            G.GAME.ControlXCard = nil
        else
            local card2 = Entropy.GetHighlightedCard({G.hand, G.jokers, G.shop_jokers, G.pack_cards, G.shop_booster, G.shop_vouchers, G.consumeables})
            local area2 = nil
            for i, v in pairs(G) do
                if v == card2.area then area2 = i end
            end
            G.GAME.ControlXCard = {
                area = area2,
                card = {
                    T = card2.T,
                    ability = card2.config.center.key,
                    center = card2.config.center,
                    set = card2.config.center.set,
                    card = card2.config.card,
                    edition = card2.edition,
                    params = card2.params,
                    seal = card2.seal,
                    debuff = card2.debuff,
                    pinned = card2.pinned,
                    label = GetCardName(card2),
                    shop = G[area2].config.type == "shop"
                }
            }
            card2:remove()
            card2:start_dissolve()
            G.consumeables:emplace(copy_card(card))
        end
    end,
    can_use = function(self, card)
        return (Entropy.GetHighlightedCards({G.hand, G.jokers, G.shop_jokers, G.pack_cards, G.shop_booster, G.shop_vouchers, G.consumeables}, nil, card) == 1) 
        or (G.GAME.ControlXCard)
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                G.GAME.ControlXCard and "Paste" or "Cut",
                G.GAME.ControlXCard and "the stored" or "one selected",
                G.GAME.ControlXCard and G.GAME.ControlXCard.card.label or "none"
            }
        }
    end,
    entr_credits = {
	},
}
local multithread = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "temporary"
        }
    },
    object_type = "Consumable",
    order = 24,
    key = "multithread",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "miscc",
    config = {
    },
    pos = {x=3,y=5},
    use = function(self, card, area, copier)
        for i, v in pairs(G.hand.highlighted) do
            local c = copy_card(v)
            c:set_edition({
                negative=true,
                key="e_negative",
                card_limit=1,
                type="negative"
            })
            c:add_to_deck()
            c.ability.temporary = true
            G.hand:emplace(c)
        end 
    end,
    can_use = function(self, card)
        return Entropy.GetHighlightedCards({G.hand}, nil, card) > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "temporary", set="Other"}
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}
local temporary = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Sticker",
    order = 4,
    atlas = "entr_stickers",
    pos = { x = 3, y = 1 },
    key = "temporary",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("FF0000"),
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        if not G.shared_stickers["entr_temporary2"] then
            G.shared_stickers["entr_temporary2"] =
                Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["entr_stickers"], { x = 2, y = 1 })
        end -- no matter how late i init this, it's always late, so i'm doing it in the damn draw function

        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers["entr_temporary2"].role.draw_major = card

        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)

        card.hover_tilt = card.hover_tilt / 2 -- call it spaghetti, but it's what hologram does so...
        G.shared_stickers["entr_temporary2"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
        G.shared_stickers["entr_temporary2"]:draw_shader(
            "hologram",
            nil,
            card.ARGS.send_to_shader,
            notilt,
            card.children.center
        ) -- this doesn't really do much tbh, but the slight effect is nice
        card.hover_tilt = card.hover_tilt * 2
    end,
    apply = function(self,card,val)
        card.ability.temporary = true
    end,
}
function CardArea:get_card(card, discarded_only)
    if not self.cards then return end
    local _cards = discarded_only and {} or self.cards
    if discarded_only then 
        for k, v in ipairs(self.cards) do
            if v.ability and v.ability.discarded then 
                _cards[#_cards+1] = v
            end
        end
    end
    if self.config.type == 'discard' or self.config.type == 'deck' then
        card = card or _cards[#_cards]
    else
        card = card or _cards[1]
    end
    return card
end
function AreaExists(area)
    if area.config.type == "shop" then return G.STATE == G.STATES.SHOP end
    if area.config.type == "hand" then return G.STATE == G.STATES.SELECTING_HAND end
    return true
end
function GetCardName(card)
    local nodes = Entropy.SafeGetNodes(3, card)
    if not nodes then return "ERROR" end
    nodes = nodes.nodes
    local text = ""
    for i, v in pairs(nodes) do
        if v.config.text then text = text..v.config.text end
    end
    if text == "" then
        text = create_UIBox_detailed_tooltip(card.config.center).nodes[1].nodes[1].nodes[1].nodes[1].config.text
        return text
    end
    return string.sub(text, 2,-2)
end
function paste_card(other, new_card, card_scale, playing_card, strip_edition)
    if other.set == "Booster" then card_scale = 2.6/2.0 end
    local new_card = new_card or Card(other.T.x, other.T.y, G.CARD_W*(card_scale or 1), G.CARD_H*(card_scale or 1), G.P_CARDS.empty, G.P_CENTERS.c_base, {playing_card = playing_card})
    if other.shop then
        create_shop_card_ui(new_card)
    end
    new_card:set_ability(other.center, false)
    new_card.ability.type = other.ability.type
    new_card:set_base(other.card, false)
    if not strip_edition then 
        new_card:set_edition(other.edition or {}, nil, true)
    end
    check_for_unlock({type = 'have_edition'})
    new_card:set_seal(other.seal, true)
    if other.params then
        new_card.params = other.params
        new_card.params.playing_card = playing_card
    end
    new_card.debuff = other.debuff
    new_card.pinned = other.pinned

    return new_card
end

local update_round_evalref = Game.update_round_eval
function Game:update_round_eval(dt)
    update_round_evalref(self, dt)
    if G.GAME.Overflow then
        G.hand.config.highlighted_limit = G.GAME.Overflow
        G.GAME.Overflow = nil
    end
    if G.GAME.Interfered then
        G.TAROT_INTERRUPT_PULSE = true
        G.TAROT_INTERRUPT = true
        update_hand_text_random(
        { nopulse = true, immediate=true },
        { handname = "", mult = 0, chips=0}
        )
        G.TAROT_INTERRUPT_PULSE = false
        G.TAROT_INTERRUPT = false
        G.GAME.Interfered = nil
    end
    if G.GAME.IncrementAnte and G.GAME.IncrementAnte ~= G.GAME.round_resets.ante then
        G.GAME.IncrementAnte = nil
        if G.GAME.Increment then
            G.E_MANAGER:add_event(Event({
                func = function() --card slot
                    -- why is this in an event?
                    change_shop_size(-G.GAME.Increment)
                    G.GAME.Increment = nil
                    return true
                end,
            }))
        end
    end
end
local pokerhandinforef = G.FUNCS.get_poker_hand_info
function G.FUNCS.get_poker_hand_info(_cards)
    local text, loc_disp_text, poker_hands, scoring_hand, disp_text = pokerhandinforef(_cards)
    local hand_table = {
		["High Card"] = G.GAME.used_vouchers.v_cry_hyperspacetether and 1 or nil,
		["Pair"] = G.GAME.used_vouchers.v_cry_hyperspacetether and 2 or nil,
		["Two Pair"] = 4,
		["Three of a Kind"] = G.GAME.used_vouchers.v_cry_hyperspacetether and 3 or nil,
		["Straight"] = next(SMODS.find_card("j_four_fingers")) and Cryptid.gameset() ~= "modest" and 4 or 5,
		["Flush"] = next(SMODS.find_card("j_four_fingers")) and Cryptid.gameset() ~= "modest" and 4 or 5,
		["Full House"] = 5,
		["Four of a Kind"] = G.GAME.used_vouchers.v_cry_hyperspacetether and 4 or nil,
		["Straight Flush"] = next(SMODS.find_card("j_four_fingers")) and Cryptid.gameset() ~= "modest" and 4 or 5, --debatable
		["cry_Bulwark"] = 5,
		["Five of a Kind"] = 5,
		["Flush House"] = 5,
		["Flush Five"] = 5,
		["cry_Clusterfuck"] = 8,
		["cry_UltPair"] = 8,
		["cry_WholeDeck"] = 52,
	}
    if Entropy.CheckTranscendence(_cards) ~= "None" or (G.GAME.hands[text] and G.GAME.hands[text].TranscensionPower) then
        ease_colour(G.C.UI_CHIPS, copy_table(HEX("84e1ff")), 0.3)
		ease_colour(G.C.UI_MULT, copy_table(HEX("84e1ff")), 0.3)
    elseif hand_table[text] and next(scoring_hand) and #scoring_hand > hand_table[text] and G.GAME.Overflow then
		ease_colour(G.C.UI_CHIPS, copy_table(HEX("FF0000")), 0.3)
		ease_colour(G.C.UI_MULT, copy_table(HEX("FF0000")), 0.3)
        if not G.C.UI_GOLD then G.C.UI_GOLD = G.C.GOLD end
        ease_colour(G.C.GOLD, copy_table(HEX("FF0000")), 0.3)
    elseif G.GAME.hands[text] and G.GAME.hands[text].AscensionPower then
        ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.3)
		ease_colour(G.C.UI_MULT, copy_table(G.C.GOLD), 0.3)
    else
        ease_colour(G.C.GOLD, copy_table(HEX("EABA44")), 0.3)
	end
    if G.GAME.hands[text] and G.GAME.hands[text].AscensionPower then
		G.GAME.current_round.current_hand.cry_asc_num = G.GAME.current_round.current_hand.cry_asc_num + G.GAME.hands[text].AscensionPower
	end
    G.GAME.current_round.current_hand.cry_asc_num = (G.GAME.current_round.current_hand.cry_asc_num or 0) * (1+(G.GAME.nemesisnumber or 0))
    if Entropy.BlindIs(G.GAME.blind, "bl_entr_scarlet_sun") and not G.GAME.blind.disabled then 
        G.GAME.current_round.current_hand.cry_asc_num = G.GAME.current_round.current_hand.cry_asc_num * -1
    end
    if Entropy.CheckTranscendence(_cards) ~= "None" then
        G.GAME.current_round.current_hand.entr_trans_num_text = "Transcendant "
        G.GAME.TRANSCENDENT = true
    end
	if to_big(G.GAME.current_round.current_hand.cry_asc_num) ~= to_big(0) then
        if to_big(G.GAME.current_round.current_hand.cry_asc_num) > to_big(0) then
            G.GAME.current_round.current_hand.cry_asc_num_text = " (+"..G.GAME.current_round.current_hand.cry_asc_num..")"
        else    
            G.GAME.current_round.current_hand.cry_asc_num_text = " ("..G.GAME.current_round.current_hand.cry_asc_num..")"
        end
    else
        G.GAME.current_round.current_hand.cry_asc_num_text = ""
    end
    if Entropy.CheckTranscendence(_cards) == "None" then
        G.GAME.current_round.current_hand.entr_trans_num_text = ""
    end
    if Entropy.BlindIs(G.GAME.blind, "bl_entr_scarlet_sun") and not G.GAME.blind.disabled then 
        G.GAME.current_round.current_hand.cry_asc_num = G.GAME.current_round.current_hand.cry_asc_num * -1
    end
    return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end

local evaluateroundref = G.FUNCS.evaluate_round
function G.FUNCS.evaluate_round()
	evaluateroundref()
	-- This is just the easiest way to check if its gold because lua is annoying
	if G.C.UI_GOLD then
		ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.3)
		ease_colour(G.C.UI_MULT, G.C.RED, 0.3)
        ease_colour(G.C.GOLD, G.C.UI_GOLD, 0.3)
        G.C.UI_GOLD = nil
	end
    G.GAME.current_round.current_hand.entr_trans_num_text = ""
end
local ref = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
    local cards = G.hand.highlighted
    local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
    G.FUNCS.get_poker_hand_info(cards)
    if G.GAME.hands[text] and G.GAME.TRANSCENDENT then
        G.GAME.hands[text].TranscensionPower = (G.GAME.hands[text].TranscensionPower or 1) + 0.1
        if G.GAME.hands[text].AscensionPower and G.GAME.hands[text].AscensionPower <= 1 then
            G.GAME.hands[text].AscensionPower =G.GAME.hands[text].AscensionPower + 0.1
        end
        if not G.GAME.hands[text].AscensionPower then
            G.GAME.hands[text].AscensionPower = 0.1
        end
        G.GAME.TRANSCENDENT = nil
    end
    G.GAME.TRANSCENDENT = nil
    ref(e)
end

local autostart = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 25,
    key = "autostart",
    set = "RCode",
    can_stack = true,
	can_divide = true,

    atlas = "miscc",
    pos = {x=4,y=5},
    config = {
        tags = 3
    },
    use = function(self, card, area, copier)
        for i = 1, card.ability.tags do
            add_tag(Tag(pseudorandom_element(G.GAME.autostart_tags, pseudoseed("autostart"))))
        end
    end,
    can_use = function(self, card)
        return G.GAME.autostart_tags
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.tags
            }
        }
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}
local add_tagref = add_tag
function add_tag(_tag)
    add_tagref(_tag)
    if not G.GAME.autostart_tags then G.GAME.autostart_tags = {} end
    if not G.GAME.autostart_tags[_tag.key] then G.GAME.autostart_tags[_tag.key] = _tag.key end
end

local local_card = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "temporary"
        }
    },
    object_type = "Consumable",
    order = 26,
    key = "local",
    set = "RCode",
    can_stack = true,
	can_divide = true,

    atlas = "miscc",
    pos = {x=0,y=6},
    config = {
        select = 3
    },
    use = function(self, card, area, copier)
        Entropy.FlipThen(G.hand.highlighted, function(card) card.ability.temporary = true end)
    end,
    can_use = function(self, card)
        return G.hand and Entropy.GetHighlightedCards({G.hand}, nil, card) > 0 and Entropy.GetHighlightedCards({G.hand}, nil, card) <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        q[#q+1]={set="Other",key="temporary"}
        return {
            vars = {
                card.ability.select
            }
        }
    end,
}

local DefineBlacklist = {
    ["c_soul"] = true,
    ["c_entr_fervour"] = true,
    ["c_cry_gateway"] = true,
    ["c_cry_pointer"] = true,
    ["c_entr_beyond"] = true,
    ["c_entr_define"] = true,

    ["j_jolly"] = true,
    ["j_obelisk"] = true,

    ["p_cry_empowered"] = true
}
for i, v in pairs(DefineBlacklist) do Entropy.DefineBlacklist[i] = v end
local matref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    if G.SETTINGS.paused then             matref(self, center or {}, initial, delay_sprites)

    elseif initial and self.config and self.config.center and G.GAME.DefineKeys and G.GAME.DefineKeys[self.config.center.key] and not G.GAME.DefineKeys[self.config.center.key].playing_card and center.set ~= "Default" and center.set ~= "Enhanced"
        then
            matref(self, G.P_CENTERS[G.GAME.DefineKeys[self.config.center.key]], initial, delay_sprites)
            if G.GAME.DefineKeys[self.config.center.key] and G.P_CENTERS[G.GAME.DefineKeys[self.config.center.key]] and G.P_CENTERS[G.GAME.DefineKeys[self.config.center.key]].set == "Booster" then
                self.card.from_define = true
            end

        else
            matref(self, center or {}, initial, delay_sprites)
        end
end

--allow defined playing cards as packs and jokers to be opened / pulled

local baseref = Card.set_base

function Card:set_base(card, initial)
    baseref(self, card, initial)
    local s = self.base and self.base.name or ""
    if (not self.area or not self.area.config.collection) and not G.SETTINGS.paused then
        if G.GAME.DefineKeys and G.GAME.DefineKeys[s] and not G.GAME.DefineKeys[s].playing_card then
            if self.config and self.config.center and G.GAME.DefineKeys and G.GAME.DefineKeys[s] and (initial or not G.VIEWING_DECK) and G.P_CENTERS[G.GAME.DefineKeys[s]] then
                matref(self, G.P_CENTERS[G.GAME.DefineKeys[s]] or {}, initial, false)
            end
        end
    end
end

local emplace = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    if self == G.pack_cards then self.config.highlighted_limit = 2 end
    card = card or {}
    local s = self.base and self.base.name or ""
    local key = G.GAME.DefineKeys and (G.GAME.DefineKeys[s] or G.GAME.DefineKeys[card.config.center.key])
    if self.config.collection or G.SETTINGS.paused or not key or G.GAME.akyrs_any_drag then
        emplace(self, card,location,stay_flipped)
    else
        if G.GAME.DefineKeys and key and key.playing_card and self.config.type ~= "play" then
            if self == G.consumeables or self == G.jokers then
                local pcard = GetDefinePlayingCard(key, G.hand, G.playing_cards)
                if #G.hand.cards > 0 then G.hand:emplace(pcard) end
                playing_card_joker_effects({ pcard })
                card:start_dissolve()
            else
                if self == G.shop_jokers or self == G.shop_vouchers or self == G.shop_boosters then
                    GetDefinePlayingCard(key, self, nil, true, true)
                else
                    GetDefinePlayingCard(key, self, nil, true)
                end
                card:start_dissolve()
            end
        else
            if G.consumeables and (self == G.consumeables or self == G.jokers) and card and card.config.center.set == "Voucher" then
                card.cost = 0
                card:redeem()
                card:start_dissolve()
            elseif G.consumeables and (self == G.consumeables or self == G.jokers) and card and card.config.center.set == "Booster" then
                if G.STATE == 999 or not card.from_define then
                    emplace(self, G.consumeables,location,stay_flipped)
                    if self == G.consumeables then
                        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
                    end
                else
                    G.GAME.DefineBoosterState = G.STATE
                    card:open()
                end
            elseif G.consumeables and self == G.consumeables and card and card.config.center.set == "Joker" then
                emplace(G.jokers, card, location, stay_flipped)
            elseif G.jokers and self == G.jokers and card and card.ability.consumeable then
                emplace(G.consumeables, card, location, stay_flipped)
            else
                emplace(self, card,location,stay_flipped)
            end
        end
    end
end

function GetDefinePlayingCard(tbl, area, insert, emplace, shop)    
    local _card = create_card("Base", area, nil, nil, nil, nil, nil, "pointer")
    if shop then
        create_shop_card_ui(_card)
    end
    SMODS.change_base(
        _card,
        tbl.suit ~= "" and tbl._suit
            or pseudorandom_element(
                { "Spades", "Hearts", "Diamonds", "Clubs" },
                pseudoseed("sigil")
            ),
            tbl._rank
    )
    if tbl._enh ~= "" then
        _card:set_ability(G.P_CENTERS[tbl._enh])
    end
    if tbl._rank == 1 then
        _card:set_ability(G.P_CENTERS["m_stone"])
    end
    if tbl._seal ~= "" then
        _card:set_seal(tbl._seal, true, true)
    end
    if tbl._ed ~= "" then
        _card:set_edition(tbl._ed, true, true)
    end
    if tbl._stickers then
        for i = 1, #tbl._stickers do
            _card.ability[tbl._stickers[i]] = true
            if tbl._stickers[i] == "pinned" then
                _card.pinned = true
            end
        end
    end
    playing_card_joker_effects({ _card })
    _card:add_to_deck()
    if not emplace then table.insert(insert or area.cards, _card)
    else area:emplace(_card) end
    return _card
end


local ed_ref = Card.set_edition

function Card:set_edition(edition, immediate, silent)
    if self.edition and edition and self.edition.negative and not edition.negative and self.config.center.type == "Booster" and self.area == G.consumeables then
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
    end
    ed_ref(self,edition, immediate, silent)
end

return {
    items = {
        memory_leak,
        root_kit,
        bootstrap,
        quickload,
        break_card,
        new,
        interference,
        constant,
        pseudorandom,
        pseudorandom_sticker,
        inherit,
        fork,
        push,
        increment,
        decrement,
        invariant,
        pinned,
        cookies,
        segfault,
        sudo,
        overflow,
        refactor,
        hotfix,
        hotfix_sticker,
        ctrl_x,
        multithread,
        temporary,
        autostart,
        local_card,
        rr
    }
}

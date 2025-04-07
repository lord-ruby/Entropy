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

SMODS.Consumable({
    key = "memory_leak",
    set = "RCode",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {

    },
    pos = {x=0,y=1},
    use = function(self, card, area, copier)
        error("\nx.x\nAw Snap!\nSomething went wrong whilst displaying this webpage.\n\nLearn More.")
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)

    end
})

SMODS.Consumable({
    key = "root_kit",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
})

SMODS.Consumable({
    key = "bootstrap",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
})
local main_ref = evaluate_play_main
function evaluate_play_main(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    local m = G.GAME.hands[text].mult
    local c = G.GAME.hands[text].chips
    if G.GAME.Bootstrap then
        poker_hands[text].mult = G.GAME.Bootstrap.Mult
        poker_hands[text].chips = G.GAME.Bootstrap.Chips
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
    poker_hands[text].mult = m
    poker_hands[text].chips = c
end
SMODS.Consumable({
    key = "quickload",
    set = "RCode",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    pos = {x=3,y=1},
    use = function(self, card, area, copier)
        G.STATE = 8
        G.STATE_COMPLETE = false
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
})
local dft = Blind.defeat
function Blind:defeat(s)
    if self.config.blind.key ~= nil then
        dft(self, s)
    end

end
local atm = Moveable.align_to_major
function Moveable:align_to_major()
    if not self.role then
        self.role = {}
    end
    if not self.role.offset then 
        self.role.offset = {}
    end
    self.alignment.offset.y = self.alignment.offset.y or 0
    self.alignment.offset.x = self.alignment.offset.x or 0
    self.role.offset.y = self.role.offset.y or 0
    self.role.offset.x = self.role.offset.x or 0
    atm(self)
end
local break_timer = 0
SMODS.Consumable({
    key = "break",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
				G.GAME.USING_CODE = true
				--G.GAME.USING_RUN = true
				--G.GAME.RUN_STATE_COMPLETE = 0
				G.STATE_COMPLETE = false
                G.GAME.USING_BREAK = true
                break_timer = 0
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
})

SMODS.Consumable({
    key = "new",
    set = "RCode",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=0,y=2},
    use = function(self, card, area, copier)
        Interfere()
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
})
SMODS.Atlas({key = 'blinds', path = 'blinds.png', px = 34, py = 34, frames = 21, atlas_table = 'ANIMATION_ATLAS'})
SMODS.Blind({
	name = "entr-red",
	key = "red",
	pos = { x = 0, y = 0 },
	atlas = "blinds",
	boss_colour = HEX("FF0000"),
    mult=1,
    boss = {min=1,max=9999},
    dollars = 3,
    in_pool = function(self) return false end
})

SMODS.Consumable({
    key = "interference",
    set = "RCode",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=1,y=2},
    use = function(self, card, area, copier)
        Interfere()
        G.GAME.Interfered = true
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
})
function create_UIBox_blind_select()
  G.blind_prompt_box = UIBox{
    definition =
      {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.2}, nodes={
        {n=G.UIT.R, config={align = "cm"}, nodes={
          {n=G.UIT.O, config={object = DynaText({string = localize('ph_choose_blind_1'), colours = {G.C.WHITE}, shadow = true, bump = true, scale = 0.6, pop_in = 0.5, maxw = 5}), id = 'prompt_dynatext1'}}
        }},
        {n=G.UIT.R, config={align = "cm"}, nodes={
          {n=G.UIT.O, config={object = DynaText({string = localize('ph_choose_blind_2'), colours = {G.C.WHITE}, shadow = true, bump = true, scale = 0.7, pop_in = 0.5, maxw = 5, silent = true}), id = 'prompt_dynatext2'}}
        }},
        (G.GAME.used_vouchers["v_retcon"] or G.GAME.used_vouchers["v_directors_cut"]) and
        UIBox_button({label = {localize('b_reroll_boss'), localize('$')..Cryptid.cheapest_boss_reroll()}, button = "reroll_boss", func = 'reroll_boss_button'}) or nil
      }},
    config = {align="cm", offset = {x=0,y=-15},major = G.HUD:get_UIE_by_ID('row_blind'), bond = 'Weak'}
  }
  G.E_MANAGER:add_event(Event({
    trigger = 'immediate',
    func = (function()
        G.blind_prompt_box.alignment.offset.y = 0
        return true
    end)
  }))

  local width = G.hand.T.w
  G.GAME.blind_on_deck = 
    not (G.GAME.round_resets.blind_states.Small == 'Defeated' or G.GAME.round_resets.blind_states.Small == 'Skipped' or G.GAME.round_resets.blind_states.Small == 'Hide') and 'Small' or
    not (G.GAME.round_resets.blind_states.Big == 'Defeated' or G.GAME.round_resets.blind_states.Big == 'Skipped'or G.GAME.round_resets.blind_states.Big == 'Hide') and 'Big' or 
    'Boss'
  
  G.blind_select_opts = {}
  if G.GAME.round_resets.red_room then
    G.GAME.blind_on_deck = "Red"
    if not G.GAME.round_resets.blind_choices["Red"] then
        G.GAME.round_resets.blind_choices["Red"] = "bl_entr_red"
    end
    if not G.GAME.round_resets.blind_states['Red'] then
        G.GAME.round_resets.blind_states['Red'] = "Select"
    end
    G.GAME.RedBlindStates = {}
    for i, v in pairs(G.GAME.round_resets.blind_states) do G.GAME.RedBlindStates[i] = v end
    G.GAME.round_resets.loc_blind_states.Red = "Select"
    G.blind_select_opts.red = G.GAME.round_resets.blind_states['Red'] ~= 'Hide' and UIBox{definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={UIBox_dyn_container({create_UIBox_blind_choice('Red')},false,get_blind_main_colour('Red'))}}, config = {align="bmi", offset = {x=0,y=0}}} or nil
    local t = {n=G.UIT.ROOT, config = {align = 'tm',minw = width, r = 0.15, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0.5}, nodes={
        G.GAME.round_resets.blind_states['Red'] ~= 'Hide' and {n=G.UIT.O, config={align = "cm", object = G.blind_select_opts.red}} or nil,
        }}
    }}
    G.GAME.round_resets.red_room = nil
    return t 
  else
    G.blind_select_opts.small = G.GAME.round_resets.blind_states['Small'] ~= 'Hide' and UIBox{definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={UIBox_dyn_container({create_UIBox_blind_choice('Small')},false,get_blind_main_colour('Small'))}}, config = {align="bmi", offset = {x=0,y=0}}} or nil
    G.blind_select_opts.big = G.GAME.round_resets.blind_states['Big'] ~= 'Hide' and UIBox{definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={UIBox_dyn_container({create_UIBox_blind_choice('Big')},false,get_blind_main_colour('Big'))}}, config = {align="bmi", offset = {x=0,y=0}}} or nil
    G.blind_select_opts.boss = G.GAME.round_resets.blind_states['Boss'] ~= 'Hide' and UIBox{definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={UIBox_dyn_container({create_UIBox_blind_choice('Boss')},false,get_blind_main_colour('Boss'), mix_colours(G.C.BLACK, get_blind_main_colour('Boss'), 0.8))}}, config = {align="bmi", offset = {x=0,y=0}}} or nil
    
    local t = {n=G.UIT.ROOT, config = {align = 'tm',minw = width, r = 0.15, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0.5}, nodes={
        G.GAME.round_resets.blind_states['Small'] ~= 'Hide' and {n=G.UIT.O, config={align = "cm", object = G.blind_select_opts.small}} or nil,
        G.GAME.round_resets.blind_states['Big'] ~= 'Hide' and {n=G.UIT.O, config={align = "cm", object = G.blind_select_opts.big}} or nil,
        G.GAME.round_resets.blind_states['Boss'] ~= 'Hide' and {n=G.UIT.O, config={align = "cm", object = G.blind_select_opts.boss}} or nil,
        }}
    }}
    return t 
  end
end
SMODS.Consumable({
    key = "constant",
    set = "RCode",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    pos = {x=2,y=2},
    use = function(self, card, area, copier)
        for i, v in pairs(G.playing_cards) do
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
        return #G.hand.highlighted == 1
	end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
})
SMODS.Consumable({
    key = "pseudorandom",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
        for i, v in pairs(G) do
            if type(v) == "table" and v.cards and allowed[i] then
                for ind, card in pairs(v.cards) do
                    Entropy.ApplySticker(card, "entr_pseudorandom")
                end
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
})
local e_round = end_round
function end_round()
    e_round()
    for i, v in pairs(G) do
        if type(v) == "table" and v.cards then
            for ind, card in pairs(v.cards) do
                if card.ability then
                    if card.ability.entr_hotfix then
                        card.ability.entr_hotfix_rounds = card.ability.entr_hotfix_rounds - 1
                        if card.ability.entr_hotfix_rounds <= 0 then
                            card.ability.entr_hotfix = false
                            
                            card:set_edition({
                                cry_glitched = true,
                            })
                        end
                    end
                    if card.ability.entr_pseudorandom then
                        card.ability.entr_pseudorandom = false
                        card.ability.cry_rigged = false
                    end
                end
            end
        end
    end
end
SMODS.Sticker({
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
})
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
SMODS.Consumable({
    key = "inherit",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
        return #G.hand.highlighted == 1 and G.hand.highlighted[1].config.center.key ~= "c_base"
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
})

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
        Entropy.ChangeEnhancements({G.playing_cards, G.deck, G.hand}, enh_suffix, base_enh, true)
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
    if G.hand and G.hand.cards and #G.hand.cards <= 0 and G.GAME.USING_BREAK then
        G.GAME.USING_BREAK = nil
    end
    if G.GAME.USING_BREAK then
        G.STATE = 7
        break_timer = break_timer + dt
    end
    if break_timer > 0.3 then
        G.FUNCS.draw_from_hand_to_discard()
		G.FUNCS.draw_from_discard_to_deck()
        break_timer = -999999999
        --if self.HUD_blind then self.HUD_blind:delete() end
        if self.HUD_blind then self.HUD_blind.states.visible = nil end
        G.GAME.USING_BREAK = nil
        G.GAME.ResetCode = true
    end
    if G.GAME.ResetCode and G.STATE ~= 7 then
        G.GAME.ResetCode = nil
        G.GAME.USING_CODE = nil
        self.HUD_blind.states.visible = true
    end
    if G.STATE == nil and G.pack_cards == nil and G.GAME.DefineBoosterState then
        G.STATE = G.GAME.DefineBoosterState
        G.STATE_COMPLETE = false
    end
end
function FindPush()
    if GetSelectedCard() and GetSelectedCard().config.center.key == "c_entr_push" then return GetSelectedCard() end
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
    
SMODS.Consumable({
    key = "fork",
    set = "RCode",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {
        extra = 1
    },
    pos = {x=0,y=3},
    use = function(self, card, area, copier)
        if area then
			area:remove_from_highlighted(card)
		end
        if G.hand.highlighted[1] then
            local card = copy_card(G.hand.highlighted[1])
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
					G.hand:emplace(card)
					playing_card_joker_effects({ card })
					return true
				end,
			}))
        end
        if G.pack_cards and #G.pack_cards.highlighted then
			G.E_MANAGER:add_event(Event({
				func = function()
					local card = copy_card(G.pack_cards.highlighted[1])
                    card:set_edition({
                        cry_glitched = true,
                    })
                    local ed = pseudorandom_element(G.P_CENTERS)
                    while ed.set ~= "Enhanced" do
                        ed = pseudorandom_element(G.P_CENTERS)
                    end
                    card:set_ability(ed)
					card:add_to_deck()
					table.insert(G.playing_cards, card)
					G.deck:emplace(card)
					playing_card_joker_effects({ card })
					return true
				end,
			}))
        end
    end,
    can_use = function(self, card)
        if not G.pack_cards and G.STATE ~= 999 then
            return #G.hand.highlighted == 1 or (G.pack_cards and #G.pack_cards.highlighted == 1)
        else 
            return false
        end
    end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
})
SMODS.Consumable({
    key = "push",
    set = "RCode",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {
        extra = 1
    },
    pos = {x=1,y=3},
    use = function(self, card, area, copier)
        if not CanCreateRuby() then
            for i, v in pairs(G.jokers.cards) do
                G.jokers.cards[i]:start_dissolve()
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
            add_joker("j_entr_ruby"):add_to_deck()
            G.jokers.config.card_limit = 1
        end
    end,
    can_use = function(self, card)
        return #G.jokers.cards > 0
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
    
})
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
Entropy.RarityPoints = {
    [1] = 1, --common
    [2] = 4, --uncommon
    [3] = 12, --rare
    ["cry_epic"] = 60,
    [4] = 300, --legendary
    ["cry_exotic"] = 1000,
    ["entr_hyper_exotic"] = 5000,
}
Entropy.RarityDiminishers = {
    [1] = 1,
    [2] = 1.5,
    [3] = 2.5,
    [4] = 5,
    ["cry_epic"] = 4,
    ["cry_exotic"] = 10,
    ["entr_hyper_exotic"] = 15
}
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
    ["e_cry_jolly"] = 1.45
})
function CanCreateRuby()
    --if G.GAME.TESTCOND then return true end
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
function HasJoker(key)
    if not G.jokers then return nil end
    local total = 0
    for i, v in pairs(G.jokers.cards) do
        if v.config.center.key == key then total = total + 1 end
    end
    return total > 0 and total or nil
end
function HasConsumable(key)
    for i, v in pairs(G.consumeables.cards) do
        if v.config.center.key == key then return true end
    end
    return false
end
function GetJokerSumRarity(loc)
    if not G.jokers or #G.jokers.cards <= 0 then return "none" end
    local rarity = 1
    local sum = SumJokerPoints()
    local last_sum = 0
    for i, v in pairs(Entropy.RarityPoints) do
        if type(sum) == "table" then
            if v > 12 and sum:gte(v-1) or sum:gte(v) then  
                if v > last_sum  then
                    rarity = i 
                    last_sum = v
                end
            end
        elseif sum >= (v > 12 and v-1 or v-0.01) then                 
            if v > last_sum  then
                rarity = i 
                last_sum = v
            end 
        end
    end
    if not loc then
        return rarity
    else
        return localize(({
            [1] = "k_common",
            [2] = "k_uncommon",
            [3] = "k_rare",
            [4] = "k_legendary"
        })[rarity] or "k_"..rarity)
    end
end
function SumJokerPoints()
    local total = 0
    for i, v in pairs(G.jokers.cards) do
        total = total + GetJokerPoints(v)
    end
    return total
end
function GetJokerPoints(card)
    local total = Entropy.RarityPoints[card.config.center.rarity] or 1
    if card.edition then
        local factor = to_big(GetEditionFactor(card.edition)) ^ (1.7/(Entropy.RarityDiminishers[card.config.center.rarity] or 1))
        total = total * factor
    end
    return total
end
Entropy.EditionFactors = {
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
    ["e_cry_jolly"] = 1.45
}
function GetEditionFactor(edition)
    return Entropy.EditionFactors[edition.key] or 1
end
SMODS.Consumable({
    key = "increment",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
})
SMODS.Consumable({
    key = "decrement",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
                        v2.highlighted = false
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
})
SMODS.Consumable({
    key = "invariant",
    set = "RCode",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {
        extra = 1
    },
    pos = {x=4,y=3},
    use = function(self, card, area, copier)
        Entropy.ApplySticker(Entropy.GetHighlightedCard({G.shop_jokers, G.shop_booster, G.shop_vouchers}), "entr_pinned")
    end,
    can_use = function(self, card)
        return Entropy.GetHighlightedCard({G.shop_jokers, G.shop_booster, G.shop_vouchers})
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "entr_pinned", set="Other"}
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
})
SMODS.Atlas { key = 'entr_stickers', path = 'stickers.png', px = 71, py = 95 }
SMODS.Sticker({
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
})
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
      ease_dollars(-G.GAME.current_round.reroll_cost)
    end
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
            for i = 1, #G.jokers.cards do
              G.jokers.cards[i]:calculate_joker({reroll_shop = true})
            end
            return true
          end
        }))
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({ func = function() save_run(); return true end}))
  end

SMODS.Consumable({
    key = "cookies",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
})
SMODS.Consumable({
    key = "segfault",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
        _card:set_ability(G.P_CENTERS[key])
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
})
SMODS.Consumable({
    key = "sudo",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
})
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
SMODS.Consumable({
    key = "overflow",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
})

SMODS.Consumable({
    key = "refactor",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
                card.edition = edition
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
})
--hotfix
SMODS.Consumable({
    key = "hotfix",
    set = "RCode",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    pos = {x=1,y=5},
    use = function(self, card, area, copier)
        Entropy.ApplySticker(Entropy.GetHighlightedCard({G.hand, G.jokers, G.consumeables}, {"c_entr_hotfix"}), "entr_hotfix")
    end,
    can_use = function(self, card)
        return Entropy.GetHighlightedCard({G.hand, G.jokers, G.consumeables}, {"c_entr_hotfix"})
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "entr_hotfix", set="Other"}
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
})
SMODS.Sticker({
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
})
local debuff_ref = Card.set_debuff
function Card:set_debuff(should_debuff)
    if not self.ability.entr_hotfix then
        debuff_ref(self, should_debuff)
    end
end
SMODS.Consumable({
    key = "ctrl_x",
    set = "RCode",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    pos = {x=2,y=5},
    use = function(self, card, area, copier)
        if G.GAME.ControlXCard then
            local card = paste_card(G.GAME.ControlXCard.card)
            local area = G[G.GAME.ControlXCard.area]

            card:add_to_deck()
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
            local card2 = GetSelectedCard()
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
        return (GetSelectedCard() and GetSelectedCards() == 2) or (G.GAME.ControlXCard and AreaExists(G[G.GAME.ControlXCard.area]))
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
})
SMODS.Consumable({
    key = "multithread",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
        return #G.hand.highlighted > 0
	end,
    loc_vars = function(self, q, card)
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
})
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
local draw_ref = draw_card
function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
    if ((to == G.discard or to == G.deck) and (from == G.hand or from == G.play or from == G.discard))
    and from:get_card(card) and from:get_card(card).ability and from:get_card(card).ability.temporary then
        card = from:remove_card(card)
        card:start_dissolve()
        --return card
    else
        return draw_ref(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
    end
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

function Interfere()
    G.GAME.blind.chips = G.GAME.blind.chips * pseudorandom("interference")+0.22
    G.GAME.InterferencePayoutMod = pseudorandom("interference")+0.85
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
	if hand_table[text] and next(scoring_hand) and #scoring_hand > hand_table[text] and G.GAME.Overflow then
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

	G.GAME.current_round.current_hand.cry_asc_num_text = (
		G.GAME.current_round.current_hand.cry_asc_num and ((type(G.GAME.current_round.current_hand.cry_asc_num) == "table" and G.GAME.current_round.current_hand.cry_asc_num:gt(to_big(0)) or G.GAME.current_round.current_hand.cry_asc_num > 0))
	)
			and " (+" .. G.GAME.current_round.current_hand.cry_asc_num .. ")"
		or ""
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
    if G.GAME.increment then

    end


end


SMODS.Consumable({
    key = "autostart",
    set = "RCode",
    unlocked = true,
    discovered = true,
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
})
local add_tagref = add_tag
function add_tag(_tag)
    add_tagref(_tag)
    if not G.GAME.autostart_tags then G.GAME.autostart_tags = {} end
    if not G.GAME.autostart_tags[_tag.key] then G.GAME.autostart_tags[_tag.key] = _tag.key end
end

Entropy.DefineBlacklist = {
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
Entropy.ExoticPlusPlus = {
    ["entr_reverse_legendary"] = true, --this is not above exotic but it needs to be blacklisted anyway
    ["cry_exotic"] = true,
    ["entr_hyper_exotic"] = true
}
SMODS.Consumable({
    key = "define",
    set = "RSpectral",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {

    },
    name = "entr-Define",
    hidden = true,
    pos = {x=4,y=4},
    --soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
    use = function(self, card, area, copier)
        if not G.GAME.DefineKeys then
            G.GAME.DefineKeys = {}
        end

        G.GAME.USING_CODE = true
		G.GAME.USING_DEFINE = true
		G.ENTERED_CARD = ""
		G.CHOOSE_CARD = UIBox({
			definition = G.FUNCS.create_UIBox_define(card),
			config = {
				align = "cm",
				offset = { x = 0, y = 10 },
				major = G.ROOM_ATTACH,
				bond = "Weak",
				instance_type = "POPUP",
			},
		})
		G.CHOOSE_CARD.alignment.offset.y = 0
		G.ROOM.jiggle = G.ROOM.jiggle + 1
		G.CHOOSE_CARD:align_to_major()
    end,
    can_use = function(self, card)
        return GetSelectedCards() > 1 and GetSelectedCards() < 3 and GetSelectedCard() and GetSelectedCard().config.center.key ~= "j_entr_ruby"
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                "#",
                colours = {
                    HEX("ff00c4")
                }
            }
        }
    end,
})

function GetSelectedCard()
    for i, v in pairs(G) do
        if type(v) == "table" and v.cards and v.highlighted then
            if #v.highlighted > 0 then
                for j, c in pairs(v.highlighted) do
                    if c.ability.name ~= "entr-Define" and not Entropy.DefineBlacklist[c.config.center.key] then
                        return c
                    end
                end
            end
        end
    end
    if #G.jokers.highlighted > 0 then
        for j, c in pairs(G.jokers.highlighted) do
            if c.ability.name ~= "entr-Define" and not Entropy.DefineBlacklist[c.config.center.key] then
                return c
            end
        end
    end
end
function GetSelectedCards()
    local total = 0
    for i, v in pairs(G) do
        if type(v) == "table" and v.cards and v.highlighted then
            total = total + #v.highlighted
        end
    end
    return total
end
local matref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    if initial and self.config and self.config.center and G.GAME.DefineKeys and G.GAME.DefineKeys[self.config.center.key] and not G.GAME.DefineKeys[self.config.center.key].playing_card and center.set ~= "Default" and center.set ~= "Enhanced"
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
    if not self.area or not self.area.config.collection then
        if G.GAME.DefineKeys and G.GAME.DefineKeys[s] and not G.GAME.DefineKeys[s].playing_card then
            if self.config and self.config.center and G.GAME.DefineKeys and G.GAME.DefineKeys[s] and (initial or not G.VIEWING_DECK) and G.P_CENTERS[G.GAME.DefineKeys[s]] then
                matref(self, G.P_CENTERS[G.GAME.DefineKeys[s]] or {}, initial, false)
            end
        end
    end
end

local emplace = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    card = card or {}
    local s = self.base and self.base.name or ""
    local key = G.GAME.DefineKeys and (G.GAME.DefineKeys[s] or G.GAME.DefineKeys[card.config.center.key])
    if self.config.collection then
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

G.FUNCS.create_UIBox_define = function(card)
    if not G.GAME.DefineKeys then
        G.GAME.DefineKeys = {}
    end
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
        outline_colour = G.C.SET.RSpectral,
        contents = {
            {
                n = G.UIT.R,
                nodes = {
                    create_text_input({
                        colour = G.C.SET.RSpectral,
                        hooked_colour = darken(copy_table(G.C.SET.RSpectral), 0.3),
                        w = 4.5,
                        h = 1,
                        max_length = 100,
                        extended_corpus = true,
                        prompt_text = localize("cry_code_enter_card"),
                        ref_table = G,
                        ref_value = "ENTERED_CARD",
                        keyboard_offset = 1,
                    }),
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    UIBox_button({
                        colour = G.C.SET.RSpectral,
                        button = "define_apply",
                        label = { localize("cry_code_create") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    UIBox_button({
                        colour = G.C.SET.RSpectral,
                        button = "your_collection",
                        label = { localize("b_collection_cap") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    UIBox_button({
                        colour = G.C.RED,
                        button = "define_apply_previous",
                        label = { localize("cry_code_create_previous") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    UIBox_button({
                        colour = G.C.RED,
                        button = "define_cancel",
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
G.FUNCS.define_cancel = function()
    G.CHOOSE_CARD:remove()
    G.GAME.USING_CODE = false
    G.GAME.USING_DEFINE = false
    G.DEBUG_DEFINE = false
end
G.FUNCS.define_apply_previous = function()
    if G.PREVIOUS_ENTERED_CARD then
        G.ENTERED_CARD = G.PREVIOUS_ENTERED_CARD or ""
    end
    G.FUNCS.define_apply()
end
Cryptid.aliases["define"] = "#define"
G.FUNCS.define_apply = function()
    local current_card
    local card = GetSelectedCard()
    local entered_card = G.ENTERED_CARD

    G.PREVIOUS_ENTERED_CARD = G.ENTERED_CARD
    local aliases = Cryptid.aliases
    if aliases[string.lower(entered_card)] then
        entered_card = aliases[string.lower(entered_card)]
    end
    for i, v in pairs(G.P_CENTERS) do
        if v.name and string.lower(entered_card) == string.lower(v.name) then
            current_card = i
        end
        if string.lower(entered_card) == string.lower(i) then
            current_card = i
        end
        if string.lower(entered_card) == string.lower(localize({ type = "name_text", set = v.set, key = i })) then
            current_card = i
        end
    end
    if not Entropy.DefineBlacklist[current_card] and G.P_CENTERS[current_card] and not Entropy.ExoticPlusPlus[G.P_CENTERS[current_card].rarity] then

        if card.config.center.key == "j_obelisk" and entered_card == "j_cry_sob" then
            check_for_unlock({ type = "unstable_concoction" })
        end
        if card.config.center.set == "Default" then
            G.GAME.DefineKeys[card.base.name] = current_card
        else
            G.GAME.DefineKeys[card.config.center.key] = current_card
        end
        card:start_dissolve()

        G.CHOOSE_CARD:remove()
        G.GAME.USING_CODE = false
        G.GAME.USING_DEFINE = false
        G.DEBUG_DEFINE = false
    else
        --try playing card
        local words = {}
				for i in string.gmatch(string.lower(entered_card), "%S+") do -- not using apply_lower because we actually want the spaces here
					table.insert(words, i)
				end

				local rank_table = {
					{ "stone" },
					{ "2", "Two", "II" },
					{ "3", "Three", "III" },
					{ "4", "Four", "IV" },
					{ "5", "Five", "V" },
					{ "6", "Six", "VI" },
					{ "7", "Seven", "VII" },
					{ "8", "Eight", "VIII" },
					{ "9", "Nine", "IX" },
					{ "10", "1O", "Ten", "X", "T" },
					{ "J", "Jack" },
					{ "Q", "Queen" },
					{ "K", "King" },
					{ "A", "Ace", "One", "1", "I" },
				} -- ty variable
				local _rank = nil
				for m = #words, 1, -1 do -- the legendary TRIPLE LOOP, checking from end since rank is most likely near the end
					for i, v in pairs(rank_table) do
						for j, k in pairs(v) do
							if words[m] == string.lower(k) then
								_rank = i
								break
							end
						end
						if _rank then
							break
						end
					end
					if _rank then
						break
					end
				end
				if _rank then -- a playing card is going to get created at this point, but we can find additional descriptors
					local suit_table = {
						["Spades"] = { "spades" },
						["Hearts"] = { "hearts" },
						["Clubs"] = { "clubs" },
						["Diamonds"] = { "diamonds" },
					}
					for k, v in pairs(SMODS.Suits) do
						local index = v.key
						local current_name = G.localization.misc.suits_plural[index]
						if not suit_table[v.key] then
							suit_table[v.key] = { string.lower(current_name) }
						end
					end
					-- i'd rather be pedantic and not forgive stuff like "spade", there's gonna be a lot of checks
					-- can change that if need be
					local enh_table = {
						["m_lucky"] = { "lucky" },
						["m_mult"] = { "mult" },
						["m_bonus"] = { "bonus" },
						["m_wild"] = { "wild" },
						["m_steel"] = { "steel" },
						["m_glass"] = { "glass" },
						["m_gold"] = { "gold" },
						["m_stone"] = { "stone" },
						["m_cry_echo"] = { "echo" },
					}
					for k, v in pairs(G.P_CENTER_POOLS.Enhanced) do
						local index = v.key
						local current_name = G.localization.descriptions.Enhanced[index].name
						current_name = current_name:gsub(" Card$", "")
						if not enh_table[v.key] then
							enh_table[v.key] = { string.lower(current_name) }
						end
					end
					local ed_table = {
						["e_base"] = { "base" },
						["e_foil"] = { "foil" },
						["e_holo"] = { "holo" },
						["e_polychrome"] = { "polychrome" },
						["e_negative"] = { "negative" },
						["e_cry_mosaic"] = { "mosaic" },
						["e_cry_oversat"] = { "oversat" },
						["e_cry_glitched"] = { "glitched" },
						["e_cry_astral"] = { "astral" },
						["e_cry_blur"] = { "blurred" },
						["e_cry_gold"] = { "golden" },
						["e_cry_glass"] = { "fragile" },
						["e_cry_m"] = { "jolly" },
						["e_cry_noisy"] = { "noisy" },
						["e_cry_double_sided"] = { "double-sided", "double_sided", "double" }, -- uhhh sure
					}
					for k, v in pairs(G.P_CENTER_POOLS.Edition) do
						local index = v.key
						local current_name = G.localization.descriptions.Edition[index].name
						if not ed_table[v.key] then
							ed_table[v.key] = { string.lower(current_name) }
						end
					end
					local seal_table = {
						["Red"] = { "red" },
						["Blue"] = { "blue" },
						["Purple"] = { "purple" },
						["Gold"] = { "gold", "golden" }, -- don't worry we're handling seals differently
						["cry_azure"] = { "azure" },
						["cry_green"] = { "green" },
					}
					local sticker_table = {
						["eternal"] = { "eternal" },
						["perishable"] = { "perishable" },
						["rental"] = { "rental" },
						["pinned"] = { "pinned" },
						["banana"] = { "banana" }, -- no idea why this evades prefixing
						["entr_pinned"] = { "rigged" },
						["cry_flickering"] = { "flickering" },
						["cry_possessed"] = { "possessed" },
						["cry_absolute"] = { "absolute" },
					}
					local function parsley(_table, _word)
						for i, v in pairs(_table) do
							for j, k in pairs(v) do
								if _word == string.lower(k) then
									return i
								end
							end
						end
						return ""
					end
					local function to_rank(rrank)
						if rrank <= 10 then
							return tostring(rrank)
						elseif rrank == 11 then
							return "Jack"
						elseif rrank == 12 then
							return "Queen"
						elseif rrank == 13 then
							return "King"
						elseif rrank == 14 then
							return "Ace"
						end
					end

					-- ok with all that fluff out the way now we can figure out what on earth we're creating

					local _seal_att = false
					local _suit = ""
					local _enh = ""
					local _ed = ""
					local _seal = ""
					local _stickers = {}
                    local card = GetSelectedCard()
					for m = #words, 1, -1 do
						-- we have a word. figure out what that word is
						-- this is dodgy spaghetti but w/ever
						local wword = words[m]
						if _suit == "" then
							_suit = parsley(suit_table, wword)
						end
						if _enh == "" then
							_enh = parsley(enh_table, wword)
							if _enh == "m_gold" and _seal_att == true then
								_enh = ""
							end
						end
						if _ed == "" then
							_ed = parsley(ed_table, wword)
							if _ed == "e_cry_gold" and _seal_att == true then
								_ed = ""
							end
						end
						if _seal == "" then
							_seal = parsley(seal_table, wword)
							if _seal == "Gold" and _seal_att == false then
								_seal = ""
							end
						end
						local _st = parsley(sticker_table, wword)
						if _st then
							_stickers[#_stickers + 1] = _st
						end
						if wword == "seal" or wword == "sealed" then
							_seal_att = true
						else
							_seal_att = false
						end -- from end so the next word should describe the seal
                    end
                    if card and card.config.center.set == "Default" then
                        G.GAME.DefineKeys[card.base.name] = {
                            ["playing_card"] = true,
                            ["_seal_att"] = _seal_att,
                            ["_suit"] = _suit,
                            ["_enh"] = _enh,
                            ["_ed"] = _ed,
                            ["_seal"] = _seal,
                            ["_stickers"] = stickers,
                            ["_rank"] = to_rank(_rank)

                        }
                    elseif card then
                        G.GAME.DefineKeys[card.config.center.key] = {
                            ["playing_card"] = true,
                            ["_seal_att"] = _seal_att,
                            ["_suit"] = _suit,
                            ["_enh"] = _enh,
                            ["_ed"] = _ed,
                            ["_seal"] = _seal,
                            ["_stickers"] = stickers,
                            ["_rank"] = to_rank(_rank)

                        }
                    end
                    if card then card:start_dissolve() end

                    G.CHOOSE_CARD:remove()
                    G.GAME.USING_CODE = false
                    G.GAME.USING_DEFINE = false
                    G.DEBUG_DEFINE = false
                end

    end
end
G.FUNCS.HUD_blind_debuff = function(e)
	local scale = 0.4
	local num_lines = #G.GAME.blind.loc_debuff_lines
	while G.GAME.blind.loc_debuff_lines[num_lines] == '' do
		num_lines = num_lines - 1
	end
	local padding = 0.05
	if num_lines > 5 then
		local excess_height = (0.3 + padding)*(num_lines - 5)
		padding = padding - excess_height / (num_lines + 1)
	end
	e.config.padding = padding
	if num_lines > #e.children then
		for i = #e.children+1, num_lines do
			local node_def = {n = G.UIT.R, config = {align = "cm", minh = 0.3, maxw = 4.2}, nodes = {
				{n = G.UIT.T, config = {ref_table = G.GAME.blind.loc_debuff_lines, ref_value = i, scale = scale * 0.9, colour = G.C.UI.TEXT_LIGHT}}}}
			e.UIBox:set_parent_child(node_def, e)
		end
	elseif num_lines < #e.children then
		for i = num_lines+1, #e.children do
			e.children[i]:remove()
			e.children[i] = nil
		end
	end
	e.UIBox:recalculate()
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
    if self.edition and edition and self.edition.negative and not edition.negative and self.config.center.type == "Joker" and self.area == G.jokers then
        G.jokers.config.card_limit = G.jokers.config.card_limit - 1
    end
    if self.edition and edition and not self.edition.negative and edition.negative and self.config.center.type == "Joker" and self.area == G.jokers then
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
    end
    ed_ref(self,edition, immediate, silent)
end
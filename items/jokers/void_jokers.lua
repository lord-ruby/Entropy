local function text_width(text)
    local size = 0.9
    local font = G.LANG.font
    local calced_text_width = 0
    local offending_char_index
    -- Math reproduced from DynaText:update_text
    for i, c in utf8.chars(text or "") do
        local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
            + 2.7 * 1 * G.TILESCALE * font.FONTSCALE
        calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
    end

    return calced_text_width * 0.75
end

local function name_text_better(key)
    local ret_strings = {}
    if pcall(function()
        local name_text = G.localization.descriptions[G.P_CENTERS[key].set][key].name
        if type(name_text) == "table" then
            for i, line in ipairs(name_text) do
                ret_strings[#ret_strings+1] = line
            end
        else
            ret_strings = {name_text}
        end
    end) then
    else ret_strings = {"ERROR"} end
    return ret_strings
end

function Entropy.generate_void_invert_uibox(center, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    -- generate normal joker ui
    SMODS.Center.generate_ui(center, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    if center.generate_extra_ui then
        center:generate_extra_ui(info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end
    if not center.discovered or center.locked then return end

    local lines = SMODS.shallow_copy(G.localization.misc.v_dictionary_parsed.entr_void_desc or {})
    local vtext = localize{ type = "variable", key = "entr_void_desc", vars = { "a" } } -- the var doesn't matter here

    -- get every joker name
    local names = {}
    local commas = {}
    for _, v in ipairs(center.corruptions) do
        if G.P_CENTERS[v] then
            for i, v in pairs(name_text_better(v)) do
                names[#names+1] = v
            end
            commas[#commas+1] = #names
        end
    end

    local width_cap = text_width(vtext[1]) * 1.5
    local joker_lines = {{}} -- stores line info
    local no_format_joker_lines = {""} -- keeps track of each line's length
    local current_line = 1

    local function add_name_to_desc(name, name_idx, multiline_part, multiline_last)
        -- if a comma should be used
        local separate = not (name_idx == #names or (multiline_part and not multiline_last)) and Spectrallib.in_table(commas, name_idx)

        -- check width
        no_format_joker_lines[current_line] = no_format_joker_lines[current_line] .. name .. (separate and "," or "")
        local too_wide = text_width(no_format_joker_lines[current_line]) > width_cap

        -- add name to lines
        joker_lines[current_line][#joker_lines[current_line]+1] = {
            strings = { name },
            control = { C = "attention" }
        }
        if separate then
            joker_lines[current_line][#joker_lines[current_line]+1] = {
                strings = { too_wide and "," or ", " },
                control = {}
            }
        end

        -- move to new line if current line has gotten too wide
        if too_wide then
            current_line = current_line + 1
            joker_lines[current_line] = {}
            no_format_joker_lines[current_line] = ""
        end
    end

    -- go through all the names
    for i, name in ipairs(names) do
        add_name_to_desc(name, i)
    end

    -- add lines to desc
    for _, line in ipairs(joker_lines) do
        lines[#lines+1] = line
    end

    local localize_args = {
        AUT = full_UI_table,
        nodes = desc_nodes,

        vars = {
            localize{ type = "name_text", set = "Joker", key = center.key }
        }
    }
    -- taken from localize; adds the multibox
    localize_args.AUT.multi_box = localize_args.AUT.multi_box or {}
    local i = #full_UI_table.multi_box + 1 -- fucking janky ass method
    for j, line in ipairs(lines) do
        local final_line = SMODS.localize_box(line, localize_args)
        if i == 1 or next(localize_args.AUT.info) then
            localize_args.nodes[#localize_args.nodes+1] = final_line -- Sends main box to AUT.main
            if not next(localize_args.AUT.info) then localize_args.nodes.main_box_flag = true end
        elseif not next(localize_args.AUT.info) then
            localize_args.AUT.multi_box[i-1] = localize_args.AUT.multi_box[i-1] or {}
            localize_args.AUT.multi_box[i-1][#localize_args.AUT.multi_box[i-1]+1] = final_line
        end
        if not next(localize_args.AUT.info) and localize_args.AUT.box_colours then localize_args.AUT.box_colours[i] = localize_args.vars.box_colours and localize_args.vars.box_colours[i] or G.C.UI.BACKGROUND_WHITE end
    end
end

local apoptosis = {
    order = 250,
    object_type = "Joker",
    key = "apoptosis",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    pos = {x = 0, y = 0},
    soul_pos = {x=0,y=1},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }
    },
    corruptions = {
        "j_entr_prismatic_shard",
        "j_entr_blooming_crimson"
    },
    config = {
        extra = {
            asc = 0.5
        }
    },
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            context.cardarea = G.play
            context.main_scoring = true
            local eval, post = eval_card(context.other_card, context)
            context.cardarea = G.hand
            context.main_scoring = nil
            eval = eval or {}
            local effects = {eval}
            SMODS.calculate_context({individual = true, other_card=context.other_card, cardarea = G.play, scoring_hand = context.scoring_hand})
            for _,v in ipairs(post or {}) do effects[#effects+1] = v end
            SMODS.trigger_effects(effects, context.other_card)
            if context.other_card.config.center.set ~= "Enhanced" then
                return {
                    plus_asc = card.ability.extra.asc
                }
            end
        end
        if context.forcetrigger then
            for i, v in pairs(G.hand.cards) do
                context.cardarea = G.play
                context.main_scoring = true
                local eval, post = eval_card(v, context)
                context.cardarea = G.hand
                context.main_scoring = nil
                eval = eval or {}
                local effects = {eval}
                SMODS.calculate_context({individual = true, other_card=v, cardarea = G.play, scoring_hand = context.scoring_hand})
                for _,v in ipairs(post or {}) do effects[#effects+1] = v end
                SMODS.trigger_effects(effects, v)
                if v.config.center.set ~= "Enhanced" then
                    SMODS.calculate_effect{card = v, message_card = card, plus_asc = card.ability.extra.asc}
                end
            end
        end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.extra.asc
            }
        }
    end,
    generate_ui = Entropy.generate_void_invert_uibox,
    entr_credits = {{art = "pangaea47"}}
}

local egocentrism = {
    order = 251,
    object_type = "Joker",
    key = "egocentrism",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    pos = {x = 1, y = 0},
    soul_pos = {x=1,y=1},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }
    },
    corruptions = {
        "j_blueprint",
        "j_brainstorm",
        "j_entr_broadcast",
        "j_entr_polaroid"
    },
    config = {
        extra = {
            asc = 0.5
        }
    },
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    calculate = function(self, card, context)
        if context.before and G.play.cards[1] then
            G.play.cards[1]:set_debuff(true)
            G.play.cards[1]:juice_up()
            if G.play.cards[1] ~= G.play.cards[#G.play.cards] then
                G.play.cards[#G.play.cards]:set_debuff(true)
                G.play.cards[#G.play.cards]:juice_up()
            end
        end
        if (context.joker_main or context.forcetrigger) and G.jokers.cards[#G.jokers.cards] ~= card then
            Spectrallib.forcetrigger({
                card = G.jokers.cards[#G.jokers.cards], 
                context = context,
                colour = Entropy.void_gradient,
                message_card = card
            })
        end
    end,
    loc_vars = function(self, info_queue, card)
		card.ability.demicoloncompat_ui = card.ability.demicoloncompat_ui or ""
		card.ability.demicoloncompat_ui_check = nil
		local check = card.ability.check
		return {
			main_end = (card.area and card.area == G.jokers)
					and {
						{
							n = G.UIT.C,
							config = { align = "bm", minh = 0.4 },
							nodes = {
								{
									n = G.UIT.C,
									config = {
										ref_table = card,
										align = "m",
										-- colour = (check and G.C.cry_epic or G.C.JOKER_GREY),
										colour = card.ability.colour,
										r = 0.05,
										padding = 0.08,
										func = "blueprint_compat",
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												ref_table = card.ability,
												ref_value = "demicoloncompat",
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.32 * 0.8,
											},
										},
									},
								},
							},
						},
					}
				or nil,
		}
	end,
    update = function(self, card, front)
		local other_joker = G.jokers and G.jokers.cards[#G.jokers.cards]
		if G.STAGE == G.STAGES.RUN and other_joker then
			local m = Cryptid.demicolonGetTriggerable(other_joker)
			if m[1] and not m[2] then
				card.ability.demicoloncompat = "Compatible"
				card.ability.check = true
				card.ability.colour = G.C.SECONDARY_SET.Enhanced
			elseif m[2] then
				card.ability.demicoloncompat = "Dangerous!"
				card.ability.check = true
				card.ability.colour = G.C.MULT
			else
				card.ability.demicoloncompat = "Incompatible"
				card.ability.check = false
				card.ability.colour = G.C.SUITS.Spades
			end
		end
	end,
    generate_ui = Entropy.generate_void_invert_uibox,
}

local generator_meltdown = {
    order = 252,
    object_type = "Joker",
    key = "generator_meltdown",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 2, y = 0},
    soul_pos = {x=2,y=1},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }
    },
    corruptions = {
        "j_space", 
        "j_burnt", 
        "j_supernova", 
        "j_entr_fused_lens"
    },
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    generate_ui = Entropy.generate_void_invert_uibox,
    entr_credits = {{art = "pangaea47"}}
}

local voidheart = {
    order = 253,
    object_type = "Joker",
    key = "voidheart",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 3, y = 0},
    soul_pos = {x=3,y=1},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }
    },
    corruptions = {
        "j_luchador",
        "j_entr_blind_collectible_pack",
        "j_entr_redkey"
    },
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_BLINDS.bl_entr_abyss
    end,
    generate_ui = Entropy.generate_void_invert_uibox,
    entr_credits = {{art = "pangaea47"}}
}

local unstable_rift = {
    order = 254,
    object_type = "Joker",
    key = "unstable_rift",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    pos = {x = 4, y = 0},
    soul_pos = {x=4,y=1},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }
    },
    config = {
        extra = {
            mult = 0,
            chips = 0,
            val = 0
        }
    },
    set_ability = function(self, card)
        math.randomseed(os.time())
        card.ability.extra.val = card.ability.extra.val or math.random() --gay ass woke transgender math.random because syncing is for losers
    end,
    --this is seperate from inversions even though they are obtained via inverting so it gets to be different
    corruptions = {
        "j_mr_bones",
        "j_entr_skullcry"
    },
    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        Entropy.generate_void_invert_uibox(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        if G.jokers then
            G.ARGS.flame_handler[tostring(card.ability.extra.val).."_chips"] = G.ARGS.flame_handler[tostring(card.ability.extra.val).."_chips"] or copy_table(G.ARGS.flame_handler.chips)
            G.ARGS.flame_handler[tostring(card.ability.extra.val).."_chips"].id = "flame_"..tostring(card.ability.extra.val).."_chips"
            G.ARGS.flame_handler[tostring(card.ability.extra.val).."_chips"].arg_tab = "flame_"..tostring(card.ability.extra.val).."_chips"
            G.ARGS.flame_handler[tostring(card.ability.extra.val).."_mult"] = G.ARGS.flame_handler[tostring(card.ability.extra.val).."_mult"] or copy_table(G.ARGS.flame_handler.mult)
            G.ARGS.flame_handler[tostring(card.ability.extra.val).."_mult"].id = "flame_"..tostring(card.ability.extra.val).."_mult"
            G.ARGS.flame_handler[tostring(card.ability.extra.val).."_mult"].arg_tab = "flame_"..tostring(card.ability.extra.val).."_mult"
        end
        full_UI_table.main = {
            {{ 
                n = G.UIT.C,
                config = { align = "bm", minh = 0.4 },
                nodes = {
                    {n=G.UIT.R, config={align = "m", colour = G.C.BLACK, r = 0.05, padding = 0.1}, nodes={
                        {n=G.UIT.C, config={align = "cr", minw = 1, minh = 0.5, r = 0.1, colour = G.C.BLUE, emboss = 0.05}, nodes={
                            {n=G.UIT.O, config={func = 'flame_handler', no_role = true, id = 'flame_'..tostring(card.ability.extra.val).."_chips", object = Moveable(0,0,0,0), w = 0, h = 0, _w = 1 * 1.25, _h = 0.5 * 2.5}},
                            {n=G.UIT.O, config={text = "chips_text", type = type, scale = 0.2*2.3, object = DynaText({
                                string = {{ref_table = card.ability.extra, ref_value = "chips"}},
                                colours = {G.C.UI.TEXT_LIGHT}, font = G.LANGUAGES['en-us'].font, shadow = true, float = true, scale = 0.2*2.3
                            })}},
                            {n=G.UIT.B, config={w = 0.1, h = 0.1}},
                        }},
                        {n=G.UIT.C, config={align = "cm"}, nodes={
                            {n=G.UIT.T, config={text = "X", lang = G.LANGUAGES['en-us'], scale = 0.2*2, colour = G.C.UI_MULT, shadow = true}},
                        }},
                        {n=G.UIT.C, config={align = "cl", minw = 1, minh = 0.5, r = 0.1, colour = G.C.RED, emboss = 0.05}, nodes={
                            {n=G.UIT.O, config={func = 'flame_handler', no_role = true, id = 'flame_'..tostring(card.ability.extra.val).."_mult", object = Moveable(0,0,0,0), w = 0, h = 0, _w = 1 * 1.25, _h = 0.5 * 2.5}},
                            {n=G.UIT.B, config={w = 0.1, h = 0.1}},
                            {n=G.UIT.O, config={text = "mult_text", type = type, scale = 0.2*2.3, object = DynaText({
                                string = {{ref_table = card.ability.extra, ref_value = "mult"}},
                                colours = {G.C.UI.TEXT_LIGHT}, font = G.LANGUAGES['en-us'].font, shadow = true, float = true, scale = 0.2*2.3
                            })}},
                        }},
                    }}
                }
            }},
            main_box_flag = true
        }
    end,
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    entr_credits = {{art = "pangaea47"}}
}

local calc_score = SMODS.calculate_round_score
SMODS.calculate_round_score = function(flames, ...)
    if G.GAME.current_round.hands_left == 0 and next(SMODS.find_card("j_entr_unstable_rift")) then
        local c = SMODS.find_card("j_entr_unstable_rift")[1]
        return c.ability.extra.mult * c.ability.extra.chips
    end
    return calc_score(flames, ...)
end

SMODS.Sticker({
    badge_colour = Entropy.void_gradient,
    prefix_config = { key = false },
    key = "entr_death_mark",
    atlas = "marked",
    pos = { x = 1, y = 0 },
    should_apply = false,
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
    end,
    loc_vars = function(self, q, card)
        if card.ability.consumeable then
            return {
                key = "entr_death_mark_consumeable"
            }
        end
    end
})

SMODS.Sticker({
    badge_colour = Entropy.void_gradient,
    prefix_config = { key = false },
    key = "void_temporary",
    atlas = "marked",
    pos = { x = 2, y = 0 },
    should_apply = false,
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
    end,
})

local pluripotent_larvae = {
    order = 255,
    object_type = "Joker",
    key = "pluripotent_larvae",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    pos = {x = 0, y = 2},
    soul_pos = {x=0,y=3},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }
    },
    config = {
        extra = {
            asc_pow = 0,
            asc_pow_mod = 0.3
        }
    },
    corruptions = {
        "j_riff_raff",
        "j_invisible",
        "j_entr_phantom_shopper",
    },
    calculate = function(self, card, context)
        if context.selling_self then
            G.GAME.banned_keys.j_entr_pluripotent_larvae = true
            local c = {}
            for i, v in pairs(G.jokers.cards) do if v ~= card then c[#c+1] = v end end
            Entropy.invert(c, true, true)
            if #G.jokers.cards < G.jokers.config.card_limit then
                for i = 1, G.jokers.config.card_limit - #G.jokers.cards + 1 do
                    G.E_MANAGER:add_event(Event{
                        trigger = "after",
                        func = function()
                            play_sound("entr_void_generic")
                            SMODS.add_card {
                                set = "Joker",
                                rarity = "entr_void"
                            }
                            return true
                        end
                    })
                    delay(1)
                end
            end
            return nil, true
        end
    end,
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    generate_ui = Entropy.generate_void_invert_uibox,
}

local desiderium = {
    order = 256,
    object_type = "Joker",
    key = "desiderium",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    pos = {x = 1, y = 2},
    soul_pos = {x=1,y=3},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }
    },
    config = {
        extra = {
            joker_slots_mod = 1,
            active = true
        }
    },
    corruptions = {
        "j_entr_stand_arrow",        
    },
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            if G.GAME.current_round.hands_left > 0 or G.GAME.current_round.discards_left > 0 then
                card.ability.extra.active = nil
                return {
                    message = localize("k_inactive_ex"),
                    colour = Entropy.void_gradient
                }
            end
        end
        if context.skip_blind then
            card.ability.extra.active = nil
            return {
                message = localize("k_inactive_ex"),
                colour = Entropy.void_gradient
            }
        end
        if context.ante_end and context.ante_change then
            if card.ability.extra.active then
                G.E_MANAGER:add_event(Event{
                    trigger = "after",
                    func = function()
                        card:juice_up()
                        Entropy.handle_card_limit(G.jokers, card.ability.extra.joker_slots_mod)
                        play_sound("entr_void_generic")
                        return true
                    end
                })
                delay(1)
            end
            card.ability.extra.active = true
        end
    end,
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.extra.joker_slots_mod,
                card.ability.extra.active and localize("k_active_ex") or localize("k_inactive_ex")
            }
        }
    end,
    generate_ui = Entropy.generate_void_invert_uibox,
}

local nadir = {
    order = 257,
    object_type = "Joker",
    key = "nadir",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    pos = {x = 2, y = 2},
    soul_pos = {x=2,y=3},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }
    },
    config = {
        extra = {
            stored_jokers = {}
        }
    },
    corruptions = {
        "j_entr_echo_chamber",        
    },
    calculate = function(self, card, context)
        if (context.post_trigger and not context.other_card.debuff) or context.forcetrigger then
            local key = pseudorandom_element(card.ability.extra.stored_jokers, pseudoseed("entr_nadir"))
            local dummy
            if key then
                dummy = Entropy.get_dummy(G.P_CENTERS[key], card.area, card)
                Spectrallib.forcetrigger{
                    card = dummy,
                    silent = true
                }
            end
        end
    end,
    can_use = function()
        return #G.jokers.cards > 1
    end,
    use = function(self, card)
        for i, v in pairs(G.jokers.cards) do
            if v ~= card then
                local c = v
                G.E_MANAGER:add_event(Event{
                    trigger = "after",
                    delay = 0.5,
                    func = function()
                        play_sound("entr_void_suck")
                        card.ability.extra.stored_jokers[#card.ability.extra.stored_jokers+1] = c.config.center.key
                        c:start_dissolve()
                        return true
                    end
                })
            end
        end
    end,
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    loc_vars = function(self, q, card)
        for i, v in pairs(card.ability.extra.stored_jokers) do q[#q+1] = G.P_CENTERS[v] end
    end,
    generate_ui = Entropy.generate_void_invert_uibox,
    entr_credits = {{art = "pangaea47"}}
}


local yaldabaoth = {
    order = 258,
    object_type = "Joker",
    key = "yaldabaoth",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    pos = {x = 3, y = 2},
    soul_pos = {x=3,y=3},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }
    },
    config = {
        extra = {
            asc_pow = 0,
            asc_pow_mod = 0.3
        }
    },
    corruptions = {
        "j_entr_sunny_joker",
        "j_entr_dr_sunshine",
        "j_entr_mark_of_the_beast",
    },
    calculate = function(self, card, context)
        if context.post_open_booster then
            G.E_MANAGER:add_event(Event{
                trigger = "after",
                blocking = false,
                delay = 0.25,
                func = function()
                    local card = pseudorandom_element(G.pack_cards.cards, pseudoseed("j_entr_chocolates"))
                    card.ability.entr_death_mark = true
                    card:juice_up()
                    return true
                end
            })
            return nil, true
        end
        if (context.post_trigger or context.individual) and context.other_card.ability and context.other_card.ability.entr_death_mark and not context.other_card.getting_sliced then
            local c = context.other_card
            c.getting_sliced = true
            return {
                func = function()
                    G.E_MANAGER:add_event(Event{
                        func = function()
                            SMODS.scale_card(card, {
                                ref_table = card.ability.extra,
                                ref_value = "asc_pow",
                                scalar_value = "asc_pow_mod",
                                message_colour = Entropy.void_gradient
                            })
                            SMODS.destroy_cards(c)
                            return true
                        end
                    })
                end
            }
        end
        if context.using_consumeable and context.consumeable.ability.entr_death_mark then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "asc_pow",
                scalar_value = "asc_pow_mod",
                message_colour = Entropy.void_gradient
            })
            return nil, true
        end
        if context.joker_main or context.forcetrigger then
            return {
                plus_asc = card.ability.extra.asc_pow
            }
        end
    end,
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = {set = "Other", key = "entr_death_mark"}
        return {
            vars = {
                card.ability.extra.asc_pow_mod,
                card.ability.extra.asc_pow
            }
        }
    end,
    generate_ui = Entropy.generate_void_invert_uibox,
}

local mutagenesis = {
    order = 259,
    object_type = "Joker",
    key = "mutagenesis",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    pos = {x = 4, y = 2},
    soul_pos = {x=4,y=3},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }
    },
    config = {
        extra = {
            stored_jokers = {}
        }
    },
    corruptions = {
        "j_dna",
        "j_certificate",
        "j_entr_jestradiol",
        "j_entr_nucleotide"        
    },
    calculate = function(self, card, context)
        if context.joker_main then
            return Entropy.calc_perma_bonus_joker(card)
        end
    end,
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    loc_vars = function(self, q, card)
        for i, v in pairs(card.ability.extra.stored_jokers) do q[#q+1] = G.P_CENTERS[v] end
    end,
    generate_ui = Entropy.generate_void_invert_uibox,
    generate_extra_ui = function(center, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        local vars = Entropy.get_perma_bonus_vars(card)
        if vars and vars.nominal_chips then
            localize{type = 'other', key = 'card_chips', nodes = desc_nodes, vars = {vars.nominal_chips}}
        end
        SMODS.localize_perma_bonuses(vars, desc_nodes)
    end,
    entr_credits = {{art = "pangaea47"}}
}

local crooked_penny = {
    order = 260,
    object_type = "Joker",
    key = "crooked_penny",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    pos = {x = 0, y = 4},
    soul_pos = {x=0,y=5},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }
    },
    config = {
        extra = {
            mult = 1.5
        }
    },
    corruptions = {
        "j_credit_card",
        "j_egg",
        "j_entr_tenner",        
        "j_entr_oops_all_es",
        "j_entr_masterful_gambit",
        "j_entr_rugpull",
        "j_entr_hash_miner",
    },
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    generate_ui = Entropy.generate_void_invert_uibox,
    entr_credits = {{art = "pangaea47"}}
}

local phoenix_a = {
    order = 261,
    object_type = "Joker",
    key = "phoenix_a",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    pos = {x = 1, y = 4},
    soul_pos = {x=1,y=5},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }   
    },
    config = {
        extra = {
            xchips = 1,
            xmult = 1,
            xchips_mod = 0.05,
            xmult_mod = 0.05
        }
    },
    calculate = function(self, card, context)
        if context.before then
            card.area:remove_card(card)
            G.play:emplace(card)
            card:highlight(true)
            SMODS.change_base(card, "entr_nilsuit", "entr_nilrank")
            G.E_MANAGER:add_event(Event{
                trigger = "after",
                blocking = false,
                func = function()
                    G.E_MANAGER:add_event(Event{
                        trigger = "after",
                        func = function()
                            if card.area then
                                card.area:remove_card(card)
                                G.jokers:emplace(card)
                            end
                            return true
                        end
                    })
                    return true
                end
            })
            local rank
            for i = #G.play.cards, 1, -1 do
                local dcard = G.play.cards[i]
                local drank = dcard:get_id()
                if dcard ~= card then
                    rank = rank or drank
                    if drank == rank then
                        G.play.cards[i].getting_sucked = true
                        SMODS.destroy_cards(dcard)
                        G.E_MANAGER:add_event(Event{
                            func = function()
                                play_sound("entr_void_suck", nil, 3)
                                return true
                            end
                        })
                        delay(0.5)
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "xmult",
                            scalar_value = "xmult_mod",
                            message_key = "a_xmult",
                            message_colour = G.C.RED
                        })
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "xchips",
                            scalar_value = "xchips_mod",
                            message_key = "a_xchips",
                            message_colour = G.C.BLUE
                        })
                        delay(0.5)
                    else
                        break
                    end
                end
            end
        end
        if context.individual and context.card == card then
            return {
                xmult = card.ability.extra.xmult,
                xchips = card.ability.extra.xchips,
            }
        end
    end,
    corruptions = {
        "j_trading",
        "j_hologram",
        "j_entr_memento_mori",
        "j_entr_false_vacuum_collapse"
    },
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.extra.xmult_mod,
                card.ability.extra.xchips_mod,
                card.ability.extra.xmult,
                card.ability.extra.xchips,
            }
        }
    end,
    generate_ui = Entropy.generate_void_invert_uibox,
    entr_credits = {{art = "pangaea47"}}
}

local antimatter_sheath = {
    order = 262,
    object_type = "Joker",
    key = "antimatter_sheath",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    pos = {x = 2, y = 4},
    soul_pos = {x=2,y=5},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }   
    },
    config = {
        extra = {
            cards = 2,
            xchips = 1,
            xmult = 1,
            xchips_mod = 0.05,
            xmult_mod = 0.05
        }
    },
    calculate = function(self, card, context)
        if context.setting_blind or context.forcetrigger then
            for i = 1, math.min(card.ability.extra.cards, 10) do
                local _card = SMODS.create_card { key = "c_entr_dagger", area = G.discard }
                _card.ability.void_temporary = true --third temporary because :3
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                _card.playing_card = G.playing_card
                table.insert(G.playing_cards, _card)

                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand:emplace(_card)
                        _card:start_materialize()
                        G.GAME.blind:debuff_card(_card)
                        G.hand:sort()
                        if context.blueprint_card then
                            context.blueprint_card:juice_up()
                        else
                            card:juice_up()
                        end
                        SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
                        return true
                    end
                }))
                save_run()
            end
            if not context.forcetrigger then return nil, true end
        end
        if context.individual and context.cardarea == G.play and context.other_card.config.center.key == "c_entr_dagger" then
            local cards = {}
            for i, v in pairs(G.hand.cards) do
                if not SMODS.is_eternal(v) then
                    cards[#cards+1] = v
                end
            end
            for i, v in pairs(G.discard.cards) do
                if not SMODS.is_eternal(v) then
                    cards[#cards+1] = v
                end
            end
            for i, v in pairs(G.deck.cards) do
                if not SMODS.is_eternal(v) then
                    cards[#cards+1] = v
                end
            end
            local c = pseudorandom_element(cards, pseudoseed("entr_sheath_destroy"))
            SMODS.destroy_cards(c)
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                message_key = "a_xmult",
                message_colour = G.C.RED
            })
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xchips",
                scalar_value = "xchips_mod",
                message_key = "a_xchips",
                message_colour = G.C.BLUE
            })
            return nil, true
        end
        if context.joker_main or context.forcetrigger then
            return {
                xmult = card.ability.extra.xmult,
                xchips = card.ability.extra.xchips,
            }
        end
    end,
    corruptions = {
        "j_ceremonial",
        "j_entr_solar_dagger",
        "j_entr_insatiable_dagger",
        "j_entr_antidagger"
    },
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.c_entr_dagger
        return {
            vars = {
                card.ability.extra.cards,
                card.ability.extra.xmult_mod,
                card.ability.extra.xchips_mod,
                card.ability.extra.xmult,
                card.ability.extra.xchips,
            }
        }
    end,
    generate_ui = Entropy.generate_void_invert_uibox,
}

local caledscratch = {
    order = 263,
    object_type = "Joker",
    key = "caledscratch",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    pos = {x = 3, y = 4},
    soul_pos = {x=3,y=5},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }
    },
    config = {
        extra = {
            repetitions = 0
        }
    },
    calculate = function(self, card, context)
        if context.entr_repetition_blocked then
            card.ability.extra.repetitions = card.ability.extra.repetitions + 1
        end
        if context.retrigger_joker_check and context.other_card == card.area.cards[1] and card.ability.extra.repetitions > 0 then
            local reps = card.ability.extra.repetitions
            card.ability.extra.repetitions = 0
            return {
                repetitions = reps,
                colour = Entropy.void_gradient
            }
        end
    end,
    corruptions = {
        "j_mime",
        "j_dusk",
        "j_sock_and_buskin", 
        "j_hack",
        "j_selzer", 
        "j_entr_opal",
        "j_entr_fasciation",
        "j_entr_bell_curve", 
        "j_entr_rubber_ball",
        "j_hanging_chad", 
        "j_entr_pineapple", 
        "j_entr_twisted_pair", 
        "j_entr_d7"
    },
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    generate_ui = Entropy.generate_void_invert_uibox,
}

local nyx = {
    order = 264,
    object_type = "Joker",
    key = "nyx",
    rarity = "entr_void",
    cost = 20,
    eternal_compat = true,
    demicoloncompat = true,
    pos = {x = 4, y = 4},
    soul_pos = {x=4,y=5},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_void_jokers",
        }
    },
    config = {
        extra = {
            mod = 3
        }
    },
    in_pool = function() return false end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local num = 0
            for i, v in pairs(G.jokers.cards) do
                if v.config.center.rarity ~= "entr_void" and not v.ability.void_temporary then
                    local card = SMODS.add_card{
                        set = "Joker", rarity = "entr_void", edition = "e_negative"
                    }
                    card.ability.void_temporary = true
                end
            end
        end
        if context.forcetrigger then
            G.E_MANAGER:add_event(Event{
                func = function()
                    local card = SMODS.add_card{
                        set = "Joker", rarity = "entr_void", edition = "e_negative"
                    }
                    card.ability.void_temporary = true
                    return true
                end
            })
        end
    end,
    can_use = function(self, card)
        local c = Entropy.get_highlighted_cards({{cards=G.I.CARD}}, card, 1, 1)
        local cost = 0
        for i, v in pairs(c) do
            cost = cost + card.ability.extra.mod * (card.sell_cost + v.sell_cost)
        end
        return G.GAME.dollars + (G.GAME.bankrupt_at or 0) >= cost
    end,
    use = function(self, card)
        local c = Entropy.get_highlighted_cards({{cards=G.I.CARD}}, card, 1, 1)
        local cost = 0
        for i, v in pairs(c) do
            cost = cost + card.ability.extra.mod * (card.sell_cost + v.sell_cost)
            v.ability.temporary = nil
            v.ability.void_temporary = nil
            v.ability.temporary2 = nil
            local c2 = v
            G.E_MANAGER:add_event(Event{
                trigger = "after",
                func = function()
                    c2.area:remove_from_highlighted(c2)
                    c2:highlight()
                    play_sound("entr_void_suck")
                    return true
                end
            })
            delay(0.5)
        end
        ease_dollars(-cost)
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = {set = "Other", key = "void_temporary"}
        local c = Entropy.get_highlighted_cards({{cards=G.I.CARD}}, card, 1, 1)
        local cost = 0
        for i, v in pairs(c) do
            cost = cost + card.ability.extra.mod * ((card.sell_cost or 10) + (v.sell_cost or 0))
        end
        return {
            vars = {
                card.ability.extra.mod,
                cost
            }
        }
    end,
    corruptions = {
        "j_canio",
        "j_triboulet",
        "j_yorick",
        "j_chicot",
        "j_perkeo",
        "j_entr_ruby",
        "j_entr_slipstream",
        "j_entr_cass",
        "j_entr_hexa",
        "j_entr_grahkon",
        "j_entr_oinac",
        "j_entr_teluobirt",
        "j_entr_kciroy",
        "j_entr_tocihc",
        "j_entr_oekrep",
        "j_entr_ybur",
        "j_entr_zelavi",
        "j_entr_ssac",
        "j_entr_exah",
        "j_entr_nokharg",
    },
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    generate_ui = Entropy.generate_void_invert_uibox,
}

return {
    items = {
        apoptosis,
        egocentrism,
        generator_meltdown,
        voidheart,
        unstable_rift,
        pluripotent_larvae,
        desiderium,
        nadir,
        mutagenesis,
        crooked_penny,
        yaldabaoth,
        phoenix_a,
        antimatter_sheath,
        caledscratch,
        nyx
    }
}

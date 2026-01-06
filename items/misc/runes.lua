SMODS.RuneTag = SMODS.Tag:extend{
    set = "Rune Tag",
	pos = { x = 0, y = 0 },
	config = {},
	class_prefix = "rune",
	required_params = {
		"key",
	},
    stack_size = 1,
	inject = function(self)
        if not G.P_RUNES then 
            G.P_RUNES = {}
        end
        if not G.P_CENTER_POOLS[self.set] then
            G.P_CENTER_POOLS[self.set] = {}
        end
        G.P_RUNES[self.key] = self
        G.P_TAGS[self.key] = self -- ew
        SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
	end,
    in_pool = function()
        return false
    end,
    loc_vars = function(self, q, card)
        return {
            key = Entropy.providence_ui_active(card) and card.key.."_providence" or card.key
        }
    end,
    no_tags = true
}

function Entropy.providence_ui_active(card)
    if card and card.config and card.config.center and card.config.center.set == "Pact" then return end
    if card and card.key and G.P_RUNES[card.key].no_providence then return end
    return (G.providence_temp and G.SETTINGS.paused) or G.GAME.providence
end

-- all the ui shit is basically just copy pasted
-- thank god for gpl 3.0 on smods
SMODS.current_mod.custom_collection_tabs = function()
    local tally = 0
    for _, v in pairs(G.P_CENTER_POOLS["Rune Tag"]) do
        if v.unlocked then
            tally = tally + 1
        end
    end
    return {UIBox_button({button = "your_collection_rune_tags", label = {localize("b_rune_cards")}, count = {tally = tally, of = #G.P_CENTER_POOLS["Rune Tag"]}, minw = 5, id = "your_collection_rune_tags"})}
end

G.FUNCS.your_collection_rune_tags = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
        definition = create_UIBox_your_collection_rune_tags(),
    }
end

function create_UIBox_your_collection_rune_tags()
	G.E_MANAGER:add_event(Event({
		func = function()
			G.FUNCS.your_collection_rune_tags_page({ cycle_config = {}})
			return true
		end
	}))
	return {
		n = G.UIT.O,
		config = { object = UIBox{
			definition = create_UIBox_your_collection_rune_tags_content(),
			config = { offset = {x=0, y=0}, align = 'cm' }
		}, id = 'your_collection_tags_contents', align = 'cm' },
	}
end


function create_UIBox_your_collection_rune_tags_content(page)
	page = page or 1
    G.your_collection_runes = {}
	local tag_matrix = {}
	local rows = 5
	local cols = 6
	local tag_tab = SMODS.collection_pool(G.P_RUNES, true)
	for i = 1, math.ceil(rows) do
		table.insert(tag_matrix, {})
	end

	local tags_to_be_alerted = {}
	local row, col = 1, 1
	for k, v in ipairs(tag_tab) do
		if k <= cols*rows*(page-1) then elseif k > cols*rows*page then break else
			local discovered = v.discovered
			local temp_tag = Tag(v.key, true)
			if not v.discovered then temp_tag.hide_ability = true end
			local temp_tag_ui, temp_tag_sprite = temp_tag:generate_UI()
            G.your_collection_runes[#G.your_collection_runes+1] = {tag = temp_tag, sprite = temp_tag_sprite}
			tag_matrix[row][col] = {
				n = G.UIT.C,
				config = { align = "cm", padding = 0.1 },
				nodes = {
					temp_tag_ui,
				}
			}
			col = col + 1
			if col > cols then col = 1; row = row + 1 end
			if discovered and not v.alerted then
				tags_to_be_alerted[#tags_to_be_alerted + 1] = temp_tag_sprite
			end
		end
	end

	G.E_MANAGER:add_event(Event({
		trigger = 'immediate',
		func = (function()
			for _, v in ipairs(tags_to_be_alerted) do
				v.children.alert = UIBox {
					definition = create_UIBox_card_alert(),
					config = { align = "tri", offset = { x = 0.1, y = 0.1 }, parent = v }
				}
				v.children.alert.states.collide.can = false
			end
			return true
		end)
	}))


	local table_nodes = {}
	for i = 1, rows do
		table.insert(table_nodes, { n = G.UIT.R, config = { align = "cm", minh = 1 }, nodes = tag_matrix[i] })
	end
	local page_options = {}
	for i = 1, math.ceil(#tag_tab/(rows*cols)) do
		table.insert(page_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#tag_tab/(rows*cols))))
	end
    local t = create_UIBox_generic_options({
		colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_colour or
            (G.ACTIVE_MOD_UI.ui_config or {}).colour) or nil,
        bg_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_bg_colour or
            (G.ACTIVE_MOD_UI.ui_config or {}).bg_colour) or nil,
        back_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_back_colour or
            (G.ACTIVE_MOD_UI.ui_config or {}).back_colour) or nil,
		back_func = G.ACTIVE_MOD_UI and "openModUI_" .. G.ACTIVE_MOD_UI.id or 'your_collection',
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", r = 0.1, colour = G.C.BLACK, padding = 0.1, emboss = 0.05 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = {
							{ n = G.UIT.R, config = { align = "cm" }, nodes = table_nodes },
						}
					},
				}
			},
            create_toggle{ -- tally function runs way too often but whatever
                label = localize{ type = "name_text", set = "Voucher", key = "v_entr_providence" }, 
                w = 0,
                ref_table = G, 
                ref_value = "providence_temp" 
            },
			{
				n = G.UIT.R,
				config = { align = 'cm' },
				nodes = {
					create_option_cycle({
						options = page_options,
						w = 4.5,
						cycle_shoulders = true,
						opt_callback = 'your_collection_rune_tags_page',
						focus_args = { snap_to = true, nav = 'wide' },
						current_option = page,
						colour = G.ACTIVE_MOD_UI and (G.ACTIVE_MOD_UI.ui_config or {}).collection_option_cycle_colour or G.C.RED,
						no_pips = true
					})
				}
			},
		}
	})
	return t
end

G.FUNCS.your_collection_rune_tags_page = function(args)
	if args then G.cry_current_tagpage = args.cycle_config.current_option end
	local page = args and args.cycle_config.current_option or G.cry_current_tagpage or 1
	local t = create_UIBox_your_collection_rune_tags_content(page)
	local e = G.OVERLAY_MENU:get_UIE_by_ID('your_collection_tags_contents')
	if e and e.config.object then e.config.object:remove() end
    e.config.object = UIBox{
      definition = t,
      config = {offset = {x=0,y=0}, align = 'cm', parent = e}
    }
end


-- i have to fucking add them to tags too
-- to prevent crashes so my weird workaround
-- for the collection is to just lie
local ref = SMODS.collection_pool
function SMODS.collection_pool(_base_pool, include, ...)
    local old_pool = ref(_base_pool, include)
    local pool = {}
    local is_array = old_pool[1]
    local ipairs = is_array and ipairs or pairs
    for _, v in ipairs(old_pool) do
        if not v.no_tags or include then
            pool[#pool+1] = v
        end
    end
    if not is_array then table.sort(pool, function(a,b) return a.order < b.order end) end
    return pool
end

function Tag:generate_UI_rune(_size)
    _size = _size or 0.8

    local tag_sprite_tab = nil

    local tag_sprite = SMODS.create_sprite(0, 0, _size*1, _size*1, SMODS.get_atlas((not self.hide_ability) and G.P_TAGS[self.key].atlas or "tags"), (self.hide_ability) and G.tag_undiscovered.pos or self.pos)
    tag_sprite.T.scale = 1
    tag_sprite_tab = {n= G.UIT.C, config={align = "cm", ref_table = self, group = self.tally}, nodes={
        {n=G.UIT.O, config={w=_size*1,h=_size*1, colour = G.C.BLUE, object = tag_sprite, focus_with_object = true}},
        self.ability.count and self.ability.count > 1 and {n=G.UIT.C, config = {align = 'cm'}, nodes = {
            {n=G.UIT.R, config = {colour = G.C.BLACK, align = 'cm', r=1, padding = 0.1}, nodes = {
                {n=G.UIT.O, config={object = DynaText({scale = 0.3, string = {{ref_table = self.ability, ref_value = 'count', prefix = 'x'}}, colours = {G.C.RED}, shadow = true})}},
            }}
        }} or nil
    }}
    tag_sprite:define_draw_steps({
        {shader = 'dissolve', shadow_height = 0.05},
        {shader = 'dissolve'},
    })
    tag_sprite.float = true
    tag_sprite.states.hover.can = true
    tag_sprite.states.drag.can = false
    tag_sprite.states.collide.can = true
    tag_sprite.config = {tag = self, force_focus = true}

    tag_sprite.hover = function(_self)
        if not G.CONTROLLER.dragging.target or G.CONTROLLER.using_touch then 
            if not _self.hovering and _self.states.visible then
                _self.hovering = true
                if _self == tag_sprite then
                    _self.hover_tilt = 3
                    _self:juice_up(0.05, 0.02)
                    play_sound('paper1', math.random()*0.1 + 0.55, 0.42)
                    if self.hover_sound and not self.hide_ability then
                    	play_sound(self.hover_sound(), 1.26, 0.12);
                    end
                    play_sound('tarot2', math.random()*0.1 + 0.55, 0.09)
                end

                self:get_uibox_table(tag_sprite)
                _self.config.h_popup =  G.UIDEF.card_h_popup(_self)
                _self.config.h_popup_config = (_self.T.x > G.ROOM.T.w*0.4) and
                    {align =  'cl', offset = {x=-0.1,y=0},parent = _self} or
                    {align =  'cr', offset = {x=0.1,y=0},parent = _self}
                if G.P_RUNES[self.key] then
                _self.config.h_popup_config = (_self.T.y > G.ROOM.T.y*0.2) and
                  {align =  'cl', offset = {x=-0.1,y=0},parent = _self} or
                  {align =  'cl', offset = {x=-0.1,y=0.65},parent = _self}
                end
                Node.hover(_self)
                if _self.children.alert then 
                    _self.children.alert:remove()
                    _self.children.alert = nil
                    if self.key and G.P_TAGS[self.key] then G.P_TAGS[self.key].alerted = true end
                    G:save_progress()
                end
            end
        end
    end
    tag_sprite.stop_hover = function(_self) _self.hovering = false; Node.stop_hover(_self); _self.hover_tilt = 0 end

    tag_sprite:juice_up()
    self.tag_sprite = tag_sprite

    return tag_sprite_tab, tag_sprite
end


function add_rune(_tag, no_copy)
    G.HUD_runes = G.HUD_runes or {}
    local tag_sprite_ui, tag_sprite = _tag:generate_UI_rune()
    G.HUD_runes[#G.HUD_runes+1] = UIBox{
        definition = {n=G.UIT.ROOT, config={align = "tm", padding = 0.05, colour = G.C.CLEAR}, nodes={
          tag_sprite_ui
        }},
        config = {
          align = G.HUD_runes[1] and 'bm' or 'tri',
          offset = G.HUD_runes[1] and {x=0,y=0} or {x=_tag.ability.count and _tag.ability.count > 1 and 1.25 or 1,y=0},
          major = G.HUD_runes[1] and G.HUD_runes[#G.HUD_runes] or G.ROOM_ATTACH}
    }
    discover_card(G.P_RUNES[_tag.key])
    unlock_card(G.P_RUNES[_tag.key])
  
    for i = 1, #G.runes do
        if G.runes[i].apply_to_run then
            G.runes[i]:apply_to_run({type = 'tag_add', tag = _tag})
        end
    end
    
    G.runes[#G.runes+1] = _tag
    _tag.HUD_rune = G.HUD_runes[#G.HUD_runes]
    _tag.HUD_tag = _tag.HUD_rune
    _tag.is_rune = true
    _tag.HUD_sprite = tag_sprite
    _tag.ability.index = #G.HUD_runes
    if #G.HUD_runes > 6 then
		for i = 2, #G.HUD_runes do
			G.HUD_runes[i].config.offset.y = -0.9 + 0.9 * (6 / #G.HUD_runes)
		end
	end
    if G.P_RUNES[_tag.key] and G.P_RUNES[_tag.key].add_to_deck then
        G.P_RUNES[_tag.key]:add_to_deck(_tag)
    end
    if not no_copy then
        SMODS.calculate_context({ entr_add_rune = true, rune = _tag })
    end
    if G.runes_visible then
        _tag.HUD_rune.states.visible = false
    end
end

local tag_removeref = Tag.remove
function Tag:remove()
    if self.is_rune then
        self:rune_remove()
    else
        tag_removeref(self)
    end
end

function Tag:rune_remove()
    self:remove_rune_from_game()
    local HUD_tag_key = nil
    for k, v in pairs(G.HUD_runes) do
        if v == self.HUD_rune then HUD_tag_key = k end
    end

    if HUD_tag_key then 
        if G.HUD_runes and G.HUD_runes[HUD_tag_key+1] then
            if HUD_tag_key == 1 then
                G.HUD_runes[HUD_tag_key+1]:set_alignment({type = 'tri',
                offset = {x=1,y=0},
                xy_bond = 'Weak',
                major = G.ROOM_ATTACH})
            else
                G.HUD_runes[HUD_tag_key+1]:set_role({
                xy_bond = 'Weak',
                major = G.HUD_runes[HUD_tag_key-1]})
            end
        end
        table.remove(G.HUD_runes, HUD_tag_key)
    end
    if G.P_RUNES[self.key] and G.P_RUNES[self.key].remove_from_deck then
        G.P_RUNES[self.key]:remove_from_deck(self)
    end
    self.HUD_rune:remove()

    if #G.HUD_runes >= 6 then
		for i = 2, #G.HUD_runes do
			G.HUD_runes[i].config.offset.y = -0.9 + 0.9 * 6 / #G.HUD_runes
		end
	end
end
local at = add_tag
function add_tag(tag, from_skip, no_copy)
	at(tag)
	if #G.HUD_tags > 6 then
		for i = 2, #G.HUD_tags do
			G.HUD_tags[i].config.offset.y = 0.9 - 0.9 * 6 / #G.HUD_tags
		end
	end
end

local tr = Tag.remove
function Tag:remove()
	tr(self)
	if #G.HUD_tags >= 6 then
		for i = 2, #G.HUD_tags do
			G.HUD_tags[i].config.offset.y = 0.9 - 0.9 * 6 / #G.HUD_tags
		end
	end
end

function Tag:remove_rune_from_game()
    local tag_key = nil
    for k, v in pairs(G.runes) do
        if v == self then tag_key = k end
    end
    table.remove(G.runes, tag_key)
end

function calculate_runes(context)
    local blacklist = {
        rune_break = true,
        remove = true,
        func = true,
        nope = true
    }
    if not G.runes then G.runes = {} end
    for i, v in pairs(G.runes) do
        if v.key and G.P_RUNES[v.key] and G.P_RUNES[v.key].calculate then
            local ret = G.P_RUNES[v.key]:calculate(v, context)
            if ret then
                if ret.nope then
                    v:nope()
                    v.triggered = true
                    if ret.func then ret.func() end
                else 
                    if ret.func then   
                        v:yep("+", G.C.PURPLE, function()
                            v.triggered = true
                            ret.func()
                            return true
                        end)
                    end
                end
                if ret.remove then
                    v.triggered = true
                    v:rune_remove()
                end
                if ret.rune_break then
                    v.triggered = true
                    break
                end
                for i2, v2 in pairs(ret) do
                    if not blacklist[i2] then
                        SMODS.calculate_individual_effect({[i2] = v2}, v, i2, v2, false)
                    end
                end
                SMODS.calculate_context({rune_triggered = true, rune = v})
            end
        end
    end
    G.GAME.rune_joker_buffer = 0
    G.GAME.rune_consumeable_buffer = 0
end

local context_ref = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
    local ret = context_ref(context, return_table)
    calculate_runes(context)
    return ret
end

function Entropy.get_random_rune(seed, no_hidden)
    local runes = {}
    for i, v in pairs(G.P_RUNES) do
        if (not v.hidden or not no_hidden) and not v.is_pact then
            runes[#runes+1]=v.key
        end
    end
    return pseudorandom_element(runes, pseudoseed(seed or "wunjo_rune"))
end

function Entropy.create_rune(key, pos, indicator_key, order, credits, loc_vars, spectral, soul_pos)
    return {
        object_type = "Consumable",
        set = spectral and "Spectral" or "Rune",
        atlas = "rune_atlas",
        pos = pos,
        soul_pos = soul_pos,
        entr_credits = credits,
        order = order,
        key = key,
        soul_set = spectral and "Rune" or nil,
        hidden = spectral,
        dependencies = {items = {"set_entr_runes"}},
        use = function(self, card)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                play_sound('entr_runes')
                if card and card.juice_up then card:juice_up(0.8, 0.5) end
                G.TAROT_INTERRUPT_PULSE = true
                return true end }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.5,
				func = function()
                    local tag = add_rune(Tag(indicator_key))
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.2,
                        func = function()
                            if tag then
                                tag:juice_up()
                            end
                            return true
                        end
                    }))
                    return true
                end
            }))
            
            delay(1.3)
        end,
        demicoloncompat = true,
        force_use = function(self, card)
            self:use(card)
        end,
        loc_vars = function(self, q, card)
            if loc_vars then
                return {
                    vars = loc_vars(self, q, card),
                    key = Entropy.providence_ui_active(card) and "c_entr_"..key.."_providence" or "c_entr_"..key
                }
            end
            return {
                key = Entropy.providence_ui_active(card) and "c_entr_"..key.."_providence" or "c_entr_"..key
            }
        end,
        can_use = function()
            return true
        end
    }
end

local fehu = Entropy.create_rune("fehu", {x=0,y=0}, "rune_entr_fehu", 6001, nil, nil, nil, {x = 0, y = 1})
local fehu_indicator = {
    object_type = "RuneTag",
    order = 7001,
    key = "fehu",
    atlas = "rune_atlas",
    pos = {x=0,y=0},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.selling_card then
            return {
                func = function()
                    local mult = 0.5
                    if G.GAME.providence then
                        mult = 1
                    end
                    Entropy.FlipThen(G.jokers.cards, function(card)
                        card.ability.extra_value = (card.ability.extra_value or 0) + context.card.sell_cost * mult
                        card:set_cost()
                    end)
                end,
            }
        end
    end
}

local uruz = Entropy.create_rune("uruz", {x=1,y=0}, "rune_entr_uruz", 6002, nil, nil, nil, {x = 1, y = 1})
local uruz_indicator = {
    object_type = "RuneTag",
    order = 7002,
    key = "uruz",
    atlas = "rune_atlas",
    pos = {x=1,y=0},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
}

local thurisaz = Entropy.create_rune("thurisaz", {x=2,y=0}, "rune_entr_thurisaz", 6003, nil, nil, nil, {x = 2, y = 1})
local thurisaz_indicator = {
    object_type = "RuneTag",
    order = 7003,
    key = "thurisaz",
    atlas = "rune_atlas",
    pos = {x=2,y=0},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.pre_discard and G.hand.highlighted[1] then
            local highlighted = {}
            for i, v in pairs(G.hand.cards) do
                if v.highlighted then highlighted[#highlighted+1]=v end
            end
            return {
                func = function()
                    local new_cards = {}
                    local prov_copy
                    local copy
                    if G.GAME.providence then
                        prov_copy = copy_card(highlighted[1])
                        new_cards[#new_cards+1] = prov_copy
                    end
                    copy = copy_card(highlighted[1])
                    new_cards[#new_cards+1] = copy
                    table.insert(G.playing_cards, copy)
                    copy:add_to_deck()
                    G.hand:emplace(copy)
                    if prov_copy then
                        table.insert(G.playing_cards, prov_copy)
                        prov_copy:add_to_deck()
                        G.hand:emplace(prov_copy)
                    end
                    playing_card_joker_effects(new_cards)
                end
            }
        end
    end
}

local ansuz = Entropy.create_rune("ansuz", {x=3,y=0}, "rune_entr_ansuz", 6004, nil, nil, nil, {x = 3, y = 1})
local ansuz_indicator = {
    object_type = "RuneTag",
    order = 7004,
    key = "ansuz",
    atlas = "rune_atlas",
    pos = {x=3,y=0},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.entr_add_tag and context.tag then
            return {
                func = function()
                    add_tag(Tag(context.tag.key), nil, true)
                    if G.GAME.providence then
                        add_tag(Tag(context.tag.key), nil, true)
                    end
                end
            }
        end
        if context.entr_add_rune and context.rune and context.rune.key ~= "rune_entr_ansuz" and not G.P_RUNES[context.rune.key].is_pact then
            return {
                func = function()
                    add_rune(Tag(context.rune.key), true)
                    if G.GAME.providence then
                        add_rune(Tag(context.rune.key), true)
                    end
                end
            }
        end
    end
}

local raido = Entropy.create_rune("raido", {x=4,y=0}, "rune_entr_raido", 6005, nil, function(self, q, card)
    local n, d = SMODS.get_probability_vars(card, G.GAME.providence and 2 or 1, 2, "entr_raido")
    return {
        n, d
    }
end, nil, {x = 4, y = 1})
local raido_indicator = {
    object_type = "RuneTag",
    order = 7005,
    key = "raido",
    atlas = "rune_atlas",
    pos = {x=4,y=0},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.entr_ante_change then
            local change = (G.GAME.providence or SMODS.pseudorandom_probability(rube, 'entr_raido', 1, 2)) and 0 or nil
            return {
                ante_mod = change,
                remove = true
            }
        end
    end,
    loc_vars = function(self, queue, rune)
        local n, d = SMODS.get_probability_vars(rune, G.GAME.providence and 2 or 1, 2, "entr_raido")
        return {
            vars = {
                n, d
            },
            key = Entropy.providence_ui_active(rune) and"rune_entr_raido_providence" or "rune_entr_raido"
        }
    end
}

local kaunan = Entropy.create_rune("kaunan", {x=5,y=0}, "rune_entr_kaunan", 6006, nil, nil, nil, {x = 5, y = 1})
local kaunan_indicator = {
    object_type = "RuneTag",
    order = 7006,
    key = "kaunan",
    atlas = "rune_atlas",
    pos = {x=5,y=0},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.before then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            local amount = G.GAME.providence and 2 or 1
            SMODS.upgrade_poker_hands{hands = text, from = rune, level_up = amount}
            return {
                --remove = true,
                func = function()
                    return true
                end,
            }
        end
    end
}

local gebo = Entropy.create_rune("gebo", {x=6,y=0}, "rune_entr_gebo", 6007, nil, nil, nil, {x = 6, y = 1})
local gebo_indicator = {
    object_type = "RuneTag",
    order = 7007,
    key = "gebo",
    atlas = "rune_atlas",
    pos = {x=6,y=0},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.selling_card then
            local card = context.card
            local area = card.area
            G.GAME.rune_joker_buffer = G.GAME.rune_joker_buffer or 0
            G.GAME.rune_consumeable_buffer = G.GAME.rune_consumeable_buffer or 0
            local buffer = card.config.center.set == "Joker" and G.GAME.rune_joker_buffer or G.GAME.rune_consumeable_buffer
            if G.GAME.providence or (#area.cards + buffer <= area.config.card_limit) then
                if card.config.center.set == "Joker" then
                    G.GAME.rune_joker_buffer = G.GAME.rune_joker_buffer + 1
                else    
                    G.GAME.rune_consumeable_buffer = G.GAME.rune_consumeable_buffer + 1
                end
                return {
                    --remove = true,
                    func = function()
                        SMODS.add_card{
                            set = card.config.center.set,
                            area = area,
                            key_append = "entr_gebo_card",
                        }
                        return true
                    end,
                }
            end
        end
    end
}

local wunjo = Entropy.create_rune("wunjo", {x=0,y=2}, "rune_entr_wunjo", 6008, nil, nil, nil, {x = 0, y = 3})
local wunjo_indicator = {
    object_type = "RuneTag",
    order = 7008,
    key = "wunjo",
    atlas = "rune_atlas",
    pos = {x=0,y=1},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.using_consumeable then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        func = function()
                            local tag1 = Entropy.get_random_rune("wunjo_rune", true)
                            add_rune(Tag(tag1 and tag1 or "rune_entr_wunjo"))
                            if not tag1 or tag1 == "rune_entr_wunjo" then
                                check_for_unlock({type = "wunjo_duplication"})
                            end
                            if G.GAME.providence then
                                local tag2 = Entropy.get_random_rune("wunjo_rune", true)
                                if not tag2 or tag2 == "rune_entr_wunjo" then
                                    check_for_unlock({type = "wunjo_duplication"})
                                end
                                add_rune(Tag(tag2 and tag2 or "rune_entr_wunjo"))
                            end
                            return true
                        end
                    }))
                end
            }
        end
    end
}

local haglaz = Entropy.create_rune("haglaz", {x=1,y=2}, "rune_entr_haglaz", 6009, nil, nil, nil, {x = 1, y = 3})
local haglaz_indicator = {
    object_type = "RuneTag",
    order = 7009,
    key = "haglaz",
    atlas = "rune_atlas",
    pos = {x=1,y=1},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.after then
            local cards = G.play.cards
            G.E_MANAGER:add_event(Event{
                trigger = "after",
                blocking = false,
                func = function()
                    for i, v in pairs(cards) do
                        v:start_dissolve()
                        v.ability.temporary2 = true
                    end
                    return true
                end
            })
            return {
                remove = true
            }
        end
        if G.GAME.providence and context.pre_discard then
            local cards = G.hand.highlighted
            G.E_MANAGER:add_event(Event{
                trigger = "after",
                blocking = false,
                func = function()
                    for i, v in pairs(cards) do
                        v:start_dissolve()
                        v.ability.temporary2 = true
                    end
                    return true
                end
            })
            return {
                remove = true
            }
        end
    end
}


local naudiz = Entropy.create_rune("naudiz", {x=2,y=2}, "rune_entr_naudiz", 6010, nil, nil, nil, {x = 2, y = 3})
local naudiz_indicator = {
    object_type = "RuneTag",
    order = 7010,
    key = "naudiz",
    atlas = "rune_atlas",
    pos = {x=2,y=1},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.buying_card and to_big(context.card.cost) > to_big(G.GAME.dollars) then
            SMODS.calculate_context({rune_triggered = true, rune = rune})
            return {
                --remove = true,
                func = function()
                    if G.GAME.providence then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                if to_big(context.card.cost) > to_big(G.GAME.dollars) and to_big(G.GAME.dollars - context.card.cost) <= to_big(0) then
                                    local diff = math.min(context.card.cost, context.card.cost - G.GAME.dollars)
                                    G.GAME.dollars = G.GAME.dollars + diff
                                    if to_big(context.card.cost) > to_big(G.GAME.dollars) and to_big(G.GAME.dollars) > to_big(0) then
                                        G.GAME.dollars = 0
                                    end
                                end
                                return true
                            end
                        }))
                    end
                    return true
                end,
                rune_break = true
            }
        end
    end,
}

local can_buy_ref = G.FUNCS.can_buy
G.FUNCS.can_buy = function(e)
    can_buy_ref(e)
    if Entropy.has_rune("rune_entr_naudiz") then
        e.config.colour = G.C.ORANGE
        e.config.button = 'buy_from_shop'
    end
end

local can_open_ref = G.FUNCS.can_open
G.FUNCS.can_open = function(e)
    can_open_ref(e)
    if Entropy.has_rune("rune_entr_naudiz") then
        e.config.colour = G.C.GREEN
        e.config.button = 'use_card'
    end
    if e.config.ref_table.ability.beast_mark then
        local num = type(e.config.ref_table.ability.beast_mark) == "number" and e.config.ref_table.ability.beast_mark or 1
        if #G.deck.cards >= num then
            e.config.colour = G.C.GREEN
            e.config.button = 'use_card'
        elseif not Entropy.has_rune("rune_entr_naudiz") then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        end
    end
end

local can_redeem_ref = G.FUNCS.can_redeem
G.FUNCS.can_redeem = function(e)
    can_redeem_ref(e)
    if Entropy.has_rune("rune_entr_naudiz") then
        e.config.colour = G.C.GREEN
        e.config.button = 'use_card'
    end
    if e.config.ref_table.ability.beast_mark then
        local num = type(e.config.ref_table.ability.beast_mark) == "number" and e.config.ref_table.ability.beast_mark or 1
        if #G.deck.cards >= num then
            e.config.colour = G.C.GREEN
            e.config.button = 'use_card'
        elseif not Entropy.has_rune("rune_entr_naudiz") then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        end
    end
end

local isaz = Entropy.create_rune("isaz", {x=3,y=2}, "rune_entr_isaz", 6011, nil, nil, nil, {x = 3, y = 3})
local isaz_indicator = {
    object_type = "RuneTag",
    order = 7011,
    key = "isaz",
    atlas = "rune_atlas",
    pos = {x=3,y=1},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.starting_shop then
            return {
                func = function()
                    SMODS.add_voucher_to_shop(nil, true)
                    return true
                end,
            }
        end
    end,
}

local jera = Entropy.create_rune("jera", {x=4,y=2}, "rune_entr_jera", 6012, nil, nil, nil, {x = 4, y = 3})
local jera_indicator = {
    object_type = "RuneTag",
    order = 7012,
    key = "jera",
    atlas = "rune_atlas",
    pos = {x=4,y=1},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.using_consumeable then
            if not context.consumeable.config.center.hidden and context.consumeable.config.center.key ~= "c_entr_jera" then
                return {
                    --remove = true,
                    func = function()
                        if G.GAME.providence then
                            local copy = copy_card(context.consumeable)
                            copy:add_to_deck()
                            G.consumeables:emplace(copy)
                        end
                        local copy = copy_card(context.consumeable)
                        copy:add_to_deck()
                        G.consumeables:emplace(copy)
                        return true
                    end
                }
            end
        end
    end
}

local ihwaz = Entropy.create_rune("ihwaz", {x=5,y=2}, "rune_entr_ihwaz", 6013, nil, nil, nil, {x = 5, y = 3})
local ihwaz_indicator = {
    object_type = "RuneTag",
    order = 7013,
    key = "ihwaz",
    atlas = "rune_atlas",
    pos = {x=5,y=1},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.before then
            local card = G.play.cards[1]
            if card then
                return {
                    func = function()
                        if G.GAME.providence then
                            local edition = SMODS.poll_edition({guaranteed = true, key = "entr_ihwaz"})
                            local enhancement_type = "Enhanced"
                            local enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("ihwaz")).key
                            while G.P_CENTERS[enhancement].no_doe or G.GAME.banned_keys[enhancement] do
                                enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("ihwaz")).key
                            end
                            local seal = SMODS.poll_seal{guaranteed = true, key = "ihwaz"}
                            card:flip()
                            card:set_edition(edition)
                            card:set_ability(G.P_CENTERS[enhancement])
                            card:set_seal(seal)
                            Entropy.randomize_rank_suit(card, true, true, "ihwaz")
                            card:flip()
                        else
                            Entropy.randomise_once(card)
                        end
                    end
                }
            end
        end
    end
}

local perthro = Entropy.create_rune("perthro", {x=6,y=2}, "rune_entr_perthro", 6014, nil, nil, nil, {x = 6, y = 3})
local perthro_indicator = {
    object_type = "RuneTag",
    order = 7014,
    key = "perthro",
    atlas = "rune_atlas",
    pos = {x=6,y=1},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.reroll_shop then
            SMODS.calculate_context({rune_triggered = true, rune = rune})
            return {
                rune_break = true,
                func = function()
                    for i, v in pairs(G.shop_booster.cards) do
                        v:start_dissolve()
                    end
                    for i = 1, G.shop_booster.config.card_limit do
                        local card = SMODS.add_card{
                            set = "Booster",
                            area = G.shop_booster,
                            key_append = "entr_perthro"
                        }
                        create_shop_card_ui(card, "Booster", G.shop_booster)
                        card:start_materialize()
                    end
                    if G.GAME.providence then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                change_shop_size(1)
                                return true
                            end,
                        }))
                        G.GAME.Increment = (G.GAME.Increment or 0) + 1
                        G.GAME.IncrementAnte = G.GAME.round_resets.ante
                    end
                end
            }
        end
    end
}

local algiz = Entropy.create_rune("algiz", {x=0,y=4}, "rune_entr_algiz", 6015, nil, nil, nil, {x = 0, y = 5})
local algiz_indicator = {
    object_type = "RuneTag",
    order = 7015,
    key = "algiz",
    atlas = "rune_atlas",
    pos = {x=0,y=2},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.game_over and to_big(G.GAME.dollars -G.GAME.bankrupt_at) > to_big(G.GAME.providence and 5 or 10)  then
            return {
                func = function()
                    ease_dollars(G.GAME.providence and -5 or -10)
                end,
                saved = "k_saved_algiz"
            }
        end
    end
}

local sowilo = Entropy.create_rune("sowilo", {x=1,y=4}, "rune_entr_sowilo", 6016, nil, nil, nil, {x = 1, y = 5})
local sowilo_indicator = {
    object_type = "RuneTag",
    order = 7016,
    key = "sowilo",
    atlas = "rune_atlas",
    pos = {x=1,y=2},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.pre_discard then
            local text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            SMODS.upgrade_poker_hands({hands = text, from = rune, ascension_power = G.GAME.providence and 4 or 2})
            return {
                func = function()
                end,
            }
        end
    end
}

local tiwaz = Entropy.create_rune("tiwaz", {x=2,y=4}, "rune_entr_tiwaz", 6017, nil, nil, nil, {x = 2, y = 5})
local tiwaz_indicator = {
    object_type = "RuneTag",
    order = 7017,
    key = "tiwaz",
    atlas = "rune_atlas",
    pos = {x=2,y=2},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.hand_drawn then
            local card = context.hand_drawn[1]
            if card then
                return {
                    func = function()
                        local type1 = pseudorandom_element({"Enhancement", "Edition", "Seal"}, pseudoseed("tiwaz"))
                        Entropy.randomise_once(card, {type1}, "tiwaz_first")
                        if G.GAME.providence then
                            G.E_MANAGER:add_event(Event{
                                func = function()
                                        local types = {}
                                        for i, v in pairs({"Enhancement", "Edition", "Seal"}) do
                                            if v ~= type1 then
                                                types[#types+1] = v
                                            end
                                        end
                                        local type2 = pseudorandom_element({"Enhancement", "Edition", "Seal"}, pseudoseed("tiwaz"))
                                        Entropy.randomise_once(card, {type2}, "tiwaz")
                                    return true
                                end
                            })
                        end
                    end,
                }
            end
        end
    end
}

local berkano = Entropy.create_rune("berkano", {x=3,y=4}, "rune_entr_berkano", 6018, nil, nil, nil, {x = 3, y = 5})
local berkano_indicator = {
    object_type = "RuneTag",
    order = 7018,
    key = "berkano",
    atlas = "rune_atlas",
    pos = {x=3,y=2},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.remove_playing_cards then
            local card = context.removed and context.removed[1]
            if card then
                return {
                    func = function()
                        local new_cards = {}
                        local prov_copy
                        local copy
                        local copy2
                        if G.GAME.providence then
                            prov_copy = copy_card(card)
                            new_cards[#new_cards+1] = prov_copy
                        end
                        copy = copy_card(card)
                        copy2 = copy_card(card)
                        new_cards[#new_cards+1] = copy
                        new_cards[#new_cards+1] = copy2
                        table.insert(G.playing_cards, copy)
                        table.insert(G.playing_cards, copy2)
                        copy:add_to_deck()
                        G.hand:emplace(copy)
                        G.hand:emplace(copy2)
                        if prov_copy then
                            table.insert(G.playing_cards, prov_copy)
                            prov_copy:add_to_deck()
                            G.hand:emplace(prov_copy)
                        end
                        playing_card_joker_effects(new_cards)
                        return true
                    end
                }
            end
        end
    end
}

local ehwaz = Entropy.create_rune("ehwaz", {x=4,y=4}, "rune_entr_ehwaz", 6019, nil, nil, nil, {x = 4, y = 5})
local ehwaz_indicator = {
    object_type = "RuneTag",
    order = 7019,
    key = "ehwaz",
    atlas = "rune_atlas",
    pos = {x=4,y=2},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.skip_blind then
            SMODS.calculate_context({rune_triggered = true, rune = rune})
            local card = context.removed and context.removed[1] or context.destroy_card
            local bl = ({Boss = "Big", Big = "Small"})[G.GAME.blind_on_deck]
            local o = G.GAME.round_resets.blind_states[bl == "Big" and "Small" or "Big"]
            G.GAME.RedBlindStates = {
                [bl == "Big" and "Small" or "Big"] = o,
                [bl] = "Skipped",
                Boss = "Upcoming"
            }
            G.GAME.no_saved = true
            return {
                rune_break = true,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        blocking = false,
                        func = function()
                            if G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
                                G.E_MANAGER:add_event(Event({
                                    trigger = "after",
                                    blocking = false,
                                    func = function()
                                        G.GAME.blind:set_blind(G.P_BLINDS[G.GAME.round_resets.blind_choices[bl]])
                                        G.STATE = G.STATES.ROUND_EVAL
                                        G.STATE_COMPLETE = false
                                        G.GAME.no_saved = nil
                                        return true
                                    end,
                                }))
                                if G.blind_select then        
                                    G.blind_select:remove()
                                    G.blind_prompt_box:remove()
                                end
                                if G.GAME.providence then
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            change_shop_size(1)
                                            return true
                                        end,
                                    }))
                                    G.GAME.Increment = (G.GAME.Increment or 0) + 1
                                    G.GAME.IncrementAnte = G.GAME.round_resets.ante
                                end
                                return true
                            end
                        end
                    }))
                end
            }
        end
    end
}

local mannaz = Entropy.create_rune("mannaz", {x=5,y=4}, "rune_entr_mannaz", 6020, nil, nil, nil, {x = 5, y = 5})
local mannaz_indicator = {
    object_type = "RuneTag",
    order = 7020,
    key = "mannaz",
    atlas = "rune_atlas",
    pos = {x=5,y=2},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.post_open_booster then
            G.GAME.mannaz_draw = true
            if rune.num_triggered then
                return {
                    func = function()

                    end
                }
            end
        end
    end
}

local laguz = Entropy.create_rune("laguz", {x=6,y=4}, "rune_entr_laguz", 6021, nil, nil, nil, {x = 6, y = 5})
local laguz_indicator = {
    object_type = "RuneTag",
    order = 7021,
    key = "laguz",
    atlas = "rune_atlas",
    pos = {x=6,y=2},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.pre_discard then
            return {
                func = function()
                    ease_discard(1)
                    if G.GAME.providence then
                        ease_hands_played(1)
                    end
                end
            }
        end
    end
}

local ingwaz = Entropy.create_rune("ingwaz", {x=0,y=6}, "rune_entr_ingwaz", 6022, nil, nil, nil, {x = 0, y = 7})
local ingwaz_indicator = {
    object_type = "RuneTag",
    order = 7022,
    key = "ingwaz",
    atlas = "rune_atlas",
    pos = {x=0,y=3},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.pseudorandom_result and not rune.triggered then
            SMODS.calculate_context({rune_triggered = true, rune = rune})
            if not G.GAME.providence or pseudorandom("rune_entr_ingwaz") < 0.66 then
                rune.triggered = true
                return {
                    rune_break = true,
                    func = function()
                        
                    end
                }
            end
        end
    end
}

local dagaz = Entropy.create_rune("dagaz", {x=1,y=6}, "rune_entr_dagaz", 6023, nil, nil, nil, {x = 1, y = 7})
local dagaz_indicator = {
    object_type = "RuneTag",
    order = 7023,
    key = "dagaz",
    atlas = "rune_atlas",
    pos = {x=1,y=3},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.consumable_emplaced and not rune.triggered then
            if Entropy.Inversion(context.consumeable) then
                rune.triggered = true
                return {
                    --remove = true,
                    func = function()
                        context.consumeable:flip()
                        context.consumeable:set_ability(Entropy.Inversion(context.consumeable))
                        context.consumeable:flip()
                        SMODS.calculate_context({entr_consumable_inverted = true, card = card})
                        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and G.GAME.providence then
                            SMODS.add_card{
                                set = "Twisted",
                                area = G.consumeables,
                                key_append = "entr_dagaz"
                            }
                        end
                        return true
                    end
                }
            end
        end
    end
}

local othila = Entropy.create_rune("othila", {x=2,y=6}, "rune_entr_othila", 6024, nil, nil, nil, {x = 2, y = 7})
local othila_indicator = {
    object_type = "RuneTag",
    order = 7024,
    key = "othila",
    atlas = "rune_atlas",
    pos = {x=2,y=3},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    calculate = function(self, rune, context)
        if context.selling_card_cost then
            return {
                cost = context.cost + context.original_cost * (G.GAME.providence and 4 or 2)
            }
        end
    end
}

local oss = Entropy.create_rune("oss", {x=3,y=6}, "rune_entr_oss", 6025, {art = {"Lil. Mr. Slipstream"}}, nil, true, {x=3,y=7, extra = {x = 4, y = 6}})
local oss_indicator = {
    object_type = "RuneTag",
    order = 7025,
    key = "oss",
    atlas = "rune_atlas",
    pos = {x=3,y=3},
    soul_pos = {x = 4, y = 3},
    atlas = "rune_indicators",
    dependencies = {items = {"set_entr_runes"}},
    hidden = true,
    no_select = true,
    calculate = function(self, rune, context)
        if context.post_open_booster then
            if rune.triggered then
                return {
                    func = function()
                        if G.GAME.providence then
                            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                                SMODS.add_card{
                                    set = "Rune",
                                    area = G.consumeables,
                                    key_append = "entr_oss"
                                }
                            end
                        end
                    end
                }
            end
        end
    end
}

local data = NFS.newFileData(Entropy.path .."/assets/glint.png")
local _glint = love.graphics.newImage(data)
SMODS.Shader({
    key="providence",
    path="providence.fs",
    send_vars = function (sprite, card)
        return {
            extra_img = _glint
        }
    end,
})

return {
    items = {
        fehu, fehu_indicator,
        uruz, uruz_indicator,
        thurisaz, thurisaz_indicator,
        ansuz, ansuz_indicator,
        raido, raido_indicator,
        kaunan, kaunan_indicator,
        gebo, gebo_indicator,
        wunjo, wunjo_indicator,
        haglaz, haglaz_indicator,
        naudiz, naudiz_indicator,
        isaz, isaz_indicator,
        jera, jera_indicator,
        ihwaz, ihwaz_indicator,
        perthro, perthro_indicator,
        algiz, algiz_indicator,
        sowilo, sowilo_indicator,
        tiwaz, tiwaz_indicator,
        berkano, berkano_indicator,
        ehwaz, ehwaz_indicator,
        mannaz, mannaz_indicator,
        laguz, laguz_indicator,
        ingwaz, ingwaz_indicator,
        dagaz, dagaz_indicator,
        othila, othila_indicator,
        oss, oss_indicator
    }
} 

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
            key = G.GAME.providence and card.key.."_providence" or card.key
        }
    end,
    no_tags = true
}

-- all the ui shit is basically just copy pasted
-- thank god for gpl 3.0 on smods
SMODS.current_mod.custom_collection_tabs = function()
    local tally = 0
    for _, v in pairs(G.P_CENTER_POOLS["Rune Tag"]) do
        if v.unlocked then
            tally = tally + 1
        end
    end
    return {UIBox_button({button = "your_collection_rune_tags", label = {localize("k_rune_cards")}, count = {tally = tally, of = #G.P_CENTER_POOLS["Rune Tag"]}, minw = 5, id = "your_collection_rune_tags"})}
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
	local tag_matrix = {}
	local rows = 4
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
    local pool = {}
    if type(_base_pool) ~= 'table' then return pool end
    local is_array = _base_pool[1]
    local ipairs = is_array and ipairs or pairs
    for _, v in ipairs(_base_pool) do
        if (not G.ACTIVE_MOD_UI or v.mod == G.ACTIVE_MOD_UI) and not v.no_collection then
            if not v.no_tags or include then
                pool[#pool+1] = v
            end
        end
    end
    if not is_array then table.sort(pool, function(a,b) return a.order < b.order end) end
    return pool
end

function add_rune(_tag)
    G.HUD_runes = G.HUD_runes or {}
    local tag_sprite_ui = _tag:generate_UI()
    G.HUD_runes[#G.HUD_runes+1] = UIBox{
        definition = {n=G.UIT.ROOT, config={align = "tm", padding = 0.05, colour = G.C.CLEAR}, nodes={
          tag_sprite_ui
        }},
        config = {
          align = G.HUD_runes[1] and 'bm' or 'tri',
          offset = G.HUD_runes[1] and {x=0,y=0} or {x=1.7,y=0},
          major = G.HUD_runes[1] and G.HUD_runes[#G.HUD_runes] or G.ROOM_ATTACH}
    }
    discover_card(G.P_RUNES[_tag.key])
  
    for i = 1, #G.GAME.runes do
      G.GAME.runes[i]:apply_to_run({type = 'tag_add', tag = _tag})
    end
    
    G.GAME.runes[#G.GAME.runes+1] = _tag
    _tag.HUD_rune = G.HUD_runes[#G.HUD_runes]
    _tag.HUD_tag = _tag.HUD_rune
    _tag.is_rune = true
    if #G.HUD_runes > 13 then
		for i = 2, #G.HUD_runes do
			G.HUD_runes[i].config.offset.y = -0.9 + 0.9 * (13 / #G.HUD_runes)
		end
	end
    if G.P_RUNES[_tag.key] and G.P_RUNES[_tag.key].add_to_deck then
        G.P_RUNES[_tag.key]:add_to_deck(_tag)
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
                offset = {x=1.7,y=0},
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

    if #G.HUD_runes >= 13 then
		for i = 2, #G.HUD_runes do
			G.HUD_runes[i].config.offset.y = -0.9 + 0.9 * 13 / #G.HUD_tags
		end
	end
end

function Tag:remove_rune_from_game()
    local tag_key = nil
    for k, v in pairs(G.GAME.runes) do
        if v == self then tag_key = k end
    end
    table.remove(G.GAME.runes, tag_key)
end

function calculate_runes(context)
    local blacklist = {
        rune_break = true,
        remove = true,
        func = true,
        nope = true
    }
    if not G.GAME.runes then G.GAME.runes = {} end
    for i, v in pairs(G.GAME.runes) do
        if G.P_RUNES[v.key].calculate then
            local ret = G.P_RUNES[v.key]:calculate(v, context)
            if ret then
                if ret.nope then
                    v:nope()
                    if ret.func then ret.func() end
                else 
                    if ret.func then   
                        v:yep("+", G.C.DARK_EDITION, function()
                            ret.func()
                            return true
                        end)
                    end
                end
                if ret.remove then
                    v:rune_remove()
                end
                if ret.rune_break then
                    break
                end
                for i2, v2 in pairs(ret) do
                    if not blacklist[i2] then
                        SMODS.calculate_individual_effect({[i2] = v2}, v, i2, v2, false)
                    end
                end
                v.triggered = true
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

function Entropy.create_rune(key, pos, indicator_key, order, credits, loc_vars)
    return {
        object_type = "Consumable",
        set = "Rune",
        atlas = "rune_atlas",
        pos = pos,
        entr_credits = credits,
        order = order,
        key = key,
        dependencies = {items = {"set_entr_runes"}},
        use = function()
            G.E_MANAGER:add_event(Event({
                trigger = "after",
				func = function()
                    add_rune(Tag(indicator_key))
                    return true
                end
            }))
        end,
        demicoloncompat = true,
        force_use = function()
            G.E_MANAGER:add_event(Event({
				func = function()
                    trigger = "after",
                    add_rune(Tag(indicator_key))
                    return true
                end
            }))
        end,
        loc_vars = function(self, q, card)
            if loc_vars then
                return {
                    vars = loc_vars(self, q, card),
                    key = G.GAME.providence and "c_entr_"..key.."_providence" or "c_entr_"..key
                }
            end
            return {
                key = G.GAME.providence and "c_entr_"..key.."_providence" or "c_entr_"..key
            }
        end,
        can_use = function()
            return true
        end
    }
end

local kaunan = Entropy.create_rune("kaunan", {x=5,y=0}, "rune_entr_kaunan", 6006)
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
            level_up_hand(rune, text, nil, amount)
            return {
                --remove = true,
                func = function()
                    return true
                end,
            }
        end
    end
}

local gebo = Entropy.create_rune("gebo", {x=6,y=0}, "rune_entr_gebo", 6007)
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
                            key_append = "entr_gebo_card"
                        }
                        return true
                    end,
                }
            end
        end
    end
}

local naudiz = Entropy.create_rune("naudiz", {x=2,y=1}, "rune_entr_naudiz", 6010)
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
end

local can_redeem_ref = G.FUNCS.can_redeem
G.FUNCS.can_redeem = function(e)
    can_redeem_ref(e)
    if Entropy.has_rune("rune_entr_naudiz") then
        e.config.colour = G.C.GREEN
        e.config.button = 'use_card'
    end
end


local jera = Entropy.create_rune("jera", {x=4,y=1}, "rune_entr_jera", 6012)
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

return {
    items = {
        kaunan, kaunan_indicator,
        gebo, gebo_indicator,
        naudiz, naudiz_indicator,
        jera, jera_indicator,
    }
}
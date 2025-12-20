is_number = is_number or function(x) return type(x) == "number" end

local card_drawref = Card.draw
function Card:draw(layer)
    local ref = card_drawref(self, layer)
    if self.config and self.config.center then
        if self.config.center.set == "Omen" and self.sprite_facing == "front" then
            self.children.center:draw_shader('booster', nil, self.ARGS.send_to_shader)
            if self.children.floating_sprite and self.config.center.entr_redraw_soul then
                local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
                local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
                self.children.floating_sprite:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
                self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
            end
        end
        if self.config.center.tsoul_pos then
            local scale_mod2 = 0.07 -- + 0.02*math.cos(1.8*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local rotate_mod2 = 0 --0.05*math.cos(1.219*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
            if self.config.center.tsoul_pos.extra then
                self.children.floating_sprite2:draw_shader(
                    "dissolve",
                    0,
                    nil,
                    nil,
                    self.children.center,
                    scale_mod2,
                    rotate_mod2,
                    nil,
                    0.1 --[[ + 0.03*math.cos(1.8*G.TIMERS.REAL)--]],
                    nil,
                    0.6
                )
                self.children.floating_sprite2:draw_shader(
                    "dissolve",
                    nil,
                    nil,
                    nil,
                    self.children.center,
                    scale_mod2,
                    rotate_mod2
                )
            end
            local scale_mod = 0.05
                + 0.05 * math.sin(1.8 * G.TIMERS.REAL)
                + 0.07
                    * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14)
                    * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL)
                + 0.07
                    * math.sin(G.TIMERS.REAL * math.pi * 5)
                    * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2
    
            self.children.floating_sprite.role.draw_major = self
            self.children.floating_sprite:draw_shader(
                "dissolve",
                0,
                nil,
                nil,
                self.children.center,
                scale_mod,
                rotate_mod,
                nil,
                0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL),
                nil,
                0.6
            )
            self.children.floating_sprite:draw_shader(
                "dissolve",
                nil,
                nil,
                nil,
                self.children.center,
                scale_mod,
                rotate_mod
            )
        end
    end
    return ref
end

local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
	set_spritesref(self, _center, _front)
    if _center then
        if _center.tsoul_pos then
            self.children.floating_sprite = Sprite(
                self.T.x,
                self.T.y,
                self.T.w * (self.no_ui and 1.1*1.2 or 1),
                self.T.h * (self.no_ui and 1.1*1.2 or 1),
                G.ASSET_ATLAS[_center.atlas or _center.set],
                _center.tsoul_pos
            )
            self.children.floating_sprite.role.draw_major = self
            self.children.floating_sprite.states.hover.can = false
            self.children.floating_sprite.states.click.can = false
            if _center.tsoul_pos.extra then
                self.children.floating_sprite2 = Sprite(
                    self.T.x,
                    self.T.y,
                    self.T.w * (self.no_ui and 1.1*1.2 or 1),
                    self.T.h * (self.no_ui and 1.1*1.2 or 1),
                    G.ASSET_ATLAS[_center.atlas or _center.set],
                    _center.tsoul_pos.extra
                )
                self.children.floating_sprite2.role.draw_major = self
                self.children.floating_sprite2.states.hover.can = false
                self.children.floating_sprite2.states.click.can = false
            end
        end
    end
end

local e_round = end_round
function end_round()
    e_round()
    G.GAME.round_resets.path_toggled = nil
    local remove_temp = {}
    for i, v in pairs({G.jokers, G.hand, G.consumeables, G.discard, G.deck}) do
        for ind, card in pairs(v.cards) do
            if card.ability then
                if card.ability.entr_hotfix then
                    card.ability.entr_hotfix_rounds = (card.ability.entr_hotfix_rounds or 5) - 1
                    if to_big(card.ability.entr_hotfix_rounds) <= to_big(0) then
                        card.ability.entr_hotfix = false
                        
                        Cryptid.manipulate(card, {min=0.1, max=10})
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
                if card.ability.debuff_timer then
                    card.ability.debuff_timer = card.ability.debuff_timer - 1
                    if card.ability.debuff_timer <= 0 then
                        card.ability.debuff_timer = nil
                        card.ability.debuff_timer_max = nil
                        card:set_debuff(false)
                        card_eval_status_text(
                            card,
                            "extra",
                            nil,
                            nil,
                            nil,
                            { message = localize("k_undebuffed_ex"), colour = G.C.RED }
                        )
                    else
                        card_eval_status_text(
                            card,
                            "extra",
                            nil,
                            nil,
                            nil,
                            { message = number_format(card.ability.debuff_timer_max-card.ability.debuff_timer).."/"..number_format(card.ability.debuff_timer_max), colour = G.C.RED }
                        )
                    end
                end
            end
        end
    end
    if #remove_temp > 0 then
        SMODS.calculate_context({remove_playing_cards = true, removed=remove_temp})
    end
    if G.GAME.blind_on_deck == "Boss" then
        G.GAME.entr_princess = nil
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function() G.GAME.asc_power_hand = 0; G.GAME.current_round.current_hand.cry_asc_num = 0;G.GAME.current_round.current_hand.cry_asc_num_text = '';return true end)
      }))
    G.GAME.entr_antithesis_active = nil
    G.GAME.antithesis_index = nil
end

local set_debuffref = Card.set_debuff

function Card:set_debuff(should_debuff)
    if (self.perma_debuff or self.ability.superego or self.ability.debuff_timer) and not self.dissolved then should_debuff = true end
    if self.ability.entr_hotfix or G.GAME.nodebuff then should_debuff = false end
    set_debuffref(self, should_debuff)
end

create_UIBox_your_collection_seals = function()
    return SMODS.card_collection_UIBox(G.P_CENTER_POOLS.Seal, {6,6}, {
        snap_back = true,
        infotip = localize('ml_edition_seal_enhancement_explanation'),
        hide_single_page = true,
        collapse_single_page = true,
        center = 'c_base',
        h_mod = 1.03,
        modify_card = function(card, center)
           card:set_seal(center.key, true)
        end,
    })
end

local set_sealref = Card.set_seal
function Card:set_seal(seal, ...)
    set_sealref(self, seal, ...)
    SMODS.calculate_context({card_modified = true, other_card = self})
    local link = self and self.ability and self.ability.link
    if link then
        for i, v in pairs(G.hand.cards) do
            if v.ability.link == link then
                set_sealref(v, seal, ...)
                SMODS.calculate_context({card_modified = true, other_card = v})
                v.ability.link = link 
            end
        end
        for i, v in pairs(G.discard.cards) do
            if v.ability.link == link then
                set_sealref(v, seal, ...)
                SMODS.calculate_context({card_modified = true, other_card = v})
                v.ability.link = link 
            end
        end
        for i, v in pairs(G.deck.cards) do
            if v.ability.link == link then
                set_sealref(v, seal, ...)
                SMODS.calculate_context({card_modified = true, other_card = v})
                v.ability.link = link
            end
        end
    end
end

local set_abilityref = Card.set_ability
function Card:set_ability(center, initial, delay)
    local link = self and self.ability and self.ability.link
    if (self.config and self.config.center ~= "m_entr_disavowed" and (not self.entr_aleph or self.ability.bypass_aleph)) or G.SETTINGS.paused then
        set_abilityref(self, center, initial, delay)
    end
    if self.ability then
        self.ability.link = link
        if link and not initial then
            for i, v in pairs(G.hand.cards) do
                if v.ability.link == link then
                    set_abilityref(v, center, initial, delay)
                    v.ability.link = link 
                end
            end
            for i, v in pairs(G.discard.cards) do
                if v.ability.link == link then
                    set_abilityref(v, center, initial, delay)
                    v.ability.link = link 
                end
            end
            for i, v in pairs(G.deck.cards) do
                if v.ability.link == link then
                    set_abilityref(v, center, initial, delay) 
                    v.ability.link = link
                end
            end
        end
    end
    if type(center) == "string" then center = G.P_CENTERS[center] end
    if center and center.key == "m_stone" then
        self.ability.bonus = 50
    end
end

local set_editionref = Card.set_edition
function Card:set_edition(...)
    set_editionref(self, ...)
    SMODS.calculate_context({card_modified = true, other_card = self})
    if self.ability.link then
        for i, v in pairs(G.hand.cards) do
            if v.ability.link == self.ability.link then
                set_editionref(v, ...) 
                SMODS.calculate_context({card_modified = true, other_card = v})
            end
        end
        for i, v in pairs(G.discard.cards) do
            if v.ability.link == self.ability.link then
                set_editionref(v, ...) 
                SMODS.calculate_context({card_modified = true, other_card = v})
            end
        end
        for i, v in pairs(G.deck.cards) do
            if v.ability.link == self.ability.link then
                set_editionref(v, ...) 
                SMODS.calculate_context({card_modified = true, other_card = v})
            end
        end
    end
    if self:is_sunny() and self.area == G.jokers then 
        check_for_unlock({ type = "sunny_joker" })
    end
end

local set_base_ref = Card.set_base
function Card:set_base(...)
    set_base_ref(self, ...)
    SMODS.calculate_context({card_modified = true, other_card = self})
    if self.ability and self.ability.link and G.hand then
        for i, v in pairs(G.hand.cards) do
            if v.ability.link == self.ability.link then
                set_base_ref(v, ...) 
                SMODS.calculate_context({card_modified = true, other_card = v})
            end
        end
        for i, v in pairs(G.discard.cards) do
            if v.ability.link == self.ability.link then
                set_base_ref(v, ...) 
                SMODS.calculate_context({card_modified = true, other_card = v})
            end
        end
        for i, v in pairs(G.deck.cards) do
            if v.ability.link == self.ability.link then
                set_base_ref(v, ...) 
                SMODS.calculate_context({card_modified = true, other_card = v})
            end
        end
    end
end

local ref = Card.get_other_side_dummy
function Card:get_other_side_dummy()
    local val = ref(self)
    if val then
        val.is_sunny = function(_, ...)
            return self:is_sunny(...)
        end
    end
    return val
end

local start_dissolveref = Card.start_dissolve
function Card:start_dissolve(...)
    start_dissolveref(self, ...)
    if self.ability.link then
        for i, v in pairs(G.hand.cards) do
            if v.ability.link == self.ability.link then
                SMODS.calculate_context({remove_playing_cards = true, removed={v}})
                start_dissolveref(v, ...) 
                v.ability.temporary2 = true
            end
        end
        for i, v in pairs(G.discard.cards) do
            if v.ability.link == self.ability.link then
                SMODS.calculate_context({remove_playing_cards = true, removed={v}})
                start_dissolveref(v, ...) 
                v.ability.temporary2 = true
            end
        end
        for i, v in pairs(G.deck.cards) do
            if v.ability.link == self.ability.link then
                SMODS.calculate_context({remove_playing_cards = true, removed={v}})
                start_dissolveref(v, ...) 
                v.ability.temporary2 = true
            end
        end
    end
    if self.config.center_key == "j_entr_prismatic_shard" and G.GAME.pool_flags then
        G.GAME.pool_flags.prismatic_shard_gone = true
    end
end

local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if not SMODS.config.no_mod_badges and obj and obj.original_mod and obj.original_mod.id == "entr" then
		local function calc_scale_fac(text)
			local size = 0.9
			local font = G.LANG.font
			local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
			local calced_text_width = 0
			-- Math reproduced from DynaText:update_text
			for _, c in utf8.chars(text) do
				local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
					+ 2.7 * 1 * G.TILESCALE * font.FONTSCALE
				calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
			end
			local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
			return scale_fac
		end
		if not obj.entr_credit or (obj.entr_credits.art or obj.entr_credits.code or obj.entr_credits.idea or obj.entr_credits.custom) then
			local scale_fac = {}
			local min_scale_fac = 1
			local strings =  G.only_display_credit and {} or {Entropy.display_name}
			for _, v in ipairs({ "idea", "art", "code" }) do
				if obj.entr_credits and obj.entr_credits[v] then
					if type(obj.entr_credits[v]) == "string" then obj.entr_credits[v] = {obj.entr_credits[v]} end
					for i = 1, #obj.entr_credits[v] do
                        if not G.only_display_credit or G.only_display_credit == obj.entr_credits[v][i] then
            				strings[#strings + 1] =
							    localize({ type = "variable", key = "cry_" .. v, vars = { obj.entr_credits[v][i] } })[1]
                        end
					end
				end
			end
            if obj.entr_credits and obj.entr_credits.custom then
                strings[#strings + 1] = localize({ type="variable", key = obj.entr_credits.custom.key, vars = { obj.entr_credits.custom.text } })
            end
			for i = 1, #strings do
				scale_fac[i] = calc_scale_fac(strings[i])
				min_scale_fac = math.min(min_scale_fac, scale_fac[i])
			end
			local ct = {}
			for i = 1, #strings do
				ct[i] = {
					string = strings[i],
				}
			end
            if #strings == 0 then
                strings = {Entropy.display_name}
            end
			local entr_badge = {
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							colour = HEX("FF0000"),
							r = 0.1,
							minw = 2 / min_scale_fac,
							minh = 0.36,
							emboss = 0.05,
							padding = 0.03 * 0.9,
                            shader = "entr_brimstone_badge"
						},
						nodes = {
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = ct or "ERROR",
										colours = { obj.entr_credits and obj.entr_credits.text_colour or G.C.WHITE },
										silent = true,
										float = true,
										shadow = true,
										offset_y = -0.03,
										spacing = 1,
										scale = 0.33 * 0.9,
									}),
								},
							},
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
						},
					},
				},
			}
			for i = 1, #badges do	
				if badges[i].nodes[1].nodes[2].config.object.string == Entropy.display_name then --this was meant to be a hex code but it just doesnt work for like no reason so its hardcoded
					badges[i].nodes[1].nodes[2].config.object:remove()
					badges[i] = entr_badge
					break
				end
			end
		end
	end
end

function Entropy.shares_aspect(card1, card2)
    if card1:get_id() == card2:get_id() then return true end
    if card1.config.center.set ~= "Default" and card1.config.center.key == card2.config.center.key then return true end
    if card1.edition and card2.edition and card1.edition.key == card2.edition.key then return true end
    if card1.seal and card1.seal == card2.seal then return true end
end

local is_suitref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if self.base.suit == "entr_nilsuit" and not next(SMODS.find_card("j_entr_opal")) then
        return false
    else
        if next(SMODS.find_card("j_entr_inkbleed")) and self.area then
            local highlighted = self.highlighted
            for i, v in pairs(highlighted and self.area.highlighted or self.area.cards) do
                if v.base.suit == suit and Entropy.shares_aspect(self, v) then
                    return true
                end
            end
        end
        return is_suitref(self, suit, bypass_debuff, flush_calc)
    end
end
local ref = Card.get_id
function Card:get_id()
    if (self.ability.effect == 'Stone Card' and not self.vampired) or self.base.value == "entr_nilrank" then
        return -math.random(100, 1000000)
    end
    return ref(self)
end


G.FUNCS.can_reserve_joker = function(e)
    local c1 = e.config.ref_table
    if
        #G.jokers.cards
        < G.jokers.config.card_limit + (Cryptid.safe_get(c1, "edition", "negative") and 1 or 0)
    then
        e.config.colour = G.C.GREEN
        e.config.button = "reserve_joker"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS.reserve_joker = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.1,
        func = function()
            local c2 = copy_card(c1, nil, nil, true, false)
            c1:remove()
            c2:add_to_deck()
            G.jokers:emplace(c2)
            SMODS.calculate_context({ pull_card = true, card = c1 })
            return true
        end,
    }))
end

G.FUNCS.can_open_booster = function(e)
    if
        G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.SHOP
    then
        e.config.colour = G.C.GREEN
        e.config.button = "open_booster"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS.open_booster = function(e)
    local c1 = e.config.ref_table
    G.GAME.DefineBoosterState = G.STATE
    delay(0.1)
    local area = c1.area
    if c1.ability.booster_pos then G.GAME.current_round.used_packs[c1.ability.booster_pos] = 'USED' end
    --draw_card(G.hand, G.play, 1, 'up', true, card, nil, true) 
    if not c1.from_tag then 
      G.GAME.round_scores.cards_purchased.amt = G.GAME.round_scores.cards_purchased.amt + 1
    end
    if c1.RPerkeoPack then
        G.RPerkeoPack = true
    end
    if G.blind_select then
        G.blind_select:remove()
        G.blind_prompt_box:remove()
    end
    e.config.ref_table.cost = 0
    e.config.ref_table:open()
    if c1.ability.cry_multiuse and to_big(c1.ability.cry_multiuse) > to_big(1) then
        local card = c1
        card.ability.cry_multiuse = card.ability.cry_multiuse - 1
        card.ability.extra_value = -1 * math.max(1, math.floor(card.cost/2))
        card:set_cost()
        delay(0.4)
    
        -- i make my own card eval status text :D
    
        card:juice_up()
        play_sound('generic1')
        attention_text({
            text = format_ui_value(card.ability.cry_multiuse),
            scale = 1.1,
            hold = 0.6,
            major = card,
            backdrop_colour = G.C.SET[card.config.center.set],
            align = 'bm',
            offset = {x = 0, y = 0.2}
        })
        local c2 = copy_card(c1)
        c2:add_to_deck()
        area:emplace(c2)

    end
    --c1:remove()
end

G.FUNCS.can_open_voucher = function(e)
    local c1 = e.config.ref_table
    e.config.colour = G.C.GREEN
    e.config.button = "open_voucher"
end
G.FUNCS.open_voucher = function(e)
    local state = G.STATE
    local c1 = e.config.ref_table
    c1.cost = 0
    local area = c1.area
    c1:redeem()
    c1:start_dissolve()
    c1:remove()
    if c1.ability.cry_multiuse and to_big(c1.ability.cry_multiuse) > to_big(1) then
        local card = c1
        card.ability.cry_multiuse = card.ability.cry_multiuse - 1
        card.ability.extra_value = -1 * math.max(1, math.floor(card.cost/2))
        card:set_cost()
        delay(0.4)
    
        -- i make my own card eval status text :D
    
        card:juice_up()
        play_sound('generic1')
        attention_text({
            text = format_ui_value(card.ability.cry_multiuse),
            scale = 1.1,
            hold = 0.6,
            major = card,
            backdrop_colour = G.C.SET[card.config.center.set],
            align = 'bm',
            offset = {x = 0, y = 0.2}
        })
        local c2 = copy_card(c1)
        c2:add_to_deck()
        area:emplace(c2)

    end
    G.STATE = state
end

G.FUNCS.can_reserve_booster = function(e)
    local c1 = e.config.ref_table
    if
        G.consumeables.config.card_count
        < G.consumeables.config.card_limit + (Cryptid.safe_get(c1, "edition", "negative") and 1 or 0)
    then
        e.config.colour = G.C.GREEN
        e.config.button = "reserve_booster"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS.reserve_booster = function(e)
    local c1 = e.config.ref_table
    --G.GAME.DefineBoosterState = G.STATE
    --c1:open()
    G.pack_cards:remove_card(c1)
    G.consumeables.cards[#G.consumeables.cards + 1] = c1
    c1.area = G.consumeables
    c1.parent = G.consumeables
    c1.layered_parallax = G.consumeables.layered_parallax
    G.consumeables:set_ranks()
    G.consumeables:align_cards()

    SMODS.calculate_context({ pull_card = true, card = c1 })
    G.GAME.pack_choices = G.GAME.pack_choices - 1
    if G.GAME.pack_choices <= 0 then
        G.FUNCS.end_consumeable(nil, delay_fac)
    end
    if c1.ability.glitched_crown then
        local center = G.P_CENTERS[c1.ability.glitched_crown[c1.glitched_index]]
        c1:set_ability(center)
        c1.ability.glitched_crown = nil
    end
    --c1:remove()
end

G.FUNCS.can_buy_deckorsleeve = function(e)
    local c1 = e.config.ref_table
    e.config.colour = G.C.GREEN
    e.config.button = "buy_deckorsleeve_2"
end
G.FUNCS.can_buy_deckorsleeve_from_shop = function(e)
    local c1 = e.config.ref_table
    if to_big(G.GAME.dollars+G.GAME.bankrupt_at) > to_big(c1.cost) or Entropy.has_rune("rune_entr_naudiz") then
        e.config.colour = G.C.GREEN
        e.config.button = "buy_deckorsleeve_from_shop"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS.buy_deckorsleeve_from_shop = function(e)
    local c1 = e.config.ref_table
    --G.GAME.DefineBoosterState = G.STATE
    --c1:open()
    ease_dollars(-c1.cost)
    G.FUNCS.redeem_deckorsleeve(e)
end

G.FUNCS.buy_deckorsleeve_2 = function(e)
    local c1 = e.config.ref_table
    --G.GAME.DefineBoosterState = G.STATE
    --c1:open()
    G.FUNCS.redeem_deckorsleeve(e)
end

G.FUNCS.redeem_deckorsleeve = function(e)
    G.E_MANAGER:add_event(Event{
        trigger = "after",
        func = function()
    
            local area
            if G.STATE == G.STATES.HAND_PLAYED then
                if not G.redeemed_vouchers_during_hand then
                    G.redeemed_vouchers_during_hand =
                        CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
                end
                area = G.redeemed_vouchers_during_hand
            else
                area = G.play
            end
            
            local card = e.config.ref_table
            if card.config.center.key == "j_joker" then
                card:set_ability(G.P_CENTERS.b_red)
            end
            card.area:remove_card(card)
            card:add_to_deck()
            area:emplace(card)
            card.cost = 0
            card:redeem_deck()
            return true
        end
    })
end

G.FUNCS.buy_deckorsleeve = function(e)
    local c1 = e.config.ref_table
    --G.GAME.DefineBoosterState = G.STATE
    --c1:open()
    if not c1.config then
        c1.config = {}
    end
    if not c1.config.center then
        c1.config.center = G.P_CENTERS[c1.center_key]
    end
    if c1.area then c1.area:remove_card(c1) end
    if c1.config and c1.config.center and c1.config.center.apply then
        local orig = G.GAME.starting_params.joker_slots
        if c1.config.center.set == "Sleeve" then
            c1.config.center:apply(c1.config.center)
        else    
            c1.config.center:apply(false)
        end
        local diff = G.GAME.starting_params.joker_slots - orig
        if to_big(diff) > to_big(0) then
            Entropy.handle_card_limit(G.jokers, diff)
        end
    end
    for i, v in pairs(c1.config and c1.config.center and c1.config.center.config or {}) do
        if i == "hands" then 
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + v 
            ease_hands_played(v)
        end
        if i == "discards" then 
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + v 
            ease_discard(v)
        end
        if i == "joker_slot" then Entropy.handle_card_limit(G.jokers, v) end
        if i == "hand_size" then Entropy.handle_card_limit(G.hand, v) end
        if i == "dollars" then ease_dollars(v) end
        if i == "spectral_rate" then G.GAME.spectral_rate = v end
        if i == "plincoins" then ease_plincoins(v) end
        if i == "jokers" then
            delay(0.4)
            G.E_MANAGER:add_event(Event({
                func = function()
                    for k, v in ipairs(c1.config.center.jokers) do
                        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, v, 'deck')
                        card:add_to_deck()
                        G.jokers:emplace(card)
    					card:start_materialize()
                    end
                return true
                end
            }))
        end
        if i == "voucher" then
            G.GAME.used_vouchers[c1.config.center.config.voucher] = true
            G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    Card.apply_to_run(nil, G.P_CENTERS[c1.config.center.config.voucher])
                    return true
                end
            }))
        end
        if i == "consumables" then
            delay(0.4)
            G.E_MANAGER:add_event(Event({
                func = function()
                    for k, v in ipairs(c1.config.center.config.consumables) do
                        local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, v, 'deck')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                    end
                return true
                end
            }))
        end
        if i == "vouchers" then
            for k, v in pairs(c1.config.center.config.vouchers) do
                G.GAME.used_vouchers[v] = true
                G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        Card.apply_to_run(nil, G.P_CENTERS[v])
                        return true
                    end
                }))
            end
        end
        if i == "consumable_slot" then
            G.GAME.starting_params.consumable_slots = G.GAME.starting_params.consumable_slots + v
        end
        if i == "ante_scaling" then
            G.GAME.starting_params.ante_scaling = v
        end
        if i == "boosters_in_shop" then
            G.GAME.starting_params.boosters_in_shop = v
        end
        if i == "no_interest" then
            G.GAME.modifiers.no_interest = true
        end
        if i == "extra_hand_bonus" then 
            G.GAME.modifiers.money_per_hand = v
        end
        if i == "extra_discard_bonus" then 
            G.GAME.modifiers.money_per_discard = v
        end
        if i == "no_faces" then
            for i, v in pairs(G.playing_cards) do
                if v:is_face() then
                    SMODS.change_base(v, nil, pseudorandom_element({"Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10"}, pseudoseed("abandoned_redeem")))
                end
            end
        end
        if i == "randomize_rank_suit" then
            for i, v in pairs(G.playing_cards) do
                Entropy.randomize_rank_suit(v, true, true, "erratic_midgame")
            end
        end
    end
    if c1.config and c1.config.center and c1.config.center.config and c1.config.center.config then
        if c1.config.center.key == "b_checkered" or c1.config.center.key == "sleeve_casl_checkered" then
            for i, v in pairs(G.playing_cards) do
                if v:is_suit("Diamonds") then
                    SMODS.change_base(v, "Hearts")
                elseif v:is_suit("Clubs") then
                    SMODS.change_base(v, "Spades")
                else 
                    SMODS.change_base(v, pseudorandom_element({"Spades", "Hearts"}, pseudoseed("checkered_redeem")), nil)
                end
            end
        elseif c1.config.center.key == "b_entr_doc" or c1.config.center.key == "sleeve_entr_doc" then
            -- G.E_MANAGER:add_event(Event({
            --     trigger = "after",
            --     delay = 0.1,
            --     func = function()
            --         G.HUD:remove()
            --         G.HUD = nil
            --         G.HUD = UIBox{
            --             definition = create_UIBox_HUD(),
            --             config = {align=('cli'), offset = {x=-1.3,y=0},major = G.ROOM_ATTACH}
            --         }
            --         for i, v in pairs(G.hand_text_area) do
            --             G.hand_text_area[i] = G.HUD:get_UIE_by_ID(v.config.id)
            --         end
            --         G.HUD_blind:remove()
            --         G.HUD_blind = UIBox{
            --              definition = create_UIBox_HUD_blind_doc(),
            --              config = {major = G.HUD:get_UIE_by_ID('row_blind'), align = 'cm', offset = {x=0,y=-10}, bond = 'Weak'}
            --         }
            --         G.HUD:recalculate()
            --         G.HUD_blind:recalculate()
            --         return true
            --     end
            -- }))
        end
    end
    if c1.config and c1.config.center and c1.config.center.config and c1.config.center.config and c1.config.center.config.cry_beta then
        local count = G.consumeables.config.card_limit
        local cards = {}
        for i, v in pairs(G.jokers.cards) do
            cards[#cards+1]=v
        end
        for i, v in pairs(G.consumeables.cards) do
            cards[#cards+1]=v
        end
        for i, v in pairs(cards) do
            v.area:remove_card(v)
            v:remove_from_deck()
        end
        G.consumeables:remove()
        count = count + G.jokers.config.card_limit
        G.jokers:remove()
        G.consumeables = nil
        local CAI = {
            discard_W = G.CARD_W,
            discard_H = G.CARD_H,
            deck_W = G.CARD_W*1.1,
            deck_H = 0.95*G.CARD_H,
            hand_W = 6*G.CARD_W,
            hand_H = 0.95*G.CARD_H,
            play_W = 5.3*G.CARD_W,
            play_H = 0.95*G.CARD_H,
            joker_W = 4.9*G.CARD_W,
            joker_H = 0.95*G.CARD_H,
            consumeable_W = 2.3*G.CARD_W,
            consumeable_H = 0.95*G.CARD_H
        }
        G.jokers = CardArea(
            CAI.consumeable_W, 0,
            CAI.joker_W+CAI.consumeable_W,
            CAI.joker_H,
            {card_limit = count, type = 'joker', highlight_limit = 1e100}
        )
        G.consumeables = G.jokers
        for i, v in pairs(cards) do
            v:add_to_deck()
            G.jokers:emplace(v)
        end
    end
    G.GAME.entr_bought_decks = G.GAME.entr_bought_decks or {}
    G.GAME.entr_bought_decks[#G.GAME.entr_bought_decks+1] = c1.config.center.key
    c1:start_dissolve()
    if c1.children.price then c1.children.price:remove() end
    c1.children.price = nil
    if c1.children.buy_button then c1.children.buy_button:remove() end
    c1.children.buy_button = nil
    remove_nils(c1.children)

    SMODS.calculate_context({ pull_card = true, card = c1 })
    --c1:remove()
end

G.FUNCS.can_reserve_card_to_deck = function(e)
    local c1 = e.config.ref_table
    e.config.colour = G.C.GREEN
    e.config.button = "reserve_card_to_deck"
end
G.FUNCS.reserve_card_to_deck = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.1,
        func = function()
            local c2 = copy_card(c1, nil, nil, true, false)
            c1:remove()
            c2:add_to_deck()
			table.insert(G.playing_cards, c2)
			G.deck:emplace(c2)
			playing_card_joker_effects({ c2 })
            SMODS.calculate_context({ pull_card = true, card = c1 })
            return true
        end,
    }))
end

G.FUNCS.can_toggle_xekanos = function(e)
    if
        e.config.ref_table.ability.turned_off
    then
        e.config.colour = G.C.GREEN
        e.config.button = "toggle_xekanos"
    else
        e.config.colour = G.C.RED
        e.config.button = "toggle_xekanos"
    end
end
G.FUNCS.toggle_xekanos = function(e)
    local c1 = e.config.ref_table
    c1.ability.turned_off = not (c1.ability.turned_off or false)
    local text = ({
        [true] = localize("b_on"),
        [false] = localize("b_off")
    })[c1.ability.turned_off]
    e.parent.UIBox:get_UIE_by_ID("on_offswitch").config.text = text
    e.parent.UIBox:get_UIE_by_ID("on_offswitch").config.text_drawable:set(text)
    e.parent.UIBox:get_UIE_by_ID("on_offswitch").UIBox:recalculate()
end

G.FUNCS.can_cycle_apeirostemma = function(e)
    local c1 = e.config.ref_table
    e.config.colour = G.C.GREEN
    e.config.button = "cycle_apeirostemma"
end
G.FUNCS.cycle_apeirostemma = function(e)
    local c1 = e.config.ref_table
    c1.ability.immutable.dice_effect = c1.ability.immutable.dice_effect + 1
    if c1.ability.immutable.dice_effect > 6 then
        c1.ability.immutable.dice_effect = 1
    end
end

G.FUNCS.can_buy_slot = function(e)
    if
        to_big(G.GAME.dollars-G.GAME.bankrupt_at) > to_big(e.config.ref_table.ability.buycost) and not G.CONTROLLER.locked
    then
        e.config.colour = G.C.GREEN
        e.config.button = "buy_slot"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS.buy_slot = function(e)
    local c1 = e.config.ref_table
    ease_dollars(-e.config.ref_table.ability.buycost)
    Entropy.handle_card_limit(G.jokers, 1)
end

G.FUNCS.can_sell_slot = function(e)
    if
        G.jokers.config.card_limit > #G.jokers.cards
    then
        e.config.colour = G.C.GREEN
        e.config.button = "sell_slot"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS.sell_slot = function(e)
    local c1 = e.config.ref_table
    ease_dollars(e.config.ref_table.ability.sellcost)
    Entropy.handle_card_limit(G.jokers, -1)
end

G.FUNCS.can_use_joker = function(e)
    local center = e.config.ref_table.config.center
    if
        center.can_use and center:can_use(e.config.ref_table) and not G.CONTROLLER.locked and not e.config.ref_table.debuff
    then
        e.config.colour = G.C.RED
        e.config.button = "use_joker"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS.use_joker = function(e)
    local int = G.TAROT_INTERRUPT
    G.TAROT_INTERRUPT = true
    local center = e.config.ref_table.config.center
    if center.use then
        center:use(e.config.ref_table)
    end
    e.config.ref_table:juice_up()
    G.TAROT_INTERRUPT = int
end

--som
local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local abc = G_UIDEF_use_and_sell_buttons_ref(card)
	-- Allow code cards to be reserved
    if card.area == G.consumeables and (card.config.center.set == "Voucher" or card.ability.set == "Voucher") then
        sell = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = 'sell'}, nodes={
              {n=G.UIT.B, config = {w=0.1,h=0.6}},
              {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                  {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                  {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                }}
              }}
            }},
          }}
        use = 
        {n=G.UIT.C, config={align = "cr"}, nodes={
          
          {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'open_voucher', func = 'can_open_voucher', handy_insta_action = 'use'}, nodes={
            {n=G.UIT.B, config = {w=0.1,h=0.6}},
            {n=G.UIT.T, config={text = localize('b_redeem'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
          }}
        }}
        return {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  sell
                }},
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  use
                }},
              }},
          }}
    end
    if (card.ability.set == "Back" or card.ability.set == "Sleeve" or card.config.center.set == "Back" or card.config.center.set == "Sleeve") then
        if card.area == G.hand or card.area == G.pack_cards then
        return  {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'buy_deckorsleeve', func = 'can_buy_deckorsleeve', handy_insta_action = 'buy_or_sell'}, nodes={
                {n=G.UIT.T, config={text = localize('b_redeem'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
              }},
          }}
        end
        if card.area == G.consumeables or card.area == G.jokers then
            sell = {n=G.UIT.C, config={align = "cr"}, nodes={
                {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = "sell"}, nodes={
                  {n=G.UIT.B, config = {w=0.1,h=0.6}},
                  {n=G.UIT.C, config={align = "tm"}, nodes={
                    {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                      {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                    }},
                    {n=G.UIT.R, config={align = "cm"}, nodes={
                      {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                      {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                    }}
                  }}
                }},
              }}
            use = 
            {n=G.UIT.C, config={align = "cr"}, nodes={
              
              {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'buy_deckorsleeve', func = 'can_buy_deckorsleeve', handy_insta_action = 'use'}, nodes={
                {n=G.UIT.B, config = {w=0.1,h=0.6}},
                {n=G.UIT.T, config={text = localize('b_redeem'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
              }}
            }}
            return {
                n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
                  {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
                    {n=G.UIT.R, config={align = 'cl'}, nodes={
                      sell
                    }},
                    {n=G.UIT.R, config={align = 'cl'}, nodes={
                      use
                    }},
                  }},
              }}
        end
    end
    if ((card.area == G.consumeables or card.area == G.jokers) and G.consumeables and card.config.center.set == "Booster") then
        sell = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = 'sell'}, nodes={
              {n=G.UIT.B, config = {w=0.1,h=0.6}},
              {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                  {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                  {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                }}
              }}
            }},
          }}
        use = 
        {n=G.UIT.C, config={align = "cr"}, nodes={
          
          {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'open_booster', func = 'can_open_booster', handy_insta_action = 'use'}, nodes={
            {n=G.UIT.B, config = {w=0.1,h=0.6}},
            {n=G.UIT.T, config={text = localize('b_open'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
          }}
        }}
        return {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  sell
                }},
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  use
                }},
              }},
          }}
    end
    if (card.area == G.hand and G.hand) then --Add a use button
		if card.config.center.set == "Joker" then
			return  {
                n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
                  {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'reserve_joker', func = 'can_reserve_joker', handy_insta_action = 'buy_or_sell'}, nodes={
                    {n=G.UIT.T, config={text = localize('b_select'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
                  }},
              }}
		end
        if card.config.center.set == "Booster" then
			return  {
                n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
                  {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'open_booster', func = 'can_open_booster', handy_insta_action = 'buy_or_sell'}, nodes={
                    {n=G.UIT.T, config={text = localize('b_open'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
                  }},
              }}
		end
        if card.config.center.set == "Voucher" then
			return  {
                n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
                  {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'open_voucher', func = 'can_open_voucher', handy_insta_action = 'buy_or_sell'}, nodes={
                    {n=G.UIT.T, config={text = localize('b_redeem'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
                  }},
              }}
		end
	end
    --let boosters not be recursive
    if (card.area == G.pack_cards and G.pack_cards) and card.config.center.set == "Booster" and not Entropy.ConsumablePackBlacklist[SMODS.OPENED_BOOSTER.config.center.key] then
        return  {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'reserve_booster', func = 'can_reserve_booster', handy_insta_action = 'buy_or_sell'}, nodes={
                {n=G.UIT.T, config={text = localize('b_select'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
              }},
          }}
    end
    if (card.area == G.jokers and G.jokers and card.config.center.use) and not card.debuff and card.config.center.set == "Joker" then
        sell = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = 'sell'}, nodes={
              {n=G.UIT.B, config = {w=0.1,h=0.6}},
              {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                  {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                  {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                }}
              }}
            }},
        }}
        transition = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cm",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'use_joker', func = 'can_use_joker', handy_insta_action = 'use'}, nodes={
              {n=G.UIT.B, config = {w=0.1,h=0.3}},
              {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                  {n=G.UIT.T, config={text = localize(card.config.center.use_key or "b_use"),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                }},
              }}
            }},
        }}
        return {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.C, config={padding = 0, align = 'cl'}, nodes={
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  sell
                }},
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  transition
                }},
            }},
        }}
    end
    if (card.area == G.jokers and G.jokers and card.config.center.key == "j_entr_akyros") and not card.debuff then
        sell = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = 'sell'}, nodes={
              {n=G.UIT.B, config = {w=0.1,h=0.6}},
              {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                  {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                  {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                }}
              }}
            }},
          }}
        buyslot = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'buy_slot', func = 'can_buy_slot'}, nodes={
              {n=G.UIT.B, config = {w=0.1,h=0.6}},
              {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                  {n=G.UIT.T, config={text = localize('b_buy_slot'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                  {n=G.UIT.T, config={ref_table = card.ability, ref_value = 'buycost',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                }}
              }}
            }},
          }}
          sellslot = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'sell_slot', func = 'can_sell_slot'}, nodes={
              {n=G.UIT.B, config = {w=0.1,h=0.6}},
              {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                  {n=G.UIT.T, config={text = localize('b_sell_slot'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                  {n=G.UIT.T, config={ref_table = card.ability, ref_value = 'sellcost',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                }}
              }}
            }},
          }}
        return {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.C, config={padding = 0, align = 'cl'}, nodes={
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  sell
                }},
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  buyslot
                }},
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                    sellslot
                  }},
              }},
          }}
    end
    if (card.area == G.jokers and G.jokers and card.config.center.key == "j_entr_apeirostemma") then
        sell = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = 'sell'}, nodes={
              {n=G.UIT.B, config = {w=0.1,h=0.6}},
              {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                  {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                  {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                }}
              }}
            }},
          }}
        onoff = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'cycle_apeirostemma', func = 'can_cycle_apeirostemma', handy_insta_action = 'use'}, nodes={
              {n=G.UIT.B, config = {w=0.1,h=0.3}},
              {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                  {n=G.UIT.T, config={text = localize('b_cycle'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true, id ="cycle"}}
                }},
              }}
            }},
          }}
        return {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.C, config={padding = 0, align = 'cl'}, nodes={
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  sell
                }},
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  onoff
                }},
              }},
          }}
    end
    if (card.area == G.jokers and G.jokers and card.config.center.key == "j_entr_xekanos") and not G.GAME.modifiers.entr_reverse_redeo then
        sell = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = 'sell'}, nodes={
              {n=G.UIT.B, config = {w=0.1,h=0.6}},
              {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                  {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                  {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                }}
              }}
            }},
          }}
        onoff = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'toggle_xekanos', func = 'can_toggle_xekanos', handy_insta_action = 'use'}, nodes={
              {n=G.UIT.B, config = {w=0.1,h=0.3}},
              {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                  {n=G.UIT.T, config={text = card.ability.turned_off and localize('b_on') or localize('b_off'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true, id ="on_offswitch"}}
                }},
              }}
            }},
          }}
        return {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.C, config={padding = 0, align = 'cl'}, nodes={
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  sell
                }},
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  onoff
                }},
              }},
          }}
    end
    if Entropy.needs_use_button(card) and card.area == G.pack_cards and G.pack_cards and (Entropy.needs_pull_button(card) or (not SMODS.OPENED_BOOSTER or not SMODS.OPENED_BOOSTER.draw_hand and card.children.front and (card.ability.consumeable))) then
        return {
            n = G.UIT.ROOT,
            config = { padding = -0.1, colour = G.C.CLEAR },
            nodes = {
                {
                    n = G.UIT.R,
                    config = {
                        ref_table = card,
                        r = 0.08,
                        padding = 0.1,
                        align = "bm",
                        minw = 0.5 * card.T.w - 0.15,
                        minh = 0.1 * card.T.h or 0.7 * card.T.h,
                        maxw = 0.7 * card.T.w - 0.15,
                        hover = true,
                        shadow = true,
                        colour = G.C.UI.BACKGROUND_INACTIVE,
                        one_press = true,
                        button = "use_card",
                        func = card:is_playing_card() and "can_reserve_card_to_deck" or "can_reserve_card",
                        handy_insta_action = 'use'
                    },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                text = Entropy.needs_pull_button(card),
                                colour = G.C.UI.TEXT_LIGHT,
                                scale = 0.55,
                                shadow = true,
                            },
                        },
                    },
                },
                {
                    n = G.UIT.R,
                    config = {
                        ref_table = card,
                        r = 0.08,
                        padding = 0.1,
                        align = "bm",
                        minw = 0.5 * card.T.w - 0.15,
                        maxw = 0.9 * card.T.w - 0.15,
                        minh = 0.1 * card.T.h,
                        hover = true,
                        shadow = true,
                        colour = G.C.UI.BACKGROUND_INACTIVE,
                        one_press = true,
                        button = "Do you know that this parameter does nothing?",
                        func = "can_use_consumeable",
                        handy_insta_action = 'use'
                    },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                text = localize("b_use"),
                                colour = G.C.UI.TEXT_LIGHT,
                                scale = 0.45,
                                shadow = true,
                            },
                        },
                    },
                },
                { n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
                { n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
                { n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
                { n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
                -- Betmma can't explain it, neither can I
            },
        }
    elseif card.area == G.pack_cards and G.pack_cards and (Entropy.needs_pull_button(card) or (not SMODS.OPENED_BOOSTER or not SMODS.OPENED_BOOSTER.draw_hand and card.children.front and (card.ability.consumeable))) then
        return {
            n = G.UIT.ROOT,
                config = { padding = -0.1, colour = G.C.CLEAR },
                nodes = {
                    {
                    n = G.UIT.R,
                    config = {
                        ref_table = card,
                        r = 0.08,
                        padding = 0.1,
                        align = "bm",
                        minw = 0.5 * card.T.w - 0.15,
                        minh = 0.7 * card.T.h,
                        maxw = 0.7 * card.T.w - 0.15,
                        hover = true,
                        shadow = true,
                        colour = G.C.UI.BACKGROUND_INACTIVE,
                        one_press = true,
                        button = "Do you know that this parameter does nothing?",
                        func = card:is_playing_card() and "can_reserve_card_to_deck" or "can_reserve_card",
                        handy_insta_action = 'use'
                    },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                text = Entropy.needs_pull_button(card),
                                colour = G.C.UI.TEXT_LIGHT,
                                scale = 0.55,
                                shadow = true,
                            },
                        },
                    },
                },
                -- Betmma can't explain it, neither can I
            },
        }
    end
	return abc
end

local sell_ref = G.FUNCS.sell_card
G.FUNCS.sell_card = function(e)
    if e.config.ref_table.ability.superego_copies then
        for i = 1, e.config.ref_table.ability.superego_copies do
            local card2 = copy_card(e.config.ref_table)
            card2:add_to_deck()
            card2.ability.superego = nil
            card2.ability.superego_copies = nil
            card2:set_debuff(false)
            card2.sell_cost = 0
            e.config.ref_table.area:emplace(card2)
        end
    end
    sell_ref(e)
end

local scie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    if Entropy.BlindIs("bl_entr_theta") then
        --hacky solution
        --probably want a whitelist of effects in the future
        --but should work fine if everyone uses standard capitalisation
        key = key:gsub("mult_mod", "chip_mod")
        key = key:gsub("mult", "chips")
    end
    local ret
    if next(SMODS.find_card("j_entr_error")) and type(amount) == "number" then
        local mult = 1
        for i, v in pairs(SMODS.find_card("j_entr_error")) do
            mult = mult * pseudorandom("entr_error", 95000, 120000)/100000
            -- G.E_MANAGER:add_event(Event{
            --     func = function()
            --         v:juice_up()
            --         return true
            --     end
            -- })
        end
        amount = amount * mult
    end
    if string.find(key, "chip") and next(SMODS.find_card("j_entr_yogurt")) then
        SMODS.calculate_context({entr_chips_calculated = true, other_card = scored_card or effect.card})    
    end
    ret = scie(effect, scored_card, key, amount, from_edition)
    if ret then
        return ret
    end
    if (key == 'eq_mult' or key == 'Eqmult_mod') then 
        local mult = SMODS.Scoring_Parameters["mult"]
        mult.current = amount
        update_hand_text({delay = 0}, {mult = mult.current})
        if not Talisman or not Talisman.config_file.disable_anims then
            Entropy.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent)
        end
        return true
    end
    if (key == 'eq_chips' or key == 'Eqchips_mod') then 
        local chips = SMODS.Scoring_Parameters["chips"]
        chips.current = amount
        update_hand_text({delay = 0}, {chips = chips.current})
        if not Talisman or not Talisman.config_file.disable_anims then
            Entropy.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "="..amount.. " Chips", G.C.BLUE)
        end
        return true
    end
    if (key == 'asc') or (key == 'asc_mod') or key == "x_asc" then
        local e = card_eval_status_text
        for i, v in pairs(SMODS.find_card("j_entr_axeh")) do
            amount = amount * v.ability.asc_mod
        end
        local hand
        if G.GAME.asc_power_hand and G.GAME.asc_power_hand ~= 0 then hand = G.GAME.asc_power_hand end
        local orig = to_big((hand or G.GAME.current_round.current_hand.cry_asc_num))
        if not G.GAME.asc_power_hand or G.GAME.asc_power_hand == 0 then G.GAME.asc_power_hand = G.GAME.current_round.current_hand.cry_asc_num end
        G.GAME.asc_power_hand = to_big(G.GAME.asc_power_hand) * to_big(amount)        
        local text = number_format(to_big(G.GAME.asc_power_hand))
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.current_round.current_hand.cry_asc_num_text = (to_big(G.GAME.asc_power_hand) < to_big(0) and " (" or " (+") .. (text) .. ")" 
                return true
            end
        }))
        card_eval_status_text = function() end
        scie(effect, scored_card, "Xmult_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        scie(effect, scored_card, "Xchip_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        card_eval_status_text = e
        if not Talisman or not Talisman.config_file.disable_anims then
            Entropy.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "X"..amount.." Asc", G.C.GOLD, "entr_e_solar", 0.6)
        end
        return true
    end
    if (key == 'plus_asc') or (key == 'plusasc_mod') then
        local e = card_eval_status_text
        for i, v in pairs(SMODS.find_card("j_entr_axeh")) do
            amount = amount * v.ability.asc_mod
        end
        local hand
        if G.GAME.asc_power_hand and G.GAME.asc_power_hand ~= 0 then hand = G.GAME.asc_power_hand end
        local orig = to_big((hand or G.GAME.current_round.current_hand.cry_asc_num))
        if not G.GAME.asc_power_hand or G.GAME.asc_power_hand == 0 then G.GAME.asc_power_hand = G.GAME.current_round.current_hand.cry_asc_num or 0 end
        G.GAME.asc_power_hand = to_big(G.GAME.asc_power_hand) + to_big(amount)
        local text = number_format(to_big(G.GAME.asc_power_hand))
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.current_round.current_hand.cry_asc_num_text = (to_big(G.GAME.asc_power_hand) < to_big(0) and " (" or " (+") .. (text) .. ")" 
                return true
            end
        }))
        card_eval_status_text = function() end
        scie(effect, scored_card, "Xmult_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        scie(effect, scored_card, "Xchip_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        card_eval_status_text = e
        if not Talisman or not Talisman.config_file.disable_anims then
            Entropy.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, (to_big(amount) < to_big(0) and "" or "+")..amount.." Asc", G.C.GOLD, "entr_e_solar", 0.6)
        end
        return true
    end
    if (key == 'exp_asc') or (key == 'exp_asc_mod') then
        local e = card_eval_status_text
        for i, v in pairs(SMODS.find_card("j_entr_axeh")) do
            amount = amount * v.ability.asc_mod
        end
        local hand
        if G.GAME.asc_power_hand and G.GAME.asc_power_hand ~= 0 then hand = G.GAME.asc_power_hand end
        local orig = to_big((hand or G.GAME.current_round.current_hand.cry_asc_num))
        if not G.GAME.asc_power_hand or G.GAME.asc_power_hand == 0 then G.GAME.asc_power_hand = G.GAME.current_round.current_hand.cry_asc_num or 0 end
        G.GAME.asc_power_hand = to_big(G.GAME.asc_power_hand) ^ to_big(amount)
        local text = number_format(to_big(G.GAME.asc_power_hand))
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.current_round.current_hand.cry_asc_num_text = (to_big(G.GAME.asc_power_hand) < to_big(0) and " (" or " (+") .. (text) .. ")" 
                return true
            end
        }))
        card_eval_status_text = function() end
        scie(effect, scored_card, "Xmult_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        scie(effect, scored_card, "Xchip_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        card_eval_status_text = e
        if not Talisman or not Talisman.config_file.disable_anims then
            Entropy.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "^"..amount.." Asc", G.C.GOLD, "entr_e_solar", 0.6)
        end
        return true
    end
    if (key == 'hyper_asc') or (key == 'hyper_asc_mod') or key == "hyperasc" or key == "hyperasc_mod" then
        for i, v in pairs(SMODS.find_card("j_entr_axeh")) do
            amount = amount * v.ability.asc_mod
        end
        local e = card_eval_status_text
        local hand
        if G.GAME.asc_power_hand and G.GAME.asc_power_hand ~= 0 then hand = G.GAME.asc_power_hand end
        local orig = to_big((hand or G.GAME.current_round.current_hand.cry_asc_num))
        if not G.GAME.asc_power_hand or G.GAME.asc_power_hand == 0 then G.GAME.asc_power_hand = G.GAME.current_round.current_hand.cry_asc_num or 1 end
        G.GAME.asc_power_hand = to_big(G.GAME.asc_power_hand):arrow(amount[1], amount[2])
        local text = number_format(to_big(G.GAME.asc_power_hand))
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.current_round.current_hand.cry_asc_num_text = (to_big(G.GAME.asc_power_hand) < to_big(0) and " (" or " (+") .. (text) .. ")" 
                return true
            end
        }))
        card_eval_status_text = function() end
        scie(effect, scored_card, "Xmult_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        scie(effect, scored_card, "Xchip_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        card_eval_status_text = e
        if not Talisman or not Talisman.config_file.disable_anims then
            Entropy.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, Entropy.FormatArrowMult(amount[1], amount[2]).." Asc", G.C.GOLD, "entr_e_solar", 0.6)
        end 
        return true
    end
    if key == 'xlog_chips' then
        local chips = SMODS.Scoring_Parameters["chips"]
        chips.current = mod_chips(chips.current * math.max(math.log(to_big(chips.current) < to_big(0) and 1 or chips.current, amount), 1))
        update_hand_text({delay = 0}, {chips = chips.current})
        if not Talisman or not Talisman.config_file.disable_anims then
            Entropy.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', 1, percent, nil, nil, "Chips Xlog(Chips)", G.C.BLUE, "entr_e_rizz", 0.6)
        end
        return true
    end
end
for _, v in ipairs({'eq_mult', 'Eqmult_mod', 'eq_chips', 'Eqchips_mod', 'xlog_chips'}) do
    table.insert(SMODS.scoring_parameter_keys or SMODS.calculation_keys or {}, v)
end
for _, v in ipairs({'asc', 'asc_mod', 'plus_asc', 'plusasc_mod', 'exp_asc', 'exp_asc_mod', 'x_asc',
                    'hyper_asc', 'hyper_asc_mod', 'hyperasc', 'hyperasc_mod'}) do
    table.insert(SMODS.other_calculation_keys or SMODS.calculation_keys or {}, v)
end

local entr_define_dt = 0
local entr_antireal_dt = 0
local entr_xekanos_dt = 0
local entr_grahkon_dt = 0
local bdt = 0
local entr_prismatic_dt = 0
local update_ref = Game.update
Entropy.last_csl = nil
Entropy.last_slots = nil
local cdt = 0
local eedt = 0
local p_s = false

Entropy.ee_faces[#Entropy.ee_faces+1] = {pos = {y = 11, x = 0}}
Entropy.ee_faces[#Entropy.ee_faces+1] = {pos = {y = 12, x = 0}}
Entropy.ee_faces[#Entropy.ee_faces+1] = {pos = {y = 13, x = 0}}

function Game:update(dt)
    if entr_xekanos_dt > 0.05 then
        entr_xekanos_dt = 0
    end
    if entr_grahkon_dt > 0.1 then
        entr_grahkon_dt = 0
    end
    if bdt > 0.15 then
        bdt = 0
    end
    update_ref(self, dt)
    if G.STATE == nil and (G.pack_cards == nil or #G.pack_cards == 0) and G.GAME.DefineBoosterState then
        G.STATE = G.GAME.DefineBoosterState
        G.STATE_COMPLETE = false
        G.GAME.DefineBoosterState = nil
    end
    if self.STATE == nil and not G.DefineBoosterState then
        G.STATE = 1
        G.STATE_COMPLETE = false
    end
    entr_define_dt = entr_define_dt + dt
    entr_prismatic_dt = entr_prismatic_dt + dt
    if G.P_CENTERS and G.P_CENTERS.c_entr_define and entr_define_dt > 0.5 then
		entr_define_dt = 0
		local pointerobj = G.P_CENTERS.c_entr_define
		pointerobj.pos.x = (pointerobj.pos.x == 4) and 5 or 4
	end
    if G.P_CENTERS and G.P_CENTERS.j_entr_prismatic_shard and entr_prismatic_dt > 0.05 then
		entr_prismatic_dt = 0
		local pointerobj = G.P_CENTERS.j_entr_prismatic_shard
		pointerobj.pos.x = pointerobj.pos.x + 1
        if pointerobj.pos.x > 10 then
            pointerobj.pos.x = 0
        end
        local crimsonobj = G.P_CENTERS.j_entr_blooming_crimson
        crimsonobj.pos.x = crimsonobj.pos.x + 1
        if crimsonobj.pos.x > 7 then
            crimsonobj.pos.x = 0
        end
	end
    entr_antireal_dt = entr_antireal_dt + dt
    if G.P_CENTERS and G.P_CENTERS.j_entr_antireal and entr_antireal_dt > 0.05 then
		entr_antireal_dt = 0
		local obj = G.P_CENTERS.j_entr_antireal
		obj.pos.x = obj.pos.x + 1 
        if obj.pos.x > 11 then
            obj.pos.x = 0
            obj.pos.y = obj.pos.y + 1
        end
        if obj.pos.y > 9 then
            obj.pos.y = 0
            obj.pos.x = 0
        end
	end
    entr_xekanos_dt = entr_xekanos_dt + dt
    entr_grahkon_dt = entr_grahkon_dt + dt
    bdt = bdt + dt
    cdt = cdt + dt
    if Entropy.DeckOrSleeve("ambisinister") and cdt > 0.05 and G.jokers then
        if not Entropy.last_csl then Entropy.last_csl = G.hand.config.highlighted_limit end
        if not Entropy.last_slots then Entropy.last_slots = (G.jokers.config.card_limit - #G.jokers.cards) end
        local slots_diff = (G.jokers.config.card_limit - #G.jokers.cards) - Entropy.last_slots
        local csl_diff = (G.hand.config.highlighted_limit) - Entropy.last_csl
        if csl_diff ~= 0 then
            Entropy.handle_card_limit(G.jokers, csl_diff)
        end
        if slots_diff ~= 0 then
            G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + slots_diff
            G.GAME.starting_params.discard_limit = G.GAME.starting_params.discard_limit + slots_diff
            G.GAME.starting_params.play_limit = G.GAME.starting_params.play_limit + slots_diff
        end
        Entropy.last_slots = G.jokers.config.card_limit - #G.jokers.cards
        G.hand.config.highlighted_limit = (G.jokers.config.card_limit - #G.jokers.cards)
        G.GAME.starting_params.play_limit = (G.jokers.config.card_limit - #G.jokers.cards)
        G.GAME.starting_params.discard_limit = (G.jokers.config.card_limit - #G.jokers.cards)
        SMODS.hand_limit_strings.discard = G.GAME.starting_params.discard_limit ~= 5 and localize('b_limit') .. G.GAME.starting_params.discard_limit or ''
        SMODS.hand_limit_strings.play = G.GAME.starting_params.play_limit ~= 5 and localize('b_limit') .. G.GAME.starting_params.play_limit or ''
        Entropy.last_csl = G.hand.config.highlighted_limit
    end
    if not Entropy.DeckOrSleeve("ambisinister") and cdt > 0.05 then
        Entropy.last_csl = nil
        Entropy.last_slots = nil
        cdt = 0
    end

    if G.GAME.blind and (Entropy.BlindIs("bl_entr_endless_entropy_phase_one") 
    or Entropy.BlindIs("bl_entr_endless_entropy_phase_two") 
    or Entropy.BlindIs("bl_entr_endless_entropy_phase_three") 
    or Entropy.BlindIs("bl_entr_endless_entropy_phase_four"))
    then
        G.GAME.EE_FADE = G.GAME.EE_FADE or 0
        G.GAME.EE_FADE = G.GAME.EE_FADE + dt * 0.5
        eedt = eedt - dt
        if eedt <= 0 then
            p_s = not p_s
            if p_s then
                local atlas = "entr_blinds"
                G.GAME.blind.children.animatedSprite:set_sprite_pos(G.GAME.blind.config.blind.pos)
                G.GAME.blind.children.animatedSprite.atlas = G.ANIMATION_ATLAS[atlas]
                G.GAME.blind.children.animatedSprite:reset()
                eedt = 0.8 + math.random() * 0.7
            else
                local elem = pseudorandom_element(Entropy.ee_faces, pseudoseed("asdkljasdkjlasdk;j"))
                atlas = elem.atlas or "entr_blinds"
                G.GAME.blind.children.animatedSprite:set_sprite_pos(elem.pos)
                G.GAME.blind.children.animatedSprite.atlas = G.ANIMATION_ATLAS[atlas]
                G.GAME.blind.children.animatedSprite:reset()
                eedt = math.random() * 0.4 + 0.1
            end
        end
    end
    if G.GAME.EE_R then
        if G.GAME.EE_FADE > 10 then
            G.GAME.EE_FADE = 10
        end
        G.GAME.EE_FADE = G.GAME.EE_FADE - dt * 3
    end
end

local card_drawref = Card.draw
function Card:draw(layer)
    if self.config.center.key == "j_entr_xekanos" then
        if entr_xekanos_dt > 0.05 then
            local v = self
            local obj = {pos = v.children.floating_sprite2.sprite_pos}
            obj.pos.x = obj.pos.x + 1 
            if obj.pos.x > 4 then
                obj.pos.x = 0
                obj.pos.y = obj.pos.y + 1
            end
            if obj.pos.y > 2 then
                obj.pos.y = 0
                obj.pos.x = 0
            end
            v.children.floating_sprite2:set_sprite_pos(obj.pos)
            v.children.floating_sprite:set_sprite_pos({x=1, y=3})
        end
    end
    if self.config.center.key == "j_entr_grahkon" or self.config.center.key == "j_entr_nokharg" then
        if entr_grahkon_dt > 0.1 then
            local v = self
            local obj = {pos = v.children.floating_sprite.sprite_pos}
            obj.pos.x = obj.pos.x + 1 
            if obj.pos.x > 5 then
                obj.pos.x = 1
                obj.pos.y = obj.pos.y + 1
            end
            if obj.pos.y > 3 then
                obj.pos.y = 0
                obj.pos.x = 1
            end
            v.children.floating_sprite:set_sprite_pos(obj.pos)
        end
    end
    if bdt >= 0.15 and self.config.center.set == "CBlind" then
        local obj = {pos = self.children.center.sprite_pos}
        obj.pos.x = obj.pos.x + 1
        if to_number(obj.pos.x) >= to_number(self.children.center.atlas.frames or 21) then
            obj.pos.x = 0
        end
    end
    return card_drawref(self, layer)
end

local ref = level_up_hand
function level_up_hand(card, hand, instant, amount, ...)
    if next(SMODS.find_card("j_entr_strawberry_pie")) and hand ~= "High Card" then
        for i, v in pairs(SMODS.find_card("j_entr_strawberry_pie")) do
            if SMODS.pseudorandom_probability(v, v.ability.num, v.ability.denom, "entr_strawberry") then
                hand = "High Card"
            end
        end 
    end
    local val = ref(card,hand,instant,amount, ...)
    return val
end

local start_dissolveref = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    if not self.ability.no_destroy and G.deck then
        SMODS.calculate_context({card_being_destroyed=true, card=self, cardarea == self.area})
    end
    if self.delay_dissolve then
        local s = self.delay_dissolve
        local d
        if type(s) == "table" then s = s.type; d = s.delay end
        if s == "after_after" then
            G.E_MANAGER:add_event(Event{
                trigger = "after",
                blocking = false,
                func = function()
                    G.E_MANAGER:add_event(Event{
                        trigger = "after",
                        delay = d,
                        func = function()
                            start_dissolveref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
                            return true
                        end
                    })
                    return true
                end
            })
        else
            G.E_MANAGER:add_event(Event{
                trigger = type(s) == "string" and s or nil,
                delay = d,
                func = function()
                    start_dissolveref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
                    return true
                end
            })
        end
    else    
        start_dissolveref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
    end
end

Entropy.ChaosBlacklist.Back = true
Entropy.ChaosBlacklist.Sleeve = true
Entropy.ChaosBlacklist.CBlind = true
Entropy.ChaosBlacklist.Edition = true
Entropy.ChaosBlacklist.Default = true
Entropy.ChaosBlacklist["Content Set"] = true
Entropy.ParakmiBlacklist["Content Set"] = true
Entropy.ParakmiBlacklist.Edition = true
Entropy.ParakmiBlacklist.Default = true
Entropy.ParakmiBlacklist.Tag = true
Entropy.ParakmiBlacklist.Seal = true
Entropy.ParakmiBlacklist.Stake = true
Entropy.ParakmiBlacklist.Unique = true
Entropy.ParakmiBlacklist.sleeve_casl_none = true
Entropy.ChaosConversions.Command = "Twisted"
Entropy.ChaosConversions.Star = "Twisted"
Entropy.ChaosConversions.Omen = "Twisted"
Entropy.ChaosConversions.Pact = "Twisted"
local ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, dont_calculate,...)
    if (next(find_joker("j_entr_chaos")) or next(find_joker("j_entr_parakmi")) or G.GAME.modifiers.entr_parakmi) and not forced_key then
        _type = Entropy.GetRandomSet(next(find_joker("j_entr_parakmi")) or G.GAME.modifiers.entr_parakmi)

    end
    if _type == "CBlind" then
        _type = "BlindTokens"
    end
    if _type == "BlindTokens" then
        local element = "c_"..pseudorandom_element(Entropy.BlindC, pseudoseed(key_append or "parakmi"))
        forced_key = forced_key or element
    end
    if area == G.pack_cards and not dont_calculate then
        if soulable and not forced_key and Entropy.has_rune("rune_entr_oss") then
            local valid = {}
            for _, v in ipairs(SMODS.Consumable.legendaries) do
                if (_type == v.type.key or _type == v.soul_set) and not (G.GAME.used_jokers[v.key] and not SMODS.showman(v.key) and not v.can_repeat_soul) and (not v.in_pool or (type(v.in_pool) ~= "function") or v:in_pool({})) then
                    valid[#valid+1] = v
                end
            end
            if (_type == 'Tarot' or _type == 'Spectral' or _type == 'Tarot_Planet') and
            not (G.GAME.used_jokers['c_soul'] and not SMODS.showman('c_soul')) then
                valid[#valid+1] = G.P_CENTERS.c_soul
            end
            if (_type == 'Planet' or _type == 'Spectral') and
            not (G.GAME.used_jokers['c_black_hole'] and not SMODS.showman('c_black_hole')) then
                valid[#valid+1] = G.P_CENTERS.c_black_hole
            end
            if #valid > 0 then
                Entropy.has_rune("rune_entr_oss").triggered = true
                local card =  ref(_type, area, legendary, _rarity, skip_materialize, false, pseudorandom_element(valid, pseudoseed("rune_entr_oss")).key, key_append, dont_calculate, ...)
                Entropy.post_create_card(card, area == G.pack_cards, forced_key)
                return card
            end
        elseif not forced_key then
            if Entropy.has_rune("rune_entr_mannaz") and (Entropy.has_rune("rune_entr_mannaz").num_triggered or 0) <= 1 then
                Entropy.has_rune("rune_entr_mannaz").num_triggered = (Entropy.has_rune("rune_entr_mannaz").num_triggered or 0) + 1
                if Entropy.has_rune("rune_entr_mannaz").num_triggered > 1 or not G.GAME.providence then
                    Entropy.has_rune("rune_entr_mannaz").num_triggered = 2
                    Entropy.has_rune("rune_entr_mannaz").triggered = true
                end
                local card = ref("Spectral", area or G.pack_cards, nil, nil, true, true, nil, "rune_entr_mannaz", dont_calculate, ...)
                Entropy.post_create_card(card, area == G.pack_cards, forced_key)
                return card
            end
        end
    end
    local card = ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, dont_calculate, ...)
    if card and card.ability and card.ability.name == "entr-solarflare" then
		card:set_edition("e_entr_solar", true, nil, true)
	end
    if card and card.ability and card.ability.name == "entr-trapezium_cluster" then
		card:set_edition("e_entr_fractured", true, nil, true)
	end
    if card and card.ability and card.ability.name == "entr-eden" then
		card:set_edition("e_entr_sunny", true, nil, true)
	end
    if card and card.ability and card.ability.name == "entr-ridiculus_absens" then
		card:set_edition("e_cry_glitched", true, nil, true)
        card.ability.cry_prob = 1
        card.ability.extra.odds = 2 
	end
    if (next(find_joker("j_entr_chaos")) or next(find_joker("j_entr_parakmi")) or G.GAME.modifiers.entr_parakmi) and not forced_key then 
        if not G.SETTINGS.paused and not G.GAME.akyrs_any_drag then
            card.fromdefine = true
        end
    end
    if card and card.config and card.config.center and card.config.center.key == "c_base" and Entropy.DeckOrSleeve("crafting") then
        if pseudorandom("crafting") < 0.5 then
            card:set_ability(SMODS.poll_enhancement({guaranteed = true, key = "entr_crafting"}))
        end
	end
    if card and card.ability and card.ability.consumeable then
        for i, a in pairs(SMODS.get_card_areas('jokers')) do
            for _, c in pairs(a.cards) do
                if c.config.center.calculate then
                    local ret = c.config.center:calculate(c, {
                        get_consumable_type = true,
                        set = card.config.center.set,
                        hidden = card.config.center.hidden,
                        other_card = card
                    })
                    if ret and (ret.set or ret.key) then
                        card:set_ability(ret.key and G.P_CENTERS[ret.key] or Entropy.GetPooledCenter(ret.set))
                        break
                    end
                end
            end
        end
    end
    if card and card.ability and card.ability.consumeable then
        SMODS.calculate_context{entr_consumable_created = true, other_card = card}
    end
    if next(SMODS.find_card("j_entr_kitchenjokers")) and card:is_food() then
        card:set_edition("e_entr_lowres")
    end
    Entropy.post_create_card(card, area == G.pack_cards, forced_key)
    return card
end

local ref = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
    local tbl = ref(context,return_table)
    if G.GAME.entr_bought_decks then
        for i, v in pairs(G.GAME.entr_bought_decks or {}) do
            if G.P_CENTERS[v].calculate then
                local ret = G.P_CENTERS[v].calculate(G.P_CENTERS[v], nil, context or {})
                for k,v in pairs(ret or {}) do 
                    tbl[k] = v 
                end
            end
        end
    end
    if not return_table then
        return tbl
    end
end

local trigger_effectref = Back.trigger_effect
function Back:trigger_effect(args, ...)
    local chips, mult = trigger_effectref(self, args, ...)
    if G.GAME.entr_bought_decks then
        for i, v in pairs(G.GAME.entr_bought_decks or {}) do
            if v == 'b_anaglyph' and args.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_double'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
            end
            if v == "b_plasma" and args.context == 'final_scoring_step' then
                chips = chips or args.chips
                mult = mult or args.mult
                local tot = chips + mult
                chips = math.floor(tot/2)
                mult = math.floor(tot/2)
                update_hand_text({delay = 0}, {mult = mult, chips = chips})

                G.E_MANAGER:add_event(Event({
                    func = (function()
                        local text = localize('k_balanced')
                        play_sound('gong', 0.94, 0.3)
                        play_sound('gong', 0.94*1.5, 0.2)
                        play_sound('tarot1', 1.5)
                        ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                        ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                        attention_text({
                            scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                        })
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            blockable = false,
                            blocking = false,
                            delay =  4.3,
                            func = (function() 
                                    ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                                    ease_colour(G.C.UI_MULT, G.C.RED, 2)
                                return true
                            end)
                        }))
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            blockable = false,
                            blocking = false,
                            no_delete = true,
                            delay =  6.3,
                            func = (function() 
                                G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                                G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                                return true
                            end)
                        }))
                        return true
                    end)
                }))
            end
        end
    end
    return chips, mult
end

local ref = create_shop_card_ui
function create_shop_card_ui(card, type, area)
    if card.config.center.set == "Back" or card.config.center.set == "Sleeve" then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.43,
            blocking = false,
            blockable = false,
            func = (function()
              if card.opening then return true end
              local t1 = {
                  n=G.UIT.ROOT, config = {minw = 0.6, align = 'tm', colour = darken(G.C.BLACK, 0.2), shadow = true, r = 0.05, padding = 0.05, minh = 1}, nodes={
                      {n=G.UIT.R, config={align = "cm", colour = lighten(G.C.BLACK, 0.1), r = 0.1, minw = 1, minh = 0.55, emboss = 0.05, padding = 0.03}, nodes={
                        {n=G.UIT.O, config={object = DynaText({string = {{prefix = localize('$'), ref_table = card, ref_value = 'cost'}}, colours = {G.C.MONEY},shadow = true, silent = true, bump = true, pop_in = 0, scale = 0.5})}},
                      }}
                  }}
              local t2 = {
                n=G.UIT.ROOT, config = {ref_table = card, minw = 1.1, maxw = 1.3, padding = 0.1, align = 'bm', colour = G.C.GOLD, shadow = true, r = 0.08, minh = 0.94, func = 'can_buy_deckorsleeve_from_shop', one_press = true, button = 'buy_deckorsleeve_from_shop', hover = true}, nodes={
                    {n=G.UIT.T, config={text = localize('b_buy'),colour = G.C.WHITE, scale = 0.5}}
                }}

              card.children.price = UIBox{
                definition = t1,
                config = {
                  align="tm",
                  offset = {x=0,y=1.5},
                  major = card,
                  bond = 'Weak',
                  parent = card
                }
              }
    
              card.children.buy_button = UIBox{
                definition = t2,
                config = {
                  align="bm",
                  offset = {x=0,y=-0.3},
                  major = card,
                  bond = 'Weak',
                  parent = card
                }
              }
              card.children.price.alignment.offset.y = card.ability.set == 'Booster' and 0.5 or 0.38
    
                return true
            end)
          }))
    else
        ref(card, type, area)
    end
end

function Cryptid.ascend(num, curr2) -- edit this function at your leisure
    G.GAME.sunnumber = G.GAME.sunnumber or {}
    local snum
    if type(G.GAME.sunnumber) == "table" then snum = G.GAME.sunnumber.not_modest or 0 
    else snum = G.GAME.sunnumber end
    curr2 =
        curr2 or
        ((G.GAME.current_round.current_hand.cry_asc_num or 0) + (G.GAME.asc_power_hand or 0)) *
            (1 + (G.GAME.nemesisnumber or 0))
    local num2 = math.min(curr2 or 0, 50)
    local diff = curr2 - num2
    if to_big(curr2 or 0) > to_big(40) then
        num2 = num2 + diff ^ 0.3
    end
    curr2 = num2
    if next(SMODS.find_card("j_entr_helios")) then
        local curr = 1
        for i, v in pairs(G.jokers.cards) do
            if not v.debuff and v.config.center.key == "j_entr_helios" and to_big(v.ability.extra):gt(curr) then
                curr = v.ability.extra + 0.4
            end
        end
        return num ^ (to_big((1.75 + snum)) * (to_big((curr2) * curr)))
    else
        return num * (to_big((1.25 + snum)) ^ to_big(curr2))
    end
end

local pokerhandinforef = G.FUNCS.get_poker_hand_info
function G.FUNCS.get_poker_hand_info(_cards)
    G.GAME.current_round.current_hand.cry_asc_num = 0
    if next(SMODS.find_card("j_entr_helios")) or (Entropy.BlindIs("bl_entr_scarlet_sun") and not G.GAME.blind.disabled) then G.GAME.used_vouchers.v_cry_hyperspacetether = true end
    local text, loc_disp_text, poker_hands, scoring_hand, disp_text = pokerhandinforef(_cards)
    if text and G.GAME.badarg and G.GAME.badarg[text] and text ~= "NULL" then
        G.boss_throw_hand = true
        G.bad_arg = true
        G.E_MANAGER:add_event(Event({
        func = function()
            update_hand_text_random({delay = 0}, {chips="bad", mult="arg", handname = ""})
            return true
        end}))
    else
        G.bad_arg = nil
    end
    local all_flesh = true
    for i, v in pairs(scoring_hand) do
        if v.config.center.key ~= "m_entr_flesh" then all_flesh = false end
    end
    if all_flesh then
        if text == "Flush" then 
            disp_text = "entr-Flesh"
			loc_disp_text = localize(disp_text, "poker_hands")
        end
        if text == "Flush House" then 
            disp_text = "entr-Flesh_House"
			loc_disp_text = localize(disp_text, "poker_hands")
        end
        if text == "Flush Five" then 
            disp_text = "entr-Flesh_Five"
			loc_disp_text = localize(disp_text, "poker_hands")
        end
        if text == "Straight Flush" then 
            disp_text = "entr-Straight_Flesh"
			loc_disp_text = localize(disp_text, "poker_hands")
        end
    end
    return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end

local ease_anteref = ease_ante
function ease_ante(mod)
    local mult = 1
    if to_big(mod) ~= to_big(0) then
        if next(SMODS.find_card("j_entr_xekanos")) then
            for i, v in pairs(G.jokers.cards) do
                if v.config.center.key == "j_entr_xekanos" and not v.debuff and not v.ability.turned_off and not G.GAME.modifiers.ReverseRedeo then
                    mult = mult * to_number(-v.ability.ante_mod)
                    if not v.ability.entr_pure then
                        v.ability.ante_mod = v.ability.ante_mod - v.ability.ante_mod_mod
                    end
                end
            end
        end
        local t
        for i, v in pairs(G.GAME.runes or {}) do
            if G.P_RUNES[v.key].calculate then
                local ret = G.P_RUNES[v.key]:calculate(v, {entr_ante_change = mod})
                if ret then
                    v:yep("+", G.C.PURPLE, function()
                        return true
                    end)
                    if ret.ante_mod then
                        mod = ret.ante_mod
                        t = v
                        break
                    end
                end
            end
        end
        if t then
            SMODS.calculate_context({rune_triggered = true, rune = v})
        end
        ease_anteref(mod * mult, a)
    end
end

local is_jollyref = Card.is_jolly
function Card:is_jolly()
	if next(SMODS.find_card("j_entr_dekatria")) then return true end
    return is_jollyref(self)
end

local AscendantTags = {
    tag_uncommon="tag_entr_ascendant_rare",
    tag_rare= (SMODS.Mods["Cryptid"] or {}).can_load and "tag_entr_ascendant_epic" or "tag_entr_ascendant_rare",
    tag_negative="tag_entr_ascendant_negative",
    tag_foil="tag_entr_ascendant_foil",
    tag_holo="tag_entr_ascendant_holo",
    tag_polychrome="tag_entr_ascendant_poly",
    tag_investment="tag_entr_ascendant_stock",
    tag_voucher="tag_entr_ascendant_voucher",
    tag_boss="tag_entr_ascendant_blind",
    tag_standard="tag_entr_ascendant_twisted",
    tag_charm="tag_entr_ascendant_twisted",
    tag_meteor="tag_entr_ascendant_twisted",
    tag_buffoon="tag_entr_ascendant_ejoker",
    tag_handy="tag_entr_ascendant_stock",
    tag_garbage="tag_entr_ascendant_stock",
    tag_ethereal="tag_entr_ascendant_twisted",
    tag_coupon="tag_entr_ascendant_credit",
    tag_double="tag_entr_ascendant_copying",
    tag_juggle="tag_entr_ascendant_effarcire",
    tag_d_six="tag_entr_ascendant_credit",
    tag_top_up="tag_entr_ascendant_topup",
    tag_skip="tag_entr_ascendant_stock",
    tag_economy="tag_entr_ascendant_stock",
    tag_orbital="tag_entr_ascendant_universal",
    tag_cry_epic="tag_entr_ascendant_epic",
    tag_cry_glitched="tag_entr_ascendant_glitched",
    tag_cry_mosaic="tag_entr_ascendant_mosaic",
    tag_cry_oversat="tag_entr_ascendant_oversat",
    tag_cry_glass="tag_entr_ascendant_glass",
    tag_cry_gold="tag_entr_ascendant_gold",
    tag_cry_blur="tag_entr_ascendant_blurry",
    tag_cry_astral="tag_entr_ascendant_astral",
    tag_cry_m="tag_entr_ascendant_m",
    tag_cry_double_m="tag_entr_ascendant_m",
    tag_cry_cat="tag_entr_ascendant_cat",
    tag_cry_gambler="tag_entr_ascendant_unbounded",
    tag_cry_empowered="tag_entr_ascendant_unbounded",
    tag_cry_better_voucher="tag_entr_ascendant_better_voucher",
    tag_cry_memory="tag_entr_ascendant_copying",
    tag_cry_better_top_up="tag_entr_ascendant_better_topup",
    tag_cry_bundle="tag_entr_ascendant_ebundle",
    tag_cry_gourmand="tag_entr_ascendant_saint",
    tag_cry_triple="tag_entr_ascendant_copying",
    tag_cry_quadruple="tag_entr_ascendant_copying",
    tag_cry_quintuple="tag_entr_ascendant_copying",
    tag_cry_scope="tag_entr_ascendant_infdiscard",
    tag_cry_schematic="tag_entr_ascendant_canvas",
    tag_cry_loss="tag_entr_ascendant_reference",
    tag_cry_banana="tag_entr_ascendant_cavendish",
    tag_cry_booster="tag_entr_ascendant_booster",
    tag_cry_console="tag_entr_ascendant_twisted",
    tag_entr_dog="tag_entr_ascendant_dog",
    tag_entr_solar="tag_entr_ascendant_solar",
    tag_entr_ascendant_rare=(SMODS.Mods["Cryptid"] or {}).can_load and "tag_entr_ascendant_epic" or nil,
    tag_entr_ascendant_epic="tag_entr_ascendant_legendary",
    --tag_entr_ascendant_legendary="tag_entr_ascendant_exotic",
    --tag_entr_ascendant_exotic="tag_entr_ascendant_entropic",
    tag_entr_sunny = "tag_entr_ascendant_sunny",
    tag_entr_freaky = "tag_entr_ascendant_freaky",
    tag_entr_fractured = "tag_entr_ascendant_fractured",
    tag_valk_kitty = "tag_entr_ascendant_kitty",
    tag_valk_negativeeternal = "tag_entr_ascendant_negative_eternal",

    tag_entr_fractured = "tag_entr_ascendant_fractured",
    tag_entr_freaky = "tag_entr_ascendant_freaky",
    tag_entr_kaleidoscopic = "tag_entr_ascendant_kaleidoscopic",
    tag_entr_neon = "tag_entr_ascendant_neon",
    tag_entr_lowres = "tag_entr_ascendant_lowres",
    tag_entr_arcane = "tag_entr_ascendant_arcane",
    tag_entr_gilded = "tag_entr_ascendant_gilded"
}
for i, v in pairs(AscendantTags) do Entropy.AscendedTags[i]=v end

local ref = Tag.init
function Tag:init(_tag, for_collection, _blind_type, ...)
    if next(SMODS.find_card("j_entr_ruby")) and not for_collection then
        local roll = pseudorandom("ruby_asc")
        if roll < 0.15 and Entropy.AscendedTags[_tag] then
            _tag = Entropy.AscendedTags[_tag]
        end
    end
    if next(SMODS.find_card("j_entr_exousia")) and Entropy.AscendedTags[_tag] and not for_collection then 
        _tag = Entropy.AscendedTags[_tag]
        local procs = 1
        while pseudorandom("exousia") < 0.1 and procs < #SMODS.find_card("j_entr_exousia") and Entropy.AscendedTags[_tag] and not for_collection do
            _tag = Entropy.AscendedTags[_tag]
        end
    end
    local ret = ref(self, _tag, for_collection, _blind_type, ...)
    tag = self
    if G.P_TAGS[tag.key] and G.P_TAGS[tag.key].set_ability then
        G.P_TAGS[tag.key]:set_ability(tag)
    end
    return ret
end

G.FUNCS.has_inversion = function(e) 
    if G.GAME.last_inversion and G.GAME.last_inversion.key ~= "c_entr_master" then 
        e.config.colour = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
    else
        e.config.colour = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
    end
 end

 G.FUNCS.has_fraud = function(e) 
    if G.GAME.last_fraud and G.GAME.last_fraud ~= "c_entr_prophecy" then 
        e.config.colour = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
    else
        e.config.colour = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
    end
 end
local ref = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
    local twis = G.GAME.modifiers.entr_twisted
    G.GAME.modifiers.entr_twisted = nil
    local card = e.config.ref_table
    if card.ability.consumeable then
        local center = card.config.center
        if center and center.calculate then
            center:calculate(card, {pre_using_self = true, consumeable = card, area = card.from_area})
        end
        local edition = card.edition and G.P_CENTERS[card.edition.key]
        if edition and edition.calculate then
            edition:calculate(card, {pre_using_self = true, consumeable = card, area = card.from_area})
        end
        SMODS.calculate_context({pre_using_consumeable = true, consumeable = card, area = card.from_area})
    end
    card.ability.bypass_aleph = true
    ref(e, mute, nosave)
    G.GAME.modifiers.entr_twisted = twis
    G.E_MANAGER:add_event(Event{
        trigger = "after",
        delay = 2,
        blocking = false,
        blockable = true,
        func = function()
        if Entropy.is_inverted(card.config.center) and not card.config.center.hidden then
                G.GAME.last_inversion = {
                    key = card.config.center.key,
                    set = card.config.center.set
                }
            elseif not card.config.center.hidden and next(SMODS.find_card("j_entr_enlightenment")) then
                G.GAME.last_tarot_planet = card.config.center.key
            end
            if card.config.center.set == "Fraud" and (card.config.center.key ~= "c_entr_prophecy" or not G.GAME.last_fraud) then
                G.GAME.last_fraud = {
                    key = card.config.center.key,
                    set = card.config.center.set
                }
            end
            G.GAME.entr_used_cards = G.GAME.entr_used_cards or {}
            G.GAME.entr_used_cards[card.config.center.key] = (G.GAME.entr_used_cards[card.config.center.key] or 0) + 1
            return true
        end
    })
    for i, v in pairs(SMODS.find_card("j_entr_shadow_crystal")) do
        if SMODS.pseudorandom_probability(card, 'shadow_crystal', 1, v.ability.extra.odds) and Entropy.Inversion(card) and not card.config.center.hidden then
            local dummy = Entropy.GetDummy(G.P_CENTERS[Entropy.Inversion(card)], card.area, card)
            Cryptid.forcetrigger(dummy, {})
            break
        end
    end
end

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
    end
    main_ref(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    if G.GAME.UsingBootstrap then
        G.GAME.Bootstrap = {
            Mult = mult,
            Chips = hand_chips
        }
        G.GAME.UsingBootstrap = nil
    end
    if G.GAME.Bootstrap then
        G.GAME.hands[text].mult = m
        G.GAME.hands[text].chips = c
        if poker_hands[text] then
            poker_hands[text].mult = m
            poker_hands[text].chips = c
        end
        G.GAME.Bootstrap = nil
    end
    return text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta
end
local set_abilityref = Card.set_ability
function Card:set_ability(center, f, s)
    if type(center) == "string" then center = G.P_CENTERS[center] end
    if center and center.set == "Joker" and G.GAME.magic_skin_prob and pseudorandom("entr_magic_skin") < G.GAME.magic_skin_prob then
        set_abilityref(self, G.P_CENTERS.j_entr_magic_skin, initial, delay_sprites)
        return
    end
    if (self.config and self.config.center and self.config.center.key ~= "m_entr_disavowed" and (not self.entr_aleph or self.ability.bypass_aleph)) or G.SETTINGS.paused then
        set_abilityref(self, center, f, s)
    else
        if not self.entr_aleph and not G.SETTINGS.paused then
            set_abilityref(self, G.P_CENTERS.m_entr_disavowed, f, s)
        else
            set_abilityref(self, self.config.center, f, s)
        end
    end
    if (G.GAME.modifiers.entr_reverse_redeo or G.GAME.ReverseRedeo) and self.config.center.key == "j_cry_redeo" then
        self.ability.extra.ante_reduction = -1
    end
    if self.ability.consumeable and Entropy.has_rune("rune_entr_gluttony") then
        self.ability.eternal = true
    end
end

local set_abilityref = Card.set_ability
function Card:set_ability(center, ...)
    if type(center) == "string" then center = G.P_CENTERS[center] end
    if center and Entropy.is_inverted(center) and G.GAME.next_inversions_prophecy and not G.SETTINGS.paused then
        set_abilityref(self, G.P_CENTERS[G.GAME.next_inversions_prophecy], ...)
        G.GAME.inversions_prophecy_counter = (G.GAME.inversions_prophecy_counter or 2) - 1
    else
        set_abilityref(self, center, ...)
    end
    if G.GAME.inversions_prophecy_counter and to_big(G.GAME.inversions_prophecy_counter) <= to_big(0) then
        G.GAME.next_inversions_prophecy = nil
        G.GAME.inversions_prophecy_counter = nil
    end
end

local use_cardref = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
	local card = e.config.ref_table
    if card.ability.glitched_crown then
        card:set_ability(G.P_CENTERS[card.ability.glitched_crown[card.glitched_index]])
        card.ability.glitched_crown = nil
    end
	if card.config.center.set ~= "Booster" and Entropy.DeckOrSleeve("doc") then
    local num = 1
    for i, v in pairs(G.GAME.entr_bought_decks or {}) do if v == "b_entr_doc" or v == "sleeve_entr_doc" then num = num + 1 end end
		if Entropy.is_inverted(card.config.center) then
			ease_entropy(2*num*Entropy.DeckOrSleeve("doc"))
		else
			ease_entropy(1*num*Entropy.DeckOrSleeve("doc"))
		end
	end
	use_cardref(e, mute, nosave)
end
SMODS.Booster:take_ownership_by_kind('Spectral', {
	create_card = function(self, card, i)
		G.GAME.entropy = G.GAME.entropy or 0
		if to_big(pseudorandom("doc")) < to_big(1 - 0.997^(G.GAME.entropy/2)) and Entropy.DeckOrSleeve("doc") and Cryptid.enabled("c_entr_beyond") == true then
			return create_card("Omen", G.pack_cards, nil, nil, true, true, "c_entr_beyond")
		elseif to_big(pseudorandom("doc")) < to_big(1 - 0.996^(G.GAME.entropy/2)) and Entropy.DeckOrSleeve("doc") and Cryptid.enabled("c_cry_gateway") == true then
			return create_card("Spectral", G.pack_cards, nil, nil, true, true, "c_cry_gateway")
		end
		return create_card("Spectral", G.pack_cards, nil, nil, true, true, nil, "spe")
	end
},true)
SMODS.Consumable:take_ownership("cry_gateway",{
	use = function(self, card, area, copier)
		if not Entropy.DeckOrSleeve("doc") and (#SMODS.find_card("j_jen_saint") + #SMODS.find_card("j_jen_saint_attuned")) <= 0 then
			local deletable_jokers = {}
			for k, v in pairs(G.jokers.cards) do
				if not SMODS.is_eternal(v) then
					deletable_jokers[#deletable_jokers + 1] = v
				end
			end
			local _first_dissolve = nil
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.75,
				func = function()
					for k, v in pairs(deletable_jokers) do
						if v.config.center.rarity == "cry_exotic" then
							check_for_unlock({ type = "what_have_you_done" })
						end
						v:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
					return true
				end,
			}))
		end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, "cry_exotic", nil, nil, nil, "cry_gateway")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
    if Entropy.DeckOrSleeve("doc") then
      ease_entropy(-math.min(G.GAME.entropy, 5))
    end
	end
},true)
local uibox_ref = create_UIBox_HUD
function create_UIBox_HUD()
  local orig = uibox_ref()
	if not Entropy.DeckOrSleeve("doc") then return orig end
    local scale = 0.4
    local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.5)

    local contents = {}

    local spacing = 0.13
    local temp_col = G.C.DYN_UI.BOSS_MAIN
    local temp_col2 = G.C.DYN_UI.BOSS_DARK
    
    contents.buttons = {
      {n=G.UIT.C, config={align = "cm", r=0.1, colour = G.C.CLEAR, shadow = true, id = 'button_area',padding=0.33}, nodes={
        {n=G.UIT.R, config={id = 'run_info_button', align = "cm", minh = 1, minw = 1.5,padding = 0.05, r = 0.1, hover = true, colour = G.C.RED, button = "run_info", shadow = true}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 2}, nodes={
          {n=G.UIT.T, config={text = localize('b_run_info_1'), scale = 1.2*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
        }},
        {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 2}, nodes={
          {n=G.UIT.T, config={text = localize('b_run_info_2'), scale = 1*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true, focus_args = {button = G.F_GUIDE and 'guide' or 'back', orientation = 'bm'}, func = 'set_button_pip'}}
        }}
        }},
        {n=G.UIT.R, config={align = "cm", minh = 1, minw = 2,padding = 0.05, r = 0.1, hover = true, colour = G.C.ORANGE, button = "options", shadow = true}, nodes={
        {n=G.UIT.C, config={align = "cm", maxw = 1.4, focus_args = {button = 'start', orientation = 'bm'}, func = 'set_button_pip'}, nodes={
          {n=G.UIT.T, config={text = localize('b_options'), scale = scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
        }},
        }},
        {n=G.UIT.R, config={align = "cm", minh = 1, minw = 2,padding = 0.05, r = 0.1, hover = true, colour=G.C.DYN_UI.BOSS_MAIN,emboss=0.05}, nodes={
        {n=G.UIT.R, config={align = "cm", maxw = 1.35}, nodes={
          {n=G.UIT.T, config={text = localize('k_entropy'), minh = 0.33, scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
        }},
        {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.8, colour = temp_col2, id = 'row_entropy_text'}, nodes={
          {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'entropy'}}, colours = {G.C.IMPORTANT},shadow = true, scale = 2*scale}),id = 'entropy_UI_count'}},
        }},
        }}
      }}
    }
    --heres the one bit of compat ill do on my end
    if SMODS.Mods.jen and SMODS.Mods.jen.can_load then
      orig.nodes[1].nodes[1].nodes[5].nodes[1].nodes[6] = {n=G.UIT.R, config={align = "cm"}, nodes={
        {n=G.UIT.C, config={id = 'hud_tension',align = "cm", padding = 0.05, minw = 1.45, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
          {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
            {n=G.UIT.T, config={text = 'Tension', scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
            {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'tension'}}, colours = {G.C.CRY_EMBER},shadow = true, font = G.LANGUAGES['en-us'].font, scale = scale_number(G.GAME.tension, 2*scale, 100)}),id = 'tension_UI_count'}},
          }},
        }},
        {n=G.UIT.C, config={minw = spacing},nodes={}},
        {n=G.UIT.C, config={id = 'hud_relief',align = "cm", padding = 0.05, minw = 1.45, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
          {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
            {n=G.UIT.T, config={text = 'Relief', scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
            {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'relief'}}, colours = {G.C.CRY_VERDANT},shadow = true, font = G.LANGUAGES['en-us'].font, scale = scale_number(G.GAME.relief, 2*scale, 100)}),id = 'relief_UI_count'}},
          }},
        }},
        {n=G.UIT.C, config={minw = spacing},nodes={}},
        {n=G.UIT.C, config={id = 'hud_entropy',align = "cm", padding = 0.05, minw = 1.45, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
          {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
            {n=G.UIT.T, config={text = localize('k_entropy'), scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
            {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'entropy'}}, colours = {G.C.IMPORTANT},shadow = true, font = G.LANGUAGES['en-us'].font, scale = 2*scale}),id = 'entropy_UI_count'}},
          }},
        }},
      }}
    else  
      orig.nodes[1].nodes[1].nodes[5].nodes[1].nodes = contents.buttons
    end
    return orig
end


function ease_entropy(mod)
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
          local round_UI = G.HUD:get_UIE_by_ID('entropy_UI_count')
          mod = mod or 0
          local text = '+'
          local col = G.C.IMPORTANT
          if to_big(mod) < to_big(0) then
              text = ''
              col = G.C.RED
          end
          G.GAME.entropy = (G.GAME.entropy or 0) + mod
          if round_UI then
            G.HUD:recalculate()
            if not Talisman or not Talisman.config_file.disable_anims then
              attention_text({
                text = text..tostring(math.abs(mod)),
                scale = 1, 
                hold = 0.7,
                cover = round_UI.parent,
                cover_colour = col,
                align = 'cm',
              })
            end
          end
          --Play a chip sound
          if not Talisman or not Talisman.config_file.disable_anims then
            play_sound('timpani', 0.8)
            play_sound('generic1')
          end
          return true
      end
    }))
end


local apply_ref = Cryptid.antimatter_apply
function Cryptid.antimatter_apply(skip)
  apply_ref(skip)
  if (Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_entr_ccd2", "wins", 8) or 0 ~= 0) or skip then
    G.GAME.modifiers.ccd2 = true
  end
  if (Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_entr_doc", "wins", 8) or 0 ~= 0) or skip then
    G.GAME.modifiers.doc_antimatter = true
  end
  if (Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_entr_twisted", "wins", 8) or 0 ~= 0) or skip then
    G.GAME.modifiers.entr_twisted = true
  end
  if (Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_entr_butterfly", "wins", 8) or 0 ~= 0) or skip then
    G.GAME.modifiers.butterfly_antimatter = true
  end
end

local uibox_ref = create_UIBox_blind_select
function create_UIBox_blind_select()
    if G.GAME.USING_BREAK then
        G.E_MANAGER:add_event(Event({
			trigger = "after",
            blocking = false,
            delay = 3,
			func = function()
                G.STATE = 7
                --G.blind_select:remove()
                --G.blind_prompt_box:remove()
                G.FUNCS.draw_from_hand_to_deck()
				return true
			end,
		}))
        G.GAME.USING_BREAK = nil
    end
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
        if Entropy.CanEeSpawn() then
            if to_big(G.GAME.round_resets.ante) < to_big(32) then G.GAME.EEBeaten = false end
            if G.GAME.EEBuildup or (to_big(G.GAME.round_resets.ante) >= to_big(32) and not G.GAME.EEBeaten) then
                G.GAME.round_resets.blind_choices.Boss = "bl_entr_endless_entropy_phase_one"
                G.GAME.round_resets.blind_choices.Small = "bl_entr_void"
                G.GAME.round_resets.blind_choices.Big = "bl_entr_void"
                G.GAME.EEBuildup = true
                ease_background_colour{new_colour = HEX("5f5f5f"), contrast = 3}
            end
        end
        if G.GAME.modifiers.zenith then
            for i, v in pairs(G.GAME.round_resets.blind_choices) do
                G.GAME.round_resets.blind_choices[i] = "bl_entr_endless_entropy_phase_one"
            end
        end
        if G.GAME.curse == "entr_maze" and not G.GAME.entr_maze_applied then
            local choices = {}
            for i, v in pairs(G.GAME.round_resets.blind_choices) do
                choices[#choices+1] = v
            end
            pseudoshuffle(choices, pseudoseed("entr_maze"))
            G.GAME.round_resets.blind_choices.Small = choices[1]
            G.GAME.round_resets.blind_choices.Big = choices[2]
            G.GAME.round_resets.blind_choices.Boss = choices[3]
            G.GAME.entr_maze_applied = true
        end
        return uibox_ref()
    end
end

local set_textref = Blind.draw
function Blind:draw()
    if G.GAME.Interfered then
        G.GAME.blind.chip_text = G.GAME.InterferedText
    end
    set_textref(self)
end
local hand_dt = 0
local hand_dt2 = 0
local update_ref = Game.update
function Game:update(dt)
    update_ref(self, dt)
    hand_dt = (hand_dt or 0) + dt
    if G.hand_text_area and hand_dt > 0.05 and G.GAME.Interfered then
        G.TAROT_INTERRUPT_PULSE = true
        G.TAROT_INTERRUPT = true
        update_hand_text_random(
        { nopulse = true, immediate=true },
        { handname = Entropy.srandom(math.random(5,15)), mult = Entropy.srandom(3), chips = Entropy.srandom(3)}
        )
        G.TAROT_INTERRUPT_PULSE = false
        G.TAROT_INTERRUPT = false
        G.GAME.InterferedText = Entropy.srandom(math.random(3,5))
        hand_dt = 0
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

local evaluate_poker_hand_ref = evaluate_poker_hand
function evaluate_poker_hand(hand)
    local results = evaluate_poker_hand_ref(hand)
    for i, v in ipairs(G.handlist) do
        if G.GAME.Interfered then
            results[v] = results[pseudorandom_element(G.handlist, pseudoseed("interfered"))]
        end
    end
    return results
end

local update_round_evalref = Game.update_round_eval
function Game:update_round_eval(dt)
    update_round_evalref(self, dt)
    if G.GAME.Overflow then
        Entropy.ChangeFullCSL(-G.GAME.Overflow)
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
    if dt > 60 * 30 then
        Entropy.UpdateDailySeed()
    end
end

local create_cardref = create_card_for_shop
function create_card_for_shop(area)
    local card = create_cardref(area)
    if card and card.ability.set == "Joker" and next(SMODS.find_card("j_entr_ieros")) then
        for i, v2 in pairs(G.jokers.cards) do
            if v2.config.center.key == "j_entr_ieros" then
                while pseudorandom("ieros") < 0.33 do
                    local rare = nil
                    if card.config.center.rarity ~= "j_entr_entropic" then
                        rare = Entropy.GetNextRarity(card.config.center.rarity or 1) or card.config.center.rarity
                    end
                    local new_card = Entropy.GetRandomRarityCard(rare)
                    card:set_ability(G.P_CENTERS[new_card])
                end
            end
        end
    end 
    return card
end


local gba = get_blind_amount
function get_blind_amount(ante)
    if not ante then return 0 end
    local actual = to_big(ante) <= to_big(8) and to_number(ante) or to_big(ante)
    if to_big(math.abs(ante - math.floor(ante))) > to_big(0.01) then

        local p = (ante - math.floor(ante))
        return get_blind_amount(math.floor(ante) + (to_big(ante) < to_big(0) and -1 or 0))*(1-p) + get_blind_amount(math.floor(ante)+1 + (to_big(ante) < to_big(0) and -1 or 0))*p
    end
    if to_big(ante) < to_big(0) then
        return 100 * (0.95^(-ante))
    end
    if (Entropy.config.ante_scaling and to_big(ante) > to_big(8) and #Cryptid.advanced_find_joker(nil, "entr_entropic", nil, nil, true) ~= 0) or G.GAME.modifiers.entropic then
        return to_big(gba(to_number(actual))):tetrate(1 + ante/32)
    end
    return gba(to_number(actual)) or 100
end
function lerp(f1,f2,p)
    p = p * p
    return f1 * (1-p) + f2*p
end

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

local htuis = G.FUNCS.hand_text_UI_set
G.FUNCS.hand_text_UI_set = function(e)
    htuis(e)
    if G.GAME.cry_exploit_override then
        e.config.object.colours = { G.C.SET.Command }
    else
        e.config.object.colours = { G.C.UI.TEXT_LIGHT }
    end
    e.config.object:update_text()
end

local add_tagref = add_tag
function add_tag(_tag, ...)
    if type(_tag) == "table" then
        if not _tag.ability.added_to_deck then
            for i, v in pairs(SMODS.get_card_areas('jokers')) do
                for a, card in pairs(v.cards) do
                    local res = card:calculate_joker({tag_create = true, tag = _tag})
                    if res and res.tag then
                        _tag = res.tag
                    end
                end
            end
        end
        add_tagref(_tag, ...)
        _tag.ability.added_to_deck = true
        if not G.GAME.autostart_tags then G.GAME.autostart_tags = {} end
    else    
        add_tagref(_tag, ...)
    end
    G.GAME.last_tag = _tag.key
end

local disable_ref = Blind.disable
function Blind:disable()
	if not self.config.blind.no_disable then disable_ref(self) end
end

--for wiki editors these arent 4 seperate blinds but 4 phases of endless entropy

local ref = G.FUNCS.reroll_boss
G.FUNCS.reroll_boss = function(e) 
	if G.GAME.EEBuildup then return end
	ref(e)
end

local upd = Game.update
local ee2dt = 0
local cdt = 0
function Game:update(dt)
	upd(self, dt)
	cdt = cdt + dt
	if cdt > 0.01 then
		if G.jokers and G.GAME.blind and G.GAME.blind.config.blind.key == "bl_entr_endless_entropy_phase_three" then
			G.HUD_blind:get_UIE_by_ID("score_at_least").config.text = localize("ph_blind_score_less_than")
			for i, v in pairs(G.jokers.cards) do
				v:set_debuff(false)
			end
            for i = 1, math.ceil(math.max(G.jokers.config.card_limit, #G.jokers.cards)/5) do
                if G.jokers.cards[i] then
                    G.jokers.cards[i].debuff = true
                end
            end
        end
        if G.jokers and G.GAME.blind and (G.GAME.blind.config.blind.key == "bl_entr_endless_entropy_phase_two" or G.GAME.blind.config.blind.key == "bl_entr_endless_entropy_phase_four") then
            G.HUD_blind:get_UIE_by_ID("score_at_least").config.text = localize("ph_blind_score_at_least")
        end
		cdt = 0
	end
end

local orig = create_UIBox_blind_popup
function create_UIBox_blind_popup(blind, discovered, vars)
	local blind_text = {}
	
	local _dollars = blind.dollars
	local target = {type = 'raw_descriptions', key = blind.key, set = 'Blind', vars = vars or blind.vars}
	if blind.collection_loc_vars and type(blind.collection_loc_vars) == 'function' then
		local res = blind:collection_loc_vars() or {}
		target.vars = res.vars or target.vars
		target.key = res.key or target.key
	end
	local loc_target = localize(target)
	local loc_name = localize{type = 'name_text', key = blind.key, set = 'Blind'}
  
	if discovered then 
	  local ability_text = {}
	  if loc_target then 
		for k, v in ipairs(loc_target) do
		  ability_text[#ability_text + 1] = {n=G.UIT.R, config={align = "cm"}, nodes={{n=G.UIT.T, config={text = v, scale = 0.35, shadow = true, colour = G.C.WHITE}}}}
		end
	  end
	  local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.4)
	  if blind.exponent then
		  local exponents = ""
		  local exponents2 = ""
		  for i = 1, blind.exponent[1] do
			exponents = exponents .. "^"
		  end
		  if blind.exponent[1] > 5 then
			exponents = ""
			exponents2 = "{" .. blind.exponent[1] .. "}"
		  end
		  blind_text[#blind_text + 1] =
			{n=G.UIT.R, config={align = "cm", emboss = 0.05, r = 0.1, minw = 2.5, padding = 0.07, colour = G.C.WHITE}, nodes={
			  {n=G.UIT.R, config={align = "cm", maxw = 2.4}, nodes={
				{n=G.UIT.T, config={text = localize('ph_blind_score_at_least'), scale = 0.35, colour = G.C.UI.TEXT_DARK}},
			  }},
			  {n=G.UIT.R, config={align = "cm"}, nodes={
				{n=G.UIT.O, config={object = stake_sprite}},
				{n=G.UIT.T, config={text = exponents .. blind.exponent[2].. exponents2 .." "..localize('k_entr_base'), scale = 0.4, colour = G.C.RED}},
			  }},
			  {n=G.UIT.R, config={align = "cm"}, nodes={
				{n=G.UIT.T, config={text = localize('ph_blind_reward'), scale = 0.35, colour = G.C.UI.TEXT_DARK}},
				{n=G.UIT.O, config={object = DynaText({string = {_dollars and string.rep(localize('$'),_dollars) or '-'}, colours = {G.C.MONEY}, rotate = true, bump = true, silent = true, scale = 0.45})}},
			  }},
			  ability_text[1] and {n=G.UIT.R, config={align = "cm", padding = 0.08, colour = mix_colours(blind.boss_colour, G.C.GREY, 0.4), r = 0.1, emboss = 0.05, minw = 2.5, minh = 0.9}, nodes=ability_text} or nil
			}}
	  else
            blind_text[#blind_text + 1] =
                {n=G.UIT.R, config={align = "cm", emboss = 0.05, r = 0.1, minw = 2.5, padding = 0.07, colour = G.C.WHITE}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 2.4}, nodes={
                    {n=G.UIT.T, config={text = localize(blind.key == "bl_entr_endless_entropy_phase_three" and 'ph_blind_score_less_than' or 'ph_blind_score_at_least'), scale = 0.35, colour = G.C.UI.TEXT_DARK}},
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.O, config={object = stake_sprite}},
                    {n=G.UIT.T, config={text = blind.mult..localize('k_x_base'), scale = 0.4, colour = G.C.RED}},
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.T, config={text = localize('ph_blind_reward'), scale = 0.35, colour = G.C.UI.TEXT_DARK}},
                    {n=G.UIT.O, config={object = DynaText({string = {_dollars and string.rep(localize('$'),_dollars) or '-'}, colours = {G.C.MONEY}, rotate = true, bump = true, silent = true, scale = 0.45})}},
                }},
                ability_text[1] and {n=G.UIT.R, config={align = "cm", padding = 0.08, colour = mix_colours(blind.boss_colour, G.C.GREY, 0.4), r = 0.1, emboss = 0.05, minw = 2.5, minh = 0.9}, nodes=ability_text} or nil
            }}
		end
	else
	  blind_text[#blind_text + 1] =
		{n=G.UIT.R, config={align = "cm", emboss = 0.05, r = 0.1, minw = 2.5, padding = 0.1, colour = G.C.WHITE}, nodes={
		  {n=G.UIT.R, config={align = "cm"}, nodes={
			{n=G.UIT.T, config={text = localize('ph_defeat_this_blind_1'), scale = 0.4, colour = G.C.UI.TEXT_DARK}},
		  }},
		  {n=G.UIT.R, config={align = "cm"}, nodes={
			{n=G.UIT.T, config={text = localize('ph_defeat_this_blind_2'), scale = 0.4, colour = G.C.UI.TEXT_DARK}},
		  }},
		}}
		return orig(blind, discovered, vars)
	end
   return orig(blind, discovered, vars)
end 

local dft = Blind.defeat
function Blind:defeat(s)
    if not self.config.blind.key then self.config.blind.key = "bl_small" end
    dft(self, s)
end

local ref = update_hand_text

function update_hand_text(config, vals)
    if not G.GAME.current_round.current_hand.cry_asc_num_text then G.GAME.current_round.current_hand.cry_asc_num_text = '' end
    if (type(vals.mult) == "number" or type(vals.mult) == "table") and next(SMODS.find_card("j_entr_tesseract")) and math.abs(to_big(vals.mult)) > to_big(0.001) then
        local total_angle = 0
        for i, v in pairs(G.jokers.cards) do
            if v.config.center.key == "j_entr_tesseract" then
                total_angle = total_angle + v.ability.degrees
            end
        end
        total_angle = (total_angle/360)*2*3.141592
        local base = {r=math.cos(total_angle),c=math.sin(total_angle)}
        local str = Entropy.WhatTheFuck(base, vals.mult)
        vals.mult = str
    end
    if (type(vals.chips) == "number" or type(vals.chips) == "table") and next(SMODS.find_card("j_entr_tesseract")) and math.abs(to_big(vals.chips)) > to_big(0.001) then
        local total_angle = 0
        for i, v in pairs(G.jokers.cards) do
            if v.config.center.key == "j_entr_tesseract" then
                total_angle = total_angle + v.ability.degrees
            end
        end
        total_angle = -(total_angle/360)*2*3.14159265
        local base = {r=math.cos(total_angle),c=math.sin(total_angle)}
        local str = Entropy.WhatTheFuck(base, vals.chips)
        vals.chips = str
    end
    ref(config, vals)
end
function Entropy.GetRecipeResult(val,jokerrares,seed)
    local rare = 1
    local cost=0
    for i, v in pairs({
        [1]=0,
        [2]=6,
        [3]=12,
        cry_epic=(SMODS.Mods["Cryptid"] or {}).can_load and 20 or nil,
        [4]=30,
        cry_exotic=(SMODS.Mods["Cryptid"] or {}).can_load and 45 or nil,
        entr_entropic = (SMODS.Mods["Cryptid"] or {}).can_load and 70 or nil,
    }) do
        if v >= cost and val >= v then
            rare = i;cost=v
        end
    end
    return pseudorandom_element(jokerrares[rare] or {}, pseudoseed(seed)) or "j_joker"
end
function Entropy.ConcatStrings(tbl)
    local result = ""
    for i, v in pairs(tbl) do result = result..v end
    return result
end



function Entropy.GetRecipe(cards)
    if #cards == 5 then
        local enhancements = Entropy.EnhancementPoints
        local rares = {}
        for i, v in pairs(G.P_CENTER_POOLS.Joker) do
            if not rares[v.rarity] then rares[v.rarity] = {} end
            rares[v.rarity][#rares[v.rarity]+1] = v.key
        end
        local enh = {}
        for i = 1, 5 do
            local card = cards[i]
            if card then
                enh[#enh+1]=card.config.center.key
            end
        end
        local sum = 0
        for i, v in pairs(enh) do
            if not enhancements[v] then
                enhancements[v] = 4.5 + math.random()*0.1-0.05
            end
            sum = sum + (enhancements[v] or 4.5) 
        end
        table.sort(enh, function(a,b)return (enhancements[a])>(enhancements[b]) end)
        G.GAME.JokerRecipes = G.GAME.JokerRecipes or {}
        if not G.GAME.JokerRecipes[Entropy.ConcatStrings(enh)] then
            G.GAME.JokerRecipes[Entropy.ConcatStrings(enh)]=Entropy.GetRecipeResult(sum, rares,Entropy.ConcatStrings(enh))
        end
        return Entropy.FixedRecipes[Entropy.ConcatStrings(enh)] or G.GAME.JokerRecipes[Entropy.ConcatStrings(enh)]
    end
    return "j_joker"
end

Entropy.DiscardSpecific = function(cards)
    for i, v in pairs(cards) do
        draw_card(G.hand, G.discard, i*100/#cards, 'down', false, v)
    end
end 

local card_addref = Card.add_to_deck
function Card:add_to_deck(...)
    card_addref(self, ...)
    if self.ability.set == "Joker" or self.ability.consumeable and self.config.center.key ~= "c_entr_detour" then
        G.GAME.detour_set = self.ability.set
    end
    if self:is_sunny() and self.area == G.jokers then 
        check_for_unlock({ type = "sunny_joker" })
    end
end

local card_redeem = Card.redeem
function Card:redeem(...)
    card_redeem(self, ...)
    G.GAME.detour_set = self.ability.set
end

local card_open = Card.open
function Card:open(...)
    card_open(self, ...)
    G.GAME.detour_set = self.ability.set
    if Entropy.has_rune("rune_entr_naudiz") then
        calculate_runes({
            buying_card = true,
            card = self
        })
    end
end

function Card:calculate_banana()
	if not self.ability.extinct then
		if self.ability.banana and (pseudorandom("banana") < G.GAME.probabilities.normal / 10) and not self.ability.cry_absolute then
			self.ability.extinct = true
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					self.T.r = -0.2
					self:juice_up(0.3, 0.4)
					self.states.drag.is = true
					self.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							if self.area then
								self.area:remove_card(self)
							end
							self:remove()
							self = nil
							return true
						end,
					}))
					return true
				end,
			}))
			card_eval_status_text(self, "jokers", nil, nil, nil, { message = localize("k_extinct_ex"), delay = 0.1 })
			return true
		elseif self.ability.banana then
			card_eval_status_text(self, "jokers", nil, nil, nil, { message = localize("k_safe_ex"), delay = 0.1 })
			return false
		end
	end
	return false
end

local get_bossref = get_new_boss
function get_new_boss()
    if (G.GAME.EEBuildup or (to_big(G.GAME.round_resets.ante) >= to_big(32) and not G.GAME.EEBeaten) or G.GAME.modifiers.zenith) and Entropy.CanEeSpawn() then
        return "bl_entr_endless_entropy_phase_one"
    end
    if G.GAME.entr_alt then
        G.GAME.perscribed_bosses = G.GAME.perscribed_bosses or {
        }
        if G.GAME.perscribed_bosses and G.GAME.perscribed_bosses[G.GAME.round_resets.ante] then 
            local ret_boss = G.GAME.perscribed_bosses[G.GAME.round_resets.ante] 
            G.GAME.perscribed_bosses[G.GAME.round_resets.ante] = nil
            G.GAME.bosses_used[ret_boss] = G.GAME.bosses_used[ret_boss] + 1
            return ret_boss
        end
        if G.FORCE_BOSS then return G.FORCE_BOSS end
        
        local eligible_bosses = {}
        for k, v in pairs(Entropy.AltBlinds) do
            if not v.boss then
    
            elseif v.in_pool and type(v.in_pool) == 'function' then
                local res, options = v:in_pool({})
                if
                    (
                        ((G.GAME.round_resets.ante)%G.GAME.win_ante == 0 and G.GAME.round_resets.ante >= 2) ==
                        (v.boss.showdown or false)
                    ) or
                    (options or {}).ignore_showdown_check
                then
                    eligible_bosses[v.key] = res and true or nil
                end
            elseif not v.boss.showdown and (v.boss.min <= math.max(1, G.GAME.round_resets.ante) and ((math.max(1, G.GAME.round_resets.ante))%G.GAME.win_ante ~= 0 or G.GAME.round_resets.ante < 2)) then
                eligible_bosses[v.key] = true
            elseif v.boss.showdown and (((G.GAME.round_resets.ante)%G.GAME.win_ante == 0 and G.GAME.round_resets.ante >= 2) or G.GAME.modifiers.cry_big_showdown ) then
                eligible_bosses[v.key] = true
            end
        end
        for k, v in pairs(G.GAME.banned_keys) do
            if eligible_bosses[k] then eligible_bosses[k] = nil end
        end
    
        -- local min_use = 100
        -- for k, v in pairs(G.GAME.bosses_used) do
        --     if eligible_bosses[k] then
        --         eligible_bosses[k] = v
        --         if eligible_bosses[k] <= min_use then 
        --             --min_use = eligible_bosses[k]
        --         end
        --     end
        -- end
        -- for k, v in pairs(eligible_bosses) do
        --     if eligible_bosses[k] then
        --         if eligible_bosses[k] > min_use then 
        --             eligible_bosses[k] = nil
        --         end
        --     end
        -- end
        local boss = nil
        if MP and MP.INTEGRATIONS and MP.INTEGRATIONS.TheOrder then
            _, boss = pseudorandom_element(eligible_bosses, pseudoseed('boss'..G.GAME.round_resets.ante))
        else
            _, boss = pseudorandom_element(eligible_bosses, pseudoseed('boss'))
        end
        if not boss or Cryptid.enabled("set_entr_altpath") ~= true then return get_bossref() end
        G.GAME.bosses_used[boss] = (G.GAME.bosses_used[boss] or 0) + 1
        return boss
    end
    return get_bossref()
end

local change_suitref = Card.change_suit 
function Card:change_suit(new_suit)
    change_suitref(self, new_suit)
    if not G.GAME.SuitBuffs then G.GAME.SuitBuffs = {} end
    if G.GAME.SuitBuffs[new_suit] then
        self.ability.bonus = (self.ability.bonus or 0) + (G.GAME.SuitBuffs[new_suit] and G.GAME.SuitBuffs[new_suit].chips or 0) - (self.ability.bonus_from_suit or 0)
        self.ability.bonus_from_suit = G.GAME.SuitBuffs[new_suit] and G.GAME.SuitBuffs[new_suit].chips or 0
    end
end

local debuff_handref = Blind.debuff_hand
function Blind:debuff_hand(cards, hand, handname, check)
    if G.GAME.badarg and G.GAME.badarg[handname] then 
        return true
    else
        return debuff_handref(self, cards, hand, handname, check)
    end
end

if Entropy.config.omega_aleph then
    local card_removeref = Card.remove
    function Card:remove(...)
        local areas = {
            
        }
        if G.SETTINGS.paused or not self.entr_aleph or self.ability.bypass_aleph or self.bypass_selfdestruct or self.children.price or self.base.suit then
            return card_removeref(self, ...)
        else
            if self.entr_aleph then
                local card2 = copy_card(self)
                card2:add_to_deck()
                if self.area then 
                    local ind = #self.area.cards
                    for i, v in ipairs(self.area.cards) do
                        if v == self then ind = i end
                    end
                    self.area.cards[ind] = card2
                    card2.area = self.area
                end
                local ref = card_removeref(self, ...)
                self = nil

                if card2.ability.name == "Popcorn" then
                    card2.ability.mult = card2.ability.mult - card2.ability.extra
                end

                if card2.ability.name == "Turtle Bean" then
                    card2.ability.extra.h_size = card2.ability.extra.h_size - card2.ability.extra.h_mod
                end
                if card2.ability.name == "Ramen" then
                    card2.ability.x_mult = card2.ability.x_mult - card2.ability.extra
                end
                if card2.ability.name == "Seltzer" then
                    card2.ability.extra = card2.ability.extra - 1
                end
                if card2.ability.name == "Ice Cream" then
                    card2.ability.extra.chips = card2.ability.extra.chips - card2.ability.extra.chip_mod
                end
                return ref
            end
        end
    end

    local cardarea_removeref = CardArea.remove_card
    function CardArea:remove_card(card, ...)
        if not card or not card.entr_aleph or G.SETTINGS.paused or card.ability.bypass_aleph or card.bypass_selfdestruct or card.children.price or card.base.suit then
            return cardarea_removeref(self, card, ...)
        end
    end

    local keyef = Controller.key_press_update
    function Controller:key_press_update(key, dt)
        if not _RELEASE_MODE and key == "r" then
            if self.hovering.target and self.hovering.target.ability then self.hovering.target.ability.bypass_aleph = true end
        end
        keyef(self, key, dt)
    end
end
local add_ref = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    if card and not card.set_card_area then
        card.set_card_area = function(card, self)
            card.area = self
        end
    end
    if self == G.hand or self == G.deck then
        if not card.base.suit or not card.base.id then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.change_base(card, card.base.suit or "entr_nilsuit", card.base.value or "entr_nilrank")
                    return true
                end
            }))
        end
    end
    if card and card.area and (card.area.config.type == "shop" or card.base.suit) then
        card.bypass_selfdestruct = true
    end
    if card then add_ref(self, card, location, stay_flipped) end
    if self == G.consumeables then
        calculate_runes({consumable_emplaced = true, consumeable=card})
    end
    if card.ability.glitched_crown and self.config.type ~= "shop" then
        card:set_ability(G.P_CENTERS[card.ability.glitched_crown[card.glitched_index]])
        card.ability.glitched_crown = nil
    end
end

local end_roundref = end_round
function end_round()
    if Entropy.IsEE() and not (G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind.key == "bl_entr_endless_entropy_phase_four") then
		if (G.GAME.blind and G.GAME.blind.config and ((G.GAME.blind.config.blind.key == "bl_entr_endless_entropy_phase_three" and to_big(G.GAME.chips) < to_big(G.GAME.blind.chips)) or (G.GAME.blind.config.blind.key ~= "bl_entr_endless_entropy_phase_three" and to_big(G.GAME.chips) >= to_big(G.GAME.blind.chips)))) then
			G.GAME.chips = 0
			G.GAME.round_resets.lost = true
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.blind:set_blind(G.P_BLINDS[G.GAME.blind.config.blind.next_phase])
					Entropy.ChangePhase()
					G.GAME.blind:juice_up()
					ease_hands_played(G.GAME.round_resets.hands-G.GAME.current_round.hands_left)
					ease_discard(
						math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards) - G.GAME.current_round.discards_left
					)
					G.FUNCS.draw_from_discard_to_deck()
					return true
				end
			}))
		else
            end_roundref()
        end
    else    
        end_roundref()
    end
    if G.GAME.candle_hand_size then 
        Entropy.handle_card_limit(G.hand, -G.GAME.candle_hand_size)
        G.GAME.candle_hand_size = nil
    end
    if G.GAME.vanish_selection_limit then
        Entropy.ChangeFullCSL(-G.GAME.vanish_selection_limit)
        G.GAME.vanish_selection_limit = nil
    end
end

local generate_uiref = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    if card_type == "Back" then 
        if card.config and card.config.center and card.config.center.collection_loc_vars then
            specific_vars = (card.config.center:collection_loc_vars({}, card) or {}).vars
        elseif card.config and card.config.center and card.config.center.loc_vars then
            specific_vars = (card.config.center:loc_vars({}, card) or {}).vars
        elseif card.config and card.config.center then
            local loc_args = {}
            local effect_config = card.config.center.config
            local name_to_check = card.config.center.name
            if name_to_check == 'Blue Deck' then loc_args = {effect_config.hands}
            elseif name_to_check == 'Red Deck' then loc_args = {effect_config.discards}
            elseif name_to_check == 'Yellow Deck' then loc_args = {effect_config.dollars}
            elseif name_to_check == 'Green Deck' then loc_args = {effect_config.extra_hand_bonus, effect_config.extra_discard_bonus}
            elseif name_to_check == 'Black Deck' then loc_args = {effect_config.joker_slot, -effect_config.hands}
            elseif name_to_check == 'Magic Deck' then loc_args = {localize{type = 'name_text', key = 'v_crystal_ball', set = 'Voucher'}, localize{type = 'name_text', key = 'c_fool', set = 'Tarot'}}
            elseif name_to_check == 'Nebula Deck' then loc_args = {localize{type = 'name_text', key = 'v_telescope', set = 'Voucher'}, -1}
            elseif name_to_check == 'Ghost Deck' then
            elseif name_to_check == 'Abandoned Deck' then 
            elseif name_to_check == 'Checkered Deck' then
            elseif name_to_check == 'Zodiac Deck' then loc_args = {localize{type = 'name_text', key = 'v_tarot_merchant', set = 'Voucher'}, 
                                localize{type = 'name_text', key = 'v_planet_merchant', set = 'Voucher'},
                                localize{type = 'name_text', key = 'v_overstock_norm', set = 'Voucher'}}
            elseif name_to_check == 'Painted Deck' then loc_args = {effect_config.hand_size,effect_config.joker_slot}
            elseif name_to_check == 'Anaglyph Deck' then loc_args = {localize{type = 'name_text', key = 'tag_double', set = 'Tag'}}
            elseif name_to_check == 'Plasma Deck' then loc_args = {effect_config.ante_scaling}
            elseif name_to_check == 'Erratic Deck' then
            end
            specific_vars = loc_args
        end
    end
    return generate_uiref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
end

function G.UIDEF.usage_tabs()
    return create_UIBox_generic_options({back_func = 'high_scores', contents ={create_tabs(
      {tabs = {
          {
            label = localize('b_stat_jokers'),
            chosen = true,
            tab_definition_function = create_UIBox_usage,
            tab_definition_function_args = {'joker_usage'},
          },
          {
            label = localize('b_stat_consumables'),
            tab_definition_function = create_UIBox_usage,
            tab_definition_function_args = {'consumeable_usage'},
          },
          {
            label = localize('b_stat_tarots'),
            tab_definition_function = create_UIBox_usage,
            tab_definition_function_args = {'consumeable_usage', 'Tarot'},
          },
          {
            label = localize('b_stat_planets'),
            tab_definition_function = create_UIBox_usage,
            tab_definition_function_args = {'consumeable_usage', 'Planet'},
          },
          {
            label = localize('b_stat_spectrals'),
            tab_definition_function = create_UIBox_usage,
            tab_definition_function_args = {'consumeable_usage', 'Spectral'},
          },
          {
            label = localize('b_stat_vouchers'),
            tab_definition_function = create_UIBox_usage,
            tab_definition_function_args = {'voucher_usage', 'Voucher'},
          },
      },
      tab_h = 8,
      snap_to_nav = true}),
      UIBox_button({
        button = "usage_plus",
        label = { ">" },
      })}})
  end

function create_usage_tabspage(args)
    local old = G.USAGE_PAGE
    local page = args
    local per_page = 6
    local types = {}
    local blacklist = {
        Unique = true,
        Food = true,
        Meme = true,
        Tier3 = true,
        M = true
    }
    for i, v in ipairs(SMODS.ConsumableType.obj_buffer) do
        if SMODS.ConsumableType.obj_table[v].original_mod and not blacklist[v] then types[#types+1] = v end
    end
    G.USAGE_PAGE = page
    if not types[1+(page*per_page)] then
        G.USAGE_PAGE = old
        page = old
    end
    local options = {
    }
    for i = 1+(page*per_page), math.min(math.max(1+(page*per_page)+per_page, #types-1), per_page) do
        local key = types[i]
        if key then
            options[#options+1] = {
                label = localize("b_stat_"..(key or "")) == "ERROR" and key or localize("b_stat_"..(key or "")),
                tab_definition_function = create_UIBox_usage,
                tab_definition_function_args = {'consumeable_usage', key},
                chosen = i == 1+(page*per_page),
            }
        end
    end
    return create_UIBox_generic_options({back_func = 'high_scores', contents ={create_tabs(
      {tabs = options,
      tab_h = 8,
      snap_to_nav = true}),  
      {n=G.UIT.R, config={minw = 5, align='cm', padding = 0.1}, nodes = {    
      UIBox_button({
        button = "usage_minus",
        label = { "<" },
        col = true
      }),
      ((G.USAGE_PAGE or -1) + 1) < (math.ceil(#types/per_page) - 1) and UIBox_button({
        button = "usage_plus",
        label = { ">" },
        align = 'cl',
        col=true
      }) or nil
    }}}})
end

G.FUNCS.usage_plus = function(e)
    G.SETTINGS.paused = true
    if G.OVERLAY_MENU then G.OVERLAY_MENU:remove(); G.OVERLAY_MENU = nil end
    G.FUNCS.overlay_menu{
      definition = create_usage_tabspage((G.USAGE_PAGE or -1)+1)
    }
end
G.FUNCS.usage_minus = function(e)
    G.SETTINGS.paused = true
    if G.OVERLAY_MENU then G.OVERLAY_MENU:remove(); G.OVERLAY_MENU = nil end
    if (G.USAGE_PAGE or 0)-1 < 0 then
        G.USAGE_PAGE = nil
    end
    G.FUNCS.overlay_menu{
      definition = (G.USAGE_PAGE or 0)-1 < 0 and G.UIDEF.usage_tabs() or create_usage_tabspage((G.USAGE_PAGE or 0)-1)
    }
end



local ref = G.UIDEF.run_setup
function G.UIDEF.run_setup(from_game_over)
    Entropy.UpdateDailySeed()
    return ref(from_game_over)
end

local draw_ref = G.FUNCS.draw_from_deck_to_hand
G.FUNCS.draw_from_deck_to_hand = function(e)
    e = e or G.hand.config.card_limit - #G.hand.cards
    if Entropy.BlindIs("bl_entr_pandora") then
        local am = 0
        for i = 1, e do
            if pseudorandom("bl_entr_pandora") < 0.33 then
                am = am + 1
            end
        end
        local actual = e - am
        e = am
        if actual > 0 then
            for i = 1, actual do
                local card = SMODS.create_card{
                    key = SMODS.poll_enhancement({guaranteed = true, key = "entr_pandora"}),
                    set = "Enhanced",
                    area = G.hand
                  }
                Entropy.randomize_rank_suit(card, true, true, "pandora")
                card.ability.temporary = true
                G.hand:emplace(card)
            end
        end
    end
    draw_ref(e)
end

local evaluate_ref = evaluate_poker_hand
function evaluate_poker_hand(hand)
    local results = evaluate_ref(hand)
    for i, v in pairs(results) do
        if G.GAME.atomikos_deleted and G.GAME.atomikos_deleted[i] then results[i] = {} end
        if G.GAME.SudoHand and G.GAME.SudoHand[i] and #results[i] > 0 and Entropy.no_recurse_scoring(results) == i then results[G.GAME.SudoHand[i]] = results[i] end
    end
    return results
end

local ref = create_shop_card_ui
function create_shop_card_ui(card, type, area)
    if card.config.center.set == "Back" or card.config.center.set == "Sleeve" then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.43,
            blocking = false,
            blockable = false,
            func = (function()
              if card.opening then return true end
              local t1 = {
                  n=G.UIT.ROOT, config = {minw = 0.6, align = 'tm', colour = darken(G.C.BLACK, 0.2), shadow = true, r = 0.05, padding = 0.05, minh = 1}, nodes={
                      {n=G.UIT.R, config={align = "cm", colour = lighten(G.C.BLACK, 0.1), r = 0.1, minw = 1, minh = 0.55, emboss = 0.05, padding = 0.03}, nodes={
                        {n=G.UIT.O, config={object = DynaText({string = {{prefix = localize('$'), ref_table = card, ref_value = 'cost'}}, colours = {G.C.MONEY},shadow = true, silent = true, bump = true, pop_in = 0, scale = 0.5})}},
                      }}
                  }}
              local t2 = {
                n=G.UIT.ROOT, config = {ref_table = card, minw = 1.1, maxw = 1.3, padding = 0.1, align = 'bm', colour = G.C.GOLD, shadow = true, r = 0.08, minh = 0.94, func = 'can_buy_deckorsleeve_from_shop', one_press = true, button = 'buy_deckorsleeve', hover = true}, nodes={
                    {n=G.UIT.T, config={text = localize('b_redeem'),colour = G.C.WHITE, scale = 0.5}}
                }}

              card.children.price = UIBox{
                definition = t1,
                config = {
                  align="tm",
                  offset = {x=0,y=1.5},
                  major = card,
                  bond = 'Weak',
                  parent = card
                }
              }
    
              card.children.buy_button = UIBox{
                definition = t2,
                config = {
                  align="bm",
                  offset = {x=0,y=-0.3},
                  major = card,
                  bond = 'Weak',
                  parent = card
                }
              }
              card.children.price.alignment.offset.y = card.ability.set == 'Booster' and 0.5 or 0.38
    
                return true
            end)
          }))
    else
        ref(card, type, area)
    end
end

if SMODS.Mods.Multipack and SMODS.Mods.Multipack.can_load then
    SMODS.Booster:take_ownership("p_mupack_favoritepack", {
        create_card = function(self, card, i)
            local used_cards = {}
            local max_amt = 0
            for k, v in pairs(G.PROFILES[G.SETTINGS.profile]['joker_usage']) do
                if G.P_CENTERS[k] and G.P_CENTERS[k].discovered and not G.P_CENTERS[k].no_doe and not G.P_CENTERS[k].no_collection then
                used_cards[#used_cards + 1] = {count = v.count, key = k}
                if v.count > max_amt then max_amt = v.count end
                end
            end
    
            table.sort(used_cards, function (a, b) return a.count > b.count end )
            
            local _card
            local v = used_cards[i]
                if v then 
                    _card = {set = "Joker", area = G.pack_cards, skip_materialize = true, soulable = false, key = v.key, key_append = "fav1"}
                else
                    _card = {set = "Joker", area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "fav2"}
                end
            return _card
        end,
    }, true)
end

local card_flipref = Card.flip_side
function Card:flip_side(...)
    local mod = G.GAME.modifiers.entr_twisted
    G.GAME.modifiers.entr_twisted = nil
    card_flipref(self, ...)
    G.GAME.modifiers.entr_twisted = mod
end

local exit_ref = G.FUNCS.exit_overlay_menu_code
function G.FUNCS.exit_overlay_menu_code()
    exit_ref()
    G.GAME.USING_INHERIT = nil
    G.GAME.USING_SUDO = nil
    G.GAME.USING_DEFINE = nil
end

local htref = create_UIBox_hand_tip
function create_UIBox_hand_tip(handname)
	if G.GAME.USING_SUDO then
		G.GAME.USING_SUDO_HAND = handname
	end
	return htref(handname)
end

local lcpref = Controller.L_cursor_press
function Controller:L_cursor_press(x, y)
	lcpref(self, x, y)
	if G and G.GAME and G.GAME.hands and G.GAME.USING_SUDO_HAND then
		if G.CONTROLLER.cursor_hover and G.CONTROLLER.cursor_hover.target and G.CONTROLLER.cursor_hover.target.config and
		G.CONTROLLER.cursor_hover.target.config.on_demand_tooltip and G.CONTROLLER.cursor_hover.target.config.on_demand_tooltip.filler and 
		G.CONTROLLER.cursor_hover.target.config.on_demand_tooltip.filler.args and G.GAME.hands[G.CONTROLLER.cursor_hover.target.config.on_demand_tooltip.filler.args] then
			if G.GAME.CODE_DESTROY_CARD then
				G.GAME.CODE_DESTROY_CARD:start_dissolve()
				G.GAME.CODE_DESTROY_CARD = nil
			end
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            if not G.GAME.SudoHand then G.GAME.SudoHand = {} end
            G.GAME.SudoHand[text] = G.GAME.USING_SUDO_HAND
			G.FUNCS.exit_overlay_menu_code()
		end
	end
end


local visible_ref = SMODS.is_poker_hand_visible
function SMODS.is_poker_hand_visible(handname)
    if G.GAME.atomikos_deleted and G.GAME.atomikos_deleted[handname] then return end
    return visible_ref(handname)
end

local evaluate_poker_hand_ref = evaluate_poker_hand
function evaluate_poker_hand(cards)
    local results = evaluate_poker_hand_ref(cards)
    local top
    if G.GAME.overload then
        for i, v in pairs(G.handlist) do
            if not top and results[v] and results[v][1] then
                top = {results[v][1]}
                top.text = v
                break
            end
        end
        for i, v in pairs(G.handlist) do
            if top then
                results[v][1] = top[1]
            end
        end
    end
    if G.GAME.randomised_hand_map then
        local results_copy = {}
        for i, v in pairs(results) do
            results_copy[i] = v
        end
        for i, v in pairs(G.GAME.randomised_hand_map) do
            results[i] = results_copy[v]
        end
    end
    results.top = top
    return results
end

local parse_ref = CardArea.parse_highlighted
function CardArea:parse_highlighted()
    G.GAME.asc_power_hand = 0
    parse_ref(self)
    local text,disp_text,poker_hands = G.FUNCS.get_poker_hand_info(self.highlighted)
    if G.GAME.hands[text] and G.GAME.hands[text].operator then
        if not G.GAME.old_operator then G.GAME.old_operator = G.GAME.current_scoring_calculation_key or "multiply" end
        SMODS.set_scoring_calculation(G.GAME.hands[text].operator)
    elseif G.GAME.old_operator then
        SMODS.set_scoring_calculation(G.GAME.old_operator)
        G.GAME.old_operator = nil
    else
        SMODS.set_scoring_calculation("multiply")
    end
end

local set_scoring_calculation_funcref = G.FUNCS.SMODS_scoring_calculation_function
G.FUNCS.SMODS_scoring_calculation_function = function(e)
    if e then set_scoring_calculation_funcref(e) end
end

local ref = SMODS.set_scoring_calculation
function SMODS.set_scoring_calculation(key, ...)
    G.GAME.current_scoring_calculation_key = key
    if ref then
        return ref(key, ...)
    end
end

local play_ref = G.FUNCS.evaluate_play
G.FUNCS.evaluate_play = function(e)
    local old_op = G.GAME.old_operator
    play_ref(e)
    G.GAME.old_op = old_op
    G.E_MANAGER:add_event(Event{
        func = function()
            if G.GAME.old_operator then
                SMODS.set_scoring_calculation(G.GAME.old_operator)
                G.GAME.old_operator = nil
            end
            return true
        end,
        trigger = "after"
    })
    G.GAME.overload = nil
    G.E_MANAGER:add_event(Event{
        trigger = "after",
        func = function()
            if G.C.UI_CHIPS[1] == G.C.GOLD[1] then
                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.3)
                ease_colour(G.C.UI_MULT, G.C.RED, 0.3)
            end
            G.GAME.current_round.current_hand.cry_asc_num = 0
            G.GAME.current_round.current_hand.cry_asc_num_text = ""
            return true
        end
    })
end

function Entropy.GetDummy(center, area, self)
    local abil = copy_table(center.config) or {}
    abil.consumeable = copy_table(abil)
    abil.name = center.name or center.key
    abil.set = center.set
    abil.t_mult = abil.t_mult or 0
    abil.t_chips = abil.t_chips or 0
    abil.x_mult = abil.x_mult or abil.Xmult or 1
    abil.extra_value = abil.extra_value or 0
    abil.d_size = abil.d_size or 0
    abil.mult = abil.mult or 0
    abil.effect = center.effect
    abil.h_size = abil.h_size or 0
    abil.card_limit = abil.card_limit or 1
    abil.extra_slots_used = abil.extra_slots_used or 0
    local eligible_editionless_jokers = {}
    for i, v in pairs(G.jokers and G.jokers.cards or {}) do
        if not v.edition then
            eligible_editionless_jokers[#eligible_editionless_jokers + 1] = v
        end
    end
    local tbl = {
        ability = abil,
        config = {
            center = center,
            center_key = center.key
        },
        juice_up = function(_, ...)
            return self:juice_up(...)
        end,
        start_dissolve = function(_, ...)
            return self:start_dissolve(...)
        end,
        remove = function(_, ...)
            return self:remove(...)
        end,
        flip = function(_, ...)
            return self:flip(...)
        end,
        can_use_consumeable = function(self, ...)
            return Card.can_use_consumeable(self, ...)
        end,
        calculate_joker = function(self, ...)
            return Card.calculate_joker(self, ...)
        end,
        can_calculate = function(self, ...)
            return Card.can_calculate(self, ...)
        end,
        set_cost = function(self, ...)
            Card.set_cost(self, ...)
        end,
        calculate_sticker = function(self, ...)
            Card.calculate_sticker(self, ...)
        end,
        base_cost = 1,
        extra_cost = 0,
        original_card = self,
        area = area,
        added_to_deck = added_to_deck,
        cost = self.cost,
        sell_cost = self.sell_cost,
        eligible_strength_jokers = eligible_editionless_jokers,
        eligible_editionless_jokers = eligible_editionless_jokers,
        T = self.t,
        VT = self.VT
    }
    for i, v in pairs(Card) do
        if type(v) == "function" and i ~= "flip_side" then
            tbl[i] = function(_, ...)
                return v(self, ...)
            end
        end
    end
    tbl.set_edition = function(s, ed, ...)
        Card.set_edition(s, ed, ...)
    end
    tbl.get_chip_h_x_mult = function(s, ...)
        local ret = SMODS.multiplicative_stacking(s.ability.h_x_mult or 1,
            (not s.ability.extra_enhancement and s.ability.perma_h_x_mult) or 0)
        return ret
    end
    tbl.get_chip_x_mult = function(s, ...)
        local ret = SMODS.multiplicative_stacking(s.ability.x_mult or 1,
            (not s.ability.extra_enhancement and s.ability.perma_x_mult) or 0)
        return ret
    end
    tbl.use_consumeable = function(self, ...)
        self.bypass_echo = true
        local ret = Card.use_consumeable(self, ...)
        self.bypass_echo = nil
    end
    return tbl
end

local use_ref = Card.use_consumeable 
function Card:use_consumeable(...)
    if Entropy.DeckOrSleeve("gemstone") and SMODS.pseudorandom_probability(nil, "entr_gemstone_deck", 1, 3) and self.config.center.set ~= "Rune" then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            attention_text({
                text = localize('k_nope_ex'),
                scale = 1.3, 
                hold = 1.4,
                major = self,
                backdrop_colour = G.C.PURPLE,
                align = 'cm',
                offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                silent = true
                })
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4);return true end}))
                play_sound('tarot2', 1, 0.4)
                self:juice_up(0.3, 0.5)
        return true end }))
        return
    else
        local ret = use_ref(self, ...)
        if not self.bypass_echo then
            if G.GAME.entr_echo and G.GAME.entr_echo[self.config.center.key] and #G.GAME.entr_echo[self.config.center.key] > 0 then
                for i, v in pairs(G.GAME.entr_echo[self.config.center.key]) do
                    local dum = Entropy.GetDummy(G.P_CENTERS[v], self.area, self)
                    dum.bypass_echo = true
                    Cryptid.forcetrigger(dum, {})
                    dum.bypass_echo = nil
                end
            end
        end
        self.used = true
        return ret
    end
end

local ref = Cryptid.handle_other_localizations
function Cryptid.handle_other_localizations()
    ref()
	SMODS.handle_loc_file(Entropy.path)
end

SMODS.Booster:take_ownership_by_kind('Arcana', {
	create_card = function(self, card, i)
        local rune
        local rare_rune
        if pseudorandom("entr_generate_rune") < 0.06 then rune = true end
		if G.GAME.entr_diviner then
            if pseudorandom("entr_generate_rune") < 0.06 then rune = true end
        end
        if rune then
            return create_card("Rune", G.pack_cards, nil, nil, true, true, nil, "spe")
        end
        local _card
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {set = "Spectral", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "ar2"}
        else
            _card = {set = "Tarot", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "ar1"}
        end
        return _card
	end
},true)


SMODS.Booster:take_ownership_by_kind('Celestial', {
	create_card = function(self, card, i)
        local rune
        local rare_rune
        if pseudorandom("entr_generate_rune") < 0.06 then rune = true end
		if G.GAME.entr_diviner then
            if pseudorandom("entr_generate_rune") < 0.06 then rune = true end
        end
        if rune and (i ~= 1 or not G.GAME.used_vouchers.v_telescope) then
            return create_card("Rune", G.pack_cards, nil, nil, true, true, nil, "spe")
        end
        local _card
        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for k, v in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(v) and G.GAME.hands[v].played > _tally then
                    _hand = v
                    _tally = G.GAME.hands[v].played
                end
            end
            if _hand then
                for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                    if v.config.hand_type == _hand then
                        _planet = v.key
                    end
                end
            end
            _card = {set = "Planet", area = G.pack_cards, skip_materialize = true, soulable = true, key = _planet, key_append = "pl1"}
        else
            _card = {set = "Planet", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "pl1"}
        end
        return _card
	end
},true)


local get_probability_varsref = SMODS.get_probability_vars
function SMODS.get_probability_vars(trigger_obj, base_numerator, base_denominator, identifier, from_roll)
    if trigger_obj and trigger_obj.config and trigger_obj.config.center and not Entropy.probability_cards[trigger_obj.config.center.key] then
        Entropy.probability_cards[trigger_obj.config.center.key] = true
    end
    local numerator, denominator = get_probability_varsref(trigger_obj, base_numerator, base_denominator, identifier, from_roll)
    if type(numerator) == "string" or numerator == nil then numerator = 1 end
    if type(denominator) == "string" or denominator == nil then denominator = 1 end
    local any_active
    for i, v in pairs(SMODS.find_card("j_entr_d1")) do
        if not v.ability.triggered then any_active = true end
    end
    if Entropy.has_rune("rune_entr_ingwaz") then
        any_active = true
    end
    if any_active then
        numerator = denominator
    end
    if (numerator or -1) < 0 then numerator = 0 end
    if (denominator or 0) < 1 then denominator = 1 end
    return numerator, denominator
end

Entropy.probability_cards = {}
local probability_ref = SMODS.pseudorandom_probability
function SMODS.pseudorandom_probability(trigger_obj, seed, base_numerator, base_denominator, identifier)
    if trigger_obj and trigger_obj.config and trigger_obj.config.center and not Entropy.probability_cards[trigger_obj.config.center.key] then
        Entropy.probability_cards[trigger_obj.config.center.key] = true
    end
    SMODS.calculate_context({pre_probability = true})
    for i, v in pairs(SMODS.find_card("j_entr_d1")) do
        if v.ability.triggered ~= true then
            v.ability.triggered = true
            return probability_ref(trigger_obj, seed, base_denominator, base_denominator, identifier)
        else
            v.ability.triggered = true
        end
    end
    for i, v in pairs(SMODS.find_card("j_entr_d4")) do
        local res = probability_ref(trigger_obj, seed, base_numerator, base_denominator, identifier) 
        if res then return res end
    end
    if next(SMODS.find_card("j_entr_heimartai")) and not next(SMODS.find_card("j_entr_d0")) then
        local res = probability_ref(trigger_obj, seed, base_numerator, base_denominator, identifier) 
        local rolls = 1
        while not res do
            res = probability_ref(trigger_obj, seed, base_numerator, base_denominator, identifier) 
            card_eval_status_text(
                trigger_obj,
                "extra",
                nil,
                nil,
                nil,
                { message = not res and localize("k_again_ex") or "Success!", colour = G.C.GREEN }
            )
            rolls = rolls + 1
        end
        for i, v in pairs(SMODS.find_card("j_entr_heimartai")) do
            SMODS.scale_card(v, {
                ref_table = v.ability,
                ref_value = "echips",
                scalar_table = {val = rolls / base_denominator},
                scalar_value = "val"
            })
        end
        return res
    end
    return probability_ref(trigger_obj, seed, base_numerator, base_denominator, identifier)
end

local has_no_suitref = SMODS.has_no_suit
function SMODS.has_no_suit(card, bypass)
    if card.config.center.key == "j_entr_false_vacuum_collapse" then return true end
    if next(SMODS.find_card("j_entr_opal")) and not bypass then
        return false
    end
    if card.base.suit == "entr_nilsuit" then return true end
    return has_no_suitref(card)
end

local has_no_rankref = SMODS.has_no_rank
function SMODS.has_no_rank(card, bypass)
    if card.config.center.key == "j_entr_false_vacuum_collapse" then return true end
    return has_no_rankref(card)
end

local in_scoringref = SMODS.in_scoring
function SMODS.in_scoring(card, ...)
    if card.config.center.key == "j_entr_false_vacuum_collapse" then return true end
    return in_scoringref(card, ...)
end

local get_idref = Card.get_id
function Card:get_id(...)
    local id = get_idref(self, ...)
    if next(SMODS.find_card("j_entr_opal")) then
        if id ~= get_idref(self, ...) then return 15 end
    end
    return id
end

local rate_ref = Cryptid.interest_rate
function Cryptid.interest_rate()
    local rate = Entropy.has_rune("rune_entr_loyalty") and math.max(5 - (Entropy.has_rune("rune_entr_loyalty").ability.count or 1), 1)
    if rate then return rate end
	return rate_ref and rate_ref() or G.GAME.modifiers.cry_interest_rate or 5
end

local interest_ref = Cryptid.get_interest
function Cryptid.get_interest(add_rows)
    local cap = G.GAME.interest_cap
    G.GAME.interest_cap = G.GAME.interest_cap +(G.GAME.companion_interest_cap or 0)
    if interest_ref then
        local interest = interest_ref(add_rows)
        G.GAME.interest_cap = cap
        return interest
    else    
        local rate = Cryptid.interest_rate()
        local interest = math.min(math.floor(G.GAME.dollars / rate), G.GAME.interest_cap / 5)
        interest = interest * G.GAME.interest_amount
        for _, a in pairs(SMODS.get_card_areas("jokers")) do
            for i, c in pairs(a.cards) do
                if c.config.center.cry_calc_interest then
                    interest = c.config.center:cry_calc_interest(c, interest)
                end
            end
        end
        G.GAME.interest_cap = cap
        return interest
    end
end

local at2 = add_tag
function add_tag(tag, from_skip, no_copy)
    at2(tag, from_skip, no_copy)
	if no_copy then
		return
	end
	SMODS.calculate_context({ entr_add_tag = true, tag = tag })
end

local ref = G.FUNCS.exit_overlay_menu_code
G.FUNCS.exit_overlay_menu_code = function(e)
	if G.GAME.CODE_DESTROY_CARD then
        G.GAME.CODE_DESTROY_CARD.ability.bypass_aleph = true
    end
    ref(e)
end

local is_eternalref = SMODS.is_eternal
function SMODS.is_eternal(c, ...)
    if c and c.ability and c.ability.entr_aleph then return true end
    if c and (c.area == G.play or c.area == G.hand or c.area == G.deck) and (c.ability.eternal or c.ability.entr_aleph) then
        return true
    end
    if c then
        return is_eternalref(c, ...)
    end
end

local open_ref = Card.open
function Card:open(...)
    if next(SMODS.find_card("j_entr_enlightenment")) then
        if self.config.center.kind == "Inverted" then
            G.GAME.last_inversion = {
                key = self.config.center.key,
                set = self.config.center.set
            }
        else
            G.GAME.last_tarot_planet = self.config.center.key
        end
    end
    open_ref(self, ...)
    G.E_MANAGER:add_event(Event{
        trigger = "after",
        blocking = false,
        func = function()
            G.E_MANAGER:add_event(Event{
                trigger = "after",
                blocking = false,
                func = function()
                    SMODS.calculate_context{post_open_booster = true, card = self}
                    return true
                end
            })
            return true
        end
    })
    if Entropy.DeckOrSleeve("crafting") then
        G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit, 5)
    end
end

local new_round_ref = new_round
function new_round(...)
    new_round_ref(...)
    if Entropy.DeckOrSleeve("crafting") then
        G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit, 5)
    end
end

local copy_cardref = copy_card
function copy_card(old, new, ...)
    local tw = G.GAME.modifiers.entr_twisted
    G.GAME.modifiers.entr_twisted = nil
    local copy = copy_cardref(old, new, ...)
    if G.deck and not G.SETTINGS.paused then
        SMODS.calculate_context{copying_card = true, original_card = old, new_card = copy}
    end
    for i, v in pairs(G.play and G.play.cards or {}) do
        eval_card(v, {copying_card = true, original_card = old, new_card = copy})
    end
    if old.base and old.base.nominal then copy.base.nominal = old.base.nominal end
    G.GAME.modifiers.entr_twisted = tw
    return copy
end

local toggle_shopref = G.FUNCS.toggle_shop
G.FUNCS.toggle_shop = function(e)
    stop_use()
    G.CONTROLLER.locks.toggle_shop = true
    local check
    for i, v in pairs(G.shop_jokers.cards) do
        if v.facing == "back" then
            G.E_MANAGER:add_event(Event{
                func = function()
                    v:flip()
                    return true
                end
            })
            check = true
            delay(2)
            card_eval_status_text(
                v,
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_nope_ex"), colour = G.C.RED }
            )
        end
    end

    
    if check then
        delay(2)
        G.E_MANAGER:add_event(Event{
            trigger = "after", 
            blocking = false,
            func = function()
                toggle_shopref(e)
                return true
            end
        })
    else
        toggle_shopref(e)
    end
end


local defeat_ref = Blind.defeat
function Blind:defeat(silent, ...)
    if G.GAME.blind_on_deck == "Boss" then
        G.GAME.round_resets.blind_states.Boss = "Defeated"
    end
    local ret = defeat_ref(self, silent, ...)
    return ret
end

for i, v in pairs(SMODS.JimboQuips or {}) do
    if not v.extra or not v.extra.center or v.extra.center == "j_joker" then
        local extra = copy_table(v.extra)
        extra = extra or {}
        extra.center = "j_entr_surreal_joker"
        SMODS.JimboQuip:take_ownership(v.key, {
            extra = extra
        }, true)
    end
end

--Init stuff at the start of the game
local gigo = Game.init_game_object
function Game:init_game_object()
	local g = gigo(self)
	g.jokers_sold = {}
	return g
end


local sell_card_stuff = Card.sell_card
function Card:sell_card()
	if self.config.center.set == "Joker" then
		if not (SMODS.Mods["Cryptid"] or {}).can_load then
			local contained = false
			for _, v in ipairs(G.GAME.jokers_sold) do
				if v == self.config.center.key then
					contained = true
					break
				end
			end
			if not contained then
				table.insert(G.GAME.jokers_sold, self.config.center.key)
			end
		end
	end
	sell_card_stuff(self)
end 

SMODS.Consumable:take_ownership("fool", {
    loc_vars = function(self, info_queue, card)
        local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
        local last_tarot_planet = fool_c and localize { type = 'name_text', key = fool_c.key, set = fool_c.set == "Booster" and "Other" or fool_c.set } or
            localize('k_none')

        if last_tarot_planet == "ERROR" then
            local nodes = {}
            localize{type = 'name', set = "Other", key = fool_c.key, nodes = nodes}
            if not nodes[1] then
                localize{type = 'name', set = "Other", key = string.gsub(fool_c.key, "_[0-9]*$", ""), nodes = nodes}
            end
            last_tarot_planet = nodes[1][1].nodes[1].config.object.string
        end
        local colour = (not fool_c or fool_c.name == 'The Fool') and G.C.RED or G.C.GREEN

        if not (not fool_c or fool_c.name == 'The Fool') then
            info_queue[#info_queue + 1] = fool_c
        end

        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' .. last_tarot_planet .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        }
                    }
                }
            }
        }

        return { vars = { last_tarot_planet }, main_end = main_end }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    SMODS.add_card({ key = G.GAME.last_tarot_planet, area = G.consumeables })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        local fac = card.area == G.consumeables and -1 or 0
        return G.consumeables.config.card_limit > #G.consumeables.cards + fac and G.GAME.last_tarot_planet and
            G.GAME.last_tarot_planet ~= 'c_fool'
    end
}, true)

local calculate_objref = SMODS.eval_individual
function SMODS.eval_individual(individual, context)
    if individual.object then
        return calculate_objref(individual, context)
    end
end

if HotPotato then
    function PissDrawer.Shop.main_shop()
        -- Reroll button for unknown goddamn reason just stuck, so I'll unstuck it
        G.E_MANAGER:add_event(Event({
            blocking = false,
            no_delete = true,
            func = function()
                local reroll = G.shop and G.shop:get_UIE_by_ID('shop_reroll')
                    if reroll and reroll.UIBox then
                    reroll.UIBox:recalculate()
                end
                return true
            end,
        }))
        return
        {n=G.UIT.C, nodes = {
            {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.R,config={id = 'next_round_button', align = "cm", minw = 1.8, minh = Entropy.CanSwitchAltPath() and 1 or 1.3, r=0.15,colour = G.C.RED, one_press = true, button = 'toggle_shop', hover = true,shadow = true}, nodes = {
                        {n=G.UIT.R, config={align = "cm", padding = 0.07, focus_args = {button = 'y', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                                {n=G.UIT.T, config={text = localize('b_next_round_1'), scale = 0.4, colour = G.C.WHITE, shadow = true}}
                            }},
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                                {n=G.UIT.T, config={text = localize('b_next_round_2'), scale = 0.4, colour = G.C.WHITE, shadow = true}}
                            }}
                        }},
                    }},
                    (Entropy.CanSwitchAltPath() and {n=G.UIT.R,config={id = 'change_path_button', align = "cm", minw = 1.8, minh = 1, r=0.15,colour = G.C.PURPLE, button = 'toggle_path', hover = true,shadow = true, func='can_toggle_path'}, nodes = {
                        {n=G.UIT.R, config={align = "cm", padding = 0.07, focus_args = {button = 'y', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                            {n=G.UIT.T, config={text = localize(G.GAME.entr_alt and 'b_change_path_3' or 'b_change_path_1'), scale = 0.4, colour = G.C.WHITE, shadow = true}}
                            }},
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                            not G.GAME.entr_alt and {n=G.UIT.T, config={text = localize('b_change_path_2'), scale = 0.4, colour = G.C.WHITE, shadow = true}} or nil
                            }}
                        }},              
                    }} or nil),
                    {n=G.UIT.R, config={id = 'shop_reroll', align = "cm", minw = 1.8, minh = Entropy.CanSwitchAltPath() and 1 or 1.3, r=0.15,colour = G.C.GREEN, button = 'reroll_shop', func = 'can_reroll', hover = true,shadow = true}, nodes = {
                        {n=G.UIT.R, config={align = "cm", padding = 0.07, focus_args = {button = 'x', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                                {n=G.UIT.T, config={text = localize('k_reroll'), scale = 0.4, colour = G.C.WHITE, shadow = true}},
                            }},
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3, minw = 1}, nodes={
                                {n=G.UIT.T, config={text = localize('$'), scale = 0.7, colour = G.C.WHITE, shadow = true}},
                                {n=G.UIT.T, config={ref_table = G.GAME.current_round, ref_value = 'reroll_cost', scale = 0.75, colour = G.C.WHITE, shadow = true}},
                            }}
                        }}
                    }},
                }},
                {n=G.UIT.C, config={align = "cm", padding = 0.2, r=0.2, colour = G.C.L_BLACK, emboss = 0.05, minw = 8.0}, nodes={
                    {n=G.UIT.O, config={object = G.shop_jokers}},
                }},
                {n=G.UIT.C, config = {align='cm', padding = 0.1}, nodes = {
                    {n=G.UIT.R, config={align = "cm", minw = 0.5, maxw = 0.7, minh = 0.8, r=0.15,colour = G.C.CLEAR, id = "show_plinko_button", button = 'open_plinko', shadow = true}, nodes = {
                        {n=G.UIT.O, config = {object = Sprite(0, 0, 0.9, 0.9, G.ASSET_ATLAS['hpot_pissdrawer_shop'], { x = 0, y = 0 }), shadow = true, hover = true, button_dist = 0.63}},
                    }},

                    {n=G.UIT.R, config={align = "cm", minw = 0.5, maxw = 0.7, minh = 0.8, r=0.15,colour = G.C.CLEAR, id = "show_wheel_button", button = 'open_wheel', shadow = true}, nodes = {
                        {n=G.UIT.O, config = {object = Sprite(0, 0, 0.9, 0.9, G.ASSET_ATLAS['hpot_pissdrawer_shop'], { x = 1, y = 0 }), shadow = true, hover = true, button_dist = 0.63}},
                    }},

                    {n=G.UIT.R, config={align = "cm", minw = 0.5, maxw = 0.7, minh = 0.8, r=0.15,colour = G.C.CLEAR, id = "show_nursery_button", button = 'open_nursery', shadow = true}, nodes = {
                        {n=G.UIT.O, config = {object = Sprite(0, 0, 0.9, 0.9, G.ASSET_ATLAS['hpot_pissdrawer_shop'], { x = 2, y = 0 }), shadow = true, hover = true, button_dist = 0.63}},
                    }},
                }}
            }},
            -- spacer
            {n=G.UIT.R, config={minh = 0.1}},
            -- bottom shop row
            {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
                    {n=G.UIT.C, config={align = "cm", padding = 0.2, r=0.2, colour = G.C.BLACK, maxh = G.shop_vouchers.T.h+0.4}, nodes={
                        {n=G.UIT.T, config={text = localize{type = 'variable', key = 'ante_x_voucher', vars = {G.GAME.round_resets.ante}}, scale = 0.45, colour = G.C.L_BLACK, vert = true}},
                        {n=G.UIT.O, config={object = G.shop_vouchers}},
                    }},
                }},
                {n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
                    {n=G.UIT.O, config={object = G.shop_booster}},
                }},
            }}
        }}
    end
end

local smods_poll_edref = SMODS.poll_edition
function SMODS.poll_edition(args)
    local unordered_options = args.options or get_current_pool("Edition", nil, nil, _key or 'edition_generic')
    local _options = {}
    for _, edition in ipairs(unordered_options) do
        if G.P_CENTERS[edition] and not G.P_CENTERS[edition].no_doe and not G.GAME.banned_keys[edition] then
            if G.P_CENTERS[edition].vanilla then
                table.insert(_options, 1, edition)
            else
                table.insert(_options, edition)
            end
        end
    end
    args.options = _options
    return smods_poll_edref(args)
end

local poll_edref = poll_edition
function poll_edition(_key, _mod, _no_neg, _guaranteed, options)
    if not options then
		if _key == "wheel_of_fortune" or _key == "aura" then -- set base game edition polling
			options = { 'e_negative', 'e_polychrome', 'e_holo', 'e_foil' }
		end
	end
    local unordered_options = options or get_current_pool("Edition", nil, nil, _key or 'edition_generic')
    local _options = {}
    for _, edition in ipairs(unordered_options) do
        if G.P_CENTERS[edition] and not G.P_CENTERS[edition].no_doe and not G.GAME.banned_keys[edition] then
            if G.P_CENTERS[edition].vanilla then
                table.insert(_options, 1, edition)
            else
                table.insert(_options, edition)
            end
        end
    end
    return poll_edref(_key, _mod, _no_neg, _guaranteed, _options)
end

local gcp = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append, override_equilibrium_effect)
    if next(SMODS.find_card("j_entr_kitchenjokers")) and _type == "Joker" then
        for i, v in pairs(SMODS.find_card("j_entr_kitchenjokers")) do
            if pseudorandom("kitchenjokers_check") < 0.25 then
                _type = "Food"
                break
            end
        end
    end
    local ret, ret2 = gcp(_type, _rarity, _legendary, _append, override_equilibrium_effect)
    return ret, ret2
end

local calc_main_scoring = SMODS.calculate_main_scoring
function SMODS.calculate_main_scoring(context, scoring_hand)
    local fvc_cards = {}
    for i, v in pairs(G.play.cards) do if v.config.center.key == "j_entr_false_vacuum_collapse" and not v.debuff then fvc_cards[#fvc_cards+1] = v end end
    for i, v in pairs(G.jokers.cards) do if v.config.center.key == "j_entr_false_vacuum_collapse" and not v.debuff then fvc_cards[#fvc_cards+1] = v end end
    if context.cardarea ~= G.play or (not next(SMODS.find_card('j_entr_rubber_ball')) and not next(fvc_cards)) then
	    calc_main_scoring(context, scoring_hand)
    end
	if context.cardarea == G.play and (next(SMODS.find_card('j_entr_rubber_ball')) or next(fvc_cards)) then
        if not G.rubber_cards or #G.rubber_cards.cards == 0 then
            G.rubber_cards = {cards = Entropy.rubber_ball_scoring(scoring_hand)}
        end
		context.cardarea = G.rubber_cards
        context.scoring_hand = G.rubber_cards.cards
		calc_main_scoring(context, G.rubber_cards.cards)
		context.cardarea = G.play
        G.rubber_cards = nil
	end
	return
end

local base_shader_ref = Card.should_draw_base_shader
function Card:should_draw_base_shader(...)
    return base_shader_ref(self, ...) and not (self.debuff and Entropy.IsEE())
end

function Entropy.ee_taunt(taunt)
    local quip = taunt
    local extra = {
        center = SMODS.JimboQuips[taunt].extra.center
    }
    extra.x = 0
    extra.y = 5
    Jimbo = Card_Character(extra)
    local spot = G.HUD:get_UIE_by_ID('hand_text_area')
    spot.config.object = Jimbo
    Jimbo.ui_object_updated = true
    Jimbo:add_speech_bubble(quip, nil, {quip = true}, extra)
    Jimbo:say_stuff((extra and extra.times) or 5, false, quip)
    G.E_MANAGER:add_event(Event{
        trigger = "after",
        blocking = false,
        func = function()
            if not Jimbo.talking then
                G.E_MANAGER:add_event(Event{
                    trigger = "after",
                    delay = 4,
                    func = function()
                        Jimbo:remove()
                        return true
                    end
                })
                return true
            end
        end
    })
end

function Entropy.is_number(x)
    return type(x) == "number" or (type(x) == "table" and is_number(x)) or (is_big and is_big(x))
end
function Entropy.is_big(x)
    return (type(x) == "table" and is_number(x)) or (is_big and is_big(x))
end

function hotpot_horsechicot_market_section_init_cards()
  G.GAME.shop.market_joker_max = G.GAME.shop.market_joker_max or 2
  if G.GAME.market_table then
    G.market_jokers:load(G.GAME.market_table)
    G.GAME.market_table = nil
  else
    if not G.GAME.market_filled then
      G.GAME.market_filled = {}
      for i = 1, G.GAME.shop.market_joker_max - #G.market_jokers.cards do
        local new_shop_card
        if G.GAME.modifiers.no_shop_jokers then
            new_shop_card = SMODS.create_card { set = "BlackMarketJokerless", area = G.market_jokers, bypass_discovery_ui = true, bypass_discovery_center = true }
            if G.GAME.modifiers.glitched_items then
                local gc = {new_shop_card.config.center.key}
                for i = 1, G.GAME.modifiers.glitched_items - 1 do
                gc[#gc+1] = Entropy.GetPooledCenter("BlackMarketJokerless").key
                end
                new_shop_card.ability.glitched_crown = gc
            end
        else
            new_shop_card = SMODS.create_card { set = "BlackMarket", area = G.market_jokers, bypass_discovery_ui = true, bypass_discovery_center = true }
            if G.GAME.modifiers.glitched_items then
                local gc = {new_shop_card.config.center.key}
                for i = 1, G.GAME.modifiers.glitched_items - 1 do
                gc[#gc+1] = Entropy.GetPooledCenter("BlackMarket").key
                end
                new_shop_card.ability.glitched_crown = gc
            end
        end
        G.market_jokers:emplace(new_shop_card)
        create_market_card_ui(new_shop_card)
        new_shop_card:juice_up()
        G.GAME.market_filled[#G.GAME.market_filled + 1] = new_shop_card.config.center.key
      end
      -- save_run()
    else
      for i, v in pairs(G.GAME.market_filled) do
        local c = SMODS.create_card {
          key = v,
          bypass_discovery_ui = true,
          bypass_discovery_center = true
        }
        create_market_card_ui(c)
        G.market_jokers:emplace(c)
      end
      for i, v in pairs(G.market_jokers.cards) do
        create_market_card_ui(v)
      end
    end
  end
  G.harvest_cost = G.harvest_cost or 0
end


local forcetrigger_ref = Cryptid.forcetrigger
function Cryptid.forcetrigger(card, ...)
    if card.ability.consumeable then
        local center = card.config.center
        if center and center.calculate then
            center:calculate(card, {pre_using_self = true, consumeable = card, area = card.from_area})
        end
        local edition = card.edition and G.P_CENTERS[card.edition.key]
        if edition and edition.calculate then
            edition:calculate(card, {pre_using_self = true, consumeable = card, area = card.from_area})
        end
    end
    return forcetrigger_ref(card, ...)
end

local gnv_ref = SMODS.get_next_vouchers
function SMODS.get_next_vouchers(vouchers)
    local ret = gnv_ref(vouchers)
    if G.GAME.deck_voucher_rate and (G.GAME.deck_voucher_round or 0) % G.GAME.deck_voucher_rate == 0 then
        local center = Entropy.GetPooledCenter("Back").key
        ret[#ret+1] = center
        ret.spawn[center] = true
    end
    G.GAME.deck_voucher_round = (G.GAME.deck_voucher_round or -1) + 1
    return ret
end
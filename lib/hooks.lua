local card_drawref = Card.draw
function Card:draw(layer)
    local ref = card_drawref(self, layer)
    if self.config and self.config.center then
        if self.config.center.set == "RSpectral" and self.sprite_facing == "front" then
            self.children.center:draw_shader('booster', nil, self.ARGS.send_to_shader)
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
    local remove_temp = {}
    for i, v in pairs({G.jokers, G.hand, G.consumeables, G.discard, G.deck}) do
            for ind, card in pairs(v.cards) do
                if card.ability then
                    if card.ability.entr_hotfix then
                        card.ability.entr_hotfix_rounds = (card.ability.entr_hotfix_rounds or 5) - 1
                        if to_big(card.ability.entr_hotfix_rounds) <= to_big(0) then
                            card.ability.entr_hotfix = false
                            
                            Cryptid.misprintize(card, nil, nil, true)
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
    if G.GAME.blind_on_deck == "Boss" then
        G.GAME.entr_princess = nil
    end
end

local set_debuffref = Card.set_debuff

function Card:set_debuff(should_debuff)
    if self.perma_debuff or self.ability.superego then should_debuff = true end
    if self.ability.entr_hotfix or G.GAME.nodebuff or (self.config.center.rarity == "entr_zenith" and not (G.GAME.blind and G.GAME.blind.config.blind.key == "bl_entr_endless_entropy_phase_three")) then should_debuff = false end
    set_debuffref(self, should_debuff)
end

local ref = evaluate_play_final_scoring
function evaluate_play_final_scoring(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta = ref(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      	func = (function()
            G.GAME.asc_power_hand = nil
        return true end)
    }))
    return text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta
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

local set_abilityref = Card.set_ability
function Card:set_ability(center, initial, delay)
    local link = self and self.ability and self.ability.link
    if self.config.center ~= "m_entr_disavowed" and (not self.entr_aleph or self.ability.bypass_aleph) then
        set_abilityref(self, center, initial, delay)
    end
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
    if center and center.key == "m_stone" then
        self.ability.bonus = 50
    end
end

local set_editionref = Card.set_edition
function Card:set_edition(...)
    set_editionref(self, ...)
    if self.ability.link then
        for i, v in pairs(G.hand.cards) do
            if v.ability.link == self.ability.link then
                set_editionref(v, ...) 
            end
        end
        for i, v in pairs(G.discard.cards) do
            if v.ability.link == self.ability.link then
                set_editionref(v, ...) 
            end
        end
        for i, v in pairs(G.deck.cards) do
            if v.ability.link == self.ability.link then
                set_editionref(v, ...) 
            end
        end
    end
    if self:is_sunny() and self.area == G.jokers then 
        check_for_unlock({ type = "sunny_joker" })
    end
end

local start_dissolveref = Card.start_dissolve
function Card:start_dissolve(...)
    start_dissolveref(self, ...)
    if self.ability.link then
        for i, v in pairs(G.hand.cards) do
            if v.ability.link == self.ability.link then
                start_dissolveref(v, ...) 
                v.ability.temporary2 = true
            end
        end
        for i, v in pairs(G.discard.cards) do
            if v.ability.link == self.ability.link then
                start_dissolveref(v, ...) 
                v.ability.temporary2 = true
            end
        end
        for i, v in pairs(G.deck.cards) do
            if v.ability.link == self.ability.link then
                start_dissolveref(v, ...) 
                v.ability.temporary2 = true
            end
        end
    end
end

local oldfunc = Game.main_menu
	Game.main_menu = function(change_context)
		local ret = oldfunc(change_context)
		-- adds a Beyond spectral to the main menu
        -- thanks to cryptid for this code
		-- make the title screen use different background colors
		G.SPLASH_BACK:define_draw_steps({
			{
				shader = "splash",
				send = {
					{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
					{ name = "vort_speed", val = 0.4 },
					{ name = "colour_1", ref_table = Entropy, ref_value = "entropic_gradient" },
					{ name = "colour_2", ref_table = G.C, ref_value = "CRY_EXOTIC" },
				},
			},
		})

		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0,
			blockable = false,
			blocking = false,
			func = function()
                for i, v in pairs(G.title_top.cards) do
                    if v.base and v.base.value and v.base.value == "Ace" then
                        if math.random() < 0.01 then
                            v:set_edition("e_entr_freaky") 
                        else
                            v:set_edition("e_entr_solar") 
                        end
                    end
                    if v.config.center_key == "c_cryptid" then 
                        v:set_ability(G.P_CENTERS.c_entr_entropy)
                        v.T.w = v.T.w * 1.1 * 1.2
                        v.T.h = v.T.h * 1.1 * 1.2
                    end
                end
				return true
			end,
		}))

		return ret
	end


    local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if not SMODS.config.no_mod_badges and obj and obj.entr_credits then
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
		if obj.entr_credits.art or obj.entr_credits.code or obj.entr_credits.idea or obj.entr_credits.custom then
			local scale_fac = {}
			local min_scale_fac = 1
			local strings = { "Entropy" }
			for _, v in ipairs({ "idea", "art", "code" }) do
				if obj.entr_credits[v] then
					for i = 1, #obj.entr_credits[v] do
						strings[#strings + 1] =
							localize({ type = "variable", key = "cry_" .. v, vars = { obj.entr_credits[v][i] } })[1]
					end
				end
			end
            if obj.entr_credits.custom then
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
			local cry_badge = {
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
			local function eq_col(x, y)
				for i = 1, 4 do
					if x[i] ~= y[i] then
						return false
					end
				end
				return true
			end
			for i = 1, #badges do
				if eq_col(badges[i].nodes[1].config.colour, HEX("FE0001")) then
					badges[i].nodes[1].nodes[2].config.object:remove()
					badges[i] = cry_badge
					break
				end
			end
		end
	end
end

local is_suitref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    --unified usually never shows up, support for life and other mods
    if self.base.suit == "entr_nilsuit" then
        return false
    else
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
        G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED
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
    if c1.edition and c1.edition.negative and c1.area == G.consumeables then
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
    end
    e.config.ref_table.cost = 0
    e.config.ref_table:open()
    --c1:remove()
end

G.FUNCS.can_open_voucher = function(e)
    local c1 = e.config.ref_table
    e.config.colour = G.C.GREEN
    e.config.button = "open_voucher"
end
G.FUNCS.open_voucher = function(e)
    local c1 = e.config.ref_table
    c1.cost = 0
    c1:redeem()
    c1:start_dissolve()
    c1:remove()
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
    --c1:remove()
end

G.FUNCS.can_buy_deckorsleeve = function(e)
    local c1 = e.config.ref_table
    e.config.colour = G.C.GREEN
    e.config.button = "buy_deckorsleeve"
end
G.FUNCS.can_buy_deckorsleeve_from_shop = function(e)
    local c1 = e.config.ref_table
    if to_big(G.GAME.dollars+G.GAME.bankrupt_at) > to_big(c1.cost) then
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
    G.FUNCS.buy_deckorsleeve(e)
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
        if c1.config.center.set == "Sleeve" then
            c1.config.center:apply(c1.config.center)
        else    
            c1.config.center:apply(false)
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
        if i == "joker_slot" then G.jokers.config.card_limit = G.jokers.config.card_limit + v end
        if i == "hand_size" then G.hand.config.card_limit = G.hand.config.card_limit + v end
        if i == "dollars" then ease_dollars(v) end
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


G.FUNCS.can_buy_slot = function(e)
    if
        to_big(G.GAME.dollars-G.GAME.bankrupt_at) > to_big(e.config.ref_table.ability.buycost)
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
    G.jokers.config.card_limit = G.jokers.config.card_limit + 1
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
    G.jokers.config.card_limit = G.jokers.config.card_limit - 1
end

--som
local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local abc = G_UIDEF_use_and_sell_buttons_ref(card)
	-- Allow code cards to be reserved
    if (card.ability.set == "Back" or card.ability.set == "Sleeve") then
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
    if (card.area == G.consumeables and G.consumeables and card.config.center.set == "Booster") then
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
    if (card.area == G.consumeables and G.consumeables) and card.config.center.set == "Voucher" then
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
    --let boosters not be recursive
    if (card.area == G.pack_cards and G.pack_cards) and card.config.center.set == "Booster" and not Entropy.ConsumablePackBlacklist[SMODS.OPENED_BOOSTER.config.center.key] then
        return  {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'reserve_booster', func = 'can_reserve_booster', handy_insta_action = 'buy_or_sell'}, nodes={
                {n=G.UIT.T, config={text = localize('b_select'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
              }},
          }}
    end

    if (card.area == G.jokers and G.jokers and card.config.center.key == "j_entr_akyros") then
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
    if card.area == G.pack_cards and G.pack_cards and not card.config.center.no_select and ((card.ability.set == "RCode" or card.ability.set == "CBlind" or card.ability.set == "RTarot" or card.ability.set == "RSpectral" or card.config.center.key == "c_entr_flipside") or not SMODS.OPENED_BOOSTER.draw_hand and card.children.front) and (card.ability.consumeable) then
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
                        button = "use_card",
                        func = (card.ability.set == "RCode" or card.ability.set == "CBlind" or card.ability.set == "RTarot" or card.ability.set == "RSpectral" or card.config.center.key == "c_entr_flipside") and "can_reserve_card" or "can_reserve_card_to_deck",
                        handy_insta_action = 'use'
                    },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                text = card.ability.set == "RCode" and localize("b_pull")  or localize("b_select"),
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
            card2.debuff = false
            card2.sell_cost = 0
            e.config.ref_table.area:emplace(card2)
        end
    end
    sell_ref(e)
end

local scie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    local ret
    ret = scie(effect, scored_card, key, amount, from_edition)
    if ret then
        return ret
    end
    if (key == 'eq_mult' or key == 'Eqmult_mod') then 
        local e = card_eval_status_text
        card_eval_status_text = function() end
        scie(effect, scored_card, "Xmult_mod", 0, from_edition)
        scie(effect, scored_card, "mult_mod", amount, from_edition)
        card_eval_status_text = e
        if not Talisman.config_file.disable_anims then
            Entropy.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent)
        end
        return true
    end
    if (key == 'eq_chips' or key == 'Eqchips_mod') then 
        local e = card_eval_status_text
        card_eval_status_text = function() end
        scie(effect, scored_card, "Xchip_mod", 0, from_edition)
        scie(effect, scored_card, "chip_mod", amount, from_edition)
        card_eval_status_text = e
        if not Talisman.config_file.disable_anims then
            Entropy.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "="..amount.. " Chips", G.C.BLUE)
        end
        return true
    end
    if (key == 'asc') or (key == 'asc_mod') then
        local e = card_eval_status_text
        local orig = to_big((G.GAME.asc_power_hand or 0) + G.GAME.current_round.current_hand.cry_asc_num)
        G.GAME.asc_power_hand = to_big((G.GAME.asc_power_hand or 1) + G.GAME.current_round.current_hand.cry_asc_num) * to_big(amount)
        if G.GAME.current_round.current_hand.cry_asc_num == 0 then G.GAME.current_round.current_hand.cry_asc_num = 1 end
        G.GAME.current_round.current_hand.cry_asc_num_text = " (+" .. (to_big(G.GAME.asc_power_hand)) .. ")"
        card_eval_status_text = function() end
        scie(effect, scored_card, "Xmult_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        scie(effect, scored_card, "Xchip_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        card_eval_status_text = e
        if not Talisman.config_file.disable_anims then
            Entropy.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "X"..amount.." Asc", G.C.GOLD, "entr_e_solar", 0.6)
        end
        return true
    end
    if (key == 'plus_asc') or (key == 'plusasc_mod') then
        local e = card_eval_status_text
        local orig = to_big((G.GAME.asc_power_hand or 0) + G.GAME.current_round.current_hand.cry_asc_num)
        G.GAME.asc_power_hand = to_big((G.GAME.asc_power_hand or 0) + G.GAME.current_round.current_hand.cry_asc_num) + to_big(amount)
        G.GAME.current_round.current_hand.cry_asc_num_text = " (+" .. (to_big(G.GAME.asc_power_hand)) .. ")"
        card_eval_status_text = function() end
        scie(effect, scored_card, "Xmult_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        scie(effect, scored_card, "Xchip_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        card_eval_status_text = e
        if not Talisman.config_file.disable_anims then
            Entropy.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "+"..amount.." Asc", G.C.GOLD, "entr_e_solar", 0.6)
        end
        return true
    end
    if (key == 'exp_asc') or (key == 'exp_asc_mod') then
        local e = card_eval_status_text
        local orig = to_big((G.GAME.asc_power_hand or 0) + G.GAME.current_round.current_hand.cry_asc_num)
        G.GAME.asc_power_hand = to_big((G.GAME.asc_power_hand or 0) + G.GAME.current_round.current_hand.cry_asc_num) ^ to_big(amount)
        if G.GAME.asc_power_hand ~= 0 then G.GAME.current_round.current_hand.cry_asc_num_text = " (+" .. (to_big(G.GAME.asc_power_hand)) .. ")" end
        card_eval_status_text = function() end
        scie(effect, scored_card, "Xmult_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        scie(effect, scored_card, "Xchip_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), false)
        card_eval_status_text = e
        if not Talisman.config_file.disable_anims then
            Entropy.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "^"..amount.." Asc", G.C.GOLD, "entr_e_solar", 0.6)
        end
        return true
    end
    if key == 'xlog_chips' then
        hand_chips = mod_chips(hand_chips * math.max(math.log(to_big(hand_chips) < to_big(0) and 1 or hand_chips, amount), 1))
        update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
        if not Talisman.config_file.disable_anims then
            Entropy.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', 1, percent, nil, nil, "Chips Xlog(Chips)", G.C.BLUE, "entr_e_rizz", 0.6)
        end
        return true
    end
end
for _, v in ipairs({'eq_mult', 'Eqmult_mod', 'asc', 'asc_mod', 'plus_asc', 'plusasc_mod', 'exp_asc', 'exp_asc_mod', 'eq_chips', 'Eqchips_mod', 'xlog_chips'}) do
    table.insert(SMODS.calculation_keys, v)
end

local entr_define_dt = 0
local entr_antireal_dt = 0
local entr_xekanos_dt = 0
local update_ref = Game.update
function Game:update(dt)
    if entr_xekanos_dt > 0.05 then
        entr_xekanos_dt = 0
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
    if G.P_CENTERS and G.P_CENTERS.c_entr_define and entr_define_dt > 0.5 then
		entr_define_dt = 0
		local pointerobj = G.P_CENTERS.c_entr_define
		pointerobj.pos.x = (pointerobj.pos.x == 4) and 5 or 4
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
    return card_drawref(self, layer)
end

local create_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local card = create_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
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
    return card
end

local ref = level_up_hand
function level_up_hand(card, hand, instant, amount)
    if Entropy.HasJoker("j_entr_strawberry_pie",true) and hand ~= "High Card" then
        hand = "High Card"
    end
    ref(card,hand,instant,amount)
end

local start_dissolveref = Card.start_dissolve
function Card:start_dissolve(...)
    start_dissolveref(self, ...)
    if self.config.center.key == "j_entr_chocolate_egg" and not self.ability.no_destroy and self.area == G.jokers and G.jokers then
        card_eval_status_text(
            self,
            "extra",
            nil,
            nil,
            nil,
            { message = localize("entr_opened"), colour = G.C.GREEN }
        )
        local c = create_card("Joker", G.jokers, nil, "Rare")
        c:add_to_deck()
        G.jokers:emplace(c)
        c:set_edition("e_entr_sunny")
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
Entropy.ChaosConversions.RCode = "Twisted"
Entropy.ChaosConversions.RPlanet = "Twisted"
Entropy.ChaosConversions.RSpectral = "Twisted"
local ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if (next(find_joker("j_entr_chaos")) or next(find_joker("j_entr_parakmi"))) and not forced_key then
        _type = Entropy.GetRandomSet(next(find_joker("j_entr_parakmi")))

    end
    if _type == "CBlind" then
        _type = "BlindTokens"
    end
    if _type == "BlindTokens" then
        local element = "c_"..pseudorandom_element(Entropy.BlindC, pseudoseed(key_append or "parakmi"))
        forced_key = forced_key or element
    end
    local card = ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if (next(find_joker("j_entr_chaos")) or next(find_joker("j_entr_parakmi"))) and not forced_key then 
        if not G.SETTINGS.paused and not G.GAME.akyrs_any_drag then
            card.fromdefine = true
        end
    end
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
    curr2 =
        curr2 or
        ((G.GAME.current_round.current_hand.cry_asc_num or 0) + (G.GAME.asc_power_hand or 0)) *
            (1 + (G.GAME.nemesisnumber or 0))
    if Entropy.BlindIs(G.GAME.blind, "bl_entr_scarlet_sun") and not G.GAME.blind.disabled then
        curr2 = curr2 * (Entropy.IsEE() and -0.25 or -1)
    end
    if Cryptid.enabled("set_cry_poker_hand_stuff") ~= true then
        return num
    end
    if Cryptid.gameset() == "modest" then
        -- x(1.1 + 0.05 per sol) base, each card gives + (0.1 + 0.05 per sol)
        if not G.GAME.current_round.current_hand.cry_asc_num then
            return num
        end
        return num *
            (1 + 0.1 + to_big(0.05 * (G.GAME.sunnumber or 0)) +
                to_big((0.1 + (0.05 * (G.GAME.sunnumber or 0))) * to_big(curr2)))
    elseif Entropy.HasJoker("j_entr_helios", true) then
        local curr = 1
        for i, v in pairs(G.jokers.cards) do
            if not v.debuff and v.config.center.key == "j_entr_helios" and to_big(v.ability.extra):gt(curr) then
                curr = v.ability.extra + 0.4
            end
        end
        return num * to_big((1.75 + (G.GAME.sunnumber or 0))):tetrate(to_big((curr2) * curr))
    else
        return num * (to_big((1.25 + (G.GAME.sunnumber or 0))) ^ to_big(curr2))
    end
end

local pokerhandinforef = G.FUNCS.get_poker_hand_info
function G.FUNCS.get_poker_hand_info(_cards)
    if Entropy.HasJoker("j_entr_helios", true) or (Entropy.BlindIs(G.GAME.blind, "bl_entr_scarlet_sun") and not G.GAME.blind.disabled) then G.GAME.used_vouchers.v_cry_hyperspacetether = true end
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

SMODS.Consumable:take_ownership('cry_sunplanet', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
        loc_vars = function(self, q, card)
            local levelone = (G.GAME.sunlevel and G.GAME.sunlevel or 0) + 1
            local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
            if levelone == 1 then
                planetcolourone = G.C.UI.TEXT_DARK
            end
            return {
                vars = {
                    (G.GAME.sunlevel or 0) + 1,
                    card.ability.extra or 0.05,
                    ((G.GAME.sunnumber and G.GAME.sunnumber or 0) + ((G.jokers and Entropy.HasJoker("j_entr_helios") and 1.75) or 1.25))..(G.jokers and Entropy.HasJoker("j_entr_helios") and "^" or ""),
                    colours = { planetcolourone },
                },
            }
        end
    },
    true -- silent | suppresses mod badge
)

local ease_anteref = ease_ante
function ease_ante(mod)
    local mult = 1
    if to_big(mod) ~= to_big(0) then
        if Entropy.HasJoker("j_entr_xekanos", true) then
            for i, v in pairs(G.jokers.cards) do
                if v.config.center.key == "j_entr_xekanos" and not v.debuff and not v.ability.turned_off and not G.GAME.modifiers.ReverseRedeo then
                    mult = mult * to_number(-v.ability.ante_mod)
                    v.ability.ante_mod = v.ability.ante_mod - v.ability.ante_mod_mod
                end
            end
        end
        ease_anteref(mod * mult, a)
    end
end

local is_jollyref = Card.is_jolly
function Card:is_jolly()
	if Entropy.HasJoker("j_entr_dekatria",true) then return true end
    return is_jollyref(self)
end


local ref = Tag.init
function Tag:init(_tag, for_collection, _blind_type, ...)
    if Entropy.HasJoker("j_entr_exousia",true) and Entropy.AscendedTags[_tag] and not for_collection then 
        _tag = Entropy.AscendedTags[_tag]
        local procs = 1
        while pseudorandom("exousia") < 0.1 and procs < Entropy.HasJoker("j_entr_exousia",true) and Entropy.AscendedTags[_tag] and not for_collection do
            _tag = Entropy.AscendedTags[_tag]
        end
    end
    ref(self, _tag, for_collection, _blind_type, ...)
    local tag = self
    if G.P_TAGS[tag.key].set_ability then
        G.P_TAGS[tag.key]:set_ability(tag)
    end
    return tag
end

local TrumpCardAllow = {
    ["Planet"] = true,
    ["Tarot"] = true,
    ["Code"] = true
}
local matref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    G.GAME.entropy = G.GAME.entropy or 0
    if G.SETTINGS.paused then
        matref(self, center, initial, delay_sprites)
    else
        if self.config and self.config.center and Entropy.FlipsideInversions and Entropy.FlipsideInversions[self.config.center.key]
        and pseudorandom("marked") < 0.10 and G.GAME.Marked and G.STATE == G.STATES.SHOP and (not self.area or not self.area.config.collection) then
            matref(self, G.P_CENTERS[Entropy.FlipsideInversions[self.config.center.key]], initial, delay_sprites)
        elseif self.config and self.config.center
        and pseudorandom("trump_card") < 0.10 and G.GAME.TrumpCard and G.STATE == G.STATES.SMODS_BOOSTER_OPENED
        and TrumpCardAllow[center.set] and (not self.area or not self.area.config.collection) then
            matref(self, G.P_CENTERS["c_entr_flipside"], initial, delay_sprites)
        elseif self.config and self.config.center and self.config.center.set == "Booster"
        and pseudorandom("supersede") < 0.20 and G.GAME.Supersede and G.STATE == G.STATES.SHOP and (not self.area or not self.area.config.collection) then
            local type = (center.cost == 6 and "jumbo") or (center.cost == 8 and "mega") or "normal"
            matref(self, G.P_CENTERS["p_entr_twisted_pack_"..type], initial, delay_sprites)
        elseif self.config and self.config.center and self.config.center.set == "Booster"
        and to_big(pseudorandom("doc")) < to_big(1-(0.995^G.GAME.entropy)) and G.STATE == G.STATES.SHOP and (not self.area or not self.area.config.collection) and Entropy.DeckOrSleeve("doc") then
            local type = (center.cost == 6 and "jumbo_1") or (center.cost == 8 and "mega_1") or "normal_"..pseudorandom_element({1,2},pseudoseed("doc"))
            matref(self, G.P_CENTERS["p_spectral_"..type], initial, delay_sprites)
        else
            matref(self, center, initial, delay_sprites)
        end
    end
end

G.FUNCS.has_inversion = function(e) 
    if G.GAME.last_inversion then 
        e.config.colour = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
    else
        e.config.colour = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
    end
 end
local ref = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
    local card = e.config.ref_table
    if Entropy.FlipsideInversions[card.config.center.key] and not Entropy.FlipsidePureInversions[card.config.center.key] and card.config.center.key ~= "c_entr_master" and not card.config.center.hidden then
        G.GAME.last_inversion = {
            key = card.config.center.key,
            set = card.config.center.set
        }
    end
    card.ability.bypass_aleph = true
    ref(e, mute, nosave)
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
local set_abilityref = Card.set_ability
function Card:set_ability(center, ...)
    if self.config and self.config.center and self.config.center.key ~= "m_entr_disavowed" and (not self.entr_aleph or self.ability.bypass_aleph)  then
        if center and Entropy.FlipsideInversions[center.key] and not G.SETTINGS.paused and (G.GAME.modifiers.entr_twisted or center.set == "Planet" and G.GAME.entr_princess) and not self.multiuse and not self.ability.fromflipside then
            set_abilityref(self, G.P_CENTERS[Entropy.FlipsideInversions[center.key]] or center, ...)
        else    
            set_abilityref(self, center, ...)
        end
    else
        if not self.entr_aleph then
            set_abilityref(self, G.P_CENTERS.m_entr_disavowed, ...)
        else
            set_abilityref(self, self.config.center, ...)
        end
    end
end

local use_cardref = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
	local card = e.config.ref_table
	if card.config.center.set ~= "Booster" and Entropy.DeckOrSleeve("doc") then
    local num = 1
    for i, v in pairs(G.GAME.entr_bought_decks or {}) do if v == "b_entr_doc" or v == "sleeve_entr_doc" then num = num + 1 end end
		if Entropy.FlipsideInversions[card.config.center.key] and not Entropy.FlipsidePureInversions[card.config.center.key] then
			ease_entropy(4*num*Entropy.DeckOrSleeve("doc"))
		else
			ease_entropy(2*num*Entropy.DeckOrSleeve("doc"))
		end
	end
	use_cardref(e, mute, nosave)
end
SMODS.Booster:take_ownership_by_kind('Spectral', {
	create_card = function(self, card, i)
		G.GAME.entropy = G.GAME.entropy or 0
		if to_big(pseudorandom("doc")) < to_big(1 - 0.997^G.GAME.entropy) and Entropy.DeckOrSleeve("doc") and Cryptid.enabled("c_entr_beyond") == true then
			return create_card("RSpectral", G.pack_cards, nil, nil, true, true, "c_entr_beyond")
		elseif to_big(pseudorandom("doc")) < to_big(1 - 0.996^G.GAME.entropy) and Entropy.DeckOrSleeve("doc") and Cryptid.enabled("c_cry_gateway") == true then
			return create_card("Spectral", G.pack_cards, nil, nil, true, true, "c_cry_gateway")
		end
		return create_card("Spectral", G.pack_cards, nil, nil, true, true, nil, "spe")
	end
},true)
SMODS.Consumable:take_ownership("cry_gateway",{
	use = function(self, card, area, copier)
		if not Entropy.DeckOrSleeve("doc") then
			local deletable_jokers = {}
			for k, v in pairs(G.jokers.cards) do
				if not v.ability.eternal then
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
      ease_entropy(-math.min(G.GAME.entropy, 4))
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
            if not Talisman.config_file.disable_anims then
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
          if not Talisman.config_file.disable_anims then
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
                G.GAME.EEBuildup = true
            end
        end
        if G.GAME.modifiers.zenith then
            for i, v in pairs(G.GAME.round_resets.blind_choices) do
                G.GAME.round_resets.blind_choices[i] = "bl_entr_endless_entropy_phase_one"
            end
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
        if G.GAME.SudoHand and G.GAME.SudoHand[v] and not G.GAME.USINGSUDO then
            results[G.GAME.SudoHand[v]] = results[v]
        end
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

local create_cardref = create_card_for_shop
function create_card_for_shop(area)
    local card = create_cardref(area)
    if card.ability.set == "Joker" and Entropy.HasJoker("j_entr_ieros", true) then
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
        return to_big(gba(actual)):tetrate(1 + ante/32)
    end
    return gba(actual) or 100
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
        e.config.object.colours = { G.C.SET.RCode }
    else
        e.config.object.colours = { G.C.UI.TEXT_LIGHT }
    end
    e.config.object:update_text()
end

local add_tagref = add_tag
function add_tag(_tag)
    add_tagref(_tag)
    if not G.GAME.autostart_tags then G.GAME.autostart_tags = {} end
    if not G.GAME.autostart_tags[_tag.key] then G.GAME.autostart_tags[_tag.key] = _tag.key end
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
		if G.jokers and G.GAME.blind and G.GAME.blind.config.blind.key == "bl_entr_endless_entropy_phase_two" then
			local dtmod = math.min(G.SETTINGS.GAMESPEED, 4)/2+0.5
			ee2dt = ee2dt + dt*dtmod
			if ee2dt > 1 then
				for i, v in pairs(G.jokers.cards) do
					if not Card.no(G.jokers.cards[i], "immutable", true) then
						Cryptid.misprintize(G.jokers.cards[i], { min=0.975,max=0.975 }, nil, true)
					end
				end
				ee2dt = ee2dt - 1
			end
		end
		if G.jokers and G.GAME.blind and G.GAME.blind.config.blind.key == "bl_entr_endless_entropy_phase_three" then
			G.HUD_blind:get_UIE_by_ID("score_at_least").config.text = localize("ph_blind_score_less_than")
			for i, v in pairs(G.jokers.cards) do
				v.debuff = false
			end
            for i = 1, math.ceil(math.max(G.jokers.config.card_limit, #G.jokers.cards)/5) do
                if G.jokers.cards[i] then
                    G.jokers.cards[i].debuff = true
                end
            end
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
    -- if Entropy.CheckTranscendence(_cards) ~= "None" or (G.GAME.hands[text] and G.GAME.hands[text].TranscensionPower) then
    --     ease_colour(G.C.UI_CHIPS, copy_table(HEX("84e1ff")), 0.3)
	-- 	ease_colour(G.C.UI_MULT, copy_table(HEX("84e1ff")), 0.3)
    -- else
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
    G.GAME.current_round.current_hand.cry_asc_num = (G.GAME.current_round.current_hand.cry_asc_num or 0) * (1+(G.GAME.nemesisnumber or 0))
    if Entropy.BlindIs(G.GAME.blind, "bl_entr_scarlet_sun") and not G.GAME.blind.disabled then 
        G.GAME.current_round.current_hand.cry_asc_num = G.GAME.current_round.current_hand.cry_asc_num * (Entropy.IsEE() and -0.25 or -1)
    end
    -- if Entropy.CheckTranscendence(_cards) ~= "None" then
    --     G.GAME.current_round.current_hand.entr_trans_num_text = "Transcendant "
    --     G.GAME.TRANSCENDENT = true
    -- end
	if to_big(G.GAME.current_round.current_hand.cry_asc_num) ~= to_big(0) then
        if to_big(G.GAME.current_round.current_hand.cry_asc_num) > to_big(0) then
            G.GAME.current_round.current_hand.cry_asc_num_text = " (+"..G.GAME.current_round.current_hand.cry_asc_num..")"
        else    
            G.GAME.current_round.current_hand.cry_asc_num_text = " ("..G.GAME.current_round.current_hand.cry_asc_num..")"
        end
    else
        G.GAME.current_round.current_hand.cry_asc_num_text = ""
    end
    -- if Entropy.CheckTranscendence(_cards) == "None" then
    --     G.GAME.current_round.current_hand.entr_trans_num_text = ""
    -- end
    if Entropy.BlindIs(G.GAME.blind, "bl_entr_scarlet_sun") and not G.GAME.blind.disabled then 
        G.GAME.current_round.current_hand.cry_asc_num = G.GAME.current_round.current_hand.cry_asc_num * (Entropy.IsEE() and -0.25 or -1)
    end
    return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end


local ref = update_hand_text

function update_hand_text(config, vals)
    if type(vals.mult) == "number" or type(vals.mult) == "table" and Entropy.HasJoker("j_entr_tesseract",true) and math.abs(to_big(vals.mult)) > to_big(0.001) then
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
    if type(vals.chips) == "number" or type(vals.chips) == "table" and Entropy.HasJoker("j_entr_tesseract",true) and math.abs(to_big(vals.chips)) > to_big(0.001) then
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

local create_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local card = create_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if card and card.config and card.config.center and card.config.center.key == "c_base" and Entropy.DeckOrSleeve("crafting") then
      if pseudorandom("crafting") < 0.5 then
        card:set_ability(pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed("crafting")))
      end
	  end
    return card
end

function Entropy.GetRecipeResult(val,jokerrares,seed)
    local rare = 1
    local cost=0
    for i, v in pairs({
        [1]=0,
        [2]=6,
        [3]=12,
        cry_epic=20,
        [4]=30,
        cry_exotic=45,
        entr_entropic = 70
    }) do
        if v > cost and val >= v then
            rare = i;cost=v
        end
    end
    return pseudorandom_element(jokerrares[rare], pseudoseed(seed))
end
function Entropy.ConcatStrings(tbl)
    local result = ""
    for i, v in pairs(tbl) do result = result..v end
    return result
end



function Entropy.GetRecipe(cards)
    local enhancements = Entropy.EnhancementPoints
    local rares = {}
    for i, v in pairs(G.P_CENTER_POOLS.Joker) do
        if not rares[v.rarity] then rares[v.rarity] = {} end
        rares[v.rarity][#rares[v.rarity]+1] = v.key
    end
    local enh = {}
    for i = 1, 5 do
        local card = cards[i]
        enh[#enh+1]=card.config.center.key
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
    if self:is_sunny() then 
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

local ref = G.FUNCS.evaluate_play
G.FUNCS.evaluate_play = function(e)
    local refe = ref(e)
    G.E_MANAGER:add_event(Event({
        trigger="after",
        func = function()
            update_hand_text_random({delay = 0}, {chips=0, mult=0, handname = "", level=""})
            return true
        end
    }))
    return refe
end

local ref = copy_card
function copy_card(old, new, ...)
    if not new or (not new.entr_aleph) then
        local card = ref(old, new, ...)
        card.ability.bypass_aleph = nil
        return card
    end
    return new
end

if Entropy.config.omega_aleph then
    local card_removeref = Card.remove
    function Card:remove(...)
        if G.SETTINGS.paused or not self.entr_aleph or self.ability.bypass_aleph then
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
        if not card or not card.entr_aleph or G.SETTINGS.paused or card.ability.bypass_aleph then
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
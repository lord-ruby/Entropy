local card_drawref = Card.draw
function Card:draw(layer)
    card_drawref(self, layer)
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

local set_debuffref = Card.set_debuff

function Card:set_debuff(should_debuff)
    if self.perma_debuff or self.ability.superego then should_debuff = true end
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
    if self.config.center ~= "m_entr_disavowed" then
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
                    --if v.base and v.base.value and v.base.value == "Ace" then v:set_edition("e_entr_solar") end
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
        #G.consumeables.cards
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
    for i, v in pairs(c1.confi and c1.config.center and c1.config.center.config or {}) do
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
            v:remove_from_deck()
            G.jokers:remove_card(v)
            cards[#cards+1]=v
        end
        for i, v in pairs(G.consumeables.cards) do
            v:remove_from_deck()
            G.consumeables:remove_card(v)
            cards[#cards+1]=v
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
        if card.area == G.hand then
        return  {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'buy_deckorsleeve', func = 'can_buy_deckorsleeve'}, nodes={
                {n=G.UIT.T, config={text = localize('b_redeem'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
              }},
          }}
        end
        if card.area == G.consumeables or card.area == G.jokers then
            sell = {n=G.UIT.C, config={align = "cr"}, nodes={
                {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card'}, nodes={
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
              
              {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'buy_deckorsleeve', func = 'can_buy_deckorsleeve'}, nodes={
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
	if (card.area == G.pack_cards and G.pack_cards) then --Add a use button
        if (card.ability.set == "Back" or card.ability.set == "Sleeve") then
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
							button = "buy_deckorsleeve",
							func = "can_buy_deckorsleeve"
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("b_select"),
									colour = G.C.UI.TEXT_LIGHT,
									scale = 0.55,
									shadow = true,
								},
							},
						},
					},
                }
            }
        elseif ((card.ability.set == "RCode" or card.ability.set == "CBlind" or card.ability.set == "RTarot") or not SMODS.OPENED_BOOSTER.draw_hand and card.children.front) and (card.ability.consumeable) then
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
							func = (card.ability.set == "RCode" or card.ability.set == "CBlind" or card.ability.set == "RTarot") and "can_reserve_card" or "can_reserve_card_to_deck",
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
		if card.ability.name == "entr-Flipside" or G.RPerkeoPack then
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
							func = "can_reserve_card",
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("b_select"),
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
	end
    if (card.area == G.consumeables and G.consumeables and card.config.center.set == "Booster") then
        sell = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card'}, nodes={
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
          
          {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'open_booster', func = 'can_open_booster'}, nodes={
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
                  {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'reserve_joker', func = 'can_reserve_joker'}, nodes={
                    {n=G.UIT.T, config={text = localize('b_select'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
                  }},
              }}
		end
        if card.config.center.set == "Booster" then
			return  {
                n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
                  {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'open_booster', func = 'can_open_booster'}, nodes={
                    {n=G.UIT.T, config={text = localize('b_open'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
                  }},
              }}
		end
        if card.config.center.set == "Voucher" then
			return  {
                n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
                  {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'open_voucher', func = 'can_open_voucher'}, nodes={
                    {n=G.UIT.T, config={text = localize('b_redeem'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
                  }},
              }}
		end
	end
    if (card.area == G.consumeables and G.consumeables) and card.config.center.set == "Voucher" then
        sell = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card'}, nodes={
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
          
          {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'open_voucher', func = 'can_open_voucher'}, nodes={
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
              {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'reserve_booster', func = 'can_reserve_booster'}, nodes={
                {n=G.UIT.T, config={text = localize('b_select'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
              }},
          }}
    end

    if (card.area == G.jokers and G.jokers and card.config.center.key == "j_entr_akyros") then
        sell = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card'}, nodes={
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


    --remove sell button if beyond exists in pack
    if
       card and card.config and card.config.center and card.config.center.set == "Joker" and  (Entropy.HasConsumable("c_entr_beyond") or (Entropy.HasConsumable("c_cry_gateway") and Entropy.HasConsumable("c_entr_flipside")))
    then
        table.remove(abc.nodes[1].nodes, 1)
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
end
for _, v in ipairs({'eq_mult', 'Eqmult_mod', 'asc', 'asc_mod', 'plus_asc', 'plusasc_mod', 'exp_asc', 'exp_asc_mod'}) do
    table.insert(SMODS.calculation_keys, v)
end

local entr_define_dt = 0
local entr_antireal_dt = 0
local update_ref = Game.update
function Game:update(dt)
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
    return ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
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
        curr2 = curr2 * -1
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
                    ((G.GAME.sunnumber and G.GAME.sunnumber or 0) + ((G.jokers and HasJoker("j_entr_helios") and 1.75) or 1.25))..(G.jokers and HasJoker("j_entr_helios") and "^" or ""),
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
    if Entropy.HasJoker("j_entr_xekanos", true) then
        for i, v in pairs(G.jokers.cards) do
            if v.config.center.key == "j_entr_xekanos" and not v.debuff then
                mult = -v.ability.ante_mod
            end
        end
    end
    ease_anteref(mod * mult)
end

local is_jollyref = Card.is_jolly
function Card:is_jolly()
	if HasJoker("j_entr_dekatria",true) then return true end
    return is_jollyref(self)
end


local ref = Tag.init
function Tag:init(_tag, for_collection, _blind_type)
    if Entropy.HasJoker("j_entr_exousia",true) and Entropy.AscendedTags[_tag] and not for_collection then 
        _tag = Entropy.AscendedTags[_tag]
        local procs = 1
        while pseudorandom("exousia") < 0.1 and procs < Entropy.HasJoker("j_entr_exousia",true) and Entropy.AscendedTags[_tag] and not for_collection do
            _tag = Entropy.AscendedTags[_tag]
        end
    end
    return ref(self,_tag, for_collection, _blind_type)
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
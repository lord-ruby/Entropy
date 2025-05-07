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
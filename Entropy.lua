local i = {
    "lib/utils",
    "items/jokers/misc_jokers",
    "items/jokers/epic_jokers",
    "items/inversions/reverseLegendaries", 
    "items/jokers/exotic_jokers",
    "items/jokers/entropic_jokers",
    "items/inversions/reverseTarots",
    "items/misc/consumable",
    "items/inversions/reversePlanets",
    "items/inversions/reverseSpectrals",
    "items/inversions/reverseCodes", 
    "items/inversions/define", 
    "lib/transcendant",
    "lib/colours", 
    "items/misc/decks", 
    "items/misc/vouchers", 
    "items/jokers/hidden", 
    "lib/fixes",
    "items/misc/stake", 
    "items/misc/tags", 
    "items/misc/editions",  
    "items/misc/seals", 
    "items/misc/enhancements", 
    "items/misc/blinds", 
    "items/misc/content_sets",
    "lib/gameset_overrides",
    "compat/loader"
}
local items = {}
for _, v in pairs(i) do
    local f, err = SMODS.load_file(v..".lua")
    if f then 
        local results = f() 
        if results then
            if results.init then results.init(results) end
            if results.items then
                for i, result in pairs(results.items) do
                    if not items[result.object_type] then items[result.object_type] = {} end
                    result.cry_order = result.order
                    items[result.object_type][#items[result.object_type]+1]=result
                end
            end
        end
    else error("error in file "..v..": "..err) end
end
for i, category in pairs(items) do
    table.sort(category, function(a, b) return a.order < b.order end)
    for i2, item in pairs(category) do
        if not SMODS[item.object_type] then print(item.object_type);Entropy.fucker = item.object_type
    else SMODS[item.object_type](item) end
    end
end
SMODS.current_mod.optional_features = {
	retrigger_joker = true,
}

Cryptid.mod_whitelist["Entropy"] = true
if not Cryptid.mod_gameset_whitelist then Cryptid.mod_gameset_whitelist = {} end
Cryptid.mod_gameset_whitelist["entr"] = true
Cryptid.mod_gameset_whitelist["Entropy"] = true
if SMODS and SMODS.calculate_individual_effect then

    local scie = SMODS.calculate_individual_effect
    function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
        local ret = scie(effect, scored_card, key, amount, from_edition)
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
                card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent)
            end
            return true
        end
        if (key == 'asc') or (key == 'asc_mod') then
            local e = card_eval_status_text
            local orig = G.GAME.asc_power_hand or 0
            G.GAME.asc_power_hand = to_big(G.GAME.asc_power_hand or 1) * to_big(amount)
            if G.GAME.current_round.current_hand.cry_asc_num == 0 then G.GAME.current_round.current_hand.cry_asc_num = 1 end
            G.GAME.current_round.current_hand.cry_asc_num_text = " (+" .. (to_big(G.GAME.current_round.current_hand.cry_asc_num) * G.GAME.asc_power_hand) .. ")"
            card_eval_status_text = function() end
            scie(effect, scored_card, "Xmult_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), from_edition)
            scie(effect, scored_card, "Xchip_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), from_edition)
            card_eval_status_text = e
            if not Talisman.config_file.disable_anims then
                card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "X"..amount.." Asc", G.C.GOLD, "entr_e_solar", 0.6)
            end
            return true
        end
        if (key == 'plus_asc') or (key == 'plusasc_mod') then
            local e = card_eval_status_text
            local orig = G.GAME.asc_power_hand or 0
            G.GAME.asc_power_hand = to_big(G.GAME.asc_power_hand or 0) + to_big(amount)
            G.GAME.current_round.current_hand.cry_asc_num_text = " (+" .. (to_big(G.GAME.current_round.current_hand.cry_asc_num) + G.GAME.asc_power_hand) .. ")"
            card_eval_status_text = function() end
            scie(effect, scored_card, "Xmult_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), from_edition)
            scie(effect, scored_card, "Xchip_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), from_edition)
            card_eval_status_text = e
            if not Talisman.config_file.disable_anims then
                card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "+"..amount.." Asc", G.C.GOLD, "entr_e_solar", 0.6)
            end
            return true
        end
        if (key == 'exp_asc') or (key == 'exp_asc_mod') then
            local e = card_eval_status_text
            local orig = G.GAME.asc_power_hand or 0
            G.GAME.asc_power_hand = to_big(G.GAME.asc_power_hand or 0) ^ to_big(amount)
            if G.GAME.current_round.current_hand.cry_asc_num == 0 then G.GAME.current_round.current_hand.cry_asc_num = 1 end
            G.GAME.current_round.current_hand.cry_asc_num_text = " (+" .. (to_big(G.GAME.current_round.current_hand.cry_asc_num) ^ to_big(G.GAME.asc_power_hand)) .. ")"
            card_eval_status_text = function() end
            scie(effect, scored_card, "Xmult_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), from_edition)
            scie(effect, scored_card, "Xchip_mod", Cryptid.ascend(1, G.GAME.asc_power_hand - orig), from_edition)
            card_eval_status_text = e
            if not Talisman.config_file.disable_anims then
                card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "^"..amount.." Asc", G.C.GOLD, "entr_e_solar", 0.6)
            end
            return true
        end
    end
    for _, v in ipairs({'eq_mult', 'Eqmult_mod', 'asc', 'asc_mod', 'plus_asc', 'plusasc_mod', 'exp_asc', 'exp_asc_mod'}) do
        table.insert(SMODS.calculation_keys, v)
    end
end

function card_eval_status_text_eq(card, eval_type, amt, percent, dir, extra, pref, col, sound, vol)
    percent = percent or (0.9 + 0.2*math.random())
    if dir == 'down' then 
        percent = 1-percent
    end

    if extra and extra.focus then card = extra.focus end

    local text = ''
    local volume = vol or 1
    local card_aligned = 'bm'
    local y_off = 0.15*G.CARD_H
    if card.area == G.jokers or card.area == G.consumeables then
        y_off = 0.05*card.T.h
    elseif card.area == G.hand then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    elseif card.area == G.play then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    elseif card.jimbo  then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    end
    local config = {}
    local delay = 0.65
    local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
    local extrafunc = nil
    sound = sound or 'multhit1'--'other1'
    amt = amt
    text = (pref) or ("Mult = "..amt)
    colour = col or G.C.MULT
    config.type = 'fade'
    config.scale = 0.7
    delay = delay*1.25
    if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
        if extra and extra.instant then
            if extrafunc then extrafunc() end
            attention_text({
                text = text,
                scale = config.scale or 1, 
                hold = delay - 0.2,
                backdrop_colour = colour,
                align = card_aligned,
                major = card,
                offset = {x = 0, y = y_off}
            })
            play_sound(sound, 0.8+percent*0.2, volume)
            if not extra or not extra.no_juice then
                card:juice_up(0.6, 0.1)
                G.ROOM.jiggle = G.ROOM.jiggle + 0.7
            end
        else
            G.E_MANAGER:add_event(Event({ --Add bonus chips from this card
                    trigger = 'before',
                    delay = delay,
                    func = function()
                    if extrafunc then extrafunc() end
                    attention_text({
                        text = text,
                        scale = config.scale or 1, 
                        hold = delay - 0.2,
                        backdrop_colour = colour,
                        align = card_aligned,
                        major = card,
                        offset = {x = 0, y = y_off}
                    })
                    play_sound(sound, 0.8+percent*0.2, volume)
                    if not extra or not extra.no_juice then
                        card:juice_up(0.6, 0.1)
                        G.ROOM.jiggle = G.ROOM.jiggle + 0.7
                    end
                    return true
                    end
            }))
        end
    end
    if extra and extra.playing_cards_created then 
        playing_card_joker_effects(extra.playing_cards_created)
    end
end


G.C.Entropy = {}
G.C.Entropy.OTHERS = {
    EqMult = HEX("CD8C8C")
}
G.C.Entropy.HYPER_EXOTIC = SMODS.Gradient{
    key = "entropic_gradient",
    colours = {
        G.C.RED,
        G.C.GOLD,
        G.C.GREEN,
        G.C.BLUE,
        G.C.PURPLE
    }
}
G.C.Entropy.REVERSE_LEGENDARY = SMODS.Gradient{
    key = "reverse_legendary_gradient",
    colours = {
        HEX("ff00c4"),
        HEX("FF00FF"),
        HEX("FF0000"),
    }
}

G.C.Entropy.ZENITH = SMODS.Gradient{
    key = "zenith_gradient",
    colours = {
        HEX("a20000"),
        HEX("a15000"),
        HEX("a3a101"),
        HEX("626262"),
        HEX("416600"),
        HEX("028041"),
        HEX("008284"),
        HEX("005683"),
        HEX("000056"),
        HEX("2b0157"),
        HEX("6a016a"),
        HEX("77003c"),
    }
}

local loc_colour_ref = loc_colour

SMODS.Rarity({
	key = "hyper_exotic",
	loc_txt = {},
	badge_colour = G.C.Entropy.HYPER_EXOTIC,
})
SMODS.Rarity({
	key = "reverse_legendary",
	loc_txt = {},
	badge_colour = G.C.Entropy.REVERSE_LEGENDARY,
})
SMODS.Rarity({
	key = "zenith",
	loc_txt = {},
	badge_colour = G.C.Entropy.ZENITH,
})
function loc_colour(_c, default)
    if not G.ARGS.LOC_COLOURS then
        loc_colour_ref(_c, default)
    elseif not G.ARGS.LOC_COLOURS.entr_colours then
        G.ARGS.LOC_COLOURS.entr_colours = true
        local new_colors = {
            entr_eqmult = G.C.Entropy.OTHERS.EqMult,
            entr_hyper_exotic = G.C.Entropy.HYPER_EXOTIC,
            entr_reverse_legendary = G.C.Entropy.REVERSE_LEGENDARY,
            entr_zenith = G.C.Entropy.ZENITH
        }

        for k, v in pairs(new_colors) do
            G.ARGS.LOC_COLOURS[k] = v
        end
    end

    return loc_colour_ref(_c, default)
end

local upd = Game.update
local anim_timer2 = 0
local entr_define_dt = 0
local entr_antireal_dt = 0
local cdt = 0
Entropy.last_csl = nil
Entropy.last_slots = nil
function Game:update(dt)
    upd(self, dt)
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
    cdt = cdt + dt
    if Entropy.DeckOrSleeve("ambisinister") and cdt > 0.05 and G.jokers then
        if not Entropy.last_csl then Entropy.last_csl = G.hand.config.highlighted_limit end
        if not Entropy.last_slots then Entropy.last_slots = (G.jokers.config.card_limit - #G.jokers.cards) end
        local slots_diff = (G.jokers.config.card_limit - #G.jokers.cards) - Entropy.last_slots
        local csl_diff = (G.hand.config.highlighted_limit) - Entropy.last_csl
        if csl_diff ~= 0 then
            G.jokers.config.card_limit = G.jokers.config.card_limit + csl_diff
        end
        if slots_diff ~= 0 then
            G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + slots_diff
        end
        Entropy.last_slots = G.jokers.config.card_limit - #G.jokers.cards
        G.hand.config.highlighted_limit = (G.jokers.config.card_limit - #G.jokers.cards)
        Entropy.last_csl = G.hand.config.highlighted_limit
    end
    if not Entropy.DeckOrSleeve("ambisinister") and cdt > 0.05 then
        Entropy.last_csl = nil
        Entropy.last_slots = nil
        cdt = 0
    end
end

local card_hoverref = Card.draw

function Card:draw(layer)
    card_hoverref(self, layer)
    if self.config and self.config.center and self.config.center.set == "RSpectral" then
        self.children.center:draw_shader('booster', nil, self.ARGS.send_to_shader)
    end
    if self.ability.name == "entr-Beyond" and (self.config.center.discovered or self.bypass_discovery_center) then
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
    if self.ability.name == "entr-Fervour" and (self.config.center.discovered or self.bypass_discovery_center) then
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

local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
	set_spritesref(self, _center, _front)
	if _center and _center.name == "entr-Beyond" then
		self.children.floating_sprite = Sprite(
			self.T.x,
			self.T.y,
			self.T.w * (self.no_ui and 1.1*1.2 or 1),
			self.T.h * (self.no_ui and 1.1*1.2 or 1),
			G.ASSET_ATLAS[_center.atlas or _center.set],
			{ x = 2, y = 0 }
		)
		self.children.floating_sprite.role.draw_major = self
		self.children.floating_sprite.states.hover.can = false
		self.children.floating_sprite.states.click.can = false
		self.children.floating_sprite2 = Sprite(
			self.T.x,
			self.T.y,
			self.T.w * (self.no_ui and 1.1*1.2 or 1),
			self.T.h * (self.no_ui and 1.1*1.2 or 1),
			G.ASSET_ATLAS[_center.atlas or _center.set],
			{ x = 1, y = 0 }
		)
		self.children.floating_sprite2.role.draw_major = self
		self.children.floating_sprite2.states.hover.can = false
		self.children.floating_sprite2.states.click.can = false
    end
    if _center and _center.name == "entr-Fervour" then
		self.children.floating_sprite = Sprite(
			self.T.x,
			self.T.y,
			self.T.w * (self.no_ui and 1.1*1.2 or 1),
			self.T.h * (self.no_ui and 1.1*1.2 or 1),
			G.ASSET_ATLAS[_center.atlas or _center.set],
			{ x = 5, y = 0 }
		)
		self.children.floating_sprite.role.draw_major = self
		self.children.floating_sprite.states.hover.can = false
		self.children.floating_sprite.states.click.can = false
    end
end

local oldfunc = Game.main_menu
	Game.main_menu = function(change_context)
		local ret = oldfunc(change_context)
		-- adds a Beyond spectral to the main menu
        -- thanks to cryptid for this code
        local newcard = Card(
			G.title_top.T.x,
			G.title_top.T.y,
			G.CARD_W*1.1*1.2,
			G.CARD_H*1.1*1.2,
			G.P_CARDS.empty,
			G.P_CENTERS.c_entr_entropy,
			{ bypass_discovery_center = true }
		)
            for i, v in pairs(G.title_top.cards) do
                if v.config.center.key == "c_cryptid" then v:start_dissolve() end
                if v.base and v.base.value and v.base.value == "Ace" then v:set_edition("e_entr_solar") end
            end
		-- recenter the title
		G.title_top:emplace(newcard)
		newcard.no_ui = true
		newcard.states.visible = false
		-- make the title screen use different background colors
		G.SPLASH_BACK:define_draw_steps({
			{
				shader = "splash",
				send = {
					{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
					{ name = "vort_speed", val = 0.4 },
					{ name = "colour_1", ref_table = G.C.RARITY, ref_value = "entr_hyper_exotic" },
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
				if change_context == "splash" then
					newcard.states.visible = true
					newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, true, 2.5)
				else
					newcard.states.visible = true
					newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, nil, 1.2)
				end
				return true
			end,
		}))

		return ret
	end


    SMODS.Atlas({
        key = "modicon",
        path = "entr_icon.png",
        px = 34,
        py = 34,
    }):register()

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

--shift+space ui for define 
local ckpu = Controller.key_press_update
function Controller:key_press_update(key, dt)
	ckpu(self, key, dt)
	if
		key == "space"
		and G.STAGE == G.STAGES.RUN
		and not _RELEASE_MODE
		and (self.held_keys["lshift"] or self.held_keys["rshift"])
		and not G.GAME.USING_CODE
	then
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
	end
end
SMODS.Sound({
	key = "music_zenith",
	path = "music_zenith.ogg",
	select_music_track = function()
		return G.GAME.Ruby and 10^300
	end,
})
SMODS.Sound({
	key = "music_entropic",
	path = "music_entropic.ogg",
	select_music_track = function()
		return Entropy.config
        and Entropy.config.entropic_music
        and #Cryptid.advanced_find_joker(nil, "entr_hyper_exotic", nil, nil, true) ~= 0 and 10^200
	end,
})
SMODS.Sound({
	key = "music_red_room",
	path = "music_red_room.ogg",
	select_music_track = function()
		return G.GAME.round_resets.blind_states.Red == "Current" and 10^5
	end,
})
SMODS.Sound({
	key = "music_freebird",
	path = "music_freebird.ogg",
	select_music_track = function()
		return HasJoker("j_entr_antireal") and Entropy.config.freebird and 10^200
	end,
})
SMODS.Sound({
	key = "music_fall",
	path = "music_fall.ogg",
	select_music_track = function()
		return ((G.GAME.round_resets.ante_disp == "32" and G.STATE == 1) or G.GAME.EEBuildup) and 10^302
	end,
})

SMODS.Sound({
	key = "music_entropy_is_endless",
	path = "music_entropy_is_endless.ogg",
	select_music_track = function()
        local blinds = {
            bl_entr_endless_entropy_phase_one=true,
            bl_entr_endless_entropy_phase_two=true,
            bl_entr_endless_entropy_phase_three=true,
            bl_entr_endless_entropy_phase_four=true
        }
		return (G.GAME.blind and blinds[G.GAME.blind.config.blind.key]) and 10^306
	end,
})
Entropy.config = SMODS.current_mod.config
local entrConfigTab = function()
	entr_nodes = {
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.O,
					config = {
						object = DynaText({
							string = localize("cry_set_enable_features"),
							colours = { G.C.WHITE },
							shadow = true,
							scale = 0.4,
						}),
					},
				},
			},
		},
	}
    entr_nodes[#entr_nodes + 1] = UIBox_button({
		colour = G.C.CRY_GREENGRADIENT,
		button = "your_collection_content_sets",
		label = { localize("b_content_sets") },
		count = modsCollectionTally(G.P_CENTER_POOLS["Content Set"]),
		minw = 5,
		minh = 1.7,
		scale = 0.6,
		id = "your_collection_jokers",
	})
	left_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
	right_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
	config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { left_settings, right_settings } }
	entr_nodes[#entr_nodes + 1] = config
	--Add warning notifications later for family mode
	entr_nodes[#entr_nodes + 1] = create_toggle({
		label = localize("k_entr_faster_ante_scaling"),
		active_colour = HEX("40c76d"),
		ref_table = Entropy.config,
		ref_value = "ante_scaling",
		callback = function()
        end,
	})
    entr_nodes[#entr_nodes + 1] = create_toggle({
		label = localize("k_entr_entropic_music"),
		active_colour = HEX("40c76d"),
		ref_table = Entropy.config,
		ref_value = "entropic_music",
		callback = function()
        end,
	})
    entr_nodes[#entr_nodes + 1] = create_toggle({
		label = localize("k_entr_blind_tokens"),
		active_colour = HEX("40c76d"),
		ref_table = Entropy.config,
		ref_value = "blind_tokens",
		callback = function()
        end,
	})
    entr_nodes[#entr_nodes + 1] = create_toggle({
		label = localize("k_entr_freebird"),
		active_colour = HEX("40c76d"),
		ref_table = Entropy.config,
		ref_value = "freebird",
		callback = function()
        end,
	})
	return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "cm",
			padding = 0.2,
			colour = G.C.BLACK,
		},
		nodes = entr_nodes,
	}
end

SMODS.current_mod.config_tab = entrConfigTab

Cryptid.pointerblistifytype("rarity", "entr_hyper_exotic")
Cryptid.pointerblistifytype("rarity", "entr_zenith")
Cryptid.pointerblistify("c_entr_define")
for i, v in pairs(G.P_BLINDS) do
    Cryptid.pointerblistify(i)
end

for i, v in pairs(SMODS.Blind.obj_table) do
    Cryptid.pointerblistify(i)
end
Entropy.GamesetAtlas = SMODS.Atlas({
	key = "gameset",
	path = "entr_gameset.png",
	px = 29,
	py = 29,
})
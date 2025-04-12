 
local i = {
    "lib/utils",
    "items/jokers",
    --"reverseTarots",
    "items/consumable",
    "items/reversePlanets",
    "items/reverseSpectrals",
    "items/reverseCodes",
    "items/reverseLegendaries",

    "lib/colours",
    "items/decks",
    "items/vouchers",
    "items/hidden",
    "lib/fixes",
    "items/stake",
    "items/tags",
    "items/editions",
    "items/seals",
    "compat/loader"
    --"glop"
}
Entropy = {}
for _, v in pairs(i) do
    local f, err = SMODS.load_file(v..".lua")
    if f then f() else error("error in file "..v..": "..err) end
end
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
            card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent)
            return true
        end
        if (key == 'asc') or (key == 'asc_mod') then
            local e = card_eval_status_text
            local orig = G.GAME.asc_power_hand or 0
            G.GAME.asc_power_hand = (G.GAME.asc_power_hand or 1) * scored_card.edition.sol
            G.GAME.current_round.current_hand.cry_asc_num_text = " (+" .. (G.GAME.current_round.current_hand.cry_asc_num * G.GAME.asc_power_hand) .. ")"
            card_eval_status_text = function() end
            scie(effect, scored_card, "Xmult_mod", to_big(Cryptid.ascend(1, G.GAME.asc_power_hand - orig)):to_number(), from_edition)
            card_eval_status_text = e

            card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "X"..scored_card.edition.sol.." Asc", G.C.GOLD, "talisman_emult")
            return true
        end
    end
    for _, v in ipairs({'eq_mult', 'Eqmult_mod', 'asc', 'asc_mod'}) do
        table.insert(SMODS.calculation_keys, v)
    end
end

function card_eval_status_text_eq(card, eval_type, amt, percent, dir, extra, pref, col, sound)
    percent = percent or (0.9 + 0.2*math.random())
    if dir == 'down' then 
        percent = 1-percent
    end

    if extra and extra.focus then card = extra.focus end

    local text = ''
    local sound = nil
    local volume = 1
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
G.C.Entropy.HYPER_EXOTIC = {
    G.C.RED,
    G.C.GOLD,
    G.C.GREEN,
    G.C.BLUE,
    G.C.PURPLE
}
G.C.Entropy.REVERSE_LEGENDARY = {
    [1] = HEX("ff00c4"),
    [2] = HEX("ff00c4"),
    [3] = HEX("FF00FF"),
    [4] = HEX("FF0000"),
    [5] = HEX("FF0000"),
}

G.C.Entropy.ZENITH = {
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

local loc_colour_ref = loc_colour

SMODS.Rarity({
	key = "hyper_exotic",
	loc_txt = {},
	badge_colour = HEX("FF0000"),
})
SMODS.Rarity({
	key = "reverse_legendary",
	loc_txt = {},
	badge_colour = HEX("FF0001"),
})
SMODS.Rarity({
	key = "zenith",
	loc_txt = {},
	badge_colour = HEX("FF0002"),
})
function loc_colour(_c, default)
    if not G.ARGS.LOC_COLOURS then
        loc_colour_ref(_c, default)
    elseif not G.ARGS.LOC_COLOURS.entr_colours then
        G.ARGS.LOC_COLOURS.entr_colours = true
        local new_colors = {
            entr_eqmult = G.C.Entropy.OTHERS.EqMult,
            entr_hyper_exotic = {2,2,2,2},
            entr_reverse_legendary = {3,3,3,3},
            entr_zenith = {4,4,4,4}
        }

        for k, v in pairs(new_colors) do
            G.ARGS.LOC_COLOURS[k] = v
        end
    end

    return loc_colour_ref(_c, default)
end

local upd = Game.update
local anim_timer2 = 0
entr_define_dt = 0
entr_ruby_dt = 0
function Game:update(dt)
    upd(self, dt)
    anim_timer2 = anim_timer2 + dt/2.0
	local anim_timer = math.floor(anim_timer2)
	local p = anim_timer2 - anim_timer
    G.C.ENTR_HYPER_EXOTIC = {0,0,0,0}
    G.C.ENTR_REVERSE_LEGENDARY = {0,0,0,0}
    G.C.ENTR_ZENITH = {0,0,0,0}
    local num = 5
    local num2 = 12
    if G.C.Entropy.HYPER_EXOTIC and G.C.Entropy.HYPER_EXOTIC[anim_timer%num+1] then
        local col1 = G.C.Entropy.HYPER_EXOTIC[anim_timer%num+1]
        local col2 = G.C.Entropy.HYPER_EXOTIC[(anim_timer+1)%num+1]
        for i = 1, 4 do     
            G.C.ENTR_HYPER_EXOTIC[i] = col1[i]*(1-p) + col2[i]* p
        end
        G.C.RARITY["entr_hyper_exotic"] = G.C.ENTR_HYPER_EXOTIC
    end
    if G.C.Entropy.REVERSE_LEGENDARY and G.C.Entropy.REVERSE_LEGENDARY[anim_timer%num+1] then
        local col12 = G.C.Entropy.REVERSE_LEGENDARY[anim_timer%num+1]
        local col22 = G.C.Entropy.REVERSE_LEGENDARY[(anim_timer+1)%num+1]
        if col22 then
            for i = 1, 4 do     
                G.C.ENTR_REVERSE_LEGENDARY[i] = col12[i]*(1-p) + col22[i]* p
            end
        end
        G.C.RARITY["entr_reverse_legendary"] = G.C.ENTR_REVERSE_LEGENDARY
    end
    if G.C.Entropy.ZENITH and G.C.Entropy.ZENITH[anim_timer%num2+1] then
        local col122 = G.C.Entropy.ZENITH[anim_timer%num2+1]
        local col222 = G.C.Entropy.ZENITH[(anim_timer+1)%num2+1]
        if col222 then
            for i = 1, 4 do     
                G.C.ENTR_ZENITH[i] = col122[i]*(1-p) + col222[i]* p
            end
        end
        G.C.RARITY["entr_zenith"] = G.C.ENTR_ZENITH
    end
    entr_define_dt = entr_define_dt + dt
    if G.P_CENTERS and G.P_CENTERS.c_entr_define and entr_define_dt > 0.5 then
		entr_define_dt = 0
		local pointerobj = G.P_CENTERS.c_entr_define
		pointerobj.pos.x = (pointerobj.pos.x == 4) and 5 or 4
	end

    entr_ruby_dt = entr_ruby_dt + dt
    if G.P_CENTERS and G.P_CENTERS.j_entr_ruby and entr_ruby_dt > 0.1 then
		entr_ruby_dt = 0
		local pointerobj = G.P_CENTERS.j_entr_ruby
		pointerobj.soul_pos.x = (pointerobj.soul_pos.x%12)+1
        if G.jokers then
            for i, v in pairs(G.jokers.cards) do
                if v.config.center.key == "j_entr_ruby" then
                    v.children.floating_sprite:remove()
                    v.children.floating_sprite = Sprite(
                        v.T.x,
                        v.T.y,
                        v.T.w * (v.no_ui and 1.1*1.2 or 1),
                        v.T.h * (v.no_ui and 1.1*1.2 or 1),
                        G.ASSET_ATLAS[v.config.center.atlas],
                        v.config.center.soul_pos
                    )
                end
            end
        end
	end
end

local card_hoverref = Card.draw

function Card:draw(layer)
    card_hoverref(self, layer)
    if self.config.h_popup and self.config and self.config.center and self.config.center.rarity == "entr_hyper_exotic" then self.config.h_popup.nodes[1].nodes[1].nodes[1].nodes[5].nodes[1].nodes[1].config.colour = G.C.RARITY["entr_hyper_exotic"] end
    if self.config.h_popup and self.config and self.config.center and self.config.center.rarity and self.config.center.rarity == "entr_zenith" then self.config.h_popup.nodes[1].nodes[1].nodes[1].nodes[5].nodes[1].nodes[1].config.colour = G.C.RARITY["entr_zenith"] end
    if self.config.h_popup and self.config and self.config.center and self.config.center.rarity == "entr_reverse_legendary" then self.config.h_popup.nodes[1].nodes[1].nodes[1].nodes[5].nodes[1].nodes[1].config.colour = G.C.RARITY["entr_reverse_legendary"] end
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
--ew
local textdrawref = DynaText.update
function DynaText:update() 
    --this is really disgusting
    if self.strings[self.focused_string].string == "Entropic " then
        self.colours[1] = G.C.RARITY["entr_hyper_exotic"]
    end
    if self.strings[self.focused_string].string == "Legendary? " then
        self.colours[1] = G.C.RARITY["entr_reverse_legendary"]
    end
    if self.strings[self.focused_string].string == "You may never lose." then
        self.colours[1] = G.C.RARITY["entr_zenith"]
    end
    textdrawref(self)
    --("(Current rarity:"):gsub(":", ""):find(localize("k_curr_rarity"))
end
--a modified version of how cryptid does this for gateway because theres otherwise no way to get it to pulsate


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
			G.P_CENTERS.c_entr_beyond,
			{ bypass_discovery_center = true }
		)
        if #G.title_top.cards > 2 then
            for i, v in pairs(G.title_top.cards) do
                if v.config.center.key == "c_cryptid" then v:start_dissolve() end
            end
        else
            G.title_top.T.w = G.title_top.T.w * 1.7675
            G.title_top.T.x = G.title_top.T.x - 0.8
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




local start_ref = Game.start_run

function Game:start_run(args)
    start_ref(self, args)
    --G.GAME.RootKit = nil
    --G.GAME.USING_BREAK = nil
    --G.GAME.Overflow = nil
    --G.GAME.DefineKeys = {}
    --G.GAME.Marked = nil
    --G.GAME.TrumpCard = nil
    --G.GAME.Supercede = nil
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
					if x[1] ~= y[1] then
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
Entropy.config = SMODS.current_mod.config
local entrConfigTab = function()
	entr_nodes = {
	}
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


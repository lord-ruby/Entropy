
SMODS.Atlas { key = 'exotic_jokers', path = 'exotic_jokers.png', px = 71, py = 95 }
SMODS.Atlas { key = 'jokers', path = 'jokers.png', px = 71, py = 95 }

SMODS.Joker({
    key = "stillicidium",
    rarity = "cry_exotic",
    cost = 50,
    atlas = "exotic_jokers",
    soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    --pos = { x = 0, y = 0 },
    --atlas = "jokers",
    loc_vars = function(self, info_queue, card)

    end,
    calculate = function (self, card, context)
        if context.ending_shop or context.forcetrigger then
                local afterS = false
                for i, v in pairs(G.jokers.cards) do
                    if (v.config.center_key ~= "j_entr_stillicidium" or context.forcetrigger) and i > GetAreaIndex(G.jokers.cards, card) 
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
                                G.jokers:remove_from_highlighted(v2, true)
                                local edition = v.edition
                                local sticker = v.sticker
                                v2 = create_card("Joker", G.jokers, nil, nil, nil, nil, key) 
                                v2:set_card_area(G.jokers)
                                v2:set_edition(edition)
                                v2:add_to_deck()
                                v2.sticker = sticker
                                G.jokers.cards[i] = v2
                            end
                            return true
                        end
                        }))
                    end
                end

                for i, v in pairs(G.consumeables.cards) do
                    if v.config.center_key ~= "j_entr_stillicidium" then
                        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                            --local c = create_card("Joker", G.jokers, nil, nil, nil, nil, key) 
                            --c:add_to_deck()    
                            --G.jokers:emplace(c)
                            --v:start_dissolve()
                            local v2 = G.consumeables.cards[i]
                            v2.highlighted = false
                            if G.P_CENTER_POOLS[v2.config.center.set] and G.P_CENTER_POOLS[v2.config.center.set][ReductionIndex(v2, v2.config.center.set)-1] then
                                key = G.P_CENTER_POOLS[v2.config.center.set][ReductionIndex(v2, v2.config.center.set)-1].key
                                --local c = create_card("Joker", G.jokers, nil, nil, nil, nil, key) 
                                --c:add_to_deck()    
                                v2:start_dissolve()
                                v2 = create_card(v.config.center.set, G.jokers, nil, nil, nil, nil, key) 
                                v2:add_to_deck()
                                v2:set_card_area(G.consumeables)
                                G.consumeables.cards[i] = v2
                            end
                            return true
                        end
                        }))
                    end
                end
        end
        if context.individual and 
            context.cardarea == G.play and context.other_card 
            then
                local card = context.other_card 
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                    card:juice_up(0.3, 0.3)
                    SMODS.change_base(card, card.base.suit, LowerCardRank(card))
                return true end }))
        end
        if (context.setting_blind and not context.blueprint and not card.getting_sliced) or context.forcetrigger then
			card.gone = false
			G.GAME.blind.chips = G.GAME.blind.chips * 0.6
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.HUD_blind:recalculate()
		end
    end
})

function ReductionIndex(card, pool)
    index = 0
    for i, v in pairs(G.P_CENTER_POOLS[pool]) do
        if card.config and v.key == card.config.center_key then
            return i
        end
        i = i + 1
    end
end
function LowerCardRank(card)
	if not card.base then return nil end
	local rank_suffix = math.min(card.base.id, 14)
	if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
	elseif rank_suffix == 10 then rank_suffix = '10'
	elseif rank_suffix == 11 then rank_suffix = 'Jack'
	elseif rank_suffix == 12 then rank_suffix = 'Queen'
	elseif rank_suffix == 13 then rank_suffix = 'King'
	elseif rank_suffix == 14 then rank_suffix = 'Ace'
	end
	return ({
		ruby_13 = "Ace",
		Ace = "King",
		King = "Queen",
		Queen = "Jack",
		Jack = "10",
		["10"] = "9",
		["9"] = "8",
		["8"] = "7",
		["7"] = "6",
		["6"] = "5",
		["5"] = "4",
		["4"] = "3",
		["3"] = "2",
		["2"] = "Ace",
	})[tostring(rank_suffix)]
end
function GetAreaIndex(cards, card)
    for i, v in pairs(cards) do
        if v.config.center_key == card.config.center_key and v.unique_val == card.unique_val then return i end
    end
    return -1
end

SMODS.Joker({
    key = "surreal_joker",
    config = {
        qmult = 4
    },
    rarity = 1,
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                " "..card.ability.qmult
            },
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            G.GAME.current_round.current_hand.mult = card.ability.qmult
            update_hand_text({delay = 0}, {chips = G.GAME.current_round.current_hand.chips and hand_chips, mult = card.ability.qmult})
            return {
                Eqmult_mod = card.ability.qmult
            }
        end
    end
})


SMODS.Joker({
    key = "acellero",
    config = {
        extra = 1.1,
        exp_mod = 0.05
    },
    rarity = "entr_hyper_exotic",
    cost = 150,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 1 },
    soul_pos = { x = 2, y = 1, extra = { x = 1, y = 1 } },
    atlas = "exotic_jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra,
                card.ability.exp_mod
            },
        }
    end,
    calculate = function (self, card, context)
        if (context.ending_shop and not context.blueprint and not context.retrigger_joker) or context.forcetrigger then
            for i, v in pairs(G.jokers.cards) do
                local check = false
                local exp = card.ability.extra
			    --local card = G.jokers.cards[i]
                if not Card.no(G.jokers.cards[i], "immutable", true) and (G.jokers.cards[i].config.center.key ~= "j_entr_acellero" or context.forcetrigger) then
                    Cryptid.with_deck_effects(v, function(card2)
                        Cryptid.misprintize(card2, { min=exp,max=exp }, nil, true, "^", 1)
                    end)
                    check = true
                end
			    if check then
				    card_eval_status_text(
					context.blueprint_card or G.jokers.cards[i],
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				    )
                end
            end
            card.ability.extra = card.ability.extra + card.ability.exp_mod
        end
    end
})
--Cryptid.big_num_whitelist["j_entr_acellero"] = true
Cryptid.big_num_blacklist["j_hiker"] = true
Cryptid.big_num_blacklist["j_credit_card"] = true
Cryptid.big_num_blacklist["j_selzer"] = true
Cryptid.big_num_blacklist["j_hanging_chad"] = true
Cryptid.big_num_blacklist["j_cry_chad"] = true
Cryptid.big_num_blacklist["j_cry_tenebris"] = true
Cryptid.big_num_blacklist["j_entr_yorick"] = true
Cryptid.big_num_blacklist["j_burglar"] = true
Cryptid.big_num_blacklist["j_entr_tesseract"] = true

SMODS.Joker({
    key = "helios",
    rarity = "entr_hyper_exotic",
    cost = 150,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 2 },
    config = {
        extra = 1.1
    },
    soul_pos = { x = 2, y = 2, extra = { x = 1, y = 2 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                1.75 + ((G.GAME.sunnumber or 0)),
                (card.ability.extra or 1.1) + 0.4
            },
        }
    end,
    add_to_deck = function()
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + 99
        G.GAME.HyperspaceActuallyUsed = G.GAME.used_vouchers.v_cry_hyperspacetether
        G.GAME.used_vouchers.v_cry_hyperspacetether = true
    end,
    remove_from_deck = function()
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - 99
        G.GAME.used_vouchers.v_cry_hyperspacetether = G.GAME.HyperspaceActuallyUsed
    end
})

function Cryptid.ascend(num, curr2) -- edit this function at your leisure
    curr2 = curr2 or ((G.GAME.current_round.current_hand.cry_asc_num or 0) + (G.GAME.asc_power_hand or 0)) * (1+(G.GAME.nemesisnumber or 0))
    if G.GAME.blind.config.blind.key == "bl_entr_scarlet_sun" then
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
		return num
				* (
					1
					+ 0.1
					+ to_big(0.05 * (G.GAME.sunnumber or 0))
					+ to_big(
						(0.1 + (0.05 * (G.GAME.sunnumber or 0)))
							* to_big(curr2)
					)
				)
	elseif HasJoker("j_entr_helios") then
        local curr = 1.5
        for i, v in pairs(G.jokers.cards) do
            if v.config.center.key == "j_entr_helios" and to_big(v.ability.extra):gt(curr) then curr = v.ability.extra+0.4 end
        end
		return num
				* to_big(
					(1.75 + ((G.GAME.sunnumber or 0)))):tetrate(
						to_big((curr2) * curr))
    else
		return num
				* to_big(
					(1.25 + ((G.GAME.sunnumber or 0)))
						^ to_big(curr2)
				)
	end
end

local pokerhandinforef = G.FUNCS.get_poker_hand_info
function G.FUNCS.get_poker_hand_info(_cards)
    if HasJoker("j_entr_helios") or G.GAME.blind.config.blind.key == "bl_entr_scarlet_sun" then G.GAME.used_vouchers.v_cry_hyperspacetether = true end
    local text, loc_disp_text, poker_hands, scoring_hand, disp_text = pokerhandinforef(_cards)
    
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

SMODS.Joker({
    key = "xekanos",
    rarity = "entr_hyper_exotic",
    cost = 150,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 3 },
    config = {
        ante_mod = 1.5,
        ante_mod_mod = 0.1
    },
    immutable = true,
    demicoloncompat = true,
    soul_pos = { x = 2, y = 3, extra = { x = 1, y = 3 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.ante_mod > 0 and "-"..card.ability.ante_mod or 1,
                card.ability.ante_mod > 0 and card.ability.ante_mod_mod or 0
            },
        }
    end,
    calculate = function(self, card, context)
        if (context.selling_card and not context.retrigger_joker) or context.forcetrigger then
            if not context.card then
                card.ability.ante_mod_mod = card.ability.ante_mod_mod * 0.5
            elseif context.card.ability.set == "Joker" and Entropy.RarityAbove("3",context.card.config.center.rarity,true) then
                card.ability.ante_mod_mod = card.ability.ante_mod_mod * 0.5
            end
        end
    end
})

SMODS.Joker({
    key = "ieros",
    rarity = "entr_hyper_exotic",
    cost = 150,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 4 },
    config = {
        e_chips = 1
    },
    demicoloncompat = true,
    soul_pos = { x = 2, y = 4, extra = { x = 1, y = 4 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.e_chips
            },
        }
    end,
    calculate = function(self, card, context)
        if context.buying_card and not context.retrigger_joker then
			if context.card.ability.set == "Joker" then
                card.ability.e_chips = card.ability.e_chips + (Entropy.ReverseRarityChecks[context.card.config.center.rarity] or 0)/20.0
                return {
                    message = "Upgraded",
                }
            end
        end
        if context.forcetrigger then
            card.ability.e_chips = card.ability.e_chips + (Entropy.ReverseRarityChecks[1] or 0)/20.0
        end
        if context.joker_main or context.forcetrigger then
            return {
				EEchip_mod = card.ability.e_chips,
				message =  '^^' .. number_format(card.ability.e_chips) .. ' Chips',
				colour = { 0.8, 0.45, 0.85, 1 },
			}
        end
    end
})

function create_card_for_shop(area)
    if area == G.shop_jokers and G.SETTINGS.tutorial_progress and G.SETTINGS.tutorial_progress.forced_shop and G.SETTINGS.tutorial_progress.forced_shop[#G.SETTINGS.tutorial_progress.forced_shop] then
      local t = G.SETTINGS.tutorial_progress.forced_shop
local card = create_card(v.type, area, nil, nil, nil, nil, nil, 'sho')      local _center = G.P_CENTERS[t[#t]] or G.P_CENTERS.c_empress
      local card = Card(area.T.x + area.T.w/2, area.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, _center, {bypass_discovery_center = true, bypass_discovery_ui = true})
      t[#t] = nil
      if not t[1] then G.SETTINGS.tutorial_progress.forced_shop = nil end
      
      create_shop_card_ui(card)
      return card
    else
      local forced_tag = nil
      for k, v in ipairs(G.GAME.tags) do
        if not forced_tag then
          forced_tag = v:apply_to_run({type = 'store_joker_create', area = area})
          if forced_tag then
            for kk, vv in ipairs(G.GAME.tags) do
              if vv:apply_to_run({type = 'store_joker_modify', card = forced_tag}) then break end
            end
            return forced_tag end
        end
      end
        G.GAME.spectral_rate = G.GAME.spectral_rate or 0
        local total_rate = (G.GAME.joker_rate + G.GAME.playing_card_rate) or 0
        for _,v in ipairs(SMODS.ConsumableType.ctype_buffer) do
            if not (v:lower() == 'tarot' or v:lower() == 'planet') then
                total_rate = total_rate + (G.GAME[v:lower()..'_rate'] or 0)
            else
                total_rate = total_rate + ((G.GAME[v:lower()..'_rate'] or 0) * (G.GAME.cry_percrate[v:lower()]/100) )
            end
        end
        local polled_rate = pseudorandom(pseudoseed('cdt'..G.GAME.round_resets.ante))*total_rate
        local check_rate = 0
        -- need to preserve order to leave RNG unchanged
        local rates = {
          {type = 'Joker', val = G.GAME.joker_rate},
          {type = 'Tarot', val = G.GAME.tarot_rate*(G.GAME.cry_percrate.tarot/100)},
          {type = 'Planet', val = G.GAME.planet_rate*(G.GAME.cry_percrate.planet/100)},
          {type = (G.GAME.used_vouchers["v_illusion"] and pseudorandom(pseudoseed('illusion')) > 0.6) and 'Enhanced' or 'Base', val = G.GAME.playing_card_rate},
          {type = 'Spectral', val = G.GAME.spectral_rate},
        }
        for _, v in ipairs(SMODS.ConsumableType.ctype_buffer) do
            if not (v == 'Tarot' or v == 'Planet' or v == 'Spectral') then
                table.insert(rates, { type = v, val = G.GAME[v:lower()..'_rate'] })
            end
        end
        for _, v in ipairs(rates) do
          if polled_rate > check_rate and polled_rate <= check_rate + v.val then
            local card = create_card(v.type, area, nil, nil, nil, nil, nil, 'sho')
            for i, v2 in pairs(G.jokers.cards) do
                if v2.config.center.key == "j_entr_ieros" then
                    while v.type == "Joker" and pseudorandom("ieros") < 0.33 do
                        card:start_dissolve()
                        local rare = nil
                        if card.config.center.rarity ~= "j_entr_hyper_exotic" then
                            rare = Entropy.RarityUppers[card.config.center.rarity or 1] or card.config.center.rarity
                        end
                        if rare == 1 then rare = "Common" end
                        if rare == 2 then rare = "Uncommon" end
                        if rare == 4 then
                            card = create_card("Joker", G.jokers, true, 4, nil, nil, nil, 'sho')
                        else 
                            card = create_card("Joker", G.jokers, nil, rare, nil, nil, nil, 'sho')
                        end
                        v2:juice_up(0.3, 0.3)
                    end
                end
            end
            create_shop_card_ui(card, v.type, area)
            G.E_MANAGER:add_event(Event({
                func = (function()
                    for k, v in ipairs(G.GAME.tags) do
                      if v:apply_to_run({type = 'store_joker_modify', card = card}) then break end
                    end
                    return true
                end)
            }))
            if (v.type == 'Base' or v.type == 'Enhanced') and G.GAME.used_vouchers["v_illusion"] and pseudorandom(pseudoseed('illusion')) > 0.8 then 
              local edition_poll = pseudorandom(pseudoseed('illusion'))
              local edition = {}
              if edition_poll > 1 - 0.15 then edition.polychrome = true
              elseif edition_poll > 0.5 then edition.holo = true
              else edition.foil = true
              end
              card:set_edition(edition)
            end
            return card
          end
          check_rate = check_rate + v.val
        end
    end
end


SMODS.Joker({
    key = "dekatria",
    rarity = "entr_hyper_exotic",
    cost = 150,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 5 },
    config = {
        mult=13,
        immutable = {
            arrows = -2
        },
        pairs_needed = 8,
        pairs_current = 0
    },
    demicoloncompat = true,
    soul_pos = { x = 2, y = 5, extra = { x = 1, y = 5 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, q, card)
        if not card.edition or card.edition.key ~= "e_cry_m" then q[#q+1]=G.P_CENTERS.e_cry_m end
        return {
            vars = {
                Entropy.FormatArrowMult(card.ability.immutable.arrows, card.ability.mult),
                card.ability.pairs_needed,
                card.ability.pairs_current
            },
        }
    end,
    add_to_deck = function()
        for i, v in pairs(G.I.CARD) do
            if v.set_edition then
                if v.config.center.key ~= "j_entr_dekatria" then
                    v:set_edition("e_cry_m")
                end
            end
        end
    end,
    calculate = function(self, card, context)
        if (context.after and not context.repetition and not context.blueprint) or context.forcetrigger then
            local pairs = 0
            for i = 1, #G.play.cards - 1 do
                for j = i + 1, #G.play.cards do
                    local m, n = G.play.cards[i], G.play.cards[j]
                    if m:get_id() == n:get_id() then
                        pairs = pairs + 1
                    end
                end
            end
            card.ability.pairs_current = card.ability.pairs_current + pairs
            while card.ability.pairs_current >= card.ability.pairs_needed do
                card.ability.pairs_current = card.ability.pairs_current - card.ability.pairs_needed
                card.ability.pairs_needed = card.ability.pairs_needed * 2
                card.ability.immutable.arrows = card.ability.immutable.arrows + 1
            end
        end
        if context.joker_main or context.forcetrigger then
            if to_big(card.ability.immutable.arrows) < to_big(-1) then
                return {
                    Eqmult_mod=card.ability.mult,
                }
            elseif to_big(card.ability.immutable.arrows) < to_big(0) then
                    return {
                        mult_mod=card.ability.mult,
                        message = Entropy.FormatArrowMult(card.ability.immutable.arrows, card.ability.mult) .. ' Mult',
                        colour = G.C.RED,
                    }
            elseif to_big(card.ability.immutable.arrows) < to_big(1) then
                return {
                    Xmult_mod=card.ability.mult,
                    message = Entropy.FormatArrowMult(card.ability.immutable.arrows, card.ability.mult) .. ' Mult',
                    colour = G.C.RED,
                }
            end
            return {
				hypermult_mod = {
                    card.ability.immutable.arrows,
                    card.ability.mult
                },
				message =   Entropy.FormatArrowMult(card.ability.immutable.arrows, card.ability.mult) .. ' Mult',
				colour = { 0.8, 0.45, 0.85, 1 },
			}
        end
    end
})

SMODS.Joker({
    key = "tesseract",
    config = {
        degrees = 90
    },
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 1, y = 0 },
    atlas = "jokers",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.degrees)
            },
        }
    end,
})

local ref = update_hand_text

function update_hand_text(config, vals)
    if type(vals.mult) == "number" or type(vals.mult) == "table" and HasJoker("j_entr_tesseract") and math.abs(to_big(vals.mult)) > to_big(0.001) then
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
    if type(vals.chips) == "number" or type(vals.chips) == "table" and HasJoker("j_entr_tesseract") and math.abs(to_big(vals.chips)) > to_big(0.001) then
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

SMODS.Joker({
    key = "solarflare",
    name="entr-solarflare",
    config = {
        asc=1.6
    },
    rarity = 2,
    cost = 2,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 2, y = 0 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        if not center.edition or (center.edition and not center.edition.sol) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_solar
		end
        return {
            vars = {
                number_format(center.ability.asc)
            },
        }
    end,
    calculate = function(self, card, context)
		if
			(context.other_joker
			and context.other_joker.edition
			and context.other_joker.edition.sol
			and card ~= context.other_joker)
		then
			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			return {
				asc = lenient_bignum(card.ability.asc),
			}
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card.edition.sol then
				return {
					asc = lenient_bignum(card.ability.asc),
					colour = G.C.MULT,
					card = card,
				}
			end
		end
		if
			(context.individual
			and context.cardarea == G.hand
			and context.other_card.edition
			and context.other_card.edition.sol
			and not context.end_of_round)
		then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
					card = card,
				}
			else
				return {
					asc = lenient_bignum(card.ability.asc),
					card = card,
				}
			end
		end
        if context.forcetrigger then
            return {
                asc = lenient_bignum(card.ability.asc),
                card = card,
            }
        end
	end
})

local create_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local card = create_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if card and card.ability and card.ability.name == "entr-solarflare" then
		card:set_edition("e_entr_solar", true, nil, true)
	end
    return card
end

SMODS.Joker({
    key = "burnt_m",
    config = {
        per_jolly=1
    },
    rarity = "cry_epic",
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 0 },
    atlas = "jokers",
    pools = { ["M"] = true },
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        if not center.edition or (center.edition and not center.edition.sol) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_solar
		end
        info_queue[#info_queue+1] = G.P_CENTERS.j_jolly
        return {
            vars = {
                center.config.per_jolly
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            if next(poker_hands["Pair"]) then
                G.play.cards[1]:set_edition("e_entr_solar")
                local jollycount = 0
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i]:is_jolly() then
                        jollycount = jollycount + 1
                    end
                end
                if jollycount > 0 then
                    for i = 2, 2+jollycount do
                        if G.play.cards[i] then G.play.cards[i]:set_edition("e_entr_solar") end
                    end
                end
            end
        end
        if context.forcetrigger then
            G.play.cards[1]:set_edition("e_entr_solar")
            local jollycount = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i]:is_jolly() then
                    jollycount = jollycount + 1
                end
            end
            if jollycount > 0 then
                for i = 2, 2+jollycount do
                    if G.play.cards[i] then G.play.cards[i]:set_edition("e_entr_solar") end
                end
            end
        end
	end
})

SMODS.Joker({
    key = "anaptyxi",
    rarity = "entr_hyper_exotic",
    cost = 150,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 6 },
    config = {
        scale_mult=2,
        scale_mult_mod=1
    },
    demicoloncompat = true,
    soul_pos = { x = 2, y = 6, extra = { x = 1, y = 6 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.scale_mult),
                number_format(card.ability.scale_mult_mod)
            },
        }
    end,
    calculate = function(self, card, context)
        if (context.end_of_round and not context.individual and not context.repetition and not context.blueprint) or context.forcetrigger then
            card.ability.scale_mult = card.ability.scale_mult + card.ability.scale_mult_mod
            return {
				message = localize("k_upgrade_ex"),
				colour = G.C.DARK_EDITION,
			}
        end
    end,
	cry_scale_mod = function(self, card, joker, orig_scale_scale, true_base, orig_scale_base, new_scale_base)
        local new_scale = lenient_bignum(
            to_big(true_base)
                * (
                    (
                        1
                        + (
                            (to_big(orig_scale_scale) / to_big(true_base))
                            ^ (to_big(1) / to_big(2))
                        )
                    ) ^ to_big(2)
                )
        )
        if not Cryptid.is_card_big(joker) and to_big(new_scale) >= to_big(1e300) then
            new_scale = 1e300
        end
        if joker.config.center.key == "j_entr_anaptyxi" then return true_base end
        for i, v in pairs(G.jokers.cards) do
            if (v ~= joker and v.config.center.key ~= "j_entr_anaptyxi") then
                    if not Card.no(v, "immutable", true) then
                    Cryptid.with_deck_effects(v, function(card2)
                        Cryptid.misprintize(card2, { min = card.ability.scale_mult*new_scale, max = card.ability.scale_mult*new_scale}, nil, true, "+")
                    end)
                    card_eval_status_text(
                        v,
                        "extra",
                        nil,
                        nil,
                        nil,
                        { message = "+ "..number_format(card.ability.scale_mult*new_scale) })
                    end
            end
        end
		return new_scale
	end,
})  


SMODS.Joker({
    key = "chaos",
    rarity = "cry_epic",
    cost = 15,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    pos = { x = 0, y = 1 },
    atlas = "jokers",
    loc_vars = function(self, info_queue, center)
    end,
})

Entropy.ChaosBlacklist = {
    --Enhanced = true,
    Back = true,
    --Default = true,
    --Edition = true,
    Sleeve = true
    ["Content Set"] = true,

}
Entropy.ChaosConversions = {
    RCode = "Twisted",
    RPlanet = "Twisted",
    RSpectral = "Twisted"
}
local ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if next(find_joker("j_entr_chaos")) and not forced_key then
        local center = pseudorandom_element(G.P_CENTERS, pseudoseed("chaos"))
        while not center.set or Entropy.ChaosBlacklist[center.set] do
            center = pseudorandom_element(G.P_CENTERS, pseudoseed("chaos"))
        end
        _type = Entropy.ChaosConversions[center.set] or center.set or _type
    end
    return ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
end
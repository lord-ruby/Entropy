SMODS.Blind({
	name = "entr-scarlet-sun",
	key = "scarlet_sun",
	pos = { x = 0, y = 1 },
	atlas = "blinds",
	boss_colour = HEX("FF0000"),
    mult=2,
    dollars = 8,
	boss = {
		min = 3,
		max = 10,
		showdown = true,
	}
})

SMODS.Blind({
	key = "burgundy_baracuda",
	pos = { x = 0, y = 2 },
	atlas = "blinds",
	boss_colour = HEX("FF0000"),
    mult=3,
    dollars = 8,
	boss = {
		min = 3,
		max = 10,
		showdown = true,
	},
	calculate = function(self, blind, context)
			if
				context.destroy_card
				and (context.cardarea == G.play or context.cardarea == "unscored")
				and not G.GAME.blind.disabled
				and pseudorandom("baracuda") < 0.5
			then
				return {remove=true}
			end
	end
})

SMODS.Blind({
	key = "diamond_dawn",
	pos = { x = 0, y = 3 },
	atlas = "blinds",
	boss_colour = HEX("00d5ff"),
    mult=3,
    dollars = 8,
	boss = {
		min = 3,
		max = 10,
		showdown = true,
	},
	config = {
		extra = {
			hand_size = -2
		}
	},
	calculate = function(self, blind, context)
		if context.pre_discard and not G.GAME.blind.disabled then
			Entropy.FlipThen(G.hand.highlighted, function(card, area)
				SMODS.change_base(card, "entr_nilsuit", "entr_nilrank")
			end)
		end
	end,
	set_blind = function(self)
        if not G.GAME.blind.disabled then G.hand:change_size(self.config.extra.hand_size) end
	end,
	defeat = function(self)
        if not G.GAME.blind.disabled then G.hand:change_size(-self.config.extra.hand_size) end
    end,
    disable = function(self)
        G.hand:change_size(-self.config.extra.hand_size)
        G.FUNCS.draw_from_deck_to_hand(-self.config.extra.hand_size)
    end
})

SMODS.Blind({
	key = "olive_orchard",
	pos = { x = 0, y = 4 },
	atlas = "blinds",
	boss_colour = HEX("55ae29"),
    mult=3,
    dollars = 8,
	boss = {
		min = 3,
		max = 10,
		showdown = true,
	},
	calculate = function(self, blind, context)
		if context.pre_discard and not G.GAME.blind.disabled then
			Entropy.FlipThen(G.hand.cards, function(card, area)
				if not card.highlighted then
					card:set_ability(G.P_CENTERS.m_entr_disavowed)
				end
			end)
		end
		if context.final_scoring_step and not G.GAME.blind.disabled then
			Entropy.FlipThen(G.hand.cards, function(card, area)
				card:set_ability(G.P_CENTERS.m_entr_disavowed)
			end)
		end
	end,
})

SMODS.Blind({
	key = "citrine_comet",
	pos = { x = 0, y = 5 },
	atlas = "blinds",
	boss_colour = HEX("ffee00"),
    mult=3,
    dollars = 8,
	boss = {
		min = 3,
		max = 10,
		showdown = true,
	},
	calculate = function(self, blind, context)
		if context.check then 
			for i, v in pairs(G.hand.cards) do if not v.highlighted then v.destroy_adjacent = false;v.destroyed_adjacent = false end end
			for i, v in pairs(G.hand.highlighted) do
				v.destroy_adjacent = true
			end
			for i, v in pairs(G.hand.cards) do
				if v.destroy_adjacent and not v.destroyed_adjacent then
					if G.hand.cards[i-1] then
						G.hand.cards[i-1]:start_dissolve()
						G.hand.cards[i-1].ability.temporary2 = true
					end
					if G.hand.cards[i+1] then
						G.hand.cards[i+1]:start_dissolve()
						G.hand.cards[i+1].ability.temporary2 = true
					end
					v.destroy_adjacent = false
					v.destroyed_adjacent = true
				end
			end
		end
	end,
})
Entropy.EEBlacklist = {
	bl_cry_obsidian_orb=true,
	bl_entr_endless_entropy_phase_one=true,
	bl_entr_endless_entropy_phase_two=true,
	bl_entr_endless_entropy_phase_three=true,
	bl_entr_endless_entropy_phase_four=true,
	bl_cry_lavender_loop=true
}
SMODS.Blind({
	key = "endless_entropy_phase_one",
	pos = { x = 0, y = 6 },
	atlas = "blinds",
	boss_colour = HEX("6d1414"),
    mult=3,
	no_ee = true,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	in_pool = function() return false end,
	next_phase = "bl_entr_endless_entropy_phase_two",
	calculate = function(self, blind, context)
		if to_big(G.GAME.chips) > to_big(G.GAME.blind.chips) then
			G.GAME.chips = 0
			G.GAME.blind:set_blind(G.P_BLINDS[self.next_phase])
			G.GAME.blind.chips = to_big(G.GAME.blind.chips) ^ 2
			G.GAME.blind:juice_up()
			ease_hands_played(G.GAME.round_resets.hands-G.GAME.current_round.hands_left)
		end
	end,
})

SMODS.Blind({
	key = "endless_entropy_phase_two",
	pos = { x = 0, y = 8 },
	atlas = "blinds",
	boss_colour = HEX("6d1414"),
    mult=3e10,
	no_ee = true,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	in_pool = function() return false end,
	next_phase = "bl_entr_endless_entropy_phase_three",
	calculate = function(self, blind, context)
		if to_big(G.GAME.chips) > to_big(G.GAME.blind.chips) then
			G.GAME.chips = 0
			G.GAME.blind:set_blind(G.P_BLINDS[self.next_phase])
			G.GAME.blind.chips = to_big(G.GAME.blind.chips) ^ 2
			G.GAME.blind:juice_up()
			ease_hands_played(G.GAME.round_resets.hands-G.GAME.current_round.hands_left)
		end
	end,
})

SMODS.Blind({
	key = "endless_entropy_phase_three",
	pos = { x = 0, y = 7 },
	atlas = "blinds",
	boss_colour = HEX("6d1414"),
    mult=3e50,
	no_ee = true,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	in_pool = function() return false end,
	next_phase = "bl_entr_endless_entropy_phase_four",
	calculate = function(self, blind, context)
		if to_big(G.GAME.chips) > to_big(G.GAME.blind.chips) then
			G.GAME.chips = 0
			G.GAME.blind:set_blind(G.P_BLINDS[self.next_phase])
			G.GAME.blind.chips = to_big(G.GAME.blind.chips) ^ 2
			G.GAME.blind:juice_up()
			ease_hands_played(G.GAME.round_resets.hands-G.GAME.current_round.hands_left)
		end
	end,
})

SMODS.Blind({
	key = "endless_entropy_phase_four",
	pos = { x = 0, y = 9 },
	atlas = "blinds",
	boss_colour = HEX("6d1414"),
    mult=3e100,
	no_ee = true,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	in_pool = function() return false end,
	set_blind = function(self, reset, silent)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.set_blind then
				s:set_blind(reset, silent)
			end
			if s.name == "The Eye" and not reset then
				G.GAME.blind.hands = {
					["Flush Five"] = false,
					["Flush House"] = false,
					["Five of a Kind"] = false,
					["Straight Flush"] = false,
					["Four of a Kind"] = false,
					["Full House"] = false,
					["Flush"] = false,
					["Straight"] = false,
					["Three of a Kind"] = false,
					["Two Pair"] = false,
					["Pair"] = false,
					["High Card"] = false,
				}
			end
			if s.name == "The Mouth" and not reset then
				G.GAME.blind.only_hand = false
			end
			if s.name == "The Fish" and not reset then
				G.GAME.blind.prepped = nil
			end
			if s.name == "The Water" and not reset then
				G.GAME.blind.discards_sub = G.GAME.current_round.discards_left
				ease_discard(-G.GAME.blind.discards_sub)
			end
			if s.name == "The Needle" and not reset then
				G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
				ease_hands_played(-G.GAME.blind.hands_sub)
			end
			if s.name == "The Manacle" and not reset then
				G.hand:change_size(-1)
			end
			if s.name == "Amber Acorn" and not reset and #G.jokers.cards > 0 then
				G.jokers:unhighlight_all()
				for k, v in ipairs(G.jokers.cards) do
					v:flip()
				end
				if #G.jokers.cards > 1 then
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.2,
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									G.jokers:shuffle("aajk")
									play_sound("cardSlide1", 0.85)
									return true
								end,
							}))
							delay(0.15)
							G.E_MANAGER:add_event(Event({
								func = function()
									G.jokers:shuffle("aajk")
									play_sound("cardSlide1", 1.15)
									return true
								end,
							}))
							delay(0.15)
							G.E_MANAGER:add_event(Event({
								func = function()
									G.jokers:shuffle("aajk")
									play_sound("cardSlide1", 1)
									return true
								end,
							}))
							delay(0.5)
							return true
						end,
					}))
				end
			end

			--add new debuffs
			for _, v in ipairs(G.playing_cards) do
				self:debuff_card(v)
			end
			for _, v in ipairs(G.jokers.cards) do
				if not reset then
					self:debuff_card(v, true)
				end
			end
		end
	end,
	defeat = function(self, silent)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			if G.P_BLINDS[k].defeat then
				G.P_BLINDS[k]:defeat(silent)
			end
			if G.P_BLINDS[k].name == "The Manacle" and not self.disabled then
				G.hand:change_size(1)
			end
		end
	end,
	press_play = function(self)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.press_play then
				s:press_play()
			end
			if s.name == "The Hook" then
				G.E_MANAGER:add_event(Event({
					func = function()
						local any_selected = nil
						local _cards = {}
						for k, v in ipairs(G.hand.cards) do
							_cards[#_cards + 1] = v
						end
						for i = 1, 2 do
							if G.hand.cards[i] then
								local selected_card, card_key = pseudorandom_element(_cards, pseudoseed("ObsidianOrb"))
								G.hand:add_to_highlighted(selected_card, true)
								table.remove(_cards, card_key)
								any_selected = true
								play_sound("card1", 1)
							end
						end
						if any_selected then
							G.FUNCS.discard_cards_from_highlighted(nil, true)
						end
						return true
					end,
				}))
				G.GAME.blind.triggered = true
				delay(0.7)
			end
			if s.name == "Crimson Heart" then
				if G.jokers.cards[1] then
					G.GAME.blind.triggered = true
					G.GAME.blind.prepped = true
				end
			end
			if s.name == "The Fish" then
				G.GAME.blind.prepped = true
			end
			if s.name == "The Tooth" then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						for i = 1, #G.play.cards do
							G.E_MANAGER:add_event(Event({
								func = function()
									G.play.cards[i]:juice_up()
									return true
								end,
							}))
							ease_dollars(-1)
							delay(0.23)
						end
						return true
					end,
				}))
				G.GAME.blind.triggered = true
			end
		end
	end,
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		local new_mult = mult
		local new_chips = hand_chips
		local trigger = false
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.modify_hand then
				local this_trigger = false
				new_mult, new_chips, this_trigger = s:modify_hand(cards, poker_hands, text, new_mult, new_chips)
				trigger = trigger or this_trigger
			end
			if s.name == "The Flint" then
				G.GAME.blind.triggered = true
				new_mult = math.max(math.floor(new_mult * 0.5 + 0.5), 1)
				new_chips = math.max(math.floor(new_chips * 0.5 + 0.5), 0)
				trigger = true
			end
		end
		return new_mult or mult, new_chips or hand_chips, trigger
	end,
	debuff_hand = function(self, cards, hand, handname, check)
		G.GAME.blind.debuff_boss = nil
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.debuff_hand and s:debuff_hand(cards, hand, handname, check) then
				G.GAME.blind.debuff_boss = s
				return true
			end
			if s.debuff then
				G.GAME.blind.triggered = false
				if s.debuff.hand and next(hand[s.debuff.hand]) then
					G.GAME.blind.triggered = true
					G.GAME.blind.debuff_boss = s
					return true
				end
				if s.debuff.h_size_ge and #cards < s.debuff.h_size_ge then
					G.GAME.blind.triggered = true
					G.GAME.blind.debuff_boss = s
					return true
				end
				if s.debuff.h_size_le and #cards > s.debuff.h_size_le then
					G.GAME.blind.triggered = true
					G.GAME.blind.debuff_boss = s
					return true
				end
				if s.name == "The Eye" then
					if G.GAME.blind.hands[handname] then
						G.GAME.blind.triggered = true
						G.GAME.blind.debuff_boss = s
						return true
					end
					if not check then
						G.GAME.blind.hands[handname] = true
					end
				end
				if s.name == "The Mouth" then
					if s.only_hand and s.only_hand ~= handname then
						G.GAME.blind.triggered = true
						G.GAME.blind.debuff_boss = s
						return true
					end
					if not check then
						s.only_hand = handname
					end
				end
			end
			if s.name == "The Arm" then
				G.GAME.blind.triggered = false
				if to_big(G.GAME.hands[handname].level) > to_big(1) then
					G.GAME.blind.triggered = true
					if not check then
						level_up_hand(G.GAME.blind.children.animatedSprite, handname, nil, -1)
						G.GAME.blind:wiggle()
					end
				end
			end
			if s.name == "The Ox" then
				G.GAME.blind.triggered = false
				if handname == G.GAME.current_round.most_played_poker_hand then
					G.GAME.blind.triggered = true
					if not check then
						ease_dollars(-G.GAME.dollars, true)
						G.GAME.blind:wiggle()
					end
				end
			end
		end
		return false
	end,
	drawn_to_hand = function(self)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.drawn_to_hand then
				s:drawn_to_hand()
			end
			if s.name == "Cerulean Bell" then
				local any_forced = nil
				for k, v in ipairs(G.hand.cards) do
					if v.ability.forced_selection then
						any_forced = true
					end
				end
				if not any_forced then
					G.hand:unhighlight_all()
					local forced_card = pseudorandom_element(G.hand.cards, pseudoseed("ObsidianOrb"))
					forced_card.ability.forced_selection = true
					G.hand:add_to_highlighted(forced_card)
				end
			end
			if s.name == "Crimson Heart" and G.GAME.blind.prepped and G.jokers.cards[1] then
				local jokers = {}
				for i = 1, #G.jokers.cards do
					if not G.jokers.cards[i].debuff or #G.jokers.cards < 2 then
						jokers[#jokers + 1] = G.jokers.cards[i]
					end
					G.jokers.cards[i]:set_debuff(false)
				end
				local _card = pseudorandom_element(jokers, pseudoseed("ObsidianOrb"))
				if _card then
					_card:set_debuff(true)
					_card:juice_up()
					G.GAME.blind:wiggle()
				end
			end
		end
	end,
	stay_flipped = function(self, area, card)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.stay_flipped and s:stay_flipped(area, card) then
				return true
			end
			if area == G.hand then
				if
					s.name == "The Wheel"
					and pseudorandom(pseudoseed("ObsidianOrb")) < G.GAME.probabilities.normal / 7
				then
					return true
				end
				if
					s.name == "The House"
					and G.GAME.current_round.hands_played == 0
					and G.GAME.current_round.discards_used == 0
				then
					return true
				end
				if s.name == "The Mark" and card:is_face(true) then
					return true
				end
				if s.name == "The Fish" and G.GAME.blind.prepped then
					return true
				end
			end
		end
	end,
	debuff_card = function(self, card, from_blind)
		if card and type(card) == "table" and card.area then
			for k, _ in pairs(Entropy.GetEEBlinds()) do
				s = G.P_BLINDS[k]
				if s.debuff_card then
					s:debuff_card(card, from_blind)
				end
				if s.debuff and not G.GAME.blind.disabled and card.area ~= G.jokers then
					--this part is buggy for some reason
					if s.debuff.suit and Card.is_suit(card, s.debuff.suit, true) then
						card:set_debuff(true)
						return
					end
					if s.debuff.is_face == "face" and Card.is_face(card, true) then
						card:set_debuff(true)
						return
					end
					if s.name == "The Pillar" and card.ability.played_this_ante then
						card:set_debuff(true)
						return
					end
					if s.debuff.value and s.debuff.value == card.base.value then
						card:set_debuff(true)
						return
					end
					if s.debuff.nominal and s.debuff.nominal == card.base.nominal then
						card:set_debuff(true)
						return
					end
				end
				if s.name == "Crimson Heart" and not G.GAME.blind.disabled and card.area == G.jokers then
					return
				end
				if s.name == "Verdant Leaf" and not G.GAME.blind.disabled and card.area ~= G.jokers then
					card:set_debuff(true)
					return
				end
			end
		end
	end,
	cry_before_play = function(self)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.cry_before_play then
				s:cry_before_play()
			end
		end
	end,
	cry_after_play = function(self)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.cry_after_play then
				s:cry_after_play()
			end
		end
	end,
	get_loc_debuff_text = function(self)
		if not G.GAME.blind.debuff_boss then
			return localize("cry_debuff_obsidian_orb")
		end
		local loc_vars = nil
		if G.GAME.blind.debuff_boss.name == "The Ox" then
			loc_vars = { localize(G.GAME.current_round.most_played_poker_hand, "poker_hands") }
		end
		local loc_target =
			localize({ type = "raw_descriptions", key = G.GAME.blind.debuff_boss.key, set = "Blind", vars = loc_vars })
		local loc_debuff_text = ""
		for k, v in ipairs(loc_target) do
			loc_debuff_text = loc_debuff_text .. v .. (k <= #loc_target and " " or "")
		end
		local disp_text = (G.GAME.blind.debuff_boss.name == "The Wheel" and G.GAME.probabilities.normal or "")
			.. loc_debuff_text
		if (G.GAME.blind.debuff_boss.name == "The Mouth") and G.GAME.blind.only_hand then
			disp_text = disp_text .. " [" .. localize(G.GAME.blind.only_hand, "poker_hands") .. "]"
		end
		return disp_text
	end,
})

--for wiki editors these arent 4 seperate blinds but 4 phases of endless entropy

local ref = G.FUNCS.reroll_boss
G.FUNCS.reroll_boss = function(e) 
	if G.GAME.EEBuildup then return end
	ref(e)
end

local upd = Game.update
local ee2dt = 0
function Game:update(dt)
	upd(self, dt)
	if G.GAME.blind and G.GAME.blind.config.blind.key == "bl_entr_endless_entropy_phase_two" then
		local dtmod = math.min(G.SETTINGS.GAMESPEED, 4)/2+0.5
		ee2dt = ee2dt + dt*dtmod
		if ee2dt > 1 then
			for i, v in pairs(G.jokers.cards) do
                if not Card.no(G.jokers.cards[i], "immutable", true) then
                    Cryptid.with_deck_effects(G.jokers.cards[i], function(card2)
                        Cryptid.misprintize(card2, { min=0.975,max=0.975 }, nil, true)
                    end)
                end
			end
			ee2dt = ee2dt - 1
		end
	end
end
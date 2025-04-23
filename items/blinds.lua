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
	bl_entr_endless_entropy=true
}
SMODS.Blind({
	key = "endless_entropy",
	pos = { x = 0, y = 6 },
	atlas = "blinds",
	boss_colour = HEX("ff00ff"),
    mult=1,
	no_ee = true,
	exponent = {
		2, 3
	},
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
		showdown = true,
	},
	counts_as = {
		["bl_entr_scarlet_sun"]=true
	},
	calculate = function(self, blind, context)
		for i, v in pairs(G.P_BLINDS) do
			if not Entropy.EEBlacklist[i] and v.boss and v.boss.showdown and v.calculate and not v.no_ee then
				v:calculate(blind, context)
			end
		end
	end,
	set_blind = function(self)
		for k, _ in pairs(G.P_BLINDS) do
			s = G.P_BLINDS[k]
			if not Entropy.EEBlacklist[k] and s.boss and s.boss.showdown and not s.no_ee then
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
		end
		G.GAME.blind.chips = to_big(G.GAME.blind.chips):arrow(self.exponent[1],self.exponent[2])
	end,
	defeat = function(self)
		for k, _ in pairs(G.P_BLINDS) do
			s = G.P_BLINDS[k]
			if not Entropy.EEBlacklist[k] and s.boss and s.boss.showdown and not s.no_ee then
				if G.P_BLINDS[k].defeat then
					G.P_BLINDS[k]:defeat(silent)
				end
				if G.P_BLINDS[k].name == "The Manacle" and not self.disabled then
					G.hand:change_size(1)
				end
			end
		end
    end,
    disable = function(self)
		for k, _ in pairs(G.P_BLINDS) do
			s = G.P_BLINDS[k]
			if not Entropy.EEBlacklist[k] and s.boss and s.boss.showdown and not s.no_ee then
				if s.disable then
					s:disable(silent)
				end
				if s.name == "The Water" then
					ease_discard(G.GAME.blind.discards_sub)
				end
				if s.name == "The Wheel" or s.name == "The House" or s.name == "The Mark" or s.name == "The Fish" then
					for i = 1, #G.hand.cards do
						if G.hand.cards[i].facing == "back" then
							G.hand.cards[i]:flip()
						end
					end
					for k, v in pairs(G.playing_cards) do
						v.ability.wheel_flipped = nil
					end
				end
				if s.name == "The Needle" then
					ease_hands_played(G.GAME.blind.hands_sub)
				end
				if s.name == "The Wall" then
					G.GAME.blind.chips = G.GAME.blind.chips / 2
					G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				end
				if s.name == "Cerulean Bell" then
					for k, v in ipairs(G.playing_cards) do
						v.ability.forced_selection = nil
					end
				end
				if s.name == "The Manacle" then
					G.hand:change_size(1)

					G.FUNCS.draw_from_deck_to_hand(1)
				end
				if s.name == "Violet Vessel" then
					G.GAME.blind.chips = G.GAME.blind.chips / 3
					G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				end
			end
		end
    end
})
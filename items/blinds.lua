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
	bl_entr_endless_entropy=true,
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
	calculate = function(self, blind, context)

	end,
	defeat = function()
		G.GAME.EEBuildup = false
	end
})

local ref = G.FUNCS.reroll_boss
G.FUNCS.reroll_boss = function(e) 
	if G.GAME.EEBuildup then return end
	ref(e)
end
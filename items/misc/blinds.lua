Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	
    order = 1200,
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
	},
	get_entrassist = function()
		return G.P_BLINDS.bl_entr_sunny_joker
	end,
	set_blind = function(self)
        G.GAME.blindentrassist.states.visible = true
		G.GAME.blindentrassist:set_entrassist_blind(G.P_BLINDS.bl_entr_sunny_joker)
		G.GAME.blindentrassist:change_dim(0.75,0.75)

		G.GAME.blind.effect.asc = 0
	end,
	load = function()
		G.GAME.blindentrassist:change_dim(0.75,0.75)
	end,
	calculate = function(self, blind, context)
		if context.post_trigger then
			G.GAME.blind.effect.asc = (G.GAME.blind.effect.asc or 0) - 0.25
		end
		if context.final_scoring_step then
			return {
				asc = G.GAME.blind.effect.asc
			}
		end
	end,
	defeat = function()
		G.GAME.blindentrassist.states.visible = false
        G.GAME.blindentrassist:change_dim(0,0)
	end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	
    order = 1201,
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
	end,
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	
    order = 1202,
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
			hand_size = -1
		}
	},
	calculate = function(self, blind, context)
		if context.pre_discard and not G.GAME.blind.disabled then
			Entropy.flip_then(G.hand.highlighted, function(card, area)
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
    end,
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	
    order = 1203,
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
			Entropy.flip_then(G.hand.cards, function(card, area)
				if not card.highlighted then
					card:set_ability(G.P_CENTERS.m_entr_disavowed)
				end
			end)
		end
		if context.final_scoring_step and not G.GAME.blind.disabled then
			Entropy.flip_then(G.hand.cards, function(card, area)
				card:set_ability(G.P_CENTERS.m_entr_disavowed)
			end)
		end
	end,
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	
    order = 1204,
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
		if context.check and not G.GAME.blind.disabled then 
			for i, v in pairs(G.hand.cards) do if not v.highlighted then v.destroy_adjacent = false;v.destroyed_adjacent = false end end
			for i, v in pairs(G.hand.highlighted) do
				v.destroy_adjacent = true
			end
			local remove = {}
			for i, v in pairs(G.hand.cards) do
				if v.destroy_adjacent and not v.destroyed_adjacent then
					if G.hand.cards[i-1] and pseudorandom("citrine") < (Entropy.is_EE() and 0.2 or 0.5) and not SMODS.is_eternal(G.hand.cards[i-1]) then
						SMODS.destroy_cards{G.hand.cards[i-1]}
					end
					if G.hand.cards[i+1] and pseudorandom("citrine") < (Entropy.is_EE() and 0.2 or 0.5) and not SMODS.is_eternal(G.hand.cards[i-1]) then
						SMODS.destroy_cards{G.hand.cards[i-1]}
					end
					v.destroy_adjacent = false
					v.destroyed_adjacent = true
				end
			end
		end
	end,
}
-- Entropy.EEBlacklist = {
-- 	bl_cry_obsidian_orb=true,
-- 	bl_entr_endless_entropy_phase_one=true,
-- 	bl_entr_endless_entropy_phase_two=true,
-- 	bl_entr_endless_entropy_phase_three=true,
-- 	bl_entr_endless_entropy_phase_four=true,
-- 	bl_cry_lemon_trophy = true,
-- 	bl_cry_lavender_loop=true,
-- 	bl_cry_vermillion_virus=true,
-- 	bl_cry_turquoise_tornado=true,
-- 	bl_mf_violet_vessel_dx = true,
-- 	bl_mf_cerulean_bell_dx = true,
-- 	bl_mf_needle_dx = true,
-- 	bl_mf_manacle_dx = true,
-- 	bl_mf_pillar_dx = true,
-- 	bl_mf_serpent_dx = true,
-- 	bl_mf_club_dx = true,
-- 	bl_mf_goad_dx = true,
-- 	bl_mf_window_dx = true,
-- 	bl_mf_head_dx = true,
-- 	bl_mf_arm_dx = true,
-- 	bl_mf_wheel_dx = true,
-- 	bl_mf_house_dx = true,
-- 	bl_mf_psychic_dx = true,
-- 	bl_mf_hook_dx = true,
-- }

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	
    order = 1205,
	name = "entr-alabaster_anchor",
	key = "alabaster_anchor",
	pos = { x = 0, y = 10 },
	atlas = "blinds",
	boss_colour = HEX("cebea8"),
    mult=2,
    dollars = 8,
	boss = {
		min = 3,
		max = 10,
		showdown = true,
	},
	calculate = function(self, blind, context)
		if context.after or context.pre_discard then
			for i = 1, #G.jokers.cards do
				Cryptid.manipulate(G.jokers.cards[i], { value = 0.95 })
				G.jokers.cards[i].config.cry_multiply = (G.jokers.cards[i].config.cry_multiply or 1) * 0.95
			end
		end
	end,
}

local highlight_ref = Card.highlight
function Card:highlight(is_highlighted)
	if Entropy.blind_is("bl_entr_alabaster_anchor") and not G.GAME.blind.disabled and self.area == G.hand and G.hand then
		for i = 1, #G.jokers.cards do
			Cryptid.manipulate(G.jokers.cards[i], { value = 0.95 })
			G.jokers.cards[i].config.cry_multiply = (G.jokers.cards[i].config.cry_multiply or 1) * 0.95
		end
	end
	if next(SMODS.find_card("j_entr_citrine_comet")) and self.edition and self.edition.negative then
		if is_highlighted then
			Entropy.change_selection_limit(1)
		else	
			Entropy.change_selection_limit(-1)
		end
	end
	highlight_ref(self, is_highlighted)
end

if not (SMODS.Mods["Cryptid"] or {}).can_load then
	local er = end_round
	function end_round()
		er()
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].config.cry_multiply then
				m = G.jokers.cards[i].config.cry_multiply
				Cryptid.manipulate(G.jokers.cards[i], { value = 1 / m })
				G.jokers.cards[i].config.cry_multiply = nil
			end
		end
	end
end

Entropy.Blind{
    dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	
    order = 4200,
	key = "red",
	pos = { x = 0, y = 0 },
	atlas = "redroom",
	boss_colour = HEX("a0001a"),
    mult=1,
    dollars = 3,
    in_pool = function(self) return false end
}

Entropy.Blind{
    dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	
    order = 4201,
	key = "abyss",
	pos = { x = 0, y = 16 },
	atlas = "redroom",
	boss_colour = HEX("80396f"),
    mult=1,
    dollars = 3,
    in_pool = function(self) return false end,
	get_copied_blinds = function()
		return G.GAME.abyss_blinds
	end,
	set_blind = function()
		G.GAME.abyss_blinds = G.GAME.abyss_blinds or {}
		G.GAME.blind.chips = G.GAME.blind.chips * (G.GAME.abyss_size_mod or 1)
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		G.HUD_blind:recalculate()
	end
}

function Entropy.progress_abyss()
	SMODS.ante_end = true; ease_ante(1)
  	SMODS.ante_end = nil; delay(0.4)
	G.GAME.abyss_size_mod = 1
	G.GAME.abyss_blinds = {get_new_boss()}
	G.GAME.abyss_just_lost = true
end

function Entropy.defeat_abyss()
	G.GAME.abyss_just_lost = nil
	G.GAME.abyss_size_mod = (G.GAME.abyss_size_mod or 1) * 1.5
	G.GAME.abyss_blinds = G.GAME.abyss_blinds or {}
	G.GAME.abyss_blinds[#G.GAME.abyss_blinds+1] = get_new_boss()
end
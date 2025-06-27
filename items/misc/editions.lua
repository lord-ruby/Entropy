SMODS.Shader({
    key="solar",
    path="solar.fs"
})

local solar = {
	object_type = "Edition",
	order = 9000+1,
    key="solar",
    shader="solar",
    config = {
        sol = 1.4
    },
	sound = {
		sound = "entr_e_solar",
		per = 1,
		vol = 0.4,
	},
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	extra_cost = 10,
	in_shop = true,
	weight = 0.4,
    badge_color = HEX("fca849"),
	disable_base_shader=true,
    loc_vars = function(self,q,card)
        return {vars={card and card.edition and card.edition.sol or 1.4}}
    end,
    calculate = function(self, card, context)
		if
			(
				context.edition
				and context.cardarea == G.jokers
				and card.config.trigger
			) or (
				context.main_scoring
				and context.cardarea == G.play
			)
		then
			return { asc = card and card.edition and card.edition.sol or 1.4 }
		end
		if context.joker_main then
			card.config.trigger = true
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
	entr_credits = {
		custom={key="shader",text="cassknows"}
	}
}


SMODS.Shader({
    key="fractured",
    path="fractured.fs"
})

local fractured ={
	object_type = "Edition",
	order = 9000+2,
    key="fractured",
    shader="fractured",
    config = {
        retrig = 3
    },
	sound = {
		sound = "entr_e_solar",
		per = 1,
		vol = 0.4,
	},
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	extra_cost = 10,
	in_shop = true,
	weight = 0.2,
    badge_color = HEX("fca849"),
	disable_base_shader=true,
    loc_vars = function(self,q,card)
        return {vars={card and card.edition and card.edition.retrig or 3}}
    end,
	draw = function(self, card, layer)
		card.children.center:draw_shader(G.P_CENTERS.e_entr_fractured.shader, nil, card.ARGS.send_to_shader)
		if card.children.front and card.ability.effect ~= 'Stone Card' and not card.config.center.replace_base_card then
			card.children.front:draw_shader("dissolve")
		end
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			card.config.trigger = true
		end

		if context.after then
			card.config.trigger = nil
		end
		if (
			context.edition
			and context.cardarea == G.jokers
			and card.config.trigger
		) or (
			context.main_scoring
			and context.cardarea == G.play
		) then
			return Entropy.RandomForcetrigger(card, card and card.edition and card.edition.retrig or 3, context)
		end
	end,
	entr_credits = {
		custom={key="shader",text="cassknows"}
	}
}
SMODS.Shader({
    key="sunny",
    path="sunny.fs"
})
local sunny = {
	object_type = "Edition",
	order = 9000-1,
    key="sunny",
    shader="sunny",
    config = {
        sol = 4
    },
	extra_cost = 4,
	sound = {
		sound = "entr_e_solar",
		per = 1,
		vol = 0.4,
	},
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	in_shop = true,
	weight = 0.8,
    badge_color = HEX("fca849"),
	disable_base_shader=true,
    loc_vars = function(self,q,card)
        return {vars={card and card.edition and card.edition.sol or 4}}
    end,
    calculate = function(self, card, context)
		if
			(
				context.edition
				and context.cardarea == G.jokers
				and card.config.trigger
			) or (
				context.main_scoring
				and context.cardarea == G.play
			)
		then
			return { plus_asc = card and card.edition and card.edition.sol or 1.4 }
		end
		if context.joker_main then
			card.config.trigger = true
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
	entr_credits = {
		custom={key="shader",text="cassknows"}
	}
}

SMODS.Shader({
    key="freaky",
    path="freaky.fs"
})

local freaky = {
	object_type = "Edition",
	order = 9000+3,
    key="freaky",
    shader="freaky",
	sound = {
		sound = "entr_e_rizz",
		per = 1,
		vol = 0.4,
	},
	config = {
		log_base = 69
	},
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	extra_cost = 18,
	in_shop = true,
	weight = 0.5,
    badge_color = HEX("fca849"),
	disable_base_shader=true,
    loc_vars = function(self,q,card)
		return {vars={card and card.edition and card.edition.log_base or 69}}
    end,
    calculate = function(self, card, context)
		if
			(
				context.edition
				and context.cardarea == G.jokers
				and card.config.trigger
			) or (
				context.main_scoring
				and context.cardarea == G.play
			)
		then
			return { xlog_chips = card and card.edition and card.edition.log_base or 69}
		end
		if context.joker_main then
			card.config.trigger = true
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
	entr_credits = {
		custom={key="shader",text="cassknows"}
	}
}

if AurinkoAddons then
	AurinkoAddons.entr_solar = function(card, hand, instant, amount)
		if to_big(G.GAME.hands[hand].AscensionPower or 0) > to_big(0) then
			local num = G.GAME.hands[hand].AscensionPower * ((card.edition.sol-1) ^ (amount or 1))
			Entropy.ReversePlanetUse(hand, card, num, nil, true)
		end
	end
	AurinkoAddons.entr_sunny = function(card, hand, instant, amount)
		local num = 4*(amount or 1)
		Entropy.ReversePlanetUse(hand, card, num, nil, true)
	end
	AurinkoAddons.entr_freaky = function(card, hand, instant, amount)
		local hand_chips = G.GAME.hands[hand].chips
		local mult = math.max(Entropy.ApproximateLogRecursion(hand_chips, card.edition.log_base, amount), hand_chips)/hand_chips
		hand_chips = math.max(Entropy.ApproximateLogRecursion(hand_chips, card.edition.log_base, amount), hand_chips)
		G.GAME.hands[hand].chips = hand_chips
		if not instant then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					play_sound("entr_e_rizz", 0.7)
					card:juice_up(0.8, 0.5)
					return true
				end,
			}))
			update_hand_text(
				{ delay = 1.3 },
				{ chips = "X"..number_format(mult), StatusText = true }
			)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					play_sound("multhit1")
					card:juice_up(0.8, 0.5)
					return true
				end,
			}))
		end
	end
end

if Entropy.config.override_glitched then

	SMODS.Shader({
		key="entr_glitched",
		path="entr_glitched.fs"
	})

	SMODS.Edition:take_ownership("cry_glitched", {
		shader = "entr_glitched"
	}, true)

end

SMODS.Shader({
    key="neon",
    path="neon.fs"
})

local neon = {
	object_type = "Edition",
	order = 9000-2,
    key="neon",
    shader="neon",
	sound = {
		sound = "multhit1",
		per = 1,
		vol = 0.4,
	},
	config = {
		cost_fac = 0.5
	},
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	in_shop = true,
	weight = 0.5,
    badge_color = HEX("fca849"),
	disable_base_shader=true,
    loc_vars = function(self,q,card)
		return {vars={card and card.edition and card.edition.cost_fac or 0.5}}
    end,
    calculate = function(self, card, context)

	end,
	entr_credits = {
		custom={key="shader",text="cassknows"}
	}
}

local set_cost_ref = Card.set_cost
function Card:set_cost()
	set_cost_ref(self)
	if self.edition and self.edition.key == "e_entr_neon" then
		self.cost = self.cost * self.edition.cost_fac
	end
end


SMODS.Shader({
    key="lowres",
    path="lowres.fs"
})

local lowres = {
	object_type = "Edition",
	order = 9000-1.75,
    key="lowres",
    shader="lowres",
	sound = {
		sound = "multhit1",
		per = 1,
		vol = 0.4,
	},
	config = {
		triggers = 2,
		factor = 0.25
	},
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	extra_cost = 5,
	in_shop = true,
	weight = 0.45,
    badge_color = HEX("fca849"),
    loc_vars = function(self,q,card)
		return {vars={card and card.edition and card.edition.triggers or 2, card and card.edition and card.edition.factor or 0.25}}
    end,
    calculate = function(self, card, context)
		if context.other_card == card and ((context.repetition and (context.cardarea == G.play or context.cardarea == G.hand)) or (context.retrigger_joker_check and not context.retrigger_joker)) then
			return {
				message = localize("k_again_ex"),
				repetitions = card.edition.triggers,
				card = card,
			}
		end
	end,
	on_apply = function(card)
		Cryptid.manipulate(card, {
			value = 0.25
		}, nil, true)
	end,
	on_remove = function(card)
		Cryptid.manipulate(card, { value = 1 })
		Cryptid.manipulate(card)
	end,
	entr_credits = {
		custom={key="shader",text="cassknows"}
	}
}

SMODS.Shader({
    key="kaleidoscopic",
    path="kaleidoscopic.fs"
})


local kaleidoscopic = {
	object_type = "Edition",
	order = 9000+4,
    key="kaleidoscopic",
    shader="kaleidoscopic",
	sound = {
		sound = "multhit1",
		per = 1,
		vol = 0.4,
	},
	config = {
		cards = 2
	},
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	extra_cost = 5,
	in_shop = true,
	weight = 0.45,
    badge_color = HEX("fca849"),
    loc_vars = function(self,q,card)
		return {vars={card and card.edition and card.edition.triggers or 2, card and card.edition and card.edition.cards or 2}}
    end,
    calculate = function(self, card, context)
		if context.edition or context.main_scoring and not context.kaleidoscopic then
			local cards = {}
			for i, v in pairs(card.area.cards) do cards[#cards+1] = v; end
			pseudoshuffle(cards, pseudoseed('kaleidoscopic_cards'))
			local actual = {}
			for i = 1, card.edition and card.edition.cards or 2 do
				actual[i] = cards[i]
			end
			for i, v in pairs(actual) do
				context.kaleidoscopic = true
				local eval, post = eval_card(v, context)
				local effects = {eval}
				if context.main_scoring then 
					eval.chips = v.base.nominal + v.ability.bonus or 0
					SMODS.calculate_context({individual = true, other_card=v, cardarea = v.area})
				end
				for _,v in ipairs(post or {}) do effects[#effects+1] = v end
				if eval.retriggers then
					for rt = 1, #eval.retriggers do
						local rt_eval, rt_post = eval_card(v, context)
						table.insert(effects, {eval.retriggers[rt]})
						table.insert(effects, rt_eval)
						for _, v in ipairs(rt_post) do effects[#effects+1] = v end
						if context.main_scoring then 
							table.insert(effects, {chips = v.base.nominal + v.ability.bonus or 0}) 
							SMODS.calculate_context({individual = true, other_card=v, cardarea = v.area})
						end
					end
				end
				SMODS.trigger_effects(effects, v)
				context.kaleidoscopic = nil
			end
		end
	end,
	entr_credits = {
		custom={key="shader",text="cassknows"}
	}
}

return {
    items = {
        solar,
        fractured,
		sunny,
		freaky,
		neon,
		lowres,
		kaleidoscopic
    }
}

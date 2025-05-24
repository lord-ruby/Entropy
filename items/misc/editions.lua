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
			local num = G.GAME.hands[hand].AscensionPower * (card.edition.sol-1) *(amount or 1)
			Entropy.ReversePlanetUse(hand, card, num)
		end
	end
	AurinkoAddons.entr_sunny = function(card, hand, instant, amount)
		local num = 4*(amount or 1)
		Entropy.ReversePlanetUse(hand, card, num)
	end
	AurinkoAddons.entr_freaky = function(card, hand, instant, amount)
		local hand_chips = G.GAME.hands[hand].chips
		local mult = math.max(math.log(to_big(hand_chips) < to_big(0) and 1 or hand_chips, 69), 1)
		hand_chips = hand_chips * mult
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

return {
    items = {
        solar,
        fractured,
		sunny,
		freaky
    }
}

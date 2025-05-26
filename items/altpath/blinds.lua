local alpha = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+1,
	name = "entr-alpha",
	key = "alpha",
	pos = { x = 0, y = 0 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=3,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
    calculate = function(self, blind, context)
		if
			context.full_hand
			and context.destroy_card
			and (context.cardarea == G.play)
			and not G.GAME.blind.disabled
		then
            local check = nil
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            for i, v in ipairs(scoring_hand) do
                if i == 1 and v == context.destroy_card then check = true end
            end
            G.GAME.blind.triggered = true
			return { remove = check and not context.destroy_card.ability.eternal }
		end
    end
}

local beta = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+2,
	name = "entr-beta",
	key = "beta",
	pos = { x = 0, y = 1 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
    calculate = function(self, blind, context)
		if
			context.after
			and not G.GAME.blind.disabled
		then
            G.hand.config.card_limit = G.hand.config.card_limit - 1
            G.GAME.beta_modifer = (G.GAME.beta_modifer or 0) + 1
            G.GAME.blind.triggered = true
		end
    end,
    defeat = function()
        if not G.GAME.blind.disabled then
            G.hand.config.card_limit = G.hand.config.card_limit + G.GAME.beta_modifer
            G.GAME.beta_modifer = nil
        end
    end,
    disable = function()
        if not G.GAME.blind.disabled then
            G.hand.config.card_limit = G.hand.config.card_limit + G.GAME.beta_modifer
            G.GAME.beta_modifer = nil
        end
    end,
    set_blind = function()
        G.hand.config.card_limit = G.hand.config.card_limit - 1
        G.GAME.beta_modifer = (G.GAME.beta_modifer or 0) + 1
    end
}

local gamma = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+3,
	name = "entr-gamma",
	key = "gamma",
	pos = { x = 0, y = 2 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
		if context.after and not G.GAME.blind.disabled then
            local suits = {}
            local discovered = 0
			for i, v in ipairs(G.play.cards) do
				if v.config.center.key == "m_cry_abstract" then
					if not suits["abstract"] then
						suits["abstract"] = true
						discovered = discovered + 1
					end
				else
					if not suits[v.base.suit] then
						suits[v.base.suit] = true
						discovered = discovered + 1
					end
				end
			end
            discovered = math.max(discovered, 2)
            G.GAME.current_round.current_hand.mult = G.GAME.current_round.current_hand.mult * (1-1/discovered)
            update_hand_text({delay = 0}, {mult = G.GAME.current_round.current_hand.mult})
            G.GAME.blind.triggered = true
		end
	end,
}

local delta = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+4,
	name = "entr-delta",
	key = "delta",
	pos = { x = 0, y = 3 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
    end
}
local eval_ref = evaluate_play_main
function evaluate_play_main (text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta = eval_ref(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    if Entropy.BlindIs("bl_entr_delta") and G.GAME.round_resets.hands > G.GAME.current_round.hands_left then
        local used = G.GAME.round_resets.hands - G.GAME.current_round.hands_left
        used = math.max(used,2)
        mult = mult / used
        G.GAME.blind.triggered = true
        update_hand_text({delay=0}, {mult=mult})
        delay(0.4)
    end
    return text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta
end

return {
    items = {
        alpha,
        beta,
        gamma,
        delta
    }
}
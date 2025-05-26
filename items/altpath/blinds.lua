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
            for i, v in ipairs(G.play.cards) do
                if i == 1 and v == context.destroy_card then check = true end
            end
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
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		if G.GAME.current_round.discards_left > 1 then
			G.GAME.blind.triggered = true
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
			return mult * (1-1/discovered), hand_chips, true
		end
		return mult, hand_chips, false
	end,
}

return {
    items = {
        alpha,
        beta,
        gamma
    }
}
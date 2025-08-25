local scenic_route = {
    order = 25,
    object_type = "Joker",
    key = "scenic_route",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 9, y = 4 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, q, card) q[#q+1] = G.P_CENTERS.c_entr_new end,
    calculate = function(self, card, context)
        if (context.end_of_round and not context.blueprint and not context.individual and G.GAME.blind_on_deck == "Boss" and not context.repetition and G.GAME.blind.config.blind.key ~= "bl_entr_red")  or context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.consumeables.config.card_count < G.consumeables.config.card_limit then
                        SMODS.add_card{
                            key="c_entr_new",
                            area=G.consumeables,
                            key_append = "entr_scenic_route"
                        }
                    end
                    return true
                end
            }))
            return {
                message = localize("k_new")
            }
        end
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"LFMoth"}
    }
}

local solarflare = {
    order = 3,
    object_type = "Joker",
    key = "solarflare",
    name="entr-solarflare",
    config = {
        asc=1.6
    },
    rarity = 2,
    cost = 6,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
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
			and context.other_joker.edition.key == "e_entr_solar"
			and card ~= context.other_joker)
		then
			if not Talisman or not Talisman.config_file.disable_anims then
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
			if context.other_card.edition and context.other_card.edition.key == "e_entr_solar" then
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
			and context.other_card.edition.key == "e_entr_solar"
			and not context.end_of_round and not context.repetition)
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
}

local code_m = {
    order = 22,
    object_type = "Joker",
    key = "code_m",
    rarity = 3,
    cost = 10,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
            "set_cry_code"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 6, y = 3 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = {
        ["M"] = true
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_cry_m
    end,
    calculate = function(self, card, context)
        if (context.using_consumeable and context.consumeable.config.center.set == "Code") or context.forcetrigger then
            local cards = {}
            for i, v in ipairs(G.jokers.cards) do
                if not v.edition then cards[#cards+1] = v end
            end
            local jcard = pseudorandom_element(cards, pseudoseed("code_m"))
            Entropy.FlipThen({jcard}, function(card)
                card:set_edition("e_cry_m")
            end)
        end
	end,
}

return {
    items = {
        scenic_route,
        solarflare,
        code_m
    }
}
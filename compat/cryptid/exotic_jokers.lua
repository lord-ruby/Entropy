local rarity = Entropy.ValkarriOverCryptid and "valk_exquisite" or Entropy.MDJOverCryptid and "MDJ_unlegendary" or "cry_exotic"
local set = ( Entropy.ValkarriOverCryptid or Entropy.MDJOverCryptid ) and "set_entr_misc_jokers" or "set_cry_exotic"

local stillicidium = {
    order = 500,
    object_type = "Joker",
    key = "stillicidium",
    rarity = rarity,
    cost = 50,
    atlas = "exotic_jokers",
    soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
    
    dependencies = {
        items = {
            set
        }
    },
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
                local cards = {}
                for i, v in pairs(G.jokers.cards) do
                    if (v.config.center_key ~= "j_entr_stillicidium" or context.forcetrigger) and i > Entropy.get_area_index(G.jokers.cards, card) 
                    and not v.ability.cry_absolute then --you cannot run, you cannot hide
                       cards[#cards+1] = v
                    end
                end
                Entropy.reduce_cards(cards, card)
                Entropy.reduce_cards(G.consumeables.cards, card)
        end
        if context.individual and 
            context.cardarea == G.play and context.other_card 
            then
                local card = context.other_card 
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                    card:juice_up(0.3, 0.3)
                    SMODS.modify_rank(card, -1)
                return true end }))
        end
        if (context.setting_blind and not context.blueprint and not card.getting_sliced) or context.forcetrigger then
			card.gone = false
			G.GAME.blind.chips = G.GAME.blind.chips * 0.7
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.HUD_blind:recalculate()
		end
    end
}

local libra = {
    order = 500 + 1,
    object_type = "Joker",
    key = "libra",
    rarity = rarity,
    cost = 50,
    atlas = "exotic_jokers",

    pos = { x = 6, y = 0 },
    soul_pos = { x = 8, y = 0, extra = { x = 7, y = 0 } },
    
    dependencies = {
        items = {
            set
        }
    },

    config = {
        echips = 1
    },

    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        return {
            vars = {
                card.ability.echips
            }
        }
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card and (context.other_card:is_face() or context.other_card.config.center.key == "m_wild") then
            local total = card.ability.echips
            local values = 1
            for i, v in pairs(context.other_card.ability) do
                if type(v) == "number" and v ~= 1 and v~= 0 then
                    total = total + v
                    values = values + 1
                end
                if (Entropy.is_big(v)) and v ~= to_big(1) and v ~= to_big(0) then
                    total = total + v
                    values = values + 1
                end
            end
            if type(context.other_card.ability.extra) == "table" and not Entropy.is_big(context.other_card.ability.extra) then
                for i, v in pairs(context.other_card.ability.extra or {}) do
                    if type(v) == "number" and v ~= 1 and v~= 0 then
                        total = total + v
                        values = values + 1
                    end
                    if Entropy.is_big(v) and v ~= to_big(1) and v ~= to_big(0) then
                        total = total + v
                        values = values + 1
                    end
                end
            end
            total = total + context.other_card.base.nominal
            values = values + 1
            for i, v in pairs(context.other_card.ability) do
                if type(v) == "number" and v ~= 1 and v~= 0 then
                    context.other_card.ability[i] = total / values
                end
                if Entropy.is_big(v) and v ~= to_big(1) and v ~= to_big(0) then
                    context.other_card.ability[i] = to_big(total / values)
                end
            end
            if type(context.other_card.ability.extra) == "table" and not Entropy.is_big(context.other_card.ability.extra) then
                for i, v in pairs(context.other_card.ability.extra or {}) do
                    if type(v) == "number" and v ~= 1 and v~= 0 then
                        context.other_card.ability.extra[i] = total / values
                    end
                    if Entropy.is_big(v) and v ~= to_big(1) and v ~= to_big(0) then
                        context.other_card.ability.extra[i] = to_big(total / values)
                    end
                end
            end
            context.other_card.base.nominal = total / values
            card.ability.echips = total / values
        end
        if context.joker_main or context.forcetrigger then
            return {
                echips = card.ability.echips
            }
        end
    end,
    entr_credits = {
        idea = {"cassknows"}
    }
}

local scorpio = {
    order = 500 + 2,
    object_type = "Joker",
    key = "scorpio",
    rarity = rarity,
    cost = 50,
    atlas = "exotic_jokers",

    pos = { x = 6, y = 1 },
    soul_pos = { x = 8, y = 1, extra = { x = 7, y = 1 } },
    
    dependencies = {
        items = {
            set
        }
    },
    config = {
        all8s = 16,
        immutable = {
            temp_fac = 1
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.all8s
            }
        }
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card and context.other_card:get_id() == 8 then
            if card.ability.immutable_temp_fac and card.ability.immutable_temp_fac < 1e69 then
                G.GAME.probabilities.normal = G.GAME.probabilities.normal * 1.16
                card.ability.immutable_temp_fac = (card.ability.immutable_temp_fac or 1) * 1.16
            end
            --just lie whatever idc
            card_eval_status_text(
                card,
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_upgrade_ex"), colour = G.C.BLUE }
            )
        end
        if context.joker_main or context.forcetrigger then
            local d8s = {}
            for i = 1, 8 do
                d8s[#d8s+1] = math.floor(pseudorandom("scorpio")*7+1.5)
            end
            local all8s = true
            local sum = 0
            for i, v in ipairs(d8s) do
                if v ~= 8 then all8s = false end
                sum = sum + v/8
            end
            if all8s then
                sum = card.ability.all8s
            end
            return {
                Echip_mod = sum,
                message = "Sum = ^"..sum.." Chips"
            }
        end
        if context.after then
            G.GAME.probabilities.normal = G.GAME.probabilities.normal / (card.ability.immutable_temp_fac or 1)
            card.ability.immutable_temp_fac = 1
        end
    end,
	entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
}

local ridiculus_absens = {
    order = 500 + 3,
    object_type = "Joker",
    key = "ridiculus_absens",
    rarity = rarity,
    cost = 50,
    atlas = "exotic_jokers",
    name = "entr-ridiculus_absens",
    pos = { x = 6, y = 2 },
    soul_pos = { x = 8, y = 2, extra = { x = 7, y = 2 } },
    
    dependencies = {
        items = {
            set
        }
    },
    config = {
        extra = {
            odds = 2
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_cry_glitched
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            local cards = {}
            for i, v in ipairs(G.play.cards) do
                if SMODS.pseudorandom_probability(card, 'tmtrainer', 1, card.ability.extra.odds) then
                    if not v.edition or v.edition and v.edition.key ~= "e_cry_glitched" then
                        cards[#cards+1]=v
                    end
                end
            end
            card.ability.extra.odds = pseudorandom("tmtrainer_odds") * 2 + 1
            Entropy.flip_then(cards, function(card)
                card:set_edition("e_cry_glitched")
                Entropy.randomize_TMT(card)
            end)
        end
    end,
	entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
}

return {
    items = {
        stillicidium,
        libra,
        scorpio,
        not Entropy.ValkarriOverCryptid and ridiculus_absens or nil
    }
}

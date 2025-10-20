-- Hotpotato crossmod stuff
-- MTX cards are the inverse of Aura cards

if (SMODS.Mods["HotPotato"] or {}).can_load then
    SMODS.ConsumableType({
        key = "mtx",
        collection_rows = { 4, 4 },
        primary_colour = G.C.GREEN,
        secondary_colour = G.C.GREEN,
        shop_rate = nil,
    })
    -- Inverse justice aura, aka "Extra Joker"
    SMODS.Consumable({
        key = "extrajoker",
        dependencies = {
            items = {
                "set_entr_inversions",
            }
        },
        set = "mtx",
        inversion = "c_hpot_justice",
        atlas = "crossmod_consumables",
        pos = {
            x = 5,
            y = 5
        },
        set_badges = function(self, card, badges)
            SMODS.create_mod_badges({ mod = SMODS.find_mod("HotPotato")[1] }, badges)
        end,
        entr_credits = {
            art = { "LFMoth" },
            idea = { "LFMoth" },
            code = { "LFMoth" },
        },
        config = {
            extra = {
                slots = 1,
                credits = 700
            },
        },
        loc_vars = function(self, info_queue, card)
            return {
                vars = { card.ability.extra.slots, card.ability.extra.credits },
            }
        end,
        can_use = function(self, card)
            if G.GAME.seeded == true and G.GAME.budget >= card.ability.extra.credits then         -- check if run is seeded, check seeded creds
                return true
            elseif G.PROFILES[G.SETTINGS.profile].TNameCredits >= card.ability.extra.credits then -- otherwise, check normal creds
                return true
            else
                return false
            end
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                func = function()
                    HPTN.ease_credits(-card.ability.extra.credits, false) -- remove credits
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.jokers then
                        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
                    end
                    return true
                end,
            }))
        end,
    })
    SMODS.Consumable({
        key = "unstick",
        dependencies = {
            items = {
                "set_entr_inversions",
            }
        },
        set = "mtx",
        inversion = "c_hpot_fear",
        atlas = "crossmod_consumables",
        pos = {
            x = 6,
            y = 5
        },
        set_badges = function(self, card, badges)
            SMODS.create_mod_badges({ mod = SMODS.find_mod("HotPotato")[1] }, badges)
        end,
        entr_credits = {
            art = { "LFMoth" },
            idea = { "LFMoth" },
            code = { "LFMoth" },
        },
        config = {
            extra = {
                credits = 300
            },
        },
        loc_vars = function(self, info_queue, card)
            return {
                vars = { card.ability.extra.credits },
            }
        end,
        can_use = function(self, card)
            if G.GAME.seeded == true and G.GAME.budget >= card.ability.extra.credits then         -- check if run is seeded, check seeded creds
                return true
            elseif G.PROFILES[G.SETTINGS.profile].TNameCredits >= card.ability.extra.credits then -- otherwise, check normal creds
                return true
            else
                return false
            end
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                func = function()
                    HPTN.ease_credits(-card.ability.extra.credits, false) -- remove credits
                    return true
                end,
            }))
            for k, v in ipairs(G.jokers.cards) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for _, sticker in pairs(SMODS.Stickers) do
                            sticker:apply(v, false)
                        end
                        v:juice_up()
                        play_sound('card1')
                        return true
                    end,
                }))
            end
        end,
    })
    SMODS.Consumable({
        key = "extrahands",
        dependencies = {
            items = {
                "set_entr_inversions",
            }
        },
        set = "mtx",
        inversion = "c_hpot_perception",
        atlas = "crossmod_consumables",
        pos = {
            x = 7,
            y = 5
        },
        set_badges = function(self, card, badges)
            SMODS.create_mod_badges({ mod = SMODS.find_mod("HotPotato")[1] }, badges)
        end,
        entr_credits = {
            art = { "LFMoth" },
            idea = { "LFMoth" },
            code = { "LFMoth" },
        },
        config = {
            extra = {
                hands = 1,
                credits = 500
            },
        },
        loc_vars = function(self, info_queue, card)
            return {
                vars = { card.ability.extra.hands, card.ability.extra.credits },
            }
        end,
        can_use = function(self, card)
            if G.GAME.seeded == true and G.GAME.budget >= card.ability.extra.credits then         -- check if run is seeded, check seeded creds
                return true
            elseif G.PROFILES[G.SETTINGS.profile].TNameCredits >= card.ability.extra.credits then -- otherwise, check normal creds
                return true
            else
                return false
            end
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                func = function()
                    HPTN.ease_credits(-card.ability.extra.credits, false) -- remove credits
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
                    ease_hands_played(card.ability.extra.hands)
                    return true
                end,
            }))
        end,
    })
    SMODS.Consumable({
        key = "moneybundle",
        dependencies = {
            items = {
                "set_entr_inversions",
            }
        },
        set = "mtx",
        inversion = "c_hpot_greatness",
        atlas = "crossmod_consumables",
        pos = {
            x = 8,
            y = 5
        },
        set_badges = function(self, card, badges)
            SMODS.create_mod_badges({ mod = SMODS.find_mod("HotPotato")[1] }, badges)
        end,
        entr_credits = {
            art = { "LFMoth" },
            idea = { "LFMoth" },
            code = { "LFMoth" },
        },
        config = {
            extra = {
                dollars = 50,
                credits = 500
            },
        },
        loc_vars = function(self, info_queue, card)
            return {
                vars = { card.ability.extra.dollars, card.ability.extra.credits },
            }
        end,
        can_use = function(self, card)
            if G.GAME.seeded == true and G.GAME.budget >= card.ability.extra.credits then         -- check if run is seeded, check seeded creds
                return true
            elseif G.PROFILES[G.SETTINGS.profile].TNameCredits >= card.ability.extra.credits then -- otherwise, check normal creds
                return true
            else
                return false
            end
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                func = function()
                    HPTN.ease_credits(-card.ability.extra.credits, false) -- remove credits
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_dollars(card.ability.extra.dollars)
                    return true
                end,
            }))
        end,
    })
    SMODS.Consumable({
        key = "biggerpockets",
        dependencies = {
            items = {
                "set_entr_inversions",
            }
        },
        set = "mtx",
        inversion = "c_hpot_clairvoyance",
        atlas = "crossmod_consumables",
        pos = {
            x = 5,
            y = 6
        },
        set_badges = function(self, card, badges)
            SMODS.create_mod_badges({ mod = SMODS.find_mod("HotPotato")[1] }, badges)
        end,
        entr_credits = {
            art = { "LFMoth" },
            idea = { "LFMoth" },
            code = { "LFMoth" },
        },
        config = {
            extra = {
                slots = 1,
                credits = 600
            },
        },
        loc_vars = function(self, info_queue, card)
            return {
                vars = { card.ability.extra.slots, card.ability.extra.credits },
            }
        end,
        can_use = function(self, card)
            if G.GAME.seeded == true and G.GAME.budget >= card.ability.extra.credits then         -- check if run is seeded, check seeded creds
                return true
            elseif G.PROFILES[G.SETTINGS.profile].TNameCredits >= card.ability.extra.credits then -- otherwise, check normal creds
                return true
            else
                return false
            end
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                func = function()
                    HPTN.ease_credits(-card.ability.extra.credits, false) -- remove credits
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
                    return true
                end,
            }))
        end,
    })
end

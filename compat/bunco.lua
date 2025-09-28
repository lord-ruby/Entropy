if (SMODS.Mods["Bunco"] or {}).can_load then

    --TODO: make this not crash the game lmao
    --Also not too fond of this name feel free to change it
    local rectification = {
        dependencies = {
            items = {
                "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = -900 + 34,
        key = "rectification",
        set = "Fraud",

        inversion = "c_bunc_adjustment",

        atlas = "crossmod_consumables",
        config = {
            select = 2
        },
        pos = {x=8,y=0},
        use = function(self, card2)
            local cards = Entropy.GetHighlightedCards({G.hand}, card2, 1, card2.ability.select)
            for i, v in pairs(cards) do
                local card = cards[i]
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.banned_keys[card.config.center.key] = true
                        return true
                    end
                }))
            end

        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            return num > 0 and num <= card.ability.select
        end,
        loc_vars = function(self, q, card)
            return {
                vars = {
                    card.ability.select
                }
            }
        end,
        entr_credits = {
            idea = {"Athebyne"}
        },

        demicoloncompat = true,
        force_use = function(self, card)
            self:use(card)
        end
    }

    --TODO: make this open regular size boosters instead of megas. Also make it directly open the pack instead of giving tags.
    --This is a dumb workaround because idk how the hell i'd make it instantly open the pack rn.
    local avarice = {
        dependencies = {
            items = {
                "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = -900 + 35,
        key = "avarice",
        set = "Fraud",

        inversion = "c_bunc_lust",

        atlas = "crossmod_consumables",
        config = {
            boosters = 3
        },
        pos = {x=10,y=0},
        use = function(self, card)
            for i = 1, math.min(card.ability.boosters, 20) do
                tag = Tag("tag_standard")
                add_tag(tag)
            end

        end,
        can_use = function(self, card)
            return true
        end,
        loc_vars = function(self, q, card) return {vars = {math.min(card.ability.boosters, 20)}} end,
        entr_credits = {
            idea = {"Athebyne"}
        },

        demicoloncompat = true,
        force_use = function(self, card)
            self:use(card)
        end
    }

    local symphony = {
        dependencies = {
            items = {
                "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = -900 + 36,
        key = "symphony",
        set = "Fraud",

        inversion = "c_bunc_art",

        atlas = "crossmod_consumables",
        config = {
            min_highlighted = 2,
            max_highlighted = 2
        },
        pos = {x=9,y=0},
        use = function(self, card)
            link_cards(G.hand.highlighted, self.key)
            card:juice_up(0.3, 0.5)
            end,
        can_use = function(self, card)
            if G.hand then
                local cards = G.hand.highlighted
                -- Group check:
                for i = 1, #cards do
                    if cards[i].ability.group then return false end
                end
                if #cards > 1 and #cards <= card.ability.max_highlighted then
                    return true
                end
            end
            return false
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.min_highlighted
                }
            }
        end,
        entr_credits = {
            idea = {"Athebyne"}
        },

        demicoloncompat = true,
        force_use = function(self, card)
            self:use(card)
        end
    }

    local microcosm = {
        dependencies = {
            items = {
                "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = -900 + 37,
        key = "microcosm",
        set = "Fraud",

        inversion = "c_bunc_universe",

        atlas = "crossmod_consumables",
        config = {
            min_highlighted = 3,
            max_highlighted = 3
        },
        pos = {x=11,y=0},
        use = function(self, card)
            local new_suit = pseudorandom_element(SMODS.Suits, pseudoseed('microcosm')).key
            local new_rank = pseudorandom_element(SMODS.Ranks, pseudoseed('microcosm')).key
            for _, playing_card in ipairs(G.hand.cards) do
                if playing_card.highlighted then
                    G.E_MANAGER:add_event(Event({delay = 0.2, trigger = 'before', func = function()
                        i = i and (i + 1) or 1
                        play_sound('card1', 0.85 + (i * 0.05))
                        playing_card:juice_up(0.7)
                        SMODS.change_base(playing_card, new_suit, new_rank)
                        return true end}))
                end
            end
        end,
        can_use = function(self, card)
            if G.hand and #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted >= card.ability.min_highlighted then
                return true
            end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.max_highlighted
                }
            }
        end,
        entr_credits = {
            idea = {"Athebyne"}
        },

        demicoloncompat = true,
        force_use = function(self, card)
            self:use(card)
        end
    }

    local desert = {
        dependencies = {
            items = {
                "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = -900 + 38,
        key = "desert",
        set = "Fraud",

        inversion = "c_bunc_sky",

        atlas = "crossmod_consumables",
        config = {
            -- consistent with bunco's exotic suits, buffs to them are stronger than buffs to the standard four.
            per_level = 15
        },
        pos = {x=8,y=1},
        use = function(self, card2)
            Entropy.LevelSuit("bunc_Fleurons", card2, 1, card2.ability.per_level)
        end,
        bulk_use = function(self, card2, _, _, amount)
            Entropy.LevelSuit("bunc_Fleurons", card2, amount, card2.ability.per_level)
        end,
        can_use = function(self, card)
            return true
        end,
        loc_vars = function(self, q, card)
            if not G.GAME.SuitBuffs then G.GAME.SuitBuffs = {} end
            if not G.GAME.SuitBuffs["bunc_Fleurons"] then G.GAME.SuitBuffs["bunc_Fleurons"] = {} end
            return {
                vars = {
                    G.GAME.SuitBuffs["bunc_Fleurons"].level or 1,
                    "",
                    localize("bunc_Fleurons",'suits_plural'),
                    card.ability.per_level,
                    colours = {
                        to_big(G.GAME.SuitBuffs["bunc_Fleurons"].level or 1) < to_big(2) and G.C.BLACK or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.SuitBuffs["bunc_Fleurons"].level or 1))]
                    }
                }
            }
        end,
        in_pool = function(self)
            return BUNCOMOD.funcs.exotic_in_pool()
        end,
        entr_credits = {
            idea = {"Athebyne"}
        },
        demicoloncompat = true,
        force_use = function(self, card)
            self:use(card)
        end
    }

    local metropolis = {
        dependencies = {
            items = {
                "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = -900 + 39,
        key = "metropolis",
        set = "Fraud",

        inversion = "c_bunc_abyss",

        atlas = "crossmod_consumables",
        config = {
            -- consistent with bunco's exotic suits, buffs to them are stronger than buffs to the standard four.
            per_level = 15
        },
        pos = {x=9,y=1},
        use = function(self, card2)
            Entropy.LevelSuit("bunc_Halberds", card2, 1, card2.ability.per_level)
        end,
        bulk_use = function(self, card2, _, _, amount)
            Entropy.LevelSuit("bunc_Halberds", card2, amount, card2.ability.per_level)
        end,
        can_use = function(self, card)
            return true
        end,
        loc_vars = function(self, q, card)
            if not G.GAME.SuitBuffs then G.GAME.SuitBuffs = {} end
            if not G.GAME.SuitBuffs["bunc_Halberds"] then G.GAME.SuitBuffs["bunc_Halberds"] = {} end
            return {
                vars = {
                    G.GAME.SuitBuffs["bunc_Halberds"].level or 1,
                    "",
                    localize("bunc_Halberds",'suits_plural'),
                    card.ability.per_level,
                    colours = {
                        to_big(G.GAME.SuitBuffs["bunc_Halberds"].level or 1) < to_big(2) and G.C.BLACK or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.SuitBuffs["bunc_Halberds"].level or 1))]
                    }
                }
            }
        end,
        in_pool = function(self)
            return BUNCOMOD.funcs.exotic_in_pool()
        end,
        entr_credits = {
            idea = {"Athebyne"}
        },
        demicoloncompat = true,
        force_use = function(self, card)
            self:use(card)
        end
    }

    return {
        items = {
            rectification,
            avarice,
            symphony,
            microcosm,
            desert,
            metropolis
        }
    }
end
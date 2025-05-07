-- 0 - The Fool -     The Master (Coded)
-- 1 - The Magician -    The Carpenter
-- 2 - The High Priestess -    The Oracle
-- 3 - The Empress -    The Princess
-- 4 - The Emperor -    The Servant (Coded)
-- 5 - The Hierophant -    The Heretic
-- 6 - The Lovers -     The Feud
-- 7 - The Chariot -     The Scar
-- 8 - Justice -     The Dagger
-- 9 - The Hermit -     The Earl
-- 10 - The Wheel of Fortune -   Whetstone (idk about this one) (Coded)
-- 11 - Strength -     Endurance (Coded)
-- 12 - The Hanged Man -    The Advisor
-- 13 - Death -    The Statue (Coded)
-- 14 - Temperance -    The Feast (Coded)
-- 15 - The Devil -     The Companion
-- 16 - The Tower -   The Village
-- 17 - The Star -    The Ocean
-- 18 - The Moon -     The Forest
-- 19 - The Sun -     The Mountain --cassknows & lfmoth
-- 20 - Judgement -     Forgiveness
-- 21 - The World -     The Tent
-- 22 - The Eclipse -     Penumbra
-- 23 - Blessing -     The Prophecy
-- 24 - The Seraph -     The Imp --lfmoth
-- 25 - Instability -     Integrity
-- 32 - The Automaton -     The Mallet
local master = {
    key = "master",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -900,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    use = function(self, card, area, copier)
        local c = create_card(G.GAME.last_inversion.set, G.consumeables, nil, nil, nil, nil, G.GAME.last_inversion.key)
        G.GAME.last_inversion = nil
        c:add_to_deck()
        G.consumeables:emplace(c)
    end,
    can_use = function(self, card)
        return G.GAME.last_inversion
	end,
    loc_vars = function(self, q, card)
        card.ability.last_inversion = G.GAME.last_inversion and G.localization.descriptions[G.GAME.last_inversion.set][G.GAME.last_inversion.key].name or "None"
        return {
            main_end = (card.area and (card.area == G.consumeables or card.area == G.pack_cards or card.area == G.hand)) and {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "m",
								colour = G.C.JOKER_GREY,
								r = 0.05,
								padding = 0.1,
								func = "has_inversion",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "last_inversion",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.32*0.8,
									},
								},
							},
						},
					},
				},
			} or nil,
        }
    end,
    can_stack = true,
	can_divide = true,
}
local servant = {
    key = "servant",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -900 + 4,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 1,
        create = 1
    },
    pos = {x=4, y = 0},
    use = function(self, card, area, copier)
        local num, cards = Entropy.GetHighlightedCards({G.hand, G.consumeables}, nil, card)
        for i, v in pairs(cards) do
            if Entropy.FlipsideInversions[v.config.center.key] then
                local set = G.P_CENTERS[Entropy.FlipsideInversions[v.config.center.key]].set
                for i = 1, card.ability.create do
                    if #G.consumeables.cards < G.consumeables.config.card_limit then
                        local c = create_card(set, G.consumeables, nil, nil, nil, nil, nil)
                        G.GAME.last_inversion = nil
                        c:add_to_deck()
                        G.consumeables:emplace(c)
                    end
                end
            end
        end
    end,
    can_use = function(self, card)
        local num, cards = Entropy.GetHighlightedCards({G.hand, G.consumeables}, nil, card)
        return num > 0 and num <= card.ability.select and Entropy.TableAny(cards, function(value) return Entropy.FlipsideInversions[value.config.center.key] end)
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select,
                card.ability.create
            }
        }
    end,
    can_stack = true,
	can_divide = true,
}

local whetstone = {
    key = "whetstone",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+10,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 2,
        extra = {odds = 2}
    },
    pos = {x=0,y=1},
    use = function(self, card2)
        if pseudorandom("whetstone")
        < cry_prob(card2.ability.cry_prob, card2.ability.extra.odds, card2.ability.cry_rigged) / card2.ability.extra.odds then
            local cards = Entropy.GetHighlightedCards({G.hand}, card)
            Entropy.FlipThen(cards, function(card)
                local enh = Entropy.UpgradeEnhancement(card)
                card:set_ability(G.P_CENTERS[enh])
                for i = 1, math.floor(pseudorandom("whetstone")*2+0.5) do
                    enh = Entropy.UpgradeEnhancement(card)
                    card:set_ability(G.P_CENTERS[enh])
                end
                if enh ~= card.config.center.key then
                    card:set_ability(G.P_CENTERS[enh])
                end
            end)
        else
            local used_tarot = card2
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                  text = localize('k_nope_ex'),
                  scale = 1.3, 
                  hold = 1.4,
                  major = used_tarot,
                  backdrop_colour = G.C.RED,
                  align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                  offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                  silent = true
                  })
                  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4);return true end}))
                  play_sound('tarot2', 1, 0.4)
                  used_tarot:juice_up(0.3, 0.5)
              return true end }))
        end
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        --q[#q+1] = G.P_CENTERS.m_stone
        return {
            vars = {
                cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged),
                card.ability.extra.odds,
                card.ability.select
            }
        }
    end,
    can_stack = true,
	can_divide = true,
}

local endurance = {
    key = "endurance",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+11,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 1,
        factor = 1.5
    },
    pos = {x=1,y=1},
    use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables}, card)
        Entropy.FlipThen(cards, function(card)
            card.ability.perishable = true -- Done manually to bypass perish compat
            card.ability.perish_tally = G.GAME.perishable_rounds
            if not Card.no(card, "immutable", true) then
                Cryptid.with_deck_effects(card, function(card3)
                    Cryptid.misprintize(card3, { min=card2.ability.factor,max=card2.ability.factor }, nil, true)
                end)
            end
        end)
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables}, card)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "perishable", set="Other", vars = {5, 5}}
        return {
            vars = {
                card.ability.select,
                card.ability.factor
            }
        }
    end,
    can_stack = true,
	can_divide = true,
}

local statue = {
    key = "statue",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+13,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        convert_per = 3,
        select = 1
    },
    pos = {x=3,y=1},
    use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.hand}, card)
        Entropy.FlipThen(cards, function(card)
            card:set_ability(G.P_CENTERS.m_stone)
            card:set_edition()
            card.seal = nil
        end)
        G.E_MANAGER:add_event(Event({
			func = function()
                for i = 1, card2.ability.convert_per do
                    local card3 = pseudorandom_element(G.deck.cards, pseudoseed("statue"))
                    copy_card(#cards == 1 and cards[1] or pseudorandom_element(cards, pseudoseed("statue")), card3)
                end
                return true
            end
        }))
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card)
        return num > 0 and num <= card.ability.select and #G.hand.cards > 0
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.m_stone
        return {
            vars = {
                card.ability.convert_per,
                card.ability.select
            }
        }
    end,
    can_stack = true,
	can_divide = true,
}

local feast = {
    key = "feast",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+14,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 2
    },
    pos = {x=4,y=1},
    use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.shop_jokers, G.shop_booster, G.shop_vouchers}, card)
        for i, v in pairs(cards) do
            local card = cards[i]
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_dollars(card.cost)
                    card:start_dissolve()
                    return true
                end
            }))
        end
            
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.shop_jokers, G.shop_booster, G.shop_vouchers}, card)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select
            }
        }
    end,
    can_stack = true,
	can_divide = true,
}
return {
    items = {
        master,
        statue,
        whetstone,
        feast,
        servant,
        endurance
    }
}
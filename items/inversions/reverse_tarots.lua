-- 0 - The Fool -     The Master (Coded)
-- 1 - The Magician -    The Mason
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
    inversion = "c_fool",
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
        card.ability.last_inversion = G.GAME.last_inversion and G.GAME.last_inversion.set and G.localization.descriptions[G.GAME.last_inversion.set][G.GAME.last_inversion.key].name or "None"
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
    
	
}

local mason = {
    key = "mason",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -900 + 1,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        create = 2
    },
    inversion = "c_magician",
    pos = {x=1, y = 0},
    use = function(self, card, area, copier)
        for i = 1, to_number(math.min(card.ability.create, 100)) do
            local card = SMODS.create_card({
                key = "m_stone",
                area = G.hand
            })
            SMODS.change_base(card, "entr_nilsuit", "entr_nilrank")
            card:set_edition(pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("mason")).key)
            G.hand:emplace(card)
            table.insert(G.playing_cards, card)
        end
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                math.min(card.ability.create, 100)
            }
        }
    end,
    
	entr_credits = {
        art = {"Lyman"}
    }
}

local oracle = {
    key = "oracle",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -900 + 2,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        change = 1
    },
    inversion = "c_high_priestess",
    pos = {x=2, y = 0},
    use = function(self, card, area, copier)
        local cards = {}
        for i, v in pairs(G.hand.cards) do cards[#cards+1]=v end
        pseudoshuffle(cards, pseudoseed('oracle_cards'))
        local actual = {}
        for i = 1, card.ability.change do
            actual[i] = cards[i]
        end
        Entropy.FlipThen(actual, function(card)
            card:set_ability(pseudorandom_element(G.P_CENTER_POOLS.RPlanet, pseudoseed("oracle_ccd")))
            card:set_edition(pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("oracle_edition")).key)
        end)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.change
            }
        }
    end,
}


local princess = {
    key = "princess",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -900 + 3,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 1,
        create = 1
    },
    inversion = "c_empress",
    pos = {x=3, y = 0},
    use = function(self, card, area, copier)
        G.GAME.entr_princess = true
        for i, v in ipairs(G.I.CARD) do
            if v.config and v.config.center and v.config.center.set == "Planet" and Entropy.FlipsideInversions[v.config.center.key] then
                v:set_ability(G.P_CENTERS[Entropy.FlipsideInversions[v.config.center.key]])
            end
        end
    end,
    can_use = function(self, card)
        return not G.GAME.entr_princess
	end,
    loc_vars = function(self, q, card)
    end,
    
	
    entr_credits = {
        idea = {"crabus"},
        art = {"Lyman"}
    }
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
    inversion = "c_emperor",
    pos = {x=4, y = 0},
    use = function(self, card, area, copier)
        local cards = Entropy.GetHighlightedCards({G.hand, G.consumeables}, card)
        for i, v in pairs(cards) do
            if Entropy.FlipsideInversions[v.config.center.key] then
                local set = G.P_CENTERS[Entropy.FlipsideInversions[v.config.center.key]].set
                for i = 1, card.ability.create do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if G.consumeables.config.card_count < G.consumeables.config.card_limit then
                                local c = create_card(set, G.consumeables, nil, nil, nil, nil, nil)
                                G.GAME.last_inversion = nil
                                c:add_to_deck()
                                G.consumeables:emplace(c)
                            end
                            return true
                        end
                    }))
                end
            end
        end
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand, G.consumeables}, card)
        local num = #cards
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
    entr_credits = {
        art = {"Lyman"}
    }
	
}

local heretic = {
    key = "heretic",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -900 + 6,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 2,
    },
    inversion = "c_hierophant",
    pos = {x=5, y = 0},
    use = function(self, card, area, copier)
        local cards = Entropy.GetHighlightedCards({G.hand}, card)
        Entropy.FlipThen(cards, function(card)
            local modification = pseudorandom_element({"Seal", "Enhancement", "Edition", "Suit", "Rank"}, pseudoseed("heretic_modification"))
            if modification == "Seal" then
                local seal = pseudorandom_element(SMODS.Seal.obj_table, pseudoseed("heretic_seal")).key
                card:set_seal(seal)
            end
            if modification == "Edition" then
                local edition = pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("heretic_edition")).key
                card:set_edition(edition)
            end
            if modification == "Enhancement" then
                local enhancement = pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed("heretic_enhancement")).key
                while G.P_CENTERS[enhancement].no_doe or G.GAME.banned_keys[enhancement] do
                    enhancement = pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed("heretic_enhancement")).key
                end
                card:set_ability(G.P_CENTERS[enhancement])
            end
            if modification == "Suit" or modification == "Rank" then
                local suit = modification == "Suit" and pseudorandom_element({"Spades", "Hearts", "Clubs", "Diamonds"}, pseudoseed("heretic_suit"))
                local rank = modification == "Rank" and pseudorandom_element({"2", "3", "4", "5", "6", "7", "8", "9", "10", "Ace", "King", "Queen", "Jack"}, pseudoseed("heretic_rank"))
                SMODS.change_base(card, suit, rank)
            end
        end)
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand}, card)
        local num = #cards
        return num > 0 and num <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select,
            }
        }
    end,
    
	
    entr_credits = {
        idea = {"notmario"}
    }
}

local feud = {
    key = "feud",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -900 + 6,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 2,
    },
    inversion = "c_lovers",
    pos = {x=6, y = 0},
    use = function(self, card, area, copier)
        local cards = Entropy.GetHighlightedCards({{highlighted = Entropy.FilterTable(G.hand.cards, function(card) return card.highlighted end)}}, card)
        local chips = 0
        local bonus_chips = 0
        for i = 2, to_number(card.ability.select) do
            local new_card = cards[i]
            if new_card then
                chips = chips + new_card.base.nominal
                bonus_chips = bonus_chips + (new_card.ability and new_card.ability.bonus or 0)
                new_card:start_dissolve()
            end
        end
        Entropy.FlipThen(cards, function(card)
            card.base.nominal = card.base.nominal + chips
            if to_big(bonus_chips) > to_big(0) then
                card.ability.bonus = bonus_chips
            end
        end)
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand}, card)
        local num = #cards
        return num >= 2 and num <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select,
                to_big(card.ability.select) > to_big(2) and 2 or 1,
            }
        }
    end,
    
	
}


local scar = {
    key = "scar",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -900 + 7,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 2,
    },
    inversion = "c_chariot",
    pos = {x=7, y = 0},
    use = function(self, card, area, copier)
        local cards = Entropy.GetHighlightedCards({G.hand}, card)
        Entropy.FlipThen(cards, function(card)
            Entropy.ApplySticker(card, "scarred")
        end)
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand, G.consumeables}, card)
        local num = #cards
        return num > 0 and num <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {set = "Other", key = "scarred"}
        return {
            vars = {
                card.ability.select,
            }
        }
    end,
    
	
}


local scarred = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Sticker",
    order = -901,
    atlas = "entr_stickers",
    pos = { x = 6, y = 1 },
    key = "scarred",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("973737"),
    apply = function(self,card,val)
        card.ability.scarred = true
    end,
}

local dagger = {
    key = "dagger",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -900 + 8,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 1,
        sellmult = 2
    },
    inversion = "c_justice",
    pos = {x=8, y = 0},
    use = function(self, card2, area, copier)
        local cards = Entropy.GetHighlightedCards({G.jokers}, card2)
        local total = 0
        local _hand, _tally = nil, -1
		for k, v in ipairs(G.handlist) do
			if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
				_hand = v
				_tally = G.GAME.hands[v].played
			end
		end
        for i, card in ipairs(cards) do
            total = total + card.sell_cost * card2.ability.sellmult
        end
        Entropy.FlipThen(cards, function(card)
            if not card.ability.eternal then
                card:start_dissolve()
            end
        end)
        delay(0.6)
        update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { mult = "+"..total, handname = localize(_hand, "poker_hands") })
        delay(2.6)
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
          { mult = 0, chips = 0, handname = "", level = "" }
        )
        G.GAME.hands[_hand].mult = G.GAME.hands[_hand].mult + total
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.jokers}, card)
        local num = #cards
        return num > 0 and num <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select,
                card.ability.sellmult
            }
        }
    end,
    
	entr_credits = {
        art = {"Lyman"}
    }
}

local earl = {
    key = "earl",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -900 + 8,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        max = 20,
    },
    inversion = "c_hermit",
    pos = {x=9, y = 0},
    use = function(self, card2, area, copier)
        local half = to_number(math.min(G.GAME.dollars, 20)) / 2
        ease_hands_played(half)
        ease_discard(half)
        G.GAME.earl_amount = (G.GAME.earl_amount or 0) + half
        ease_dollars(-(half*2))
    end,
    can_use = function(self, card)
        return to_big(G.GAME.dollars) > to_big(0) and G.STATE == G.STATES.SELECTING_HAND
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.max
            }
        }
    end,
    
	
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
    inversion = "c_wheel_of_fortune",
    pos = {x=0,y=1},
    use = function(self, card2)
        if pseudorandom("whetstone")
        < cry_prob(card2.ability.cry_prob, card2.ability.extra.odds, card2.ability.cry_rigged) / card2.ability.extra.odds then
            local cards = Entropy.GetHighlightedCards({G.hand}, card)
            Entropy.FlipThen(cards, function(card)
                local enh = Entropy.UpgradeEnhancement(card, false, {m_entr_disavowed = true})
                if G.P_CENTERS[enh] then
                    card:set_ability(G.P_CENTERS[enh])
                    for i = 1, math.floor(pseudorandom("whetstone")*3+0.5) do
                        enh = Entropy.UpgradeEnhancement(card, false, {m_entr_disavowed = true})
                        card:set_ability(G.P_CENTERS[enh])
                    end
                    if enh ~= card.config.center.key then
                        card:set_ability(G.P_CENTERS[enh])
                    end
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
    inversion = "c_strength",
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
    
	
}

local advisor = {
    key = "advisor",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+12,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    pos = {x=2,y=1},
    inversion = "c_hanged_man",
    use = function(self, card2)
        num = 0
        hand = "High Card"
        for i, v in pairs(G.GAME.hands) do
            if v.played > num and v.played > 0 then
                num = v.played
                hand = i
            end
        end 
        for i, v in pairs(SMODS.PokerHands) do
            if v.played > num and v.played > 0 then
                num = v.played
                hand = i
            end
        end 
        local example = (G.GAME.hands[hand] or SMODS.PokerHands[hand]).example
        for k, v in ipairs(example) do
            if v[2] == true then
                local card = Card(0,0, G.CARD_W, G.CARD_H, G.P_CARDS[v[1]], G.P_CENTERS.c_base)
                if v[3] then
                    card:set_ability(G.P_CENTERS[v[3]])
                end
                G.hand:emplace(card)
                card.ability.temporary = true
            end
        end
    end,
    can_use = function(self, card)
        return G.STATE == G.STATES.SELECTING_HAND
	end,
    
	
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
    inversion = "c_death",
    pos = {x=3,y=1},
    use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.hand}, card)
        G.E_MANAGER:add_event(Event({
			func = function()
                for i = 1, card2.ability.convert_per do
                    local card3 = pseudorandom_element(G.deck.cards, pseudoseed("statue"))
                    copy_card(#cards == 1 and cards[1] or pseudorandom_element(cards, pseudoseed("statue")), card3)
                end
                Entropy.FlipThen(cards, function(card)
                    card:set_ability(G.P_CENTERS.m_stone)
                    card:set_edition()
                    card.seal = nil
                end)
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
    inversion = "c_temperance",
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
    
	entr_credits = {
        art = {"Lyman"}
    }
}

local companion = {
    key = "companion",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+15,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        extra = 2
    },
    pos = {x=5,y=1},
    inversion = "c_temperance",
    use = function(self, card)
        G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.interest_cap = G.GAME.interest_cap + (card.ability.extra)
                ease_dollars(math.min(G.GAME.interest_cap, 50))
				return true
			end,
		}))
    end,
    can_use = function(self, card)
        return true
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                localize("$"),
                card.ability.extra
            }
        }
    end,
    
	entr_credits = {
        idea = {"Lyman"},
        art = {"Lyman"}
    }
}

local village = {
    key = "village",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+16,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        chips=10
    },
    pos = {x=6,y=1},
    inversion = "c_star",
    use = function(self, card2)
        Entropy.FlipThen(G.hand.cards, function(card)
            card.ability.bonus = (card.ability.bonus or 0) + card2.ability.chips
        end)
    end,
    bulk_use = function(self, card2, _, _, amount)
        Entropy.FlipThen(G.hand.cards, function(card)
            card.ability.bonus = (card.ability.bonus or 0) + card2.ability.chips * amount
        end)
    end,
    can_use = function(self, card)
        return true
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.chips
            }
        }
    end,
}

local ocean = {
    key = "ocean",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+17,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        per_level=10
    },
    pos = {x=7,y=1},
    inversion = "c_star",
    use = function(self, card2)
        Entropy.LevelSuit("Diamonds", card2, card2.ability.per_level)
    end,
    bulk_use = function(self, card2, _, _, amount)
        Entropy.LevelSuit("Diamonds", card2, card2.ability.per_level*amount)
    end,
    can_use = function(self, card)
        return true
    end,
    loc_vars = function(self, q, card)
        if not G.GAME.SuitBuffs then G.GAME.SuitBuffs = {} end
        if not G.GAME.SuitBuffs["Diamonds"] then G.GAME.SuitBuffs["Diamonds"] = {} end
        return {
            vars = {
                G.GAME.SuitBuffs["Diamonds"].level or 1,
                "",
                localize("Diamonds",'suits_plural'),
                card.ability.per_level,
                colours = {
                    to_big(G.GAME.SuitBuffs["Diamonds"].level or 1) < to_big(2) and G.C.BLACK or G.C.HAND_LEVELS[to_big(math.min(7, G.GAME.SuitBuffs["Diamonds"].level or 1)):to_number()]
                }
            }
        }
    end,
}

local forest = {
    key = "forest",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+18,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        per_level=10
    },
    pos = {x=8,y=1},
    inversion = "c_moon",
    use = function(self, card2)
        Entropy.LevelSuit("Clubs", card2, card2.ability.per_level)
    end,
    bulk_use = function(self, card2, _, _, amount)
        Entropy.LevelSuit("Clubs", card2, card2.ability.per_level*amount)
    end,
    can_use = function(self, card)
        return true
    end,
    loc_vars = function(self, q, card)
        if not G.GAME.SuitBuffs then G.GAME.SuitBuffs = {} end
        if not G.GAME.SuitBuffs["Clubs"] then G.GAME.SuitBuffs["Clubs"] = {} end
        return {
            vars = {
                G.GAME.SuitBuffs["Clubs"].level or 1,
                "",
                localize("Clubs",'suits_plural'),
                card.ability.per_level,
                colours = {
                    to_big(G.GAME.SuitBuffs["Clubs"].level or 1) < to_big(2) and G.C.BLACK or G.C.HAND_LEVELS[to_big(math.min(7, G.GAME.SuitBuffs["Clubs"].level or 1)):to_number()]
                }
            }
        }
    end,
    entr_credits = {
        art = {"notmario"}
    }
}

local mountain = {
    key = "mountain",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+19,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        per_level=10
    },
    pos = {x=9,y=1},
    inversion = "c_sun",
    use = function(self, card2)
        Entropy.LevelSuit("Hearts", card2, card2.ability.per_level)
    end,
    bulk_use = function(self, card2, _, _, amount)
        Entropy.LevelSuit("Hearts", card2, card2.ability.per_level*amount)
    end,
    can_use = function(self, card)
        return true
    end,
    loc_vars = function(self, q, card)
        if not G.GAME.SuitBuffs then G.GAME.SuitBuffs = {} end
        if not G.GAME.SuitBuffs["Hearts"] then G.GAME.SuitBuffs["Hearts"] = {} end
        return {
            vars = {
                G.GAME.SuitBuffs["Hearts"].level or 1,
                "",
                localize("Hearts",'suits_plural'),
                card.ability.per_level,
                colours = {
                    to_big(G.GAME.SuitBuffs["Hearts"].level or 1) < to_big(2) and G.C.BLACK or G.C.HAND_LEVELS[to_big(math.min(7, G.GAME.SuitBuffs["Hearts"].level or 1)):to_number()]
                }
            }
        }
    end,
    entr_credits = {
        art = {"lfmoth"}
    }
}

local forgiveness = {
    key = "forgiveness",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+20,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    pos = {x=0,y=2},
    inversion = "c_judgement",
    use = function(self, card2)
        local new_card = create_card(
            "Joker",
            G.jokers,
            nil,
            nil,
            nil,
            nil,
            G.GAME.jokers_sold[pseudorandom("entr_forgiveness", 1, #G.GAME.jokers_sold)]
        )
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
        new_card:start_materialize()
    end,
    can_use = function(self, card)
        local num = G.GAME.jokers_sold and #G.GAME.jokers_sold or 0
        return num > 0
    end,
    
	
    entr_credits = {
        idea = "cassknows"
    }
}

local tent = {
    key = "tent",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+21,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        per_level=10
    },
    pos = {x=1,y=2},
    inversion = "c_world",
    use = function(self, card2)
        Entropy.LevelSuit("Spades", card2, card2.ability.per_level)
    end,
    bulk_use = function(self, card2, _, _, amount)
        Entropy.LevelSuit("Spades", card2, card2.ability.per_level*amount)
    end,
    can_use = function(self, card)
        return true
    end,
    loc_vars = function(self, q, card)
        if not G.GAME.SuitBuffs then G.GAME.SuitBuffs = {} end
        if not G.GAME.SuitBuffs["Spades"] then G.GAME.SuitBuffs["Spades"] = {} end
        return {
            vars = {
                G.GAME.SuitBuffs["Spades"].level or 1,
                "",
                localize("Spades",'suits_plural'),
                card.ability.per_level,
                colours = {
                  to_big(G.GAME.SuitBuffs["Spades"].level or 1) < to_big(2) and G.C.BLACK or G.C.HAND_LEVELS[to_big(math.min(7, G.GAME.SuitBuffs["Spades"].level or 1)):to_number()]
                }
            }
        }
    end,
}

local penumbra = {
    key = "penumbra",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+22,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 1
    },
    pos = {x=2,y=2},
    inversion = "c_cry_eclipse",
    use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.hand}, card)
        for i, v in pairs(cards) do
            local card = cards[i]
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:start_dissolve()
                    if card.config.center.key ~= "c_base" then G.GAME.banned_keys[card.config.center.key] = true end
                    return true
                end
            }))
        end
            
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select
            }
        }
    end,
    
	
}

local prophecy = {
    key = "prophecy",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -900+23,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    inversion = "c_cry_blessing",
    pos = {x=3,y=2},
    config = {
        counter = 2
    },
    use = function(self, card, area, copier)
        G.GAME.next_inversions_prophecy = G.GAME.last_rtarot.key
        G.GAME.last_rtarot = nil
        G.GAME.inversions_prophecy_counter = card.ability.counter
    end,
    can_use = function(self, card)
        return G.GAME.last_rtarot
	end,
    loc_vars = function(self, q, card)
        card.ability.last_rtarot = G.GAME.last_rtarot and G.GAME.last_rtarot.set and G.localization.descriptions[G.GAME.last_rtarot.set][G.GAME.last_rtarot.key].name or "None"
        return {
            vars = {
                card.ability.counter
            },
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
								func = "has_rtarot",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "last_rtarot",
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
    entr_credits = {
        idea = {"cassknows"}
    }
	
}

local imp = {
    key = "imp",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+24,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 2
    },
    pos = {x=4,y=2},
    inversion = "c_cry_seraph",
    use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.hand}, card)
        Entropy.FlipThen(cards, function(card)
            card:set_ability(G.P_CENTERS.m_entr_dark)
        end)
            
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.m_entr_dark
        return {
            vars = {
                card.ability.select
            }
        }
    end,
    
	
    entr_credits = {
        art = {"lfmoth"}
    }
}

local integrity = {
    key = "integrity",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+25,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 2
    },
    pos = {x=5,y=2},
    inversion = "c_cry_instability",
    use = function(self, card2)
        local cards = Entropy.FilterTable(Entropy.GetHighlightedCards({G.hand}, card), function(card) return card.config.center.key ~= "c_base" end)
        Entropy.FlipThen(cards, function(card)
            local edition = pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("entropy")).key
            local seal = pseudorandom_element(G.P_CENTER_POOLS.Seal, pseudoseed("entropy")).key
            card:set_edition(edition)
            card:set_seal(seal)
            card:set_ability(G.P_CENTERS.c_base)
        end)
            
    end,
    can_use = function(self, card)
        local num = #Entropy.FilterTable(Entropy.GetHighlightedCards({G.hand}, card), function(card) return card.config.center.key ~= "c_base" end)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select
            }
        }
    end,
    
	
}

local mallet = {
    key = "mallet",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+32,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        create = 1
    },
    pos = {x=6,y=2},
    inversion = "c_cry_automaton",
    use = function(self, card2)
        local cards = {}
        for i, v in pairs(G.hand.cards) do cards[#cards+1]=v end
        pseudoshuffle(cards, pseudoseed('immolate'))
        local actual = {}
        for i = 1, card2.ability.create do
            actual[i] = cards[i]
        end
        for i, v in ipairs(actual) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.consumeables.config.card_count < G.consumeables.config.card_limit then
                        SMODS.add_card({
                            set = "RCode",
                            area = G.consumeables
                        })
                    end
                    return true
                end
            }))
            v:start_dissolve()
        end
    end,
    can_use = function(self, card)
        return G.STATE == G.STATES.SELECTING_HAND
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.create
            }
        }
    end,
}

return {
    items = {
        master,
        statue,
        whetstone,
        feast,
        servant,
        endurance,
        scarred,
        scar,
        dagger,
        penumbra,
        integrity,
        forgiveness,
        feud,
        advisor,
        heretic,
        earl,
        mason,
        princess,
        imp,
        oracle,
        ocean,
        forest,
        mountain,
        tent,
        companion,
        prophecy,
        mallet,
        village
    }
}

local master = {
    key = "master",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    inversion = "c_fool",
    use = function(self, card, area, copier)
        if G.GAME.last_inversion then
            local tw = G.GAME.modifiers.entr_twisted
            G.GAME.modifiers.entr_twisted = nil
            local c = create_card(G.GAME.last_inversion.set, G.consumeables, nil, nil, nil, nil, G.GAME.last_inversion.key)
            G.GAME.last_inversion = nil
            c:add_to_deck()
            G.consumeables:emplace(c)
            G.GAME.modifiers.entr_twisted = tw
        end
    end,
    can_use = function(self, card)
        local fac = card.area == G.consumeables and -1 or 0
        return G.consumeables.config.card_limit > #G.consumeables.cards + fac and G.GAME.last_inversion
	end,
    loc_vars = function(self, q, card)
        card.ability.last_inversion = G.GAME.last_inversion and G.GAME.last_inversion.set and G.localization.descriptions[G.GAME.last_inversion.set] and G.localization.descriptions[G.GAME.last_inversion.set][G.GAME.last_inversion.key].name or localize('k_none')
        if G.GAME.last_inversion and card.ability.last_inversion == localize('k_none') then
            local nodes = {}
            localize{type = 'name', set = "Other", key = G.GAME.last_inversion.key, nodes = nodes}
            if not nodes[1] then
                localize{type = 'name', set = "Other", key = string.gsub(G.GAME.last_inversion.key, "_[0-9]*$", ""), nodes = nodes}
            end
            card.ability.last_inversion = nodes[1][1].nodes[1].config.object.string
        elseif G.GAME.last_inversion and G.GAME.last_inversion.key~= "c_entr_master" then
            q[#q+1] = G.P_CENTERS[G.GAME.last_inversion.key]
        end
        return {
            main_end = (card.area and (card.area == G.consumeables or card.area == G.pack_cards or card.area == G.hand or card.area == G.shop_jokers or card.area == G.shop_booster or card.area == G.shop_vouchers)) and {
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
    entr_credits = {
        art = {"MrVarius"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local mason = {
    key = "mason",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901 + 1,
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
            card:set_edition(SMODS.poll_edition({guaranteed = true, key = "entr_mason"}))
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
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local oracle = {
    key = "oracle",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901 + 2,
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
            card:set_ability(Entropy.pseudorandom_element(G.P_CENTER_POOLS.Star, pseudoseed("oracle_ccd"),function(e)
                return G.GAME.banned_keys[e.key] or e.no_doe
            end))
            card:set_edition(SMODS.poll_edition({guaranteed = true, key = "entr_oracle"}))
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
    entr_credits = {
        art = {"MrVarius"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end,
    entr_credits = {
        idea = {"cassknows"}
    },
}


local princess = {
    key = "princess",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901 + 3,
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
            if v.config and v.config.center and v.config.center.set == "Planet" and Entropy.Inversion(v.config.center) then
                v:set_ability(G.P_CENTERS[Entropy.Inversion(v.config.center)])
            end
        end
    end,
    can_use = function(self, card)
        return not G.GAME.entr_princess
	end,
    loc_vars = function(self, q, card)
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end,
	
    entr_credits = {
        idea = {"crabus"},
        art = {"Lyman"}
    }
}

local servant = {
    key = "servant",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901 + 4,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 1,
        create = 2
    },
    inversion = "c_emperor",
    pos = {x=4, y = 0},
    use = function(self, card, area, copier)
        local cards = Entropy.GetHighlightedCards({G.hand, G.consumeables}, card, 1, card.ability.select)
        for i, v in pairs(cards) do
            if Entropy.Inversion(v.config.center) then
                local set = G.P_CENTERS[Entropy.Inversion(v.config.center)].set
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
        local cards = Entropy.GetHighlightedCards({G.hand, G.consumeables}, card, 1, card.ability.select)
        local num = #cards
        return num > 0 and num <= card.ability.select and Entropy.TableAny(cards, function(value) return Entropy.Inversion(value.config.center) end)
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.create,
                card.ability.select,
            }
        }
    end,
    entr_credits = {
        art = {"Lyman"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
	
}

local heretic = {
    key = "heretic",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901 + 5.5,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 2,
    },
    inversion = "c_heirophant",
    pos = {x=5, y = 0},
    use = function(self, card, area, copier)
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
        Entropy.FlipThen(cards, function(card)
            local modification = pseudorandom_element({"Seal", "Enhancement", "Edition", "Suit", "Rank"}, pseudoseed("heretic_modification"))
            if modification == "Seal" then
                local seal = pseudorandom_element(SMODS.Seal.obj_table, pseudoseed("heretic_seal")).key
                card:set_seal(seal)
            end
            if modification == "Edition" then
                local edition = SMODS.poll_edition({guaranteed = true, key = "entr_heretic_ed"})
                card:set_edition(edition)
            end
            if modification == "Enhancement" then
                local enhancement = SMODS.poll_enhancement({guaranteed = true, key = "entr_heretic_enh"})
                card:set_ability(G.P_CENTERS[enhancement])
            end
            if modification == "Suit" or modification == "Rank" then
                Entropy.randomize_rank_suit(card, modification == "Suit", modification == "Rank", "heretic")
            end

        end)
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
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
        idea = {"notmario"},
        art = {"MrVarius"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local feud = {
    key = "feud",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901 + 6,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 2,
        chip_mult = 2
    },
    inversion = "c_lovers",
    pos = {x=6, y = 0},
    use = function(self, card, area, copier)
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
        local chips = 0
        local bonus_chips = 0
        for i = 2, to_number(card.ability.select) do
            local new_card = cards[i]
            if new_card then
                chips = chips + new_card.base.nominal
                bonus_chips = bonus_chips + (new_card.ability and new_card.ability.bonus or 0)
                SMODS.destroy_cards(new_card)
            end
        end
        local mult = card.ability.chip_mult
        Entropy.FlipThen(cards, function(card)
            card.base.nominal = card.base.nominal + chips * mult
            if to_big(bonus_chips) > to_big(0) then
                card.ability.bonus = card.ability.bonus + bonus_chips * mult
            end

        end)
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
        local num = #cards
        return num >= 2 and num <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select,
                to_big(card.ability.select) > to_big(2) and 2 or 1,
                card.ability.chip_mult
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}


local scar = {
    key = "scar",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901 + 7,
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
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
        for i, v in pairs(cards) do
            Entropy.ApplySticker(v, "scarred")
            v:juice_up()
        end

    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
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
    
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
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
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901 + 8,
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
        local cards = Entropy.GetHighlightedCards({G.hand}, card2, 1, card2.ability.select)
        local total = 0
        local _hand, _tally = nil, -1
		for k, v in ipairs(G.handlist) do
			if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
				_hand = v
				_tally = G.GAME.hands[v].played
			end
		end
        for i, card in ipairs(cards) do
            total = total + card.base.nominal + (card.ability.bonus or 0)
        end
        SMODS.destroy_cards(cards)
        update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = G.GAME.hands[_hand].level, mult = Entropy.ascend_hand(G.GAME.hands[_hand].mult, _hand), chips = Entropy.ascend_hand(G.GAME.hands[_hand].chips, _hand), handname = localize(_hand, "poker_hands") })
        delay(1.6)
        update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { chips = "+"..total, handname = localize(_hand, "poker_hands"), StatusText = true })
        delay(2.6)
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
          { mult = 0, chips = 0, handname = "", level = "" }
        )
        G.GAME.hands[_hand].chips = G.GAME.hands[_hand].chips + total
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
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
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local earl = {
    key = "earl",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901 + 9,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        per_hand = 4,
        per_discard = 3
    },
    inversion = "c_hermit",
    pos = {x=9, y = 0},
    use = function(self, card, area, copier)
        if not G.GAME.earl_modifiers then
            G.GAME.earl_modifiers = {
                discard = G.GAME.modifiers.money_per_discard,
                hand = G.GAME.modifiers.money_per_hand
            }
        end
        G.GAME.modifiers.money_per_discard = (G.GAME.modifiers.money_per_discard or 0) + card.ability.per_discard
        G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 0) + card.ability.per_hand
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                (G.GAME.modifiers.money_per_hand or 0) + card.ability.per_hand,
                (G.GAME.modifiers.money_per_discard or 0) + card.ability.per_discard
            }
        }
    end,
    
	entr_credits = {
        art = {"HexaCryonic"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local whetstone = {
    key = "whetstone",
    set = "Fraud",
    atlas = "fraud",
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
        if SMODS.pseudorandom_probability(card2, 'whetstone', 1, card2.ability.extra.odds) or G.cry_force_use then
            local cards = Entropy.GetHighlightedCards({G.hand}, card2, 1, card2.ability.select)
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
        local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        --q[#q+1] = G.P_CENTERS.m_stone
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {
            vars = {
                numerator,
                denominator,
                card.ability.select
            }
        }
    end,
    
	entr_credits = {
        art = {"MrVarius"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local endurance = {
    key = "endurance",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901+11,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 1,
        factor = 1.25,
    },
    pos = {x=1,y=1},
    inversion = "c_strength",
    use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables}, card2, 1, card2.ability.select)
        G.GAME.endurance_rounds = (G.GAME.endurance_rounds or 3)
        for i, card in pairs(cards) do
            card.ability.debuff_timer = (card.ability.debuff_timer or 0) + G.GAME.endurance_rounds
            card.ability.debuff_timer_max = (card.ability.debuff_timer_max or 0) + G.GAME.endurance_rounds
            if not Card.no(card, "immutable", true) then
                Cryptid.manipulate(card, { value=card2.ability.factor })
            end
            card:set_debuff(true)
            card:juice_up()
        end
        G.GAME.endurance_rounds = G.GAME.endurance_rounds + 1
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables}, card, 1, card.ability.select)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select,
                card.ability.factor,
                G.GAME.endurance_rounds or 3 
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
	
}

local advisor = {
    key = "advisor",
    set = "Fraud",
    atlas = "fraud",
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
    entr_credits = {
        art = {"Ein13"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local statue = {
    key = "statue",
    set = "Fraud",
    atlas = "fraud",
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
        local cards = Entropy.GetHighlightedCards({G.hand}, card2, 1, card2.ability.select)
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
                    G.hand:remove_from_highlighted(card)
                end)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
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
    entr_credits = {
        art = {"LFMoth"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local feast = {
    key = "feast",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901+14,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 2,
        multiplier = 2
    },
    pos = {x=4,y=1},
    inversion = "c_temperance",
    use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.shop_jokers, G.shop_booster, G.shop_vouchers}, card2, 1, card2.ability.select)
        for i, v in pairs(cards) do
            local card = cards[i]
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_dollars(card.cost * card2.ability.multiplier)
                    card:start_dissolve()
                    return true
                end
            }))
        end
            
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.shop_jokers, G.shop_booster, G.shop_vouchers}, card, 1, card.ability.select)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select,
                card.ability.multiplier
            }
        }
    end,
    
	entr_credits = {
        art = {"Lyman"}
    },
}

local companion = {
    key = "companion",
    set = "Fraud",
    atlas = "fraud",
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
    inversion = "c_devil",
    use = function(self, card)
        G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.companion_interest_cap = (G.GAME.companion_interest_cap or 0) + (card.ability.extra)
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
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local village = {
    key = "village",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901+16,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        chips=15
    },
    pos = {x=6,y=1},
    inversion = "c_tower",
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
        return G.hand and #G.hand.cards > 0
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.chips
            }
        }
    end,
    entr_credits = {
        art = {"Ein13"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local ocean = {
    key = "ocean",
    set = "Fraud",
    atlas = "fraud",
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
        Entropy.LevelSuit("Diamonds", card2, 1, card2.ability.per_level)
    end,
    bulk_use = function(self, card2, _, _, amount)
        Entropy.LevelSuit("Diamonds", card2, amount, card2.ability.per_level)
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
                    to_big(G.GAME.SuitBuffs["Diamonds"].level or 1) < to_big(2) and G.C.BLACK or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.SuitBuffs["Diamonds"].level or 1))]
                }
            }
        }
    end,
    etnr_credits = {
        art = {"Lyman"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local forest = {
    key = "forest",
    set = "Fraud",
    atlas = "fraud",
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
        Entropy.LevelSuit("Clubs", card2, 1, card2.ability.per_level)
    end,
    bulk_use = function(self, card2, _, _, amount)
        Entropy.LevelSuit("Clubs", card2, amount, card2.ability.per_level)
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
                    to_big(G.GAME.SuitBuffs["Clubs"].level or 1) < to_big(2) and G.C.BLACK or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.SuitBuffs["Clubs"].level or 1))]
                }
            }
        }
    end,
    entr_credits = {
        art = {"notmario"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local mountain = {
    key = "mountain",
    set = "Fraud",
    atlas = "fraud",
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
        Entropy.LevelSuit("Hearts", card2, 1, card2.ability.per_level)
    end,
    bulk_use = function(self, card2, _, _, amount)
        Entropy.LevelSuit("Hearts", card2, amount, card2.ability.per_level)
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
                    to_big(G.GAME.SuitBuffs["Hearts"].level or 1) < to_big(2) and G.C.BLACK or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.SuitBuffs["Hearts"].level or 1))]
                }
            }
        }
    end,
    entr_credits = {
        art = {"LFMoth"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local forgiveness = {
    key = "forgiveness",
    set = "Fraud",
    atlas = "fraud",
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
        idea = {"cassknows"},
        art = {"Ein13"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local tent = {
    key = "tent",
    set = "Fraud",
    atlas = "fraud",
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
        Entropy.LevelSuit("Spades", card2, 1, card2.ability.per_level)
    end,
    bulk_use = function(self, card2, _, _, amount)
        Entropy.LevelSuit("Spades", card2, amount, card2.ability.per_level)
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
                  to_big(G.GAME.SuitBuffs["Spades"].level or 1) < to_big(2) and G.C.BLACK or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.SuitBuffs["Spades"].level or 1))]
                }
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local frail = {
    key = "frail",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901+33,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 1
    },
    pos = {x=7,y=2},
    inversion = "c_entr_kiln",
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select
            }
        }
    end,
    use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.hand}, card2, 1, card2.ability.select)
        local modifications = {}
        for i, v in pairs(cards) do
            if v.config.center.set == "Enhanced" then
                modifications[#modifications+1] = {enhancement=v.config.center.key}
            end
            if v.edition then
                modifications[#modifications+1] = {edition=v.edition.key}
            end
            if v.seal then
                modifications[#modifications+1] = {seal = v.seal}
            end
        end
        local possible_cards = {}
        for i, v in pairs(G.hand.cards) do
            if v ~= card2 then
                possible_cards[#possible_cards+1] = v
            end
        end
        for i, v in pairs(modifications) do
            local card = pseudorandom_element(possible_cards, pseudoseed("frail_card"))
            if v.enhancement then card:set_ability(v.enhancement) end
            if v.edition then card:set_edition(v.edition) end
            if v.seal then card:set_seal(v.seal) end
        end
        for i, v in pairs(cards) do
            v:start_dissolve()
        end
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
        return #cards > 0 and #cards <= card.ability.select
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local inferno = {
    key = "inferno",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901+34,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        per_past_three = 3
    },
    pos = {x=8,y=2},
    inversion = "c_entr_comet",
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.per_past_three
            }
        }
    end,
    use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
        for i, v in pairs(cards) do
            v:start_dissolve()
        end
        if #cards > 2 then
            ease_dollars(-(card.ability.per_past_three * (#cards - 2)))
        end
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
        return #cards > 0
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end,
    entr_credits = {
        art = {"LFMoth"}
    }
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
        forgiveness,
        feud,
        advisor,
        heretic,
        earl,
        mason,
        princess,
        oracle,
        ocean,
        forest,
        mountain,
        tent,
        companion,
        village,
        frail,
        inferno
    }
}

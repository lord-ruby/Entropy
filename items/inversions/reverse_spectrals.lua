local changeling = {
    object_type = "Consumable",
    order = 2000,
    key = "changeling",
    inversion = "c_familiar",
    pos = {x = 6, y = 4},
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = { random = 3 },
    atlas = "consumables",
    set = "Omen",
    
    use = function(self, card)
        local cards = {}
        for i, v in pairs(G.hand.cards) do cards[#cards+1]=v end
        pseudoshuffle(cards, pseudoseed('changeling'))
        local actual = {}
        for i = 1, card.ability.random do
            actual[i] = cards[i]
        end
        Entropy.FlipThen(actual, function(card)
            card:set_edition(SMODS.poll_edition({guaranteed = true, key = "entr_changeling"}))
            SMODS.change_base(card, nil, pseudorandom_element({"King", "Queen", "Jack"}, pseudoseed("changeling_rank")), nil)
        end)
    end,
    can_use = function()
        return G.hand and #G.hand.cards > 0
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.random
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
}

local rend = {
    object_type = "Consumable",
    order = 2000 + 1,
    key = "rend",
    inversion = "c_grim",
    pos = {x = 7, y = 4},
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = { select = 4 },
    atlas = "consumables",
    set = "Omen",
    
    use = function(self, card)
        Entropy.FlipThen(Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select), function(card)
            card:set_ability(G.P_CENTERS.m_entr_flesh)
        end)
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
        return #cards > 0 and #cards <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.m_entr_flesh
        return {
            vars = {
                card.ability.select
            }
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}
local inscribe = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 2,
    key = "inscribe",
    set = "Omen",
    
	
    inversion = "c_incantation",
    atlas = "consumables",
    config = {
        chipmult = 3
    },
	pos = {x=8,y=4},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        Entropy.FlipThen(Entropy.FilterTable(G.hand.cards, function(card) return not card:is_face() and card.base.value ~= "Ace" end), function(card, area)
            card.base.nominal = card.base.nominal * card2.ability.chipmult
            card.ability.debuff_timer = 1
            card.ability.debuff_timer_max = 1
            card:set_debuff(true)
        end)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.chipmult
            }
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}
local insignia = Entropy.SealSpectral("insignia", {x=9,y=4}, "entr_silver", 2000+3, "c_talisman", {art = {"Lil. Mr. Slipstream"}})
local rendezvous = Entropy.SealSpectral("rendezvous", {x=10,y=5}, "entr_crimson",2000+10.5, "c_deja_vu")
local eclipse = Entropy.SealSpectral("eclipse", {x=12,y=5}, "entr_sapphire",2000+12, "c_trance", {art = {"Lil. Mr. Slipstream"}})
local calamity = Entropy.SealSpectral("calamity", {x=6,y=6}, "entr_pink",2000+13, "c_medium",{art = {"Lil. Mr. Slipstream"}})

local siphon = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 4,
    key = "siphon",
    set = "Omen",
    
    inversion = "c_aura",

    atlas = "consumables",
    config = {
        cards = 3
    },
	pos = {x=10,y=4},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local lower = Entropy.FindPreviousInPool(G.jokers.highlighted[1].edition.key, "Edition", "e_negative")
        local cards = {}
        local rcards = {}
        for i, v in pairs(G.hand.cards) do if not v.edition then cards[#cards+1] = v end end
        pseudoshuffle(cards, pseudoseed("entr_siphon"))
        for i = 1, math.min(#cards, card2.ability.cards) do rcards[#rcards+1] = cards[i] end
        Entropy.FlipThen(rcards, function(card, area)
            card:set_edition(lower)
        end)
        G.jokers.highlighted[1]:start_dissolve()
    end,
    can_use = function(self, card)
        return G.jokers 
        and #G.jokers.highlighted == 1 
        and G.jokers.highlighted[1] 
        and G.jokers.highlighted[1].edition 
        and G.jokers.highlighted[1].ability and not G.jokers.highlighted[1].ability.cry_absolute
	end,
    loc_vars = function(self, q, card)
        local str = localize("k_none")
        if G.jokers and #G.jokers.highlighted > 0 and G.jokers.highlighted[1].edition and Entropy.FindPreviousInPool(G.jokers.highlighted[1].edition.key, "Edition", "e_negative") then
            str = G.localization.descriptions.Edition[Entropy.FindPreviousInPool(G.jokers.highlighted[1].edition.key, "Edition", "e_negative")].name
        end
        return {
            vars = {
                str,
                card.ability.cards
            }
        }
    end,
    entr_credits = {
        idea = {"crabus"}
    },
    --TODO figure this shit out when force used
}

local ward = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 5,
    key = "ward",
    set = "Omen",
    inversion = "c_wraith",
    atlas = "consumables",
    config = {
        sellmult = 3,
        rounds = 3
    },
	pos = {x=11,y=4},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        local joker = pseudorandom_element(G.jokers.cards, pseudoseed("entr_ward"))
        local total = joker.sell_cost
        joker.ability.debuff_timer = (joker.ability.debuff_timer or 0) + card.ability.rounds
        joker.ability.debuff_timer_max = (joker.ability.debuff_timer_max or 0) + card.ability.rounds 
        joker:set_debuff(true)
        joker:juice_up()
        ease_dollars(total * card.ability.sellmult)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards > 0
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.sellmult,
                card.ability.rounds
            }
        }
    end,
    entr_credits = {
        idea = {"CapitalChirp"},
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local disavow = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 6,
    key = "disavow",
    set = "Omen",
    inversion = "c_sigil",
    atlas = "consumables",
	pos = {x=12,y=4},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, 1)
        local enh = cards[1] and cards[1].config.center_key or "m_base"
        Entropy.FlipThen(G.hand.cards, function(card, area, ind)
            if card == cards[1] then
                card:set_ability(G.P_CENTERS["m_entr_disavowed"])
            else
                card:set_ability(G.P_CENTERS[enh])
            end
        end)
    end,
    can_use = function(self, card)
        local cards = #Entropy.GetHighlightedCards({G.hand}, card, 1, 1)
        return cards > 0 and cards <= 1
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.m_entr_disavowed
    end,
    entr_credits = {
        idea = {"CapitalChirp"},
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local pact = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "link"
        }
    },
    object_type = "Consumable",
    order = 2000 + 7,
    key = "pact",
    set = "Omen",

    inversion = "c_ouija",

    atlas = "consumables",
    config = {
        selected = 3
    },
	pos = {x=6,y=5},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        local linktxt
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.selected)
        for i, v in pairs(cards) do
            if v.ability.link then linktxt = v.ability.link end
        end
        linktxt = linktxt or Entropy.StringRandom(8)
        for i, v in pairs(cards) do
            for i, v2 in pairs(G.hand.cards) do
                if v2 ~= v and v.ability.link and v.ability.link == v2.ability.link then
                    v2.ability.link = linktxt
                end
            end
            for i, v2 in pairs(G.deck.cards) do
                if v2 ~= v and v.ability.link and v.ability.link == v2.ability.link then
                    v2.ability.link = linktxt
                end
            end
            v.ability.link = linktxt
            v:juice_up()
        end

    end,
    can_use = function(self, card)
        local num = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.selected)
        return #num <= card.ability.selected and #num > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {set="Other",key="link", vars = {"[LINK_KEY]"}}
        return {
            vars = {
                card.ability.selected
            }
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local link = {
    atlas = "entr_stickers",
    pos = { x = 1, y = 1 },
    key = "link",
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Sticker",
    order = 2500 + 0,
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("59ffe8"),
    loc_vars = function(self,q,card)
        return {
            vars = {
                card.ability.link
            }
        }
    end,
    apply = function(self,card,val) 
        if not G.GAME.link then
            G.GAME.link = Entropy.StringRandom(8)
        end
        card.ability.link = G.GAME.link
    end,
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
    end,
}

local ichor = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 8,
    key = "ichor",
    set = "Omen",
    
    inversion="c_ectoplasm",

    atlas = "consumables",
    config = {
        num = 1
    },
	pos = {x=7,y=5},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        local joker = pseudorandom_element(G.jokers.cards, pseudoseed("entr_ichor"))
        Entropy.handle_card_limit(G.jokers, 1)
        if joker then
            joker:juice_up()
            joker.ability.extra_slots_used = joker.ability.extra_slots_used + 1
        end
    end,
    can_use = function(self, card)
        if not G.jokers then return false end
        for i, v in pairs(G.jokers.cards) do
            if v.edition and v.edition.key == "e_negative" then return true end
        end
        return false
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.e_negative
        return {
            vars = {
                card.ability.num
            }
        }
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"LFMoth"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local rejuvenate = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 9,
    key = "rejuvenate",
    set = "Omen",
    
    inversion = "c_immolate",

    atlas = "consumables",
    config = {
        dollars = -10,
        num = 2
    },
	pos = {x=8,y=5},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local cards = {}
        for i, v in pairs(G.hand.cards) do if not v.highlighted then cards[#cards+1]=v end end
        pseudoshuffle(cards, pseudoseed('immolate'))
        local actual = {}
        for i = 1, card2.ability.num do
            actual[i] = cards[i]
        end
        local ed = SMODS.poll_edition({guaranteed = true, key = "entr_rejuvenate_ed"})
        local enh = G.P_CENTERS[SMODS.poll_enhancement({guaranteed = true})]
        local seal = SMODS.poll_seal{guaranteed = true, key = "rejuvenate"}
        local card = Entropy.GetHighlightedCards({G.hand}, card2, 1, 1)[1] or pseudorandom_element(G.hand.cards, pseudoseed("rejuvenate"), 1, 1)
        card:set_edition(ed)
        card:set_ability(enh)
        card:set_seal(seal)
        Entropy.FlipThen(actual, function(card3, area)
                copy_card(card,card3)
                card3:set_edition(ed)
                card3:set_ability(enh)
                card3:set_seal(seal)
        end)

        ease_dollars(card2.ability.dollars)
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, 1)
        return num <= 1 and num > 0
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.num,
                Entropy.FormatDollarValue(card.ability.dollars)
            }
        }
    end,
    entr_credits = {
        idea = {"crabus"},
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local crypt = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 10,
    key = "crypt",
    set = "Omen",
    inversion = "c_ankh",
    atlas = "consumables",
    config = {
        select = 2,
    },
	pos = {x=9,y=5},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local jokers = Entropy.GetHighlightedCards({G.jokers}, card2, 1, card2.ability.select)
        local selected = pseudorandom_element(jokers, pseudoseed("entr_crypt"))
        Entropy.FlipThen(jokers, function(v, area)
            if v ~= selected and v and selected then            
                copy_card(selected, v)
                if v.edition and v.edition.key == "e_negative" then
                    v:set_edition()
                end
            end
        end)

    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.jokers}, card, 1, card.ability.select)
        return #cards > 1 and #cards <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        local main_end = {}
        if G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.edition and joker.edition.negative then
                    localize { type = 'other', key = 'remove_negative', nodes = main_end, vars = {} }
                    break
                end
            end
        end
        return {
            vars = {
                card.ability.select,
            },
            main_end = main_end[1]
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local charm = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 11,
    key = "charm",
    set = "Omen",
    
	inversion = "c_hex",

    atlas = "consumables",
    config = {
        select = 1,
    },
	pos = {x=11,y=5},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local editions = {}
        for i, v in pairs(G.P_CENTER_POOLS.Edition) do
            if v.key ~= "e_negative" and v.key ~= "e_base" then
                editions[#editions+1] = {
                    weight = 1,
                    name = v.key
                }
            end
        end
        for i, v in pairs(Entropy.GetHighlightedCards({G.jokers}, card2, 1, card2.ability.select)) do
            local edition = SMODS.poll_edition({
                key = "entr_charm",
                options = editions,
                guaranteed = true
            })
            v:set_edition(edition)
            v.ability.eternal = true

        end
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.jokers}, card, 1, card.ability.select)
        return #cards <= card.ability.select and #cards > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.e_entr_gilded
        q[#q+1] = {key="eternal",set="Other"}
        return {
            vars = {
                card.ability.select,
            }
        }
    end,
    entr_credits = {
        idea = {"crabus"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local entropy = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 14,
    key = "entropy",
    set = "Omen",
    
    inversion = "c_cryptid",

    atlas = "consumables",
    config = {
        select = 2,
    },
	pos = {x=7,y=6},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        Entropy.FlipThen(Entropy.GetHighlightedCards({G.hand}, card2, 1, card2.ability.select), function(card,area)
            local edition = SMODS.poll_edition({guaranteed = true, key = "entr_entropy"})
            local enhancement_type = pseudorandom_element({"Enhanced","Enhanced","Enhanced","Joker","Consumeables","Voucher","Booster"}, pseudoseed("entropy"))
            local enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("entropy")).key
            while G.P_CENTERS[enhancement].no_doe or G.GAME.banned_keys[enhancement] or (enhancement_type == "Joker" and SMODS.Rarities[G.P_CENTERS[enhancement].rarity]
                and (
                    SMODS.Rarities[G.P_CENTERS[enhancement].rarity].get_weight
                    or (SMODS.Rarities[G.P_CENTERS[enhancement].rarity].default_weight and SMODS.Rarities[G.P_CENTERS[enhancement].rarity].default_weight > 0)
                )) do
                enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("entropy")).key
            end
            local seal = SMODS.poll_seal{guaranteed = true, key = "entropy"}
            card:set_edition(edition)
            card:set_ability(G.P_CENTERS[enhancement])
            card:set_seal(seal)
            Entropy.randomize_rank_suit(card, true, true, "entropy")

        end)
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
        return num <= card.ability.select and num > 0
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select,
            }
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"},
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local fervour = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 15,
    key = "fervour",
    set = "Omen",
    
    inversion = "c_soul",
    
    atlas = "consumables",
	name = "entr-Fervour",
    soul_rate = 0, --probably only obtainable from flipsiding a gateway
    hidden = true, 
	pos = {x=4,y=0},
    soul_set = "Omen",
    tsoul_pos = {x=5,y=0},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, "entr_reverse_legendary", nil, nil, nil, "entr_fervour")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                colours = {
                    {3,3,3,3}
                }
            }
        }
    end,
    no_select = true,
    entr_credits = {
        custom = {key="card_art", text="gudusername_53951"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local quasar = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 16,
    key = "quasar",
    set = "Omen",
    
    inversion = "c_black_hole",

    atlas = "consumables",
    no_select = true,
    soul_rate = 0,
    hidden = true, 
	pos = {x=7,y=3},
    soul_set = "Star",
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier,amt)
        local amt = amt or 1
        local used_consumable = copier or card
        delay(0.4)
        local max=0
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
          { handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
        )
        for i, v in pairs(G.GAME.hands) do
            G.GAME.hands[i].AscensionPower = to_big(G.GAME.hands[i].AscensionPower or 0) + to_big(G.GAME.hands[i].level) * to_big(amt) * to_big(0.5)
        end
        delay(1.0)
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.2,
          func = function()
            play_sound("tarot1")
            ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.1)
            ease_colour(G.C.UI_MULT, copy_table(G.C.GOLD), 0.1)
            Cryptid.pulse_flame(0.01, sunlevel)
            used_consumable:juice_up(0.8, 0.5)
            G.E_MANAGER:add_event(Event({
              trigger = "after",
              blockable = false,
              blocking = false,
              delay = 1.2,
              func = function()
                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
                ease_colour(G.C.UI_MULT, G.C.RED, 1)
                return true
              end,
            }))
            return true
          end,
        }))
        update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+ ..." })
        delay(1.0)
        delay(2.6)
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
          { mult = 0, chips = 0, handname = "", level = "" }
        )
    end,
    bulk_use = function(self,card,area,copier,amt)
        self.use(self,card,area,copier,amt)
    end,
    can_use = function(self, card)
        return true
	end,
    no_select = true,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

SMODS.Rank {
    key = 'nilrank',
    card_key = 'nilrank',
    pos = {x = 0},
    nominal = 1,
    face_nominal = 1,
    shorthand = "nil",
    hc_atlas = 'hc_nilr',
    lc_atlas = 'lc_nilr',
    suit_map = { Hearts = 0, Clubs = 1, Diamonds = 2, Spades = 3, entr_nilsuit = 9999 },
    in_pool = function(self, args)
        return false
    end
}
SMODS.Suit {
    key = 'nilsuit',
    card_key = 'nilsuit',
    shorthand="nil",
    hc_atlas = 'hc_nils',
    lc_atlas = 'lc_nils',
    pos = { y = 0 },
    ui_pos = {x=99,y=99},
    in_pool = function(self, args)
        return false
    end
}

if Engulf then
    Engulf.SpecialFuncs = {
        c_entr_pulsar = function(card, hand, instant, amount)
            if card.edition then
                for i, v in pairs(G.GAME.hands) do
                    Engulf.EditionHand(card, i, card.edition, Engulf.config.stackeffects and amount or 1, true)
                end
            end
        end,
        c_entr_quasar = function(card, hand, instant, amount)
            if card.edition then
                Engulf.EditionHand(card, hand, card.edition, Engulf.config.stackeffects and amount or 1, instant)
            end
        end
    }
    Engulf.SpecialWhitelist["c_entr_pulsar"] = true
    Engulf.SpecialWhitelist["c_entr_quasar"] = true
    Engulf.SpecialWhitelist["Omen"] = true
end

local regenerate = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 33,
    key = "regenerate",
    set = "Omen",
    
    inversion = "c_entr_shatter",
	
    atlas = "consumables",
    config = {
        limit = 2
    },
	pos = {x=8,y=8},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        local cards = Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeable}, card, 1, card.ability.limit)
        Entropy.FlipThen(cards, function(card)
            card.ability.bypass_aleph = true
            if card.config.center.set == "Enhanced" then
                if card.config.center.key == "m_entr_disavowed" then
                    card.ability.disavow = false
                end
                card:set_ability(G.P_CENTERS.c_base)
            else
                card:set_ability(G.P_CENTERS[card.config.center.key])
            end
            card.seal = nil
            card:set_edition()
            for i, v in pairs(SMODS.Sticker.obj_table) do
                if i ~= "absolute" then card.ability[i] = nil end
            end
            if card.base.suit == "entr_nilsuit" or card.base.value == "entr_nilrank" then
                Entropy.randomize_rank_suit(card, true, true, "regenerate")
            end

        end)
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeable}, card, 1, card.ability.limit)
        return num > 0 and num <= card.ability.limit
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.limit
            }
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local pure = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Sticker",
    order = 2500+4,
    atlas = "entr_stickers",
    pos = { x = 8, y = 1 },
    key = "entr_pure",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("fd56e9"),
    should_apply = false,
    apply = function(self,card,val)
        card.ability.entr_pure = true
    end,
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
    end,
}

local purity = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 34,
    key = "purity",
    set = "Omen",
    
    inversion = "c_entr_lust",
	
    atlas = "consumables",
    config = {
        limit = 2
    },
	pos = {x=9,y=8},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        for i, v in pairs(Entropy.GetHighlightedCards({G.jokers}, card, 1, card.ability.limit)) do
            Entropy.ApplySticker(v, "entr_pure")
            v:juice_up()
        end

    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.jokers}, card, 1, card.ability.limit)
        return num > 0 and num <= card.ability.limit
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {set = "Other", key = "entr_pure"}
        return {
            vars = {
                card.ability.limit
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local misprintize = Cryptid.misprintize
function Cryptid.misprintize(card, ...)
    if not card.ability.entr_pure then
        return misprintize(card, ...)
    end
end

local calculate_jokerref = Card.calculate_joker
function Card:calculate_joker(...)
    local abil
    if self.ability.entr_pure then
        abil = copy_table(self.ability)        
    end
    local ret = calculate_jokerref(self, ...)
    if self.ability.entr_pure then
        self.ability = abil
    end
    return ret
end

local transcend = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 35,
    key = "transcend",
    set = "Omen",
    
    inversion = "c_entr_null",
	
    atlas = "consumables",
    config = {
        limit = 1
    },
	pos = {x=11,y=7},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        Entropy.FlipThen(Entropy.GetHighlightedCards({G.consumeables, G.hand, G.pack_cards, G.shop_jokers, G.shop_vouchers, G.shop_booster, G.jokers}, card, 1, card.ability.limit), function(card)
            if card.config.center.key == "j_entr_parakmi" then
                check_for_unlock({ type = "parakmi_transcend" })
            end
            card:set_ability(Entropy.GetPooledCenter(Entropy.GetRandomSet(true)))

        end)
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.consumeables, G.hand, G.pack_cards, G.shop_jokers, G.shop_vouchers, G.shop_booster, G.jokers}, card, 1, card.ability.limot)
        return num > 0 and num <= card.ability.limit
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.limit
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end,
    entr_credits = {
        idea = {"cassknows"}
    },
}

local weld = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 36,
    key = "weld",
    set = "Omen",
    
    inversion = "c_entr_antithesis",

    atlas = "consumables",
    config = {
        select = 1,
    },
	pos = {x=10,y=8},
    hidden = true,
    soul_rate = 0,
    no_select = true,
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        for i, card in pairs(Entropy.GetHighlightedCards({G.jokers}, card, 1, card.ability.select)) do
            card.ability.entr_aleph = true
            card:set_edition("e_negative")
            card:juice_up()

        end
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.jokers}, card, 1, card.ability.select)
        return #cards > 0 and #cards <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {set="Other", key = "entr_aleph"}
        q[#q+1] = G.P_CENTERS.e_negative
        return {
            vars = {
                card.ability.select,
            }
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local malediction = Entropy.SealSpectral("malediction", {x=2,y=0}, "entr_amber", 2000+37, "c_entr_enchant", nil, "consumables2")

local idyll = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 38,
    key = "idyll",
    set = "Omen",
    
    inversion = "c_entr_manifest",

    atlas = "consumables",
	pos = {x=2,y=8},
    use = function(self, card, area, copier)
        if G.GAME.last_tag then
            add_tag(Tag(G.GAME.last_tag))
            add_tag(Tag(Entropy.AscendedTags[G.GAME.last_tag] or G.GAME.last_tag))
        end
    end,
    can_use = function(self, card)
        return G.GAME.last_tag
	end,
    loc_vars = function(self, q, card)
        if G.GAME.last_tag then
            q[#q+1] = G.P_TAGS[G.GAME.last_tag]
            q[#q+1] = G.P_TAGS[Entropy.AscendedTags[G.GAME.last_tag] or G.GAME.last_tag]
        end
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

return {
    items = {
        changeling,
        rend,
        inscribe,
        insignia,
        rendezvous,
        eclipse,
        calamity,
        downpour,
        script,
        ward,
        siphon,
        disavow,
        pact,
        link,
        ichor,
        rejuvenate,
        crypt,
        charm,
        entropy,
        quasar,
        fervour,
        regenerate,
        beyond,
        pure,
        purity,
        transcend,
        weld,
        malediction,
        idyll
    }
}

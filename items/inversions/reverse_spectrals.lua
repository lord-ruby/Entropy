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
    set = "RSpectral",
    
    use = function(self, card)
        local cards = {}
        for i, v in pairs(G.hand.cards) do cards[#cards+1]=v end
        pseudoshuffle(cards, pseudoseed('immolate'))
        local actual = {}
        for i = 1, card.ability.random do
            actual[i] = cards[i]
        end
        Entropy.FlipThen(actual, function(card)
            card:set_edition(pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("changeling_edition")).key)
            SMODS.change_base(card, nil, pseudorandom_element({"King", "Queen", "Jack"}, pseudoseed("changeling_rank")))
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
    end
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
    config = { select = 3 },
    atlas = "consumables",
    set = "RSpectral",
    
    use = function(self, card)
        Entropy.FlipThen(G.hand.highlighted, function(card)
            card:set_ability(G.P_CENTERS.m_entr_flesh)
        end)
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand}, card)
        return #cards > 0 and #cards <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select
            }
        }
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
    set = "RSpectral",
    can_stack = true,
	can_divide = true,
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
            card.perma_debuff = true
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
}
local insignia = Entropy.SealSpectral("insignia", {x=9,y=4}, "entr_silver", 2000+3, "c_talisman")
local rendezvous = Entropy.SealSpectral("rendezvous", {x=10,y=5}, "entr_crimson",2000+10.5, "c_deja_vu")
local eclipse = Entropy.SealSpectral("eclipse", {x=12,y=5}, "entr_sapphire",2000+12, "c_trance")
local calamity = Entropy.SealSpectral("calamity", {x=6,y=6}, "entr_pink",2000+13, "c_medium")
local downpour = Entropy.SealSpectral("downpour", {x=12,y=7}, "entr_cerulean",2000+24, "c_cry_typhoon")
local script = Entropy.SealSpectral("script", {x=6,y=8}, "entr_verdant",2000+25, "c_cry_source")

local siphon = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 4,
    key = "siphon",
    set = "RSpectral",
    
    invesion = "c_aura",

    atlas = "consumables",
    config = {
        chipmult = 3
    },
	pos = {x=10,y=4},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local lower = Entropy.FindPreviousInPool(G.jokers.highlighted[1].edition.key, "Edition")
        Entropy.FlipThen(G.hand.cards, function(card, area)
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
        local str = "none"
        if G.jokers and #G.jokers.highlighted > 0 and G.jokers.highlighted[1].edition and Entropy.FindPreviousInPool(G.jokers.highlighted[1].edition.key, "Edition") then
            str = G.localization.descriptions.Edition[Entropy.FindPreviousInPool(G.jokers.highlighted[1].edition.key, "Edition")].name
        end
        return {
            vars = {
                str
            }
        }
    end,
    entr_credits = {
        idea = {"crabus"}
    }
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
    set = "RSpectral",
    inversion = "c_wraith",
    atlas = "consumables",
    config = {
        sellmult = 2
    },
	pos = {x=11,y=4},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        local total = 0
        for i, v in pairs(G.jokers.cards) do
            if not v.ability.eternal and not v.ability.cry_absolute then
                local joker = G.jokers.cards[i]
                total = total + joker.cost
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        joker:start_dissolve()
                        return true
                    end
                }))
            end
        end
        ease_dollars(total * card.ability.sellmult)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards > 0
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.sellmult
            }
        }
    end,
    entr_credits = {
        idea = {"CapitalChirp"}
    }
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
    set = "RSpectral",
    inversion = "c_sigil",
    atlas = "consumables",
    config = {
        sellmult = 2
    },
	pos = {x=12,y=4},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        Entropy.FlipThen(G.hand.cards, function(card, area, ind)
            local func = Entropy.EnhancementFuncs[card.config.center.key] or function(card)
                card:set_edition("e_cry_glitched")
            end
            if card.config.center.key ~= "c_base" then 
                local ability = card.ability
                card:set_ability(G.P_CENTERS.m_entr_disavowed)
                card.ability = ability
                card.ability.disavow = true
                func(card)
            end
        end)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
	end,
    loc_vars = function(self, q, card)
    end,
    entr_credits = {
        idea = {"CapitalChirp"}
    }
}

local EnhancementFuncs = {
    m_bonus = function(card) card.ability.bonus = 100 end,
    m_mult = function(card) card.ability.x_mult = card.ability.x_mult * 1.5 end,
    m_glass = function(card) card.temporary2=true;card:shatter() end,
    m_steel = function(card) card.ability.x_mult = (card.ability.x_mult+1)^2 end,
    m_stone = function(card) card.ability.bonus = (card.base.nominal^2) end,
    m_gold = function(card) ease_dollars(20) end,
    m_lucky = function(card)
        if pseudorandom("disavow") < 0.5 then
            card.ability.x_mult = card.ability.x_mult * 1.5
        else    
            ease_dollars(20)
        end
    end,
    m_cry_echo = function(card) 
        local card2 = copy_card(card) 
        card2:set_ability(G.P_CENTERS.c_base)
        card2:add_to_deck()
        G.hand:emplace(card2)
    end,
    m_cry_light = function(card)
        card.ability.x_mult = card.ability.x_mult * 4
    end,
    m_entr_flesh = function(card)
        card.temporary2=true;card:start_dissolve()
    end
}
for i, v in pairs(EnhancementFuncs) do Entropy.EnhancementFuncs[i] = v end

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
    set = "RSpectral",

    inversion = "c_ouija",

    atlas = "consumables",
    config = {
        selected = 3
    },
	pos = {x=6,y=5},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        local linktxt
        for i, v in pairs(G.hand.highlighted) do
            if v.ability.link then linktxt = v.ability.link end
        end
        linktxt = linktxt or Entropy.StringRandom(8)
        for i, v in pairs(G.hand.highlighted) do
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
        local num = Entropy.GetHighlightedCards({G.hand}, card)
        return #num <= card.ability.selected and #num > 0
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.selected
            }
        }
    end,
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
    order = 2000 + 0,
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("FF00FF"),
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
    calculate = function(self, card, context)

    end
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
    set = "RSpectral",
    
    inversion="c_ectoplasm",

    atlas = "consumables",
    config = {
        num = 2
    },
	pos = {x=7,y=5},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        local joker = pseudorandom_element(Entropy.FilterArea(G.jokers.cards, function(card)
            return card.edition and card.edition.key == "e_negative"
        end), pseudoseed("ichor"))
        joker:start_dissolve()
        G.GAME.banned_keys[joker.config.center.key] = true
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.num
        eval_card(v, {banishing_card = true, banisher = card, card = joker, cardarea = joker.area})
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
    }
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
    set = "RSpectral",
    
    inversion = "c_immolate",

    atlas = "consumables",
    config = {
        dollars = -15,
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
        local ed = pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("rejuvenate")).key
        local enh = G.P_CENTERS[pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed("rejuvenate")).key]
        local seal = pseudorandom_element(G.P_CENTER_POOLS.Seal, pseudoseed("rejuvenate")).key
        local card = Entropy.GetHighlightedCards({G.hand}, card2)[1]
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
        local num = #Entropy.GetHighlightedCards({G.hand}, card)
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
        idea = {"crabus"}
    }
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
    set = "RSpectral",
    inversion = "c_ankh",
    atlas = "consumables",
    config = {
        select = 2,
    },
	pos = {x=9,y=5},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local joker = nil
        for i, v in pairs(G.jokers.cards) do 
            if v.highlighted then 
                joker = v 
            end 
        end
        Entropy.FlipThen(G.jokers.highlighted, function(v, area)
            if v ~= joker then            
                copy_card(joker, v)
                v:set_edition()
            end
        end)
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.jokers}, card)
        return #cards > 1 and #cards <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select,
            }
        }
    end,
}

local charm = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "e_cry_astral"
        }
    },
    object_type = "Consumable",
    order = 2000 + 11,
    key = "charm",
    set = "RSpectral",
    can_stack = true,
	can_divide = true,

    atlas = "consumables",
    config = {
        select = 1,
    },
	pos = {x=11,y=5},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        for i, v in pairs(G.jokers.highlighted) do
            v:set_edition("e_cry_astral")
            v.ability.eternal = true
        end
        local joker = nil
        local tries = 100
        while (joker == nil or joker.ability.eternal or joker.ability.cry_absolute) and tries > 0 do
            joker = pseudorandom_element(G.jokers.cards, pseudoseed("charm"))
            tries = tries - 1
        end
        if joker then
            joker:start_dissolve()
            G.GAME.banned_keys[joker.config.center.key] = true
        end
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.jokers}, card)
        local any_can_banish = false
        for i, joker in pairs(cards) do
            if not joker.ability.eternal and not joker.ability.cry_absolute and not joker.highlighted then
                any_can_banish = true
            end
        end
        return #cards <= card.ability.select and #cards > 0 and any_can_banish
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.e_cry_astral
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
    set = "RSpectral",
    
    inversion = "c_cryptid",

    atlas = "consumables",
    config = {
        select = 2,
    },
	pos = {x=7,y=6},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        Entropy.FlipThen(G.hand.highlighted, function(card,area)
            local edition = pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("entropy")).key
            local enhancement_type = pseudorandom_element({"Enhanced","Enhanced","Enhanced","Joker","Consumable","Voucher","Booster"}, pseudoseed("entropy"))
            if enhancement_type == "Consumable" then
                enhancement_type = pseudorandom_element({"Tarot","Planet","Spectral","Code","RPlanet","RSpectral","RCode"}, pseudoseed("entropy"))
            end
            local enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("entropy")).key
            while G.P_CENTERS[enhancement].no_doe or G.GAME.banned_keys[enhancement] do
                enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("entropy")).key
            end
            local seal = pseudorandom_element(G.P_CENTER_POOLS.Seal, pseudoseed("entropy")).key
            card:set_edition(edition)
            card:set_ability(G.P_CENTERS[enhancement])
            card:set_seal(seal)
            SMODS.change_base(card,pseudorandom_element({"Spades","Hearts","Clubs","Diamonds"}, pseudoseed("entropy")),pseudorandom_element({"2", "3", "4", "5", "6", "7", "8", "9", "10", "Ace", "King", "Queen", "Jack"}, pseudoseed("entropy")))
        end)
    end,
    can_use = function(self, card)
        local num = Entropy.GetHighlightedCards({G.hand}, card)
        return num <= card.ability.select and num > 0
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select,
            }
        }
    end,
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
    set = "RSpectral",
    
    inversion = "c_soul",
    
    atlas = "consumables",
    config = {

    },
	name = "entr-Fervour",
    soul_rate = 0, --probably only obtainable from flipsiding a gateway
    hidden = true, 
	pos = {x=4,y=0},
    soul_set = "RSpectral",
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
    entr_credits = {
        custom = {key="card_art", text="gudusername_53951"}
    }
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
    set = "RSpectral",
    
    inversion = "c_black_hole",

    atlas = "consumables",
    config = {
        level = 3
    },
    soul_rate = 0,
    hidden = true, 
	pos = {x=7,y=3},
    soul_set = "RPlanet",
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier,amt)
        local amt = amt or 1
        local used_consumable = copier or card
        delay(0.4)
        local max=0
        local ind="High Card"
        for i, v in pairs(G.GAME.hands) do
            if v.played > max then
                max = v.played
                ind = i
            end
        end
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
          { handname = localize(ind,'poker_hands'), chips = "...", mult = "...", level = "" }
        )
        G.GAME.hands[ind].AscensionPower = (G.GAME.hands[ind].AscensionPower or 0) + G.GAME.hands[ind].level * amt * card.ability.level
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
        update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+"..G.GAME.hands[ind].level..card.ability.level*amt })
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
    loc_vars = function(self, q, card)
        local max=0
        local ind="High Card"
        for i, v in pairs(G.GAME.hands) do
            if v.played > max then
                max = v.played
                ind = i
            end
        end
        return {
            vars = {
                G.GAME.hands[ind].level * card.ability.level
            }
        }
    end,
}

local weld = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 17,
    key = "weld",
    set = "RSpectral",
    
    inversion = "c_cry_lock",

    atlas = "consumables",
    config = {
        select = 1,
        discard = 1
    },
	pos = {x=11,y=6},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        for i = 1, card.ability.select do
            local card = G.jokers.highlighted[i]
            if card then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        card:flip()
                        return true
                    end
                }))
            end
        end
        for i = 1, card.ability.select do
            local card = G.jokers.highlighted[i]
            if card then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        card.cry_absolute = true
                        return true
                    end
                }))
            end
        end
        for i = 1, card.ability.select do
            local card = G.jokers.highlighted[i]
            if card then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        card:flip()
                        return true
                    end
                }))
            end
        end
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.discard
        ease_discard(-card.ability.discard)
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.jokers}, card)
        return #cards > 0 and #cards <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "cry_absolute", set="Other"}
        return {
            vars = {
                card.ability.select,
                -card.ability.discard
            }
        }
    end,
}

SMODS.Rank {
    key = 'nilrank',
    card_key = 'nilrank',
    pos = {x = 99},
    nominal = 1,
    face_nominal = 1,
    shorthand = "nil",
    in_pool = function(self, args)
        return false
    end
}
SMODS.Suit {
    key = 'nilsuit',
    card_key = 'nilsuit',
    shorthand="nil",
    pos = { y = 99 },
    ui_pos = {x=99,y=99},
    in_pool = function(self, args)
        return false
    end
}

local cleanse = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 18,
    key = "cleanse",
    set = "RSpectral",
    
    inversion = "c_cry_vacuum",

    atlas = "consumables",
    config = {
        dollarpc = 1
    },
	pos = {x=7,y=7},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local total = 0
        for i, card in pairs(G.hand.cards) do
            if card.ability and card.ability.effect == 'Stone Card' then
                total = total + (10 + card.ability.perma_bonus) * card2.ability.dollarpc 
                card:set_ability(G.P_CENTERS.c_base, true, nil)
            else
                total = total + (card.base.nominal-1 + card.ability.perma_bonus) * card2.ability.dollarpc 
            end
            card.ability.perma_bonus = 0
        end
        Entropy.FlipThen(G.hand.cards, function(card, area)
            total = total + (card.base.nominal-1) * card2.ability.dollarpc
            SMODS.change_base(card, "entr_nilsuit", "entr_nilrank")
        end)
        delay(1)
        ease_dollars(total)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.dollarpc
            }
        }
    end,
}

local fusion = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 19,
    key = "fusion",
    set = "RSpectral",
    
    inversion = "c_cry_hammerspace",

    atlas = "consumables",
    config = {
        num = 3,
    },
	pos = {x=10,y=7},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local cards = {}
        for i, v in ipairs(G.hand.cards) do cards[#cards+1]=v end
        pseudoshuffle(cards, pseudoseed("fusion"))
        local actual = {}
        for i = 1, card2.ability.num do
            actual[#actual+1] = cards[i]
        end
        Entropy.FlipThen(actual, function(card,area)
            local sel = Entropy.GetHighlightedCards({G.jokers, G.consumeables, G.hand}, card, {c_base=true})[1]
            local enhancement_type = sel.ability and sel.ability.set or sel.config.center.set
            if sel.area == G.hand then
                SMODS.change_base(card,pseudorandom_element({"Spades","Hearts","Clubs","Diamonds"}, pseudoseed("fusion")),pseudorandom_element({"2", "3", "4", "5", "6", "7", "8", "9", "10", "Ace", "King", "Queen", "Jack"}, pseudoseed("fusion")))
                card:set_ability(G.P_CENTERS.c_base)
            else
                local enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("fusion")).key
                while G.P_CENTERS[enhancement].no_doe or (G.P_CENTERS[enhancement].soul_rate and pseudorandom("fusion") > 0.02) or G.GAME.banned_keys[enhancement] do
                    enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("fusion")).key
                end
                card:set_ability(G.P_CENTERS[enhancement])
            end
        end)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0 and #Entropy.GetHighlightedCards({G.jokers, G.consumeables, G.hand}, card, {c_base=true}) == 1
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.num,
            }
        }
    end,
}

local substitute = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 20,
    key = "substitute",
    set = "RSpectral",
    
    inversion = "c_cry_trade",

    atlas = "consumables",
    config = {
        num = 3,
    },
	pos = {x=6,y=7},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local usable_vouchers = {}
        local voucher = pseudorandom_element(G.vouchers.cards, pseudoseed("substitute"))
        local tries = 100
        while (voucher.ability.eternal or voucher.ability.cry_absolute or Entropy.GetHigherVoucherTier(voucher.config.center.key) == nil) and tries > 0 do
            voucher = pseudorandom_element(G.vouchers.cards, pseudoseed("substitute"))
            tries = tries - 1
        end
        voucher:unredeem()
        voucher:start_dissolve()
        for i, v in pairs(voucher.config.center.requires or {}) do
            if Entropy.InTable(G.vouchers.cards, v) then
                local voucher2 = G.vouchers.cards[Entropy.InTable(G.vouchers.cards, v)]
                for i2, v2 in pairs(voucher2.config.center.requires or {}) do
                    if Entropy.InTable(G.vouchers.cards, v2) then
                        local voucher3 = G.vouchers.cards[Entropy.InTable(G.vouchers.cards, v2)]
                        voucher3:unredeem()
                        voucher3:start_dissolve()
                    end
                end
                voucher2:unredeem()
                voucher2:start_dissolve()
            end
        end
        local card = create_card("Voucher", G.vouchers, nil, nil, nil, nil, nil, "entr_beyond")
        card:set_ability(G.P_CENTERS[Entropy.GetHigherVoucherTier(voucher.config.center.key) or "v_blank"])
        card:add_to_deck()
        G.vouchers:emplace(card)
        --Entropy.GetHigherVoucherTier(voucher.config.center.key) 
    end,
    can_use = function(self, card)
        local usable_count = 0
		for _, v in pairs(G.vouchers.cards) do
			if not v.ability.eternal and Entropy.GetHigherVoucherTier(v.config.center.key) and not v.ability.cry_absolute then
				usable_count = usable_count + 1
			end
		end
		if usable_count > 0 then
			return true
		else
			return false
		end
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.num,
            }
        }
    end,
}

local evocation = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 21,
    key = "evocation",
    set = "RSpectral",
    
    inversion = "c_cry_summoning",

    atlas = "consumables",
    config = {
        num = 1,
        hands = 1
    },
	pos = {x=7,y=8},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        for i, v in pairs(G.jokers.cards) do
            if not v.highlighted and not v.ability.cry_absolute and not v.ability.eternal then
                v:remove_from_deck()
                v:start_dissolve()
            end
        end
        for i, card in pairs(G.jokers.highlighted) do
            card:remove_from_deck()
            card:start_dissolve()
            local rare = nil
            if card.config.center.rarity ~= "j_entr_hyper_exotic" then
                rare = Entropy.GetNextRarity(card.config.center.rarity or 1) or card.config.center.rarity
            end
            if rare == 1 then rare = "Common" end
            if rare == 2 then rare = "Uncommon" end
            if rare == 4 then
                card = create_card("Joker", G.jokers, true, 4, nil, nil, nil, 'evocation')
            else 
                card = create_card("Joker", G.jokers, nil, rare, nil, nil, nil, 'evocation')
            end
            card:juice_up(0.3, 0.3)
            card:add_to_deck()
            G.jokers:emplace(card)
        end
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card2.ability.hands
        ease_hands_played(-card2.ability.hands)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.highlighted > 0 and #G.jokers.highlighted <= card.ability.num
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.num,
                card.ability.hands
            }
        }
    end,
}

local mimic = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 22,
    key = "mimic",
    set = "RSpectral",
    
    can_stack = true,
	can_divide = true,
    atlas = "consumables",

    inversion="c_cry_replica",

    config = {
        num = 1,
    },
	pos = {x=12,y=6},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local orig = Entropy.GetHighlightedCard({G.hand, G.consumeables, G.jokers, G.pack_cards, G.shop_booster, G.shop_jokers, G.shop_vouchers}, card2)
        local newcard = copy_card(orig)
        newcard:add_to_deck()
        newcard.ability.perishable = true
        newcard.ability.banana = true
        newcard.area = orig.area
        if newcard.ability.set == "Booster" and orig.area ~= G.hand then
            newcard.area = G.consumeables
            newcard:add_to_deck()
            table.insert(newcard.area.cards, newcard)
        elseif newcard.ability.set == "Voucher" and orig.area ~= G.hand then
            newcard.area = G.consumeables
            newcard:add_to_deck()
            table.insert(newcard.area.cards, newcard)
        else
            orig.area:emplace(newcard)
            if orig.area.config.type == "shop" then
                local ref = G.FUNCS.check_for_buy_space(c1)
                newcard.ability.infinitesimal = true
                newcard.cost = 0
                G.FUNCS.buy_from_shop({config={ref_table=newcard}})
            end
        end
    end,
    can_use = function(self, card)
        return Entropy.GetHighlightedCards({G.hand, G.consumeables, G.jokers, G.pack_cards, G.shop_booster, G.shop_jokers, G.shop_vouchers}, card) == card.ability.num
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.num,
            }
        }
    end,
}

local superego = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 23,
    key = "superego",
    set = "RSpectral",
    
    inversion = "c_cry_analog",

    atlas = "consumables",
    config = {
        num = 1,
    },
	pos = {x=8,y=6},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local cards = Entropy.GetHighlightedCards({G.jokers}, card2)
        for i, card in ipairs(cards) do
            card.ability.superego = true
            card.ability.superego_copies = 0
            card.debuff = true
            card.sell_cost = 0
        end
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.jokers}, card)
        return num <= card.ability.num and num > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key="superego", set="Other", vars = {0}}
        return {
            vars = {
                card.ability.num,
            }
        }
    end,
    entr_credits = {
        art = {"LFMoth"}
    }
}

local superego_sticker = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Sticker",
    order = 2000 + 2,
    atlas = "entr_stickers",
    pos = { x = 4, y = 1 },
    key = "superego",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("FF00FF"),
    apply = function(self,card,val)
        card.ability.superego = true
        card.ability.superego_copies = 0
        card.debuff = true
    end,
    loc_vars = function(self, q, card) return {vars={card.ability and math.floor(card.ability.superego_copies or 0) or 0}} end
}

local engulf = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "e_entr_solar"
        }
    },
    object_type = "Consumable",
    order = 2000 + 26,
    key = "engulf",
    set = "RSpectral",
    
    inversion = "c_cry_ritual",

    atlas = "consumables",
    config = {
        num = 1,
    },
	pos = {x=8,y=7},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        Entropy.FlipThen(Entropy.GetHighlightedCards({G.hand}, card), function(card, area)
            card:set_edition("e_entr_solar")
        end)
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card) 
        return num <= card.ability.num and num > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] =  G.P_CENTERS.e_entr_solar
        return {
            vars = {
                card.ability.num,
            }
        }
    end,
}

local offering = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 27,
    key = "offering",
    set = "RSpectral",

    inversion = "c_cry_adversary",

    atlas = "consumables",
    config = {
        sellmult = 0.75,
    },
	pos = {x=9,y=7},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        Entropy.FlipThen(G.jokers.cards, function(card, area)
            card.ability.rental = true
        end)
        G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.entr_shop_price_modifier = (G.GAME.entr_shop_price_modifier or 1) * card2.ability.sellmult
				for k, v in pairs(G.I.CARD) do
					if v.set_cost then
						v:set_cost()
					end
				end
				return true
			end,
		}))
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] =  {key="rental",set="Other", vars = {3}}
        return {
            vars = {
                card.ability.sellmult,
            }
        }
    end,
}

local entomb = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 28,
    key = "entomb",
    set = "RSpectral",

    inversion = "c_cry_chambered",

    atlas = "consumables",
    config = {
        num = 1
    },
	pos = {x=9,y=6},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        for i, v in pairs(G.consumeables.highlighted) do
            if v.config.center.key ~= "c_entr_entomb" and v.config.center.set ~= "Voucher" then
                local c
                if v.config.center.set == "Booster" then
                    c = copy_card(v)
                else
                    c = create_card("Booster", G.consumeables, nil, nil, nil, nil, key) 
                    c:set_ability(G.P_CENTERS[Entropy.BoosterSets[v.config.center.set] or "p_standard_normal_1"])
                end
                c:add_to_deck()
                c.T.w = c.T.w *  2.0/2.6
                c.T.h = c.T.h *  2.0/2.6
                table.insert(G.consumeables.cards, c)
                c.area = G.consumeables
                G.consumeables:align_cards()
            end
        end
    end,
    can_use = function(self, card)
        return G.consumeables and #Entropy.GetHighlightedCards({G.consumeables}, card) > 0 and #Entropy.GetHighlightedCards({G.consumeables}, card) <= card.ability.num
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.num,
            }
        }
    end,
}

local conduct = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 29,
    key = "conduct",
    set = "RSpectral",

    inversion = "c_cry_conduit",

    atlas = "consumables",
	pos = {x=10,y=6},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local card = Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card2)[1]
        local area = card.area
        local edition = Entropy.FindPreviousInPool(card.edition.key, "Edition")
        local cards = {}
        for i, v in pairs(area.cards) do
            if area.cards[i+1] == card or area.cards[i-1] == card then
                cards[#cards+1]=v
            end
        end
        Entropy.FlipThen(cards, function(card3, area, indx)
            card3:set_edition(edition)
            card3:add_to_deck()
        end)
    end,
    can_use = function(self, card)
        return #Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card) == 1 and Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card)[1].edition
        and Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card)[1].edition.key
	end,
    loc_vars = function(self,q,card)
        local str = "none"
        if #Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card) == 1 and Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card)[1].edition 
            and Entropy.FindPreviousInPool(Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card)[1].edition.key, "Edition") then
            str = G.localization.descriptions.Edition[Entropy.FindPreviousInPool(Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card)[1].edition.key, "Edition")].name
        end
        return {
            vars = {
                str
            }
        }
    end
}

local pulsar = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 30,
    key = "pulsar",
    set = "RSpectral",
    
    inversion = "c_cry_white_hole",

    atlas = "consumables",
    config = {
        level = 4
    },
    soul_rate = 0,
    hidden = true, 
	pos = {x=6,y=3},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier,amt)
        local amt = amt or 1
        local used_consumable = copier or card
        delay(0.4)
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
          { handname = localize('k_all_hands'), chips = "...", mult = "...", level = "" }
        )
        for i, v in pairs(G.GAME.hands) do
            v.AscensionPower = (v.AscensionPower or 0) + card.ability.level*amt
            v.visible = true
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
        update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+"..card.ability.level*amt })
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
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.level
            }
        }
    end,
}

local beyond = {
    object_type = "Consumable",
    order = 2000 + 31,
    key = "beyond",
    inversion = "c_cry_gateway",
    pos = {x = 0, y = 0},
    tsoul_pos = {x=2, y=0, extra = {x=1,y=0}},
    dependencies = {
        items = {"set_entr_entropics"}
    },
    atlas = "consumables",
    set = "RSpectral",
    use = function(self, card)
        local deletable_jokers = {}
		for k, v in pairs(G.jokers.cards) do
			if not v.ability.eternal then
				deletable_jokers[#deletable_jokers + 1] = v
			end
		end
		local _first_dissolve = nil
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.75,
			func = function()
				for k, v in pairs(deletable_jokers) do
					if v.config.center.rarity == "cry_exotic" then
						check_for_unlock({ type = "what_have_you_done" })
					end
                    G.GAME.banned_keys[v.config.center.key] = true
                    eval_card(v, {banishing_card = true, banisher = card, card = v, cardarea = v.area})
					v:start_dissolve(nil, _first_dissolve)
					_first_dissolve = true
				end
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, "entr_entropic", nil, nil, nil, "entr_beyond")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
    end
}

local regenerate = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 33,
    key = "regenerate",
    set = "RSpectral",
    
    can_stack = true,
	can_divide = true,
    atlas = "consumables",
    config = {
        limit = 2
    },
	pos = {x=8,y=8},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        local cards = Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeable}, card)
        Entropy.FlipThen(cards, function(card)
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
                SMODS.change_base(card, card.base.suit == "entr_nilsuit" and pseudorandom({"Spades","Clubs","Hearts","Diamonds"}, pseudoseed("regenerate")),
                    card.base.value == "entr_nilrank" and pseudorandom_element({"2", "3", "4", "5", "6", "7", "8", "9", "10", "Ace", "King", "Queen", "Jack"}, pseudoseed("regenerate"))
                )
            end
        end)
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeable}, card)
        return num > 0 and num <= card.ability.limit
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.limit
            }
        }
    end,
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
        weld,
        cleanse,
        fusion,
        substitute,
        evocation,
        mimic,
        superego,
        superego_sticker,
        engulf,
        offering,
        entomb,
        conduct,
        pulsar,
        regenerate,
        beyond
    }
}
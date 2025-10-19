local flipside = {
    object_type = "Consumable",
    order = 1000 + 1,
    key = "flipside",
    atlas = "consumables",
    pos = {x = 3, y = 0},
    dependencies = {
        items={"set_entr_inversions"}
    },
    config = {
        select = 1
    },
    set = "Spectral",
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({{cards = G.I.CARD}}, card, 1, card.ability.select)
        cards = Entropy.FilterTable(cards, function(card)
            return Entropy.Inversion(card)
        end)
        return #cards > 0 and #cards <= card.ability.select
    end,
    use = function(self, card)
        local cards = Entropy.GetHighlightedCards({{cards = G.I.CARD}}, card, 1, card.ability.select)
        local actual = Entropy.FilterTable(cards, function(card)
            return Entropy.Inversion(card)
        end)
        Entropy.FlipThen(cards, function(card)
            card.ability.fromflipside = true
            card:set_ability(G.P_CENTERS[Entropy.Inversion(card)])
            if card.ability.glitched_crown then
                for i,v in pairs(card.ability.glitched_crown) do
                    card.ability.glitched_crown[i] = Entropy.FlipsideInversions[v]
                end
            end
            card.ability.fromflipside = false
            SMODS.calculate_context({entr_consumable_inverted = true, card = card})
        end)
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select,
            }
        }
    end,
    can_be_pulled = true
}

local shatter = {
    key = "shatter",
    set = "Spectral",
    
    order = 37,
    object_type = "Consumable",
    config = {limit = 2},
    atlas = "consumables",
    pos = {x=5,y=8},
    dependencies = {
        items = {
          "set_entr_spectrals"
        }
    },
    use = function(self, card, area, copier)
        Entropy.FlipThen(G.hand.highlighted, function(card)
            card:set_edition("e_entr_fractured")
        end)
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.limit)
        return num > 0 and num <= card.ability.limit
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.e_entr_fractured
        return {vars={
            card.ability.limit
        }}
    end,
    entr_credits = {
        art = {"cassknows"}
    }
}

local destiny = {
    key = "destiny",
    set = "Spectral",
    
    order = 36,
    object_type = "Consumable",
    atlas = "consumables",
    immutable = true,
    pos = {x=5,y=7},
    dependencies = {
        items = {
          "set_entr_spectrals"
        }
    },
    use = function(self, card, area, copier)
        local remove = {}
        for i, v in pairs(G.hand.highlighted) do
            if v.config.center.key ~= "c_base" or pseudorandom("crafting") < 0.4 then
                v:start_dissolve()
                v.ability.temporary2 = true
                remove[#remove+1]=v
            else
                Entropy.DiscardSpecific({v})
            end
        end
        if #remove > 0 then SMODS.calculate_context({remove_playing_cards = true, removed=remove}) end
        add_joker(Entropy.GetRecipe(G.hand.highlighted))
        if Entropy.DeckOrSleeve("crafting") then
            if not (card.ability.overflow_amount) then
                local card2 = copy_card(card)
                card2.ability.cry_absolute = true
                card2:add_to_deck()
                G.consumeables:emplace(card2)
                card2:set_edition("e_negative")
            end
        end
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted == 5
	end,
    loc_vars = function(self, q, card)
        return {vars={
            G.hand and #G.hand.highlighted == 5 and localize({type = "name_text", set = "Joker", key = Entropy.GetRecipe(G.hand.highlighted)}) or "none"
        }}
    end,
    no_doe = true,
    in_pool = function()
        return not Entropy.DeckOrSleeve("crafting")
    end,
    weight = 0
}

local lust = {
    key = "lust",
    set = "Spectral",
    
    order = 38,
    object_type = "Consumable",
    config = {limit = 2},
    atlas = "consumables",
    pos = {x=4,y=Cryptid_config.family_mode and 8 or 7},
    dependencies = {
        items = {
          "set_entr_spectrals"
        }
    },
    use = function(self, card, area, copier)
        Entropy.FlipThen(G.hand.highlighted, function(card)
            card:set_edition("e_entr_freaky")
        end)
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.limit)
        return num > 0 and num <= card.ability.limit
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.e_entr_freaky
        return {vars={
            card.ability.limit
        }}
    end,
    entr_credits = {
        art = {"missingnumber"}
    }
}
local ref = Cryptid.reload_localization
function Cryptid.reload_localization()
    SMODS.handle_loc_file(Entropy.path)
    if G.P_CENTERS.c_entr_lust then
        G.P_CENTERS.c_entr_lust.pos = {x=4,y=Cryptid_config.family_mode and 8 or 7}
        for i, v in ipairs(G.I.CARD) do
            if v.config.center_key == "c_entr_lust" then
                v.children.center:set_sprite_pos({x=4,y=Cryptid_config.family_mode and 8 or 7})
            end
        end
    end
    if ref then
        return ref()
    else
        Entropy.config.family_mode = Cryptid_config.family_mode
        return init_localization()
    end
end


local null = {
    key = "null",
    set = "Spectral",
    
    order = 39,
    object_type = "Consumable",
    config = {create = 5},
    atlas = "consumables",
    pos = {x=3,y=7},
    dependencies = {
        items = {
          "set_entr_spectrals"
        }
    },
    use = function(self, card, area, copier)
        local destroyed_cards = {}
        destroyed_cards[#destroyed_cards+1] = pseudorandom_element(G.hand.cards, pseudoseed('random_destroy'))
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true 
        end }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function() 
                for i=#destroyed_cards, 1, -1 do
                    local card = destroyed_cards[i]
                    if card.ability.name == 'Glass Card' then 
                        card:shatter()
                    else
                        card:start_dissolve(nil, i ~= #destroyed_cards)
                    end
                end
                return true 
            end 
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function() 
                local cards = {}
                for i=1, card.ability.create do
                    cards[i] = true
                    local _suit, _rank = nil, nil
                    _rank = "entr_nilrank"
                    _suit = "entr_nilsuit"
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' then 
                            cen_pool[#cen_pool+1] = v
                        end
                    end
                    create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Spectral})
                end
                playing_card_joker_effects(cards)
                return true 
            end 
        }))
        for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = destroyed_cards})
        end
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
	end,
    loc_vars = function(self, q, card)
        return {vars={
            card.ability.create
        }}
    end,
}

local antithesis = {
    key = "antithesis",
    set = "Spectral",
    order = 80,
    object_type = "Consumable",
    atlas = "consumables",
    pos = {x=3,y=8},
    dependencies = {
        items = {
          "set_entr_spectrals"
        }
    },
    hidden = true,
    soul_set = "Spectral",
    use = function(self, card, area, copier)
        
        for i = 1, #G.jokers.cards do
            G.jokers.cards[i].ability.eternal = not G.jokers.cards[i].ability.eternal
        end
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards > 0
	end,
}

local enchant = {
    dependencies = {
        items = {
          "set_entr_runes",
          "entr_ornate"
        }
    },
    object_type = "Consumable",
    order = 40,
    key = "enchant",
    set = "Spectral",
    
    atlas = "consumables2",
    config = {
        highlighted = 1
    },
    pos = {x=1,y=0},
    use = Entropy.ModifyHandCardNF({seal="entr_ornate"}),
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.highlighted)
        return #cards > 0 and #cards <= card.ability.highlighted
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "entr_ornate_seal", set="Other"}
        return {
            vars = {
                card.ability.highlighted,
            }
        }
    end,
    entr_credits = entr_credits,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

return {
    items = {
        flipside,
        shatter,
        destiny,
        lust,
        null,
        antithesis,
        enchant
    }
}
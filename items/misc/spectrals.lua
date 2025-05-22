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
        local cards = Entropy.GetHighlightedCards({G.consumeables, G.hand, G.pack_cards, G.shop_jokers, G.shop_vouchers, G.shop_booster}, card)
        cards = Entropy.FilterTable(cards, function(card)
            return Entropy.Inversion(card)
        end)
        return #cards > 0 and #cards <= card.ability.select
    end,
    use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.consumeables, G.hand, G.pack_cards, G.shop_jokers, G.shop_vouchers, G.shop_booster}, card)
        local actual = Entropy.FilterTable(cards, function(card)
            return Entropy.Inversion(card)
        end)
        Entropy.FlipThen(cards, function(card)
            card.ability.fromflipside = true
            card:set_ability(G.P_CENTERS[Entropy.Inversion(card)])
            card.ability.fromflipside = false
        end)
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select
            }
        }
    end
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
        local num = #Entropy.GetHighlightedCards({G.hand}, nil, card)
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
            local card2 = copy_card(card)
            card2.ability.cry_absolute = true
            card2:set_edition("e_negative")
            card2:add_to_deck()
            G.consumeables:emplace(card2)
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
        return false
    end,
    weight = 0
}


return {
    items = {
        flipside,
        shatter,
        destiny
    }
}
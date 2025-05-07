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
            card:set_ability(G.P_CENTERS[Entropy.Inversion(card)])
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
        local num = Entropy.GetHighlightedCards({G.hand}, nil, card)
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

return {
    items = {
        flipside,
        shatter
    }
}
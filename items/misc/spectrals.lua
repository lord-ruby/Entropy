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
            card:set_ability(Entropy.Inversion(card))
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

return {
    items = {
        flipside
    }
}
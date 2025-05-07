function Entropy.GetHighlightedCards(cardareas, ignorecard)
    local cards = {}
    for i, area in ipairs(cardareas) do
        if area.highlighted then
            for i2, card in ipairs(area.highlighted) do
                if card ~= ignorecard then
                    cards[#cards + 1] = card
                end
            end
        end
    end
    return cards
end

function Entropy.FilterTable(table, func)
    local temp = {}
    for i, v in ipairs(table) do
        if func(v, i) then
            temp[#temp + 1] = v
        end
    end
    return temp
end

function Entropy.Inversion(card)
    return Entropy.FlipsideInversions[card.config.center.key]
end

function Entropy.FlipThen(cardlist, func, before, after)
    for i, v in ipairs(cardlist) do
        local card = cardlist[i]
        if card then
            G.E_MANAGER:add_event(
                Event(
                    {
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            if before then
                                before(card)
                            end
                            if card.flip then
                                card:flip()
                            end
                            return true
                        end
                    }
                )
            )
        end
    end
    for i, v in ipairs(cardlist) do
        local card = cardlist[i]
        if card then
            G.E_MANAGER:add_event(
                Event(
                    {
                        trigger = "after",
                        delay = 0.15,
                        func = function()
                            func(card, cardlist, i)
                            return true
                        end
                    }
                )
            )
        end
    end
    for i, v in ipairs(cardlist) do
        local card = cardlist[i]
        if card then
            G.E_MANAGER:add_event(
                Event(
                    {
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            if card.flip then
                                card:flip()
                            end
                            if after then
                                after(card)
                            end
                            return true
                        end
                    }
                )
            )
        end
    end
end

function Entropy.SealSpectral(key, sprite_pos, seal,order, inversion)
    return {
        dependencies = {
            items = {
              "set_entr_inversions",
              seal
            }
        },
        object_type = "Consumable",
        order = order,
        key = key,
        set = "RSpectral",
        
        atlas = "consumables",
        config = {
            highlighted = 1
        },
        pos = sprite_pos,
        inversion = inversion,
        --soul_pos = { x = 5, y = 0},
        use = Entropy.ModifyHandCard({seal=seal}),
        can_use = function(self, card)
            local cards = Entropy.GetHighlightedCards({G.hand}, nil, card)
            return #cards > 0 and #cards <= card.ability.highlighted
        end,
        loc_vars = function(self, q, card)
            q[#q+1] = {key = seal.."_seal", set="Other"}
            return {
                vars = {
                    card.ability.highlighted,
                    colours = {
                        SMODS.Seal.obj_table[seal].badge_colour or G.C.RED
                    }
                }
            }
        end,
    }
end

function Entropy.ModifyHandCard(modifications, cards)
    return function()
        Entropy.FlipThen(cards or G.hand.highlighted, function(mcard)
            if modifications.suit or modifications.rank then
                SMODS.change_base(mcard, modifications.suit, modifications.rank)
            end
            if modifications.enhancement then
                mcard:set_ability(G.P_CENTERS[modifications.enhancement])
            end
            if modifications.edition then
                if type(modifications.edition) == "table" then
                    mcard:set_edition(modifications.edition)
                else
                    mcard:set_edition(G.P_CENTERS[modifications.edition])
                end
            end
            if modifications.seal then
                mcard:set_seal(modifications.seal)
            end
            if modifications.sticker then
                Entropy.ApplySticker(mcard, modifications.sticker)
            end
            if modifications.extra then
                for i, v in pairs(modifications.extra) do mcard.ability[i] = v end
            end
        end)
    end
end

function Entropy.FindPreviousInPool(item, pool)
    for i, v in pairs(G.P_CENTER_POOLS[pool]) do
        if G.P_CENTER_POOLS[pool][i].key == item then
            return G.P_CENTER_POOLS[pool][i-1].key
        end
    end
    return nil
end
function Entropy.GetHighlightedCards(cardareas, ignorecard)
    local cards = {}
    for i, area in ipairs(cardareas) do
        if area.highlighted then
            for i2, card in ipairs(area.highlighted) do
                if card ~= ignorecard then cards[#cards+1]=card end
            end
        end
    end
end

function Entropy.FilterTable(table, func)
    local temp = {}
    for i, v in ipairs(table) do
        if func(v, i) then temp[#temp+1]=v end
    end
    return temp
end

function Entropy.Inversion(card)
    return Entropy.FlipsideInversions[card.config.center.key]
end
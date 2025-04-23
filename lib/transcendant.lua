function Entropy.CheckTranscendence(cards)
    local base = 1
    local suit_totals = {}
    local rank_totals = {}
    for i, v in pairs(cards) do
        if v.config.center.set ~= "Default" and v.config.center.set ~= "Enhanced" then
            if not suit_totals[v.ability.consumeable and "Consumable" or v.config.center.set] then
                suit_totals[v.ability.consumeable and "Consumable" or v.config.center.set] = 0
            end
            suit_totals[v.ability.consumeable and "Consumable" or v.config.center.set] = suit_totals[v.ability.consumeable and "Consumable" or v.config.center.set] + 1
            if not rank_totals[v.config.center.key] then
                rank_totals[v.config.center.key] = 0
            end
            rank_totals[v.config.center.key] = rank_totals[v.config.center.key] + 1
        end  
    end
    local flush = false
    local of_a_kind = 0
    for i, v in pairs(suit_totals) do
        if v == (HasJoker("j_four_fingers") and 4 or 5) then flush = true end
    end
    for i, v in pairs(rank_totals) do
        if v > of_a_kind then of_a_kind = v end
    end
    if of_a_kind == 1 then 
        return flush and "Transcendent Flush" or "None"
    end
    if of_a_kind == 2 then 
        return flush and "Transcendent Flush" or "Transcendent Pair"
    end
    if of_a_kind >= 3 then 
        return flush and "Transcendent Flush "..of_a_kind or "Transcendent "..of_a_kind.." of a Kind"
    end
    return "None", of_a_kind > 1 and math.min(of_a_kind, flush and 5 or 3) or 0
end

G.FUNCS.entr_trans_UI_set = function(e)
	e.config.object.colours = { HEX("84e1ff") }
	e.config.object:update_text()
end

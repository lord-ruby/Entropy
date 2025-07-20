function Entropy.pact_mark(key)
    if not Entropy.has_rune(key) then
        add_rune(Tag(key))
    end
    Entropy.has_rune(key).ability.count = (Entropy.has_rune(key).ability.count or 0) + 1
end

function Entropy.create_mark(key, order, pos, calculate, credits)
    return {
        object_type = "RuneTag",
        order = order,
        key = key,
        atlas = "rune_atlas",
        pos = pos,
        atlas = "rune_indicators",
        dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
        calculate = calculate
    }
end

local envy = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=6,y=4},
    order = 6666,
    key = "envy",
    soul_set = spectral and "Rune" or nil,
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_gebo",
    use = function()
        local destructible = {}
        for i, v in pairs(G.jokers.cards) do
            if not SMODS.is_eternal(v) then
                destructible[#destructible+1] = v
            end
        end
        if #destructible > 0 then
            pseudorandom_element(destructible, pseudoseed("entr_envy")):start_dissolve()
        end
        Entropy.pact_mark("rune_entr_envy")
    end,
    can_use = function()
        return true
    end
}

local envy_indicator = Entropy.create_mark("envy", 7051, {x = 6,y = 4}, function(self, mark, context)
    if #G.jokers.cards > 0 then
        if not mark.ability.joker_number then mark.ability.joker_number = pseudorandom("entr_envy_joker", 1, #G.jokers.cards) end
        if context.retrigger_joker_check and context.other_card == G.jokers.cards[mark.ability.joker_number] then
            return {
                message = localize("k_again_ex"),
                repetitions = mark.ability.count or 1,
            }
        end
        if context.end_of_round then
            mark.ability.joker_number = pseudorandom("entr_envy_joker", 1, #G.jokers.cards)
        end
    end
end)

local retriggers_ref = SMODS.calculate_retriggers
SMODS.calculate_retriggers = function(card, context, _ret)
    local retriggers = retriggers_ref(card, context, _ret)
    for _, rune in ipairs(G.GAME.runes or {}) do
        if G.P_RUNES[rune.key].calculate then
            local eval, post = G.P_RUNES[rune.key]:calculate(rune, {retrigger_joker_check = true, other_card = card, other_context = context, other_ret = _ret})
            if eval and eval.repetitions then
                for i = 1, type(eval.repetitions) == "number" and eval.repetitions or 1 do
                    retriggers[#retriggers+1] = {
                        retrigger_card = rune,
                        message_card = card,
                        card = card,
                        retrigger_flag = card,
                        retrigger_juice = rune,
                        message = eval.message,
                        repetitions = eval.repetitions
                    }
                end
            end
        end
    end
    return retriggers
end

return {
    items = {
        envy, envy_indicator
    }
}
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

local avarice_indicator = Entropy.create_mark("avarice", 7051, {x = 0, y = 4})
local avarice = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=0,y=4},
    order = 7601,
    key = "avarice",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_thusisaz",
    use = function(self, card)
        local h = G.jokers.cards[1]
        if h then
            for i, v in pairs(G.jokers.cards) do
                if to_big(v.sell_cost) > to_big(h.sell_cost) then h = v end
            end
            if to_big(h.sell_cost) == to_big(0) then
                h = pseudorandom_element(G.jokers.cards, pseudoseed("entr_avarice"))
            end
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                local copy = copy_card(h)
                h:add_to_deck()
                if h.edition and h.edition.negative then
                    h:set_edition()
                end
                G.jokers:emplace(copy)
            end
        end
        Entropy.pact_mark("rune_entr_avarice")
        if h then
            for i, v in pairs(G.I.CARD) do
                if v.set_cost then
                    v:set_cost()
                end
            end
        end
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args.source == "twisted_card" then
            return false
        end
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local rage_indicator = Entropy.create_mark("rage", 7052, {x = 1, y = 4})
local rage = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=1,y=4},
    order = 7602,
    key = "rage",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_uruz",
    use = function(self, card)
        local cards = {}
        for i, v in pairs(G.playing_cards) do
            cards[#cards+1] = v
        end
        if #cards > 0 then 
            pseudoshuffle(cards, pseudoseed("entr_rage"))
            for i = 1, math.max(math.floor(#cards/5), math.min(#cards, 5)) do
                cards[i]:start_dissolve()
            end
        end
        Entropy.pact_mark("rune_entr_rage")
    end,
    can_use = function()
        return true
    end,
    in_pool = function()
        if args.source == "twisted_card" then
            return false
        end
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local thorns_indicator = Entropy.create_mark("thorns", 7053, {x = 2, y = 4})
local thorns = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=2,y=4},
    order = 7603,
    key = "thorns",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_thusisaz",
    use = function(self, card)
        local jokers = {}
        for i, v in pairs(G.jokers.cards) do
            if not v.edition then jokers[#jokers+1] = v end
        end
        if #jokers > 0 then
            pseudoshuffle(jokers, pseudoseed("entr_thorns"))
            for i = 1, math.min(2, #jokers) do
                jokers[i]:set_edition(poll_edition("entr_thorns_edition", nil, nil, true))
                jokers[i].ability.rental = true
            end
        end
        Entropy.pact_mark("rune_entr_thorns")
    end,
    can_use = function()
        return true
    end,
    in_pool = function()
        if args.source == "twisted_card" then
            return false
        end
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local decay_indicator = Entropy.create_mark("decay", 7056, {x = 5, y = 4})
local decay = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=5,y=4},
    order = 7606,
    key = "decay",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_kaunan",
    use = function(self, card)
        local hand = "High Card"
        for i, v in pairs(G.GAME.hands) do
            if v.played > G.GAME.hands[hand].played then hand = i end
        end
        local hands = {}
        for i, v in pairs(G.GAME.hands) do
            if i ~= hand and v.visible and to_big(v.level) > to_big(0) then hands[#hands+1] = i end
        end
        for i = 1, math.min(2, #hands) do
            local rhand = pseudorandom_element(hands, pseudoseed("entr_decay_hand"))
            SMODS.smart_level_up_hand(card, rhand, false, -1)
            local ind
            for i, v in pairs(hands) do
                if v == rhand then ind = i; break end
            end
            table.remove(hands, ind)
        end

        SMODS.smart_level_up_hand(card, "High Card", false, 2)
        Entropy.pact_mark("rune_entr_decay")
    end,
    can_use = function()
        return true
    end,
    in_pool = function()
        if args.source == "twisted_card" then
            return false
        end
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local envy_indicator = Entropy.create_mark("envy", 7057, {x = 6,y = 4}, function(self, mark, context)
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
local envy = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=6,y=4},
    order = 7607,
    key = "envy",
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
    end,
    in_pool = function()
        if args.source == "twisted_card" then
            return false
        end
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

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
        avarice, avarice_indicator,
        rage, rage_indicator,
        thorns, thorns_indicator,
        decay, decay_indicator,
        envy, envy_indicator
    }
}
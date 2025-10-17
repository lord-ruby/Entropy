function Entropy.pact_mark(key)
    if not Entropy.has_rune(key) then
        add_rune(Tag(key))
    end
    Entropy.has_rune(key).ability.count = (Entropy.has_rune(key).ability.count or 0) + 1
    return Entropy.has_rune(key).ability.count
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
        calculate = calculate,
        is_pact = true,
        no_providence = true
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
    inversion = "c_entr_fehu",
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
        if args and args.source == "twisted_card" then
            return false
        end
        return true
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
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
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
    inversion = "c_entr_thurisaz",
    config = {
        extra = 2
    },
    loc_vars = function(self, q, card) return {vars = {card.ability.extra}} end,
    use = function(self, card)
        local jokers = {}
        for i, v in pairs(G.jokers.cards) do
            if not v.edition then jokers[#jokers+1] = v end
        end
        if #jokers > 0 then
            pseudoshuffle(jokers, pseudoseed("entr_thorns"))
            for i = 1, math.min(card.ability.extra, #jokers) do
                jokers[i]:set_edition(poll_edition("entr_thorns_edition", nil, nil, true))
                jokers[i].ability.rental = true
            end
        end
        Entropy.pact_mark("rune_entr_thorns")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local denial_indicator = Entropy.create_mark("denial", 7054, {x = 3, y = 4})
local denial = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=3,y=4},
    order = 7604,
    key = "denial",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_ansuz",
    use = function(self, card)
        if G.GAME.last_sold_card and not G.GAME.banned_keys[G.GAME.last_sold_card] then
            local area = G.consumeables
            local buffer = G.GAME.consumeable_buffer
            if G.P_CENTERS[G.GAME.last_sold_card].set == "Joker" then
                area = G.jokers
                buffer = G.GAME.joker_buffer
            end
            if #area.cards + buffer < area.config.card_limit then
                SMODS.add_card{
                    key = G.GAME.last_sold_card,
                    area = area
                }
            end
            G.GAME.banned_keys[G.GAME.last_sold_card] = true
        end
        Entropy.pact_mark("rune_entr_denial")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local chains_indicator = Entropy.create_mark("chains", 7055, {x = 4, y = 4}, function(self, rune, context)
    if context.hand_drawn and not rune.ability.triggered then
        local card = context.hand_drawn[1]
        if card then
            card.ability.eternal = true
        end
        rune.ability.triggered = true
    end
    if context.end_of_round then
        rune.ability.triggered = nil
    end
end)
local chains = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=4,y=4},
    order = 7605,
    key = "chains",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_raido",
    use = function(self, card)
        Entropy.pact_mark("rune_entr_chains")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
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
    config = {
        level = 1,
        hands = 2,
        most_played = 2
    },
    loc_vars = function(self, q, card) return {vars = {card.ability.level, card.ability.hands, card.ability.most_played}} end,
    use = function(self, card)
        local hand = "High Card"
        for i, v in pairs(G.GAME.hands) do
            if v.played > G.GAME.hands[hand].played then hand = i end
        end
        local hands = {}
        for i, v in pairs(G.GAME.hands) do
            if i ~= hand and v.visible and to_big(v.level) > to_big(0) then hands[#hands+1] = i end
        end
        for i = 1, math.min(card.ability.hands, #hands) do
            local rhand = pseudorandom_element(hands, pseudoseed("entr_decay_hand"))
            SMODS.smart_level_up_hand(card, rhand, false, -card.ability.level)
            local ind
            for i, v in pairs(hands) do
                if v == rhand then ind = i; break end
            end
            table.remove(hands, ind)
        end

        SMODS.smart_level_up_hand(card, "High Card", false, card.ability.most_played)
        Entropy.pact_mark("rune_entr_decay")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local envy_indicator = Entropy.create_mark("envy", 7057, {x = 6,y = 4}, function(self, mark, context)
    if #G.jokers.cards > 0 then
        if not mark.ability.joker_number then mark.ability.joker_number = pseudorandom("entr_envy_joker", 1, #G.jokers.cards) end
        if context.retrigger_rune_check and context.other_card == G.jokers.cards[mark.ability.joker_number] then
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
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
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
            local eval, post = G.P_RUNES[rune.key]:calculate(rune, {retrigger_rune_check = true, other_card = card, other_context = context, other_ret = _ret})
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

local youth_indicator = Entropy.create_mark("youth", 7058, {x = 0,y = 5})
local youth = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=0,y=5},
    order = 7608,
    key = "youth",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_wunjo",
    config = {
        extra = 1,
        rounds = 3
    },
    loc_vars = function(self, q, card) return {vars = {card.ability.extra, card.ability.rounds}} end,
    use = function(self, card)
        ease_ante(-card.ability.extra)
        local jokers = {}
        for i, v in pairs(G.jokers.cards) do
            if not v.ability.debuff_timer then jokers[#jokers+1] = v end
        end
        local dcard = pseudorandom_element(jokers, pseudoseed("entr_youth"))
        dcard.ability.debuff_timer = card.ability.rounds
        dcard.ability.debuff_timer_max = card.ability.rounds
        dcard:set_debuff(true)
        card_eval_status_text(
            dcard,
            "extra",
            nil,
            nil,
            nil,
            { message = localize("k_debuffed"), colour = G.C.RED }
        )
        Entropy.pact_mark("rune_entr_youth")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local shards_indicator = Entropy.create_mark("shards", 7059, {x = 1,y = 5})
local shards = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=1,y=5},
    order = 7609,
    key = "shards",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_haglaz",
    loc_vars = function(self, q, card) q[#q+1] = G.P_CENTERS.e_entr_fractured end,
    use = function(self, card)
        local jokers = {}
        for i, v in pairs(G.jokers.cards) do
            if not v.edition or not v.edition.entr_fractured then jokers[#jokers+1] = v end
        end
        if #jokers > 0 then
            local dcard = pseudorandom_element(jokers, pseudoseed("entr_shards"))
            dcard:set_edition("e_entr_fractured")
        end
        Entropy.pact_mark("rune_entr_shards")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

function Card:is_playing_card()
    if not G.deck then return end
    if self.area == G.play and self.ability.consumeable then return end
    if (self.area == G.hand or self.area == G.play or self.area == G.discard) and (self.config.center.set == "Default" or self.config.center.set == "Enhanced") then return true end
    for i, v in pairs(G.playing_cards) do
        if v == self then return true end
    end
end

local start_dissolveref = Card.start_dissolve
function Card:start_dissolve(...)
    if Entropy.has_rune("rune_entr_shards") and pseudorandom("entr_shards") < 0.3 and self:is_playing_card() then
        card_eval_status_text(
            self,
            "extra",
            nil,
            nil,
            nil,
            { message = localize("k_nope_ex"), colour = G.C.RED }
        )
        if self.area == G.play then
            G.E_MANAGER:add_event(Event{
                trigger = "after",
                blocking = false,
                func = function()
                    G.play:remove_card(self)
                    G.deck:emplace(self)
                    return true
                end
            })
        end
    elseif Entropy.has_rune("rune_entr_rebirth") and self:is_playing_card() then
        card_eval_status_text(
            self,
            "extra",
            nil,
            nil,
            nil,
            { message = localize("k_duplicated_ex"), colour = G.C.RED }
        )
        local copy = copy_card(self)
        copy:add_to_deck()
        table.insert(G.playing_cards, copy)
        G.hand:emplace(copy)
    else
        return start_dissolveref(self, ...)
    end
end

local shatter = Card.shatter
function Card:shatter(...)
    if Entropy.has_rune("rune_entr_shards") and pseudorandom("entr_shards") < 0.3 and self:is_playing_card() then
        card_eval_status_text(
            self,
            "extra",
            nil,
            nil,
            nil,
            { message = localize("k_nope_ex"), colour = G.C.RED }
        )
        if self.area == G.play then
            G.E_MANAGER:add_event(Event{
                trigger = "after",
                blocking = false,
                func = function()
                    G.play:remove_card(self)
                    G.deck:emplace(self)
                    return true
                end
            })
        end
    elseif Entropy.has_rune("rune_entr_rebirth") and self:is_playing_card() then
        card_eval_status_text(
            self,
            "extra",
            nil,
            nil,
            nil,
            { message = localize("k_duplicated_ex"), colour = G.C.RED }
        )
        local copy = copy_card(self)
        copy:add_to_deck()
        table.insert(G.playing_cards, copy)
        G.hand:emplace(copy)
    else
        return shatter(self, ...)
    end
end
local desire_indicator = Entropy.create_mark("desire", 7060, {x = 2, y = 5})
local desire = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=2,y=5},
    order = 7610,
    key = "desire",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_naudiz",
    config = {
        create = 2
    },
    loc_vars = function(self, q, card) return {vars = {math.min(card.ability.create, 20)}} end,
    use = function(self, card)
        local cards = {}
        for i, v in pairs(G.consumeables.cards) do if v ~= card or (card.edition and card.edition.card_limit) then cards[#cards+1] = v end end
        for i = 1, math.min(card.ability.create, 20) do
            local type = pseudorandom_element({"Spectral", "Omen"}, pseudoseed("entr_desire"))
            if G.GAME.consumeable_buffer + #cards < G.consumeables.config.card_limit - (card.edition and card.edition.card_limit or 0) then
                G.E_MANAGER:add_event(Event{
                    trigger = "after",
                    func = function()
                        SMODS.add_card{
                            area = G.consumeables,
                            set = type
                        }
                        return true
                    end
                })
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            end
        end
        G.GAME.consumeable_buffer = 0
        G.GAME.entr_booster_cost = (G.GAME.entr_booster_cost or 1) + 0.5
        Entropy.pact_mark("rune_entr_desire")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local ice_indicator = Entropy.create_mark("ice", 7061, {x = 3, y = 5})
local ice = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=3,y=5},
    order = 7611,
    key = "ice",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_isaz",
    config = {
        create = 2
    },
    loc_vars = function(self, q, card) return {vars = {math.min(card.ability.create, 20)}} end,
    use = function(self, card)
        local area
		if G.STATE == G.STATES.HAND_PLAYED then
			if not G.redeemed_vouchers_during_hand then
				G.redeemed_vouchers_during_hand =
					CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
			end
			area = G.redeemed_vouchers_during_hand
		else
			area = G.play
		end
		for i = 1, math.min(card.ability.create, 20) do
			local area
			if G.STATE == G.STATES.HAND_PLAYED then
				if not G.redeemed_vouchers_during_hand then
					G.redeemed_vouchers_during_hand =
						CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
				end
				area = G.redeemed_vouchers_during_hand
			else
				area = G.play
			end
			local _pool = get_current_pool("Voucher", nil, nil, nil, true)
			local center = pseudorandom_element(_pool, pseudoseed("entr_ice"))
			local it = 1
			while center == "UNAVAILABLE" do
				it = it + 1
				center = pseudorandom_element(_pool, pseudoseed("entr_ice_resample" .. it))
			end
			local card = create_card("Voucher", area, nil, nil, nil, nil, center)
			card:start_materialize()
			area:emplace(card)
			card.cost = 0
			card.shop_voucher = false
			local current_round_voucher = G.GAME.current_round.voucher
			card:redeem()
			G.GAME.current_round.voucher = current_round_voucher
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0,
				func = function()
					card:start_dissolve()
					return true
				end,
			}))
		end
        Entropy.pact_mark("rune_entr_ice")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local level_up_handref = level_up_hand
function level_up_hand(card, hand, ...)
    if Entropy.has_rune("rune_entr_ice") then
        local bhand = "High Card"
        for i, v in pairs(G.GAME.hands) do
            if to_big(v.level) > to_big(G.GAME.hands[bhand].level) then
                bhand = i
            end
        end
        if hand == bhand then
            if card then
                card_eval_status_text(
                    card,
                    "extra",
                    nil,
                    nil,
                    nil,
                    { message = localize("k_nope_ex"), colour = G.C.RED }
                )
            end
        else
            return level_up_handref(card, hand, ...)
        end
    else
        return level_up_handref(card, hand, ...)
    end
end

local gluttony_indicator = Entropy.create_mark("gluttony", 7062, {x = 4, y = 5})
local gluttony = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=4,y=5},
    order = 7612,
    key = "gluttony",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_jera",
    config = {
        slots = 2
    },
    loc_vars = function(self, q, card) return {vars = {math.min(card.ability.slots, 20)}} end,
    use = function(self, card)
        G.consumeables:handle_card_limit(math.min(card.ability.slots, 20))
        for i, v in pairs(G.I.CARD) do
            if v.ability and v.ability.consumeable then v.ability.eternal = true end
        end
        Entropy.pact_mark("rune_entr_gluttony")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local set_abilityref = Card.set_ability
function Card:set_abilityref(...)
    set_abilityref(self, ...)
    if self.ability.consumeable and Entropy.has_rune("rune_entr_gluttony") then
        self.ability.eternal = true
    end
end

local can_sellref = Card.can_sell_card
function Card:can_sell_card(context)
    if self.ability.eternal or SMODS.is_eternal(self, {from_sell = true}) then return false end
    return can_sellref(self, context)
end

local rebirth_indicator = Entropy.create_mark("rebirth", 7063, {x = 5, y = 5})
local rebirth = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=5,y=5},
    order = 7613,
    key = "rebirth",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_ihwaz",
    config = {
        hand_size = 1
    },
    loc_vars = function(self, q, card) return {vars = {math.min(card.ability.hand_size, 1000)}} end,
    use = function(self, card)
        G.hand:handle_card_limit(- math.min(card.ability.hand_size, 1000))
        Entropy.pact_mark("rune_entr_rebirth")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local despair_indicator = Entropy.create_mark("despair", 7064, {x = 6, y = 5})
local despair = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=6,y=5},
    order = 7614,
    key = "despair",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_perthro",
    config = {
        percentage = 25,
        rounds = 5
    },
    loc_vars = function(self, q, card) return {vars = {G.hand and G.hand.config.card_limit or 8, card.ability.percentage, card.ability.rounds}} end,
    use = function(self, card)
        local cards = {}
        for i, v in pairs(G.playing_cards) do
            cards[#cards+1] = v
        end 
        pseudoshuffle(cards, pseudoseed("entr_despair"))
        for i = 1, math.min(G.hand.config.card_limit, #cards) do
            local enhancement = pseudorandom_element(G.P_CENTER_POOLS["Enhanced"], pseudoseed("entr_despair")).key
            while G.P_CENTERS[enhancement].no_doe or G.GAME.banned_keys[enhancement] do
                enhancement = pseudorandom_element(G.P_CENTER_POOLS["Enhanced"], pseudoseed("entr_despair")).key
            end
            cards[i]:flip()
            cards[i]:set_ability(G.P_CENTERS[enhancement])
            cards[i]:flip()
        end
        pseudoshuffle(cards, pseudoseed("entr_despair"))
        for i = 1, math.floor(card.ability.percentage / 100 * #cards) do
            local dcard = cards[i]
            dcard.ability.debuff_timer = card.ability.rounds
            dcard.ability.debuff_timer_max = card.ability.rounds
            dcard:set_debuff(true)
        end
        Entropy.pact_mark("rune_entr_despair")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local play_ref = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
    for i, v in pairs(G.hand.highlighted) do
        v.ability.entr_times_played = (v.ability.entr_times_played or 0) + 1
    end
    local text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
    if text == "Full House" and (next(SMODS.find_card("j_entr_ruby") or next(SMODS.find_card("j_entr_slipstream"))) or next(SMODS.find_card("j_entr_cassknows")) or next(SMODS.find_card("j_entr_crabus"))) then
        check_for_unlock({type = "suburban_jungle"})
    end
    local text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
    if text == "entr_derivative" and next(SMODS.find_card("j_entr_antiderivative")) then
        check_for_unlock({type = "anti_derivative"})
    end
    G.GAME.asc_power_hand = 0
    play_ref(e)
end

local strength_indicator = Entropy.create_mark("strength", 7065, {x = 0, y = 6})
local strength = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=0,y=6},
    order = 7615,
    key = "strength",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_algiz",
    config = {
        copies = 3
    },
    loc_vars = function(self, q, card) 
        if not card.ability.rental then
            q[#q+1] = {set="Other", key = "rental", vars = {5, 5}}
        end
        return {vars = {math.min(card.ability.copies, 100)}} 
    end,
    use = function(self, rcard)
        local card
        local cards = {}
        for i, v in pairs(G.playing_cards) do
            if not card or (v.ability.entr_times_played or 0) > (card.ability.entr_times_played or 0) then
                if v.T then
                    card = v
                    cards[#cards+1] = v
                end
            end
        end 
        if not card then card = pseudorandom_element(cards, pseudoseed("entr_strength")) end
        if card and card.T then
            for i = 1, math.min(rcard.ability.copies, 100) do
                card_eval_status_text(
                    card,
                    "extra",
                    nil,
                    nil,
                    nil,
                    { message = localize("k_duplicated_ex"), colour = G.C.RED }
                )
                local copy = copy_card(card)
                copy:add_to_deck()
                table.insert(G.playing_cards, copy)
                G.hand:emplace(copy)
            end
        end
        local joker = pseudorandom_element(G.jokers.cards, pseudoseed("entr_strength"))
        if joker then
            joker.ability.rental = true
            joker:juice_up()
        end
        Entropy.pact_mark("rune_entr_strength")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local darkness_indicator = Entropy.create_mark("darkness", 7066, {x = 1, y = 6})
local darkness = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=1,y=6},
    order = 7616,
    key = "darkness",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_sowilo",
    loc_vars = function(self, q, card) 
        if not card.ability.rental then
            q[#q+1] = G.P_CENTERS.e_negative
        end
    end,
    use = function(self, rcard)
        local cards = {}
        for i, v in pairs(G.jokers.cards) do
            if not v.edition or not v.edition.negative then
                cards[#cards+1] = v
            end
        end 
        local joker = pseudorandom_element(cards, pseudoseed("entr_strength"))
        if joker then
            joker:set_edition("e_negative")
        end
        local level = Entropy.pact_mark("rune_entr_darkness")
        G.GAME.modifiers.flipped_cards = 5 / (level ^ 0.5)
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local freedom_indicator = Entropy.create_mark("freedom", 7067, {x = 2, y = 6})
local freedom = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=2,y=6},
    order = 7617,
    key = "freedom",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_tiwaz",
    loc_vars = function(self, q, card) 
        return {
            vars = {
                number_format(card.ability.selection_limit),
                number_format(card.ability.hand_size),
            }
        }
    end,
    config = {
        selection_limit = 2,
        hand_size = 2
    },
    use = function(self, rcard)
        G.hand:handle_card_limit(-rcard.ability.hand_size)
        Entropy.ChangeFullCSL(rcard.ability.selection_limit)
        Entropy.pact_mark("rune_entr_freedom")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local eternity_indicator = Entropy.create_mark("eternity", 7068, {x = 3, y = 6})
local eternity = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=3,y=6},
    order = 7618,
    key = "eternity",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_berkano",
    loc_vars = function(self, q, card) 
        return {
            vars = {
                number_format(card.ability.asc_power + (G.GAME.entr_black_dwarf or 0)),
            }
        }
    end,
    config = {
        asc_power = 4
    },
    use = function(self, rcard)
        local cards = {}
        for i, v in pairs(G.jokers.cards) do
            if not SMODS.is_eternal(v) then
                cards[#cards+1] = v
            end
        end 
        local joker = pseudorandom_element(cards, pseudoseed("entr_strength"))
        if joker then
            joker.ability.eternal = true
            joker:juice_up()
        end
        local hand = "High Card"
        for i, v in pairs(G.GAME.hands) do
            if v.played > G.GAME.hands[hand].played then
                hand = i
            end
        end
        Entropy.ReversePlanetUse(hand, rcard, rcard.ability.asc_power + (G.GAME.entr_black_dwarf or 0))
        Entropy.pact_mark("rune_entr_eternity")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local loyalty_indicator = Entropy.create_mark("loyalty", 7069, {x = 4, y = 6}, function(self, rune, context)
    if not rune.ability.hand then rune.ability.hand = 0 end
    if context.final_scoring_step and rune.ability.hand % 2 == 0 then
        rune.ability.hand = rune.ability.hand + 1
        G.E_MANAGER:add_event(Event{
            func = function()
                attention_text({
                    scale = 1.4,
                    text = localize({ type = "variable", key = "a_xmult", vars = { 0.5 }}),
                    hold = 2,
                    align = "cm",
                    offset = { x = 0, y = -2.7 },
                    major = G.play,
                })
                return true
            end
        })
        return {
            Xmult_mod = 0.5,
        }
    elseif context.final_scoring_step then
        rune.ability.hand = rune.ability.hand + 1
    end
end)
local loyalty = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=4,y=6},
    order = 7619,
    key = "loyalty",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_ehwaz",
    immutable = true,
    use = function(self, rcard)
        Entropy.pact_mark("rune_entr_loyalty")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local brimstone_indicator = Entropy.create_mark("brimstone", 7070, {x = 5, y = 6}, function(self, rune, context)
    if context.final_scoring_step then
        G.E_MANAGER:add_event(Event{
            func = function()
                attention_text({
                    scale = 1.4,
                    text = localize({ type = "variable", key = "a_xmult", vars = { 3.6 }}),
                    hold = 2,
                    align = "cm",
                    offset = { x = 0, y = -2.7 },
                    major = G.play,
                })
                return true
            end
        })
        return {
            Xmult_mod = 3.6,
        }
    end
end)
local brimstone = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=5,y=6},
    order = 7620,
    key = "brimstone",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_mannaz",
    immutable = true,
    config = {
        hands = 1
    },
    loc_vars = function(self, q, card) return {vars = {card.ability.hands}} end,
    use = function(self, card)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.hands
        ease_hands_played(-card.ability.hands)
        Entropy.pact_mark("rune_entr_brimstone")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local dreams_indicator = Entropy.create_mark("dreams", 7071, {x = 6, y = 6})
local dreams = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=6,y=6},
    order = 7621,
    key = "dreams",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_laguz",
    immutable = true,
    config = {
        tags = 6
    },
    loc_vars = function(self, q, card) return {vars = {math.min(card.ability.tags, 20)}} end,
    use = function(self, card)
        for i = 1, math.min(card.ability.tags, 20) do
            tag = Tag(get_next_tag_key())
            add_tag(tag)
        end
        G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
        G.GAME.modifiers.no_blind_reward.Small = true
        Entropy.pact_mark("rune_entr_dreams")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local energy_indicator = Entropy.create_mark("energy", 7072, {x = 0, y = 7})
local energy = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=0,y=7},
    order = 7622,
    key = "energy",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_ingwaz",
    immutable = true,
    config = {
        discards = 1
    },
    loc_vars = function(self, q, card) return {vars = {card.ability.discards}} end,
    use = function(self, card)
        for i, v in pairs(G.GAME.last_discarded or {}) do
            v:set_edition(poll_edition("entr_energy", nil, true, true))
        end
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.discards
        ease_discard(-card.ability.discards)
        Entropy.pact_mark("rune_entr_energy")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local discard_ref = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function(e, hook)
    G.GAME.last_discarded = {}
    for i, v in pairs(G.hand.highlighted) do
        G.GAME.last_discarded[#G.GAME.last_discarded+1] = v
    end
    discard_ref(e, hook)
end

--pact of awakening here

local awakening_indicator = Entropy.create_mark("awakening", 7073, {x = 2, y = 7})
local awakening = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=2,y=7},
    order = 7623,
    key = "awakening",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_dagaz",
    immutable = true,
    config = {
        shop_size = 1
    },
    loc_vars = function(self, q, card) q[#q + 1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}; return {vars = {card.ability.shop_size}} end,
    use = function(self, card)
        local mod = math.floor(card and card.ability.shop_size or 1)
        SMODS.change_booster_limit(-mod)
        local card = SMODS.add_card{
            set = "Voucher",
            area = G.consumeables
        }
        card:set_edition("e_negative")
        Entropy.pact_mark("rune_entr_awakening")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local blood_indicator = Entropy.create_mark("blood", 7074, {x = 1, y = 7})
local blood = {
    object_type = "Consumable",
    set = "Pact",
    atlas = "rune_atlas",
    pos = {x=1,y=7},
    order = 7624,
    key = "blood",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_othila",
    immutable = true,
    config = {
        random = 5
    },
    loc_vars = function(self, q, card) q[#q+1] = {set="Other",key="link", vars = {"[LINK_KEY]"}}; return {vars = {card.ability.random}} end,
    use = function(self, card)
        local cards = {}
        for i, v in pairs(G.playing_cards) do
            if v.base then cards[#cards+1] = v end
        end
        local linktxt
        for i, v in pairs(cards) do
            if v.ability.link then linktxt = v.ability.link end
        end
        linktxt = linktxt or Entropy.StringRandom(8)
        pseudoshuffle(cards, pseudoseed("entr_blood"))
        for i = 1, math.min(#cards, card.ability.random) do
            local v = cards[i]
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
        Entropy.pact_mark("rune_entr_blood")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local serpents_indicator = Entropy.create_mark("serpents", 7075, {x = 3, y = 7})
local serpents = {
    object_type = "Consumable",
    set = "Omen",
    atlas = "rune_atlas",
    pos = {x=3,y=7},
    order = 7625,
    key = "serpents",
    dependencies = {items = {"set_entr_runes", "set_entr_inversions"}},
    inversion = "c_entr_oss",
    immutable = true,
    no_select = true,
    loc_vars = function(self, q, card) return {vars = {card.ability.dollars}} end,
    use = function(self, card)
        local omens = {}
        for i, v in pairs(G.P_CENTERS) do
            if v.hidden and not v.no_collection and (not v.in_pool or v:in_pool({}) and v.key ~= "c_entr_serpents") then
                omens[#omens+1] = v.key
            end
        end
        local key = pseudorandom_element(omens, pseudoseed("entr_serpents"))
        SMODS.add_card{
            key = key,
            area = G.consumeables
        }
        Entropy.pact_mark("rune_entr_serpents")
    end,
    can_use = function()
        return true
    end,
    in_pool = function(self, args)
        if args and args.source == "twisted_card" then
            return false
        end
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

return {
    items = {
        avarice, avarice_indicator,
        rage, rage_indicator,
        thorns, thorns_indicator,
        denial, denial_indicator,
        chains, chains_indicator,
        decay, decay_indicator,
        envy, envy_indicator,
        youth, youth_indicator,
        shards, shards_indicator,
        desire, desire_indicator,
        ice, ice_indicator,
        gluttony, gluttony_indicator,
        rebirth, rebirth_indicator,
        despair, despair_indicator,
        strength, strength_indicator,
        darkness, darkness_indicator,
        freedom, freedom_indicator,
        eternity, eternity_indicator,
        loyalty, loyalty_indicator,
        brimstone, brimstone_indicator,
        dreams, dreams_indicator,
        energy, energy_indicator,
        blood, blood_indicator,
        awakening, awakening_indicator,
        serpents, serpents_indicator
    }
}
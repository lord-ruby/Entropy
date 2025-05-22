if FinisherBossBlindStringMap then
    FinisherBossBlindStringMap["bl_entr_endless_entropy_phase_four"] = {"j_entr_endlessentropy", "Endless Entropy"}

    local ee_hand_funcs = {
        function(self, card, context)
            if context.joker_main then
                local card = pseudorandom_element(G.playing_cards, pseudoseed("ee_hand1"))
                card:set_edition("e_entr_sunny")
            end
        end,
        function(self, card, context)
            G.GAME.nodebuff = true
        end,
        function(self, card, context)
            if context.joker_main then
                for i, v in ipairs(G.jokers.cards) do
                    local card = G.jokers.cards[i]
                    if not Card.no(card, "immutable", true) then
                        Cryptid.with_deck_effects(card, function(card)
                            Cryptid.misprintize(card, { min = 1.666, max = 1.66 }, nil, true)
                        end)
                        check = true
                    end
                end
                card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
            end
        end,
        function(self, card, context)
            if context.joker_main then
                local res2 = {}
                if #G.jokers.cards > 1 then
                    local v = pseudorandom_element(G.jokers.cards, pseudoseed("ee_hand4"))
                    while v == card do
                        v = pseudorandom_element(G.jokers.cards, pseudoseed("ee_hand4"))
                    end
                    if Cryptid.demicolonGetTriggerable(v)then
                        local results = Cryptid.forcetrigger(v, context)
                        if results then
                            for i, v in pairs(results) do
                                for i2, result in pairs(v) do
                                    if type(result) == "number" or (type(result) == "table" and result.tetrate) then
                                        res[i2] = Entropy.StackEvalReturns(res[i2], result, i2)
                                    else
                                        res[i2] = result
                                    end
                                end
                            end
                        end
                        card_eval_status_text(
                            v,
                            "extra",
                            nil,
                            nil,
                            nil,
                            { message = localize("cry_demicolon"), colour = G.C.GREEN }
                        )
                    end
                end
            end
        end
    }

    local ee_discard_funcs = {
        function(self, card, context)
            if context.pre_discard then
                if #G.hand.highlighted == 1 then
                    local cards = {}
                    for i, v in ipairs(G.hand.cards) do if not v.highlighted then cards[#cards+1] = v end end
                    pseudoshuffle(cards, pseudoseed('ee_discard1'))
                    local actual = {}
                    for i = 1, 2 do
                        actual[i] = cards[i]
                    end
                    Entropy.FlipThen(actual, function(card)
                        card:set_edition(G.hand.highlighted[1].edition and G.hand.highlighted[1].edition.key)
                    end)
                end
            end
        end,
        function(self, card, context)
            if context.joker_main then
                for i, v in ipairs(G.play.cards) do
                    local card2 = copy_card(v)
                    card2.ability.banana = true
                    card2:set_edition("e_negative")
                    card2:add_to_deck()
                    G.hand:emplace(card2)
                    table.insert(G.playing_cards, card2)
                end
            end
        end,
        function(self, card, context)
            if context.pre_discard then
                for i = 1, #G.hand.highlighted do
                    add_tag(Tag(pseudorandom_element(Entropy.AscendedTags, pseudoseed("ee_discard3"))))
                end
            end
        end,
        function(self, card, context)
            if context.joker_main then
                return {
                    eemult = 3
                }
            end
        end,
    }

    local endless_entropy = {
        object_type = "Joker",
        key = "entr_endlessentropy",
        order = 10^300,
        rarity = "finity_showdown",
        cost = 10,
        atlas = "ee_atlas",
        pos = {x=0, y=0},
        soul_pos = {x = 4, y = 3, extra = {x=0,y=1}},
        entr_credits = {
            art = {"missingnumber"}
        },
        loc_vars = function(self, q, card)
            return {
                vars = {
                    localize("k_ee_hand_"..(card.ability.immutable.ee_handeffect or 1)),
                    localize("k_ee_discard_"..(card.ability.immutable.ee_discardeffect or 1))
                }
            }
        end,
        config = {
            immutable = {
                ee_discardeffect = 1,
                ee_handeffect = 1
            }
        },
        calculate = function(self, card, context)
            local ret = {}
            local ret1 = ee_hand_funcs[card.ability.immutable.ee_handeffect or 1](self, card, context)
            local ret2 = ee_discard_funcs[card.ability.immutable.ee_discardeffect or 1](self, card, context)
            for i, v in pairs(ret1 or {}) do ret[i]=v end
            for i, v in pairs(ret2 or {}) do ret[i]=v end
            if context.joker_main then
                G.GAME.nodebuff = false
                card.ability.immutable.ee_handeffect = (card.ability.immutable.ee_handeffect or 1) + 1
                if card.ability.immutable.ee_handeffect > 4 then card.ability.immutable.ee_handeffect = 1 end
                if card.ability.immutable.ee_handeffect == 2 then G.GAME.nodebuff = true end
                card.children.floating_sprite:set_sprite_pos({x=pseudorandom_element({2,3,4}, pseudoseed("ee_X")), y= (card.ability.immutable.ee_discardeffect or 1)-1})
                print(card.ability.immutable.ee_discardeffect)
            end
            if context.pre_discard then
                card.ability.immutable.ee_discardeffect = (card.ability.immutable.ee_discardeffect or 1) + 1
                if card.ability.immutable.ee_discardeffect > 4 then card.ability.immutable.ee_discardeffect = 1 end
                card.children.floating_sprite2:set_sprite_pos({x=1, y=(card.ability.immutable.ee_discardeffect or 1)-1})
                card.children.floating_sprite:set_sprite_pos({x=pseudorandom_element({2,3,4}, pseudoseed("ee_X")), y= (card.ability.immutable.ee_discardeffect or 1)-1})
            end
            if ret1 or ret2 then return ret end
        end,
        in_pool = function()
            return false
        end,
        add_to_deck = function(self, card)
            card.children.floating_sprite2:set_sprite_pos({x=1,y=0})
            card.children.floating_sprite:set_sprite_pos({x=pseudorandom_element({2,3,4}, pseudoseed("ee_X")), y = 0})
        end
    }


    return {
        items = {
            endless_entropy
        }
    }
end
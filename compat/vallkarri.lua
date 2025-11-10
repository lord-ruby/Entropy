if (SMODS.Mods["vallkarri"] or {}).can_load then

    local asc_kitty = {
        object_type = "Tag",
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 100,
        key = "ascendant_kitty",
        atlas = "crossmod_tags",
        pos = {x=0,y=0},
        config = { chips = 1.1 },
        loc_vars = function(self, info_queue, tag)
            return { vars = { tag.config.chips } }
        end,
        in_pool = function() return false end,

        apply = function(self, tag, context)
            if context.type == "valk_final_scoring_step" then --functionality assisted by reading morefluff code
                for i = 1, vallkarri.count_kitty_tags() do
                    local chips = tag.config.chips
                    G.CARD_H = -G.CARD_H -- manipulate y_off
                    SMODS.calculate_effect({ xchips = chips }, tag.HUD_tag)
                    G.CARD_H = -G.CARD_H
                end
            end
        end
    }

    local eternal_negative = {
        object_type = "Tag",
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 101,
        key = "ascendant_negative_eternal",
        atlas = "crossmod_tags",
        pos = {x=1,y=0},
        config = { type = "store_joker_modify" },
        in_pool = function() return false end,
        apply = function(self, tag, context)
            if context.type == "store_joker_modify" then
                tag:yep("+", nil, function()
                    for i, v in pairs(G.shop_jokers.cards) do
                        v:set_edition("e_negative")
                        v:set_eternal(true)
                        v.ability.eternal = true
                    end
                    for i, v in pairs(G.shop_booster.cards) do
                        v:set_edition("e_negative")
                        v:set_eternal(true)
                        v.ability.eternal = true
                    end
                    for i, v in pairs(G.shop_vouchers.cards) do
                        v:set_edition("e_negative")
                        v:set_eternal(true)
                        v.ability.eternal = true
                    end
                    return true
                end)
                tag.triggered = true
            end
        end,
        loc_vars = function(s,q,c)
            q[#q+1] = G.P_CENTERS.e_negative
        end,
    }

    local highway = {
        object_type = "Consumable",
        order = 9000 + 10,
        key = "highway",
        inversion = "c_valk_freeway",
        pos = {x = 1, y = 2},
        tsoul_pos = {x=3, y=2, extra = {x=2,y=2}},
        dependencies = {
            items = {"set_entr_entropics", "set_entr_inversions"}
        },
        atlas = "crossmod_consumables",
        set = "Omen",
        no_select = true,
        hidden=true,
        soul_rate = 0,
        use = function(self, card)
            local deletable_jokers = {}
            local rand = pseudorandom_element(G.jokers.cards, pseudoseed("entr_highway"))
            for k, v in pairs(G.jokers.cards) do
                if not SMODS.is_eternal(v) then
                    deletable_jokers[#deletable_jokers + 1] = v
                end
            end
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0.75,
                func = function()
                    for k, v in pairs(deletable_jokers) do
                        if v.config.center.rarity == "cry_exotic" then
                            check_for_unlock({ type = "what_have_you_done" })
                        end
                        v:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("timpani")
                    local card = create_card("Joker", G.jokers, nil, "entr_entropic", nil, nil, nil, "entr_beyond")
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    card:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            delay(0.6)
        end,
        can_use = function() return true end,
        demicoloncompat = true,
        force_use = function(self, card)
            self:use(card)
        end
    }

    local items = {
        asc_kitty,
        eternal_negative,
        highway
    }
    local aesthetics = {
        { pos = { x = 0, y = 0 }, edition = "e_entr_neon", key = "vintage" },
        { pos = { x = 1, y = 0 }, edition = "e_entr_lowres", key = "retro" },
        { pos = { x = 2, y = 0 }, edition = "e_entr_sunny", key = "ytp" },
        { pos = { x = 3, y = 0 }, edition = "e_entr_solar", key = "solarpunk" },
        { pos = { x = 4, y = 0 }, edition = "e_entr_fractured", key = "breakcore" },
        { pos = { x = 0, y = 1 }, edition = "e_entr_freaky", key = "lewd", credits = {art = {"gudusername_53951"}} },
        { pos = { x = 1, y = 1 }, edition = "e_entr_kaleidoscopic", key = "disco" },
    }
    local order = 10000
    for i, v in pairs(aesthetics) do
        items[#items+1] =  {
            object_type = "Consumable",
            set = "Aesthetic",
            key = v.key,
            cost = 7,
            pos = v.pos,
            atlas = "aes",
            config = { extra = { select = 1, edition = v.edition } },
            order = order,
            loc_vars = function(self, info_queue, card)
                info_queue[#info_queue + 1] = G.P_CENTERS[v.edition]
                return { vars = { 
                    card.ability.extra.select,
                    localize({ type = "name_text", set = "Edition", key = card.ability.extra.edition })
                } }
            end,
            can_use = function(self, card)
                local sed = true
                for i, jkr in ipairs(G.jokers.highlighted) do
                    if jkr.edition then
                        sed = false
                    end
                end
                return (#G.jokers.highlighted > 0) and (#G.jokers.highlighted <= card.ability.extra.select) and sed
            end,
            use = function(self, card, area, copier)
                for i, high in ipairs(G.jokers.highlighted) do
                    high:set_edition(card.ability.extra.edition)
                end
            end,
            dependencies = {
                items = {
                    "set_entr_misc",
                    v.edition
                }
            },
            entr_credits = v.credits
        }
        order = order + 1
    end
    return {
        items = items
    }
end
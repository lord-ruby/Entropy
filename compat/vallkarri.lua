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

    return {
        items = {
            asc_kitty,
            eternal_negative
        }
    }
end
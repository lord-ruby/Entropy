if (SMODS.Mods["aikoyorisshenanigans"] or {}).can_load then
    local verbophobia = {
        order = -99,
        object_type = "Joker",
        key = "verbophobia",
        rarity = 2,
        cost = 6,
        dependencies = {
            items = {            
                "set_entr_inversions"
            }
        },
        eternal_compat = true,
        pos = { x = 1, y = 0 },
        atlas = "crossmod_jokers",
        calculate = function(self, card, context)
            if context.setting_blind then
                card.ability.triggered = nil
            end
            if context.after then
                card.ability.triggered = true
            end
        end,
    }
    local loadmodsref = SMODS.injectItems
    function SMODS.injectItems(...)
        loadmodsref(...)
        if not G.entr_akyrs_loaded then
            local check_wordref = AKYRS.check_word
            function AKYRS.check_word(str_arr_in)
                if #str_arr_in <= 5 then
                    local check
                    for i, v in pairs(SMODS.find_card("j_entr_verbophobia")) do
                        if not v.ability.triggered then
                            check = true
                        end
                    end
                    if check then
                        local word_str = table.concat(str_arr_in)
                        return { valid = word_str, word = word_str}
                    end
                end
                return check_wordref(str_arr_in)
            end
            G.entr_akyrs_loaded = true
        end
    end
    return {
        items = {
            verbophobia
        }
    }
end
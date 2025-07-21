if RevosVault then
    local compositor = {
        order = -100,
        object_type = "Joker",
        key = "compositor",
        rarity = "crv_p",
        cost = 10,
        dependencies = {
            items = {
                "set_entr_misc_jokers",
            }
        },
        unlocked = true,
        discovered = false,
        eternal_compat = true,
        pos = { x = 0, y = 0 },
        atlas = "crossmod_jokers",
        demicoloncompat = true,
        calculate = function(self, card, context)
            if context.setting_blind or context.forcetrigger then
                SMODS.add_card{
                    set = "Twisted",
                    area = G.consumeables,
                    edition = G.GAME.used_vouchers["v_crv_printerup"] == true and "e_negative" or nil
                }
            end
        end
    }
    return {
        items = {
            compositor
        }
    }
end
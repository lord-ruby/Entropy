if (SMODS.Mods["Multiplayer"] or {}).can_load then
    return {
        items = {
            {
                object_type = "Consumable",
                key = "supernova",
                set = "Star",
                atlas = "consumables",
                pos = {x = 0, y = 7},
                cost = 3,
                unlocked = true,
                discovered = true,
                inversion = "c_mp_asteroid",
                order = -100,
                dependencies = {
                    items = {
                        "set_entr_inversions"
                    }
                },
                loc_vars = function(self, info_queue, card)
                    add_nemesis_info(info_queue)
                    return { vars = { 2 } }
                end,
                in_pool = function(self)
                    return MP.LOBBY.code and MP.LOBBY.config.multiplayer_jokers
                end,
                can_use = function(self, card)
                    return true
                end,
                use = function(self, card, area, copier)
                    MP.ACTIONS.remove_phantom("entr_weirdhack_collapse")
                end,
            }
        }
    }
end
local ruby = {
    object_type = "Joker",
    key = "ruby",
    order = 10^300,
    rarity = "entr_zenith",
    cost = 1e300,
    atlas = "ruby_atlas",
    pos = {x=0, y=0},
    soul_pos = {x = 1, y = 0},
    no_doe = true,
    no_collection = true,
    loc_vars = function()
        return {
            vars = {
                "{", "}"
            }
        }
    end,
    calculate = function(self, card, context)
        if context.game_over and pseudorandom("ruby") < 0.5 then
            return {
                message = pseudorandom("ruby") < 0.5 and localize("k_saved_heoric") or localize("k_saved_just"),
                saved = true,
                colour = G.C.RED,
            }
        end
        if context.joker_main then
            return {
                mult = 666,
                hypermult_mod = {
                    25000,
                    10^300
                }
            }
        end
    end,
    add_to_deck = function(self, card)
        G.jokers.config.card_limit = -999
        card.ability.cry_absolute = true
    end
}

return {
    items = {
        ruby
    }
}
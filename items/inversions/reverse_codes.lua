local memoryleak = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 3000 + 1,
    key = "memory_leak",
    set = "RCode",

    inversion = "c_cry_crash",

    atlas = "consumables",
	pos = {x=0,y=1},

    use = function(self, card)
        if pseudorandom("memoryleak") < (1/4) then
            glitched_intensity = 100
            G.SETTINGS.GRAPHICS.crt = 100
            G.GAME.USING_CODE = true
            G.ENTERED_ACE = ""
            G.CHOOSE_ACE = UIBox({
                definition = create_UIBox_memleak(card),
                config = {
                    align = "bmi",
                    offset = { x = 0, y = G.ROOM.T.y + 29 },
                    major = G.jokers,
                    bond = "Weak",
                    instance_type = "POPUP",
                },
            })
        else
            for i, v in pairs(G.jokers.cards) do
                v:start_dissolve()
            end
            for i, v in pairs(G.consumables.cards) do
                v:start_dissolve()
            end
        end
    end
    can_use = function() return true end
}

return {
    items = {
        memoryleak
    }
}
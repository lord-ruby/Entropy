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
            for i, v in pairs(G.consumeables.cards) do
                v:start_dissolve()
            end
        end
    end,
    can_use = function() return true end
}

local rootkit = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 3000 + 2,
    key = "root_kit",
    set = "RCode",

    inversion = "c_cry_payload",

    atlas = "consumables",
	pos = {x=1,y=1},

    config = {
        perhand = 10
    }

    use = function(self, card, area, copier)
        G.GAME.RootKit = (G.GAME.RootKit or 0) + card.ability.perhand
    end,
    bulk_use = function(self, card, area, copier, number)
		G.GAME.RootKit = (G.GAME.RootKit or 0) + card.ability.perhand * number
	end,
    can_use = function() return true end
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.perhand
            }
        }
    end
}

return {
    items = {
        memoryleak,
        rootkit
    }
}
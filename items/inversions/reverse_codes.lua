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
    },

    use = function(self, card, area, copier)
        G.GAME.RootKit = (G.GAME.RootKit or 0) + card.ability.perhand
    end,
    bulk_use = function(self, card, area, copier, number)
		G.GAME.RootKit = (G.GAME.RootKit or 0) + card.ability.perhand * number
	end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.perhand
            }
        }
    end
}

local bootstrap = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 3000 + 3,
    key = "bootstrap",
    set = "RCode",

    inversion = "c_cry_payload",

    atlas = "consumables",
	pos = {x=2,y=1},
    use = function(self, card, area, copier)
        G.GAME.UsingBootstrap = true
    end,
    can_use = function() return true end,
}

local quickload = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3000+4,
    key = "quickload",
    set = "RCode",
    
    inversion = "c_cry_revert",

    atlas = "consumables",
    pos = {x=3,y=1},
    use = function(self, card, area, copier)
        G.STATE = 8
        G.STATE_COMPLETE = false
        if G.SHOP_SIGN then     
            G.SHOP_SIGN:remove()
        end
    end,
    can_use = function(self, card)
        return G.STATE == 5
	end,
    loc_vars = function(self, q, card)
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

local break_card = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3000+5,
    key = "break",
    set = "RCode",
    
    inversion = "c_cry_run",

    atlas = "consumables",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=5,y=1},
    use = function(self, card, area, copier)
        for i, v in pairs(G.GAME.round_resets.blind_states) do
            if v == "Current" then v = "Upcoming" end
        end
        G.E_MANAGER:add_event(Event({
			trigger = "immediate",
			func = function()
                G.STATE = 7
				--G.GAME.USING_RUN = true
				--G.GAME.RUN_STATE_COMPLETE = 0
				G.STATE_COMPLETE = false
                G.GAME.USING_BREAK = true
                break_timer = 0
                G.FUNCS.draw_from_hand_to_deck()
				return true
			end,
		}))
        if G.blind_select then        
            G.blind_select:remove()
            G.blind_prompt_box:remove()
        end
    end,
    can_use = function(self, card)
        for i, v in pairs(G.GAME.round_resets.blind_states) do
            if v == "Current" then return true end
        end
        return false
	end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

return {
    items = {
        memoryleak,
        rootkit,
        bootstrap,
        quickload,
        break_card
    }
}
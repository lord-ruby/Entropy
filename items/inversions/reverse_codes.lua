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

local new = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3000+6,
    key = "new",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "consumables",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=0,y=2},
    use = function(self, card, area, copier)
        G.GAME.round_resets.red_room = true
        G.GAME.round_resets.blind_states['Red'] = "Select"
        if G.blind_select then        
            G.blind_select:remove()
            G.blind_prompt_box:remove()
            G.STATE_COMPLETE = false
        end
    end,
    can_use = function(self, card)
        return not G.GAME.round_resets.red_room and G.blind_select
	end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
}

local rr = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Blind",
    order = 999,
	name = "entr-red",
	key = "red",
	pos = { x = 0, y = 0 },
	atlas = "blinds",
	boss_colour = HEX("FF0000"),
    mult=1,
    boss = {min=1,max=9999},
    dollars = 3,
    in_pool = function(self) return false end
}

local interference = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3000+7,
    key = "interference",
    set = "RCode",
    
    can_stack = true,
	can_divide = true,
    atlas = "consumables",
    pos = {x=1,y=2},
    use = function(self, card, area, copier)
        G.GAME.blind.chips = G.GAME.blind.chips * pseudorandom("interference")+0.22
        G.GAME.InterferencePayoutMod = pseudorandom("interference")+0.85
        G.GAME.Interfered = true
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
}

return {
    items = {
        memoryleak,
        rootkit,
        bootstrap,
        quickload,
        break_card,
        new,
        rr,
        interference
    }
}
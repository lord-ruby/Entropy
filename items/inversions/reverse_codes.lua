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

    inversion = "c_cry_reboot",

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

local detour = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3000+4.5,
    key = "detour",
    set = "RCode",
    
    inversion = "c_cry_function",

    atlas = "consumables",
    pos = {x=4,y=1},
    use = function(self, card, area, copier)
        local area = ({
            ["Joker"] = G.jokers
        })[G.GAME.detour_set] or G.consumeables
        print(G.GAME.detour_set)
        local card = create_card(G.GAME.detour_set, area)
        card:add_to_deck()
        area:emplace(card)
    end,
    can_use = function(self, card)
        return G.GAME.detour_set
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                G.GAME.detour_set and localize("k_"..string.lower(G.GAME.detour_set)) or "None"
            }
        }
    end,
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
    
    inversion = "c_cry_semicolon",

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
    
    inversion = "c_cry_malware",

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

local constant = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 8,
    key = "constant",
    set = "RCode",
    
    inversion = "c_cry_variable",

    atlas = "consumables",
    pos = {x=2,y=2},
    use = function(self, card, area, copier)
        for i, v in pairs(G.discard.cards) do
            if v.base.id == G.hand.highlighted[1].base.id then
                copy_card(G.hand.highlighted[1],v)
            end
        end
        for i, v in pairs(G.hand.cards) do
            if v.base.id == G.hand.highlighted[1].base.id then
                copy_card(G.hand.highlighted[1],v)
            end
        end
        for i, v in pairs(G.deck.cards) do
            if v.base.id == G.hand.highlighted[1].base.id then
                copy_card(G.hand.highlighted[1],v)
            end
        end
    end,
    can_use = function(self, card)
        return #Entropy.GetHighlightedCards({G.hand}, card) == 1
	end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
}
local pseudorandom = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "entr_pseudorandom"
        }
    },
    object_type = "Consumable",
    order = 3000+9,
    key = "pseudorandom",
    set = "RCode",
    
    inversion = "c_cry_seed",

    atlas = "consumables",
    pos = {x=3,y=2},
    use = function(self, card, area, copier)
        local allowed = {
            ["hand"]=true,
            ["jokers"]=true,
            ["consumeables"]=true,
            ["shop_jokers"]=true,
            ["shop_booster"]=true,
            ["shop_vouchers"]=true
        }
        for i, v in pairs(allowed) do
            for ind, card in pairs(G[i] and G[i].cards or {}) do
                Entropy.ApplySticker(card, "entr_pseudorandom")
            end
        end
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "entr_pseudorandom", set="Other"}
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

local pseudorandom_sticker = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Sticker",
    order = 3000+1,
    atlas = "entr_stickers",
    pos = { x = 5, y = 0 },
    key = "entr_pseudorandom",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("FF0000"),
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        if not G.shared_stickers["entr_pseudorandom2"] then
            G.shared_stickers["entr_pseudorandom2"] =
                Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["entr_stickers"], { x = 4, y = 0 })
        end -- no matter how late i init this, it's always late, so i'm doing it in the damn draw function

        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers["entr_pseudorandom2"].role.draw_major = card

        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)

        card.hover_tilt = card.hover_tilt / 2 -- call it spaghetti, but it's what hologram does so...
        G.shared_stickers["entr_pseudorandom2"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
        G.shared_stickers["entr_pseudorandom2"]:draw_shader(
            "hologram",
            nil,
            card.ARGS.send_to_shader,
            notilt,
            card.children.center
        ) -- this doesn't really do much tbh, but the slight effect is nice
        card.hover_tilt = card.hover_tilt * 2
    end,
    apply = function(self,card,val)
        card.ability.entr_pseudorandom = true
        if card.area then
        card.ability.cry_rigged = true
        end
    end,
}
SMODS.Sticker:take_ownership("cry_rigged",{
    draw = function(self, card)
        if not card.ability.entr_pseudorandom then
            local notilt = nil
            if card.area and card.area.config.type == "deck" then
                notilt = true
            end
            if not G.shared_stickers["cry_rigged2"] then
                G.shared_stickers["cry_rigged2"] =
                    Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["cry_sticker"], { x = 5, y = 1 })
            end -- no matter how late i init this, it's always late, so i'm doing it in the damn draw function

            G.shared_stickers[self.key].role.draw_major = card
            G.shared_stickers["cry_rigged2"].role.draw_major = card

            G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)

            card.hover_tilt = card.hover_tilt / 2 -- call it spaghetti, but it's what hologram does so...
            G.shared_stickers["cry_rigged2"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
            G.shared_stickers["cry_rigged2"]:draw_shader(
                "hologram",
                nil,
                card.ARGS.send_to_shader,
                notilt,
                card.children.center
            ) -- this doesn't really do much tbh, but the slight
            card.hover_tilt = card.hover_tilt * 2
        end
    end
},true)

local inherit = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3000+10,
    key = "inherit",
    set = "RCode",
    
    inversion = "c_cry_class",

    atlas = "consumables",
    pos = {x=4,y=2},
    use = function(self, card, area, copier)
        G.GAME.USING_CODE = true
		G.ENTERED_ENH = ""
		G.CHOOSE_ENH = UIBox({
			definition = create_UIBox_inherit(card),
			config = {
				align = "cm",
				offset = { x = 0, y = 10 },
				major = G.ROOM_ATTACH,
				bond = "Weak",
				instance_type = "POPUP",
			},
		})
		G.CHOOSE_ENH.alignment.offset.y = 0
		G.ROOM.jiggle = G.ROOM.jiggle + 1
		G.CHOOSE_ENH:align_to_major()
    end,
    can_use = function(self, card)
        return #Entropy.GetHighlightedCards({G.hand}, card, {c_base=true}) == 1
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

local fork = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3000+11,
    key = "fork",
    set = "RCode",
    
    inversion = "c_cry_merge",

    atlas = "consumables",
    config = {
        extra = 1
    },
    pos = {x=0,y=3},
    use = function(self, card, area, copier)
        if area then
			area:remove_from_highlighted(card)
		end
        local cards = Entropy.GetHighlightedCards({G.hand, G.pack_cards}, card)
        local total = #cards
        if total > 0 then
            for i, orig in pairs(cards) do
                local card = copy_card(orig)
                G.E_MANAGER:add_event(Event({
                    trigger="immediate",
                    func = function()
                        local ed = pseudorandom_element(G.P_CENTER_POOLS.Enhanced)
                        while ed.no_doe do
                            ed = pseudorandom_element(G.P_CENTER_POOLS.Enhanced)
                        end
                        card:set_ability(ed)
                        card:set_edition({
                            cry_glitched = true,
                        })
                        card:add_to_deck()
                        table.insert(G.playing_cards, card)
                        orig.area:emplace(card)
                        playing_card_joker_effects({ card })
                        return true
                    end,
                }))
            end
        end
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand, G.pack_cards}, card)
        local num = #cards
        for i, v in pairs(cards) do
            if v.area == G.pack_cards and not v.base.suit then num = num - 1 end
        end
        return num <= card.ability.extra and num > 0
    end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
}

local push = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3000+12,
    key = "push",
    set = "RCode",
    
    inversion = "c_cry_commit",

    atlas = "consumables",
    config = {
        extra = 1
    },
    pos = {x=1,y=3},
    use = function(self, card, area, copier)
        if not Entropy.CanCreateZenith() then
            for i, v in pairs(G.jokers.cards) do
                if not v.ability or (not v.ability.eternal and not v.ability.cry_absolute) then
                    G.jokers.cards[i]:start_dissolve()
                end
            end
            local rarity = Entropy.GetJokerSumRarity()
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                local rare = ({
                    [1] = "Common",
                    [2] = "Uncommon",
                    [3] = "Rare",
                    [4] = "Legendary"
                })[rarity] or rarity
                local card = create_card("Joker", G.jokers, rare == "Legendary", rare, nil, nil, nil, "entr_beyond")
                --create_card("Joker", G.jokers, nil, 2, nil, nil, nil, "entr_beyond")
                card:add_to_deck()
                G.jokers:emplace(card)
                card:juice_up(0.3, 0.5)
                return true
            end}))
        else    
            for i, v in pairs(G.jokers.cards) do v:start_dissolve() end
            local key = pseudorandom_element(Entropy.Zeniths, pseudoseed("zenith"))
            add_joker(key):add_to_deck()
            G.jokers.config.card_limit = 1
        end
    end,
    can_use = function(self, card)
        if G.jokers and #G.jokers.cards > 0 then
            for i, v in pairs(G.jokers.cards) do
                if not v.ability or (not v.ability.eternal and not v.ability.cry_absolute) then
                    return true
                end
            end
        end
	end,
    loc_vars = function(self, q, card)
        local mstart = {
            Entropy.randomchar({"(Current rarity: "})
        }
        if Entropy.CanCreateZenith() then
            for i = 0, 10 do
                mstart[#mstart+1] = Entropy.randomchar(Entropy.stringsplit(Entropy.charset))
            end
        else
            mstart[#mstart+1] = Entropy.randomchar({Entropy.GetJokerSumRarity(true) or "none"})
        end
        mstart[#mstart+1] = Entropy.randomchar({")"})
        return {
            main_end = mstart,
            vars = {
                Entropy.CanCreateZenith() and Entropy.srandom(10) or Entropy.GetJokerSumRarity(true),
                colours = {
                    {0.6969,0.6969,0.6969,1}
                }
            }
        }
    end,
}

local increment = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3000+13,
    key = "increment",
    set = "RCode",
    
    inversion = "c_cry_divide",

    atlas = "consumables",
    config = {
        extra = 1
    },
    pos = {x=2,y=3},
    use = function(self, card, area, copier)
        local mod = math.floor(card and card.ability.extra or self.config.extra)
        G.E_MANAGER:add_event(Event({
			func = function() --card slot
				-- why is this in an event?
				change_shop_size(mod)
				return true
			end,
		}))
        G.GAME.Increment = (G.GAME.Increment or 0) + mod
        G.GAME.IncrementAnte = G.GAME.round_resets.ante
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                math.floor(card and card.ability.extra or self.config.extra)
            }
        }
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

local decrement = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3000+14,
    key = "decrement",
    set = "RCode",

    inversion = "c_cry_multiply",

    atlas = "consumables",
    config = {
        extra = 1
    },
    pos = {x=3,y=3},
    use = function(self, card, area, copier)
        Entropy.FlipThen(G.jokers.highlighted, function(card)
            local ind = ReductionIndex(card, "Joker")-1
            if G.P_CENTER_POOLS.Joker[ind] then
                card:set_ability(G.P_CENTERS[G.P_CENTER_POOLS.Joker[ind].key])
            end
            G.jokers:remove_from_highlighted(card)
        end)
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.jokers}, card)
        return num > 0 and num <= card.ability.extra
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.extra,
            }
        }
    end
}

local invariant = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "entr_pinned"
        }
    },
    object_type = "Consumable",
    order = 3000+15,
    key = "invariant",
    set = "RCode",
    
    inversion = "c_cry_delete",

    atlas = "consumables",
    config = {
        extra = 1
    },
    pos = {x=4,y=3},
    use = function(self, card, area, copier)
        Entropy.ApplySticker(Entropy.GetHighlightedCards({G.shop_jokers, G.shop_booster, G.shop_vouchers}, card)[1], "entr_pinned")
    end,
    can_use = function(self, card)
        return #Entropy.GetHighlightedCards({G.shop_jokers, G.shop_booster, G.shop_vouchers}, card) > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "entr_pinned", set="Other"}
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

local pinned = {
    object_type="Sticker",
    order=3000+2,
    atlas = "entr_stickers",
    pos = { x = 1, y = 0 },
    key = "entr_pinned",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("FF0000"),
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        if not G.shared_stickers["entr_pinned2"] then
            G.shared_stickers["entr_pinned2"] =
                Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["entr_stickers"], { x = 0, y = 0 })
        end -- no matter how late i init this, it's always late, so i'm doing it in the damn draw function

        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers["entr_pinned2"].role.draw_major = card

        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)

        card.hover_tilt = card.hover_tilt / 2 -- call it spaghetti, but it's what hologram does so...
        G.shared_stickers["entr_pinned2"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
        G.shared_stickers["entr_pinned2"]:draw_shader(
            "hologram",
            nil,
            card.ARGS.send_to_shader,
            notilt,
            card.children.center
        ) -- this doesn't really do much tbh, but the slight effect is nice
        card.hover_tilt = card.hover_tilt * 2
    end,
    apply = function(self,card,val) 
        card.ability.entr_pinned_round = G.GAME.round
        card.ability.entr_pinned = true
        if not G.GAME.entr_pinned_cards then G.GAME.entr_pinned_cards = {} end
        if card.area then
            G.GAME.entr_pinned_cards[#G.GAME.entr_pinned_cards+1] = {
                area = Entropy.GetAreaName(card.area),
                card = card.config.center.key,
                pos = Entropy.GetIdxInArea(card)
            }
        end
    end,
    calculate = function(self, card, context)

    end
}

local cookies = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "set_cry_spooky"
        }
    },
    object_type = "Consumable",
    order = 3000+17,
    key = "cookies",
    set = "RCode",
    
    inversion = "c_cry_spaghetti",

    atlas = "consumables",
    config = {
    },
    pos = {x=5,y=3},
    use = function(self, card, area, copier)
        local card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "entr_beyond")
		card:set_edition({
            negative = true,
            key = "e_negative",
            type = "negative",
            card_limit = 1
        })
		card:add_to_deck()
		G.jokers:emplace(card)
    end,
    can_use = function(self, card)
        return true
	end,
}

local segfault = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 3000+18,
    key = "segfault",
    set = "RCode",

    inversion = "c_cry_machinecode",

    atlas = "consumables",
    config = {
        extra = 1
    },
    pos = {x=0,y=4},
    use = function(self, card, area, copier)
        local key = ""
        local ptype = pseudorandom_element({
            "Booster",
            "Voucher",
            "Tarot",
            "Joker",
            "Consumeable",
        }, pseudoseed("segfault"))
        if ptype == "Consumeable" then
            key = Cryptid.random_consumable("entr_segfault", nil, "c_entr_segfault").key
        else
            key = pseudorandom_element(G.P_CENTERS, pseudoseed("segfault"))
            while key.set ~= ptype or Entropy.SegFaultBlacklist[key.key] or Entropy.SegFaultBlacklist[key.rarity] do
                key = pseudorandom_element(G.P_CENTERS, pseudoseed("segfault"))
            end
            key = key.key
        end
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        local _card = create_card("Base", G.deck, nil, nil, nil, nil, nil, "segfault")
        SMODS.change_base(_card,pseudorandom_element({"Spades","Hearts","Clubs","Diamonds"}, pseudoseed("entropy")),pseudorandom_element({"2", "3", "4", "5", "6", "7", "8", "9", "10", "Ace", "King", "Queen", "Jack"}, pseudoseed("segfault")))
        if G.P_CENTERS[key] then _card:set_ability(G.P_CENTERS[key]) else print(key) end
        _card:add_to_deck()
        table.insert(G.playing_cards, _card)
        G.deck:emplace(_card)
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {card.ability.extra}
        }
    end,
}

local sudo = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3000+19,
    key = "sudo",
    set = "RCode",
    
    inverison = "c_cry_exploit",

    atlas = "consumables",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=1,y=4},
    use = function(self, card, area, copier)
        G.GAME.USING_CODE = true
		G.ENTERED_HAND = ""
		G.CHOOSE_HAND = UIBox({
			definition = create_UIBox_sudo(card),
			config = {
				align = "cm",
				offset = { x = 0, y = 10 },
				major = G.ROOM_ATTACH,
				bond = "Weak",
				instance_type = "POPUP",
			},
		})
        G.GAME.USINGSUDO = true
		G.CHOOSE_HAND.alignment.offset.y = 0
		G.ROOM.jiggle = G.ROOM.jiggle + 1
		G.CHOOSE_HAND:align_to_major()
    end,
    can_use = function(self, card)
        local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
        G.FUNCS.get_poker_hand_info(Entropy.GetHighlightedCards({G.hand}, card))
        return text and text ~= "NULL"
	end,
    loc_vars = function(self, q, card)
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

local overflow = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "set_cry_poker_hand_stuff"
        }
    },
    object_type = "Consumable",
    order = 3000+20,
    key = "overflow",
    set = "RCode",

    inversion = "c_cry_oboe",

    atlas = "consumables",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=2,y=4},
    use = function(self, card, area, copier)
        G.GAME.Overflow = G.hand.config.highlighted_limit
        G.hand.config.highlighted_limit = 9999
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

local refactor = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3000+21,
    key = "refactor",
    set = "RCode",
    
    inversion = "c_cry_rework",

    atlas = "consumables",
    config = {
    },
    pos = {x=3,y=4},
    use = function(self, card, area, copier)
        local cards = Entropy.GetHighlightedCards({G.jokers}, card)
        local edition = cards[1].edition
        local card = pseudorandom_element(G.jokers.cards, pseudoseed("refactor"))
        local tries = 0
        while card.unique_val == cards[1].unique_val and tries < 50 do
            card = pseudorandom_element(G.jokers.cards, pseudoseed("refactor"))
            tries = tries + 1
        end
        G.E_MANAGER:add_event(Event({
            trigger="after",
            delay = 0.15,
            func = function() 
                card:flip()
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger="after",
            delay = 1,
            func = function() 
                card:remove_from_deck()
                card:set_edition(edition)
                card:add_to_deck()
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger="after",
            delay = 0.15,
            func = function() 
                card:flip()
                return true
            end,
        }))
    end,
    can_use = function(self, card)
        local num = Entropy.GetHighlightedCards({G.jokers}, card)
        return #num == 1
	end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

local hotfix = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "entr_hotfix"
        }
    },
    object_type = "Consumable",
    order = 3000+22,
    key = "hotfix",
    set = "RCode",
    
    inversion = "c_cry_patch",

    atlas = "consumables",
    pos = {x=1,y=5},
    use = function(self, card, area, copier)
        Entropy.ApplySticker(Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables}, card, card)[1], "entr_hotfix")
    end,
    can_use = function(self, card)
        return #Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables}, card, card) == 1
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "entr_hotfix", set="Other"}
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}
local hotfix_sticker = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Sticker",
    order=3000+3,
    atlas = "entr_stickers",
    pos = { x = 3, y = 0 },
    key = "entr_hotfix",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("FF0000"),
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        if not G.shared_stickers["entr_hotfix2"] then
            G.shared_stickers["entr_hotfix2"] =
                Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["entr_stickers"], { x = 2, y = 0 })
        end -- no matter how late i init this, it's always late, so i'm doing it in the damn draw function

        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers["entr_hotfix2"].role.draw_major = card

        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)

        card.hover_tilt = card.hover_tilt / 2 -- call it spaghetti, but it's what hologram does so...
        G.shared_stickers["entr_hotfix2"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
        G.shared_stickers["entr_hotfix2"]:draw_shader(
            "hologram",
            nil,
            card.ARGS.send_to_shader,
            notilt,
            card.children.center
        ) -- this doesn't really do much tbh, but the slight effect is nice
        card.hover_tilt = card.hover_tilt * 2
    end,
    apply = function(self,card,val) 
        card.ability.entr_hotfix = true
        if card.area then
        if card.debuff then card.debuff = false end
        card.ability.entr_hotfix_rounds = pseudorandom_element({5,6,7,8,9,10,11,12,13,14,15}, pseudoseed("hotfix"))
        end
    end,
    calculate = function(self, card, context)
        if card.debuff then card.debuff = false end
    end
}

local ctrl_x = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 3000+22,
    key = "ctrl_x",
    set = "RCode",
    
    inversion = "c_cry_ctrl_v",

    atlas = "consumables",
    config = {
    },
    pos = {x=2,y=5},
    use = function(self, orig)
        if G.GAME.ControlXCard then
            G.GAME.ControlXCardArea = G[G.GAME.ControlXCardArea]
            if not G.GAME.ControlXCardArea or not G.GAME.ControlXCardArea.cards then
                if G.GAME.ControlXCard.set == "Joker" then
                    G.GAME.ControlXCardArea = G.jokers
                else    
                    G.GAME.ControlXCardArea = G.consumeables
                end
            end
            local card = SMODS.create_card({set = G.GAME.ControlXCard.set, area = G.GAME.ControlXCardArea, key = G.GAME.ControlXCard.key})
            card:add_to_deck()
            G.GAME.ControlXCardArea:emplace(card)
            G.GAME.ControlXCardArea:align_cards()
            if G.GAME.ControlXCardArea == G.shop_jokers or G.GAME.ControlXCardArea == G.shop_booster or G.GAME.ControlXCardArea == G.shop_vouchers then
                create_shop_card_ui(card, G.GAME.ControlXCard.set, G.GAME.ControlXCardArea)
            end
            if G.GAME.ControlXCardArea == G.shop_jokers or G.GAME.ControlXCardArea == G.shop_vouchers then
                G.GAME.ControlXCardArea.config.card_limit = G.GAME.ControlXCardArea.config.card_limit + 1
            end
            G.GAME.ControlXCard = nil
            G.GAME.ControlXCardArea = nil
        else
            local card = Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.shop_booster, G.shop_vouchers, G.shop_jokers, G.pack_cards}, card)[1]
            G.GAME.ControlXCard = {
                set = card.ability.set,
                key = card.config.center.key
            }
            for i, v in pairs(G) do
                if v == card.area then G.GAME.ControlXCardArea = i end
            end
            card:start_dissolve()
            orig.multiuse = true
            G.consumeables:emplace(copy_card(orig))
        end
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.shop_booster, G.shop_vouchers, G.shop_jokers, G.pack_cards}, card)
        return #cards == 1 or G[G.GAME.ControlXCardArea or ""]
    end,
    loc_vars = function()
        return {
            vars = {
                G.GAME.ControlXCard and "Paste" or "Cut",
                1,
                G.GAME.ControlXCard and G.localization.descriptions[G.GAME.ControlXCard.set][G.GAME.ControlXCard.key].name or "None"
            }
        }
    end
}

local multithread = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "temporary"
        }
    },
    object_type = "Consumable",
    order = 3000+24,
    key = "multithread",
    set = "RCode",
    
    inversion = "c_cry_inst",

    atlas = "consumables",
    config = {
    },
    pos = {x=3,y=5},
    use = function(self, card, area, copier)
        for i, v in pairs(G.hand.highlighted) do
            local c = copy_card(v)
            c:set_edition({
                negative=true,
                key="e_negative",
                card_limit=1,
                type="negative"
            })
            c:add_to_deck()
            c.ability.temporary = true
            G.hand:emplace(c)
        end 
    end,
    can_use = function(self, card)
        return #Entropy.GetHighlightedCards({G.hand}, nil, card) > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "temporary", set="Other"}
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

local temporary = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Sticker",
    order = 3000+4,
    atlas = "entr_stickers",
    pos = { x = 3, y = 1 },
    key = "temporary",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("FF0000"),
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        if not G.shared_stickers["entr_temporary2"] then
            G.shared_stickers["entr_temporary2"] =
                Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["entr_stickers"], { x = 2, y = 1 })
        end -- no matter how late i init this, it's always late, so i'm doing it in the damn draw function

        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers["entr_temporary2"].role.draw_major = card

        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)

        card.hover_tilt = card.hover_tilt / 2 -- call it spaghetti, but it's what hologram does so...
        G.shared_stickers["entr_temporary2"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
        G.shared_stickers["entr_temporary2"]:draw_shader(
            "hologram",
            nil,
            card.ARGS.send_to_shader,
            notilt,
            card.children.center
        ) -- this doesn't really do much tbh, but the slight effect is nice
        card.hover_tilt = card.hover_tilt * 2
    end,
    apply = function(self,card,val)
        card.ability.temporary = true
    end,
}

local autostart = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 3000+25,
    key = "autostart",
    set = "RCode",
    
    inversion = "c_cry_alttab",

    atlas = "consumables",
    pos = {x=4,y=5},
    config = {
        tags = 3
    },
    use = function(self, card, area, copier)
        for i = 1, card.ability.tags do
            add_tag(Tag(pseudorandom_element(G.GAME.autostart_tags, pseudoseed("autostart"))))
        end
    end,
    can_use = function(self, card)
        return G.GAME.autostart_tags
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.tags
            }
        }
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

local local_card = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "temporary"
        }
    },
    object_type = "Consumable",
    order = 3000+27,
    key = "local",
    set = "RCode",
    
    inversion = "c_cry_global",

    atlas = "consumables",
    pos = {x=0,y=6},
    config = {
        select = 3
    },
    use = function(self, card, area, copier)
        Entropy.FlipThen(G.hand.highlighted, function(card) card.ability.temporary = true end)
    end,
    can_use = function(self, card)
        return G.hand and #Entropy.GetHighlightedCards({G.hand}, nil, card) > 0 and #Entropy.GetHighlightedCards({G.hand}, nil, card) <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        q[#q+1]={set="Other",key="temporary"}
        return {
            vars = {
                card.ability.select
            }
        }
    end,
}

local transpile = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 3000+30,
    key = "transpile",
    set = "RCode",
    
    inversion = "c_cry_assemble",

    atlas = "consumables",
    pos = {x=4,y=6},
    config = {
        jokerslots = -1,
        handsize = 2,
        consumableslots = 2
    },
    use = function(self, card, area, copier)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.jokerslots
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.consumableslots
        G.hand.config.card_limit = G.hand.config.card_limit + card.ability.handsize
    end,
    can_use = function(self, card)
        return G.jokers and G.jokers.config.card_limit > 0
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.jokerslots,
                card.ability.consumableslots,
                card.ability.handsize,
            }
        }
    end,
    entr_credits = {
        art = {"Grakhon"},
        idea = {"Grakhon"}
    }
}

local mbr = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 3000+31,
    key = "mbr",
    set = "RCode",
    
    inversion = "c_cry_keygen",

    atlas = "consumables",
    pos = {x=5,y=6},
    use = function(self, card, area, copier)
        local card = SMODS.create_card({
            key = "p_entr_voucher_pack",
            set = "Booster",
            area = G.shop_booster
        })
        card:add_to_deck()
        card.ability.banana = true
        G.shop_booster:emplace(card)
        create_shop_card_ui(card, "Booster", G.shop_booster)
    end,
    can_use = function(self, card)
        return G.STATE == G.STATES.SHOP
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {set = "Other", key = "banana", vars = {"1", "10"}}
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
        interference,
        constant,
        pseudorandom,
        pseudorandom_sticker,
        inherit,
        fork,
        push,
        increment,
        decrement,
        invariant,
        pinned,
        cookies,
        segfault,
        sudo,
        overflow,
        refactor,
        hotfix,
        hotfix_sticker,
        multithread,
        temporary,
        autostart,
        ctrl_x,
        local_card,
        transpile,
        detour,
        mbr
    }
}
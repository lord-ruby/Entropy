local memoryleak = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 4000 + 1,
    key = "memory_leak",
    set = "Command",
    no_collection = true,
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
                if not v.ability.cry_absolute then
                    v:start_dissolve()
                end
            end
            for i, v in pairs(G.consumeables.cards) do
                if not v.ability.cry_absolute then
                    v:start_dissolve()
                end
            end
        end
    end,
    can_use = function() return true end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local rootkit = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 4000 + 2,
    key = "root_kit",
    set = "Command",

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
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local bootstrap = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 4000 + 3,
    key = "bootstrap",
    set = "Command",

    inversion = "c_cry_reboot",

    atlas = "consumables",
	pos = {x=2,y=1},
    use = function(self, card, area, copier)
        G.GAME.UsingBootstrap = true
    end,
    can_use = function() return true end,
	entr_credits = {
		idea = {
			"cassknows",
		},
	},
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local quickload = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 4000+4,
    key = "quickload",
    set = "Command",
    
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
    order = 4000+4.5,
    key = "detour",
    set = "Command",
    
    inversion = "c_cry_cryfunction",

    atlas = "consumables",
    pos = {x=4,y=1},
    use = function(self, card, area, copier)
        local area = ({
            ["Joker"] = G.jokers
        })[G.GAME.detour_set] or G.consumeables
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
    demicoloncompat = true,
    force_use = function(self, card)
        if G.GAME.detour_set then
            self:use(card)
        end
    end
}


local break_card = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 4000+5,
    key = "break",
    set = "Command",
    
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
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local new = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 4000+6,
    key = "new",
    set = "Command",
    
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

local interference = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 4000+7,
    key = "interference",
    set = "Command",
    
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
    order = 4000+8,
    key = "constant",
    set = "Command",
    
    inversion = "c_cry_variable",

    atlas = "consumables",
    pos = {x=2,y=2},
    use = function(self, card, area, copier)
        local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, 1)
        for i, v in pairs(G.discard.cards) do
            if v.base.id == cards[1].base.id then
                copy_card(G.hand.highlighted[1],v)
            end
        end
        for i, v in pairs(G.hand.cards) do
            if v.base.id == cards[1].base.id then
                copy_card(G.hand.highlighted[1],v)
            end
        end
        for i, v in pairs(G.deck.cards) do
            if v.base.id == cards[1].base.id then
                copy_card(G.hand.highlighted[1],v)
            end
        end
        for i, v in pairs(G.jokers.cards) do
            if v.base.id == cards[1].base.id then
                copy_card(G.hand.highlighted[1],v)
            end
        end
    end,
    can_use = function(self, card)
        return #Entropy.GetHighlightedCards({G.hand}, card, 1, 1) == 1
	end,
    loc_vars = function(self, q, card)
        return {
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}
local pseudorandom = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "entr_pseudorandom"
        }
    },
    object_type = "Consumable",
    order = 4000+9,
    key = "pseudorandom",
    set = "Command",
    
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
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local pseudorandom_sticker = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Sticker",
    order = 4500+1,
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
    order = 4000+10,
    key = "inherit",
    set = "Command",
    
    inversion = "c_cry_class",

    atlas = "consumables",
    pos = {x=4,y=2},
    use = function(self, card, area, copier)
		if not card.ability.cry_multiuse or to_big(card.ability.cry_multiuse) <= to_big(1)
		 then
			G.GAME.CODE_DESTROY_CARD = copy_card(card)
			G.consumeables:emplace(G.GAME.CODE_DESTROY_CARD)
		 else
			card.ability.cry_multiuse = card.ability.cry_multiuse + 1
		 end
		G.GAME.USING_CODE = true
		G.GAME.USING_INHERIT = true
		G.FUNCS.overlay_menu({definition = create_UIBox_class()})
    end,
    init = function(self)
		local ccl = Card.click
		function Card:click()
			if G.GAME.USING_INHERIT then
				if not self.debuff then
					G.FUNCS.exit_overlay_menu_code()
					delay(3)
                    local card = Cryptid.get_highlighted_cards({ G.hand }, {}, 1, G.GAME.USING_CLASS or 1)[1]
                    if card then
                        local base_enh = card and card.config.center.key or ""
                        Entropy.ChangeEnhancements({G.discard, G.deck, G.hand}, self.config.center.key, base_enh, true)
                        G.hand:unhighlight_all()
                    end
					ccl(self)
					if G.GAME.CODE_DESTROY_CARD then	
						G.GAME.CODE_DESTROY_CARD:start_dissolve()
						G.GAME.CODE_DESTROY_CARD = nil
					end
				end
			else
				ccl(self)
			end
		end
		local emplace_ref = CardArea.emplace
		function CardArea:emplace(card, ...)
			if G.GAME.USING_INHERIT then
				local c = card.config.center
				if c.hidden or c.noe_doe or c.no_collection or c.no_class or c.no_code then
					card.debuff = true
				end
			end
			return emplace_ref(self, card, ...)
		end
	end,
    can_use = function(self, card)
        return #Entropy.GetHighlightedCards({G.hand}, card, 1, 1,{c_base=true}) == 1
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
    order = 4000+11,
    key = "fork",
    set = "Command",
    
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
        local cards = Entropy.GetHighlightedCards({G.hand, G.pack_cards}, card, 1, card.ability.extra)
        local total = #cards
        if total > 0 then
            for i, orig in pairs(cards) do
                local card = copy_card(orig)
                G.E_MANAGER:add_event(Event({
                    trigger="immediate",
                    func = function()
                        local ed = pseudorandom_element(G.P_CENTER_POOLS.Enhanced)
                        while ed.no_doe or G.GAME.banned_keys[ed.key] do
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
        local cards = Entropy.GetHighlightedCards({G.hand, G.pack_cards}, card, 1, card.ability.extra)
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
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local push = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 4000+12,
    key = "push",
    set = "Command",
    
    inversion = "c_cry_commit",

    atlas = "consumables",
    config = {
        extra = 1
    },
    pos = {x=1,y=3},
    use = function(self, card, area, copier)
        for i, v in pairs(G.jokers.cards) do
            if not v.ability or (not SMODS.is_eternal(v) and not v.ability.cry_absolute) then
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
    end,
    can_use = function(self, card)
        if G.jokers and #G.jokers.cards > 0 then
            for i, v in pairs(G.jokers.cards) do
                if not v.ability or (not SMODS.is_eternal(v) and not v.ability.cry_absolute) then
                    return true
                end
            end
        end
	end,
    loc_vars = function(self, q, card)
        local mstart = {
            Entropy.randomchar({"(Current rarity: "})
        }
        mstart[#mstart+1] = Entropy.randomchar({Entropy.GetJokerSumRarity(true) or "none"})
        mstart[#mstart+1] = Entropy.randomchar({")"})
        return {
            main_end = mstart,
            vars = {
                Entropy.GetJokerSumRarity(true),
                colours = {
                    {0.6969,0.6969,0.6969,1}
                }
            }
        }
    end,
	entr_credits = {
		idea = {
			"cassknows",
		},
	},
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local increment = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 4000+13,
    key = "increment",
    set = "Command",
    
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
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local decrement = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 4000+14,
    key = "decrement",
    set = "Command",

    inversion = "c_cry_multiply",

    atlas = "consumables",
    config = {
        extra = 1
    },
    pos = {x=3,y=3},
    use = function(self, card, area, copier)
        Entropy.FlipThen(Entropy.GetHighlightedCards({G.jokers}, card, 1, card.ability.extra), function(card)
            local ind = ReductionIndex(card, card.config.center.set)-1
            while G.P_CENTER_POOLS[card.config.center.set][ind] and G.P_CENTER_POOLS[card.config.center.set][ind].no_doe or G.P_CENTER_POOLS[card.config.center.set].no_collection do
                ind = ind - 1
            end
            if ind < 1 then ind = 1 end
            if G.P_CENTER_POOLS.Joker[ind] then
                card:set_ability(G.P_CENTERS[G.P_CENTER_POOLS.Joker[ind].key])
            end
            G.jokers:remove_from_highlighted(card)
        end)
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.jokers}, card, 1, card.ability.extra)
        return num > 0 and num <= card.ability.extra
	end,
    loc_vars = function(self, q, card)
        local name = "None"
        local cards = Entropy.GetHighlightedCards({G.jokers, G.shop_jokers, G.shop_booster, G.shop_vouchers}, card, 1, card.ability.extra)
        if cards and #cards > 0 then
            if cards[1].config.center.set == "Joker" or G.GAME.modifiers.cry_beta and cards[1].consumable then
                local first = cards[1]
                local ind = ReductionIndex(cards[1], cards[1].config.center.set )-1
                while G.P_CENTER_POOLS[cards[1].config.center.set ][ind].no_doe or G.P_CENTER_POOLS[cards[1].config.center.set ].no_collection do
                    ind = ind - 1
                end
                if ind < 1 then ind = 1 end
                name = G.localization.descriptions[cards[1].config.center.set ][G.P_CENTER_POOLS[cards[1].config.center.set ][ind].key].name
            end
        end
        return {
            vars = {
                card.ability.extra,
                name
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
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
    order = 4000+15,
    key = "invariant",
    set = "Command",
    
    inversion = "c_cry_delete",

    atlas = "consumables",
    config = {
        extra = 1
    },
    pos = {x=4,y=3},
    use = function(self, card, area, copier)
        Entropy.ApplySticker(Entropy.GetHighlightedCards({G.shop_jokers, G.shop_booster, G.shop_vouchers}, card, 1, card.ability.extra)[1], "entr_pinned")
        local card = Entropy.GetHighlightedCards({G.shop_jokers, G.shop_booster, G.shop_vouchers}, card, 1, card.ability.extra)[1]
        card:juice_up()

    end,
    can_use = function(self, card)
        return #Entropy.GetHighlightedCards({G.shop_jokers, G.shop_booster, G.shop_vouchers}, card, 1, card.ability.extra) > 0
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
    order=4500+2,
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
    order = 4000+17,
    key = "cookies",
    set = "Command",
    
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
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local segfault = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 4000+18,
    key = "segfault",
    set = "Command",

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
        Entropy.randomize_rank_suit(card, true, true, "segfault")
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
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local sudo = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 4000+19,
    key = "sudo",
    set = "Command",
    
    inversion = "c_cry_exploit",

    atlas = "consumables",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=1,y=4},
    use = function(self, card, area, copier)
        if not card.ability.cry_multiuse or to_big(card.ability.cry_multiuse) <= to_big(1) then
			G.GAME.CODE_DESTROY_CARD = copy_card(card)
			G.consumeables:emplace(G.GAME.CODE_DESTROY_CARD)
		else
			G.GAME.CODE_DESTROY_CARD = card
			card.ability.cry_multiuse = card.ability.cry_multiuse + 1
		end
		G.GAME.USING_CODE = true
		G.GAME.USING_SUDO = true
		G.FUNCS.overlay_menu({definition = G.UIDEF.exploit_menu()})
    end,
    can_use = function(self, card)
        local num = G.PROFILES[G.SETTINGS.profile].cry_none and -1 or 0
        return #Entropy.GetHighlightedCards({G.hand}, card, 1, num) > num 
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
    order = 4000+20,
    key = "overflow",
    set = "Command",

    inversion = "c_cry_oboe",

    atlas = "consumables",
    config = {
        extra = {
            selected = 10
        }
    },
    pos = {x=2,y=4},
    use = function(self, card, area, copier)
        G.GAME.Overflow = 9999
        Entropy.ChangeFullCSL(9999, localize("b_infinity"))
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
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local refactor = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 4000+21,
    key = "refactor",
    set = "Command",
    
    inversion = "c_cry_rework",

    atlas = "consumables",
    config = {
    },
    pos = {x=3,y=4},
    use = function(self, card, area, copier)
        local cards = Entropy.GetHighlightedCards({G.jokers}, card, 1, 1)
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
        local num = Entropy.GetHighlightedCards({G.jokers}, card, 1, 1)
        return #num == 1
	end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local hotfix = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "entr_hotfix"
        }
    },
    object_type = "Consumable",
    order = 4000+22,
    key = "hotfix",
    set = "Command",
    
    inversion = "c_cry_patch",

    atlas = "consumables",
    pos = {x=1,y=5},
    use = function(self, card, area, copier)
        Entropy.ApplySticker(Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables}, card, 1, 1)[1], "entr_hotfix")
        local card = Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables}, card, 1, 1)[1]
        card:juice_up()

    end,
    can_use = function(self, card)
        return #Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables}, card, 1, 1) == 1
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "entr_hotfix", set="Other"}
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}
local hotfix_sticker = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Sticker",
    order=4500+3,
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
        card.ability.entr_hotfix_rounds = 15
        if card.debuff then card.debuff = false end
    end,
    calculate = function(self, card, context)
        if card.debuff then card.debuff = false end
    end
}

local desync_card = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "desync"
        }
    },
    object_type = "Consumable",
    order = 4000+22,
    key = "desync",
    set = "Command",
    
    inversion = "c_cry_hook",

    atlas = "consumables",
    pos = {x=0,y=5},
    use = function(self, card, area, copier)
        Entropy.ApplySticker(Entropy.GetHighlightedCards({G.jokers, G.consumeables}, card, 1, 1)[1], "desync")
        local card = Entropy.GetHighlightedCards({G.jokers, G.consumeables}, card, 1, 1)[1]
        card:juice_up()

    end,
    can_use = function(self, card)
        return #Entropy.GetHighlightedCards({G.jokers, G.consumeables}, card, 1, 1) == 1
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "desync", set="Other", vars = {"context.none"}}
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local ctrl_x = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 4000+22,
    key = "ctrl_x",
    set = "Command",
    
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
            if G.GAME.ControlXCard.seal then card:set_seal(G.GAME.ControlXCard.seal) end
            if G.GAME.ControlXCard.edition then card:set_edition(G.GAME.ControlXCard.edition) end
            SMODS.change_base(card, G.GAME.ControlXCard.base.suit, tostring(G.GAME.ControlXCard.base.value))
            G.GAME.ControlXCardArea:emplace(card)
            G.GAME.ControlXCardArea:align_cards()
            if G.GAME.ControlXCardArea == G.shop_jokers or G.GAME.ControlXCardArea == G.shop_booster or G.GAME.ControlXCardArea == G.shop_vouchers then
                create_shop_card_ui(card, G.GAME.ControlXCard.set, G.GAME.ControlXCardArea)
            end
            if G.GAME.ControlXCardArea == G.shop_jokers or G.GAME.ControlXCardArea == G.shop_vouchers then
                G.GAME.ControlXCardArea:handle_card_limit(1)
            end
            G.GAME.ControlXCard = nil
            G.GAME.ControlXCardArea = nil
        else
            local card = Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.shop_booster, G.shop_vouchers, G.shop_jokers, G.pack_cards}, card, 1, 1)[1]
            G.GAME.ControlXCard = {
                set = card.ability.set,
                key = card.config.center.key,
                name =  G.GAME.ControlXCard and G.localization.descriptions[G.GAME.ControlXCard.set] and G.GAME.ControlXCard and G.localization.descriptions[G.GAME.ControlXCard.set][G.GAME.ControlXCard.key].name
                or card.base.name,
                base = card.base,
                edition = card.edition and card.edition.key,
                seal = card.seal
            }
            for i, v in pairs(G) do
                if v == card.area then G.GAME.ControlXCardArea = i end
            end
            card:start_dissolve()
            orig.multiuse = true
            orig.ability.fromflipside = true
            G.consumeables:emplace(copy_card(orig))
        end
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.shop_booster, G.shop_vouchers, G.shop_jokers, G.pack_cards}, card, 1, 1)
        return #cards == 1 or G[G.GAME.ControlXCardArea or ""]
    end,
    loc_vars = function()
        return {
            vars = {
                G.GAME.ControlXCard and "Paste" or "Cut",
                1,
                G.GAME.ControlXCard and G.GAME.ControlXCard.name or "None"
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
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
    order = 4000+24,
    key = "multithread",
    set = "Command",
    
    inversion = "c_cry_inst",

    atlas = "consumables",
    config = {
    },
    pos = {x=3,y=5},
    use = function(self, card, area, copier)
        for i, v in pairs(Entropy.GetHighlightedCards({G.hand}, card, 1, G.hand.config.card_limit)) do
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
        return #Entropy.GetHighlightedCards({G.hand}, card, 1, G.hand.config.card_limit) > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "temporary", set="Other"}
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local temporary = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Sticker",
    order = 4500+4,
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
    order = 4000+25,
    key = "autostart",
    set = "Command",
    
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
    demicoloncompat = true,
    force_use = function(self, card)
        if G.GAME.autostart_tags then
            self:use(card)
        end
    end
}

local echo = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Consumable",
    order = 4000+26,
    key = "echo",
    set = "Command",
    
    inversion = "c_cry_log",

    atlas = "consumables",
    pos = {x=5,y=5},
    use = function(self, card, area, copier)
        local cards = Cryptid.get_highlighted_cards({G.consumeables, G.shop_jokers, G.shop_vouchers, G.shop_booster, G.pack_cards}, card, 2,2, function(card)
            return card.ability.consumeable
        end)
        if not G.GAME.entr_echo then
            G.GAME.entr_echo = {}
        end
        if #cards >= 2 then
            G.GAME.entr_echo[cards[1].config.center.key] = G.GAME.entr_echo[cards[1].config.center.key] or {}
            G.GAME.entr_echo[cards[1].config.center.key][#G.GAME.entr_echo[cards[1].config.center.key]+1] = cards[2].config.center.key

            G.GAME.entr_echo[cards[2].config.center.key] = G.GAME.entr_echo[cards[2].config.center.key] or {}
            G.GAME.entr_echo[cards[2].config.center.key][#G.GAME.entr_echo[cards[2].config.center.key]+1] = cards[1].config.center.key
        end
    end,
    can_use = function(self, card)
        local cards = Cryptid.get_highlighted_cards({G.consumeables, G.shop_jokers, G.shop_vouchers, G.shop_booster, G.pack_cards}, card, 2,2, function(card)
            return card.ability.consumeable
        end)
        return #cards == 2 and cards[1].config.center.key ~= cards[2].config.center.key
	end,
    demicoloncompat = true,
    force_use = function(self, card)
        if G.GAME.autostart_tags then
            self:use(card)
        end
    end
}

local local_card = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "temporary"
        }
    },
    object_type = "Consumable",
    order = 4000+27,
    key = "local",
    set = "Command",
    
    inversion = "c_cry_global",

    atlas = "consumables",
    pos = {x=0,y=6},
    config = {
        select = 3
    },
    use = function(self, card, area, copier)
        for i, card in pairs(Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)) do
            card.ability.temporary = true
            card:juice_up()

        end
    end,
    can_use = function(self, card)
        return G.hand and #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select) > 0 and #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select) <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        q[#q+1]={set="Other",key="temporary"}
        return {
            vars = {
                card.ability.select
            }
        }
    end,
    entr_credits = {
        art = {"Grahkon"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local interpolate = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 4000+28,
    key = "interpolate",
    set = "Command",
    
    inversion = "c_cry_quantify",

    atlas = "consumables",
    pos = {x=1,y=6},
    config = {
        select = 1
    },
    use = function(self, card, area, copier)
        G.GAME.interpolate_cards = G.GAME.interpolate_cards or {}
        for i, card in pairs(Entropy.GetHighlightedCards({G.jokers, G.consumeables}, card, 1, card.ability.select)) do
            G.GAME.interpolate_cards[#G.GAME.interpolate_cards+1] = card.config.center.key
            card:start_dissolve()
        end
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.jokers, G.consumeables}, card, 1, card.ability.select)
        return #cards > 0 and #cards <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        q[#q+1]=G.P_CENTERS.p_entr_twisted_pack_normal
        q[#q+1]=G.P_CENTERS.p_cry_code_normal_1
        return {
            vars = {
                card.ability.select
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local overload = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 4000+28,
    key = "overload",
    set = "Command",
    
    inversion = "c_cry_declare",

    atlas = "consumables",
    pos = {x=2,y=6},
    config = {
        cry_multiuse = 3
    },
    use = function(self, card, area, copier)
        G.GAME.overload = true
    end,
    can_use = function()
        return not G.GAME.overload
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local badarg = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 4000+29,
    key = "badarg",
    set = "Command",
    
    inversion = "c_cry_nperror",

    atlas = "consumables",
    pos = {x=3,y=6},
    config = {
    },
    use = function(self, card, area, copier)
        local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
        G.FUNCS.get_poker_hand_info(Entropy.GetHighlightedCards({G.hand}, card))
        if text and G.GAME.hands[text] then
            if not G.GAME.badarg then G.GAME.badarg = {} end
            G.GAME.badarg[text] = true
        end
        update_hand_text({delay=0}, {handname = "", chips="bad", mult="arg"})
        G.boss_throw_hand = true
        G.bad_arg = true

    end,
    can_use = function(self, card)
        local num = G.PROFILES[G.SETTINGS.profile].cry_none and -1 or 0
        return #Entropy.GetHighlightedCards({G.hand}, card) > num
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
        art = {"cassknows"},
        idea = {"cassknows"}
    }
}

local transpile = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 4000+30,
    key = "transpile",
    set = "Command",
    
    inversion = "c_cry_assemble",

    atlas = "consumables",
    pos = {x=4,y=6},
    config = {
        jokerslots = -1,
        handsize = 2,
        consumableslots = 2
    },
    use = function(self, card, area, copier)
        G.jokers:handle_card_limit(card.ability.jokerslots)
        G.consumeables:handle_card_limit(card.ability.consumableslots)
        G.hand:handle_card_limit(card.ability.handsize)
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
        art = {"Grahkon"},
        idea = {"Grahkon"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local mbr = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 4000+31,
    key = "mbr",
    set = "Command",
    
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
        q[#q+1] = G.P_CENTERS.p_entr_voucher_pack
    end,
}

local desync = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Sticker",
    order = 4500+32,
    atlas = "entr_stickers",
    pos = { x = 7, y = 0 },
    key = "desync",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("FF0000"),
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        if not G.shared_stickers["entr_desync"] then
            G.shared_stickers["entr_desync"] =
                Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["entr_stickers"], { x = 6, y = 0 })
        end -- no matter how late i init this, it's always late, so i'm doing it in the damn draw function

        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers["entr_desync"].role.draw_major = card

        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)

        card.hover_tilt = card.hover_tilt / 2 -- call it spaghetti, but it's what hologram does so...
        G.shared_stickers["entr_desync"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
        G.shared_stickers["entr_desync"]:draw_shader(
            "hologram",
            nil,
            card.ARGS.send_to_shader,
            notilt,
            card.children.center
        ) -- this doesn't really do much tbh, but the slight effect is nice
        card.hover_tilt = card.hover_tilt * 2
    end,
    calculate = function(self, card, context)
        if context.after then
            if card.ability.context == "after" then
                if Entropy.ContextChecks(self, card, context, card.ability.context) then
                    card.ability.context = Entropy.RandomContext()
                    if Cryptid.demicolonGetTriggerable(card) then
                        local results = Cryptid.forcetrigger(card, context)
                        if results and results.jokers then
                            results.jokers.message = localize("cry_demicolon")
                            results.jokers.colour = G.C.RARITY.cry_epic
                            results.jokers.sound = "cry_demitrigger"
                            return results.jokers
                        end
                        return {
                            message = localize("cry_demicolon"),
                            colour = G.C.RARITY.cry_epic,
                            sound = "cry_demitrigger",
                        }
                    end
                end
            else
                card.ability.context = Entropy.RandomContext()
            end
        end
        if Entropy.ContextChecks(self, card, context, card.ability.context) then
            if Cryptid.demicolonGetTriggerable(card) then
                local results = Cryptid.forcetrigger(card, context)
                if results and results.jokers then
                    results.jokers.message = localize("cry_demicolon")
                    results.jokers.colour = G.C.RARITY.cry_epic
                    results.jokers.sound = "cry_demitrigger"
                    return results.jokers
                end
                return {
                    message = localize("cry_demicolon"),
                    colour = G.C.RARITY.cry_epic,
                    sound = "cry_demitrigger",
                }
            end
        end
    end,
    apply = function(self,card,val)
        card.ability.context = Entropy.RandomContext()
        card.ability.desync = true
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {"context."..(card.ability.context or "none")}
        }
    end
}


return {
    items = {
        memoryleak,
        rootkit,
        bootstrap,
        quickload,
        break_card,
        new,
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
        mbr,
        desync,
        desync_card,
        badarg,
        interpolate,
        overload,
        echo
    }
}

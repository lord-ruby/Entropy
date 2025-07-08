local downpour = Entropy.SealSpectral("downpour", {x=12,y=7}, "entr_cerulean",2000+24, "c_cry_typhoon", {art = {"Lil. Mr. Slipstream"}})

local rift = {
    key = "rift",
    set = "Omen",
    atlas = "consumables",
    object_type = "Consumable",
    order = 2000+24.5,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        num = 2
    },
    pos = {x=11,y=8},
    inversion = "c_cry_meld",
    use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.jokers, G.consumeables, G.hand}, card2, 1, card2.ability.num)
        Entropy.FlipThen(cards, function(card)
            card:juice_up()
            card:set_edition(Entropy.pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("rift"),function(e)
                return G.GAME.banned_keys[e.key] or e.no_doe
            end).key)
        end)
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.jokers, G.consumeables, G.hand}, card, 1, card.ability.num)
        return #cards > 0 and #cards <= card.ability.num
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.num
            }
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local script = Entropy.SealSpectral("script", {x=6,y=8}, "entr_verdant",2000+25, "c_cry_source", {art = {"Lil. Mr. Slipstream"}})

local dispel = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 17,
    key = "dispel",
    set = "Omen",
    
    inversion = "c_cry_lock",

    atlas = "consumables",
    config = {
        select = 1,
    },
	pos = {x=11,y=6},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        for i, v in pairs(Entropy.GetHighlightedCards({G.jokers}, card, 1, card.ability.select)) do
            if not v.entr_aleph then
                v:start_dissolve()
                G.GAME.banned_keys[v.config.center.key] = true
            end
        end
    end,
    can_use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.jokers}, card, 1, card.ability.select)
        return #cards > 0 and #cards <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select,
            }
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local cleanse = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 18,
    key = "cleanse",
    set = "Omen",
    
    inversion = "c_cry_vacuum",

    atlas = "consumables",
    config = {
        dollarpc = 1
    },
	pos = {x=7,y=7},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local total = 0
        for i, card in pairs(G.hand.cards) do
            if card.ability and card.ability.effect == 'Stone Card' then
                total = total + (10 + card.ability.perma_bonus) * card2.ability.dollarpc 
                card:set_ability(G.P_CENTERS.c_base, true, nil)
            else
                total = total + (card.base.nominal-1 + card.ability.perma_bonus) * card2.ability.dollarpc 
            end
            card.ability.perma_bonus = 0
        end
        Entropy.FlipThen(G.hand.cards, function(card, area)
            total = total + (card.base.nominal-1) * card2.ability.dollarpc
            SMODS.change_base(card, "entr_nilsuit", "entr_nilrank")
        end)
        delay(1)
        ease_dollars(total)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.dollarpc
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local fusion = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 19,
    key = "fusion",
    set = "Omen",
    
    inversion = "c_cry_hammerspace",

    atlas = "consumables",
    config = {
        num = 3,
    },
	pos = {x=10,y=7},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local cards = {}
        for i, v in ipairs(G.hand.cards) do cards[#cards+1]=v end
        pseudoshuffle(cards, pseudoseed("fusion"))
        local actual = {}
        for i = 1, card2.ability.num do
            actual[#actual+1] = cards[i]
        end
        Entropy.FlipThen(actual, function(card,area)
            local sel = Entropy.GetHighlightedCards({G.jokers, G.consumeables, G.hand}, card2, 1, 1, {c_base=true})[1]
            if sel then
                local enhancement_type = sel.ability and sel.ability.set or sel.config.center.set
                if sel.area == G.hand then
                    SMODS.change_base(card,pseudorandom_element({"Spades","Hearts","Clubs","Diamonds"}, pseudoseed("fusion")),pseudorandom_element({"2", "3", "4", "5", "6", "7", "8", "9", "10", "Ace", "King", "Queen", "Jack"}, pseudoseed("fusion")))
                    card:set_ability(G.P_CENTERS.c_base)
                else
                    local enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("fusion")).key
                    while G.P_CENTERS[enhancement].no_doe or (G.P_CENTERS[enhancement].soul_rate and pseudorandom("fusion") > 0.02) or G.GAME.banned_keys[enhancement] do
                        enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("fusion")).key
                    end
                    card:set_ability(G.P_CENTERS[enhancement])
                end
            end
            G.hand:remove_from_highlighted(card)
        end)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0 and #Entropy.GetHighlightedCards({G.jokers, G.consumeables, G.hand}, card, 1, 1, {c_base=true}) == 1
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.num,
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local substitute = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 20,
    key = "substitute",
    set = "Omen",
    
    inversion = "c_cry_trade",

    atlas = "consumables",
    config = {
        num = 3,
    },
	pos = {x=6,y=7},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local usable_vouchers = {}
        local voucher = pseudorandom_element(G.vouchers.cards, pseudoseed("substitute"))
        local tries = 100
        local uvouchers = {}
        while (voucher.ability.eternal or voucher.ability.cry_absolute or Entropy.GetHigherVoucherTier(voucher.config.center.key) == nil) and tries > 0 do
            voucher = pseudorandom_element(G.vouchers.cards, pseudoseed("substitute"))
            tries = tries - 1
        end
        uvouchers[#uvouchers+1] = voucher
        for i, v in pairs(voucher.config.center.requires or {}) do
            if Entropy.InTable(G.vouchers.cards, v) then
                local voucher2 = G.vouchers.cards[Entropy.InTable(G.vouchers.cards, v)]
                for i2, v2 in pairs(voucher2.config.center.requires or {}) do
                    if Entropy.InTable(G.vouchers.cards, v2) then
                        local voucher3 = G.vouchers.cards[Entropy.InTable(G.vouchers.cards, v2)]
                        uvouchers[#uvouchers+1] = voucher3
                    end
                end
                uvouchers[#uvouchers+1] = voucher2
            end
        end
        --Entropy.GetHigherVoucherTier(voucher.config.center.key) 

        local area
		if G.STATE == G.STATES.HAND_PLAYED then
			if not G.redeemed_vouchers_during_hand then
				G.redeemed_vouchers_during_hand =
					CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
			end
			area = G.redeemed_vouchers_during_hand
		else
			area = G.play
		end

        for i, v in pairs(uvouchers) do
            local card2 = copy_card(v)
            card2.ability.extra = copy_table(v.ability.extra)
            if card2.facing == "back" then
                card2:flip()
            end
            card2:start_materialize()
            area:emplace(card2)
            card2.cost = 0
            card2.shop_voucher = false
            local current_round_voucher = G.GAME.current_round.voucher
            card2:unredeem()
            G.GAME.current_round.voucher = current_round_voucher
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0,
                func = function()
                    card2:start_dissolve()
                    v:start_dissolve()
                    return true
                end,
            }))
        end
        local area
        if G.STATE == G.STATES.HAND_PLAYED then
            if not G.redeemed_vouchers_during_hand then
                G.redeemed_vouchers_during_hand =
                    CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
            end
            area = G.redeemed_vouchers_during_hand
        else
            area = G.play
        end

        local card = create_card("Voucher", G.vouchers, nil, nil, nil, nil, nil, "entr_subby")
        card:set_ability(G.P_CENTERS[Entropy.GetHigherVoucherTier(voucher.config.center.key) or voucher.config.center.key] or G.P_CENTERS[voucher.config.center.key])
        card:add_to_deck()
        area:emplace(card)
        card.cost = 0
        card.shop_voucher = false
        local current_round_voucher = G.GAME.current_round.voucher
        card:redeem()
        G.GAME.current_round.voucher = current_round_voucher
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0,
            func = function()
                card:start_dissolve()
                return true
            end,
        }))
    end,
    can_use = function(self, card)
        local usable_count = 0
		for _, v in pairs(G.vouchers.cards) do
			if not v.ability.eternal and Entropy.GetHigherVoucherTier(v.config.center.key) and not v.ability.cry_absolute then
				usable_count = usable_count + 1
			end
		end
		if usable_count > 0 then
			return true
		else
			return false
		end
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.num,
            }
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local evocation = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 21,
    key = "evocation",
    set = "Omen",
    
    inversion = "c_cry_summoning",

    atlas = "consumables",
    config = {
        num = 1,
        hands = 1
    },
	pos = {x=7,y=8},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        for i, v in pairs(G.jokers.cards) do
            if not v.highlighted and not v.ability.cry_absolute and not v.ability.eternal then
                v:remove_from_deck()
                v:start_dissolve()
            end
        end
        for i, card in pairs(G.jokers.highlighted) do
            card:remove_from_deck()
            card:start_dissolve()
            local rare = nil
            if card.config.center.rarity ~= "j_entr_entropic" then
                rare = Entropy.GetNextRarity(card.config.center.rarity or 1) or card.config.center.rarity
            end
            if rare == 1 then rare = "Common" end
            if rare == 2 then rare = "Uncommon" end
            if rare == 4 then
                card = create_card("Joker", G.jokers, true, 4, nil, nil, nil, 'evocation')
            else 
                card = create_card("Joker", G.jokers, nil, rare, nil, nil, nil, 'evocation')
            end
            card:juice_up(0.3, 0.3)
            card:add_to_deck()
            G.jokers:emplace(card)
        end
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card2.ability.hands
        ease_hands_played(-card2.ability.hands)

    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.highlighted > 0 and #G.jokers.highlighted <= card.ability.num
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.num,
                -card.ability.hands
            }
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
}

local mimic = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 22,
    key = "mimic",
    set = "Omen",
    
    
	
    atlas = "consumables",

    inversion="c_cry_replica",

    config = {
        num = 1,
    },
	pos = {x=12,y=6},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local orig = Entropy.GetHighlightedCards({G.shop_booster, G.shop_jokers, G.shop_vouchers, G.hand, G.consumeables, G.jokers, G.pack_cards}, card2, 1, 1)[1]
        local newcard = copy_card(orig)
        newcard:add_to_deck()
        newcard.ability.perishable = true
        newcard.ability.banana = true
        newcard.area = orig.area
        if newcard.ability.set == "Booster" and orig.area ~= G.hand then
            newcard.area = G.consumeables
            newcard:add_to_deck()
            table.insert(newcard.area.cards, newcard)
        elseif newcard.ability.set == "Voucher" and orig.area ~= G.hand then
            newcard.area = G.consumeables
            newcard:add_to_deck()
            table.insert(newcard.area.cards, newcard)
        else
            orig.area:emplace(newcard)
            if orig.area.config.type == "shop" then
                local ref = G.FUNCS.check_for_buy_space(c1)
                newcard.ability.infinitesimal = true
                newcard.cost = 0
                G.FUNCS.buy_from_shop({config={ref_table=newcard}})
            end
        end

    end,
    can_use = function(self, card)
        return #Entropy.GetHighlightedCards({G.shop_booster, G.shop_jokers, G.shop_vouchers, G.hand, G.consumeables, G.jokers, G.pack_cards}, card, 1, card.ability.num) == card.ability.num
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.num,
            }
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local superego = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 23,
    key = "superego",
    set = "Omen",
    
    inversion = "c_cry_analog",

    atlas = "consumables",
    config = {
        num = 1,
    },
	pos = {x=8,y=6},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local cards = Entropy.GetHighlightedCards({G.jokers}, card2, 1, card2.ability.num)
        for i, card in ipairs(cards) do
            card.ability.superego = true
            card.ability.superego_copies = 0
            card:set_debuff(true)
            card.sell_cost = 0
            card:juice_up()

        end
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.jokers}, card, 1, card.ability.num)
        return num <= card.ability.num and num > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key="superego", set="Other", vars = {0}}
        return {
            vars = {
                card.ability.num,
            }
        }
    end,
    entr_credits = {
        art = {"LFMoth"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local superego_sticker = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Sticker",
    order = 2500 + 2,
    atlas = "entr_stickers",
    pos = { x = 4, y = 1 },
    key = "superego",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("FF00FF"),
    apply = function(self,card,val)
        card.ability.superego = true
        card.ability.superego_copies = 0
        card.ability.debuff = true
    end,
    loc_vars = function(self, q, card) return {vars={card.ability and math.floor(card.ability.superego_copies or 0) or 0}} end
}

local engulf = {
    dependencies = {
        items = {
          "set_entr_inversions",
          "e_entr_solar"
        }
    },
    object_type = "Consumable",
    order = 2000 + 26,
    key = "engulf",
    set = "Omen",
    
    inversion = "c_cry_ritual",

    atlas = "consumables",
    config = {
        num = 1,
    },
	pos = {x=8,y=7},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        for i, v in pairs(Entropy.GetHighlightedCards({G.hand}, card2, 1, card2.ability.num) ) do
            v:set_edition("e_entr_solar")
            v:juice_up()

        end
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.num) 
        return num <= card.ability.num and num > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] =  G.P_CENTERS.e_entr_solar
        return {
            vars = {
                card.ability.num,
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local offering = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 27,
    key = "offering",
    set = "Omen",

    inversion = "c_cry_adversary",

    atlas = "consumables",
    config = {
        sellmult = 0.75,
    },
	pos = {x=9,y=7},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        Entropy.FlipThen(G.jokers.cards, function(card, area)
            card.ability.rental = true
        end)
        G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.entr_shop_price_modifier = (G.GAME.entr_shop_price_modifier or 1) * card2.ability.sellmult
				for k, v in pairs(G.I.CARD) do
					if v.set_cost then
						v:set_cost()
					end
				end
				return true
			end,
		}))
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] =  {key="rental",set="Other", vars = {3}}
        return {
            vars = {
                card.ability.sellmult,
            }
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local entomb = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 28,
    key = "entomb",
    set = "Omen",

    inversion = "c_cry_chambered",

    atlas = "consumables",
    config = {
        num = 1
    },
	pos = {x=9,y=6},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        for i, v in pairs(Entropy.GetHighlightedCards({G.consumeables}, card2, 1, card2.ability.num)) do
            local c
            if v.config.center.set == "Booster" then
                c = copy_card(v)
            else
                c = create_card("Booster", G.consumeables, nil, nil, nil, nil, key) 
                c:set_ability(G.P_CENTERS[Entropy.BoosterSets[v.config.center.set] or "p_standard_normal_1"])
            end
            c:add_to_deck()
            c.T.w = c.T.w *  2.0/2.6
            c.T.h = c.T.h *  2.0/2.6
            table.insert(G.consumeables.cards, c)
            c.area = G.consumeables
            G.consumeables:align_cards()
        end

    end,
    can_use = function(self, card)
        return G.consumeables and #Entropy.GetHighlightedCards({G.consumeables}, card, 1, card.ability.num) > 0 and #Entropy.GetHighlightedCards({G.consumeables}, card, 1, card.ability.num) <= card.ability.num
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.num,
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local conduct = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 29,
    key = "conduct",
    set = "Omen",

    inversion = "c_cry_conduit",

    atlas = "consumables",
	pos = {x=10,y=6},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local card = Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card2, 1, 1)[1]
        local area = card.area
        local edition = Entropy.FindPreviousInPool(card.edition.key, "Edition")
        local cards = {}
        for i, v in pairs(area.cards) do
            if area.cards[i+1] == card or area.cards[i-1] == card then
                cards[#cards+1]=v
            end
        end
        Entropy.FlipThen(cards, function(card3, area, indx)
            card3:set_edition(edition)
            card3:add_to_deck()
        end)
        Entropy.Unhighlight({G.hand, G.jokers, G.consumeables, G.pack_cards})
    end,
    can_use = function(self, card)
        return #Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card, 1, 1) == 1 and Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card, 1, 1)[1].edition
        and Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card, 1, 1)[1].edition.key
	end,
    loc_vars = function(self,q,card)
        local str = "none"
        if #Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card) == 1 and Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card, 1, 1)[1].edition 
            and Entropy.FindPreviousInPool(Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card, 1, 1)[1].edition.key, "Edition") then
            str = G.localization.descriptions.Edition[Entropy.FindPreviousInPool(Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables, G.pack_cards}, card, 1, 1)[1].edition.key, "Edition")].name
        end
        return {
            vars = {
                str
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local pulsar = {
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    object_type = "Consumable",
    order = 2000 + 30,
    key = "pulsar",
    set = "Omen",
    
    inversion = "c_cry_white_hole",

    atlas = "consumables",
    config = {
        level = 4
    },
    no_select = true,
    soul_rate = 0,
    hidden = true, 
	pos = {x=6,y=3},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier,amt)
        local amt = amt or 1
        local used_consumable = copier or card
        delay(0.4)
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
          { handname = localize('k_all_hands'), chips = "...", mult = "...", level = "" }
        )
        for i, v in pairs(G.GAME.hands) do
            v.AscensionPower = to_big(v.AscensionPower or 0) + to_big(card.ability.level*amt)
        end
        delay(1.0)
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.2,
          func = function()
            play_sound("tarot1")
            ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.1)
            ease_colour(G.C.UI_MULT, copy_table(G.C.GOLD), 0.1)
            Cryptid.pulse_flame(0.01, sunlevel)
            used_consumable:juice_up(0.8, 0.5)
            G.E_MANAGER:add_event(Event({
              trigger = "after",
              blockable = false,
              blocking = false,
              delay = 1.2,
              func = function()
                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
                ease_colour(G.C.UI_MULT, G.C.RED, 1)
                return true
              end,
            }))
            return true
          end,
        }))
        update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+"..card.ability.level*amt })
        delay(2.6)
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
          { mult = 0, chips = 0, handname = "", level = "" }
        )
    end,
    no_select = true,
    bulk_use = function(self,card,area,copier,amt)
        self.use(self,card,area,copier,amt)
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.level
            }
        }
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}


local beyond = {
    object_type = "Consumable",
    order = 2000 + 31,
    key = "beyond",
    inversion = "c_cry_gateway",
    pos = {x = 0, y = 0},
    tsoul_pos = {x=2, y=0, extra = {x=1,y=0}},
    dependencies = {
        items = {"set_entr_entropics", "set_entr_inversions"}
    },
    atlas = "consumables",
    set = "Omen",
    no_select = true,
    hidden=true,
    soul_rate = 0,
    use = function(self, card)
        local deletable_jokers = {}
		for k, v in pairs(G.jokers.cards) do
			if not v.ability.eternal then
                if not Entropy.DeckOrSleeve("doc") or to_big(G.GAME.entropy or 0) < to_big(100) then
				    deletable_jokers[#deletable_jokers + 1] = v
                end
			end
		end
        if Entropy.DeckOrSleeve("doc") then
            ease_entropy(-G.GAME.entropy)
        end
		local _first_dissolve = nil
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.75,
			func = function()
				for k, v in pairs(deletable_jokers) do
					if v.config.center.rarity == "cry_exotic" then
						check_for_unlock({ type = "what_have_you_done" })
					end
					v:start_dissolve(nil, _first_dissolve)
					_first_dissolve = true
				end
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, "entr_entropic", nil, nil, nil, "entr_beyond")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
    end,
    can_use = function() return true end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}


local penumbra = {
    key = "penumbra",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901+22,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 1
    },
    pos = {x=2,y=2},
    inversion = "c_cry_eclipse",
    use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.hand}, card2, 1, card2.ability.select)
        for i, v in pairs(cards) do
            local card = cards[i]
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:start_dissolve()
                    if card.config.center.key ~= "c_base" then G.GAME.banned_keys[card.config.center.key] = true end
                    return true
                end
            }))
        end
            
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
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

local prophecy = {
    key = "prophecy",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -900+23,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    inversion = "c_cry_theblessing",
    pos = {x=3,y=2},
    config = {
        counter = 2
    },
    use = function(self, card, area, copier)
        G.GAME.next_inversions_prophecy = G.GAME.last_fraud.key
        G.GAME.last_fraud = nil
        G.GAME.inversions_prophecy_counter = card.ability.counter
    end,
    can_use = function(self, card)
        return G.GAME.last_fraud
	end,
    loc_vars = function(self, q, card)
        card.ability.last_fraud = G.GAME.last_fraud and G.GAME.last_fraud.set and G.localization.descriptions[G.GAME.last_fraud.set][G.GAME.last_fraud.key].name or "None"
        return {
            vars = {
                card.ability.counter
            },
            main_end = (card.area and (card.area == G.consumeables or card.area == G.pack_cards or card.area == G.hand)) and {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "m",
								colour = G.C.JOKER_GREY,
								r = 0.05,
								padding = 0.1,
								func = "has_fraud",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "last_fraud",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.32*0.8,
									},
								},
							},
						},
					},
				},
			} or nil,
        }
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"Grahkon"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local imp = {
    key = "imp",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901+24,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 2
    },
    pos = {x=4,y=2},
    inversion = "c_cry_seraph",
    use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.hand}, card2, 1, card2.ability.select)
        Entropy.FlipThen(cards, function(card)
            card:set_ability(G.P_CENTERS.m_entr_dark)
            G.hand:remove_from_highlighted(card)
        end)
            
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.m_entr_dark
        return {
            vars = {
                card.ability.select
            }
        }
    end,
    
	
    entr_credits = {
        art = {"Lfmoth"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

local integrity = {
    key = "integrity",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901+25,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 2
    },
    pos = {x=5,y=2},
    inversion = "c_cry_instability",
    use = function(self, card2)
        local cards = Entropy.FilterTable(Entropy.GetHighlightedCards({G.hand}, card2, 1, card2.ability.select), function(card) return card.config.center.key ~= "c_base" end)
        Entropy.FlipThen(cards, function(card)
            local edition = Entropy.pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("entropy"),function(e)
                return G.GAME.banned_keys[e.key] or e.no_doe
            end).key
            local seal = Entropy.pseudorandom_element(G.P_CENTER_POOLS.Seal, pseudoseed("entropy"),function(e)
                return G.GAME.banned_keys[e.key] or e.no_doe
            end).key
            card:set_edition(edition)
            card:set_seal(seal)
            card:set_ability(G.P_CENTERS.c_base)
            G.hand:remove_from_highlighted(card)
        end)
            
    end,
    can_use = function(self, card)
        local num = #Entropy.FilterTable(Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select), function(card) return card.config.center.key ~= "c_base" end)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
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

local mallet = {
    key = "mallet",
    set = "Fraud",
    atlas = "fraud",
    object_type = "Consumable",
    order = -901+32,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        create = 1
    },
    pos = {x=6,y=2},
    inversion = "c_cry_automaton",
    use = function(self, card2)
        local cards = {}
        for i, v in pairs(G.hand.cards) do cards[#cards+1]=v end
        pseudoshuffle(cards, pseudoseed('immolate'))
        local actual = {}
        for i = 1, card2.ability.create do
            actual[i] = cards[i]
        end
        for i, v in ipairs(actual) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.consumeables.config.card_count < G.consumeables.config.card_limit then
                        SMODS.add_card({
                            set = "Command",
                            area = G.consumeables
                        })
                    end
                    return true
                end
            }))
            v:start_dissolve()
        end
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.create
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

return {
    items = {
        --Omen
        dispel,
        cleanse,
        fusion,
        substitute,
        evocation,
        mimic,
        project,
        downpour,
        rift,
        script,
        engulf,
        offering,
        entomb,
        conduct,
        pulsar,
        beyond,
        superego,
        superego_sticker,

        --Fraud
        penumbra,
        prophecy,
        imp,
        integrity,
        mallet
    }
}
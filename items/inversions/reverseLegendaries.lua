SMODS.Atlas { key = 'reverse_legendary', path = 'reverse_legendaries.png', px = 71, py = 95 }

local perkeo = {
    order = 200,
    object_type = "Joker",
    key = "perkeo",
    config = {
        qmult = 4
    },
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    rarity = "entr_reverse_legendary",
    cost = 20,
    unlocked = true,

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },
    atlas = "reverse_legendary",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
    end,
    immutable = true,
    demicoloncompat = true,
    calculate = function (self, card, context)
        if context.ending_shop or context.forcetrigger then
            if #G.consumeables.cards > 0 then
                local e = pseudorandom_element(G.consumeables.cards, pseudoseed("rperkeo"))
                local set = e.config.center.set
                local tries = 0
                while not Entropy.BoosterSets[set] and tries < 100 do
                    e = pseudorandom_element(G.consumeables.cards, pseudoseed("rperkeo"))
                    set = e.config.center.set
                end 
                if Entropy.BoosterSets[set] then
                    e:start_dissolve()
                    local c = create_card("Booster", G.consumeables, nil, nil, nil, nil, key) 
                    c:set_ability(G.P_CENTERS[Entropy.BoosterSets[set] or "p_standard_normal_1"])
                    c:add_to_deck()
                    c.T.w = c.T.w *  2.0/2.6
                    c.T.h = c.T.h *  2.0/2.6
                    table.insert(G.consumeables.cards, c)
                    c.area = G.consumeables
                    c:set_edition({
                        negative=true,
                        key="e_negative",
                        card_limit=1,
                        type="negative"
                    })
                    c.RPerkeoPack = true
                    G.consumeables:align_cards()
                    G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
                end
            end
        end
    end
}

local add_ref = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    add_ref(self, card, location, stay_flipped)
    if self == G.hand and G.hand and G.GAME.h_side_mult and G.GAME.h_side_mult ~= 1 then
        G.hand.config.card_limit = G.hand.config.card_limit + 1 - 1/(G.GAME.h_side_mult)
        if G.hand.config.card_limit - #G.hand.cards >= 4 then
            G.FUNCS.draw_from_deck_to_hand(1)
        end
    end
end
local remove_ref = CardArea.remove_card
function CardArea:remove_card(card, discarded_only)
    local c = remove_ref(self, card, discarded_only) 
    if self == G.hand and G.hand and G.GAME.h_side_mult and G.GAME.h_side_mult ~= 1 then
        G.hand.config.card_limit = G.hand.config.card_limit - (1 - 1/(G.GAME.h_side_mult))
    end
    return c
end
local chicot = {
    order = 201,
    object_type = "Joker",
    key = "chicot",
    config = {
        qmult = 4
    },
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    rarity = "entr_reverse_legendary",
    cost = 20,
    unlocked = true,

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },
    atlas = "reverse_legendary",
    demicoloncompat=true,
    loc_vars = function(self, info_queue, card)
        local ret = localize("k_none")
		if Cryptid.safe_get(G.GAME, "blind", "in_blind") then
			for i, v in pairs(G.GAME.round_resets.blind_states) do
                if v == "Current" or v == "Select" then
                    if i == "Boss" then
                        ret = "???"
                    else    
                        ret = localize({ type = "name_text", key = G.GAME.round_resets.blind_tags.Small, set = "Tag" })
                    end
                end
            end
		end
        return {
            vars = {ret}
        }
    end,
    immutable = true,
    calculate = function (self, card, context)
        if (context.setting_blind and not card.getting_sliced) or context.forcetrigger then
            local tag
            local type = G.GAME.blind:get_type()

            if type == "Boss" then
                tag = Tag(get_next_tag_key())
                if context.forcetrigger then
                    G.GAME.blind.chips = G.GAME.blind.chips * 0.2
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    G.HUD_blind:recalculate()
                end
            else
                tag = Tag(G.GAME.round_resets.blind_tags[type])
                if not context.blueprint then
                    G.GAME.blind.chips = G.GAME.blind.chips * 0.2
                end
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate()
                --card:juice_up()
            end
            for i = 0, 10 do
                if not tag.ability.shiny or tag.ability.shine == false then
                    tag.ability.shiny=Cryptid.is_shiny()
                end
            end
            add_tag(tag)
        end
    end
}

local BoosterSets = {
    ["Spectral"] = "p_spectral_mega_1",
    ["Tarot"] = "p_arcana_mega_1",
    ["Planet"] = "p_celestial_mega_1",
    ["Spectral"] = "p_spectral_mega_1",
    ["Code"] = "p_cry_code_mega_1",
    ["RCode"] = "p_entr_twisted_pack_mega",
    ["RPlanet"] = "p_entr_twisted_pack_mega",
    ["RSpectral"] = "p_entr_twisted_pack_mega",
}
for i, v in pairs(BoosterSets) do Entropy.BoosterSets[i] = v end
local yorick = {
    order = 202,
    object_type = "Joker",
    key = "yorick",
    config = {
        csl = 23,
        hs = 2.3,
        neededd = 114,
        currd = 0,
        echips = 1,
        echips_mod = 0.5
    },
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    rarity = "entr_reverse_legendary",
    cost = 20,
    unlocked = true,

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },
    atlas = "reverse_legendary",
    demicoloncompat=true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.hs,
                card.ability.csl,
                card.ability.echips_mod,
                card.ability.neededd,
                card.ability.currd,
                card.ability.echips,
            },
        }
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
    demicoloncompat = true,
    add_to_deck = function(self, card)
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + card.ability.csl
        card.ability.hs_set = nil
        if G.hand.config.card_limit * (G.GAME.hsize_mult or 1) < 1000 then
            G.GAME.hsize_mult = (G.GAME.hsize_mult or 1) * card.ability.hs
            card.ability.hs_set = true
            G.hand.config.true_size = G.hand.config.card_limit * (G.GAME.hsize_mult or 1)
            if #G.hand.cards > 0 then
                G.FUNCS.draw_from_deck_to_hand(G.hand.config.true_size-#G.hand.cards)
            end
        end
    end,
    remove_from_deck = function(self, card)
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - card.ability.csl
        if card.ability.hs_set then
            G.GAME.hsize_mult = G.GAME.hsize_mult / card.ability.hs
            G.hand.config.true_size = G.hand.config.card_limit * (G.GAME.hsize_mult or 1)
        end
    end,
    calculate = function (self, card, context)
        if (context.pre_discard and not context.retrigger_joker and not context.blueprint) or context.forcetrigger then
            card.ability.currd = card.ability.currd + #G.hand.highlighted
            while card.ability.currd >= card.ability.neededd do
                card.ability.currd = card.ability.currd - card.ability.neededd
                card.ability.echips = card.ability.echips + card.ability.echips_mod
            end
            if context.forcetrigger then
                card.ability.echips = card.ability.echips + card.ability.echips_mod
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
				Echip_mod = card.ability.echips,
				message = localize({
					type = "variable",
					key = "a_powchips",
					vars = { card.ability.echips },
				}),
				colour = { 0.8, 0.45, 0.85, 1 }, --plasma colors
			}
        end
    end
}

local rdeck_ref = Card.remove_from_deck

function Card:remove_from_deck()
    rdeck_ref(self)
    if G.hand and ((self.ability and (self.ability.h_size or self.ability.h_size_mod)) or (self.edition and self.edition.card_limit)) then
        G.hand.config.true_size = (G.hand.config.card_limit - (self.ability and (self.ability.h_size or self.ability.h_size_mod)) or (self.edition and self.edition.card_limit)) * (G.GAME.hsize_mult or 1)
    end
end

local draw_ref = CardArea.draw

function CardArea:draw()
    if self == G.hand and G.hand then  
        self.config.true_size = self.config.card_limit * (G.GAME.hsize_mult or 1)
    else
        self.config.true_size = self.config.card_limit
    end
    draw_ref(self)
end


local trib = {
    order = 203,
    object_type = "Joker",
    key = "triboulet",
    rarity = "entr_reverse_legendary",
    cost = 20,
    unlocked = true,
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },
    atlas = "reverse_legendary",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.xmult
            },
        }
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
    calculate = function (self, card, context)
        if (context.individual and context.cardarea == G.play) then
            local num_jacks = 0
            for i, v in pairs(G.play.cards) do
                if v.base.id == 11 then
                    num_jacks = num_jacks + 1
                end
            end
            if context.other_card.base.id == 11 then
                return {
                    Xchip_mod = num_jacks,
                    message = localize({
                        type = "variable",
                        key = "a_xchips",
                        vars = { num_jacks },
                    }),
                    colour = { 0.8, 0.45, 0.85, 1 }
                }
            end
        end
        if context.repetition and context.cardarea == G.play and context.other_card.base.id == 11 then
            local order = 1
            for i, v in pairs(G.play.cards) do
                if v.unique_val == context.other_card.unique_val then
                    order = i
                end
            end
            if order > 1 then
                return {
                    message = localize("cry_again_q"),
                    repetitions = order-1,
                    card = card,
                }
            end
        end
    end
}

local canio = {
    order = 204,
    object_type = "Joker",
    key = "canio",
    rarity = "entr_reverse_legendary",
    cost = 20,
    unlocked = true,

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    config = {
        extra = {
            emult = 1,
            emult_mod = 0.05
        }
    },
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    atlas = "reverse_legendary",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.emult_mod,
                card.ability.extra.emult
            },
        }
    end,
    demicoloncompat = true,
    calculate = function (self, card2, context)
        if context.destroy_card and context.cardarea == G.play and context.destroying_card then
                local card = Card(context.destroying_card.T.x, context.destroying_card.T.y, G.CARD_W*(card_scale or 1), G.CARD_H*(card_scale or 1), G.P_CARDS.empty, G.P_CENTERS.c_base, {playing_card = playing_card})
                card:set_base(context.destroying_card.config.card)
                SMODS.change_base(card, card.base.suit, Entropy.HigherCardRank(card))
                card:add_to_deck()
                table.insert(G.playing_cards, card)
                G.hand:emplace(card)
                playing_card_joker_effects({ card })
                if context.destroying_card:is_face() then
                    card2.ability.extra.emult = (card2.ability.extra.emult or 1) + (card2.ability.extra.emult_mod or 0.1)
                    return {
                        message = "Upgraded",
                        remove = true
                    }
                else    
                    return {
                        remove = true
                    }
                end
        end
        if context.joker_main or context.forcetrigger then
            return {
				Echip_mod = card2.ability.extra.emult,
				message = localize({
					type = "variable",
					key = "a_powchips",
					vars = { card2.ability.extra.emult },
				}),
				colour = { 0.8, 0.45, 0.85, 1 }, --plasma colors
			}
        end
    end
}

local membership = {
    order = 205,
    object_type = "Joker",
    key = "membership",
    config = {
        x_asc_mod = 1,
        num = 86
    },
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    rarity = "entr_reverse_legendary",
    cost = 20,
    unlocked = true,

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 3 },
    soul_pos = { x = 0, y = 2 },
    atlas = "reverse_legendary",
    demicoloncompat=true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.x_asc_mod),
                number_format(1+card.ability.num*card.ability.x_asc_mod)
            }
        }
    end,
    calculate = function (self, card, context)
       if context.joker_main or context.forcetrigger then
            return {
                asc = 1+card.ability.num*card.ability.x_asc_mod
            }
       end
    end
}
return {
    items = {
        perkeo,
        canio,
        chicot,
        yorick,
        trib,
        membership
    }
}
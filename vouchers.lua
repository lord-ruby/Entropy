SMODS.Atlas { key = 'vouchers', path = 'vouchers.png', px = 71, py = 95 }
SMODS.Atlas { key = 'booster', path = 'boosters.png', px = 71, py = 95 }
SMODS.Voucher({
    key = "marked",
    atlas = "vouchers",
    pos = {x=0, y=0},
    redeem = function(self, card)
        G.GAME.Marked = true
    end,
    unredeem = function(self, card) 
        G.GAME.Marked = nil
    end
})

SMODS.Voucher({
    key = "trump_card",
    atlas = "vouchers",
    pos = {x=1, y=0},
    requires = {"v_entr_marked"},
    redeem = function(self, card)
        G.GAME.TrumpCard = true
    end,
    unredeem = function(self, card) 
        G.GAME.TrumpCard = nil
    end
})

SMODS.Voucher({
    key = "supersede",
    atlas = "vouchers",
    pos = {x=2, y=0},
    requires = {"v_entr_marked", "v_entr_trump_card"},
    redeem = function(self, card)
        G.GAME.Supersede = true
    end,
    unredeem = function(self, card) 
        G.GAME.Supersede = nil
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_entr_flipside
    end
})

local TrumpCardAllow = {
    ["Planet"] = true,
    ["Tarot"] = true,
    ["Code"] = true
}
local matref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    if self.config and self.config.center and Entropy.FlipsideInversions and Entropy.FlipsideInversions[self.config.center.key]
    and pseudorandom("marked") < 0.10 and G.GAME.Marked and G.STATE == G.STATES.SHOP and (not self.area or not self.area.config.collection) then
        matref(self, G.P_CENTERS[Entropy.FlipsideInversions[self.config.center.key]], initial, delay_sprites)
    elseif self.config and self.config.center
    and pseudorandom("trump_card") < 0.10 and G.GAME.TrumpCard and G.STATE == G.STATES.SMODS_BOOSTER_OPENED
    and TrumpCardAllow[center.set] and (not self.area or not self.area.config.collection) then
        matref(self, G.P_CENTERS["c_entr_flipside"], initial, delay_sprites)
    elseif self.config and self.config.center and self.config.center.set == "Booster"
    and pseudorandom("supersede") < 0.20 and G.GAME.Supersede and G.STATE == G.STATES.SHOP and (not self.area or not self.area.config.collection) then
        local type = (center.cost == 6 and "jumbo") or (center.cost == 8 and "mega") or "normal"
        matref(self, G.P_CENTERS["p_entr_twisted_pack_"..type], initial, delay_sprites)
    elseif self.config and self.config.center and self.config.center.set == "Booster"
    and to_big(pseudorandom("doc")) < to_big(1-(0.975^G.GAME.entropy)) and G.STATE == G.STATES.SHOP and (not self.area or not self.area.config.collection) and G.GAME.selected_back.effect.center.original_key == "doc" then
        local type = (center.cost == 6 and "jumbo_1") or (center.cost == 8 and "mega_1") or "normal_"..pseudorandom_element({1,2},pseudoseed("doc"))
        matref(self, G.P_CENTERS["p_spectral_"..type], initial, delay_sprites)
    else
        matref(self, center, initial, delay_sprites)
    end
end

SMODS.Booster({
    key = "twisted_pack_normal",
    set = "Booster",
    config = { extra = 3, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    HEX("851628")
                }
            },
        }
    end,
    atlas = 'booster', pos = { x = 0, y = 0 },
    group_key = "k_inverted_pack",
    cost = 4,
    draw_hand = true,
    weight = 0.75,
    hidden = true,
    kind = "Inverted",
    create_card = function (self, card, i) 
        return create_inverted_card()
    end,
    ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, HEX("851628"))
		ease_background_colour({ new_colour = HEX("3c020b"), special_colour = HEX("3c020b"), contrast = 2 })
	end
})
SMODS.Booster({
    key = "twisted_pack_jumbo",
    set = "Booster",
    config = { extra = 5, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    HEX("851628")
                }
            },
        }
    end,
    atlas = 'booster', pos = { x = 1, y = 0 },
    group_key = "k_inverted_pack",
    cost = 6,
    draw_hand = true,
    weight = 0.5,
    hidden = true,
    kind = "Inverted",
    create_card = function (self, card, i) 
        return create_inverted_card()
    end,
    ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, HEX("851628"))
		ease_background_colour({ new_colour = HEX("3c020b"), special_colour = HEX("3c020b"), contrast = 2 })
	end
})
SMODS.Booster({
    key = "twisted_pack_mega",
    set = "Booster",
    config = { extra = 5, choose = 2 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    HEX("851628")
                }
            },
        }
    end,
    atlas = 'booster', pos = { x = 2, y = 0 },
    group_key = "k_inverted_pack",
    cost = 8,
    draw_hand = true,
    weight = 0.25,
    hidden = true,
    kind = "Inverted",
    create_card = function (self, card, i) 
        return create_inverted_card()
    end,
    ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, HEX("851628"))
		ease_background_colour({ new_colour = HEX("3c020b"), special_colour = HEX("3c020b"), contrast = 2 })
	end
})
Entropy.RareInversions = {
    ["c_entr_define"] = "c_entr_define",
    ["c_entr_beyond"] = "c_entr_beyond",
    ["c_entr_fervour"] = "c_entr_fervour"
}
function create_inverted_card(area, seed)
    local num = pseudorandom("twisted_rare")
    if num - 0.01 <= 0 then
        local c = pseudorandom_element(Entropy.RareInversions, pseudoseed(seed or "twisted"))
        return create_card(G.P_CENTERS[c].set, area or G.pack_cards, nil, nil, true, true, c)
    end
    return create_card("Twisted", area or G.pack_cards, nil, nil, true, true, nil, "twisted")
end
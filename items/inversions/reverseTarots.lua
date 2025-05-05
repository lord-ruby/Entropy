SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "RTarot",
	primary_colour = HEX("da7272"),
	secondary_colour = HEX("a54747"),
	collection_rows = { 4, 4 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_fool"
})
-- 0 - Fool -     Master (Coded)
-- 1 - Magician -     Carpenter
-- 2 - High Priestess -     Oracle
-- 3 - Empress -     Princess
-- 4 - Emperor -     Servant
-- 5 - Hierophant -     Heretic
-- 6 - Lovers -     Feud
-- 7 - Chariot -     Scar
-- 8 - Justice -     Dagger
-- 9 - Hermit -     Earl
-- 10 - Wheel of Fortune -     Whetstone
-- 11 - Strength -     Endurance
-- 12 - Hanged Man -     Advisor
-- 13 - Death -     Statue (Coded)
-- 14 - Temperance -     Feast
-- 15 - Devil -     Companion
-- 16 - Tower -     Village
-- 17 - Star -     Ocean
-- 18 - Moon -     Forest
-- 19 - Sun -     Mountain --cassknows & lfmoth
-- 20 - Judgement -     Forgiveness
-- 21 - World -     Tent
-- 22 - Eclipse -     Noon (Zenith) [Penumbra] {Umbra} <Bra> 'Shadow'
-- 23 - Blessing -     Prophecy
-- 24 - Seraph -     Imp --lfmoth
-- 25 - Instability -     Equality
-- 32 - Automaton -     Mallet
SMODS.Atlas { key = 'rtarot', path = 'reverse_tarots.png', px = 71, py = 95 }
local master = {
    key = "master",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -900,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    use = function(self, card, area, copier)
        local c = create_card(G.GAME.last_inversion.set, G.consumeables, nil, nil, nil, nil, G.GAME.last_inversion.key)
        G.GAME.last_inversion = nil
        c:add_to_deck()
        G.consumeables:emplace(c)
    end,
    can_use = function(self, card)
        return G.GAME.last_inversion
	end,
    loc_vars = function(self, q, card)
        card.ability.last_inversion = G.GAME.last_inversion and G.localization.descriptions[G.GAME.last_inversion.set][G.GAME.last_inversion.key].name or "None"
        return {
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
								func = "has_inversion",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "last_inversion",
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
    end
}
G.FUNCS.has_inversion = function(e) 
    if G.GAME.last_inversion then 
        e.config.colour = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
    else
        e.config.colour = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
    end
 end
local ref = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
    local card = e.config.ref_table
    if Entropy.FlipsideInversions[card.config.center.key] and not Entropy.FlipsidePureInversions[card.config.center.key] and card.config.center.key ~= "c_entr_master" then
        G.GAME.last_inversion = {
            key = card.config.center.key,
            set = card.config.center.set
        }
    end
    ref(e, mute, nosave)
end

local whetstone = {
    key = "whetstone",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+10,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        select = 2,
        extra = {odds = 2}
    },
    pos = {x=0,y=1},
    use = function(self, card2)
        if pseudorandom("whetstone")
        < cry_prob(card2.ability.cry_prob, card2.ability.extra.odds, card2.ability.cry_rigged) / card2.ability.extra.odds then
            local num, cards = Entropy.GetHighlightedCards({G.hand}, nil, card)
            Entropy.FlipThen(cards, function(card)
                local enh = Entropy.UpgradeEnhancement(card)
                card:set_ability(G.P_CENTERS[enh])
                for i = 1, math.floor(pseudorandom("whetstone")*2+0.5) do
                    enh = Entropy.UpgradeEnhancement(card)
                    card:set_ability(G.P_CENTERS[enh])
                end
                if enh ~= card.config.center.key then
                    card:set_ability(G.P_CENTERS[enh])
                end
            end)
        else
            local used_tarot = card2
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                  text = localize('k_nope_ex'),
                  scale = 1.3, 
                  hold = 1.4,
                  major = used_tarot,
                  backdrop_colour = G.C.RED,
                  align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                  offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                  silent = true
                  })
                  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4);return true end}))
                  play_sound('tarot2', 1, 0.4)
                  used_tarot:juice_up(0.3, 0.5)
              return true end }))
        end
    end,
    can_use = function(self, card)
        local num = Entropy.GetHighlightedCards({G.hand}, nil, card)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        --q[#q+1] = G.P_CENTERS.m_stone
        return {
            vars = {
                cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged),
                card.ability.extra.odds,
                card.ability.select
            }
        }
    end
}

local statue = {
    key = "statue",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901+13,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    config = {
        convert_per = 3,
        select = 1
    },
    pos = {x=3,y=1},
    use = function(self, card2)
        local num, cards = Entropy.GetHighlightedCards({G.hand}, nil, card)
        Entropy.FlipThen(cards, function(card)
            card:set_ability(G.P_CENTERS.m_stone)
            card:set_edition()
            card.seal = nil
        end)
        G.E_MANAGER:add_event(Event({
			func = function()
                for i = 1, card2.ability.convert_per do
                    local card3 = pseudorandom_element(G.deck.cards, pseudoseed("statue"))
                    copy_card(#cards == 1 and #cards[1] or pseudorandom_element(cards, pseudoseed("statue")), card3)
                end
            end
        }))
    end,
    can_use = function(self, card)
        local num = Entropy.GetHighlightedCards({G.hand}, nil, card)
        return num > 0 and num <= card.ability.select and #G.hand.cards > 0
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.m_stone
        return {
            vars = {
                card.ability.convert_per,
                card.ability.select
            }
        }
    end
}
return {
    items = {
        master,
        statue,
        whetstone
    }
}
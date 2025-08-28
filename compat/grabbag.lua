if (SMODS.Mods["GrabBag"] or {}).can_load then
    function get_random_shatter()
        local shatters = {}
        for i, v in pairs(GB_SHATTERED_TABLE) do
            shatters[#shatters+1] = v
        end
        return pseudorandom_element(shatters, pseudoseed("random_shatter"))
    end
    local splinter = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 2500+3,
        key = "splinter",
        set = "Omen",
        
        inversion = "c_gb_shatter",
        
        atlas = "crossmod_consumables",
        pos = {x=5,y=0},
        --soul_pos = { x = 5, y = 0},
        use = function(self, card, area, copier)
            local card = pseudorandom_element(G.playing_cards, pseudoseed("entr_splinter"))
            card:set_ability(get_random_shatter())
            card:juice_up()
        end,
        can_use = function(self, card)
            return #G.playing_cards > 0
        end,
        demicoloncompat = true,
        force_use = function(self, card)
            self:use(card)
        end
    }
    local dream = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 2500 + 4,
        key = "dream",
        set = "Omen",
        
        inversion = "c_gb_awaken",
        
        atlas = "crossmod_consumables",
        config = {
            create = 3
        },
        pos = {x=6,y=0},
        --soul_pos = { x = 5, y = 0},
        use = function(self, card, area, copier)
            for i = 1, math.min(card.ability.create, 100) do
                local card = SMODS.add_card{
                    set = "Enhanced",
                    area = G.hand,
                    suit = "gb_Eyes"
                }
                table.insert(G.playing_cards, card)
            end
        end,
        can_use = function(self, card)
            return G.GAME.blind.in_blind
        end,
        loc_vars = function(self, q, card)
            return {
                vars = {
                    math.min(card.ability.create, 100)
                }
            }
        end,
        demicoloncompat = true,
        force_use = function(self, card)
            self:use(card)
        end
    }

    local mini = {
        dependencies = {
            items = {
                "set_entr_inversions"
            }
        },
        object_type = "Seal",
        order = 3010,
        key="entr_mini",
        atlas = "seals",
        pos = {x=0,y=1},
        config = { extra = { odds = 3 } },
        badge_colour = HEX('ba3f00'),
        loc_vars = function(self, info_queue, card)
            local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, self.config.extra.odds)
            return { vars = { new_numerator, new_denominator } }
        end,
        calculate = function(self, card, context)
            if context.after then
                if SMODS.pseudorandom_probability(card, 'entr_mini', 1, self.config.extra.odds) then
                    local index
                    for i, v in pairs(G.play.cards) do
                        if v == card then index = i end
                    end
                    if index then
                        local card1 = G.play.cards[index-1]
                        local card2 = G.play.cards[index+1]
                        if card1 then card1:start_dissolve(); card1.ability.temporary2 = true end
                        if card2 then card2:start_dissolve(); card2.ability.temporary2 = true end
                    end
                end
            end
        end,
    }

    local sharp = {
        dependencies = {
            items = {
                "set_entr_inversions"
            }
        },
        object_type = "Seal",
        order = 3011,
        key="entr_sharp",
        atlas = "seals",
        pos = {x=1,y=1},
        config = { extra = { odds = 3 } },
        badge_colour = HEX('985252'),
        loc_vars = function(self, info_queue, card)
            local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, self.config.extra.odds)
            return { vars = { new_numerator, new_denominator } }
        end,
        calculate = function(self, card, context)
            if context.before 
            and context.cardarea == G.play then    
                if SMODS.pseudorandom_probability(card, 'entr_sharp', 1, self.config.extra.odds) then
                    Entropy.FlipThen({card}, function(card)
                        local enh = Entropy.UpgradeEnhancement(card, false, {m_entr_disavowed = true})
                        if G.P_CENTERS[enh] then
                            card:set_ability(G.P_CENTERS[enh])
                        end
                    end)
                end
            end
        end,
    }
    local vantablack = {
        dependencies = {
            items = {
                "set_entr_inversions"
            }
        },
        object_type = "Seal",
        order = 3012,
        key="entr_vantablack",
        atlas = "seals",
        pos = {x=2,y=1},
        badge_colour = HEX('201f33'),
    }
    local highlight_ref = Card.highlight
    function Card:highlight(is_h, ...)
        if self.seal == "entr_vantablack" then
            if is_h and not self.highlighted and not self.added then
                Entropy.ChangeFullCSL(1)
                self.added = true
            end
            if not is_h and self.highlighted and self.added then
                Entropy.ChangeFullCSL(-1)
                self.added = nil
            end
        end
        return highlight_ref(self, is_h, ...)
    end
    local void = Entropy.SealSpectral("void", {x=5,y=1}, "entr_mini", 2500, "c_gb_dualism", nil, "crossmod_consumables", {1, 3})
    local sharpen = Entropy.SealSpectral("sharpen", {x=6,y=1}, "entr_sharp", 2501, "c_gb_gambit", nil, "crossmod_consumables", {1, 3})
    local singularity = Entropy.SealSpectral("singularity", {x=7,y=1}, "entr_vantablack", 2502, "c_gb_lotus", nil, "crossmod_consumables")

    -- Sculpture - Visage
    -- Hourlgass - Sundial
    -- Gold Dust - Pyrite
    -- Magic - Faith
    -- Rust - Decay
    -- Spirit - Essence
    -- Collapse - Implode
    -- Group - Set
    -- Chain - Cage
    -- Portal - ??
    -- Plasma - Burn
    -- Comet - Meteor
    -- Wish - Hope
    -- Mirage - Oasis
    -- Diffusion - Concentrate
    -- Incense - Candle
    -- Vanish - Manifest
    -- Spark - Nebula
    -- Harlequin - Trickster
    -- Motley - Ragtag

    SMODS.ConsumableType({
        object_type = "ConsumableType",
        key = "Transient",
        primary_colour = G.C.Entropy.Transient,
        secondary_colour = G.C.Entropy.Transient,
        collection_rows = { 5, 5 },
        shop_rate = 0.0,
        loc_txt = {},
        default = "c_entr_visage",
        can_be_pulled = true,
    })
    
    SMODS.UndiscoveredSprite({
        key = "Transient",
        atlas = "undiscovered",
        path = "undiscovered.png",
        pos = { x = 0, y = 1 },
        px = 71,
        py = 95,
    })

    local cage = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3000,
        key = "cage",
        set = "Transient",
        inversion = "c_gb_chain",
        atlas = "crossmod_consumables",
        config = {
            select = 3
        },
        pos = {x=5,y=3},
        --soul_pos = { x = 5, y = 0},
        use = function(self, card, area, copier)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            Entropy.FlipThen(cards, function(card)
                local suit = cards[1].base.suit
                SMODS.change_base(card, suit)
                card:set_edition("e_gb_temporary")
            end)
        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            return num > 0 and num <= card.ability.select
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local implode = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3001,
        key = "implode",
        set = "Transient",
        inversion = "c_gb_collapse",
        atlas = "crossmod_consumables",
        config = {
            select = 3
        },
        pos = {x=11,y=2},
        use = function(self, card, area, copier)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            Entropy.FlipThen(cards, function(card)
                SMODS.change_base(card, "entr_nilsuit", "Ace")
                card:set_edition("e_gb_temporary")
            end)
        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            return num > 0 and num <= card.ability.select
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local meteor = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3002,
        key = "meteor",
        set = "Transient",
        inversion = "c_gb_comet",
        atlas = "crossmod_consumables",
        config = {
            select = 3
        },
        pos = {x=8,y=3},
        use = function(self, card, area, copier)
            local cards = {}; for i, v in pairs(G.hand.cards) do cards[#cards+1] = v end
            pseudoshuffle(cards, pseudoseed("entr_meteor"))
            for i = 1, math.min(#cards, card.ability.select) do
                if cards[i] then
                    cards[i]:set_seal("entr_sapphire")
                    cards[i]:set_edition("e_gb_temporary")
                end
            end
        end,
        can_use = function(self, card)
            return #G.hand.cards > 0
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local concentrate = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3003,
        key = "concentrate",
        set = "Transient",
        inversion = "c_gb_diffusion",
        atlas = "crossmod_consumables",
        config = {
            select = 3
        },
        pos = {x=11,y=3},
        use = function(self, card, area, copier)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            Entropy.FlipThen(cards, function(card)
                card:set_edition("e_gb_temporary")
                local card_new = copy_card(card)
                card_new:add_to_deck()
                G.hand:emplace(card_new)
            end)
        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            return num > 0
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local pyrite = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3004,
        key = "pyrite",
        set = "Transient",
        inversion = "c_gb_gold_dust",
        atlas = "crossmod_consumables",
        config = {
            select = 2
        },
        pos = {x=7,y=2},
        use = function(self, card, area, copier)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            Entropy.FlipThen(cards, function(card)
                card:set_ability(G.P_CENTERS.m_gold)
                card:set_edition("e_gb_temporary")
            end)
        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            return num > 0 and num <= card.ability.select
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local set = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3005,
        key = "set",
        set = "Transient",
        inversion = "c_gb_group",
        atlas = "crossmod_consumables",
        config = {
            select = 3
        },
        pos = {x=12,y=2},
        --soul_pos = { x = 5, y = 0},
        use = function(self, card, area, copier)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            local rank = cards[1] and cards[1].base.value
            Entropy.FlipThen(cards, function(card)
                SMODS.change_base(card, nil, rank)
                card:set_edition("e_gb_temporary")
            end)
        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            return num > 0 and num <= card.ability.select
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local trickster = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3006,
        key = "trickster",
        set = "Transient",
        inversion = "c_gb_harlequin",
        atlas = "crossmod_consumables",
        config = {
            select = 1
        },
        pos = {x=7,y=4},
        --soul_pos = { x = 5, y = 0},
        use = function(self, card, area, copier)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            local ability = pseudorandom_element(G.P_JOKER_RARITY_POOLS[3], pseudoseed("entr_trickster"))
            Entropy.FlipThen(cards, function(card)
                card:set_ability(ability)
                card:set_edition("e_gb_temporary")
            end)
        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            return num > 0 and num <= card.ability.select
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local sundial = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3007,
        key = "sundial",
        set = "Transient",
        inversion = "c_gb_hourglass",
        atlas = "crossmod_consumables",
        config = {
            select = 2
        },
        pos = {x=6,y=2},
        use = function(self, card, area, copier)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            Entropy.FlipThen(cards, function(card)
                card:set_ability(G.P_CENTERS.m_glass)
                card:set_edition("e_gb_temporary")
            end)
        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            return num > 0 and num <= card.ability.select
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local candle = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3008,
        key = "candle",
        set = "Transient",
        inversion = "c_gb_incense",
        atlas = "crossmod_consumables",
        config = {
            size = 2
        },
        pos = {x=12,y=3},
        use = function(self, card, area, copier)
            G.GAME.candle_hand_size = (G.GAME.candle_hand_size or 0) + math.min(card.ability.size, 10)
            G.hand:handle_card_limit(math.min(card.ability.size, 10))
        end,
        can_use = function(self, card)
            return G.GAME.blind.in_blind
        end,
        loc_vars = function(self, q, card)
            return {vars = {math.min(card.ability.size, 10)}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local faith = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3009,
        key = "faith",
        set = "Transient",
        inversion = "c_gb_magic",
        atlas = "crossmod_consumables",
        config = {
            select = 2
        },
        pos = {x=8,y=2},
        use = function(self, card, area, copier)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            Entropy.FlipThen(cards, function(card)
                card:set_ability(G.P_CENTERS.m_lucky)
                card:set_edition("e_gb_temporary")
            end)
        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            return num > 0 and num <= card.ability.select
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local oasis = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3010,
        key = "oasis",
        set = "Transient",
        inversion = "c_gb_mirage",
        atlas = "crossmod_consumables",
        config = {
            create = 4
        },
        pos = {x=10,y=3},
        use = function(self, card, area, copier)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, 1)
            local create = card.ability.create
            Entropy.FlipThen(cards, function(card)
                card:set_edition("e_gb_temporary")
                for i = 1, create do
                    local card_new = copy_card(card)
                    card_new:add_to_deck()
                    G.hand:emplace(card_new)
                end
            end)
        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, 1)
            return num > 0 and num <= 1
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.create}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local ragtag = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3011,
        key = "ragtag",
        set = "Transient",
        inversion = "c_gb_motley",
        atlas = "crossmod_consumables",
        config = {
            select = 3
        },
        pos = {x=8,y=4},
        --soul_pos = { x = 5, y = 0},
        use = function(self, card, area, copier)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            local ability = pseudorandom_element(G.P_JOKER_RARITY_POOLS[1], pseudoseed("entr_trickster"))
            Entropy.FlipThen(cards, function(card)
                card:set_ability(ability)
                card:set_edition("e_gb_temporary")
            end)
        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            return num > 0 and num <= card.ability.select
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local burn = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3012,
        key = "burn",
        set = "Transient",
        inversion = "c_gb_plasma",
        atlas = "crossmod_consumables",
        config = {
            select = 3
        },
        pos = {x=7,y=3},
        use = function(self, card, area, copier)
            local cards = {}; for i, v in pairs(G.hand.cards) do cards[#cards+1] = v end
            pseudoshuffle(cards, pseudoseed("entr_burn"))
            for i = 1, math.min(#cards, card.ability.select) do
                if cards[i] then
                    cards[i]:set_seal("entr_pink")
                    cards[i]:set_edition("e_gb_temporary")
                end
            end
        end,
        can_use = function(self, card)
            return #G.hand.cards > 0
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local escape = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3013,
        key = "escape",
        set = "Transient",
        inversion = "c_gb_portal",
        atlas = "crossmod_consumables",
        config = {
            select = 3
        },
        pos = {x=6,y=3},
        use = function(self, card, area, copier)
            local cards = {}; for i, v in pairs(G.hand.cards) do cards[#cards+1] = v end
            pseudoshuffle(cards, pseudoseed("entr_burn"))
            for i = 1, math.min(#cards, card.ability.select) do
                if cards[i] then
                    Entropy.randomise_once(card)
                    cards[i]:set_edition("e_gb_temporary")
                end
            end
        end,
        can_use = function(self, card)
            return #G.hand.cards > 0
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local decay = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3014,
        key = "gbdecay",
        set = "Transient",
        inversion = "c_gb_rust",
        atlas = "crossmod_consumables",
        config = {
            select = 2
        },
        pos = {x=9,y=2},
        use = function(self, card, area, copier)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            Entropy.FlipThen(cards, function(card)
                card:set_ability(G.P_CENTERS.m_steel)
                card:set_edition("e_gb_temporary")
            end)
        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            return num > 0 and num <= card.ability.select
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local visage = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3015,
        key = "visage",
        set = "Transient",
        inversion = "c_gb_sculpture",
        atlas = "crossmod_consumables",
        config = {
            select = 3
        },
        pos = {x=5,y=2},
        use = function(self, card, area, copier)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            Entropy.FlipThen(cards, function(card)
                card:set_ability(G.P_CENTERS.m_stone)
                card:set_edition("e_gb_temporary")
            end)
        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            return num > 0 and num <= card.ability.select
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local nebula = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3016,
        key = "nebula",
        set = "Transient",
        inversion = "c_gb_spark",
        atlas = "crossmod_consumables",
        config = {
            create = 3
        },
        pos = {x=6,y=4},
        use = function(self, card, area, copier)
            for i = 1, math.min(card.ability.create, 10) do
                SMODS.add_card{
                    area = G.consumables,
                    set = "CBlind",
                    edition = "e_gb_temporary"
                }
            end
        end,
        can_use = function(self, card)
            return G.GAME.blind.in_blind
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.create}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local essence = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3017,
        key = "essence",
        set = "Transient",
        inversion = "c_gb_spirit",
        atlas = "crossmod_consumables",
        config = {
            select = 3
        },
        pos = {x=10,y=2},
        use = function(self, card, area, copier)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            Entropy.FlipThen(cards, function(card)
                SMODS.change_base(card, nil, "King")
                Entropy.randomize_rank_suit(card, nil, true, "entr_essence")
                card:set_edition("e_gb_temporary")
            end)
        end,
        can_use = function(self, card)
            local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
            return num > 0 and num <= card.ability.select
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local manifest = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3018,
        key = "manifest",
        set = "Transient",
        inversion = "c_gb_vanish",
        atlas = "crossmod_consumables",
        config = {
            size = 2
        },
        pos = {x=5 ,y=4},
        use = function(self, card, area, copier)
            G.GAME.vanish_selection_limit = (G.GAME.vanish_selection_limit or 0) + card.ability.size
            Entropy.ChangeFullCSL(card.ability.size)
        end,
        can_use = function(self, card)
            return G.GAMe.blind.in_blind
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.size}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    local hope = {
        dependencies = {
            items = {
              "set_entr_inversions",
            }
        },
        object_type = "Consumable",
        order = 3019,
        key = "hope",
        set = "Transient",
        inversion = "c_gb_wish",
        atlas = "crossmod_consumables",
        config = {
            select = 3
        },
        pos = {x=7,y=3},
        use = function(self, card, area, copier)
            local cards = {}; for i, v in pairs(G.hand.cards) do cards[#cards+1] = v end
            pseudoshuffle(cards, pseudoseed("entr_burn"))
            for i = 1, math.min(#cards, card.ability.select) do
                if cards[i] then
                    cards[i]:set_seal("entr_silver")
                    cards[i]:set_edition("e_gb_temporary")
                end
            end
        end,
        can_use = function(self, card)
            return #G.hand.cards > 0
        end,
        loc_vars = function(self, q, card)
            return {vars = {card.ability.select, colours = {SMODS.Seal.obj_table["entr_silver"].badge_colour}}}
        end,
        demicoloncompat = true,
        force_use = function(self, card) self:use(card) end
    }

    return {
        items = {
            splinter,
            dream,
            mini,
            sharp,
            vantablack,
            void,
            sharpen,
            singularity,

            cage,
            implode,
            meteor,
            concentrate,
            pyrite,
            set,
            trickster,
            sundial,
            candle,
            faith,
            oasis,
            ragtag,
            burn,
            escape,
            decay,
            visage,
            nebula,
            essence,
            manifest,
            hope
        }
    }
end
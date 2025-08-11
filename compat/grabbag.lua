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
                math.min(card.ability.create, 100)
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
    return {
        items = {
            splinter,
            dream,
            mini,
            sharp,
            vantablack,
            void,
            sharpen,
            singularity
        }
    }
end
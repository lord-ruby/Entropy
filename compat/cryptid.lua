if SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load then
    Cryptid.pointerblistifytype("rarity", "entr_entropic")
    Cryptid.pointerblistify("c_entr_define")
    for i, v in pairs(G.P_BLINDS) do
        Cryptid.pointerblistify(i)
    end
    
    for i, v in pairs(SMODS.Blind.obj_table) do
        Cryptid.pointerblistify(i)
    end
    Entropy.load_table({
        compat = {
            cryptid = {
                ".*"
            }
        }
    })

    Cryptid.edeck_sprites.seal.entr_cerulean = {atlas="entr_crypt_deck", pos = {x=0,y=0}}
    Cryptid.edeck_sprites.seal.entr_sapphire = {atlas="entr_crypt_deck", pos = {x=1,y=0}}
    Cryptid.edeck_sprites.seal.entr_verdant = {atlas="entr_crypt_deck", pos = {x=3,y=0}}
    Cryptid.edeck_sprites.seal.entr_silver = {atlas="entr_crypt_deck", pos = {x=4,y=0}}
    Cryptid.edeck_sprites.seal.entr_pink = {atlas="entr_crypt_deck", pos = {x=5,y=0}}
    Cryptid.edeck_sprites.seal.entr_crimson = {atlas="entr_crypt_deck", pos = {x=6,y=0}}
    Cryptid.edeck_sprites.seal.entr_ornate = {atlas="entr_crypt_deck", pos = {x=2,y=4}}
    Cryptid.edeck_sprites.seal.entr_amber = {atlas="entr_crypt_deck", pos = {x=3,y=4}}
    Cryptid.edeck_sprites.edition.entr_solar = {atlas="entr_crypt_deck", pos = {x=2,y=0}}
    Cryptid.edeck_sprites.edition.entr_sunny = {atlas="entr_crypt_deck", pos = {x=0,y=2}}
    Cryptid.edeck_sprites.edition.entr_fractured = {atlas="entr_crypt_deck", pos = {x=1,y=2}}
    Cryptid.edeck_sprites.edition.entr_freaky = {atlas="entr_crypt_deck", pos = {x=2,y=2}}
    Cryptid.edeck_sprites.edition.entr_neon = {atlas="entr_crypt_deck", pos = {x=0,y=3}}
    Cryptid.edeck_sprites.edition.entr_lowres = {atlas="entr_crypt_deck", pos = {x=1,y=3}}
    Cryptid.edeck_sprites.edition.entr_kaleidoscopic = {atlas="entr_crypt_deck", pos = {x=0,y=4}}
    Cryptid.edeck_sprites.suit.entr_nilsuit = {atlas="entr_crypt_deck", pos = {x=0,y=1}}
    Cryptid.edeck_sprites.enhancement.m_entr_flesh = {atlas="entr_crypt_deck", pos = {x=1,y=1}}
    Cryptid.edeck_sprites.enhancement.m_entr_disavowed = {atlas="entr_crypt_deck", pos = {x=2,y=1}}
    Cryptid.edeck_sprites.enhancement.m_entr_prismatic = {atlas="entr_crypt_deck", pos = {x=3,y=1}}
    Cryptid.edeck_sprites.enhancement.m_entr_dark = {atlas="entr_crypt_deck", pos = {x=3,y=2}}
    Cryptid.edeck_sprites.enhancement.m_entr_ceramic = {atlas="entr_crypt_deck", pos = {x=1,y=4}}
    Cryptid.edeck_sprites.enhancement.m_entr_ethereal = {atlas="entr_crypt_deck", pos = {x=4,y=4}}
    Cryptid.edeck_sprites.enhancement.m_entr_samsara = {atlas="entr_crypt_deck", pos = {x=5,y=4}}
    Cryptid.edeck_sprites.sticker.entr_pinned = {atlas="entr_crypt_deck", pos = {x=4,y=1}}
    Cryptid.edeck_sprites.sticker.entr_hotfix = {atlas="entr_crypt_deck", pos = {x=5,y=1}}
    Cryptid.edeck_sprites.sticker.entr_pseudorandom = {atlas="entr_crypt_deck", pos = {x=6,y=1}}
    Cryptid.edeck_sprites.sticker.link = {atlas="entr_crypt_deck", pos = {x=4,y=2}}
    Cryptid.edeck_sprites.sticker.desync = {atlas="entr_crypt_deck", pos = {x=5,y=2}}
    Cryptid.edeck_sprites.sticker.temporary = {atlas="entr_crypt_deck", pos = {x=6,y=2}}
    Cryptid.edeck_sprites.sticker.entr_aleph = {atlas="entr_crypt_deck", pos = {x=4,y=3}}
    Cryptid.edeck_sprites.sticker.scarred = {atlas="entr_crypt_deck", pos = {x=5,y=3}}
    Cryptid.edeck_sprites.sticker.entr_pure = {atlas="entr_crypt_deck", pos = {x=6,y=3}}
    Cryptid.edeck_sprites.sticker.entr_yellow_sign = {atlas="entr_crypt_deck", pos = {x=3,y=3}}
    Cryptid.edeck_sprites.sticker.superego = {atlas="entr_crypt_deck", pos = {x=2,y=3}}


    Entropy.Voucher{
        dependencies = {
            items = {
              "set_entr_vouchers",
              "set_entr_inversions",
              "set_cry_tier3"
            }
        },
        order = -2000+2,
        key = "supersede",
        atlas = "vouchers",
        pos = {x=2, y=0},
        requires = {"v_entr_trump_card"},
        redeem = function(self, card)
            G.GAME.Supersede = true
        end,
        unredeem = function(self, card) 
            G.GAME.Supersede = nil
        end,
        loc_vars = function(self, info_queue, card)
        end,
        entr_credits = {
            art = {"Grahkon"}
        }
    }
    Entropy.Voucher{
        dependencies = {
            items = {
              "set_entr_vouchers",
              "set_entr_runes",
              "set_cry_tier3"
            }
        },
        order = -2000+5,
        key = "ascension",
        atlas = "vouchers",
        pos = {x=2, y=1},
        requires = {"v_entr_providence"},
        calculate = function(self, card, context)
            if context.end_of_round then card.ability.used = nil end
            if context.using_consumeable and context.consumeable and (context.consumeable.config.center.set == "Rune" or context.consumeable.config.center.set == "Pact") and not card.ability.used then
                local copy = copy_card(context.consumeable)
                copy:add_to_deck()
                G.consumeables:emplace(copy)
                card.ability.used = true
                card_eval_status_text(
                    context.consumeable,
                    "extra",
                    nil,
                    nil,
                    nil,
                    { message = localize("k_copied_ex"), colour = G.C.PURPLE }
                )
            end
        end,
        entr_credits = {
            art = {"Lil. Mr. Slipstream"}
        }
    }
    items[#items+1]=supersede
    items[#items+1]=ascension

    Entropy.rare_tag("cry_epic", "epic", true, "cry_epic", {x=1,y=0}, 0, nil,4)
    Entropy.rare_tag("cry_exotic", "exotic", true, "cry_exotic", {x=3,y=0}, 0, nil,6)
    Entropy.rare_tag("entr_entropic", "entropic", true, "cry_exotic", {x=4,y=0}, 0, nil,7)
    Entropy.edition_tag("e_cry_glass", "glass", true, {x=5,y=1},10.5)
    Entropy.edition_tag("e_cry_glitched", "glitched", true, {x=0,y=2},12)
    Entropy.edition_tag("e_cry_gold", "gold", true, {x=1,y=2},13)
    Entropy.edition_tag("e_cry_blur", "blurry", true, {x=2,y=2},14)
    Entropy.edition_tag("e_cry_m", "m", true, {x=3,y=2},15)
    Entropy.edition_tag("e_cry_mosaic", "mosaic", true, {x=4,y=2},16)
    Entropy.edition_tag("e_cry_astral", "astral", true, {x=5,y=2},17)
    Entropy.edition_tag("e_cry_oversat", "oversat", true, {x=0,y=3},18)
    Entropy.Tag{
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 10,
        shiny_atlas="entr_shiny_ascendant_tags",
        key = "ascendant_saint",
        atlas = "ascendant_tags",
        pos = {x=0,y=1},
        config = { type = "store_joker_create" },
        in_pool = function() return false end or nil,
        loc_vars = function(self, info_queue, tag)
        end,
        apply = function(self, tag, context)
            if context.type == "store_joker_create" then
                local card = create_card("Joker", context.area, nil, "cry_candy", nil, nil, nil, "entr_saint")
                create_shop_card_ui(card, "Joker", context.area)
                card.states.visible = false
                tag:yep("+", G.C.GREEN, function()
                    card:start_materialize()
                    card.ability.couponed = true
                    card:set_edition(SMODS.poll_edition({guaranteed = true, key = "entr_saint"}))
                    card:set_cost()
                    return true
                end)
                tag.triggered = true
                return card
            end
        end,
        shiny_atlas = "entr_shiny_asc_tags",
    }

    Entropy.Tag{
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 11,
        shiny_atlas="entr_shiny_ascendant_tags",
        key = "ascendant_better_voucher",
        atlas = "ascendant_tags",
        pos = {x=6,y=1},
        config = { type = "voucher_add" },
        in_pool = function() return false end or nil,
        loc_vars = function(self, info_queue)
            return { vars = { (SMODS.Mods["Tier3Sub"] and 4 or 3) } }
        end,
        apply = function(self, tag, context)
            if context.type == "voucher_add" then
                tag:yep("+", G.C.SECONDARY_SET.Voucher, function()
                    SMODS.add_voucher_to_shop(Cryptid.next_tier3_key(true), true)
                    SMODS.add_voucher_to_shop(Cryptid.next_tier3_key(true), true)
                    return true
                end)
                tag.triggered = true
            end
        end,
        shiny_atlas = "entr_shiny_asc_tags",
    }

    Entropy.Tag{
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 21,
        shiny_atlas="entr_shiny_ascendant_tags",
        atlas = "ascendant_tags",
        pos = { x = 2, y = 3 },
        config = { level = 1 },
        key = "ascendant_cat",
        name = "entr-Ascendant-Cat Tag",
        loc_vars = function(self, info_queue, tag)
            return { vars = { tag.ability and tag.ability.level or 1 } }
        end,
        level_func = function(level,one,tag)
            tag.ability.level2 = (tag.ability.level2 or 0) + 1
            return level * 2
        end,
        set_ability = function(self, tag)
            tag.ability.level2 = (tag.ability.level2 or 0) + 1
            tag.level_func = self.level_func
            tag.get_edition = function(tag)
                return G.P_CENTER_POOLS.Edition[(tag.ability.level2%#G.P_CENTER_POOLS.Edition)+1]
            end
            tag.hover_sound = function() return 'cry_meow'..math.random(4) end
        end,
        in_pool = function() return false end,
        shiny_atlas = "entr_shiny_asc_tags",
    }

    Entropy.Tag{
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 23,
        shiny_atlas="entr_shiny_ascendant_tags",
        key = "ascendant_canvas",
        atlas = "ascendant_tags",
        pos = {x=4,y=3},
        config = { type = "store_joker_create" },
        in_pool = function() return false end or nil,
        apply = function(self, tag, context)
            if context.type == "store_joker_create" then
                local card
                if not G.GAME.banned_keys["j_cry_canvas"] then
                    card = create_card("Joker", context.area, nil, nil, nil, nil, "j_cry_canvas")
                    create_shop_card_ui(card, "Joker", context.area)
                    card.states.visible = false
                    tag:yep("+", G.C.RED, function()
                        card:start_materialize()
                        card:set_cost()
                        return true
                    end)
                else
                    tag:nope()
                end
                tag.triggered = true
                return card
            end
        end,
        shiny_atlas = "entr_shiny_asc_tags",
    }

    Entropy.Tag{
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 24,
        shiny_atlas="entr_shiny_ascendant_tags",
        key = "ascendant_unbounded",
        atlas = "ascendant_tags",
        pos = {x=5,y=3},
        config = { type = "new_blind_choice" },
        in_pool = function() return false end or nil,
        loc_vars = function(self, info_queue)
            info_queue[#info_queue + 1] = G.P_CENTERS.p_spectral_normal_1
            info_queue[#info_queue + 1] = { set = "Spectral", key = "c_cry_pointer" }
            info_queue[#info_queue + 1] = G.P_CENTERS.c_entr_beyond
        end,
        apply = function(self, tag, context)
            if context.type == "new_blind_choice" then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                tag:yep("+", G.C.SECONDARY_SET.Spectral, function()
                    local key = "p_entr_unbounded"
                    local card = Card(
                        G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                        G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                        G.CARD_W * 1.27,
                        G.CARD_H * 1.27,
                        G.P_CARDS.empty,
                        G.P_CENTERS[key],
                        { bypass_discovery_center = true, bypass_discovery_ui = true }
                    )
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({ config = { ref_table = card } })
                    if G.GAME.modifiers.cry_force_edition and not G.GAME.modifiers.cry_force_random_edition then
                        card:set_edition(nil, true, true)
                    elseif G.GAME.modifiers.cry_force_random_edition then
                        local edition = Cryptid.poll_random_edition()
                        card:set_edition(edition, true, true)
                    end
                    card:start_materialize()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end,
        shiny_atlas = "entr_shiny_asc_tags",
    }

    SMODS.Booster{
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 94,
        shiny_atlas="entr_shiny_ascendant_tags",
        key = "unbounded",
        set = "Booster",
        config = { extra = 2, choose = 1 },
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.choose,
                    card.ability.extra,
                    colours = {
                        HEX("FF0000")
                    }
                },
            }
        end,
        atlas = 'booster', pos = { x = 4, y = 0 },
        cost = 6,
        draw_hand = true,
        weight = 0,
        in_pool = function() return false end,
        draw_hand = true,
        update_pack = SMODS.Booster.update_pack,
        loc_vars = SMODS.Booster.loc_vars,
        ease_background_colour = function(self)
            ease_background_colour_blind(G.STATES.SPECTRAL_PACK)
        end,
        create_UIBox = function(self)
            return create_UIBox_spectral_pack()
        end,
        particles = function(self)
            G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
                timer = 0.015,
                scale = 0.1,
                initialize = true,
                lifespan = 3,
                speed = 0.2,
                padding = -1,
                attach = G.ROOM_ATTACH,
                colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
                fill = true,
            })
            G.booster_pack_sparkles.fade_alpha = 1
            G.booster_pack_sparkles:fade(1, 0)
        end,
        create_card = function(self, card, i)
            if
                i % 2 == 1
                and Cryptid.enabled("c_entr_beyond") == true
                and not G.GAME.banned_keys["c_entr_beyond"]
                and not (G.GAME.used_jokers["c_entr_beyond"] and not next(find_joker("Showman")))
            then
                return create_card("Spectral", G.pack_cards, nil, nil, true, true, "c_entr_beyond")
            elseif
                not (G.GAME.used_jokers["c_cry_pointer"] and not next(find_joker("Showman"))) and not G.GAME.banned_keys["c_cry_pointer"]
            then
                return create_card("Spectral", G.pack_cards, nil, nil, true, true, "c_cry_pointer")
            else
                return create_card("Spectral", G.pack_cards, nil, nil, true, true)
            end
        end,
        hidden = true,
        group_key = "k_spectral_pack",
        cry_digital_hallucinations = {
            colour = G.C.SECONDARY_SET.Spectral,
            loc_key = "k_plus_spectral",
            create = function()
                local ccard
                if pseudorandom(pseudoseed("diha")) < 0.5 then
                    ccard = create_card("Spectral", G.consumeables, nil, nil, true, true, "c_cry_pointer")
                else
                    ccard = create_card("Spectral", G.consumeables, nil, nil, true, true, "c_entr_beyond")
                end
                ccard:set_edition({ negative = true }, true)
                ccard:add_to_deck()
                G.consumeables:emplace(ccard)
            end,
        },
        shiny_atlas = "entr_shiny_asc_tags",
    }

    Entropy.Tag{
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 27,
        shiny_atlas="entr_shiny_ascendant_tags",
        key = "ascendant_ebundle",
        atlas = "ascendant_tags",
        pos = {x=1,y=4},
        config = { type = "new_blind_choice" },
        in_pool = function() return false end or nil,
        loc_vars = function(self, info_queue,tag)
            info_queue[#info_queue + 1] = { set = "Tag", key = "tag_ethereal" }
            info_queue[#info_queue + 1] = { set = "Tag", key = "tag_cry_console" }
            info_queue[#info_queue + 1] = { set = "Tag", key = "tag_entr_ascendant_twisted" }
            info_queue[#info_queue + 1] = { set = "Tag", key = "tag_cry_bundle" }
        end,
        apply = function(self, tag, context)
            if context.type == "new_blind_choice" then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                tag:yep("+", G.C.ATTENTION, function()
                    local tags = { "ethereal", "cry_console", "entr_ascendant_twisted", "cry_bundle" }
                    for i, v in ipairs(tags) do
                        local _tag = Tag("tag_" .. v, true)
                        _tag.ability.shiny = Cryptid.is_shiny()
                        add_tag(_tag)
                        _tag.ability.no_asc = true
                        if i == 1 then
                            tag.triggered = true
                        end
                    end
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end,
        shiny_atlas = "entr_shiny_asc_tags",
    }

    Entropy.Tag{
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 30,
        shiny_atlas="entr_shiny_ascendant_tags",
        key = "ascendant_reference",
        atlas = "ascendant_tags",
        pos = {x=5,y=4},
        config = { type = "new_blind_choice" },
        in_pool = function() return false end or nil,
        loc_vars = function(self, info_queue)
            info_queue[#info_queue + 1] = G.P_CENTERS.p_entr_reference
        end,
        apply = function(self, tag, context)
            if context.type == "new_blind_choice" then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                tag:yep("+", G.C.SECONDARY_SET.Spectral, function()
                    local key = "p_entr_reference_pack"
                    local card = Card(
                        G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                        G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                        G.CARD_W * 1.27,
                        G.CARD_H * 1.27,
                        G.P_CARDS.empty,
                        G.P_CENTERS[key],
                        { bypass_discovery_center = true, bypass_discovery_ui = true }
                    )
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({ config = { ref_table = card } })
                    if G.GAME.modifiers.cry_force_edition and not G.GAME.modifiers.cry_force_random_edition then
                        card:set_edition(nil, true, true)
                    elseif G.GAME.modifiers.cry_force_random_edition then
                        local edition = Cryptid.poll_random_edition()
                        card:set_edition(edition, true, true)
                    end
                    card:start_materialize()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end,
        shiny_atlas = "entr_shiny_asc_tags",
    }

    SMODS.Booster{
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 96,
        shiny_atlas="entr_shiny_ascendant_tags",
        key = "reference_pack",
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
        atlas = 'booster', pos = { x = 5, y = 0 },
        group_key = "k_reference_pack",
        cost = 8,
        draw_hand = true,
        weight = 0,
        in_pool = function() return false end,
        hidden = true,
        kind = "Joker",
        create_card = function (self, card, i) 
            return create_card("Reference", area or G.pack_cards, nil, nil, true, true, nil, "reference")
        end,
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, G.C.BLUE)
            ease_background_colour({ new_colour = G.C.RED, special_colour = G.C.BLUE, contrast = 2 })
        end,
        cry_digital_hallucinations = {
            colour = G.C.GREEN,
            loc_key = "k_reference_pack",
            create = function()
                local ccard = create_card("Reference", area or G.pack_cards, nil, nil, true, true, nil, "reference")
                ccard:set_edition({ negative = true }, true)
                ccard:add_to_deck()
                G.jokers:emplace(ccard)
            end,
        },
    }

    Entropy.Tag{
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 31,
        shiny_atlas="entr_shiny_ascendant_tags",
        key = "ascendant_cavendish",
        atlas = "ascendant_tags",
        pos = {x=0,y=5},
        config = { type = "immediate" },
        in_pool = function() return false end or nil,
        loc_vars = function(self, info_queue,tag)
            info_queue[#info_queue + 1] = {
                set = "Joker",
                key = "j_cavendish",
                specific_vars = { 3, G.GAME.probabilities.normal or 1, 1000 },
            }
        end,
        apply = function(self, tag, context)
            if context.type == "immediate" then
                tag:yep("+", G.C.GOLD, function()
                    local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cavendish")
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    return true
                end)
                tag.triggered = true
                return true
            end
        end,
        shiny_atlas = "entr_shiny_asc_tags",
    }
    Entropy.Tag{
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 34,
        shiny_atlas="entr_shiny_ascendant_tags",
        key = "ascendant_better_topup",
        atlas = "ascendant_tags",
        pos = {x=3,y=5},
        config = { type = "immediate" },
        in_pool = function() return false end or nil,
        loc_vars = function(self, info_queue,tag)
        end,
        apply = function(self, tag, context)
            if context.type == "immediate" then
                tag:yep("+", G.C.RED, function()
                    for i = 1, 3 do
                        if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                            local card = create_card("Joker", G.jokers, nil, 3, nil, nil, nil, "bettertop")
                            card:add_to_deck()
                            G.jokers:emplace(card)
                        end
                    end
                    return true
                end)
                tag.triggered = true
                return true
            end
        end,
        shiny_atlas = "entr_shiny_asc_tags",
    }

    Entropy.Tag{
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = 35,
        shiny_atlas="entr_shiny_ascendant_tags",
        key = "ascendant_booster",
        atlas = "ascendant_tags",
        pos = {x=4,y=5},
        config = { type = "immediate" },
        in_pool = function() return false end or nil,
        loc_vars = function(self, info_queue,tag)
        end,
        apply = function(self, tag, context)
            if context.type == "immediate" then
                tag:yep("+", G.C.GREEN, function()
                    for i = 1, 3 do
                        G.GAME.boostertag = (G.GAME.boostertag or 0) + 1.5
                    end
                    return true
                end)
                tag.triggered = true
                return true
            end
        end,
        shiny_atlas = "entr_shiny_asc_tags",
    }

    Entropy.Seal{
        dependencies = {
            items = {
            "set_entr_inversions"
            }
        },
        
        order = 3005,
        key="entr_verdant",
        atlas = "seals",
        pos = {x=4,y=0},
        badge_colour = HEX("75bb62"),
        calculate = function(self, card, context)
            if context.main_scoring and context.cardarea == G.play then
                local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
                G.FUNCS.get_poker_hand_info(G.play.cards)
                if #scoring_hand == 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if G.consumeables.config.card_count < G.consumeables.config.card_limit then
                                local c = create_card("Command", G.consumeables, nil, nil, nil, nil, nil) 
                                c:add_to_deck()
                                G.consumeables:emplace(c)
                            end
                            return true
                        end
                    }))
                end
            end
            if context.forcetrigger then
                local key = pseudorandom_element(Entropy.FlipsideInversions, pseudoseed("verdant"))
                while G.P_CENTERS[key].set ~= "Command" do key = pseudorandom_element(Entropy.FlipsideInversions, pseudoseed("verdant")) end
                local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
                c:add_to_deck()
                G.consumeables:emplace(c)
            end
        end,
    }

    Entropy.Seal{
        dependencies = {
            items = {
            "set_entr_inversions"
            }
        },
        
        order = 3006,
        key="entr_cerulean",
        atlas = "seals",
        pos = {x=5,y=0},
        badge_colour = HEX("4078e6"),
        calculate = function(self, card, context)
            if context.main_scoring and context.cardarea == G.play then
                local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
                G.FUNCS.get_poker_hand_info(G.play.cards)
                local pkey = "regulus"
                for i, v in pairs(Entropy.ReversePlanets) do
                    if v.name == text then pkey = v.new_key end
                end
                local key = "c_entr_"..pkey
                for i = 1, 3 do
                        local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
                        c:add_to_deck()
                        G.consumeables:emplace(c)
                        c:set_edition("e_negative")
                    end
                for i, v in pairs(scoring_hand) do
                    v.ability.temporary2 = true
                end
                SMODS.calculate_context({remove_playing_cards = true, removed=scoring_hand})
            end
            if context.forcetrigger then
                local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
                G.FUNCS.get_poker_hand_info(G.play.cards)
                local pkey = "pluto"
                for i, v in pairs(Entropy.ReversePlanets) do
                    if v.name == text then pkey = v.key end
                end
                local key = "c_entr_"..pkey
                for i = 1, 3 do
                    local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
                    c:add_to_deck()
                    G.consumeables:emplace(c)
                    c:set_edition("e_negative")
                end
            end
        end,
    }
elseif (SMODS.Mods["vallkarri"] or {}).can_load then
    Entropy.ValkarriOverCryptid = true
    Entropy.load_table({
        compat = {
            cryptid = {
                "epic_jokers",
                "exotic_jokers"
            }
        }
    })
    G.FUNCS.cry_asc_UI_set = function(e)
        e.config.object.colours = { Entropy.get_asc_colour(G.GAME.current_round.current_hand.cry_asc_num) }
        e.config.object:update_text()
    end    
    -- Needed because get_poker_hand_info isnt called at the end of the road
    local evaluateroundref = G.FUNCS.evaluate_round
    function G.FUNCS.evaluate_round()
        evaluateroundref()
        -- This is just the easiest way to check if its gold because lua is annoying
        if G.C.UI_CHIPS[1] == G.C.GOLD[1] then
            ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.3)
            ease_colour(G.C.UI_MULT, G.C.RED, 0.3)
        end
    end
elseif (SMODS.Mods["MyDreamJournal"] or {}).can_load then
    Entropy.MDJOverCryptid = true
    Entropy.load_table({
        compat = {
            cryptid = {
                "epic_jokers",
                "exotic_jokers"
            }
        }
    })
    local items = Entropy.collect_files(files)
    G.FUNCS.cry_asc_UI_set = function(e)
        e.config.object.colours = { Entropy.get_asc_colour(G.GAME.current_round.current_hand.cry_asc_num) }
        e.config.object:update_text()
    end    
    -- Needed because get_poker_hand_info isnt called at the end of the road
    local evaluateroundref = G.FUNCS.evaluate_round
    function G.FUNCS.evaluate_round()
        evaluateroundref()
        -- This is just the easiest way to check if its gold because lua is annoying
        if G.C.UI_CHIPS[1] == G.C.GOLD[1] then
            ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.3)
            ease_colour(G.C.UI_MULT, G.C.RED, 0.3)
        end
    end
else
    G.FUNCS.cry_asc_UI_set = function(e)
        e.config.object.colours = { Entropy.get_asc_colour(G.GAME.current_round.current_hand.cry_asc_num) }
        e.config.object:update_text()
    end    
    -- Needed because get_poker_hand_info isnt called at the end of the road
    local evaluateroundref = G.FUNCS.evaluate_round
    function G.FUNCS.evaluate_round()
        evaluateroundref()
        -- This is just the easiest way to check if its gold because lua is annoying
        if G.C.UI_CHIPS[1] == G.C.GOLD[1] then
            ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.3)
            ease_colour(G.C.UI_MULT, G.C.RED, 0.3)
        end
    end
end

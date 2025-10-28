if SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load then
    Cryptid.pointerblistifytype("rarity", "entr_entropic")
    Cryptid.pointerblistify("c_entr_define")
    for i, v in pairs(G.P_BLINDS) do
        Cryptid.pointerblistify(i)
    end
    
    for i, v in pairs(SMODS.Blind.obj_table) do
        Cryptid.pointerblistify(i)
    end
    
    local files = {
        "compat/cryptid/cursed_jokers",
        "compat/cryptid/define",
        "compat/cryptid/entropic_jokers",
        "compat/cryptid/epic_jokers",
        "compat/cryptid/exotic_jokers",
        "compat/cryptid/reverse_codes",
        "compat/cryptid/other_consumables",
        "compat/cryptid/misc_jokers",
    }
    local items = Entropy.collect_files(files)

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


local containment = {
    object_type = "Back",
    order = 7002,
    dependencies = {
      items = {
        "set_entr_decks"
      }
    },
      object_type = "Back",
      name = "Deck of Containment",
      key = "doc",
      pos = { x = 2, y = 0 },
      atlas = "decks",
      apply = function(self)
          G.GAME.entropy = 0
      end,
      calculate = function(self,back,context)
          if context.final_scoring_step and number_format(0.002 + (0.998^(G.GAME.entropy/2))) ~= "1" then
              if not ({
                  ["High Card"]=true,
                  ["Pair"]=true,
                  ["Three of a Kind"]=true,
                  ["Two Pair"]=true,
                  ["Four of a Kind"]=true,
                  ["Flush"]=true,
                  ["Straight"]=true,
                  ["Straight Flush"]=true,
                  ["Full House"]=true
              })[context.scoring_name] or to_big(G.GAME.hands[context.scoring_name].AscensionPower or 0) > to_big(0) then
                  ease_entropy(G.GAME.hands[context.scoring_name].level + (G.GAME.hands[context.scoring_name].AscensionPower or 0) or 1)
              end
              G.E_MANAGER:add_event(Event({
                  func = function()
                      play_sound("talisman_echip", 1)
                      attention_text({
                          scale = 1.4,
                          text = "^"..tostring(number_format(0.002 + (0.998^(G.GAME.entropy/2)))).." Chips",
                          hold = 2,
                          align = "cm",
                          offset = { x = 0, y = -2.7 },
                          major = G.play,
                      })
                      return true
                  end,
              }))
              return {
                  Echip_mod = 0.01 + (0.998^(G.GAME.entropy/2)),
                  colour = G.C.DARK_EDITION,
              }
          end
          if context.individual and context.cardarea == G.play then
              if context.other_card and (context.other_card.edition or context.other_card.ability.set == "Enhanced") then
                  if context.other_card.edition and context.other_card.ability.set == "Enhanced" then ease_entropy(2) else ease_entropy(1) end
              end
          end
        if context.after then
            for i, v in pairs(G.jokers.cards) do
                if v.edition and v.edition.key then ease_entropy(2) end
                if i > G.jokers.config.card_limit then ease_entropy(1) end
            end
        end
    end
  }
  if CardSleeves then
    CardSleeves.Sleeve {
        key = "doc",
        atlas = "sleeves",
        pos = { x = 2, y = 0 },
        apply = function()
        if G.GAME.selected_back and G.GAME.selected_back.effect.center.original_key == "doc" then
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                SMODS.add_card({
                rarity = "entr_entropic",
                area = G.jokers,
                set = "Joker",
                key_append = "entr_doc_combo"
                })
                return true
            end
            }))
        end
        end,
        calculate = function(self,back,context)
        if context.final_scoring_step and number_format(0.002 + (0.998^(G.GAME.entropy/2))) ~= "1" then
            if not ({
                ["High Card"]=true,
                ["Pair"]=true,
                ["Three of a Kind"]=true,
                ["Two Pair"]=true,
                ["Four of a Kind"]=true,
                ["Flush"]=true,
                ["Straight"]=true,
                ["Straight Flush"]=true,
                ["Full House"]=true
            })[context.scoring_name] or to_big(G.GAME.hands[context.scoring_name].AscensionPower or 0) > to_big(0) then
                ease_entropy(G.GAME.hands[context.scoring_name].level + (G.GAME.hands[context.scoring_name].AscensionPower or 0) or 1)
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("talisman_echip", 1)
                    attention_text({
                        scale = 1.4,
                        text = "^"..tostring(number_format(0.002 + (0.998^(G.GAME.entropy/2)))).." Chips",
                        hold = 2,
                        align = "cm",
                        offset = { x = 0, y = -2.7 },
                        major = G.play,
                    })
                    return true
                end,
            }))
            return {
                Echip_mod = 0.01 + (0.998^(G.GAME.entropy/2)),
                colour = G.C.DARK_EDITION,
            }
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card and (context.other_card.edition or context.other_card.ability.set == "Enhanced") then
                if context.other_card.edition and context.other_card.ability.set == "Enhanced" then ease_entropy(2) else ease_entropy(1) end
            end
        end
        if context.after then
            for i, v in pairs(G.jokers.cards) do
                if v.edition and v.edition.key then ease_entropy(2) end
                if i > G.jokers.config.card_limit then ease_entropy(1) end
            end
        end
    end
    }
    end

    local supersede = {
        dependencies = {
            items = {
              "set_entr_vouchers",
              "set_entr_inversions",
              "set_cry_tier3"
            }
        },
        object_type = "Voucher",
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
    local ascension = {
        dependencies = {
            items = {
              "set_entr_vouchers",
              "set_entr_runes",
              "set_cry_tier3"
            }
        },
        object_type = "Voucher",
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
    items[#items+1]=containment
    items[#items+1]=supersede
    items[#items+1]=ascension
  return {
    items = items
  }
elseif (SMODS.Mods["vallkarri"] or {}).can_load then
    Entropy.ValkarriOverCryptid = true
    local files = {
        "compat/cryptid/entropic_jokers",
        "compat/cryptid/epic_jokers",
        "compat/cryptid/exotic_jokers",
    }
    local items = Entropy.collect_files(files)
    G.FUNCS.cry_asc_UI_set = function(e)
        e.config.object.colours = { G.C.GOLD }
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
    return {
        items = items
    }
else
    G.FUNCS.cry_asc_UI_set = function(e)
        e.config.object.colours = { G.C.GOLD }
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
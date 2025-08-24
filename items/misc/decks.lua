local twisted = {
    object_type = "Back",
    order = 7000,
    dependencies = {
      items = {
        "set_entr_inversions",
        "set_entr_decks"
      }
    },
    name = "Twisted Deck",
    key = "twisted",
    pos = { x = 0, y = 0 },
    atlas = "decks",
    apply = function()
        G.GAME.modifiers.entr_twisted = true
    end
}

local redefined = {
    object_type = "Back",
    order = 7001,
    dependencies = {
      items = {
        "set_entr_decks"
      }
    },
    name = "CCD 2.0",
    key = "ccd2",
    pos = { x = 1, y = 0 },
    atlas = "decks",
    apply = function(self)
        G.GAME.modifiers.ccd2 = true
    end,
}


local destiny = {
  order = 7003,
  dependencies = {
    items = {
      "set_entr_decks"
    }
  },
  object_type = "Back",
  name = "Deck of Destiny",
  key = "crafting",
  pos = { x = 3, y = 0 },
  atlas = "decks",
  apply = function(self)
    G.GAME.modifiers.crafting = true
    if not G.GAME.JokerRecipes then G.GAME.JokerRecipes = {} end
    --G.hand.config.highlighted_limit = 
    G.GAME.joker_rate = 0
    if not G.GAME.banned_keys then G.GAME.banned_keys = {} end
    G.GAME.banned_keys["p_bufoon_normal_1"] = true
    G.GAME.banned_keys["p_bufoon_normal_2"] = true
    G.GAME.banned_keys["p_bufoon_jubmo_1"] = true
    G.GAME.banned_keys["p_bufoon_mega_1"] = true
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      func = function()
        local c = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_entr_destiny") 
        c.ability.cry_absolute = true
        c.ability.entr_aleph = true
        c.ability.eternal = true
        c:add_to_deck()
        G.consumeables:emplace(c)
        c:set_edition("e_negative")
        return true
      end}))
  end,
  config = { vouchers = { "v_magic_trick", "v_illusion" } },
  entr_credits = {
    art = {"Lil. Mr. Slipstream"}
  }
}


local ambisinister = {
  object_type = "Back",
  order = 7004,
  dependencies = {
    items = {
      "set_entr_decks"
    }
  },
  key = "ambisinister",
  pos = { x = 5, y = 0 },
  atlas = "decks",
  apply = function()
    G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + 3
    Entropy.last_csl = nil
    Entropy.last_slots = nil
  end
}

local butterfly = {
  object_type = "Back",
  order = 7005,
  dependencies = {
    items = {
      "set_entr_decks"
    }
  },
  config = { joker_slot = -2 },
  key = "butterfly",
  pos = { x = 4, y = 0 },
  atlas = "decks",
  loc_vars = function() 
    return {vars = {G.GAME.probabilities.normal or 1}}
  end
}

local gemstone = {
  object_type = "Back",
  order = 7006,
  dependencies = {
    items = {
      "set_entr_decks"
    }
  },
  config = { },
  key = "gemstone",
  pos = { x = 6, y = 0 },
  atlas = "decks",
  calculate = function(self, back, context)
    if context.using_consumeable and context.consumeable.config.center.set ~= "Rune" then
        G.GAME.gemstone_amount = (G.GAME.gemstone_amount or 0) + 1
        if G.GAME.gemstone_amount == 2 then
          G.GAME.gemstone_amount = 0
          G.E_MANAGER:add_event(Event{
            func = function()
              if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                SMODS.add_card{
                  set = "Rune",
                  area = G.consumeables,
                  key_append = "entr_gemstone_deck"
                }
              end
              return true
            end
          })
          return {
            message = "+1 "..localize("k_rune")
          }
        else
          return {
            message = G.GAME.gemstone_amount.."/2"
          }
        end
    end
  end
}

if CardSleeves then
    CardSleeves.Sleeve {
      key = "twisted",
      atlas = "sleeves",
      pos = { x = 0, y = 0 },
      apply = function()
        G.GAME.modifiers.entr_twisted = true
      end
    }
    CardSleeves.Sleeve {
      key = "ccd2",
      atlas = "sleeves",
      pos = { x = 1, y = 0 },
      apply = function()
        G.GAME.modifiers.ccd2 = true
      end
    }

    CardSleeves.Sleeve {
      key = "crafting",
      atlas = "sleeves",
      pos = { x = 3, y = 0 },
      config = { vouchers = { "v_magic_trick", "v_illusion" } },
      apply = function()
        G.GAME.modifiers.crafting = true
        if not G.GAME.JokerRecipes then G.GAME.JokerRecipes = {} end
        --G.hand.config.highlighted_limit = 
        G.GAME.joker_rate = 0
        if not G.GAME.banned_keys then G.GAME.banned_keys = {} end
        G.GAME.banned_keys["p_bufoon_normal_1"] = true
        G.GAME.banned_keys["p_bufoon_normal_2"] = true
        G.GAME.banned_keys["p_bufoon_jubmo_1"] = true
        G.GAME.banned_keys["p_bufoon_mega_1"] = true
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          func = function()
            local c = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_entr_destiny") 
            c.ability.cry_absolute = true
            c.ability.entr_aleph = true
            c.ability.eternal = true
            c:add_to_deck()
            G.consumeables:emplace(c)
            c:set_edition("e_negative")
            return true
          end}))
      end
    }

  CardSleeves.Sleeve {
    key = "ambisinister",
    atlas = "sleeves",
    pos = { x = 4, y = 0 },
    config = {joker_slot=3},
    apply = function()
      G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + 3
      Entropy.last_csl = nil
      Entropy.last_slots = nil
    end
  }


  CardSleeves.Sleeve {
    key = "butterfly",
    atlas = "sleeves",
    pos = { x = 5, y = 0 },
    apply = function()
      G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots - 2
    end,
    loc_vars = function() 
      return {vars = {G.GAME.probabilities.normal or 1}}
    end
  }

  CardSleeves.Sleeve {
    key = "gemstone",
    atlas = "sleeves",
    pos = { x = 6, y = 0 },
    calculate = function(self, back, context)
      if context.using_consumeable and context.consumeable.config.center.set ~= "Rune" then
          G.GAME.gemstone_amount = (G.GAME.gemstone_amount or 0) + 1
          if G.GAME.gemstone_amount == 2 then
            G.GAME.gemstone_amount = 0
            G.E_MANAGER:add_event(Event{
              func = function()
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                  SMODS.add_card{
                    set = "Rune",
                    area = G.consumeables,
                    key_append = "entr_gemstone_deck"
                  }
                end
                return true
              end
            })
            return {
              message = "+1 "..localize("k_rune")
            }
          else
            return {
              message = G.GAME.gemstone_amount.."/2"
            }
          end
      end
    end
  }
end

return {
    items = {
      twisted,
      redefined,
      containment,
      destiny,
      ambisinister,
      butterfly,
      gemstone
    }
  }
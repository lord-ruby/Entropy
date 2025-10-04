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

local update_ref = Card.update
function Card:update(dt, ...)
    if self.ability.glitched_crown then
      if not self.glitched_dt then
        local soul_layer
        for i, v in pairs(self.ability.glitched_crown) do
          if G.P_CENTERS[v].soul_pos then soul_layer = true end
        end
        if soul_layer and not self.children.floating_sprite then
          local _center = G.P_CENTERS[self.ability.glitched_crown[1]]
          self.children.floating_sprite = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center[G.SETTINGS.colourblind_option and 'hc_atlas' or 'lc_atlas'] or _center.atlas or _center.set], self.config.center.soul_pos or {x=9999,y=9999})
          self.children.floating_sprite.role.draw_major = self
          self.children.floating_sprite.states.hover.can = false
          self.children.floating_sprite.states.click.can = false
        end
      end
      self.glitched_dt = (self.glitched_dt or 0) + dt
      if self.glitched_dt > 3 / #self.ability.glitched_crown then
          self.glitched_dt = 0
          self.glitched_index = 1 + (self.glitched_index or 1)
          if self.glitched_index > #self.ability.glitched_crown then self.glitched_index = 1 end
          local _center = G.P_CENTERS[self.ability.glitched_crown[self.glitched_index]]
          self.children.center.atlas = G.ASSET_ATLAS[(_center.atlas or (_center.set == 'Joker' or _center.consumeable or _center.set == 'Voucher') and _center.set) or 'centers']
          self.children.center:set_sprite_pos(_center.pos)
          if self.children.floating_sprite then
            self.children.floating_sprite.atlas = G.ASSET_ATLAS[_center[G.SETTINGS.colourblind_option and 'hc_atlas' or 'lc_atlas'] or _center.atlas or _center.set]
            self.children.floating_sprite:set_sprite_pos(_center.soul_pos or {x=9999,y=9999})
          end
          if self.states.hover.is then
              self:stop_hover()
              self:hover()
          end
      end
    end
    return update_ref(self, dt, ...)
end

local generate_UIBox_ability_tableref = Card.generate_UIBox_ability_table
function Card:generate_UIBox_ability_table(vars_only)
    if self.ability.glitched_crown then
        local a = self.ability
        local conf = self.config.center
        local center = G.P_CENTERS[self.ability.glitched_crown[self.glitched_index]]
        self.ability = center.config
        self.config.center = center
        self.ability.name = center.name
        self.ability.set = center.set
        local ret = generate_UIBox_ability_tableref(self, vars_only)
        self.ability = a
        self.config.center = conf
        return ret
    else
        return generate_UIBox_ability_tableref(self, vars_only)
    end
end

local get_type_colourref = get_type_colour
function get_type_colour(_c, card)
    if card.ability and card.ability.glitched_crown then
        return get_type_colourref(G.P_CENTERS[card.ability.glitched_crown[card.glitched_index]], card)
    end
    return get_type_colourref(_c, card)
end

local can_use_ref = G.FUNCS.can_use_consumeable
G.FUNCS.can_use_consumeable = function(e)
  local card = e.config.ref_table
  if card.ability.glitched_crown and G.P_CENTERS[card.ability.glitched_crown[card.glitched_index]] then
    if Card.can_use_consumeable(Entropy.GetDummy(G.P_CENTERS[card.ability.glitched_crown[card.glitched_index]], card.area, card)) then
      e.config.colour = G.C.RED
      e.config.button = 'use_card'
    else
      e.config.colour = G.C.UI.BACKGROUND_INACTIVE
      e.config.button = nil
    end
  else
    can_use_ref(e)
  end
end

local buy_and_use_ref = G.FUNCS.can_buy_and_use
G.FUNCS.can_buy_and_use = function(e)
  local card = e.config.ref_table
  if card.ability.glitched_crown and G.P_CENTERS[card.ability.glitched_crown[card.glitched_index]] then
    if (((e.config.ref_table.cost > G.GAME.dollars - G.GAME.bankrupt_at) and (e.config.ref_table.cost > 0)) or (not Card.can_use_consumeable(Entropy.GetDummy(G.P_CENTERS[card.ability.glitched_crown[card.glitched_index]], card.area, card)))) then
        e.UIBox.states.visible = false
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        if e.config.ref_table.highlighted then
          e.UIBox.states.visible = true
        end
        e.config.colour = G.C.SECONDARY_SET.Voucher
        e.config.button = 'buy_from_shop'
    end
  else  
    buy_and_use_ref(e)
  end
end

local corrupted = {
  object_type = "Back",
  order = 7006,
  dependencies = {
    items = {
      "set_entr_decks"
    }
  },
  config = { },
  key = "corrupted",
  pos = { x = 4, y = 0 },
  atlas = "decks",
  apply = function()
    G.GAME.modifiers.glitched_items = 3
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
      gemstone,
      corrupted
    }
  }
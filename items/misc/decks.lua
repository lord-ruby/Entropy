local twisted = {
    object_type = "Back",
    order = 0,
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
    order = 1,
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

local containment = {
    object_type = "Back",
    order = 2,
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
          if context.final_scoring_step and to_big(G.GAME.entropy) > to_big(1) then
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
              })[context.scoring_name] or (G.GAME.hands[context.scoring_name].AscensionPower or 0) > 0 then
                  ease_entropy(G.GAME.hands[context.scoring_name].level + (G.GAME.hands[context.scoring_name].AscensionPower or 0) or 1)
              end
              G.E_MANAGER:add_event(Event({
                  func = function()
                      play_sound("talisman_echip", 1)
                      attention_text({
                          scale = 1.4,
                          text = "^"..tostring(number_format(0.002 + (0.998^G.GAME.entropy))).." Chips",
                          hold = 2,
                          align = "cm",
                          offset = { x = 0, y = -2.7 },
                          major = G.play,
                      })
                      return true
                  end,
              }))
              return {
                  Echip_mod = 0.01 + (0.99^G.GAME.entropy),
                  colour = G.C.DARK_EDITION,
              }
          end
          if context.individual and context.cardarea == G.play then
              if context.other_card and (context.other_card.edition or context.other_card.ability.set == "Enhanced") then
                  if context.other_card.edition and context.other_card.ability.set == "Enhanced" then ease_entropy(4) else ease_entropy(2) end
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

Cryptid.edeck_sprites.seal.entr_cerulean = {atlas="entr_crypt_deck", pos = {x=0,y=0}}
Cryptid.edeck_sprites.seal.entr_sapphire = {atlas="entr_crypt_deck", pos = {x=1,y=0}}
Cryptid.edeck_sprites.seal.entr_verdant = {atlas="entr_crypt_deck", pos = {x=3,y=0}}
Cryptid.edeck_sprites.seal.entr_silver = {atlas="entr_crypt_deck", pos = {x=4,y=0}}
Cryptid.edeck_sprites.seal.entr_pink = {atlas="entr_crypt_deck", pos = {x=5,y=0}}
Cryptid.edeck_sprites.seal.entr_crimson = {atlas="entr_crypt_deck", pos = {x=6,y=0}}
Cryptid.edeck_sprites.edition.entr_solar = {atlas="entr_crypt_deck", pos = {x=2,y=0}}
Cryptid.edeck_sprites.edition.entr_solar = {atlas="entr_crypt_deck", pos = {x=2,y=0}}
Cryptid.edeck_sprites.suit.entr_nilsuit = {atlas="entr_crypt_deck", pos = {x=0,y=1}}
Cryptid.edeck_sprites.enhancement.m_entr_flesh = {atlas="entr_crypt_deck", pos = {x=1,y=1}}
Cryptid.edeck_sprites.enhancement.m_entr_disavowed = {atlas="entr_crypt_deck", pos = {x=2,y=1}}


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
      key = "doc",
      atlas = "sleeves",
      pos = { x = 2, y = 0 },
      calculate = function(self,back,context)
        if context.final_scoring_step and to_big(G.GAME.entropy) > to_big(1) then
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
          })[context.scoring_name] or (G.GAME.hands[context.scoring_name].AscensionPower or 0) > 0 then
            ease_entropy(G.GAME.hands[context.scoring_name].level + (G.GAME.hands[context.scoring_name].AscensionPower or 0) or 1)
          end
          G.E_MANAGER:add_event(Event({
            func = function()
              play_sound("talisman_echip", 1)
              attention_text({
                scale = 1.4,
                text = "^"..tostring(number_format(0.002 + (0.998^G.GAME.entropy))).." Chips",
                hold = 2,
                align = "cm",
                offset = { x = 0, y = -2.7 },
                major = G.play,
              })
              return true
            end,
          }))
          return {
            Echip_mod = 0.01 + (0.99^G.GAME.entropy),
            colour = G.C.DARK_EDITION,
          }
        end
        if context.individual and context.cardarea == G.play then
          if context.other_card and (context.other_card.edition or context.other_card.ability.set == "Enhanced") then
            if context.other_card.edition and context.other_card.ability.set == "Enhanced" then ease_entropy(4) else ease_entropy(2) end
          end
        end
        if context.final_scoring_step then
          for i, v in pairs(G.jokers.cards) do
            if v.edition and v.edition.key then ease_entropy(2) end
            if i > G.jokers.config.card_limit then ease_entropy(1) end
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
    }
  }
SMODS.Atlas { key = 'decks', path = 'decks.png', px = 71, py = 95 }
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
}

local matref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
  local Jumbos = {
    p_buffoon_normal_1="p_standard_mega_1",
    p_buffoon_normal_2="p_standard_mega_1",
    p_buffoon_jumbo_1="p_standard_mega_1",
    p_buffoon_mega_1="p_standard_mega_1"
  }
    if G.SETTINGS.paused then
      matref(self, center, initial, delay_sprites)
    else
      if self.config and self.config.center and Entropy.FlipsideInversions and Entropy.FlipsideInversions[self.config.center.key] and 
      Entropy.DeckOrSleeve("twisted") then
          if not self.ability then self.ability = {} end
          if self.area and self.area == G.pack_cards then
            matref(self, center, initial, delay_sprites)
            G.E_MANAGER:add_event(Event({
              trigger="after",
              func = function()
                matref(self, G.P_CENTERS[Entropy.FlipsideInversions[self.config.center.key]] or center, initial, delay_sprites)
              end
            }))
          else
            matref(self, G.P_CENTERS[Entropy.FlipsideInversions[self.config.center.key]] or center, initial, delay_sprites)
          end
      elseif self.config and self.config.center and Jumbos[self.config.center.key] and 
        Entropy.DeckOrSleeve("crafting") then
          if not self.ability then self.ability = {} end
          matref(self, G.P_CENTERS[Jumbos[self.config.center.key]], initial, delay_sprites)
      else
          if not self.ability then self.ability = {} end
          matref(self, center, initial, delay_sprites)
      end
    end
end

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

--chance of beyond showing up is 1 - 0.99^entropy
--chips exp is 0.02 + 0.98^entropy
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
	end
}
local use_cardref = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
	local card = e.config.ref_table
	if card.config.center.set ~= "Booster" and Entropy.DeckOrSleeve("doc") then
    local num = 1
    for i, v in pairs(G.GAME.entr_bought_decks or {}) do if v == "b_entr_doc" or v == "sleeve_entr_doc" then num = num + 1 end end
		if Entropy.FlipsideInversions[card.config.center.key] and not Entropy.FlipsidePureInversions[card.config.center.key] then
			ease_entropy(4*num)
		else
			ease_entropy(2*num)
		end
	end
	use_cardref(e, mute, nosave)
end
SMODS.Booster:take_ownership_by_kind('Spectral', {
	create_card = function(self, card, i)
		G.GAME.entropy = G.GAME.entropy or 0
		if to_big(pseudorandom("doc")) < to_big(1 - 0.997^G.GAME.entropy) and Entropy.DeckOrSleeve("doc") and Cryptid.enabled("c_entr_beyond") == true then
      G.GAME.entropy = 0
			return create_card("RSpectral", G.pack_cards, nil, nil, true, true, "c_entr_beyond")
		elseif to_big(pseudorandom("doc")) < to_big(1 - 0.996^G.GAME.entropy) and Entropy.DeckOrSleeve("doc") and Cryptid.enabled("c_cry_gateway") == true then
			return create_card("Spectral", G.pack_cards, nil, nil, true, true, "c_cry_gateway")
		end
		return create_card("Spectral", G.pack_cards, nil, nil, true, true, nil, "spe")
	end
},true)
SMODS.Consumable:take_ownership("cry_gateway",{
	use = function(self, card, area, copier)
		if not Entropy.DeckOrSleeve("doc") then
			local deletable_jokers = {}
			for k, v in pairs(G.jokers.cards) do
				if not v.ability.eternal then
					deletable_jokers[#deletable_jokers + 1] = v
				end
			end
			local _first_dissolve = nil
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.75,
				func = function()
					for k, v in pairs(deletable_jokers) do
						if v.config.center.rarity == "cry_exotic" then
							check_for_unlock({ type = "what_have_you_done" })
						end
						v:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
					return true
				end,
			}))
		end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, "cry_exotic", nil, nil, nil, "cry_gateway")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
    if Entropy.DeckOrSleeve("doc") then
      ease_entropy(-math.min(G.GAME.entropy, 4))
    end
	end
},true)
local uibox_ref = create_UIBox_HUD
function create_UIBox_HUD()
  local orig = uibox_ref()
	if not Entropy.DeckOrSleeve("doc") then return orig end
    local scale = 0.4
    local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.5)

    local contents = {}

    local spacing = 0.13
    local temp_col = G.C.DYN_UI.BOSS_MAIN
    local temp_col2 = G.C.DYN_UI.BOSS_DARK
    
    contents.buttons = {
      {n=G.UIT.C, config={align = "cm", r=0.1, colour = G.C.CLEAR, shadow = true, id = 'button_area',padding=0.33}, nodes={
        {n=G.UIT.R, config={id = 'run_info_button', align = "cm", minh = 1, minw = 1.5,padding = 0.05, r = 0.1, hover = true, colour = G.C.RED, button = "run_info", shadow = true}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 2}, nodes={
          {n=G.UIT.T, config={text = localize('b_run_info_1'), scale = 1.2*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
        }},
        {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 2}, nodes={
          {n=G.UIT.T, config={text = localize('b_run_info_2'), scale = 1*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true, focus_args = {button = G.F_GUIDE and 'guide' or 'back', orientation = 'bm'}, func = 'set_button_pip'}}
        }}
        }},
        {n=G.UIT.R, config={align = "cm", minh = 1, minw = 2,padding = 0.05, r = 0.1, hover = true, colour = G.C.ORANGE, button = "options", shadow = true}, nodes={
        {n=G.UIT.C, config={align = "cm", maxw = 1.4, focus_args = {button = 'start', orientation = 'bm'}, func = 'set_button_pip'}, nodes={
          {n=G.UIT.T, config={text = localize('b_options'), scale = scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
        }},
        }},
        {n=G.UIT.R, config={align = "cm", minh = 1, minw = 2,padding = 0.05, r = 0.1, hover = true, colour=G.C.DYN_UI.BOSS_MAIN,emboss=0.05}, nodes={
        {n=G.UIT.R, config={align = "cm", maxw = 1.35}, nodes={
          {n=G.UIT.T, config={text = localize('k_entropy'), minh = 0.33, scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
        }},
        {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.8, colour = temp_col2, id = 'row_entropy_text'}, nodes={
          {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'entropy'}}, colours = {G.C.IMPORTANT},shadow = true, scale = 2*scale}),id = 'entropy_UI_count'}},
        }},
        }}
      }}
    }
    --heres the one bit of compat ill do on my end
    if SMODS.Mods.jen and SMODS.Mods.jen.can_load then
      orig.nodes[1].nodes[1].nodes[5].nodes[1].nodes[6] = {n=G.UIT.R, config={align = "cm"}, nodes={
        {n=G.UIT.C, config={id = 'hud_tension',align = "cm", padding = 0.05, minw = 1.45, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
          {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
            {n=G.UIT.T, config={text = 'Tension', scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
            {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'tension'}}, colours = {G.C.CRY_EMBER},shadow = true, font = G.LANGUAGES['en-us'].font, scale = scale_number(G.GAME.tension, 2*scale, 100)}),id = 'tension_UI_count'}},
          }},
        }},
        {n=G.UIT.C, config={minw = spacing},nodes={}},
        {n=G.UIT.C, config={id = 'hud_relief',align = "cm", padding = 0.05, minw = 1.45, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
          {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
            {n=G.UIT.T, config={text = 'Relief', scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
            {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'relief'}}, colours = {G.C.CRY_VERDANT},shadow = true, font = G.LANGUAGES['en-us'].font, scale = scale_number(G.GAME.relief, 2*scale, 100)}),id = 'relief_UI_count'}},
          }},
        }},
        {n=G.UIT.C, config={minw = spacing},nodes={}},
        {n=G.UIT.C, config={id = 'hud_entropy',align = "cm", padding = 0.05, minw = 1.45, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
          {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
            {n=G.UIT.T, config={text = localize('k_entropy'), scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
            {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'entropy'}}, colours = {G.C.IMPORTANT},shadow = true, font = G.LANGUAGES['en-us'].font, scale = 2*scale}),id = 'entropy_UI_count'}},
          }},
        }},
      }}
    else  
      orig.nodes[1].nodes[1].nodes[5].nodes[1].nodes = contents.buttons
    end
    return orig
end


function ease_entropy(mod)
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
          local round_UI = G.HUD:get_UIE_by_ID('entropy_UI_count')
          mod = mod or 0
          local text = '+'
          local col = G.C.IMPORTANT
          if to_big(mod) < to_big(0) then
              text = ''
              col = G.C.RED
          end
          G.GAME.entropy = (G.GAME.entropy or 0) + mod
          if round_UI then
            G.HUD:recalculate()
            if not Talisman.config_file.disable_anims then
              attention_text({
                text = text..tostring(math.abs(mod)),
                scale = 1, 
                hold = 0.7,
                cover = round_UI.parent,
                cover_colour = col,
                align = 'cm',
              })
            end
          end
          --Play a chip sound
          if not Talisman.config_file.disable_anims then
            play_sound('timpani', 0.8)
            play_sound('generic1')
          end
          return true
      end
    }))
end

--OH BOY

local destiny = {
  order = 3,
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
        c:set_edition("e_negative")
        c.ability.cry_absolute = true
        c:add_to_deck()
        G.consumeables:emplace(c)
        return true
      end}))
	end,
  config = { vouchers = { "v_magic_trick", "v_illusion" } },
}

local create_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local card = create_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if card and card.config and card.config.center and card.config.center.key == "c_base" and Entropy.DeckOrSleeve("crafting") then
      if pseudorandom("crafting") < 0.5 then
        card:set_ability(pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed("crafting")))
      end
	  end
    return card
end

local butterfly = {
  object_type = "Back",
  order = 4,
  dependencies = {
    items = {
      "set_entr_decks"
    }
  },
	object_type = "Back",
	name = "Butterfly Deck",
	key = "butterfly",
	pos = { x = 4, y = 0 },
	atlas = "decks",
  config = { vouchers = { "v_cry_command_prompt", "v_cry_satellite_uplink" } },
  calculate = function(self, back, context)
    if context.setting_blind and G.GAME.blind_on_deck == "Boss" then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        func = function()
          local c = create_card("Code", G.consumeables, nil, nil, nil, nil, "c_cry_revert") 
          c:set_edition("e_negative")
          c:add_to_deck()
          G.consumeables:emplace(c)
          return true
        end}))
    end
  end
}

local ambisinister = {
  object_type = "Back",
  order = 5,
  dependencies = {
    items = {
      "set_entr_decks"
    }
  },
	key = "ambisinister",
	pos = { x = 5, y = 0 },
	atlas = "decks",
  apply = function()
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      func = function()
        G.jokers.config.card_limit = G.jokers.config.card_limit + 3
        G.hand.config.highlight_limit = G.jokers.config.card_limit - #G.jokers.cards
        return true
      end
    }))
  end
}
local ref = pseudorandom
function pseudorandom(key,min,max)
  if Entropy.DeckOrSleeve("butterfly") then key = "butterfly" end
  return ref(key,min,max)
end
local eref = pseudorandom_element
function pseudorandom_element(elements, pseudokey)
  if Entropy.DeckOrSleeve("butterfly") then pseudokey = pseudoseed("butterfly") end
  return eref(elements, pseudokey)
end
--cryptid enh/edition/seal decks here
SMODS.Atlas { key = 'crypt_deck', path = 'crypt_decks.png', px = 71, py = 95 }
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

local apply_ref = Cryptid.antimatter_apply
function Cryptid.antimatter_apply(skip)
  apply_ref(skip)
  if (Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_entr_ccd2", "wins", 8) or 0 ~= 0) or skip then
    G.GAME.modifiers.ccd2 = true
  end
  if (Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_entr_doc", "wins", 8) or 0 ~= 0) or skip then
    G.GAME.modifiers.doc_antimatter = true
  end
  if (Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_entr_twisted", "wins", 8) or 0 ~= 0) or skip then
    G.GAME.modifiers.twisted_antimatter = true
  end
end

--sleeves
if CardSleeves then
  SMODS.Atlas { key = 'sleeves', path = 'sleeves.png', px = 73, py = 95 }
  CardSleeves.Sleeve {
    key = "twisted",
    atlas = "sleeves",
    pos = { x = 0, y = 0 },
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
    end
  }
  CardSleeves.Sleeve {
    key = "butterfly",
    atlas = "sleeves",
    pos = { x = 1, y = 0 },
  }

  CardSleeves.Sleeve {
    key = "ambisinister",
    atlas = "sleeves",
    pos = { x = 1, y = 0 },
  }
end

return {
  items = {
    twisted,
    redefined,
    destiny,
    containment,
    butterfly,
    ambisinister
  }
}
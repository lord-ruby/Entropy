SMODS.Atlas { key = 'decks', path = 'decks.png', px = 71, py = 95 }
SMODS.Back({
	name = "Twisted Deck",
	key = "twisted",
	pos = { x = 0, y = 0 },
	atlas = "decks",
})

local matref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
	Entropy.ReverseFlipsideInversions()
    if self.config and self.config.center and Entropy.FlipsideInversions and Entropy.FlipsideInversions[self.config.center.key] and 
    Entropy.DeckOrSleeve("twisted") then
        matref(self, G.P_CENTERS[Entropy.FlipsideInversions[self.config.center.key]], initial, delay_sprites)
    else
        matref(self, center, initial, delay_sprites)
    end
end

SMODS.Back({
	object_type = "Back",
	name = "CCD 2.0",
	key = "ccd2",
	pos = { x = 1, y = 0 },
	order = 1,
	atlas = "decks",
	apply = function(self)
		G.GAME.modifiers.ccd2 = true
	end,
})

--chance of beyond showing up is 1 - 0.99^entropy
--chips exp is 0.02 + 0.98^entropy
SMODS.Back({
	object_type = "Back",
	name = "Deck of Containment",
	key = "doc",
	pos = { x = 2, y = 0 },
	order = 1,
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
})
local use_cardref = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
	local card = e.config.ref_table
	if card.config.center.set ~= "Booster" and Entropy.DeckOrSleeve("doc") then
		if Entropy.FlipsideInversions[card.config.center.key] and not Entropy.FlipsidePureInversions[card.config.center.key] then
			ease_entropy(4)
		else
			ease_entropy(2)
		end
	end
	use_cardref(e, mute, nosave)
end
SMODS.Booster:take_ownership_by_kind('Spectral', {
	create_card = function(self, card, i)
		G.GAME.entropy = G.GAME.entropy or 0
		if to_big(pseudorandom("doc")) < to_big(1 - 0.997^G.GAME.entropy) and Entropy.DeckOrSleeve("doc") then
			ease_entropy(-G.GAME.entropy)
			return create_card("RSpectral", G.pack_cards, nil, nil, true, true, "c_entr_beyond")
		elseif to_big(pseudorandom("doc")) < to_big(1 - 0.996^G.GAME.entropy) and Entropy.DeckOrSleeve("doc") then
			if to_big(G.GAME.entropy) < to_big(4) then ease_entropy(-G.GAME.entropy) else ease_entropy(-4) end
			return create_card("RSpectral", G.pack_cards, nil, nil, true, true, "c_cry_gateway")
		end
		return {set = "Spectral", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "spe"}
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
	end
},true)
local uibox_ref = create_UIBox_HUD
function create_UIBox_HUD()
	if not Entropy.DeckOrSleeve("doc") then return uibox_ref() end
    local scale = 0.4
    local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.5)

    local contents = {}

    local spacing = 0.13
    local temp_col = G.C.DYN_UI.BOSS_MAIN
    local temp_col2 = G.C.DYN_UI.BOSS_DARK
            contents.round = {
              {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={id = 'hud_hands',align = "cm", padding = 0.05, minw = 1.45, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
                  {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
                    {n=G.UIT.T, config={text = localize('k_hud_hands'), scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                  }},
                  {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME.current_round, ref_value = 'hands_left'}}, font = G.LANGUAGES['en-us'].font, colours = {G.C.BLUE},shadow = true, rotate = true, scale = 2*scale}),id = 'hand_UI_count'}},
                  }}
                }},
                {n=G.UIT.C, config={minw = spacing},nodes={}},
                {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 1.45, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
                  {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
                    {n=G.UIT.T, config={text = localize('k_hud_discards'), scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                  }},
                  {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
                      {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME.current_round, ref_value = 'discards_left'}}, font = G.LANGUAGES['en-us'].font, colours = {G.C.RED},shadow = true, rotate = true, scale = 2*scale}),id = 'discard_UI_count'}},
                    }}
                  }},
                }},
              }},
              {n=G.UIT.R, config={minh = spacing},nodes={}},
              {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 1.45*2 + spacing, minh = 1.15, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
                  {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.C, config={align = "cm", r = 0.1, minw = 1.28*2+spacing, minh = 1, colour = temp_col2}, nodes={
                      {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'dollars', prefix = localize('$')}},
                            scale_function = function ()
                                return scale_number(G.GAME.dollars, 2.2 * scale, 99999, 1000000)
                            end, maxw = 1.35, colours = {G.C.MONEY}, font = G.LANGUAGES['en-us'].font, shadow = true,spacing = 2, bump = true, scale = 2.2*scale}), id = 'dollar_text_UI'}}
                  }},
                  }},
                }},
            }},
            {n=G.UIT.R, config={minh = spacing},nodes={}},
            {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.C, config={id = 'hud_ante',align = "cm", padding = 0.05, minw = 1.45, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
                  {n=G.UIT.T, config={text = localize('k_ante'), scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                }},
                {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
                  {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'RubyAnteTextNum'}}, colours = {G.C.IMPORTANT},shadow = true, font = G.LANGUAGES['en-us'].font, scale = 2*scale}),id = 'ante_UI_count'}},
                  {n=G.UIT.T, config={text = " ", scale = 0.3*scale}},
                  {n=G.UIT.T, config={text = "/ ", scale = 0.7*scale, colour = G.C.WHITE, shadow = true}},
                  {n=G.UIT.T, config={ref_table = G.GAME, ref_value='win_ante', scale = scale, colour = G.C.WHITE, shadow = true}}
                }},
              }},
              {n=G.UIT.C, config={minw = spacing},nodes={}},
              {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 1.45, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.35}, nodes={
                  {n=G.UIT.T, config={text = localize('k_round'), minh = 0.33, scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                }},
                {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2, id = 'row_round_text'}, nodes={
                  {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'round'}}, colours = {G.C.IMPORTANT},shadow = true, scale = 2*scale}),id = 'round_UI_count'}},
                }},
              }},
            }},            
    }

    contents.hand =
        {n=G.UIT.R, config={align = "cm", id = 'hand_text_area', colour = darken(G.C.BLACK, 0.1), r = 0.1, emboss = 0.05, padding = 0.03}, nodes={
            {n=G.UIT.C, config={align = "cm"}, nodes={
              {n=G.UIT.R, config={align = "cm", minh = 1.1}, nodes={
                {n=G.UIT.O, config={id = 'hand_name', func = 'hand_text_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "handname_text"}}, colours = {G.C.UI.TEXT_LIGHT}, shadow = true, float = true, scale = scale*1.4})}},
                {n=G.UIT.O, config={id = 'cry_asc', func = 'cry_asc_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "cry_asc_num_text"}}, colours = {G.C.GOLD}, shadow = true, float = true, scale = scale*1})}},
                {n=G.UIT.O, config={id = 'hand_chip_total', func = 'hand_chip_total_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "chip_total_text"}}, colours = {G.C.UI.TEXT_LIGHT}, shadow = true, float = true, scale = scale*1.4})}},
                {n=G.UIT.T, config={ref_table = G.GAME.current_round.current_hand, ref_value='hand_level', scale = scale, colour = G.C.UI.TEXT_LIGHT, id = 'hand_level', shadow = true}}
              }},
              {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
                {n=G.UIT.C, config={align = "cr", minw = 2, minh =1, r = 0.1,colour = G.C.UI_CHIPS, id = 'hand_chip_area', emboss = 0.05}, nodes={
                    {n=G.UIT.O, config={func = 'flame_handler',no_role = true, id = 'flame_chips', object = Moveable(0,0,0,0), w = 0, h = 0}},
                    {n=G.UIT.O, config={id = 'hand_chips', func = 'hand_chip_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "chip_text"}}, colours = {G.C.UI.TEXT_LIGHT}, font = G.LANGUAGES['en-us'].font, shadow = true, float = true, scale = scale*2.3})}},
                    {n=G.UIT.B, config={w=0.1,h=0.1}},
                }},
                {n=G.UIT.C, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={text = "X", lang = G.LANGUAGES['en-us'], scale = scale*2, colour = G.C.UI_MULT, shadow = true}},
                }},
                {n=G.UIT.C, config={align = "cl", minw = 2, minh=1, r = 0.1,colour = G.C.UI_MULT, id = 'hand_mult_area', emboss = 0.05}, nodes={
                  {n=G.UIT.O, config={func = 'flame_handler',no_role = true, id = 'flame_mult', object = Moveable(0,0,0,0), w = 0, h = 0}},
                  {n=G.UIT.B, config={w=0.1,h=0.1}},
                  {n=G.UIT.O, config={id = 'hand_mult', func = 'hand_mult_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "mult_text"}}, colours = {G.C.UI.TEXT_LIGHT}, font = G.LANGUAGES['en-us'].font, shadow = true, float = true, scale = scale*2.3})}},
                }}
              }}
            }}
          }}
    contents.dollars_chips = {n=G.UIT.R, config={align = "cm",r=0.1, padding = 0,colour = G.C.DYN_UI.BOSS_MAIN, emboss = 0.05, id = 'row_dollars_chips'}, nodes={
      {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
        {n=G.UIT.C, config={align = "cm", minw = 1.3}, nodes={
          {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 1.3}, nodes={
            {n=G.UIT.T, config={text = localize('k_round'), scale = 0.42, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
          }},
          {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 1.3}, nodes={
            {n=G.UIT.T, config={text =localize('k_lower_score'), scale = 0.42, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
          }}
        }},
        {n=G.UIT.C, config={align = "cm", minw = 3.3, minh = 0.7, r = 0.1, colour = G.C.DYN_UI.BOSS_DARK}, nodes={
          {n=G.UIT.O, config={w=0.5,h=0.5 , object = stake_sprite, hover = true, can_collide = false}},
          {n=G.UIT.B, config={w=0.1,h=0.1}},
          {n=G.UIT.T, config={ref_table = G.GAME, ref_value = 'chips_text', lang = G.LANGUAGES['en-us'], scale = 0.85, colour = G.C.WHITE, id = 'chip_UI_count', func = 'chip_UI_set', shadow = true}}
        }}
      }}
    }}

    
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

    return {n=G.UIT.ROOT, config = {align = "cm", padding = 0.03, colour = G.C.UI.TRANSPARENT_DARK}, nodes={
      {n=G.UIT.R, config = {align = "cm", padding= 0.05, colour = G.C.DYN_UI.MAIN, r=0.1}, nodes={
        {n=G.UIT.R, config={align = "cm", colour = G.C.DYN_UI.BOSS_DARK, r=0.1, minh = 30, padding = 0.08}, nodes={
          {n=G.UIT.R, config={align = "cm", minh = 0.3}, nodes={}},
          {n=G.UIT.R, config={align = "cm", id = 'row_blind', minw = 1, minh = 3.75}, nodes={
              {n=G.UIT.B, config={w=0, h=3.64, id = 'row_blind_bottom'}, nodes={}}
          }},
          contents.dollars_chips,
          contents.hand,
          {n=G.UIT.R, config={align = "cm", id = 'row_round'}, nodes={
            {n=G.UIT.C, config={align = "cm"}, nodes=contents.buttons},
            {n=G.UIT.C, config={align = "cm"}, nodes=contents.round}
          }},
        }}
      }}
    }}
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
          G.HUD:recalculate()
          attention_text({
            text = text..tostring(math.abs(mod)),
            scale = 1, 
            hold = 0.7,
            cover = round_UI.parent,
            cover_colour = col,
            align = 'cm',
            })
          --Play a chip sound
          play_sound('timpani', 0.8)
          play_sound('generic1')
          return true
      end
    }))
end


--cryptid enh/edition/seal decks here
SMODS.Atlas { key = 'crypt_deck', path = 'crypt_decks.png', px = 71, py = 95 }
Cryptid.edeck_sprites.seal.entr_cerulean = {atlas="entr_crypt_deck", pos = {x=0,y=0}}
Cryptid.edeck_sprites.seal.entr_sapphire = {atlas="entr_crypt_deck", pos = {x=1,y=0}}

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
    atlas = "sleeves",  -- you will need to create an atlas yourself
    pos = { x = 0, y = 0 },
  }
  CardSleeves.Sleeve {
    key = "ccd2",
    atlas = "sleeves",  -- you will need to create an atlas yourself
    pos = { x = 1, y = 0 },
    apply = function()
      G.GAME.modifiers.ccd2 = true
    end
  }
  CardSleeves.Sleeve {
    key = "doc",
    atlas = "sleeves",  -- you will need to create an atlas yourself
    pos = { x = 2, y = 0 },
  }
end
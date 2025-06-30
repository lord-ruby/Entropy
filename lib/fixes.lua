G.FUNCS.flame_handler = function(e)
  G.C.UI_CHIPLICK = G.C.UI_CHIPLICK or {1, 1, 1, 1}
  G.C.UI_MULTLICK = G.C.UI_MULTLICK or {1, 1, 1, 1}
  for i=1, 3 do
    G.C.UI_CHIPLICK[i] = math.min(math.max(((G.C.UI_CHIPS[i]*0.5+G.C.YELLOW[i]*0.5) + 0.1)^2, 0.1), 1)
    G.C.UI_MULTLICK[i] = math.min(math.max(((G.C.UI_MULT[i]*0.5+G.C.YELLOW[i]*0.5) + 0.1)^2, 0.1), 1)
  end

  G.ARGS.flame_handler = G.ARGS.flame_handler or {
    chips = {
      id = 'flame_chips', 
      arg_tab = 'chip_flames',
      colour = G.C.UI_CHIPS,
      accent = G.C.UI_CHIPLICK
    },
    mult = {
      id = 'flame_mult', 
      arg_tab = 'mult_flames',
      colour = G.C.UI_MULT,
      accent = G.C.UI_MULTLICK
    }
  }
  for k, v in pairs(G.ARGS.flame_handler) do
    if e.config.id == v.id then 
      if not e.config.object:is(Sprite) or e.config.object.ID ~= v.ID then 
        e.config.object:remove()
        e.config.object = Sprite(0, 0, 2.5, 2.5, G.ASSET_ATLAS["ui_1"], {x = 2, y = 0})
        v.ID = e.config.object.ID
        G.ARGS[v.arg_tab] = {
            intensity = 0,
            real_intensity = 0,
            intensity_vel = 0,
            colour_1 = v.colour,
            colour_2 = v.accent,
            timer = G.TIMERS.REAL
        }      
        e.config.object:set_alignment({
            major = e.parent,
            type = 'bmi',
            offset = {x=0,y=0},
            xy_bond = 'Weak'
        })
        e.config.object:define_draw_steps({{
          shader = 'flame',
          send = {
              {name = 'time', ref_table = G.ARGS[v.arg_tab], ref_value = 'timer'},
              {name = 'amount', ref_table = G.ARGS[v.arg_tab], ref_value = 'real_intensity'},
              {name = 'image_details', ref_table = e.config.object, ref_value = 'image_dims'},
              {name = 'texture_details', ref_table = e.config.object.RETS, ref_value = 'get_pos_pixel'},
              {name = 'colour_1', ref_table =  G.ARGS[v.arg_tab], ref_value = 'colour_1'},
              {name = 'colour_2', ref_table =  G.ARGS[v.arg_tab], ref_value = 'colour_2'},
              {name = 'id', val =  e.config.object.ID},
          }}})
          e.config.object:get_pos_pixel()
      end
      local _F = G.ARGS[v.arg_tab]
      local exptime = math.exp(-0.4*G.real_dt)
      if to_big(G.ARGS.score_intensity.earned_score) >= to_big(G.ARGS.score_intensity.required_score) and to_big(G.ARGS.score_intensity.required_score) > to_big(0) then
        _F.intensity = ((G.pack_cards and not G.pack_cards.REMOVED) or (G.TAROT_INTERRUPT)) and 0 or math.max(0., math.log(G.ARGS.score_intensity.earned_score+1, 5)-2)
          if type(_F.intensity) == "table" then
              if _F.intensity > to_big(85) then
                  _F.intensity = 85
              else
                  _F.intensity = _F.intensity:to_number()
              end
          elseif _F.intensity > 85 then
              _F.intensity = 85
          end
      else
        _F.intensity = 0
      end
      _F.timer = _F.timer + G.real_dt*(1 + _F.intensity*0.2)
      if _F.intensity_vel < 0 then _F.intensity_vel = _F.intensity_vel*(1 - 10*G.real_dt) end
      _F.intensity_vel = (1-exptime)*(_F.intensity - _F.real_intensity)*G.real_dt*25 + exptime*_F.intensity_vel
      _F.real_intensity = math.max(0, _F.real_intensity + _F.intensity_vel)
      
      _F.real_intensity = (G.cry_flame_override and G.cry_flame_override['duration'] > 0) and ((_F.real_intensity + G.cry_flame_override['intensity'])/2) or _F.real_intensity
      if to_big(_F.real_intensity) > to_big(85) then
          _F.real_intensity = 85
      end
      _F.change = (_F.change or 0)*(1 - 4.*G.real_dt) + ( 4.*G.real_dt)*(_F.real_intensity < _F.intensity - 0.0 and 1 or 0)*_F.real_intensity
      _F.change = (G.cry_flame_override and G.cry_flame_override['duration'] > 0) and ((_F.change + G.cry_flame_override['intensity'])/2) or _F.change
    end
  end
end

  SMODS.Joker:take_ownership("cry_oil_lamp", {
    rarity = "cry_epic"
  }, true)


SMODS.Joker:take_ownership("j_cry_redeo", {
  loc_vars = function(self, q, center)
    local ante_mod = center.ability.extra.ante_reduction
    if ante_mod > 0 then
      ante_mod = "-"..number_format(ante_mod)
    else
      ante_mod = "+"..number_format(-ante_mod)
    end
    if G.GAME.ReverseRedeo then
      ante_mod = "+1"
    end
    return {
      vars = {
        ante_mod,
				number_format(center.ability.extra.money_req),
				number_format(center.ability.extra.money_remaining),
				number_format(center.ability.extra.money_mod),
			},
    }
  end,
  calculate = function(self, card, context)
		if context.cry_ease_dollars and to_big(context.cry_ease_dollars) < to_big(0) and not context.blueprint then
			card.ability.extra.money_remaining =
				lenient_bignum(to_big(card.ability.extra.money_remaining) - context.cry_ease_dollars)
			local ante_mod = 0
			while to_big(card.ability.extra.money_remaining) >= to_big(card.ability.extra.money_req) do
				card.ability.extra.money_remaining =
					lenient_bignum(to_big(card.ability.extra.money_remaining) - card.ability.extra.money_req)
				card.ability.extra.money_req =
					lenient_bignum(to_big(card.ability.extra.money_req) + card.ability.extra.money_mod)
				card.ability.extra.money_mod = lenient_bignum(math.ceil(to_big(card.ability.extra.money_mod) * 1.06))
				ante_mod = lenient_bignum(ante_mod - to_big(card.ability.extra.ante_reduction))
			end
			ease_ante(ante_mod)
			return nil, true
		end
		if context.forcetrigger then
			ease_ante(card.ability.extra.ante_reduction)
		end
	end,
},true)

function get_highest(hand)
  local highest = nil
  if type(hand) ~= "table" then return {} end
  for k, v in ipairs(hand or {}) do
    if not highest or v:get_nominal() > highest:get_nominal() then
      highest = v
    end
  end
  if #hand > 0 then return {{highest}} else return {} end
end

function UIElement:update_text()
  if self.config and self.config.text and not self.config.text_drawable then
      self.config.lang = self.config.lang or G.LANG
      if self.config.font then
        self.config.text_drawable = love.graphics.newText(self.config.font.FONT, {G.C.WHITE,self.config.text})
      else
        self.config.text_drawable = love.graphics.newText(self.config.lang.font.FONT, {G.C.WHITE,self.config.text})
      end
  end

  if self.config.ref_table and self.config.ref_table[self.config.ref_value] ~= self.config.prev_value then
      self.config.text = tostring(self.config.ref_table[self.config.ref_value])
      self.config.text_drawable:set(self.config.text)
      if type(self.config.prev_value) == "string" and type(self.config.text) ~= "string" then
        if not self.config.no_recalc and self.config.prev_value and string.len(self.config.prev_value) ~= string.len(self.config.text) then self.UIBox:recalculate() end
      else
        self.config.prev_value = number_format(self.config.prev_value)
        self.UIBox:recalculate()
      end
      self.config.prev_value = self.config.ref_table[self.config.ref_value] 
  end
end


G.FUNCS.hand_chip_UI_set = function(e)
  local new_chip_text = number_format(G.GAME.current_round.current_hand.chips)
    if new_chip_text ~= G.GAME.current_round.current_hand.chip_text then 
      G.GAME.current_round.current_hand.chip_text = new_chip_text
      e.config.object.scale = scale_number(G.GAME.current_round.current_hand.chips, 0.9, 1000)
      if string.len(new_chip_text) > 6 then
          e.config.object.scale = 0.9 / (string.len(new_chip_text)/6)
        end
      e.config.object:update_text()
      if not G.TAROT_INTERRUPT_PULSE then G.FUNCS.text_super_juice(e, math.max(0,math.floor(math.log10(type(G.GAME.current_round.current_hand.chips) == 'number' and G.GAME.current_round.current_hand.chips or 1)))) end
    end
end



G.FUNCS.hand_mult_UI_set = function(e)
  local new_mult_text = number_format(G.GAME.current_round.current_hand.mult)
  if new_mult_text ~= G.GAME.current_round.current_hand.mult_text then 
    G.GAME.current_round.current_hand.mult_text = new_mult_text
    e.config.object.scale = scale_number(G.GAME.current_round.current_hand.mult, 0.9, 1000)
    if string.len(new_mult_text) > 6 then
      e.config.object.scale = 0.9 / (string.len(new_mult_text)/6)
    end
    e.config.object:update_text()
    if not G.TAROT_INTERRUPT_PULSE then G.FUNCS.text_super_juice(e, math.max(0,math.floor(math.log10(type(G.GAME.current_round.current_hand.mult) == 'number' and G.GAME.current_round.current_hand.mult or 1)))) end
  end
end

local ref = SMODS.get_blind_amount
function SMODS.get_blind_amount(ante)
  if to_big(ante) <= to_big(8) then 
    return ref(to_number(ante))
  else --disgusting hook because the patches sometimes fail
    local k = to_big(0.75)
    local scale = G.GAME.modifiers.scaling
    local amounts = {
        to_big(300),
        to_big(700 + 100*scale),
        to_big(1400 + 600*scale),
        to_big(2100 + 2900*scale),
        to_big(15000 + 5000*scale*math.log(scale)),
        to_big(12000 + 8000*(scale+1)*(0.4*scale)),
        to_big(10000 + 25000*(scale+1)*((scale/4)^2)),
        to_big(50000 * (scale+1)^2 * (scale/7)^2)
    }
    local a, b, c, d = amounts[8], amounts[8]/amounts[7], ante-8, 1 + 0.2*(ante-8)
    local amount = math.floor(a*(b + (b*k*c)^d)^c)
    if (amount:lt(R.E_MAX_SAFE_INTEGER)) then
      local exponent = to_big(10)^(math.floor(amount:log10() - to_big(1))):to_number()
      amount = math.floor(amount / exponent):to_number() * exponent
    end
    amount:normalize()
    return amount
  end
end


SMODS.Consumable:take_ownership("cry_white_hole",
  {
    use = function(self, card, area, copier)
      local used_consumable = copier or card
      local modest = Card.get_gameset(used_consumable) == "modest"
      --Get most played hand type (logic yoinked from Telescope)
      local _hand, _tally = nil, -1
      for k, v in ipairs(G.handlist) do
        if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
          _hand = v
          _tally = G.GAME.hands[v].played
        end
      end
      local removed_levels = 0
      for k, v in ipairs(G.handlist) do
        if to_big(G.GAME.hands[v].level) > to_big(1) then
          local this_removed_levels = G.GAME.hands[v].level - 1
          if
            -- Due to how these poker hands are loaded they still techically exist even if Poker Hand Stuff is disabled
            -- Because they still exist, While Hole needs to ignore levels from these if disabled (via Black Hole, Planet.lua, etc...)
            (v ~= "cry_Bulwark" and v ~= "cry_Clusterfuck" and v ~= "cry_UltPair" and v ~= "cry_WholeDeck")
            or Cryptid.enabled("set_cry_poker_hand_stuff") == true
          then
            if v ~= _hand or not modest then
              removed_levels = removed_levels + this_removed_levels
              level_up_hand(used_consumable, v, true, -this_removed_levels)
            end
          end
        end
      end
      update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
        handname = localize(_hand, "poker_hands"),
        chips = G.GAME.hands[_hand].chips,
        mult = G.GAME.hands[_hand].mult,
        level = G.GAME.hands[_hand].level,
      })
      if modest then
        level_up_hand(used_consumable, _hand, false, 4)
      else
        level_up_hand(used_consumable, _hand, false, (3 * to_big(removed_levels)))
      end
      update_hand_text(
        { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
        { mult = 0, chips = 0, handname = "", level = "" }
      )
    end,
    bulk_use = function(self, card, area, copier, number)
      local used_consumable = copier or card
      local modest = Card.get_gameset(used_consumable) == "modest"
      --Get most played hand type (logic yoinked from Telescope)
      local _hand, _tally = nil, -1
      for k, v in ipairs(G.handlist) do
        if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
          _hand = v
          _tally = G.GAME.hands[v].played
        end
      end
      local removed_levels = 0
      for k, v in ipairs(G.handlist) do
        if to_big(G.GAME.hands[v].level) > to_big(1) then
          local this_removed_levels = G.GAME.hands[v].level - 1
          removed_levels = removed_levels + this_removed_levels
          if v ~= _hand or not modest then
            level_up_hand(used_consumable, v, true, -this_removed_levels)
          end
        end
      end
      update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
        handname = localize(_hand, "poker_hands"),
        chips = G.GAME.hands[_hand].chips,
        mult = G.GAME.hands[_hand].mult,
        level = G.GAME.hands[_hand].level,
      })
      if modest then
        level_up_hand(used_consumable, _hand, false, 4 * number)
      else
        level_up_hand(used_consumable, _hand, false, ((to_big(3) ^ to_big(number)) * removed_levels))
      end
      update_hand_text(
        { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
        { mult = 0, chips = 0, handname = "", level = "" }
      )
    end,
  }
,true)

local updateht_ref= update_hand_text
function update_hand_text( args1, args2)
    if args2.handname == localize("cry_None", "poker_hands") and G.GAME.badarg and G.GAME.badarg["cry_None"] then
      args2.handname = ""
      args2.chips = "bad"
      args2.mult = "arg"
    else
      updateht_ref(args1, args2)
    end
end

SMODS.Blind:take_ownership("cry_pin", {
  recalc_debuff = function(self, card, from_blind)
		if
			(card.area == G.jokers)
			and not G.GAME.blind.disabled
			and (
				card.config.center.rarity == 4
				or card.config.center.rarity == "cry_epic"
				or card.config.center.rarity == "cry_exotic"
        or card.config.center.rarity == "entr_reverse_legendary"
        or card.config.center.rarity == "entr_entropic"
			)
		then
			return true
		end
		return false
	end,
},true)

local ref = localize
function localize(args, misc_cat)
  return ref(args or {}, misc_cat)
end

if PTASaka then
  SMODS.Joker:take_ownership("payasaka_paya", {
    calculate = function(self, card, context)
      if not card.ability.extra.exponential_cnt then card.ability.extra.exponential_cnt = 0 end
      if context.setting_blind and ((pseudorandom('paya_hell') < (G.GAME.probabilities.normal or 1) / card.ability.odds) or card.ability.cry_rigged) then
        card.ability.extra.exponential_cnt = card.ability.extra.exponential_cnt + 1
        G.E_MANAGER:add_event(Event {
          func = function()
            G.GAME.paya_operator = G.GAME.paya_operator + 1
            return true
          end
        })
        return {
          message = card.ability.extra.exponential_cnt == 1 and localize('k_active_ex') or localize('k_payasaka_hyperactive_ex'),
          colour = card.ability.extra.exponential_cnt == 1 and G.C.GOLD or G.C.DARK_EDITION,
          card = context.blueprint_card or card
        }
      end
      while context.end_of_round and card.ability.extra.exponential_cnt > 0 and not context.individual do
        card.ability.extra.exponential_cnt = card.ability.extra.exponential_cnt - 1
        G.E_MANAGER:add_event(Event {
          func = function()
            G.GAME.paya_operator = math.max(G.GAME.paya_operator - 1, 0)
            return true
          end
        })
        card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_payasaka_inactive_ex') })
      end
    end
  }, true)
end
SMODS.Booster:take_ownership("p_cry_code_normal_1", {
  create_card = function()
      if #G.GAME.interpolate_cards > 0 then
        for i, v in pairs(G.GAME.interpolate_cards) do
            local num = pseudorandom("twisted_interpolate")
            if num <= 0.03 then
                local c = v
                return create_card(G.P_CENTERS[c].set, area or G.pack_cards, nil, nil, true, true, c)
            end
        end
    end
    return create_card("Code", G.pack_cards, nil, nil, true, true, nil, "cry_program_1")
  end
}, true)
SMODS.Booster:take_ownership("p_cry_code_normal_2", {
  create_card = function()
      if G.GAME.interpolate_cards and #G.GAME.interpolate_cards > 0 then
        for i, v in pairs(G.GAME.interpolate_cards) do
            local num = pseudorandom("twisted_interpolate")
            if num <= 0.03 then
                local c = v
                return create_card(G.P_CENTERS[c].set, area or G.pack_cards, nil, nil, true, true, c)
            end
        end
    end
    return create_card("Code", G.pack_cards, nil, nil, true, true, nil, "cry_program_1")
  end
}, true)
SMODS.Booster:take_ownership("p_cry_code_jumbo_1", {
  create_card = function()
      if G.GAME.interpolate_cards and #G.GAME.interpolate_cards > 0 then
        for i, v in pairs(G.GAME.interpolate_cards) do
            local num = pseudorandom("twisted_interpolate")
            if num <= 0.03 then
                local c = v
                return create_card(G.P_CENTERS[c].set, area or G.pack_cards, nil, nil, true, true, c)
            end
        end
    end
    return create_card("Code", G.pack_cards, nil, nil, true, true, nil, "cry_program_1")
  end
}, true)
SMODS.Booster:take_ownership("p_cry_code_mega_1", {
  create_card = function()
      if G.GAME.interpolate_cards and #G.GAME.interpolate_cards > 0 then
        for i, v in pairs(G.GAME.interpolate_cards) do
            local num = pseudorandom("twisted_interpolate")
            if num <= 0.03 then
                local c = v
                return create_card(G.P_CENTERS[c].set, area or G.pack_cards, nil, nil, true, true, c)
            end
        end
    end
    return create_card("Code", G.pack_cards, nil, nil, true, true, nil, "cry_program_1")
  end
}, true)
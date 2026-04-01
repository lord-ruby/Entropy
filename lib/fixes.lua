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
    if ( to_big(amount) < to_big(R and R.E_MAX_SAFE_INTEGER or 9e15)) then
	  local amount_log = type(amount) == "table" and amount:log10() or math.log10(amount)
      local exponent = to_big(10)^(math.floor(amount_log - to_big(1)))
	  if type(exponent) == "table" then exponent = exponent:to_number() end
      amount = math.floor(amount / exponent)
	  if type(amount) == "table" then amount = amount:to_number() end
	  amount = amount * exponent
    end
    if type(amount) == "table" then amount:normalize() end
    return amount
  end
end

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

SMODS.Booster:take_ownership("p_cry_code_normal_1", {
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

local mod_mult_ref = mod_mult
function mod_mult(_mult)
  if _mult then return mod_mult_ref(_mult) end
  return 1
end

local mod_chips_ref = mod_chips
function mod_chips(_chips)
  if _chips then return mod_chips_ref(_chips) end
  return 1
end

local get_areas_ref = SMODS.get_card_areas
function SMODS.get_card_areas(...)
  local ret = get_areas_ref(...)
  for i, v in pairs(ret) do
    v.cards = v.cards or {}
  end
  return ret
end

local hand_row_ref = create_UIBox_current_hand_row
function create_UIBox_current_hand_row(handname, simple)
    if G.GAME.hands[handname].operator then
      return (G.GAME.hands[handname].visible) and
      (not simple and
        {n=G.UIT.R, config={align = "cm", padding = 0.05, r = 0.1, colour = darken(G.C.JOKER_GREY, 0.1), emboss = 0.05, hover = true, force_focus = true, on_demand_tooltip = {text = localize(handname, 'poker_hand_descriptions'), filler = {func = create_UIBox_hand_tip, args = handname}}}, nodes={
          {n=G.UIT.C, config={align = "cl", padding = 0, minw = 5}, nodes={
            {n=G.UIT.C, config={align = "cm", padding = 0.01, r = 0.1, colour = G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands[handname].level))], minw = 1.5, outline = 0.8, outline_colour = G.C.WHITE}, nodes={
              {n=G.UIT.T, config={text = localize('k_level_prefix')..number_format(G.GAME.hands[handname].level), scale = 0.5, colour = G.C.UI.TEXT_DARK}}
            }},
            {n=G.UIT.C, config={align = "cm", minw = 4.5, maxw = 4.5}, nodes={
              {n=G.UIT.T, config={text = ' '..localize(handname,'poker_hands'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
            }}
          }},
          {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.BLACK,r = 0.1}, nodes={
            {n=G.UIT.C, config={align = "cr", padding = 0.01, r = 0.1, colour = G.GAME.badarg[handname] and HEX("FF0000") or G.C.CHIPS, minw = 1.1}, nodes={
              {n=G.UIT.T, config={text = G.GAME.badarg[handname] and "BAD" or number_format(G.GAME.hands[handname].chips, 1000000), scale = 0.45, colour = G.C.UI.TEXT_LIGHT}},
              {n=G.UIT.B, config={w = 0.08, h = 0.01}}
            }},
            {n=G.UIT.T, config={text = G.GAME.hands[handname].operator and Entropy.FormatArrowMult(G.GAME.hands[handname].operator, "") or "X", scale = 0.45, colour = Entropy.get_arrow_color(G.GAME.hands[handname].operator or 0)}},
            {n=G.UIT.C, config={align = "cl", padding = 0.01, r = 0.1, colour = G.GAME.badarg[handname] and HEX("FF0000") or G.C.MULT, minw = 1.1}, nodes={
              {n=G.UIT.B, config={w = 0.08,h = 0.01}},
              {n=G.UIT.T, config={text = G.GAME.badarg[handname] and "ARG" or number_format(G.GAME.hands[handname].mult, 1000000), scale = 0.45, colour = G.C.UI.TEXT_LIGHT}}
            }}
          }},
          {n=G.UIT.C, config={align = "cm"}, nodes={
              {n=G.UIT.T, config={text = '  #', scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
            }},
          {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.L_BLACK,r = 0.1, minw = 0.9}, nodes={
            {n=G.UIT.T, config={text = G.GAME.hands[handname].played, scale = 0.45, colour = G.C.FILTER, shadow = true}},
          }}
        }}
      or {n=G.UIT.R, config={align = "cm", padding = 0.05, r = 0.1, colour = darken(G.C.JOKER_GREY, 0.1), force_focus = true, emboss = 0.05, hover = true, on_demand_tooltip = {text = localize(handname, 'poker_hand_descriptions'), filler = {func = create_UIBox_hand_tip, args = handname}}, focus_args = {snap_to = (simple and handname == 'Straight Flush')}}, nodes={
        {n=G.UIT.C, config={align = "cm", padding = 0, minw = 5}, nodes={
            {n=G.UIT.T, config={text = localize(handname,'poker_hands'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
        }}
      }})
      or nil
    elseif G.GAME.hands[handname] and not G.GAME.hands[handname].AscensionPower then
        return hand_row_ref(handname, simple)
    else
        if not (G.GAME.hands[handname]) then return {} end
        if not G.GAME.badarg then G.GAME.badarg = {} end
        local color = (G.GAME.badarg and G.GAME.badarg[handname] and HEX("FF0000")) or (G.GAME.hands[handname].TranscensionPower and HEX("84e1ff")) or G.C.GOLD
        return (G.GAME.hands[handname].visible) and
        (not simple and
          {n=G.UIT.R, config={align = "cm", padding = 0.05, r = 0.1, colour = darken(G.C.JOKER_GREY, 0.1), emboss = 0.05, hover = true, force_focus = true, on_demand_tooltip = {text = localize(handname, 'poker_hand_descriptions'), filler = {func = create_UIBox_hand_tip, args = handname}}}, nodes={
            {n=G.UIT.C, config={align = "cl", padding = 0, minw = 5}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.BLACK,r = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", padding = 0.01, r = 0.1, colour = to_big(G.GAME.hands[handname].level) < to_big(2) and G.C.UI.TEXT_LIGHT or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands[handname].level))], minw = 1.1}, nodes={
                      {n=G.UIT.T, config={text = localize('k_level_prefix')..number_format(G.GAME.hands[handname].level, 1000000), scale = 0.45, colour = G.C.UI.TEXT_DARK}},
                    }},
                    {n=G.UIT.T, config={text = "+", scale = 0.45, colour = color}},
                    {n=G.UIT.C, config={align = "cm", padding = 0.01, r = 0.1, colour = color, minw = 0.7}, nodes={
                      {n=G.UIT.T, config={text = ""..number_format(to_big(G.GAME.hands[handname].AscensionPower) ^ to_big(G.GAME.hands[handname].TranscensionPower or 1), 1000000), scale = 0.45, colour = G.C.UI.TEXT_LIGHT}}
                    }}
                  }},
              {n=G.UIT.C, config={align = "cm", minw = 3.8, maxw = 3.8}, nodes={
                {n=G.UIT.T, config={text = ' '..localize(handname,'poker_hands'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
              }}
            }},
            {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.BLACK,r = 0.1}, nodes={
              {n=G.UIT.C, config={align = "cr", padding = 0.01, r = 0.1, colour = color, minw = 1.1}, nodes={
                {n=G.UIT.T, config={text = G.GAME.badarg[handname] and "BAD" or number_format(Entropy.ascend_hand(G.GAME.hands[handname].chips,handname), 1000000), scale = 0.45, colour = G.C.UI.TEXT_LIGHT}},
                {n=G.UIT.B, config={w = 0.08, h = 0.01}}
              }},
              {n=G.UIT.T, config={text = G.GAME.hands[handname].operator and Entropy.FormatArrowMult(G.GAME.hands[handname].operator, "") or "X", scale = 0.45, colour = color}},
              {n=G.UIT.C, config={align = "cl", padding = 0.01, r = 0.1, colour = color, minw = 1.1}, nodes={
                {n=G.UIT.B, config={w = 0.08,h = 0.01}},
                {n=G.UIT.T, config={text = G.GAME.badarg[handname] and "ARG" or number_format(Entropy.ascend_hand(G.GAME.hands[handname].mult,handname), 1000000), scale = 0.45, colour = G.C.UI.TEXT_LIGHT}}
              }}
            }},
            {n=G.UIT.C, config={align = "cm"}, nodes={
                {n=G.UIT.T, config={text = '  #', scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
              }},
            {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.L_BLACK,r = 0.1, minw = 0.9}, nodes={
              {n=G.UIT.T, config={text = G.GAME.hands[handname].played, scale = 0.45, colour = G.C.FILTER, shadow = true}},
            }}
          }}
        or {n=G.UIT.R, config={align = "cm", padding = 0.05, r = 0.1, colour = darken(G.C.JOKER_GREY, 0.1), force_focus = true, emboss = 0.05, hover = true, on_demand_tooltip = {text = localize(handname, 'poker_hand_descriptions'), filler = {func = create_UIBox_hand_tip, args = handname}}, focus_args = {snap_to = (simple and handname == 'Straight Flush')}}, nodes={
          {n=G.UIT.C, config={align = "cm", padding = 0, minw = 5}, nodes={
              {n=G.UIT.T, config={text = localize(handname,'poker_hands'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
          }}
        }})
        or nil
    end
end


function Entropy.ascend_hand(num, hand) -- edit this function at your leisure
    local ret = Cryptid.ascend(num, (G.GAME.hands[hand].AscensionPower or 0))
    return ret
end

function Entropy.ReverseSuitUse(self, card, area, copier, num)
  local handnames = card.ability.handnames
  local declare = {
    cry_Declare0 = true,
    cry_Declare1 = true,
    cry_Declare2 = true
  }
  for i, v in pairs(handnames) do
    if not declare[v] or G.GAME.hands[v].declare_cards then
      Entropy.ReversePlanetUse(v, card, (card.ability.level + (G.GAME.entr_black_dwarf or 0)) * (num or 1))
    end
  end
end
function Entropy.ReverseSuitLocVars(self, q, card, instant, noengulf)
  return {
    vars = {
      localize(card.ability.handnames[1], "poker_hands"),
      localize(card.ability.handnames[2], "poker_hands"),
      localize(card.ability.handnames[3], "poker_hands"),
      number_format(G.GAME.hands[card.ability.handnames[1]].level),
      number_format(G.GAME.hands[card.ability.handnames[2]].level),
      number_format(G.GAME.hands[card.ability.handnames[3]].level),
      (card.ability.level or 1) + (G.GAME.entr_black_dwarf or 0),
      G.GAME.hands[card.ability.handnames[1]].AscensionPower and " + "..number_format(G.GAME.hands[card.ability.handnames[1]].AscensionPower) or "",
      G.GAME.hands[card.ability.handnames[2]].AscensionPower and " + "..number_format(G.GAME.hands[card.ability.handnames[2]].AscensionPower) or "",
      G.GAME.hands[card.ability.handnames[3]].AscensionPower and " + "..number_format(G.GAME.hands[card.ability.handnames[3]].AscensionPower) or "",
      colours = {
        (
          to_big(G.GAME.hands[card.ability.handnames[1]].level) == to_big(1) and G.C.UI.TEXT_DARK
          or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands[card.ability.handnames[1]].level))]
        ),
        (
          to_big(G.GAME.hands[card.ability.handnames[2]].level) == to_big(1) and G.C.UI.TEXT_DARK
          or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands[card.ability.handnames[2]].level))]
        ),
        (
          to_big(G.GAME.hands[card.ability.handnames[3]].level) == to_big(1) and G.C.UI.TEXT_DARK
          or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands[card.ability.handnames[3]].level))]
        ),
      },
    },
  }
end

function Entropy.ChunkLocVars(self, q, card, instant, noengulf)
  return {
    vars = {
      G.GAME.hands[card.ability.handnames[1]].declare_cards and localize(card.ability.handnames[1], "poker_hands") or localize("cry_code_empty"),
      G.GAME.hands[card.ability.handnames[2]].declare_cards and localize(card.ability.handnames[2], "poker_hands") or localize("cry_code_empty"),
      G.GAME.hands[card.ability.handnames[3]].declare_cards and localize(card.ability.handnames[3], "poker_hands") or localize("cry_code_empty"),
      number_format(G.GAME.hands[card.ability.handnames[1]].level),
      number_format(G.GAME.hands[card.ability.handnames[2]].level),
      number_format(G.GAME.hands[card.ability.handnames[3]].level),
      card.ability.level or 1,
      G.GAME.hands[card.ability.handnames[1]].AscensionPower and " + "..number_format(G.GAME.hands[card.ability.handnames[1]].AscensionPower) or "",
      G.GAME.hands[card.ability.handnames[2]].AscensionPower and " + "..number_format(G.GAME.hands[card.ability.handnames[2]].AscensionPower) or "",
      G.GAME.hands[card.ability.handnames[3]].AscensionPower and " + "..number_format(G.GAME.hands[card.ability.handnames[3]].AscensionPower) or "",
      colours = {
        (
          to_big(G.GAME.hands[card.ability.handnames[1]].level) == to_big(1) and G.C.UI.TEXT_DARK
          or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands[card.ability.handnames[1]].level))]
        ),
        (
          to_big(G.GAME.hands[card.ability.handnames[2]].level) == to_big(1) and G.C.UI.TEXT_DARK
          or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands[card.ability.handnames[2]].level))]
        ),
        (
          to_big(G.GAME.hands[card.ability.handnames[3]].level) == to_big(1) and G.C.UI.TEXT_DARK
          or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands[card.ability.handnames[3]].level))]
        ),
      },
    },
  }
end

function Entropy.ReversePlanetUse(handname, card, amt)
  if next(SMODS.find_card("j_entr_strawberry_pie")) and handname ~= "High Card" then
    handname = "High Card"
  end
  if not card then card = {ability={level=1}} end
  local level = amt
  amt = 1
  local used_consumable = copier or card
  local c = copy_table(G.C.UI_CHIPS)
  local m = copy_table(G.C.UI_MULT)
  delay(0.4)
  update_hand_text(
    { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
    { handname = localize(handname,'poker_hands'), chips = "...", mult = "...", level = "..." }
  )
  G.GAME.hands[handname].AscensionPower = to_big((G.GAME.hands[handname].AscensionPower or 0)) + to_big(level*amt) 
  delay(1.0)
  G.E_MANAGER:add_event(Event({
    trigger = "after",
    delay = 0.2,
    func = function()
      play_sound("tarot1")
      ease_colour(G.C.UI_CHIPS, HEX("ffb400"), 0.1)
      ease_colour(G.C.UI_MULT, HEX("ffb400"), 0.1)
      Cryptid.pulse_flame(0.01, sunlevel)
      if used_consumable.juice_up then used_consumable:juice_up(0.8, 0.5) end
      G.E_MANAGER:add_event(Event({
        trigger = "after",
        blockable = false,
        blocking = false,
        delay = 1.2,
        func = function()
          ease_colour(G.C.UI_CHIPS, c, 1)
          ease_colour(G.C.UI_MULT, m, 1)
          return true
        end,
      }))
      return true
    end,
  }))
  update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = (to_big(level*amt) > to_big(0) and "+" or "")..number_format(to_big(level*amt) ) })
  delay(1.6)
  if card.edition and to_big(amt or 1) > to_big(0) and not noengulf and Engulf then
    if Engulf.SpecialFuncs[card.config.center.key] then 
    else Engulf.EditionHand(card, handname, card.edition, amt, instant) end 
  end
  delay(1.6)
  update_hand_text(
    { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
    { mult = 0, chips = 0, handname = "", level = "" }
  )
  delay(1)
  G.hand:parse_highlighted()
  G.GAME.current_round.current_hand.cry_asc_num = 0
  G.GAME.current_round.current_hand.cry_asc_num_text = ""
end

local planets = {}
local order = 0

function Entropy.RegisterReversePlanet(key, handname, sprite_pos, func, cost,level, name,set_badges,loc_vars,config, new_key, calc, art, atlas)
  order = order + 1
  planets[#planets+1]={
    object_type="Consumable",
    order = order - 200,
    key = new_key,
    set = "Star",
    
    dependencies = {
      items = {
        "set_entr_inversions"
      }
    },
    atlas = atlas or "consumables",
    config = config or {
        level = level or 1,
        handname = handname
    },
    cost = cost,
    pos = sprite_pos,
    set_card_type_badge = set_badges,
    
    
    can_bulk_use = true,
    use = function(self, card, area, copier)
        if func then func(self, card,area,copier) else Entropy.ReversePlanetUse(card.ability.handname, card, ((G.GAME.entr_black_dwarf or 0) + card.ability.level)) end
    end,
    bulk_use = function(self, card, area, copier, number)
      if func then func(self, card,area,copier,number) else Entropy.ReversePlanetUse(card.ability.handname, card, ((G.GAME.entr_black_dwarf or 0) + card.ability.level) * number) end
    end,
    can_use = function(self, card)
        return true
	  end,
    loc_vars = loc_vars or function(self, q, card)
        if G.GAME.hands[card.ability.handname] then
            return {
              vars = {
                G.GAME.hands[card.ability.handname].level,
                G.GAME.hands[card.ability.handname].AscensionPower and (" + "..G.GAME.hands[card.ability.handname].AscensionPower.."") or "",
                localize(card.ability.handname,'poker_hands'),
                card.ability.level + (G.GAME.entr_black_dwarf or 0),
                colours = {
                  to_big(G.GAME.hands[card.ability.handname].level) < to_big(2) and G.C.BLACK or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands[card.ability.handname].level))]
                }
              }
            }
        end
    end,
    in_pool = function(self, args)
      if G.GAME.hands[self.config.handname] and G.GAME.hands[self.config.handname].visible then return true end
      return false
    end,
    calculate = calc or function(self, card, context)
      if
        G.GAME.used_vouchers.v_observatory
        and context.joker_main
        and (
          context.scoring_name == card.ability.handname
        )
      then
        local value = G.P_CENTERS.v_observatory.config.extra
        return {
          asc = to_big(value) ^ (card.ability.overflow_amount or 1),
        }
      end
    end,
    demicoloncompat = true,
    force_use = function(self, card, area)
      self:use(card, area)
    end,
    entr_credits = art and {
      art = {art}
    } or nil
  }
  return planets[#planets]
end

function Entropy.bdwarf(self, card, area, copier, number)
  local used_consumable = card or copier or {}
  number = number or 1
  local c = copy_table(G.C.UI_CHIPS)
  local m = copy_table(G.C.UI_MULT)
  update_hand_text(
    { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
    { handname = localize("k_level_asc"), chips = "...", mult = "...", level = "..." }
  )
  delay(1.0)
  G.E_MANAGER:add_event(Event({
    trigger = "after",
    delay = 0.2,
    func = function()
      play_sound("tarot1")
      ease_colour(G.C.UI_CHIPS, HEX("ffb400"), 0.1)
      ease_colour(G.C.UI_MULT, HEX("ffb400"), 0.1)
      Cryptid.pulse_flame(0.01, sunlevel)
      if used_consumable.juice_up then used_consumable:juice_up(0.8, 0.5) end
      G.E_MANAGER:add_event(Event({
        trigger = "after",
        blockable = false,
        blocking = false,
        delay = 1.2,
        func = function()
          ease_colour(G.C.UI_CHIPS, c, 1)
          ease_colour(G.C.UI_MULT, m, 1)
          return true
        end,
      }))
      return true
    end,
  }))
  update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+"..number_format(card.ability.bdwarf*number) })
  delay(2.6)
  update_hand_text(
    { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
    { mult = 0, chips = 0, handname = "", level = "" }
  )
  G.GAME.entr_black_dwarf = (G.GAME.entr_black_dwarf or 0) + card.ability.bdwarf*number
  delay(1.6)
  Cryptid.reset_to_none()
end

Entropy.ReversePlanets = {
  {name="Pair",key="mercury",sprite_pos={x=7,y=0}, new_key="hydrae", art="Binary"},
  {name="Three of a Kind",key="venus",sprite_pos={x=8,y=0},new_key="vega", art="Binary"},
  {name="Full House",key="earth",sprite_pos={x=9,y=0},new_key="polaris", art="Binary"},
  {name="Four of a Kind",key="mars",sprite_pos={x=10,y=0},new_key="cassiopeiae", art="Binary"},
  {name="Flush",key="jupiter",sprite_pos={x=11,y=0},new_key="pegasi", art="Binary"},
  {name="Straight",key="saturn",sprite_pos={x=12,y=0},new_key="persei", art="Binary"},
  {name="Two Pair",key="uranus",sprite_pos={x=6,y=1},new_key="ophiuchi", art="Binary"},
  {name="Straight Flush",key="neptune",sprite_pos={x=7,y=1},new_key="carinae", art="Binary"},
  {name="High Card",key="pluto",sprite_pos={x=6,y=0},new_key="regulus", art="Binary"},
  {name="Five of a Kind",key="planet_x",sprite_pos={x=9,y=1},new_key="tauri", art="Binary"},
  {name="Flush House",key="ceres",sprite_pos={x=8,y=1},new_key="procyon", art="Binary"},
  {name="Flush Five",key="eris",sprite_pos={x=10,y=1},new_key="sirius", art="Binary"},
}
-- putting this here its easier because of how dumb the system is
if SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load then
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="", key="planetlua",sprite_pos={x=8,y=2}, new_key="starlua", prefix = "cry",config = {
    level = 1,
    odds = 5
  },
  loc_vars = function(self,q,card) 
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.odds)
    return {
      vars = {
        numerator,
        denominator,
        card.ability.level,
      }
    }
  end,
  func = function(self,card,area,copier,number)
    if number and number ~= 1 then
      Entropy.StarLuaBulk(self,card,area,copier,number)
    else
      Entropy.StarLuaSingle(self,card,area,copier)
    end
  end,
  calc = function(self, card, context)
    if
      G.GAME.used_vouchers.v_observatory
      and context.joker_main
      and (
        context.scoring_name == card.ability.handname
      )
      and pseudorandom("starlua") < 0.25
    then
      local value = G.P_CENTERS.v_observatory.config.extra
      return {
        asc = to_big(value) ^ (card.ability.overflow_amount or 1),
      }
    end
  end
  }
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="cry_Bulwark", new_key = "dyson_swarm", key="asteroidbelt",sprite_pos={x=12,y=1},prefix = "cry",set_badges = function(self, card, badges)
    badges[1] = create_badge(localize("k_planet_dyson_swarm"), get_type_colour(self or card.config, card), nil, 1.2)
  end, art="Binary"}
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="cry_Clusterfuck", new_key = "dark_matter", key="void",sprite_pos={x=11,y=1},prefix = "cry",set_badges = function(self, card, badges)
    badges[1] = create_badge("", get_type_colour(self or card.config, card), nil, 1.2)
  end, art="Binary"}
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="cry_UltPair", key="marsmoons", new_key = "binarystars", sprite_pos={x=6,y=2},prefix = "cry",set_badges = function(self, card, badges)
    badges[1] = create_badge(localize("k_planet_binary_star"), get_type_colour(self or card.config, card), nil, 1.2)
  end, art="Binary"}
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="cry_None", key="nibiru", new_key = "deadcore", sprite_pos={x=11,y=2},prefix = "cry",set_badges = function(self, card, badges)
    
		if badges[1] and badges[1].remove then
			badges[1]:remove()
		end
		badges[1] = nil
  end}
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="cry_WholeDeck", key="universe", new_key = "multiverse", sprite_pos={x=7,y=2},prefix = "cry",set_badges = function(self, card, badges)
    badges[1] = create_badge(localize("k_planet_multiverse"), get_type_colour(self or card.config, card), nil, 1.2)
  end}
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="", key="nstar", new_key = "strange_star", sprite_pos={x=9,y=2},prefix = "cry",
  loc_vars = function(self,q,card) 
    return {
      vars = {
        G.GAME.strange_star or 0,
        card.ability.level
      }
    }
  end,
  func = function(self,card,area,copier,number)
    Entropy.StrangeSingle(self,card,area,copier,number)
  end,
  calc = function() end, art="Binary"
  }
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="", key="sunplanet", new_key = "nemesis", sprite_pos={x=10,y=2},prefix = "cry", config = {extra = 0.1},
    loc_vars = function(self,q,card) 
      local levelone = (G.GAME.nemesislevel and G.GAME.nemesislevel or 0) + 1
      local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
      if levelone == 1 then
        planetcolourone = G.C.UI.TEXT_DARK
      end
      local str = "X("..((G.GAME.sunnumber and G.GAME.sunnumber.not_modest or 0) + 1.25).."^"..(G.GAME.nemesisnumber and G.GAME.nemesisnumber > 0 and G.GAME.nemesisnumber+1 or "").."asc)"
      if G.jokers and next(SMODS.find_card("j_entr_helios")) then
          str = "^("..((G.GAME.sunnumber and G.GAME.sunnumber.not_modest or 0) + 1.75).."X"..(G.GAME.nemesisnumber and G.GAME.nemesisnumber > 0 and G.GAME.nemesisnumber+1 or "").."asc)"
      end
      return {
        vars = {
          (G.GAME.nemesislevel or 0) + 1,
          card.ability.extra or 0.1,
          str,
          colours = { planetcolourone },
        },
      }
    end,
    func = function(self,card,area,copier,number)
      number = number or 1
      local used_consumable = copier or card
      local nemesislevel = (G.GAME.nemesislevel and G.GAME.nemesislevel or 0) + number
      G.GAME.nemesislevel = (G.GAME.nemesislevel or 0) + number
      delay(0.4)
      update_hand_text(
        { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
        { handname = localize("cry_asc_hands"), chips = "...", mult = "...", level = to_big(nemesislevel) }
      )
      delay(1.0)
      G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.2,
        func = function()
          play_sound("tarot1")
          ease_colour(G.C.UI_CHIPS, copy_table(HEX("FF0000")), 0.1)
          ease_colour(G.C.UI_MULT, copy_table(HEX("FF0000")), 0.1)
          Cryptid.pulse_flame(0.01, nemesislevel)
          used_consumable:juice_up(0.8, 0.5)
          G.E_MANAGER:add_event(Event({
            trigger = "after",
            blockable = false,
            blocking = false,
            delay = 1.2,
            func = function()
              ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
              ease_colour(G.C.UI_MULT, G.C.RED, 1)
              return true
            end,
          }))
          return true
        end,
      }))
      update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = to_big(nemesislevel + 1) })
      delay(2.6)
      G.GAME.nemesisnumber = (G.GAME.nemesisnumber or 0) + card.ability.extra * number
      update_hand_text(
        { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
        { mult = 0, chips = 0, handname = "", level = "" }
      )
    end,
    calc = function(self, card, context)
      if
        G.GAME.used_vouchers.v_observatory
        and context.joker_main
      then
        local value = G.P_CENTERS.v_observatory.config.extra
        return {
          exp_asc = to_big(value) ^ (card.ability.overflow_amount or 1),
        }
      end
    end,
  }
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="", key="Timantii", new_key = "jatka", sprite_pos={x=8,y=3},prefix = "cry", func = Entropy.ReverseSuitUse, config = {level=1,handnames = {"High Card", "Pair", "Two Pair"}}, loc_vars = Entropy.ReverseSuitLocVars, calc=Entropy.ReverseSuitCalc}
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="", key="Klubi", new_key = "rouva", sprite_pos={x=9,y=3},prefix = "cry", func = Entropy.ReverseSuitUse, config = {level=1,handnames = {"Three of a Kind", "Straight", "Flush"}}, loc_vars = Entropy.ReverseSuitLocVars, calc=Entropy.ReverseSuitCalc}
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="", key="Sydan", new_key = "paras", sprite_pos={x=10,y=3},prefix = "cry", func = Entropy.ReverseSuitUse, config = {level=1,handnames = {"Full House", "Four of a Kind", "Straight Flush"}}, loc_vars = Entropy.ReverseSuitLocVars, calc=Entropy.ReverseSuitCalc}
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="", key="Lapio", new_key = "assa", sprite_pos={x=11,y=3},prefix = "cry", func = Entropy.ReverseSuitUse, config = {level=1,handnames = {"Five of a Kind", "Flush House", "Flush Five"}}, loc_vars = Entropy.ReverseSuitLocVars, calc=Entropy.ReverseSuitCalc}
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="", key="Kaikki", new_key = "kivi", sprite_pos={x=12,y=3},prefix = "cry", func = Entropy.ReverseSuitUse, config = {level=1,handnames = {"cry_Bulwark", "cry_Clusterfuck", "cry_UltPair"}}, loc_vars = Entropy.ReverseSuitLocVars, calc=Entropy.ReverseSuitCalc}
  Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="", key="voxel", new_key = "chunk", sprite_pos={x=1,y=7},prefix = "cry", func = Entropy.ReverseSuitUse, config = {level=1,handnames = {"cry_Declare0", "cry_Declare1", "cry_Declare2"}}, loc_vars = Entropy.ChunkLocVars, calc=Entropy.ReverseSuitCalc}
end
Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="entr_derivative",key="wormhole",sprite_pos={x=4,y=0}, new_key="pocket_dimension", prefix = "entr", atlas = "consumables2", set_badges = function(self, card, badges)
  badges[1] = create_badge(localize("k_spatial_anomaly"), get_type_colour(self or card.config, card), nil, 1.2)
end}
Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="",key="tyche",sprite_pos={x=0,y=2}, new_key="black_dwarf", prefix = "entr", atlas = "consumables2", set_badges = function(self, card, badges)
  badges[1] = create_badge(localize("k_star_q"), get_type_colour(self or card.config, card), nil, 1.2)
end, func = Entropy.bdwarf, config = {bdwarf = 0.25}, loc_vars = function(self, q, card) return {vars = {card.ability.bdwarf}} end}
Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="",key="theia",sprite_pos={x=1,y=2}, new_key="frozen_star", prefix = "entr", atlas = "consumables2", set_badges = function(self, card, badges)
  badges[1] = create_badge(localize("k_star_q"), get_type_colour(self or card.config, card), nil, 1.2)
end, func = function(self, card, area, copier, number)
  local hand = "High Card"
  for i, v in pairs(G.GAME.hands) do
    if to_big(v.level) > to_big(G.GAME.hands[hand].level) then
      hand = i
    end
  end
  Entropy.ReversePlanetUse(hand, card, card.ability.amt + (G.GAME.entr_black_dwarf or 0))
end, config = {amt = 0.5}, loc_vars = function(self, q, card) return {vars = {card.ability.amt + (G.GAME.entr_black_dwarf or 0)}} end}

Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="",key="chiron",sprite_pos={x=2,y=2}, new_key="coatlicue", prefix = "entr", atlas = "consumables2", set_badges = function(self, card, badges)
  badges[1] = create_badge(localize("k_star_q"), get_type_colour(self or card.config, card), nil, 1.2)
end, func = function(self, card, copier, area, number) 
  local hands = {}
  for i, v in pairs(G.GAME.hands) do
    if v.visible then
      hands[#hands+1] = i
    end
  end
  local hand = pseudorandom_element(hands, pseudoseed("entr_coatlicue"))
  Entropy.ReversePlanetUse(hand, card, G.GAME.hands[hand].l_chips / 25 + (G.GAME.entr_black_dwarf or 0))
end, config = {bdwarf = 0.5}, loc_vars = function(self, q, card) return {vars = {card.ability.bdwarf}} end}

Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="",key="neith",sprite_pos={x=3,y=2}, new_key="threefour", prefix = "entr", atlas = "consumables2", set_badges = function(self, card, badges)
  badges[1] = create_badge(localize("k_star_q"), get_type_colour(self or card.config, card), nil, 1.2)
end, func = function(self, card, copier, area, number) 
  local hands = {}
  for i, v in pairs(G.GAME.hands) do
    if v.visible then
      hands[#hands+1] = i
    end
  end
  local hand = pseudorandom_element(hands, pseudoseed("entr_threefour"))
  Entropy.ReversePlanetUse(hand, card, G.GAME.hands[hand].l_mult / 3 + (G.GAME.entr_black_dwarf or 0))
end, config = {bdwarf = 0.5}, loc_vars = function(self, q, card) return {vars = {card.ability.bdwarf}} end}

Entropy.ReversePlanets[#Entropy.ReversePlanets+1] = {name="",key="sputnik",sprite_pos={x=4,y=2}, new_key="fuzzball", prefix = "entr", atlas = "consumables2", set_badges = function(self, card, badges)
  badges[1] = create_badge(localize("k_spatial_anomaly"), get_type_colour(self or card.config, card), nil, 1.2)
end, func = function(self, card, area, copier, number)
  local hands = {}
  for i, v in pairs(G.GAME.hands) do
    if v.visible then
      hands[#hands+1] = i
    end
  end
  pseudoshuffle(hands, pseudoseed("entr_sputnik"))
  for i = 1, math.min(card.ability.hands, #hands) do
    Entropy.ReversePlanetUse(hands[i], card, card.ability.amt + (G.GAME.entr_black_dwarf or 0))
  end
end, config = {amt = 1, hands = 3}, loc_vars = function(self, q, card) return {vars = {card.ability.hands, card.ability.amt + (G.GAME.entr_black_dwarf or 0)}} end}

function Entropy.RegisterReversePlanets()
  Entropy.StarLocs = {}
    for i, v in pairs(Entropy.ReversePlanets) do
		Entropy.RegisterReversePlanet(v.key,v.name,v.sprite_pos,v.func,v.cost,v.level,v.name,v.set_badges,v.loc_vars,v.config,v.new_key, v.calc, v.art, v.atlas)
        planets[#planets].inversion = "c_"..((v.prefix and v.prefix.."_") or "")..v.key
	end
end


Entropy.RegisterReversePlanets()

function Entropy.StarLuaSingle(self,card,area,copier)
  local used_consumable = copier or card
  if
  SMODS.pseudorandom_probability(card, 'starlua', 1, card.ability.odds)
  then --Code "borrowed" from black hole
    delay(0.4)
    update_hand_text(
      { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
      { handname = localize("k_all_hands"), chips = "...", mult = "...", level = "", }
    )
    for i, v in pairs(G.GAME.hands) do
      v.AscensionPower = (v.AscensionPower or 0) + card.ability.level
    end
    delay(1.0)
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.2,
      func = function()
        play_sound("tarot1")
        ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.1)
        ease_colour(G.C.UI_MULT, copy_table(G.C.GOLD), 0.1)
        Cryptid.pulse_flame(0.01, 1)
        used_consumable:juice_up(0.8, 0.5)
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          blockable = false,
          blocking = false,
          delay = 1.2,
          func = function()
            ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
            ease_colour(G.C.UI_MULT, G.C.RED, 1)
            return true
          end,
        }))
        return true
      end,
    }))
    update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+1" })
    delay(2.6)
    update_hand_text(
      { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
      { mult = 0, chips = 0, handname = "", level = "" }
    )
  else
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.4,
      func = function() --"borrowed" from Wheel Of Fortune
        attention_text({
          text = localize("k_nope_ex"),
          scale = 1.3,
          hold = 1.4,
          major = used_consumable,
          backdrop_colour = G.C.SECONDARY_SET.Planet,
          align = (
            G.STATE == G.STATES.TAROT_PACK
            or G.STATE == G.STATES.SPECTRAL_PACK
            or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
          )
              and "tm"
            or "cm",
          offset = {
            x = 0,
            y = (
              G.STATE == G.STATES.TAROT_PACK
              or G.STATE == G.STATES.SPECTRAL_PACK
              or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
            )
                and -0.2
              or 0,
          },
          silent = true,
        })
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.06 * G.SETTINGS.GAMESPEED,
          blockable = false,
          blocking = false,
          func = function()
            play_sound("tarot2", 0.76, 0.4)
            return true
          end,
        }))
        play_sound("tarot2", 1, 0.4)
        used_consumable:juice_up(0.3, 0.5)
        return true
      end,
    }))
  end
end

function Entropy.StarLuaBulk(self,card,area,copier,number)
  local used_consumable = copier or card
  if
  SMODS.pseudorandom_probability(card, 'starlua', 1 * number, card.ability.odds)
  then --Code "borrowed" from black hole
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.odds)
    local quota = numerator*number / denominator
    delay(0.4)
    update_hand_text(
      { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
      { handname = localize("k_all_hands"), chips = "...", mult = "...", level = "", }
    )
    for i, v in pairs(G.GAME.hands) do
      v.AscensionPower = (v.AscensionPower or 0) + card.ability.level*number*quota
    end
    delay(1.0)
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.2,
      func = function()
        play_sound("tarot1")
        ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.1)
        ease_colour(G.C.UI_MULT, copy_table(G.C.GOLD), 0.1)
        Cryptid.pulse_flame(0.01, 1)
        used_consumable:juice_up(0.8, 0.5)
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          blockable = false,
          blocking = false,
          delay = 1.2,
          func = function()
            ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
            ease_colour(G.C.UI_MULT, G.C.RED, 1)
            return true
          end,
        }))
        return true
      end,
    }))
    update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+1" })
    delay(2.6)
    update_hand_text(
      { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
      { mult = 0, chips = 0, handname = "", level = "" }
    )
  else
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.4,
      func = function() --"borrowed" from Wheel Of Fortune
        attention_text({
          text = localize("k_nope_ex"),
          scale = 1.3,
          hold = 1.4,
          major = used_consumable,
          backdrop_colour = G.C.SECONDARY_SET.Planet,
          align = (
            G.STATE == G.STATES.TAROT_PACK
            or G.STATE == G.STATES.SPECTRAL_PACK
            or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
          )
              and "tm"
            or "cm",
          offset = {
            x = 0,
            y = (
              G.STATE == G.STATES.TAROT_PACK
              or G.STATE == G.STATES.SPECTRAL_PACK
              or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
            )
                and -0.2
              or 0,
          },
          silent = true,
        })
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.06 * G.SETTINGS.GAMESPEED,
          blockable = false,
          blocking = false,
          func = function()
            play_sound("tarot2", 0.76, 0.4)
            return true
          end,
        }))
        play_sound("tarot2", 1, 0.4)
        used_consumable:juice_up(0.3, 0.5)
        return true
      end,
    }))
  end
end

function Entropy.StrangeSingle(self, card, area, copier,num)
  local used_consumable = copier or card
  --Get amount of Neutron stars use this run or set to 0 if nil
  G.GAME.strange_star = G.GAME.strange_star or 0

  --Add +1 to amount of neutron stars used this run
  G.GAME.strange_star = G.GAME.strange_star + 1
  local handname = Cryptid.get_random_hand(nil, "sstar" .. G.GAME.round_resets.ante) --Random poker hand
  delay(0.4)
  update_hand_text(
    { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
    { handname = localize(handname,'poker_hands'), chips = "...", mult = "...", level = number_format(G.GAME.hands[handname].AscensionPower or 0 + G.GAME.hands[handname].level or 0, 1000000) }
  )
  G.GAME.hands[handname].AscensionPower = (G.GAME.hands[handname].AscensionPower or 0) + G.GAME.strange_star*(num or 1)
  delay(1.0)
  G.E_MANAGER:add_event(Event({
    trigger = "after",
    delay = 0.2,
    func = function()
      play_sound("tarot1")
      ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.1)
      ease_colour(G.C.UI_MULT, copy_table(G.C.GOLD), 0.1)
      Cryptid.pulse_flame(0.01, sunlevel)
      used_consumable:juice_up(0.8, 0.5)
      G.E_MANAGER:add_event(Event({
        trigger = "after",
        blockable = false,
        blocking = false,
        delay = 1.2,
        func = function()
          ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
          ease_colour(G.C.UI_MULT, G.C.RED, 1)
          return true
        end,
      }))
      return true
    end,
  }))
  update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = to_big(G.GAME.hands[handname].AscensionPower + G.GAME.hands[handname].level) })
  delay(2.6)
  update_hand_text(
    { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
    { mult = 0, chips = 0, handname = "", level = "" }
  )
end

function Entropy.ReverseSuitCalc(self, card, context)
  for i, v in pairs(card.ability.handnames) do
    if
      G.GAME.used_vouchers.v_observatory
      and context.joker_main
      and (
        context.scoring_name == v
      )
    then
      local value = G.P_CENTERS.v_observatory.config.extra
      return {
        asc = to_big(value) ^ (card.ability.overflow_amount or 1),
      }
    end
  end
end

return {
  items = planets
}

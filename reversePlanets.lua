local hand_row_ref = create_UIBox_current_hand_row
function create_UIBox_current_hand_row(handname, simple)
    if not G.GAME.hands[handname].AscensionPower then
        return hand_row_ref(handname, simple)
    else
        return (G.GAME.hands[handname].visible) and
        (not simple and
          {n=G.UIT.R, config={align = "cm", padding = 0.05, r = 0.1, colour = darken(G.C.JOKER_GREY, 0.1), emboss = 0.05, hover = true, force_focus = true, on_demand_tooltip = {text = localize(handname, 'poker_hand_descriptions'), filler = {func = create_UIBox_hand_tip, args = handname}}}, nodes={
            {n=G.UIT.C, config={align = "cl", padding = 0, minw = 5}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.BLACK,r = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", padding = 0.01, r = 0.1, colour = G.C.UI.TEXT_LIGHT, minw = 1.1}, nodes={
                      {n=G.UIT.T, config={text = localize('k_level_prefix')..number_format(G.GAME.hands[handname].level, 1000000), scale = 0.45, colour = G.C.UI.TEXT_DARK}},
                    }},
                    {n=G.UIT.T, config={text = "+", scale = 0.45, colour = G.C.GOLD}},
                    {n=G.UIT.C, config={align = "cm", padding = 0.01, r = 0.1, colour = G.C.GOLD, minw = 0.7}, nodes={
                      {n=G.UIT.T, config={text = ""..number_format(G.GAME.hands[handname].AscensionPower, 1000000), scale = 0.45, colour = G.C.UI.TEXT_LIGHT}}
                    }}
                  }},
              {n=G.UIT.C, config={align = "cm", minw = 3.8, maxw = 3.8}, nodes={
                {n=G.UIT.T, config={text = ' '..localize(handname,'poker_hands'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
              }}
            }},
            {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.BLACK,r = 0.1}, nodes={
              {n=G.UIT.C, config={align = "cr", padding = 0.01, r = 0.1, colour = G.C.GOLD, minw = 1.1}, nodes={
                {n=G.UIT.T, config={text = number_format(Entropy.ascend_hand(G.GAME.hands[handname].chips,handname), 1000000), scale = 0.45, colour = G.C.UI.TEXT_LIGHT}},
                {n=G.UIT.B, config={w = 0.08, h = 0.01}}
              }},
              {n=G.UIT.T, config={text = "X", scale = 0.45, colour = G.C.GOLD}},
              {n=G.UIT.C, config={align = "cl", padding = 0.01, r = 0.1, colour = G.C.GOLD, minw = 1.1}, nodes={
                {n=G.UIT.B, config={w = 0.08,h = 0.01}},
                {n=G.UIT.T, config={text = number_format(Entropy.ascend_hand(G.GAME.hands[handname].mult,handname), 1000000), scale = 0.45, colour = G.C.UI.TEXT_LIGHT}}
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
	if Cryptid.enabled("set_cry_poker_hand_stuff") ~= true then
		return num
	end
	if Cryptid.gameset() == "modest" then
		-- x(1.1 + 0.05 per sol) base, each card gives + (0.1 + 0.05 per sol)
		if not G.GAME.current_round.current_hand.cry_asc_num then
			return num
		end
		if G.GAME.current_round.current_hand.cry_asc_num <= 0 then
			return num
		end
		return math.max(
			num,
			num
				* (
					1
					+ 0.1
					+ to_big(0.05 * (G.GAME.sunnumber or 0))
					+ to_big((0.1 + (0.05 * (G.GAME.sunnumber or 0))) * to_big(G.GAME.hands[hand].AscensionPower or 0))
				)
		)
  elseif HasJoker("j_entr_helios") then
		local curr = 1.5
        for i, v in pairs(G.jokers.cards) do
            if v.config.center.key == "j_entr_helios" and to_big(v.ability.extra):gt(curr) then curr = v.ability.extra+0.4 end
        end
		return math.max(
			num,
			num
				* to_big(
					(1.75 + ((G.GAME.sunnumber or 0)))):tetrate(
						to_big(G.GAME.hands[hand].AscensionPower * curr))
		)
	else
		return math.max(
			num,
			num * to_big((1.25 + (0.05 * (G.GAME.sunnumber or 0))) ^ to_big(G.GAME.hands[hand].AscensionPower or 0))
		)
  end
end


function Entropy.ReversePlanetUse(handname, card, amt)
  amt = amt or 1
  local used_consumable = copier or card
  local sunlevel = (G.GAME.sunlevel and G.GAME.sunlevel or 0) + 1
  G.GAME.sunlevel = (G.GAME.sunlevel or 0) + 1
  delay(0.4)
  update_hand_text(
    { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
    { handname = localize(handname,'poker_hands'), chips = "...", mult = "...", level = number_format(G.GAME.hands[handname].level, 1000000) }
  )
  G.GAME.hands[handname].AscensionPower = (G.GAME.hands[handname].AscensionPower or 0) + card.ability.level*amt
  G.GAME.hands[handname].visible = true
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
  update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = to_big(G.GAME.hands[handname].AscensionPower + card.ability.level*amt) })
  delay(2.6)
  update_hand_text(
    { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
    { mult = 0, chips = 0, handname = "", level = "" }
  )
end

SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "RPlanet",
	primary_colour = HEX("845baa"),
	secondary_colour = HEX("845baa"),
	collection_rows = { 6, 6 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_pluto"
})


function Entropy.RegisterReversePlanet(key, handname, sprite_pos, func, cost,level, name,set_badges)
  --this is bad but im lazy
  SMODS.Consumable({
    key = key,
    set = "RPlanet",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {
        level = level or 1,
        handname = handname
    },
    cost = cost,
    pos = sprite_pos,
    set_card_type_badge = set_badges,
    use = function(self, card, area, copier)
        if func then func(self, card,area,copier) else Entropy.ReversePlanetUse(card.ability.handname, card) end
    end,
    bulk_use = function(self, card, area, copier, number)
      if func then func(self, card,area,copier,number) else Entropy.ReversePlanetUse(card.ability.handname, card,number) end
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
          vars = {
            G.GAME.hands[card.ability.handname].level,
            G.GAME.hands[card.ability.handname].AscensionPower and (" + "..G.GAME.hands[card.ability.handname].AscensionPower.."") or "",
            localize(card.ability.handname,'poker_hands'),
            card.ability.level,
            colours = {
              to_big(G.GAME.hands[card.ability.handname].level < to_big(2)) and G.C.BLACK or G.C.HAND_LEVELS[to_big(math.min(7, G.GAME.hands[card.ability.handname].level)):to_number()]
            }
          }
        }
    end,
  })
end
Entropy.ReversePlanets = {
  {name="High Card",key="pluto",sprite_pos={x=6,y=0}},
  {name="Pair",key="mercury",sprite_pos={x=7,y=0}},
  {name="Three of a Kind",key="venus",sprite_pos={x=8,y=0}},
  {name="Full House",key="earth",sprite_pos={x=9,y=0}},
  {name="Four of a Kind",key="mars",sprite_pos={x=10,y=0}},
  {name="Flush",key="jupiter",sprite_pos={x=11,y=0}},
  {name="Straight",key="saturn",sprite_pos={x=12,y=0}},
  {name="Two Pair",key="uranus",sprite_pos={x=6,y=1}},
  {name="Straight Flush",key="neptune",sprite_pos={x=7,y=1}},
  {name="Flush House",key="ceres",sprite_pos={x=8,y=1}},
  {name="Five of a Kind",key="planet_x",sprite_pos={x=9,y=1}},
  {name="Flush Five",key="eris",sprite_pos={x=10,y=1}},
  {name="cry_UltPair", key="marsmoons",sprite_pos={x=6,y=2},prefix = "c_cry_",set_badges = function(self, card, badges)
    badges[1] = create_badge(localize("k_planet_binary_star"), get_type_colour(self or card.config, card), nil, 1.2)
  end},
  {name="cry_Clusterfuck", key="void",sprite_pos={x=11,y=1},prefix = "c_cry_",set_badges = function(self, card, badges)
    badges[1] = create_badge("", get_type_colour(self or card.config, card), nil, 1.2)
  end},
  {name="cry_Bulwark", key="asteroidbelt",sprite_pos={x=12,y=1},prefix = "c_cry_",set_badges = function(self, card, badges)
    badges[1] = create_badge(localize("k_planet_dyson_swarm"), get_type_colour(self or card.config, card), nil, 1.2)
  end},
  {name="cry_WholeDeck", key="universe",sprite_pos={x=7,y=2},prefix = "c_cry_",set_badges = function(self, card, badges)
    badges[1] = create_badge(localize("k_planet_multiverse"), get_type_colour(self or card.config, card), nil, 1.2)
  end}
}
function Entropy.RegisterReversePlanets()
  Entropy.RPlanetLocs = {}
    for i, v in pairs(Entropy.ReversePlanets) do
		Entropy.RegisterReversePlanet(v.key,v.name,v.sprite_pos,v.func,v.cost,v.level,v.name,v.set_badges)
		Entropy.FlipsideInversions[(v.prefix or "c_")..v.key] = "c_entr_"..v.key
	end
end

Entropy.RegisterReversePlanets()
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
	else
		return math.max(
			num,
			num * to_big((1.25 + (0.05 * (G.GAME.sunnumber or 0))) ^ to_big(G.GAME.hands[hand].AscensionPower or 0))
		)
	end
end
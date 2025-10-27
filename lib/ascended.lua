local pokerhandinforef = G.FUNCS.get_poker_hand_info
function G.FUNCS.get_poker_hand_info(_cards)
	local text, loc_disp_text, poker_hands, scoring_hand, disp_text = pokerhandinforef(_cards)
	-- Display text if played hand contains a Cluster and a Bulwark
	-- Not Ascended hand related but this hooks in the same spot so i'm lumping it here anyways muahahahahahaha
    local hidden = false
    for i, v in pairs(scoring_hand) do
        if v.facing == "back" then
            hidden = true
            break
        end
    end
    -- Ascension power
    local a_power = Cryptid.calculate_ascension_power(
        text,
        _cards,
        scoring_hand,
        G.GAME.used_vouchers.v_cry_hyperspacetether,
        G.GAME.bonus_asc_power
    )
    if a_power ~= 0 then
        G.GAME.current_round.current_hand.cry_asc_num = a_power
        -- Change mult and chips colors if hand is ascended
        if not hidden then
            if G.GAME.Overflow or (G.GAME.badarg and G.GAME.badarg[text]) then
                ease_colour(G.C.UI_CHIPS, copy_table(HEX("FF0000")), 0.3)
                ease_colour(G.C.UI_MULT, copy_table(HEX("FF0000")), 0.3)
                if not G.C.UI_GOLD then G.C.UI_GOLD = G.C.GOLD end
                ease_colour(G.C.GOLD, copy_table(HEX("FF0000")), 0.3)
            else 
                ease_colour(G.C.GOLD, copy_table(HEX("EABA44")), 0.3)
                ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.3)
                ease_colour(G.C.UI_MULT, copy_table(G.C.GOLD), 0.3)
            end

            G.GAME.current_round.current_hand.cry_asc_num_text = (
                a_power
            )
                    and " (".. (to_big(a_power) >= to_big(0) and "+" or "") .. a_power .. ")"
                or ""
        else
            ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.3)
            ease_colour(G.C.UI_MULT, G.C.RED, 0.3)
            G.GAME.current_round.current_hand.cry_asc_num_text = ""
        end
    else
        G.GAME.current_round.current_hand.cry_asc_num = 0
		if G.GAME.badarg and G.GAME.badarg[text] then
            ease_colour(G.C.UI_CHIPS, copy_table(HEX("FF0000")), 0.3)
            ease_colour(G.C.UI_MULT, copy_table(HEX("FF0000")), 0.3)
		else 
			ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.3)
			ease_colour(G.C.UI_MULT, G.C.RED, 0.3)
		end
        G.GAME.current_round.current_hand.cry_asc_num_text = ""
    end
    if to_big(G.GAME.current_round.current_hand.cry_asc_num) == to_big(0) then
        ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.3)
        ease_colour(G.C.UI_MULT, G.C.RED, 0.3)
    end
	return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end

function Cryptid.calculate_ascension_power(hand_name, hand_cards, hand_scoring_cards, tether, bonus)
	bonus = bonus or 0
	local starting = 0
	if Cryptid.enabled("set_cry_poker_hand_stuff") ~= true and (SMODS.Mods["Cryptid"] or {}).can_load then
		return 0
	end
	if hand_name then
		-- Get Starting Ascension power from Poker Hands
		if hand_cards then
			local check = Cryptid.hand_ascension_numbers(hand_name, tether)
			if check then
				starting = (tether and #hand_cards or #hand_scoring_cards) - check
			end
			if Entropy.BlindIs("bl_entr_scarlet_sun") then
				starting = #hand_cards
			end
		end
		-- Extra starting calculation for Declare hands
		if G.GAME.hands[hand_name] and G.GAME.hands[hand_name].declare_cards then
			local total = 0
			for i, v in pairs(G.GAME.hands[hand_name].declare_cards or {}) do
				local how_many_fit = 0
				local suit, rank
				for i2, v2 in pairs(hand_cards) do
					if not v2.marked then
						if SMODS.has_no_rank(v2) and v.rank == "rankless" or v2:get_id() == v.rank then
							rank = true
						end
						if v2:is_suit(v.suit) or (v.suit == "suitless" and SMODS.has_no_suit(v2)) or not v.suit then
							suit = true
						end
						if not (suit and rank) then
							suit = false
							rank = false
						end
						if suit and rank then
							how_many_fit = how_many_fit + 1
							v2.marked = true
						end
					end
				end
				if not rank or not suit then
					how_many_fit = 0
				end
				total = total + how_many_fit
			end
			for i2, v2 in pairs(hand_cards) do
				v2.marked = nil
			end
			starting = starting + (total - #hand_scoring_cards)
		end
	end
	-- Get Ascension power from Exploit
	if G.GAME.cry_exploit_override then
		bonus = bonus + 1
	end
	-- Get Ascension Power From Sol (Observatory effect)
	if G.GAME.used_vouchers.v_observatory and next(find_joker("cry-sunplanet")) then
		if #find_joker("cry-sunplanet") == 1 then
			bonus = bonus + 1
		else
			bonus = bonus + Cryptid.nuke_decimals(Cryptid.funny_log(2, #find_joker("cry-sunplanet") + 1), 2)
		end
	end
	local final = math.max(0, starting + bonus)
	-- Round to 1 if final value is less than 1 but greater than 0
	if final > 0 and final < 1 then
		final = 1
	end
    if not (SMODS.Mods["Cryptid"] or {}).can_load and not next(SMODS.find_card("j_entr_hexa")) and not Entropy.BlindIs("bl_entr_scarlet_sun") then
        final = 0
    end
    if next(SMODS.find_card("j_entr_hexa")) then
        final = final * 3 * #SMODS.find_card("j_entr_hexa")
    end
    if next(SMODS.find_card("j_entr_axeh")) then
        for i, v in pairs(SMODS.find_card("j_entr_axeh")) do
            final = final * v.ability.asc_mod
        end
    end
    final = final + (G.GAME.hands[hand_name] and G.GAME.hands[hand_name].AscensionPower or 0)
    final = final * (1+(G.GAME.nemesisnumber or 0))
    if Entropy.BlindIs("bl_entr_scarlet_sun") and not G.GAME.blind.disabled then 
        final = final * (Entropy.IsEE() and -0.25 or -1)
    end
	return final
end
function Cryptid.hand_ascension_numbers(hand_name, tether)
	tether = tether or Entropy.BlindIs("bl_entr_scarlet_sun")
    Cryptid.ascension_numbers = Cryptid.ascension_numbers or {}
	if Cryptid.ascension_numbers[hand_name] and type(Cryptid.ascension_numbers[hand_name]) == "function" then
		return Cryptid.ascension_numbers[hand_name](hand_name, tether)
	end
	if hand_name == "High Card" then
		return tether and 1 or nil
	elseif hand_name == "Pair" then
		return tether and 2 or nil
	elseif hand_name == "Two Pair" then
		return 4
	elseif hand_name == "Three of a Kind" then
		return tether and 3 or nil
	elseif hand_name == "Straight" or hand_name == "Flush" or hand_name == "Straight Flush" then
		return next(SMODS.find_card("j_four_fingers")) and Cryptid.gameset() ~= "modest" and 4 or 5
	elseif
		hand_name == "Full House"
		or hand_name == "Five of a Kind"
		or hand_name == "Flush House"
		or hand_name == "cry_Bulwark"
		or hand_name == "Flush Five"
		or hand_name == "bunc_Spectrum"
		or hand_name == "bunc_Straight Spectrum"
		or hand_name == "bunc_Spectrum House"
		or hand_name == "bunc_Spectrum Five"
	then
		return 5
	elseif hand_name == "Four of a Kind" then
		return tether and 4 or nil
	elseif hand_name == "cry_Clusterfuck" or hand_name == "cry_UltPair" then
		return 8
	elseif hand_name == "cry_WholeDeck" then
		return 52
	elseif hand_name == "cry_Declare0" then
		return G.GAME.hands.cry_Declare0
			and G.GAME.hands.cry_Declare0.declare_cards
			and #G.GAME.hands.cry_Declare0.declare_cards
	elseif hand_name == "cry_Declare1" then
		return G.GAME.hands.cry_Declare1
			and G.GAME.hands.cry_Declare1.declare_cards
			and #G.GAME.hands.cry_Declare1.declare_cards
	elseif hand_name == "cry_Declare2" then
		return G.GAME.hands.cry_Declare2
			and G.GAME.hands.cry_Declare2.declare_cards
			and #G.GAME.hands.cry_Declare2.declare_cards
	elseif
		hand_name == "spa_Spectrum"
		or hand_name == "spa_Straight_Spectrum"
		or hand_name == "spa_Spectrum_House"
		or hand_name == "spa_Spectrum_Five"
		or hand_name == "spa_Flush_Spectrum"
		or hand_name == "spa_Straight_Flush_Spectrum"
		or hand_name == "spa_Flush_Spectrum_House"
		or hand_name == "spa_Flush_Spectrum_Five"
	then
		return SpectrumAPI
				and SpectrumAPI.configuration.misc.four_fingers_spectrums
				and next(SMODS.find_card("j_four_fingers"))
				and Cryptid.gameset() ~= "modest"
				and 4
			or 5
	end
	return nil
end

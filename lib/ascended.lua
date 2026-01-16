local pokerhandinforef = G.FUNCS.get_poker_hand_info
function G.FUNCS.get_poker_hand_info(_cards)
	local text, loc_disp_text, poker_hands, scoring_hand, disp_text = pokerhandinforef(_cards)
	-- Display text if played hand contains a Cluster and a Bulwark
	-- Not Ascended hand related but this hooks in the same spot so i'm lumping it here anyways muahahahahahaha
    local cards = {}
    for _, card in pairs(_cards) do
        cards[#cards+1] = card
    end
    for _, card in pairs(G.I.CARD) do
        if card.ability and card.ability.entr_marked then
            if not card.highlighted and not Entropy.InTable(_cards, card) then
                cards[#cards+1] = card
            end
        end
    end
    _cards = cards
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
            ease_colour(G.C.GOLD, copy_table(HEX("EABA44")), 0.3)
            ease_colour(G.C.UI_CHIPS, copy_table(Entropy.get_asc_colour(G.GAME.current_round.current_hand.cry_asc_num, text)), 0.3)
            ease_colour(G.C.UI_MULT, copy_table(Entropy.get_asc_colour(G.GAME.current_round.current_hand.cry_asc_num, text)), 0.3)

            G.GAME.current_round.current_hand.cry_asc_num_text = (
                a_power
            )
                    and " (".. (to_big(a_power) >= to_big(0) and "+" or "") .. number_format(a_power) .. ")"
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

local calculate_ascension_power_ref = Cryptid.calculate_ascension_power
function Cryptid.calculate_ascension_power(hand_name, hand_cards, hand_scoring_cards, tether, bonus)
	if Entropy.BlindIs("bl_entr_scarlet_sun") and not G.GAME.blind.disabled then
		tether = true
	end
    if next(SMODS.find_card("j_entr_helios")) then
		tether = true
	end
	local final = calculate_ascension_power_ref(hand_name, hand_cards, hand_scoring_cards, tether, bonus)
    if next(SMODS.find_card("j_entr_hexa")) then
        final = final * 3 * #SMODS.find_card("j_entr_hexa")
    end
    if next(SMODS.find_card("j_entr_helios")) then
        local total = 0
        for i, v in pairs(SMODS.find_card("j_entr_helios")) do total = total + v.ability.extra end
        final = final * total
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
local hand_ascension_numbers_ref = Cryptid.hand_ascension_numbers
function Cryptid.hand_ascension_numbers(hand_name, tether)
    if Entropy.BlindIs("bl_entr_scarlet_sun") then return 0 end
    if next(SMODS.find_card("j_entr_helios")) then
        tether = true
    end
	return hand_ascension_numbers_ref(hand_name, tether)
end

local asc_enabled_ref = Cryptid.ascension_power_enabled
function Cryptid.ascension_power_enabled()
	if next(SMODS.find_card("j_entr_helios")) or next(SMODS.find_card("j_entr_hexa")) or Entropy.BlindIs("bl_entr_scarlet_sun") then return true end
	if asc_enabled_ref then return asc_enabled_ref() end
end

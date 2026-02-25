local calculate_ascension_power_ref = Cryptid.calculate_ascension_power
function Cryptid.calculate_ascension_power(hand_name, hand_cards, hand_scoring_cards, tether, bonus)
	if Entropy.blind_is("bl_entr_scarlet_sun") and not G.GAME.blind.disabled then
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
    if Entropy.blind_is("bl_entr_scarlet_sun") and not G.GAME.blind.disabled then 
        final = final * (Entropy.is_EE() and -0.25 or -1)
    end
	return final
end
local hand_ascension_numbers_ref = Cryptid.hand_ascension_numbers
function Cryptid.hand_ascension_numbers(hand_name, tether)
    if Entropy.blind_is("bl_entr_scarlet_sun") then return 0 end
    if next(SMODS.find_card("j_entr_helios")) then
        tether = true
    end
	return hand_ascension_numbers_ref(hand_name, tether)
end

local asc_enabled_ref = Cryptid.ascension_power_enabled
function Cryptid.ascension_power_enabled()
	if next(SMODS.find_card("j_entr_helios")) or next(SMODS.find_card("j_entr_hexa")) or Entropy.blind_is("bl_entr_scarlet_sun") then return true end
	if asc_enabled_ref then return asc_enabled_ref() end
end

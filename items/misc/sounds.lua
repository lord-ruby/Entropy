-- SMODS.Sound({
-- 	key = "music_zenith",
-- 	path = "music_zenith.ogg",
-- 	select_music_track = function()
-- 		return G.GAME.Ruby and 10^300
-- 	end,
-- })
SMODS.Sound({
	key = "music_entropic",
	path = "music_entropic.ogg",
	select_music_track = function()
		return Entropy.config
        and Entropy.config.entropic_music
        and #Cryptid.advanced_find_joker(nil, "entr_entropic", nil, nil, true) ~= 0 and 10^200
	end,
})
SMODS.Sound({
	key = "music_red_room",
	path = "music_red_room.ogg",
	select_music_track = function()
		return G.GAME.round_resets.blind_states.Red == "Current" and 10^5
	end,
})
SMODS.Sound({
	key = "music_freebird",
	path = "music_freebird.ogg",
	select_music_track = function()
		return Entropy.HasJoker("j_entr_antireal") and Entropy.config.freebird and 10^200
	end,
})
SMODS.Sound({
	key = "music_fall",
	path = "music_fall.ogg",
	select_music_track = function()
		return ((G.GAME.round_resets.ante_disp == "32" and G.STATE == 1) or G.GAME.EEBuildup) and 10^302
	end,
})

SMODS.Sound({
	key = "music_entropy_is_endless",
	path = "music_entropy_is_endless.ogg",
	select_music_track = function()
        local blinds = {
            bl_entr_endless_entropy_phase_one=true,
            bl_entr_endless_entropy_phase_two=true,
            bl_entr_endless_entropy_phase_three=true,
            bl_entr_endless_entropy_phase_four=true
        }
		return (G.GAME.blind and blinds[G.GAME.blind.config.blind.key]) and 10^306
	end,
})

SMODS.Sound({
	key = "e_solar",
	path = "e_solar.ogg",
})
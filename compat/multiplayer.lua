return function()
	sendDebugMessage("Entropy compatibility detected", "MULTIPLAYER")
	MP.DECK.ban_card("j_entr_ruby")
    MP.DECK.ban_card("c_entr_new")
    for i, b in pairs(Entropy.BlindC) do
        MP.DECK.ban_card("c_"..b)
    end
    MP.DECK.ban_card("j_entr_xekanos")
end
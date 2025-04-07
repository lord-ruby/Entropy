SMODS.Atlas { key = 'decks', path = 'decks.png', px = 71, py = 95 }
SMODS.Back({
	object_type = "Back",
	name = "Twisted Deck",
	key = "twisted",
	pos = { x = 0, y = 0 },
	order = 1,
	atlas = "decks",
})

local matref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
	Entropy.ReverseFlipsideInversions()
    if self.config and self.config.center and Entropy.FlipsideInversions and Entropy.FlipsideInversions[self.config.center.key] and 
    G.GAME.selected_back and G.GAME.selected_back.effect.center.original_key == "twisted" then
        matref(self, G.P_CENTERS[Entropy.FlipsideInversions[self.config.center.key]], initial, delay_sprites)
    else
        matref(self, center, initial, delay_sprites)
    end
end

SMODS.Back({
	object_type = "Back",
	name = "CCD 2.0",
	key = "ccd2",
	pos = { x = 1, y = 0 },
	order = 1,
	atlas = "decks",
	apply = function(self)
		G.GAME.modifiers.ccd2 = true
	end,
})
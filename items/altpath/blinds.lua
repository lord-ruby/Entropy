local alpha = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+1,
	name = "entr-alpha",
	key = "alpha",
	pos = { x = 0, y = 0 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
    calculate = function(self, blind, context)
		if
			context.full_hand
			and context.destroy_card
			and (context.cardarea == G.play)
			and not G.GAME.blind.disabled
		then
            local check = nil
            for i, v in ipairs(G.play.cards) do
                if i == 1 and v == context.destroy_card then check = true end
            end
			return { remove = check and not context.destroy_card.ability.eternal }
		end
    end
}
return {
    items = {
        alpha
    }
}
SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "RTarot",
	primary_colour = HEX("da7272"),
	secondary_colour = HEX("a54747"),
	collection_rows = { 4, 4 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_fool"
})

SMODS.Atlas { key = 'rtarot', path = 'reverse_tarots.png', px = 71, py = 95 }
SMODS.Consumable({
    key = "fool",
    set = "RTarot",
    unlocked = true,

    atlas = "rtarot",
    config = {

    },
    use = function(self, card, area, copier)

    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)

    end
})
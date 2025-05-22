local aleph = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    object_type = "Sticker",
    order = 3000+4,
    atlas = "entr_stickers",
    pos = { x = 8, y = 0 },
    key = "entr_aleph",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("c75985"),
    should_apply = false,
	draw = function(self, card, layer)
		local notilt = nil
		if card.area and card.area.config.type == "deck" then
			notilt = true
		end
		G.shared_stickers["entr_aleph"].role.draw_major = card
		G.shared_stickers["entr_aleph"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
		G.shared_stickers["entr_aleph"]:draw_shader(
			"polychrome",
			nil,
			card.ARGS.send_to_shader,
			notilt,
			card.children.center
		)
		G.shared_stickers["entr_aleph"]:draw_shader(
			"voucher",
			nil,
			card.ARGS.send_to_shader,
			notilt,
			card.children.center
		)
	end,
    apply = function(self,card,val)
        card.ability.entr_aleph = true
    end,
}

local start_dissolveref = Card.start_dissolve
function Card:start_dissolve(...)
    if not self.ability.entr_aleph or self.ability.bypass_aleph then
        return start_dissolveref(self, ...)
    end
end

local update_ref = Card.update
function Card:update(dt)
	update_ref(self, dt)
	if self.ability.entr_aleph then
		self.entr_aleph = true
	end
	if self.entr_aleph then
		self.ability.entr_aleph = true
		self.ability.eternal = true
	end
    if self.cry_absolute then
        self.cry_absolute = nil
        self.ability.cry_absolute = nil

        self.entr_aleph = true
        self.ability.entr_aleph = true
		self.ability.eternal = true
    end
end

SMODS.Sticker:take_ownership("eternal", {
	draw = function(self, card)
		local notilt = nil
		if card.area and card.area.config.type == "deck" then
			notilt = true
		end
		if not card.ability.cry_absolute and not card.ability.entr_aleph then
			G.shared_stickers[self.key].role.draw_major = card
			G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
		end
	end,
})

SMODS.Sticker:take_ownership("cry_absolute", {
    no_collection = true,
	no_edeck = true
}, true)

return {
    items = {
        aleph
    }
}
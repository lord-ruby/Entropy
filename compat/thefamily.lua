if TheFamily then
	local toggle_tags = function(b)
		for _, tag in ipairs(G.HUD_tags or {}) do
			tag.states.visible = b
		end
	end
	local toggle_runes = function(b)
		G.runes_visible = not b
		for _, rune in ipairs(G.HUD_runes or {}) do
			rune.states.visible = b
		end
	end
	local pos_runes = function(is_tab_enabled)
		if G.HUD_runes and G.HUD_runes[1] then
			G.HUD_runes[1].config.offset.x = is_tab_enabled and 0.85 or 1.7
		end
	end

	TheFamily.create_tab_group({
		key = "entr_misc_group",
		order = 0,
		center = "c_entr_ingwaz",

		can_be_disabled = true,
	})

	TheFamily.create_tab({
		key = "entr_rune_tags",
		group_key = "entr_misc_group",
		center = "c_entr_ingwaz",

		-- Make it behave like switch for skip tags
		type = "switch",
		switch_overlays = { TheFamily.SWITCH_OVERLAYS.TAGS },
		can_be_disabled = true,

		front_label = function(self, card)
			return {
				text = localize("b_rune_cards"),
			}
		end,
		popup = function(self, card)
			return {
				name = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									-- Ha-ha, all localized except this one
									text = "Toggle Rune Tag Display",
									colour = G.C.WHITE,
									scale = 0.4,
								},
							},
						},
					},
				},
				description = {
					{
						{
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = TheFamily.UI.localize_text({
								-- Same here lul
								"Toggles the display of {C:purple}Rune Tags{}",
							}, {
								align = "cm",
							}),
						},
					},
				},
			}
		end,

		-- Display amounf of runes you have right now
		alert = function(self, card)
			return {
				definition_function = function()
					local ui_values = TheFamily.UI.get_ui_values()
					return TheFamily.UI.PARTS.create_dark_alert(card, {
						{
							n = G.UIT.T,
							config = {
								-- My beloved hack to keep track of size of smth dynamically
								ref_table = setmetatable({}, {
									__index = function()
										return #(G.HUD_runes or {})
									end,
								}),
								ref_value = "count",
								colour = G.C.WHITE,
								scale = 0.4 * ui_values.scale,
							},
						},
					})
				end,
			}
		end,

		highlight = function(self, card)
			-- Hide skip tags and show runes
			pos_runes(true)
			toggle_tags(false)
			toggle_runes(true)
		end,
		unhighlight = function(self, card)
			-- Hide runes and show skip tags
			toggle_tags(true)
			toggle_runes(false)
		end,

		load = function(self, disabled_by_user)
			if not disabled_by_user then
				pos_runes(true)
				toggle_runes(false)
			end
		end,

		disabled_change = function(self, new_value, caused_by_group)
			pos_runes(not new_value)
			toggle_tags(true)
			toggle_runes(new_value)
		end,
	})
end

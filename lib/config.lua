Entropy.config = SMODS.current_mod.config
local entrConfigTab = function()
	entr_nodes = {
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.O,
					config = {
						object = DynaText({
							string = localize("cry_set_enable_features"),
							colours = { G.C.WHITE },
							shadow = true,
							scale = 0.4,
						}),
					},
				},
			},
		},
	}
    entr_nodes[#entr_nodes + 1] = UIBox_button({
		colour = G.C.CRY_GREENGRADIENT,
		button = "your_collection_content_sets",
		label = { localize("b_content_sets") },
		count = modsCollectionTally(G.P_CENTER_POOLS["Content Set"]),
		minw = 5,
		minh = 1.7,
		scale = 0.6,
		id = "your_collection_jokers",
	})
	left_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
	right_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
	config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { left_settings, right_settings } }
	entr_nodes[#entr_nodes + 1] = config
    entr_nodes[#entr_nodes + 1] = create_toggle({
		label = localize("k_entr_entropic_music"),
		active_colour = HEX("40c76d"),
		ref_table = Entropy.config,
		ref_value = "entropic_music",
		callback = function()
        end,
	})
    entr_nodes[#entr_nodes + 1] = create_toggle({
		label = localize("k_entr_freebird"),
		active_colour = HEX("40c76d"),
		ref_table = Entropy.config,
		ref_value = "freebird",
		callback = function()
        end,
	})
	return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "cm",
			padding = 0.2,
			colour = G.C.BLACK,
		},
		nodes = entr_nodes,
	}
end

SMODS.current_mod.config_tab = entrConfigTab
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
	entr_nodes[#entr_nodes+1] = create_option_cycle({
		label = localize("flipside_info"),
		scale = 0.8,
		w = 6,
		options = {localize("flipside_none"), localize("flipside_minimal"), localize("flipside_full")},
		opt_callback = "update_inversion_queue",
		current_option = Entropy.config.inversion_queues,
	})
	entr_nodes[#entr_nodes + 1] = create_toggle({
		label = localize("cry_family"),
		active_colour = HEX("40c76d"),
		ref_table = Cryptid_config,
		ref_value = "family_mode",
		callback = Cryptid.reload_localization,
	})
	if SMODS.Mods["Cryptid"] and SMODS.Mods["Cryptid"].can_load then
		entr_nodes[#entr_nodes + 1] = create_toggle({
			label = localize("k_entr_faster_ante_scaling"),
			active_colour = HEX("40c76d"),
			ref_table = Entropy.config,
			ref_value = "ante_scaling",
			callback = function()
			end,
		})
		-- entr_nodes[#entr_nodes + 1] = create_toggle({
		-- 	label = localize("k_entr_glitched"),
		-- 	active_colour = HEX("40c76d"),
		-- 	ref_table = Entropy.config,
		-- 	ref_value = "override_glitched",
		-- 	callback = function()
		-- 	end,
		-- })
	end
	entr_nodes[#entr_nodes + 1] = create_toggle({
		label = localize("k_entr_omega_aleph"),
		active_colour = HEX("40c76d"),
		ref_table = Entropy.config,
		ref_value = "omega_aleph",
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

G.FUNCS.update_inversion_queue = function(e)
	Entropy.config.inversion_queues = e.to_key
end

function Entropy.generate_credits_nodes(table, type)
	local code_nodes = {
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.O,
					config = {
						object = DynaText({
							string = localize("k_"..type),
							colours = { G.C.IMPORTANT },
							shadow = true,
							scale = 0.7,
						}),
					},
				},
			},
		},
	}
	for i, v in pairs(table) do
		code_nodes[#code_nodes + 1] = 
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.O,
					config = {
						object = DynaText({
							string = i,
							colours = { G.C.WHITE },
							shadow = true,
							scale = 0.4,
						}),
					},
				},
			},
		}
	end
	return { n = G.UIT.C, config = { align = "tm", padding = 0 }, nodes = code_nodes }
end

local entropyTabs = function()
	return {
		{
			label = localize("cry_set_music"),
			tab_definition_function = function()
				entr_nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
						},
					},
				}
				settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
				settings.nodes[#settings.nodes + 1] = create_toggle({
					label = localize("k_entr_entropic_music"),
					active_colour = HEX("40c76d"),
					ref_table = Entropy.config,
					ref_value = "entropic_music",
					callback = function()
					end,
				})
				settings.nodes[#settings.nodes + 1] = create_toggle({
					label = localize("k_entr_freebird"),
					active_colour = HEX("40c76d"),
					ref_table = Entropy.config,
					ref_value = "freebird",
					callback = function()
					end,
				})
				config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { settings } }
				entr_nodes[#entr_nodes + 1] = config
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
			end,
		},
		{
			label = localize("k_credits"),
			tab_definition_function = function()
				entr_nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
						},
					},
				}
				local credits = {
					art = {},
					idea = {},
					code = {
						["lord.ruby"]=true, 
						["cassknows"]=true, 
						["SleepyG11"]=true, 
						["hayaunderscore"]=true, 
						["AnnieTheEagle"]=true, 
						["WhoNeedsAUsrName"]=true, 
						["wingedcatgirl"]=true, 
						["Lily Felli"]=true, 
						["gemstonez"]=true, 
						["triple6lexi"]=true
					},
					music = {gemstonez=true}
				}
				for i, v in pairs(G.P_CENTERS) do if v.entr_credits then
					if v.entr_credits.idea then for i, v in pairs(v.entr_credits.idea) do credits.idea[v] = true end end
					if v.entr_credits.art then for i, v in pairs(v.entr_credits.art) do credits.art[v] = true end end
					if v.entr_credits.code then for i, v in pairs(v.entr_credits.code) do credits.code[v] = true end end
				end end
				settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }

				config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { settings } }
				entr_nodes[#entr_nodes+1] = Entropy.generate_credits_nodes(credits.code, "code", entr_nodes)
				entr_nodes[#entr_nodes+1] = Entropy.generate_credits_nodes(credits.idea, "idea", entr_nodes)
				entr_nodes[#entr_nodes+1] = Entropy.generate_credits_nodes(credits.art, "art", entr_nodes)
				entr_nodes[#entr_nodes+1] = Entropy.generate_credits_nodes(credits.music, "music", entr_nodes)
				entr_nodes[#entr_nodes + 1] = config
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
			end,
		},
	}
end
SMODS.current_mod.extra_tabs = entropyTabs
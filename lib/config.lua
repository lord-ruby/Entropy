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
	if not G.ENTROPY_PAGE_2 then G.ENTROPY_PAGE_2 = 1 end
	if G.ENTROPY_PAGE_2 == 1 then
		left_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.1 }, nodes = {} }
		right_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.1 }, nodes = {} }
		config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { left_settings, right_settings } }
		entr_nodes[#entr_nodes + 1] = config
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
		entr_nodes[#entr_nodes + 1] = config
		entr_nodes[#entr_nodes + 1] = create_toggle({
			label = localize("k_entr_profile_prefix"),
			active_colour = HEX("40c76d"),
			ref_table = Entropy.config,
			ref_value = "profile_prefix",
		})
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
		entr_nodes[#entr_nodes + 1] = create_toggle({
			label = localize("curses_enabled"),
			active_colour = HEX("40c76d"),
			ref_table = Entropy.config,
			ref_value = "curses_enabled",
		})
	elseif G.ENTROPY_PAGE_2 == 2 then
		left_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.1 }, nodes = {} }
		right_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.1 }, nodes = {} }
		config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { left_settings, right_settings } }
		entr_nodes[#entr_nodes + 1] = config
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
		entr_nodes[#entr_nodes + 1] = config
		if SMODS.Mods["Cryptid"] and SMODS.Mods["Cryptid"].can_load then
			entr_nodes[#entr_nodes + 1] = create_toggle({
				label = localize("k_entr_faster_ante_scaling"),
				active_colour = HEX("40c76d"),
				ref_table = Entropy.config,
				ref_value = "ante_scaling",
				callback = function()
				end,
			})
			entr_nodes[#entr_nodes + 1] = create_toggle({
				label = localize("k_entr_glitched"),
				active_colour = HEX("40c76d"),
				ref_table = Entropy.config,
				ref_value = "override_glitched",
				callback = function()
				end,
			})
		end
		entr_nodes[#entr_nodes + 1] = create_toggle({
				label = localize("k_entr_omega_aleph"),
				active_colour = HEX("40c76d"),
				ref_table = Entropy.config,
				ref_value = "omega_aleph",
				callback = function()
				end,
			})
		entr_nodes[#entr_nodes + 1] = create_toggle({
			label = localize("k_entr_asc_tutorial"),
			active_colour = HEX("40c76d"),
			ref_table = Entropy.config,
			ref_value = "asc_power_tutorial",
		})
		entr_nodes[#entr_nodes+1] = create_slider({
			label = localize('k_entr_corrupted_speed'), 
			w = 5, 
			h = 0.4, 
			ref_table = Entropy.config, 
			ref_value = 'corrupted_speed', 
			min = 25, 
			max = 100
		})
		entr_nodes[#entr_nodes + 1] = create_toggle({
			label = localize("k_entr_sensitive_content"),
			active_colour = HEX("40c76d"),
			ref_table = Entropy.config,
			ref_value = "hide_sensitive_content",
			callback = Cryptid.reload_localization,
		})
	end
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
		nodes = {
			{ n = G.UIT.R, config = { align = "cm", r = 0.1, colour = {0,0,0,0}, emboss = 0.05 }, nodes = entr_nodes },
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					create_option_cycle({
						options = {
							localize("k_page") .. " " .. tostring(1) .. "/" .. tostring(2),
							localize("k_page") .. " " .. tostring(2) .. "/" .. tostring(2)
						},
						w = 4.5,
						cycle_shoulders = true,
						opt_callback = "entr_set_config_page",
						current_option = G.ENTROPY_PAGE_2 or 1,
						colour = Entropy.reverse_legendary_gradient,
						no_pips = true,
						focus_args = { snap_to = true, nav = "wide" },
					}),
				},
			}
		},
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
							string = localize("k_"..(type == "music" and "music_sound" or type)),
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
		local cards_with_credit = {}
		for _, v in pairs(G.P_CENTERS) do
			if v.slib_credits then
				for i2, v2 in pairs(v.slib_credits) do
					for i3, v3 in pairs(v2) do
						if v3 == i then
							cards_with_credit[#cards_with_credit+1] = v
							goto continue
						end
					end
				end
			end
			::continue::
		end
		if i == "crimsonseraphim" then
			for _, v in pairs(G.P_CENTERS) do
				if v.set ~= "Content Set" and v.set ~= "CBlind" and (not v.slib_credits or not v.slib_credits.art or not v.slib_credits.idea or not v.slib_credits.code) then
					cards_with_credit[#cards_with_credit+1] = v
				end
			end
		end
		G.FUNCS["entr_credit_"..i] = function(e)
            G.SETTINGS.paused = true
			G.E_MANAGER:add_event(Event{
				trigger = "after",
				func = function()
					G.only_display_credit = i
					return true
				end
			})
            G.FUNCS.overlay_menu {
                definition = SMODS.card_collection_UIBox(cards_with_credit, { 5, 5, 5 }),
				config = {back_func = "exit_entr_overlay"}
            }
		end
		code_nodes[#code_nodes + 1] = 
		{
			n = G.UIT.R,
			config = { align = "cm"},
			nodes = {
				{
					n = G.UIT.O,
					config = {
						button = #cards_with_credit > 0 and "entr_credit_"..i or nil,
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
local overlay_ref = G.FUNCS.overlay_menu
G.FUNCS.overlay_menu = function(...)
	local ret = overlay_ref(...)
	G.dont_display_credit = nil
	G.only_display_credit = nil
	return ret
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
				if not G.ENTROPY_PAGE then G.ENTROPY_PAGE = 1 end
				entr_nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
						},
					},
				}
				if G.ENTROPY_PAGE == 1 then
					local credits = {
						art = {
							["pangaea47"] = true
						},
						idea = {},
						code = {
							["crimsonseraphim"]=true, 
							["cassknows"]=true, 
							["SleepyG11"]=true, 
							["hayaunderscore"]=true, 
							["AnnieTheEagle"]=true, 
							["WhoNeedsAUsrName"]=true, 
							["wingedcatgirl"]=true, 
							["Lily Felli"]=true, 
							["gemstonez"]=true, 
							["triple6lexi"]=true,
							["Athebyne"] = true,
							["InvalidOS"] = true,
							["FirstTry"] = true,
							["Eris"] = true,
							["WilsontheWolf"] = true,
							["Soulware"] = true,
							["bioboi"] = true,
							["noritheavali"] = true
						},
						music = {gemstonez=true, Grahkon = true, metanite64 = true}
					}
					for i, v in pairs(G.P_CENTERS) do if v.slib_credits then
						if v.slib_credits.idea then for i, v in pairs(v.slib_credits.idea) do credits.idea[v] = true end end
						if v.slib_credits.art then for i, v in pairs(v.slib_credits.art) do credits.art[v] = true end end
						if v.slib_credits.code then for i, v in pairs(v.slib_credits.code) do credits.code[v] = true end end
					end end
					settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }

					config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { settings } }
					entr_nodes[#entr_nodes+1] = Entropy.generate_credits_nodes(credits.code, "code", entr_nodes)
					entr_nodes[#entr_nodes+1] = Entropy.generate_credits_nodes(credits.idea, "idea", entr_nodes)
					entr_nodes[#entr_nodes+1] = Entropy.generate_credits_nodes(credits.art, "art", entr_nodes)
					entr_nodes[#entr_nodes+1] = Entropy.generate_credits_nodes(credits.music, "music", entr_nodes)
				elseif G.ENTROPY_PAGE == 2 then
					local special = {
						{name = "cassknows", text = "general assistance throughout the entirety of the mod", colour = HEX("00FF00")},
						{name = "Lily.Felli", text = "flashlight.fs and invertradius.fs", colour = G.C.ORANGE},
						{name = "bioboi", text = "writing assistance for EEv4", colour = HEX("996e00")},
						{name = "missingnumber", text = "spriting assistance for EEv4", colour = G.C.ORANGE},
						{name = "metanite64", text = "music assistance for EEv4", colour = HEX("ff73e5")},
						{name = "InvalidOS", text = "design assistance for EEv4", colour = Entropy.entropic_gradient},
						{name = "notmario", text = "programming assistance for The Joker is You", colour = HEX("ff6868")},
					}
					local special_nodes = {

					}
					for i, v in pairs(special) do
						special_nodes[#special_nodes+1] = {
							n = G.UIT.R,
							config = { align = "cm"},
							nodes = {
								{
									n = G.UIT.O,
									config = {
										object = DynaText({
											string = v.name,
											colours = { v.colour },
											shadow = true,
											scale = 0.5,
										}),
									},
								},
								{
									n = G.UIT.O,
									config = {
										object = DynaText({
											string = " - "..v.text,
											colours = { G.C.WHITE },
											shadow = true,
											scale = 0.4,
										}),
									},
								},
							},
						}
					end
					entr_nodes[#entr_nodes+1] = { n = G.UIT.C, config = { align = "tm", padding = 0 }, nodes = {
						{
							n = G.UIT.R,
							config = { align = "tm"},
							nodes = {
								{
									n = G.UIT.O,
									config = {
										object = DynaText({
											string = "Special Thanks",
											colours = { G.C.IMPORTANT },
											shadow = true,
											scale = 0.7,
										}),
									},
								},
							},
						},
						unpack(special_nodes)
					} }
				end
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
					nodes = {
						{ n = G.UIT.R, config = { align = "cm", r = 0.1, colour = {0,0,0,0}, emboss = 0.05 }, nodes = entr_nodes },
						{
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = {
								create_option_cycle({
									options = {
										localize("k_page") .. " " .. tostring(1) .. "/" .. tostring(2),
										localize("k_page") .. " " .. tostring(2) .. "/" .. tostring(2)
									},
									w = 4.5,
									cycle_shoulders = true,
									opt_callback = "entr_set_credits_page",
									current_option = G.ENTROPY_PAGE or 1,
									colour = Entropy.reverse_legendary_gradient,
									no_pips = true,
									focus_args = { snap_to = true, nav = "wide" },
								}),
							},
						}
					},
				}	
			end,
		},
		{
			label = "References",
			tab_definition_function = function()
				entr_nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
						},
					},
				}
				local refs = {}
				for i, v in pairs(Entropy.references) do
					refs[#refs+1] = G.P_CENTERS[i]
				end
				G.ENTERED_FILTER = G.ENTERED_FILTER or ""
				local text = create_text_input({
					colour = G.C.RED,
					hooked_colour = darken(copy_table(G.C.RED), 0.3),
					w = 3,
					h = 1,
					max_length = 100,
					extended_corpus = true,
					prompt_text = "",
					ref_table = G,
					ref_value = "ENTERED_FILTER",
					keyboard_offset = 1,
					config = { align = "cm", id = "ENTRTEXTINP" },
					callback = function()
						Entropy.FILTER = G.ENTERED_FILTER
						G.ENTERED_FILTER = ""
						Entropy.filtered_centers = Entropy.search_centers(Entropy.FILTER, refs)
						Entropy.selected_center = Entropy.filtered_centers[1]
						G.FUNCS["openModUI_entr"]()
					end
				})
				Entropy.filtered_centers = Entropy.filtered_centers or Entropy.search_centers("", refs)
				Entropy.selected_center = Entropy.selected_center or Entropy.filtered_centers[1]
				text.config.id = "ENTRTEXTINP"
				local dropdown = SMODS.GUI.dropdown_select({
					ref_table = Entropy,
					ref_value = "selected_center",
					options = Entropy.filtered_centers or {}
				})

				if G.REFERENCE_AREA then
					G.REFERENCE_AREA:remove()
				end
				G.REFERENCE_AREA = CardArea(
					G.ROOM.T.w / 2, G.ROOM.T.h / 2, G.CARD_W, G.CARD_H, { type = "title" }
				)
				local t_nodes = {}
				if Entropy.selected_center and G.P_CENTERS[Entropy.selected_center] then
					G.REFERENCE_AREA:emplace(SMODS.create_card{area = G.REFERENCE_AREA, key = Entropy.selected_center, no_edition = true})
					for i, v in pairs(Entropy.references[Entropy.selected_center]) do
						entr_nodes[#entr_nodes+1] = {
							n = G.UIT.R,
							config = {
								align = "cm",
							},
							nodes = {
								{
									n = G.UIT.O,
									config = { object = DynaText({
										string = v,
										colours = { G.C.WHITE },
										shadow = true,
										scale = 0.4,
									}) },
								}
							}
						}
					end
				end
				entr_nodes[#entr_nodes+1] = {
					n = G.UIT.R,
					config = {
						align = "cm",
					},
					nodes = {
						{
							n = G.UIT.O,
							config = {
								object = G.REFERENCE_AREA,
							},
						}
					}
				}

				entr_nodes[#entr_nodes+1] = SMODS.GUI.dropdown_select({
					ref_table = Entropy,
					ref_value = "selected_center",
					options = Entropy.filtered_centers or {},
					colour = Entropy.reverse_legendary_gradient,
					id = "entr_reference_select",
					ui_type = G.UIT.R,
					close_on_select = true,
					no_unselect = true,
					max_menu_h = 4,
					max_item_w = 5,
					dropdown_element_def = function (option, args)
						local center = G.P_CENTERS[option] or {set = ""}
						return {n = G.UIT.T, config = {maxw = 4, text = localize{type = "name_text", set = center.set, key = option}, scale = 0.3, colour = G.C.UI.TEXT_LIGHT}}
					end,
					callback = "entr_set_references",
					display_choice_func = function(option)
						local center = G.P_CENTERS[option] or {set = ""}
						return localize{type = "name_text", set = center.set, key = option}
					end
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
					nodes = {
						{
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = {
								text
							},
						},
						unpack(entr_nodes),
					},
				}
			end,
		}
	}
end

G.FUNCS.entr_set_credits_page = function(args)
	if args.cycle_config then
		G.ENTROPY_PAGE = args.cycle_config.current_option
	end
	G.FUNCS["openModUI_entr"]()
end
G.FUNCS.entr_set_config_page = function(args)
	G.ENTROPY_PAGE_2 = args.cycle_config.current_option
	G.FUNCS["openModUI_entr"]()
end

G.FUNCS.entr_set_references = function(args)
	G.E_MANAGER:add_event(Event{
		func = function()
			G.FUNCS["openModUI_entr"]()
			return true
		end
	})
end

SMODS.current_mod.custom_ui = function(nodes)
    local logo = {
        n = G.UIT.R,
        config = {
            align = 'cm',
            colour = {0,0,0,0},
            r = 0.3,
            padding = 0.25
        },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = 'cm' },
                nodes = {
                    {
                        n = G.UIT.O,
                        config = {
                            object = SMODS.create_sprite(
                                5, 0,
                                8,4,
                                'entr_modlogo',
                                { x = 0, y = 0 }
                            )
                        }
                    }
                }
            }
        }
    }
    table.insert(nodes, 2, logo)
    return nodes
end

SMODS.current_mod.ui_config = {
	author_colour = Entropy.reverse_legendary_gradient,
    tab_button_colour = Entropy.reverse_legendary_gradient,
	back_colour = Entropy.reverse_legendary_gradient,
	bg_colour = adjust_alpha(G.C.BLACK, 0.95),
	colour = darken(G.C.BLACK, .2),
	outline_colour = lighten(G.C.BLACK, .2),
}

SMODS.current_mod.extra_tabs = entropyTabs

function Entropy.get_order(a)
	sets = {
		Joker = 0,
		Tarot = 10000,
		Planet = 20000,
		Spectral = 30000,
		Rune = 40000,
		Fraud = 50000,
		Star = 60000,
		Omen = 70000,
		Pact = 80000,
		Voucher = 90000,
		Booster = 100000,
		Back = 110000
	}
	return (G.P_CENTERS[a].cry_order or G.P_CENTERS[a].order or 0) + (sets[G.P_CENTERS[a].set] or 0)
end

function Entropy.search_centers(str, tbl)
    local cent = {}
	local cents = {}
	if str == "" or not str then
		for i, v in pairs(tbl or G.P_CENTERS) do
			cents[#cents+1] = v.key
		end
		table.sort(cents, function(a, b) return Entropy.get_order(a) < Entropy.get_order(b) end)
		return cents
	end
    for i, v in pairs(tbl or G.P_CENTERS) do
		if not v.no_collection then 
			local refs = string.find(v.key or "", string.lower(str)) or string.find(v.name or "", string.lower(str))
				or string.find(v.original_key or "", string.lower(str)) or string.find(string.lower(localize{type = "name_text", set = v.set, key = v.key} or ""), string.lower(str))
			if not refs then
				for i, r in pairs(Entropy.references[v.key] or {}) do
					if string.find(string.lower(r), string.lower(str)) then
						refs = true
					end
				end
			end
			if refs then
				if not cent[v.key] then
					cents[#cents+1] = v.key
				end
				cent[v.key] = v.key
			end
			local mod = (v.mod or {display_name = "", id = "", prefix = ""})
			if string.find(string.lower(mod.display_name or ""), string.lower(str)) or string.find(string.lower(mod.id or ""), string.lower(str)) 
				or string.find(string.lower(mod.prefix or ""), string.lower(str))
			then
				if not cent[v.key] then
					cents[#cents+1] = v.key
				end
				cent[v.key] = v.key
			end
		end
    end
	table.sort(cents, function(a, b) return Entropy.get_order(a) < Entropy.get_order(b) end)
    return cents
end

Entropy.references = {
	j_entr_surreal_joker = {"The Son of Man - René Magritte"},
	j_entr_strawberry_pie = {"Celeste - Maddy Makes Games inc."},
	j_entr_dr_sunshine = {"Dr Sunshine is Dead - Will Wood"},
	j_entr_devilled_suns = {"Devil Vortex Saws - ToshDeluxe", "Bingus - rawdogcomics"},
	j_entr_crimson_flask = {"Crimson Heart - Balatro"},
	j_entr_qu = {"Qu - All Tomorrows"},
	j_entr_memento_mori = {"Memento Mori - Will Wood"},
	j_entr_chalice_of_blood = {"Chalice of the Blood God - Calamity Mod"},
	j_entr_torn_photograph = {"Torn Photograph - TBOI"},
	j_entr_oops_alles = {"Calculating Screen - Talisman"},
	j_entr_masterful_gambit = {"Hyperaccelerated Bongcloud Opening - u/enlightened-creature"},
	j_entr_girldinner = {"Pups Gotta Eat - Puppychan"},
	j_entr_jokers_against_humanity = {"Cards Against Humanity"},
	j_entr_prayer_card = {"Prayer Card - TBOI"},
	j_entr_grape_juice = {"Jesus Juice - TBOI"},
	j_entr_petrichor = {"Petrichor V - Risk of Rain"},
	j_entr_otherworldly_joker = {"Alternia - Homestuck"},
	j_entr_error = {"I AM ERROR - TBOI"},
	j_entr_thirteen_of_stars = {"Thirteen of Stars - Homestuck"},
	j_entr_prismatic_shard = {"The Community - Calamity Mod"},
	j_entr_redkey = {"Red Key - TBOI"},
	j_entr_car_battery = {"Car Battery - TBOI"},
	j_entr_black_rose_green_sun = {"Black Rose, Green Sun - Homestuck"},
	j_entr_fast_food = {"Burger King (1999-2020)"},
	j_entr_antipattern = {"Einstein Tiling - David Smith"},
	j_entr_spiral_of_ants = {"Spiral of Ants - Lemon Demon"},
	j_entr_blooming_crimson = {"Shattered Community - Calamity Mod"},
	j_entr_overpump = {"Ultrakill"},
	j_entr_shadow_crystal = {"Shadow Crystal - Deltarune"},
	j_entr_meridian = {"Blood Meridian - Cormac McCarthy"},
	j_entr_kitchenjokers = {"r/kitchencels"},
	j_entr_stand_arrow = {"Stand Arrow - JJBA"},
	j_entr_magic_skin = {"Magic Skin - TBOI"},
	j_entr_echo_chamber = {"Echo Chamber - TBOI"},
	j_entr_twisted_pair = {"Twisted Pair - TBOI"},
	j_entr_void_cradle = {"Void Cradle - Risk of Rain"},
	j_entr_pound_of_flesh = {"Pound of Flesh - TBOI"},
	j_entr_fthof = {"Force the Hand of Fate - Cookie Clicker"},
	j_entr_searing_joke = {"Searing Blow - Slay the Spire"},
	j_entr_ancestral_recall = {"Ancestral Recall - MTG"},
	j_entr_planetarium = {"Planetarium - TBOI"},
	j_entr_midnight = {"Midnight Crew - Problem Sleuth"},
	j_entr_quadrants = {"Quadrants - Homestuck"},
	j_entr_hidden_gem = {"Hidden Gem - STS2"},
	j_entr_bloodletting = {"Bloodletting - STS2"},
	j_entr_record_disc = {"Scratch Construct - Homestuck"},
	j_entr_demon_form = {"Demon Form - STS2"},
	j_entr_broken_god = {"Mekhane - SCP"},
	j_entr_rivulet = {"Rivulet - Rain World"},
	j_entr_big_walk = {"Big Walk"},
	j_entr_infinite_loop = {"BaBa Is You"},
	j_entr_dice_shard = {"Spindown Dice - TBOI"},
	j_entr_apoptosis = {"Void Items - Risk of Rain 2"},
	j_entr_egocentrism = {"Egocentrism - Risk of Rain 2", "Void Items - Risk of Rain 2"},
	j_entr_generator_meltdown = {"Void Items - Risk of Rain 2"},
	j_entr_voidheart = {"Voidheart - Hollow Knight", "Void Items - Risk of Rain 2"},
	j_entr_unstable_rift = {"Void Items - Risk of Rain 2"},
	j_entr_pluripotent_larvae = {"Pluripotent Larva - Risk of Rain 2", "Void Items - Risk of Rain 2"},
	j_entr_desiderium = {"Void Items - Risk of Rain 2"},
	j_entr_nadir = {"Void Items - Risk of Rain 2"},
	j_entr_yaldabaoth = {"Void Items - Risk of Rain 2"},
	j_entr_mutagenesis = {"Void Items - Risk of Rain 2"},
	j_entr_crooked_penny = {"Crooked Penny - TBOI", "Void Items - Risk of Rain 2"},
	j_entr_phoenix_a = {"Void Items - Risk of Rain 2"},
	j_entr_antimatter_sheath = {"Dark Matter Sheath - Calamity Mod", "Void Items - Risk of Rain 2"},
	j_entr_caledscratch = {"Caledscratch - Homestuck", "Void Items - Risk of Rain 2"},
	j_entr_apoptosis = {"Nyx - Homestuck", "Void Items - Risk of Rain 2"},
	j_entr_ruby = {"Homestuck"},
	j_entr_slipstream = {"Homestuck"},
	j_entr_cass = {"Homestuck"},
	j_entr_hexa = {"Homestuck"},

	b_entr_crafting = {"Tainted Cain - TBOI"},
	b_entr_doc = {"SCP"},

	v_entr_providence = {"Tarot Cloth - TBOI"},

	c_entr_wormhole = {"The Interloper - Outer Wilds"},
	c_entr_destiny = {"Bag of Crafting - TBOI"},
	c_entr_feud = {"The Princess Bride"},
}

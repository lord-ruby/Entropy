G.FUNCS.cry_intro_part = function(_part)
	local step = 1
	G.SETTINGS.paused = true
	if _part == "start" then
		G.gateway = Sprite(
			G.ROOM_ATTACH.T.x + G.ROOM_ATTACH.T.w / 2 - 1,
			G.ROOM_ATTACH.T.y + G.ROOM_ATTACH.T.h / 2 - 4,
			G.CARD_W * 1.5,
			G.CARD_H * 1.5,
			G.ASSET_ATLAS["cry_atlasnotjokers"],
			{ x = 2, y = 0 }
		)
		G.gateway.states.visible = false
		G.gateway.states.collide.can = true
		G.gateway.states.focus.can = false
		G.gateway.states.hover.can = true
		G.gateway.states.drag.can = false
		G.gateway.hover = Node.hover
		G.yawetag = Sprite(
			G.ROOM_ATTACH.T.x + G.ROOM_ATTACH.T.w / 2 - 1,
			G.ROOM_ATTACH.T.y + G.ROOM_ATTACH.T.h / 2 - 4,
			G.CARD_W * 1.5,
			G.CARD_H * 1.5,
			G.ASSET_ATLAS["cry_atlasnotjokers"],
			{ x = 6, y = 5 }
		)
		G.yawetag.states.visible = false
		G.yawetag.states.collide.can = true
		G.yawetag.states.focus.can = false
		G.yawetag.states.hover.can = true
		G.yawetag.states.drag.can = false
		G.yawetag.hover = Node.hover
		step = Cryptid.intro_info({
			text_key = "cry_intro_1",
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = 0 } },
			step = step,
		})
		step = Cryptid.intro_info({
			text_key = "cry_intro_2",
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = -3 } },
			step = step,
		})
		step = Cryptid.intro_info({
			text_key = "cry_intro_3",
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = -3 } },
			step = step,
			highlight = {
				G.gateway,
				G.yawetag,
			},
			on_start = function()
				G.gateway.states.visible = true
				G.gateway:set_alignment({ major = G.ROOM_ATTACH, type = "cm", offset = { x = -2.5, y = -3 } })
				G.yawetag.states.visible = true
				G.yawetag:set_alignment({ major = G.ROOM_ATTACH, type = "cm", offset = { x = 2.5, y = -3 } })
			end,
		})
		step = Cryptid.intro_info({
			text_key = "cry_intro_4",
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = -3 } },
			step = step,
			highlight = {
				G.gateway,
				G.yawetag,
			},
		})
		local modestSprite = Sprite(0, 0, 1, 1, G.ASSET_ATLAS["cry_gameset"], { x = 0, y = 0 })
		modestSprite:define_draw_steps({
			{ shader = "dissolve", shadow_height = 0.05 },
			{ shader = "dissolve" },
		})
		local mainlineSprite = Sprite(0, 0, 1, 1, G.ASSET_ATLAS["cry_gameset"], { x = 1, y = 0 })
		mainlineSprite:define_draw_steps({
			{ shader = "dissolve", shadow_height = 0.05 },
			{ shader = "dissolve" },
		})
		local madnessSprite = Sprite(0, 0, 1, 1, G.ASSET_ATLAS["cry_gameset"], { x = 2, y = 0 })
		madnessSprite:define_draw_steps({
			{ shader = "dissolve", shadow_height = 0.05 },
			{ shader = "dissolve" },
		})
		--TODO: localize
		G.modestBtn = create_UIBox_character_button_with_sprite({
			sprite = modestSprite,
			button = localize("cry_gameset_modest"),
			id = "modest",
			func = "cry_modest",
			colour = G.C.GREEN,
			maxw = 3,
		})
		G.mainlineBtn = create_UIBox_character_button_with_sprite({
			sprite = mainlineSprite,
			button = localize("cry_gameset_mainline"),
			id = "mainline",
			func = "cry_mainline",
			colour = G.C.RED,
			maxw = 3,
		})
		G.madnessBtn = create_UIBox_character_button_with_sprite({
			sprite = madnessSprite,
			button = localize("cry_gameset_madness"),
			id = "madness",
			func = "cry_madness",
			colour = G.C.Entropy.HYPER_EXOTIC,
			maxw = 3,
		})
		local gamesetUI = create_UIBox_generic_options({
			infotip = false,
			contents = {
				G.modestBtn,
				G.mainlineBtn,
				G.madnessBtn,
			},
			back_label = "Confirm",
			back_colour = G.C.BLUE,
			back_func = "cry_gameset_confirm",
		})
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			blocking = false,
			blockable = false,
			func = function()
				G.madnessBtn.config.colour = G.C.Entropy.HYPER_EXOTIC
				return true
			end,
		}))
		gamesetUI.nodes[2] = nil
		gamesetUI.config.colour = G.C.CLEAR
		G.gamesetUI = UIBox({
			definition = gamesetUI,
			config = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = 2.5 } },
		})
		G.gamesetUI.states.visible = false
		step = Cryptid.intro_info({
			text_key = "cry_intro_5",
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = -3 } },
			step = step,
			highlight = {
				G.gateway,
				G.yawetag,
				G.gamesetUI,
			},
			on_start = function()
				--the scaling should be eased later...
				G.gamesetUI.states.visible = true
				G.gateway:set_alignment({ major = G.ROOM_ATTACH, type = "cm", offset = { x = -4.5, y = 2.2 } })
				G.gateway.T.w = G.gateway.T.w * 3
				G.gateway.T.h = G.gateway.T.h * 3
				G.yawetag:set_alignment({ major = G.ROOM_ATTACH, type = "cm", offset = { x = 4.5, y = 2.2 } })
				G.yawetag.T.w = G.yawetag.T.w * 3
				G.yawetag.T.h = G.yawetag.T.h * 3
			end,
			no_button = true,
		})
	end
	if _part == "modest" or _part == "mainline" or _part == "madness" then
		local desc_length = { --number of times Jolly Joker speaks for each gameset
			modest = 2,
			mainline = 3,
			madness = 3,
		}
		G.E_MANAGER:clear_queue("tutorial")
		if G.OVERLAY_TUTORIAL.content then
			G.OVERLAY_TUTORIAL.content:remove()
		end
		G.OVERLAY_TUTORIAL.Jimbo:remove_button()
		G.OVERLAY_TUTORIAL.Jimbo:remove_speech_bubble()
		G.OVERLAY_TUTORIAL.step = nil
		for i = 1, desc_length[_part] do
			step = Cryptid.intro_info({
				text_key = "cry_" .. _part .. "_" .. i,
				attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = -3 } },
				step = step,
				highlight = {
					G.gamesetUI:get_UIE_by_ID(_part),
				},
			})
		end
		step = Cryptid.intro_info({
			no_button = true,
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = -3 } },
			step = step,
			highlight = {
				G.gateway,
				G.yawetag,
				G.gamesetUI,
			},
		})
	end
end

G.FUNCS.cry_modest = function(e)
	G.modestBtn.config.colour = G.C.CRY_SELECTED
	G.mainlineBtn.config.colour = G.C.RED
	G.madnessBtn.config.colour = G.C.Entropy.HYPER_EXOTIC
	G.FUNCS.cry_intro_part("modest")
	G.selectedGameset = "modest"
end
G.FUNCS.cry_mainline = function(e)
	G.modestBtn.config.colour = G.C.GREEN
	G.mainlineBtn.config.colour = G.C.CRY_SELECTED
	G.madnessBtn.config.colour = G.C.Entropy.HYPER_EXOTIC
	G.FUNCS.cry_intro_part("mainline")
	G.selectedGameset = "mainline"
end

local gtc = get_type_colour
function get_type_colour(center, card)
	local color = gtc(center, card)
	if center.set == "Back" or center.set == "Tag" or center.set == "Blind" then
		color = G.C.CRY_SELECTED
	end
	if card.gameset_select then
		if center.force_gameset == "modest" then
			color = G.C.GREEN
		elseif center.force_gameset == "mainline" then
			color = G.C.RED
		elseif center.force_gameset == "madness" then
			color = G.C.Entropy.HYPER_EXOTIC
		elseif center.force_gameset ~= "disabled" then
			color = G.C.CRY_ASCENDANT
		end
	end
	if
		Cryptid.gameset(card, center) == "disabled"
		or (center.cry_disabled and (not card.gameset_select or center.cry_disabled.type ~= "manual"))
	then
		color = mix_colours(G.C.RED, G.C.GREY, 0.7)
	end
	return color
end
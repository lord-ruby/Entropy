SMODS.Shader({
    key="entropic_vortex",
    path="splash.fs"
})

-- Entropy.Blind{
-- 	dependencies = {
--         items = {
--           "set_entr_blinds"
--         }
--     },
--     order = 6664,
-- 	key = "endless_entropy_phase_three",
-- 	pos = { x = 0, y = 7 },
-- 	atlas = "blinds",
-- 	boss_colour = HEX("000000"),
--     mult=3,
--     dollars = 8,
-- 	boss = {
-- 		min = 32,
-- 		max = 32,
-- 	},
-- 	no_disable=true,
-- 	in_pool = function() return false end,
-- 	next_phase = "bl_entr_endless_entropy_phase_two",
-- 	loc_vars = function(self, info_queue, card)
-- 		return { vars = { get_blind_amount(G.GAME.round_resets.ante) * 3 * G.GAME.starting_params.ante_scaling } } -- no bignum?
-- 	end,
-- 	collection_loc_vars = function(self)
-- 		return { vars = { localize("entr_nadir_placeholder") } }
-- 	end,
-- 	set_blind = function()
-- 		G.GAME.EE_R = nil
-- 		G.GAME.EE_FADE_SPEED = nil
-- 		Entropy.create_ee_splash()
-- 	end
-- }

-- Entropy.Blind{
-- 	dependencies = {
--         items = {
--           "set_entr_blinds"
--         }
--     },
--     order = 6665,
-- 	key = "endless_entropy_phase_two",
-- 	pos = { x = 0, y = 8 },
-- 	atlas = "blinds",
-- 	boss_colour = HEX("000000"),
--     mult=1,
--     dollars = 8,
-- 	boss = {
-- 		min = 32,
-- 		max = 32,
-- 	},
-- 	no_disable=true,
-- 	in_pool = function() return false end,
-- 	next_phase = "bl_entr_endless_entropy_phase_four",
-- 	calculate = function(self, blind, context)
-- 		if to_big(G.GAME.chips) > to_big(G.GAME.blind.chips) then
-- 			G.GAME.chips = 0
-- 			G.GAME.blind:set_blind(G.P_BLINDS[self.next_phase])
-- 			Entropy.change_phase()
-- 			G.GAME.blind:juice_up()
-- 			ease_hands_played(G.GAME.round_resets.hands-G.GAME.current_round.hands_left)
-- 			ease_discard(
-- 				math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards) - G.GAME.current_round.discards_left
-- 			)
-- 			G.FUNCS.draw_from_discard_to_deck()
-- 			G.jokers:load(G.GAME.EE_JOKERS)
-- 			G.GAME.hands = copy_table(G.GAME.EE_HANDS)
-- 			G.GAME.EE_HANDS = nil
-- 			G.GAME.EE_JOKERS = nil
-- 		end
-- 	end,
-- 	set_blind = function()
-- 		Entropy.ee_taunt("entr_tq_ee_half")
-- 		G.GAME.EE_JOKERS = G.jokers:save()
-- 		G.GAME.EE_HANDS = copy_table(G.GAME.hands)
-- 		for i, v in pairs(G.GAME.hands) do
-- 			v.mult = v.s_mult
-- 			v.chips = v.s_chips
-- 			v.level = 1
-- 			G.GAME.hands[i] = v
-- 		end
-- 		G.E_MANAGER:add_event(Event{
-- 			func = function()
-- 				for i, v in pairs(G.jokers.cards) do
-- 					local c = v
-- 					G.E_MANAGER:add_event(Event{
-- 						trigger = "after",
-- 						delay = 0.15 * G.SETTINGS.GAMESPEED,	
-- 						func = function()
-- 							c:juice_up()
-- 							c.debuff = true
-- 							play_sound("multhit1")
-- 							return true
-- 						end
-- 					})
-- 				end
-- 				G.E_MANAGER:add_event(Event{
-- 					trigger = "after",
-- 					delay = 0.4 * G.SETTINGS.GAMESPEED,
-- 					func = function()
-- 						for i, v in pairs(G.jokers.cards) do
-- 							v:start_dissolve()
-- 						end
-- 						play_sound("glass6")
-- 						return true
-- 					end
-- 				})
-- 				G.E_MANAGER:add_event(Event{
-- 					trigger = "after",
-- 					func = function()
-- 						save_run()
-- 						return true
-- 					end
-- 				})
-- 				return true
-- 			end
-- 		})
-- 		G.GAME.blind.chips = 10000
-- 		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
-- 		G.HUD_blind:recalculate()
-- 		G.GAME.EE_R = nil
-- 		G.GAME.EE_FADE_SPEED = nil
-- 		Entropy.create_ee_splash()
-- 	end
-- }

-- Entropy.Blind{
-- 	dependencies = {
--         items = {
--           "set_entr_blinds"
--         }
--     },
--     order = 6666,
-- 	key = "endless_entropy_phase_four",
-- 	pos = { x = 0, y = 9 },
-- 	atlas = "blinds",
-- 	boss_colour = HEX("000000"),
--     mult=1,
--     dollars = 8,
-- 	no_disable=true,
-- 	boss = {
-- 		min = 32,
-- 		max = 32,
-- 	},
-- 	exponent = {
-- 		1, 1.5
-- 	},
-- 	in_pool = function() return false end,
-- 	set_blind = function(self, reset, silent)
-- 		G.GAME.EE_R = nil
-- 		G.GAME.EE_FADE_SPEED = nil
-- 		Entropy.create_ee_splash()
-- 	end,
-- 	defeat = function(self, silent)
-- 		G.GAME.EEBeaten = true
-- 		if G.GAME.EEBuildup then
-- 			Entropy.win_EE()
-- 		end
-- 		G.GAME.EEBuildup = false
-- 		check_for_unlock({ type = "beat_ee" })
--         Entropy.destroy_ee_splash()
-- 	end,
-- 	get_copied_blinds = function()
-- 		local b = {}
-- 		for i, v in pairs(Entropy.get_EE_blinds()) do b[#b+1] = i end
-- 		return b
-- 	end
-- }

Entropy.Joker{
    key = "eecc",
    order = 10^300,
    rarity = "entr_zenith",
    cost = 10,
    atlas = "ee_atlas",
    pos = {x=0, y=0},
    soul_pos = {x = 4, y = 3, extra = {x=0,y=1}},
    no_doe = true,
    no_collection = true,
	in_pool = function()
		return false
	end
}

SMODS.Shader({
    key="brimstone",
    path="brimstone.fs"
})

SMODS.Shader({
    key="brimstone_badge",
    path="brimstone_badge.fs"
})

function Entropy.ee_ante()
    return 32
end

function Entropy.can_ee_spawn()
    if MP and MP.LOBBY and MP.LOBBY.code then return false end
    return Cryptid.enabled("bl_entr_endless_entropy_phase_one")
    and Cryptid.enabled("bl_entr_endless_entropy_phase_two")
    and Cryptid.enabled("bl_entr_endless_entropy_phase_three")
    and Cryptid.enabled("bl_entr_endless_entropy_phase_four")
end

function Entropy.is_EE()
    return G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind.endless_entropy
end

function Entropy.win_EE()
    G.GAME.EE_SCREEN = false
    G.GAME.EE_R = true
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            for k, v in pairs(G.I.CARD) do
                v.sticker_run = nil
            end
            
            play_sound('win')
            G.SETTINGS.paused = true
            G.GAME.TrueEndless = true
            G.FUNCS.overlay_menu{
                definition = create_UIBox_win(),
                config = {no_esc = true}
            }
            local Jimbo = nil

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 2.5,
                blocking = false,
                func = (function()
                    if G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot') then 
                        local quip, extra = SMODS.quip("ee_win")
                        extra.x = 0
                        extra.y = 5
                        Jimbo = Card_Character(extra)
                        local spot = G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot')
                        spot.config.object:remove()
                        spot.config.object = Jimbo
                        Jimbo.ui_object_updated = true
                        Jimbo:add_speech_bubble(quip, nil, {quip = true})
                        Jimbo:say_stuff(5)
                    end
                    return true
                end)
            }))
            
            return true
        end)
    }))

    if (not G.GAME.seeded and not G.GAME.challenge) or SMODS.config.seeded_unlocks then
        G.PROFILES[G.SETTINGS.profile].stake = math.max(G.PROFILES[G.SETTINGS.profile].stake or 1, (G.GAME.stake or 1)+1)
    end
    G:save_progress()
    G.FILE_HANDLER.force = true
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            if not G.SETTINGS.paused then
                G.GAME.current_round.round_text = 'Endless Round '
                return true
            end
        end)
    }))
end

local disable_ref = Blind.disable
function Blind:disable()
	if not self.config.blind.no_disable then disable_ref(self) end
end

local ref = G.FUNCS.reroll_boss
G.FUNCS.reroll_boss = function(e) 
	if G.GAME.EEBuildup then return end
	ref(e)
end

function Entropy.is_ee_or_buildup()
    return (to_big(G.GAME.round_resets.ante) >= to_big(32) and not G.GAME.EEBeaten) or G.GAME.EEBuildup
end

function Entropy.spawn_ee_ui()
    G.GAME.round_resets.blind_choices.Boss = "bl_entr_endless_entropy_phase_one"
    G.GAME.round_resets.blind_choices.Small = "bl_entr_void"
    G.GAME.round_resets.blind_choices.Big = "bl_entr_void"
    G.GAME.EEBuildup = true
    if not G.SPLASH_EE then
        G.GAME.EE_SCREEN = true
        G.SPLASH_EE = Sprite(-30, -13, G.ROOM.T.w+60, G.ROOM.T.h+22, G.ASSET_ATLAS["ui_1"], {x = 9999, y = 0})
        G.GAME.EE_FADE = 0
        G.GAME.EE_FLAMES = 0
        G.E_MANAGER:add_event(Event({
            trigger = 'ease',
            ease = 'inexpo',
            ref_table = G.GAME,
            ref_value = 'EE_FLAMES',
            ease_to = 0.2,
            delay = 5,
            timer = "REAL",
            func = (function(t) return t end),
            blockable = false,
        }), "entr_desc")
        G.SPLASH_EE:define_draw_steps({{
            shader = 'entr_entropic_vortex',
            send = {
                {name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
                --ame = 'vort_speed', val = 1},
                --{name = 'colour_1', ref_table = G.C, ref_value = 'BLUE'},
                --{name = 'colour_2', ref_table = G.C, ref_value = 'WHITE'},
                --{name = 'mid_flash', val = 0},
                {name = 'fade_in', ref_table = G.GAME, ref_value = "EE_FADE"},
                {name = 'flame_height', ref_table = G.GAME, ref_value = "EE_FLAMES"},
                --{name = 'vort_offset', val = (2*90.15315131*os.time())%100000},
            }}}
        )
    end
    attention_text({
        text = "CHALLENGE",
        scale = 1.1,
        hold = 60000,
        major = G.play,
        backdrop_colour = HEX("ff0000"),
        align = 'cm',
        offset = {x = 0, y = -3},
    })
    attention_text({
        text = "v",
        scale = 0.8,
        hold = 60000,
        major = G.play,
        align = 'cm',
        offset = {x = 0, y = -2.35},
    })
    local index = #G.I.UIBOX
    local index2 = #G.I.UIBOX - 1
    G.E_MANAGER:add_event(Event{
        blocking = false,
        blockable = false,
        func = function()
            if G.GAME.blind.in_blind then
                G.I.UIBOX[index]:remove()
                G.I.UIBOX[index2]:remove()
                table.remove(G.I.UIBOX, index)
                table.remove(G.I.UIBOX, index2)
                return true
            end
        end
    })
    --
    return {n=G.UIT.ROOT, config = {align = 'tm',minw = 100, minh = 100, r = 0.15, colour = G.C.CLEAR,
        func = 'can_enter_ee', one_press = true, button = 'enter_ee'
    }, nodes={}}
end

local unblind_void_ref = UnBlind_create_UIBox_blind
function UnBlind_create_UIBox_blind(type)
    if Entropy.can_ee_spawn() then
        if to_big(G.GAME.round_resets.ante) < to_big(32) then G.GAME.EEBeaten = false end
        if Entropy.is_ee_or_buildup() then
            G.GAME.round_resets.blind_choices.Boss = "bl_entr_endless_entropy_phase_one"
            G.GAME.round_resets.blind_choices.Small = "bl_entr_void"
            G.GAME.round_resets.blind_choices.Big = "bl_entr_void"
            G.GAME.EEBuildup = true
        end
    end
    return unblind_void_ref(type)
end

SMODS.ScreenShader({
    key="eeshader",
    path="eeshader.fs",
    send_vars = function (sprite, card)
        local t = G.TIMERS.REAL or 0
        t = t - 5000*math.floor(t/5000)
        return {
            realtime = t,
            redshift = G.GAME.ee_redshift or 0,
            distort_mod = G.GAME.ee_distortmod or 1
        }
    end,
    should_apply = function()
        --return G.GAME.EEBuildup or Entropy.is_EE() or (G.GAME.EE_FADE or 0) > 0
    end
})

function Entropy.create_ee_splash()
    if not G.SPLASH_EE then
        G.GAME.EE_SCREEN = true
        G.SPLASH_EE = Sprite(-30, -13, G.ROOM.T.w+60, G.ROOM.T.h+22, G.ASSET_ATLAS["ui_1"], {x = 9999, y = 0})
        G.GAME.EE_FADE = 0
        G.GAME.EE_FLAMES = 0
        G.E_MANAGER:add_event(Event({
            trigger = 'ease',
            ease = 'inexpo',
            ref_table = G.GAME,
            ref_value = 'EE_FLAMES',
            ease_to = 0.2,
            delay = 5,
            timer = "REAL",
            func = (function(t) return t end),
            blockable = false,
        }), "entr_desc")
        G.SPLASH_EE:define_draw_steps({{
            shader = 'entr_entropic_vortex',
            send = {
                {name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
                --ame = 'vort_speed', val = 1},
                --{name = 'colour_1', ref_table = G.C, ref_value = 'BLUE'},
                --{name = 'colour_2', ref_table = G.C, ref_value = 'WHITE'},
                --{name = 'mid_flash', val = 0},
                {name = 'fade_in', ref_table = G.GAME, ref_value = "EE_FADE"},
                {name = 'flame_height', ref_table = G.GAME, ref_value = "EE_FLAMES"},
                --{name = 'vort_offset', val = (2*90.15315131*os.time())%100000},
            }}}
        )
    end
end

function Entropy.destroy_ee_splash()
    if G.GAME.modifiers.zenith then return end
    G.GAME.EE_R = true
    G.E_MANAGER:add_event(Event{
        blocking = false,
        blockable = false,
        func = function()
            if not G.GAME.EE_FADE or not G.SPLASH_EE then return end
            if G.GAME.EE_FADE <= 0 and G.SPLASH_EE then
                G.SPLASH_EE:remove()
                G.SPLASH_EE = nil
                return true
            end
        end
    })
end

function Blind:change_dim(w, h)
    w = (w or self.T.w) * self.children.animatedSprite.atlas.px / 34
    h = (h or self.T.h) * self.children.animatedSprite.atlas.py / 34
    self.T.w = w
    self.T.h = h
    self.children.animatedSprite.T.w = w
    self.children.animatedSprite.T.h = h
    self.children.animatedSprite:rescale()
end

local blind_load = Blind.load
function Blind:load(...)
    local r = blind_load(self, ...)
    self.children.animatedSprite.scale = {
        x = self.children.animatedSprite.atlas.px,
        y = self.children.animatedSprite.atlas.py
    }
    self.children.animatedSprite:reset()
    self:change_dim(1.5, 1.5)
    return r
end

local blind_set = Blind.set_blind
function Blind:set_blind(...)
    blind_set(self, ...)    
    self.children.animatedSprite.scale = {
        x = self.children.animatedSprite.atlas.px,
        y = self.children.animatedSprite.atlas.py
    }
    self.children.animatedSprite:reset()
    self:change_dim(1.5, 1.5)
end

function Entropy.change_phase()
    G.STATE = 1
    G.STATE_COMPLETE = false
    local remove_temp = {}
    for i, v in pairs({G.jokers, G.hand, G.consumeables, G.discard, G.deck}) do
        for ind, card in pairs(v.cards) do
            if card.ability then
                if card.ability.temporary or card.ability.temporary2 or card.ability.void_temporary then
                    if card.area ~= G.hand and card.area ~= G.play and card.area ~= G.jokers and card.area ~= G.consumeables then card.states.visible = false end
                    card:remove_from_deck()
                    G.entr_bypass_rebirth = true
                    card:start_dissolve()
                    G.entr_bypass_rebirth = nil
                    if card.ability.temporary then remove_temp[#remove_temp+1]=card end
                end
            end
        end
    end
    if #remove_temp > 0 then
        SMODS.calculate_context({remove_playing_cards = true, removed=remove_temp})
    end
    G.deck:shuffle()
    G.E_MANAGER:add_event(Event({func = function()
        G.GAME.ChangingPhase = nil
        return true
    end}))
end

local STP = loadStackTracePlus()
local utf8 = require("utf8")
function Entropy.fake_crash(msg)
    msg = tostring(msg)

    --sendErrorMessage("Oops! The game crashed\n" .. STP.stacktrace(msg), 'StackTrace')

    if not love.window or not love.graphics or not love.event then
        return
    end


    Entropy.crash_volume = Entropy.crash_volume or G.SETTINGS.SOUND.volume
    G.SETTINGS.SOUND.volume = 0

    love.graphics.reset()
    local font = love.graphics.setNewFont("resources/fonts/m6x11plus.ttf", 20)

    local background = {0, 0, 1}
    if G and G.C and G.C.BLACK then
        background = G.C.BLACK
    end
    love.graphics.clear(background)
    love.graphics.origin()

    local trace = STP.stacktrace("", 3)

    local sanitizedmsg = {}
    for char in msg:gmatch(utf8.charpattern) do
        table.insert(sanitizedmsg, char)
    end
    sanitizedmsg = table.concat(sanitizedmsg)

    local err = {}

    table.insert(err, "Oops! The game crashed:")
    if sanitizedmsg:find("Syntax error: game.lua:4: '=' expected near 'Game'") then
        table.insert(err,
            'Duplicate installation of Steamodded detected! Please clean your installation: Steam Library > Balatro > Properties > Installed Files > Verify integrity of game files.')
    elseif sanitizedmsg:find("Syntax error: game.lua:%d+: duplicate label 'continue'") then
        table.insert(err,
            'Duplicate installation of Steamodded detected! Please remove the duplicate steamodded/smods folder in your mods folder.')
    else
        table.insert(err, sanitizedmsg)
    end
    if #sanitizedmsg ~= #msg then
        table.insert(err, "Invalid UTF-8 string in error message.")
    end

    if V and SMODS and SMODS.save_game and V(SMODS.save_game or '0.0.0') ~= V(SMODS.version or '0.0.0') then
        table.insert(err, 'This crash may be caused by continuing a run that was started on a previous version of Steamodded. Try creating a new run.')
    end

    if V and V(MODDED_VERSION or '0.0.0') ~= V(RELEASE_VERSION or '0.0.0') then
        table.insert(err, '\n\nDevelopment version of Steamodded detected! If you are not actively developing a mod, please try using the latest release instead.\n\n')
    end

    if not V then
        table.insert(err, '\nA mod you have installed has caused a syntax error through patching. Please share this crash with the mod developer.\n')
    end

    local success, msg = pcall(getDebugInfoForCrash)
    if success and msg then
        table.insert(err, '\n' .. msg)
    else
        table.insert(err, "\n" .. "Failed to get additional context :/")
    end

    for l in trace:gmatch("(.-)\n") do
        table.insert(err, l)
    end

    local p = table.concat(err, "\n")

    p = p:gsub("\t", "")
    p = p:gsub("%[string \"(.-)\"%]", "%1")

    local scrollOffset = 0
    local endHeight = 0

    local pos = 70
    local arrowSize = 20

    local function calcEndHeight()
        local font = love.graphics.getFont()
        local rw, lines = font:getWrap(p, love.graphics.getWidth() - pos * 2)
        local lineHeight = font:getHeight()
        local atBottom = scrollOffset == endHeight and scrollOffset ~= 0
        endHeight = #lines * lineHeight - love.graphics.getHeight() + pos * 2
        if (endHeight < 0) then
            endHeight = 0
        end
        if scrollOffset > endHeight or atBottom then
            scrollOffset = endHeight
        end
    end

    p = p .. "\n\nPress ESC to exit\nPress R to restart the game"
    if love.system then
        p = p .. "\nPress Ctrl+C or tap to copy this error"
    end

    if not love.graphics.isActive() then
        return
    end
    love.graphics.clear(background)
    calcEndHeight()
    love.graphics.printf(p, pos, pos - scrollOffset, love.graphics.getWidth() - pos * 2)
    if scrollOffset ~= endHeight then
        love.graphics.polygon("fill", love.graphics.getWidth() - (pos / 2),
            love.graphics.getHeight() - arrowSize, love.graphics.getWidth() - (pos / 2) + arrowSize,
            love.graphics.getHeight() - (arrowSize * 2), love.graphics.getWidth() - (pos / 2) - arrowSize,
            love.graphics.getHeight() - (arrowSize * 2))
    end
    if scrollOffset ~= 0 then
        love.graphics.polygon("fill", love.graphics.getWidth() - (pos / 2), arrowSize,
            love.graphics.getWidth() - (pos / 2) + arrowSize, arrowSize * 2,
            love.graphics.getWidth() - (pos / 2) - arrowSize, arrowSize * 2)
    end
    love.graphics.present()
end

--APRIL FOOLS CONTENT, REMOVE LATER
Entropy.ee_dialog = {
    ee_intro_1 = {type = "text", strings = {
        "You walk forward into the door of the cathedral,",
        "In front of you a bloodstained altar."
    }, next = "ee_intro_2"},
    ee_intro_2 = {type = "text", strings = {
        "The air around you is cold, as you approach the",
        "altar it only gets colder."
    }, next = "ee_intro_3"},
    ee_intro_3 = {type = "text", strings = {
        "Its very dark in here other than a faint red",
        "glow from the stained glass window panes."
    }, next = "ee_intro_4"},
    ee_intro_4 = {type = "text", strings = {
        "You dont have a good feeling ab-"
    }, next = "ee_start_1"},

    ee_start_1 = {type = "text", strings = {
        "You bump into a cloaked figure, its hard",
        "to tell what she looks like but she has",
        "an ominous vibe around her."
    }, next = "ee_start_2"},

    ee_start_2 = {speaker = "???", emotion = "dark", type = "text", strings = {
        [["Oh, an insolent fool wishes to become another sacrifice?"]]
    }, next = "ee_start_3"},

    ee_start_3 = {speaker = "???", emotion = "dark", type = "choice", choices = {
        {string = [["Yes Mommy"]], func = function() 
            Entropy.clean_up_dating_sim()
            G.STATE = G.STATES.GAME_OVER
            G.STATE_COMPLETE = false 
            play_sound("entr_snd_ominous")
        end},
        {string = "Apologize.", next = "ee_start_4"},
    }},

    ee_start_4 = {speaker = "Y/N", emotion = "dark", type = "text", strings = {
        "Im sorry..."
    }, next = "ee_start_5"},

    ee_start_5 = {speaker = "???", emotion = "dark", type = "text", strings = {
        "You better be, you foolish sinner.",
        "What makes you think you can enter this cathedral.",
        "Without anyone noticing you?"
    }, func = function()
        G.GAME.entr_current_dialog = "ee_fakeout_choice_1"
        G.E_MANAGER:add_event(Event{
            timer = "REAL",
            trigger = "after",
            delay = 0.5,
            blockable = false,
            func = function()
                G.GAME.entr_current_dialog = "ee_start_6"
                G.GAME.entr_dialog_string = ""
                G.GAME.entr_dialog_char_ind = 1
                G.GAME.entr_dialog_string_ind = 1
                G.GAME.entr_hovered_choice = nil
                return true
            end
        })
    end},
    ee_fakeout_choice_1 = {
        speaker = "???", type = "choice", emotion = "dark", choices = {
            {string = "I dont know", func = function() end},
            {string = "What makes you so special?", func = function() end},
        }
    },
    ee_start_6 = {
        speaker = "???", type = "text", emotion = "dark", strings = {
            "Dont even bother speaking.",
            "I don't care for what you have to say."
        }, next = "ee_start_7"
    },
    ee_start_7 = {speaker = "???", emotion = "dark", type = "choice", choices = {
        {string = [["..."]], next = "ee_start_8"},
        {string = "Say something.", next = "ee_start_8_alt"},
    }},

    ee_start_8 = {speaker = "Y/N", emotion = "dark", type = "text", strings = {
        "..."
    }, next = "ee_start_9"},

    ee_start_8_alt = {speaker = "Y/N", emotion = "dark", type = "text", strings = {
        "That's-"
    }, next = "ee_start_8_alt_2", music = "evil"},

    ee_start_8_alt_2 = {
        speaker = "???", type = "text", emotion = "dark", strings = {
            "SILENCE!",
        }, next = "ee_start_9",
    },

    ee_start_9 = {type = "text", emotion = "dark", strings = {
        "You just stand there, unsure of what to do.",
        "This seemed to please her,",
    }, next = "ee_start_10"},

    ee_start_10 = {speaker = "???", emotion = "dark", type = "text", strings = {
        "Good...",
    }, next = "ee_start_11"},

    ee_start_11 = {type = "text", emotion = "dark", strings = {
        "but only for a moment.",
    }, next = "ee_start_12"},

    ee_start_12 = {
        speaker = "???", type = "text", emotion = "normal", strings = {
            "Okay... Maybe I do care a little bit.",
            "What brings you here to this cathedral, mortal?"
        }, next = "ee_start_13", music = "normal"
    },

    ee_start_13 = {speaker = "???", emotion = "normal", type = "choice", choices = {
        {string = "Speak the truth.", next = "ee_start_14"},
        {string = "Lie.", next = "ee_start_14_alt"},
        },
    },

    ee_start_14 = {
        speaker = "Y/N", type = "text", emotion = "normal", strings = {
            "I've come here in search of the end.",
        }, next = "ee_start_15"
    },

    ee_start_14_alt = {
        speaker = "Y/N", type = "text", emotion = "normal", strings = {
            "I've come here to die.",
        }, next = "ee_start_15"
    },

    ee_start_15 = {
        speaker = "???", type = "text", emotion = "normal", strings = {
            "Well then, you've certainly come to the right place.",
            "Welcome to the Church of Blood",
            "where you'll worship me, Endless Entropy, until you perish."
        }, next = "ee_start_16", music = "evil"
    },

    ee_start_16 = {speaker = "ee", emotion = "normal", type = "choice", choices = {
        {string = [["... That's it?"]], next = "ee_start_17"},
        {string = "Feign excitement.", next = "ee_start_17_alt"},
        }, music = "normal"
    },

    ee_start_17 = {
        speaker = "Y/N", type = "text", emotion = "normal", strings = {
            "... That's it?",
        }, next = "ee_start_18"
    },

    ee_start_17_alt = {
        speaker = "Y/N", type = "text", emotion = "normal", strings = {
            "Great! That sounds like a good time.",
        }, next = "ee_start_27"
    },

    ee_start_18 = {type = "text", emotion = "shocked", strings = {
        "She recoils ever so slightly.",
    }, next = "ee_start_19", sound = "entr_eev4_shocked"},

    ee_start_19 = {
        speaker = "ee", type = "text", emotion = "shocked", strings = {
            [[... "That's it"?!]],
        }, next = "ee_start_20"
    },

    ee_start_20 = {
        speaker = "Y/N", type = "text", emotion = "shocked", strings = {
            "Yeah. I just expected this place to a bit more... grandiose, is all.",
        }, next = "ee_start_21",
    },

    ee_start_21 = {
        speaker = "ee", type = "text", emotion = "frown", strings = {
            "Grandiose?!",
        }, next = "ee_start_22"
    },

    ee_start_22 = {type = "text", emotion = "frown", strings = {
        "She spits the word out as if it is venom.",
    }, next = "ee_start_23"},

    ee_start_23 = {
        speaker = "ee", type = "text", emotion = "dark", strings = {
            "I'll have you know that this grandiose cathedral had lots of worshippers!",
            "Hell, I even had people willing to sacrifice themselves.",
            "Who are you to barge in here and desecrate this sacred place?",
        }, next = "ee_start_24", music = "evil"
    },

    ee_start_24 = {speaker = "ee", emotion = "dark", type = "choice", choices = {
        {string = [["Had...?"]], next = "ee_start_25"},
        {string = "Ask what happened.", next = "ee_start_25_alt"},
        },
    },

    ee_start_25 = {
        speaker = "Y/N", type = "text", emotion = "dark", strings = {
            "This place... had worshippers?",
        }, next = "ee_start_26"
    },

    ee_start_25_alt = {
        speaker = "Y/N", type = "text", emotion = "dark", strings = {
            "This place seems rather empty. What happened to them?",
        }, next = "ee_start_26"
    },

    ee_start_26 = {
        speaker = "ee", type = "text", emotion = "blush", strings = {
            "Well. Erm, I may have been a little bit too zealous.",
            "And maybe they were too.",
        }, next = "ee_start_27"
    },

    ee_start_27 = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
            "No matter.",
            "State your business or you will suffer the same fate as them.",
        }, next = "ee_branch"
    },

    ee_branch = {speaker = "ee", emotion = "normal", type = "choice", choices = {
        {string = "Volunteer.", next = "ee_good_1"},
        {string = "Do not volunteer.", next = "ee_bad_1"},
        },
    },

    ee_good_1 = {
        speaker = "Y/N", type = "text", emotion = "normal", strings = {
            "I would glady worship you, Endless Entropy.",
        }, next = "ee_good_2"
    },

    ee_good_2 = {type = "text", emotion = "normal", strings = {
        "She raises an eyebrow, as if contemplating, then grins.",
    }, next = "ee_good_3"},

    ee_good_3 = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
            "Good.",
            "I have many, many ideas for you.",
        }, next = "ee_good_5"
    },
    --note for max: i added these
    ee_good_5 = {
        speaker = "ee", type = "choice", emotion = "normal", choices = {
            {string = "Get closer to her.", next = "ee_good_6"},
            {string = [["Go on..."]], next = "ee_good_6_alt"},
        }, music = "normal"
    },

    ee_good_6 = {
        type = "text", emotion = "normal", strings = {
            "You try to get closer to her.",
            "As you walk towards her you can see",
            "a shocked look bubble to her eyes."
        }, next = "ee_good_7"
    },

    ee_good_6_alt = {
        speaker = "ee", type = "text", emotion = "blush", strings = {
            "Quite ready to offer yourself",
            "up for this huh...?"
        }, next = "ee_good_9"
    },

    ee_good_7 = {
        speaker = "ee", type = "text", emotion = "shocked", strings = {
            "My...",
            "You're feeling quite assertive, arent you?"
        },
        next = "ee_good_8",sound = "entr_eev4_shocked"
    },

    ee_good_8 = {
        type = "text", emotion = "blush", strings = {
            "She gets closer to you.",
            "Close enough to lean down and put her hand",
            "on your shoulder. She is quite a bit taller",
            "than you. You can feel her gaze upon your",
            "head before you tilt your eyes towards her."
        },
        next = "ee_good_9"
    },

    ee_good_9 = {
        speaker = "ee", type = "text", emotion = "blush", strings = {
            "So...",
            "How about you get on your knees.",
            "And start praying."
        },
        next = "ee_good_10"
    },

    ee_good_10 = {
        speaker = "ee", type = "choice", emotion = "blush", choices = {
            {string = "Pray", next = "ee_good_11_a1"},
            {string = "Pray", next = "ee_good_11_a2"},
            {string = "Pray", next = "ee_good_11_a3"},
            {string = "Pray", next = "ee_good_11_a4"},
            {string = "Pray", next = "ee_good_11_a5"},
            {string = "Pray", next = "ee_good_11_a6"},
            {string = "Pray", next = "ee_good_11_a7"},
        }
    },
    ee_good_11_a1 = {type="text",emotion="blush",next="ee_good_12", strings = {
        "You get down on your knees.",
        "The ground is colder than you expected,",
        "And you clasp your hands together...",
    }},
    ee_good_11_a2 = {type="text",emotion="blush",next="ee_good_12", strings = {
        "You get down on your knees.",
        "This feeling... something you have never",
        "felt before. You bring your hands together",
    }},
    ee_good_11_a3 = {type="text",emotion="blush",next="ee_good_12", strings = {
        "You get down on your knees.",
        "Her energy is electrifying.",
        "You pray; you dont know what for.",
    }},
    ee_good_11_a4 = {type="text",emotion="blush",next="ee_good_12", strings = {
        "You get down on your knees.",
        "Your mind is racing... No,",
        "May god save you now.",
        "You pray that she might."
    }},
    ee_good_11_a5 = {type="text",emotion="blush",next="ee_good_12", strings = {
        "You get down on your knees.",
        "Your heart is pounding.",
        "Your hands are weak but you",
        "manage to bring them toghether."
    }},
    ee_good_11_a6 = {type="text",emotion="blush",next="ee_good_12", strings = {
        "You get down on your knees",
        "and pray to her.",
    }},
    ee_good_11_a7 = {type="text",emotion="blush",next="ee_good_12", strings = {
        "You get down on your knees.",
        "Your hands are cold, But you",
        "still pray."
    }},

    ee_good_12 = {
        type = "text", emotion = "blush", strings = {
            "..."
        },
        next = "ee_good_13"
    },
    ee_good_13 = {
        type = "text", emotion = "blush", strings = {
            "..."
        },
        next = "ee_good_14"
    },
    ee_good_14 = {
        type = "text", emotion = "normal", strings = {
            "Well... Thats right. Thats right.",
            "Finally someone who gets it",
            "around here."
        },
        next = "ee_good_15"
    },
    ee_good_15 = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
            "So. How'd you even manage to",
            "stumble your way over here",
            "in the first place huh?"
        },
        next = "ee_good_16"
    },
    ee_good_16 = {
        speaker = "ee", type = "choice", emotion = "normal", choices = {
            {string = "Talk about #1#", next = "ee_good_17"},
            {string = "Talk about #2#", next = "ee_good_17_alt"},
        },
        loc_vars = function()
            return {
                G.GAME.entr_ante_8_boss,
                G.GAME.entr_ante_12_boss
            }
        end
    },
    ee_good_17 = {
        type = "text", emotion = "shocked", strings = {
            "You go on a big long rant about #1#",
            "and all that lead up to Ante 8",
            "she seems quite interested in the",
            "Jokers that let you get to this point"
        }, loc_vars = function() return {G.GAME.entr_ante_8_boss} end,
        next = "ee_good_18", sound = "entr_eev4_shocked"
    },
    ee_good_17_alt = {
        type = "text", emotion = "shocked", strings = {
            "You go on a big long rant about #1#",
            "and all that lead up to Ante 12",
            "she seems quite interested in the",
            "Jokers that let you get to this point"
        }, loc_vars = function() return {G.GAME.entr_ante_12_boss} end,
        next = "ee_good_18"
    },
    ee_good_18 = {
        type = "text", emotion = "shocked", strings = {
            "She lets you go on and on and on about the journey",
            "that brought you to this Cathedral, its hard to tell",
            "what her exacty impression is but she seems to",
            "enjoy the way that your journey unfolded to bring you here"
        },
        next = "ee_good_19"
    },
    ee_good_19 = {
        type = "text", emotion = "normal", strings = {
            "As you continue to speak she eventually interrupts you",
            "you can't tell if she has had an idea or if she just",
            "is getting bored of you talking about this but it is",
            "clear that she has decided to take back the reins"
        },
        next = "ee_good_20", music = "evil"
    },
    ee_good_20 = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
            "Well... isnt that quite interesting, You have",
            "a pretty powerful line up of material here",
            "dont you?"
        },
        next = "ee_good_21", music = "evil"
    },
    ee_good_21 = {
        type = "text", emotion = "dark", strings = {
            "As she continued to speak you could notice",
            "a fervent look in her eyes, as if you could",
            "tell the very moment she had gotten another",
            "idea for what to do with you next"
        },
        next = "ee_good_22"
    },
    ee_good_22 = {
        type = "text", emotion = "dark", strings = {
            "She had gotten closer to you. You gulp as she approaches",
            "she has an intimidating air around her and it has only",
            "gotten worse as you have realized the nature of her idea"
        },
        next = "ee_good_23"
    },

    ee_good_23 = {
        speaker = "ee", type = "text", emotion = "dark", strings = {
            "You wouldn't have gotten anywhere without these",
            [["Jokers" of yours, wouldn't you?]],
        }, next = "ee_good_24"
    },

    ee_good_24 = { --PLACEHOLDER
        type = "text", emotion = "dark", strings = {
            "She sizes you up, and a grin forms on her face.",
        }, next = "ee_good_25"
    },

    ee_good_25 = {
        speaker = "ee", type = "text", emotion = "dark", strings = {
            "So how about..."
        }, next = "ee_good_26"
    },

    ee_good_26 = {
        type = "text", emotion = "dark", strings = {
            "She pauses for dramatic effect.",
            "You feel like you could break out in sweat",
            "at any moment."
        }, next = "ee_good_27"
    },

    ee_good_27 = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
            "You give me one of them? As an offering.",
            "To prove your willingness to serve me.",
            "You can pick which one."
        }, next = "ee_good_28"
    },
    
    ee_good_28 = {
        type = "text", emotion = "normal", strings = {
            "Oh. That's not so bad.",
            "You grab your Jokers, inspecting your compatriots.",
            "Which one are you willing to part with?"
        }, next = "ee_good_29"
    },

    ee_good_29 = {
        type = "choice", emotion = "normal", choices = {}, loc_vars = function(self)
            local rarities = {
                entr_void = 3.5,
                entr_reverse_legendary = 5,
                entr_entropic = 6,
            }

            local highest = {}
            local encountered = {}

            for i,v in pairs(G.jokers.cards) do
                if not encountered[v.config.center.rarity] then
                    highest[#highest+1] = rarities[v.config.center.rarity] or (type(v.config.center.rarity) == 'number' and v.config.center.rarity) or 1
                    encountered[v.config.center.rarity] = true
                end
            end
            table.sort(highest, function(a, b)
                return a > b
            end)

            for i,v in pairs(G.jokers.cards) do
                local next = "ee_good_to_sacrifice_1"
                if (#highest <= 3 and (rarities[v.config.center.rarity] or v.config.center.rarity) == highest[1]) or (#highest > 3 and ((rarities[v.config.center.rarity] or v.config.center.rarity) == highest[1] or (rarities[v.config.center.rarity] or v.config.center.rarity) == highest[2])) then
                    next = "ee_good_30"
                end
                self.choices[#self.choices+1] = {
                    string = "Offer: "..localize{type="name_text", set = v.config.center.set, key = v.config.center.key},
                    func = function()
                        v:start_dissolve()
                        G.GAME.entr_last_emotion = Entropy.ee_dialog[G.GAME.entr_current_dialog].emotion
                        G.GAME.entr_current_dialog = next
                        bump_dir = 0
                        if Entropy.ee_dialog[G.GAME.entr_current_dialog].type == "text" then
                            G.GAME.entr_dialog_string = ""
                            G.GAME.entr_dialog_char_ind = 1
                            G.GAME.entr_dialog_string_ind = 1
                        end
                        G.GAME.entr_hovered_choice = nil
                    end
                }
            end
            self.choices[#self.choices+1] = {string = "Refuse to offer anything", next = "ee_good_to_sacrifice_1_alt"}
        end,
    },

    ee_good_30 = {
        type = "text", emotion = "normal", strings = {
            "With much trouble, you pick one of them.",
            "It's one of your better ones.",
            "You feel conflicted about this decision, but hand it over you must.",
            "You hand it over to her.",
            "She inspects it with a keen eye.",
            "You don't have a good feeling about this."
        }, next = "ee_good_31"
    },

    ee_good_31 = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
            "Let's take a look...",
        }, next = "ee_good_32"
    },

    ee_good_32 = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
            "It's got quite a heft to it...",
            "Feels nice in the hand...",
            "And..."
        }, next = "ee_good_33"
    },

    ee_good_33 = {
        type = "text", emotion = "dark", strings = {
            "The joker starts floating in her hand.",
            "And it starts spinning,",
            "faster and faster."
        }, next = "ee_good_34"
    },

    ee_good_34 = {
        type = "text", emotion = "dark", strings = {
            "Before finally exploding in a miniature explosion.",
            "Your stomach drops.",
            "She snatches the remains out of the air.",
        }, next = "ee_good_35"
    },

    ee_good_35 = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
            "Yeah, that's the good stuff.",
            "Thank you for your offering.",
            "...What's with that look?",
        }, next = "ee_good_36"
    },

    ee_good_36 = {
        type = "text", emotion = "frown", strings = {
            "She has shifted her gaze onto you.",
            "You didn't notice it yet,",
            "but your eyes are welling up with tears",
            "The smirk from her face slowly dissipates."
        }, next = "ee_good_37", music = "normal",
    },

    ee_good_37 = {
        speaker = "ee", type = "text", emotion = "frown", strings = {
            "Are you alright?",
        }, next = "ee_good_38"
    },

    ee_good_38 = {
        speaker = "ee", type = "choice", emotion = "frown", choices = {
            {string = "Try to deflect.", next = "ee_good_39"},
            {string = "Admit it.", next = "ee_good_39_alt"},
        }
    },

    ee_good_39 = {
        speaker = "Y/N", type = "text", emotion = "frown", strings = {
            "No, I'm alright. I made my choice.",
            "Just... give me a sec."
        }, next = "ee_good_40"
    },

    ee_good_39_alt = {
        speaker = "Y/N", type = "text", emotion = "frown", strings = {
            "That was one of my favorites...",
            "It helped me so much..."
        }, next = "ee_good_40"
    },

    ee_good_40 = {
        type = "text", emotion = "frown", strings = {
            "Despite your best efforts, a tear escapes your eyes.",
            "Despite making the choice it's still a lot for you.",
            "She gets closer to you again.",
            "The hairs on the back of your neck stand up.",
            "Oh no. This is it, isn't it?",
        }, next = "ee_good_41"
    },

    ee_good_41 = {
        type = "text", emotion = "frown", strings = {
            "She raises her hand and...",
        }, next = "ee_good_42"
    },

    ee_good_42 = {
        type = "text", emotion = "frown", strings = {
            "Wipes the tear off your cheek?",
            "Her hand is warm to the touch, like",
            "a hot stream of water on your face"
        }, next = "ee_good_43"
    },

    ee_good_43 = {
        speaker = "ee", type = "text", emotion = "frown", strings = {
            "I'm sorry...",
            "I-I didn't-",
        }, next = "ee_good_44"
    },
    ee_good_44 = {
        speaker = "ee", type = "text", emotion = "frown", strings = {
            "...",
        }, next = "ee_good_45"
    },

    ee_good_45 = {
        type = "text", emotion = "frown", strings = {
            "For the first time, she's at a loss for words.",
            "You are at a loss too.",
            "You can see the gears slowly turning behind her eyes.",
            "A flicker of an idea.",
        }, next = "ee_good_46"
    },

    ee_good_46 = {
        type = "text", emotion = "frown", strings = {
            "She slowly raises her other hand.",
            "But then she abruptly stops. She hesitates.",
            "She squeezes her hand into a fist for a second.",
            "Then she pulls you into a hug.",
        }, next = "ee_good_47"
    },

    ee_good_47 = {
        type = "choice", emotion = "frown", choices = {
            {string = "Hug her back.", next = "ee_good_48"},
            {string = "Break out of the hug.", func = function() return end},
        }
    },
    ee_good_48 = {
        type = "choice", emotion = "frown", choices = {
            {string = "Keep hugging her", next = "ee_good_49"},
            {string = "Break out of the hug.", func = function() return end},
        }
    },
    ee_good_49 = {
        type = "choice", emotion = "normal", choices = {
            {string = "Dont let go.", next = "ee_good_50"},
            {string = "Break out of the hug.", func = function() return end},
        }
    },
    ee_good_50 = {
        type = "choice", emotion = "normal", choices = {
            {string = "Break out of the hug.", next = "ee_wish_1"},
        }, music = "normal"
    },

    ee_wish_1 = {
        speaker = "ee", emotion = "embarrased", strings = {
            "So...",
            "Maybe I can cheer you up.",
        }, next = "ee_wish_2", type = "text"
    },
    ee_wish_2 = {
        speaker = "ee", emotion = "normal", strings = {
            "I have the power to grant you anything you",
            "might wish for in the confines of this cathedral.",
            "But don't take advantage of this. Those better",
            "not have been alligator tears."
        }, next = "ee_wish_3", type = "text"
    },
    ee_wish_3 = {
        speaker = "ee", emotion = "normal", strings = {
            "So? What do you wish for.",
        }, next = "ee_wish_4", type = "text"
    },
    ee_wish_4 = {
        speaker = "ee", emotion = "normal", choices = {
            {string = "Wish for her to journey with you", next = "ee_good_end_1"},
            {string = "Wish for power", next = "ee_wish_to_sacrifice_1"},
        }, type = "choice"
    },

    ee_wish_to_sacrifice_1 = {
        speaker = "Y/N", emotion = "normal", strings = {
            "I wish for... power."
        }, next = "ee_wish_to_sacrifice_2", type = "text"
    },

    ee_wish_to_sacrifice_2 = {
        type = "text", emotion = "frown", strings = {
            "She raises an eyebrow."
        }, next = "ee_wish_to_sacrifice_3"
    },

    ee_wish_to_sacrifice_3 = {
        speaker = "ee", emotion = "frown", strings = {
            "Power?",
            "I can give that.",
            "It's just...",
            "I don't give it out. Not without some proper sacrifice.",
            "I need proof of complete devotion.",
            "And I think I know how you will have to prove yourself."
        }, next = "ee_good_to_sacrifice_9", type = "text", music = "evil"
    },

    ee_good_end_1 = {
        speaker = "Y/N", emotion = "normal", strings = {
            "Will you..."
        }, next = "ee_good_end_2", type = "text"
    },
    ee_good_end_2 = {
        emotion = "normal", strings = {
            "You stumble over your words, you are very",
            "anxious. You realize she can tell this",
            "but she is being patient."
        }, next = "ee_good_end_3", type = "text"
    },
    ee_good_end_3 = {
        speaker = "Y/N", emotion = "normal", strings = {
            "Will you...",
            "Leave this cathedral...",
            "And come with me..."
        }, next = "ee_good_end_4", type = "text"
    },
    ee_good_end_4 = {
        speaker = "Y/N", emotion = "normal", strings = {
            "I cant imagine how long you have been",
            "cooped up in here. There is so much to",
            "see out there, and I have nothing else",
            "to wish for than to get to know you better"
        }, next = "ee_good_end_5", type = "text"
    },
    ee_good_end_5 = {
        emotion = "shocked", strings = {
            "She is taken aback, she knew your wish was",
            "going to be something serious with the way",
            "your demeanor shifted. But... no one has",
            "ever asked her for something like this before."
        }, next = "ee_good_end_6", sound = "entr_eev4_shocked", type = "text"
    },
    ee_good_end_6 = {
        emotion = "blush", strings = {
            "She reaches out to your hand and grabs it",
            "you don't hesitate nor flinch. She looks",
            "as if a massive weight has been lifted",
            "from off of her back."
        }, next = "ee_good_end_7", type = "text"
    },

    ee_good_end_7 = {
        speaker = "ee", emotion = "blush", strings = {
            "You want me... to leave the cathedral?",
            "I have wondered about what lays outside",
            "the bounds of this sanctuary for a long time,",
            "but I have never had a good reason to leave."
        }, next = "ee_good_end_8", type = "text"
    },
    --insert exposition about ee idk man im tired rn
    ee_good_end_8 = {
        speaker = "ee", emotion = "blush", strings = {
            "But... Maybe... This is a good reason."
        }, next = "ee_good_end_9", type = "text"
    },
    ee_good_end_9 = {
        emotion = "blush", strings = {
            "She shifts in place. For a deity she's",
            "awfully nervous; it is kind of contagious.",
            "You can't help but sweat at the thought",
            "of your own proposition."
        }, next = "ee_good_end_10", type = "text"
    },
    ee_good_end_10 = {
        emotion = "blush", strings = {
            "She gets closer to you, touches your hand with hers.",
            "She feels warm, more like holding your hand over an",
            "open flame than the regular warmth of another person."
        }, next = "ee_good_end_11", type = "text"
    },
    ee_good_end_11 = {
        emotion = "blush", strings = {
            "She leans into you..."
        }, next = "ee_good_end_12", type = "text"
    },
    ee_good_end_12 = {
        emotion = "blush", strings = {
            "She puts her hand around your back... and",
            "she kisses you, slowly."
        }, next = "ee_good_end_13", sound = "entr_e_rizz", type = "text"
    },
    ee_good_end_13 = {
        speaker = "ee", emotion = "shocked", strings = {
            "..."
        }, next = "ee_good_end_14", type = "text"
    },
    ee_good_end_14 = {
        speaker = "ee", emotion = "blush", strings = {
            "Well... I would be glad to."
        }, next = "ee_good_end_15", type = "text"
    },
    ee_good_end_15 = {
        emotion = "blush", strings = {
            "She gets up with you and starts to head towards the",
            "cathedral exit. The crimson window panes glisten in",
            "the surrounding inferno. You don't really know where",
            "you will head off to next but you feel as if you have",
            "made the correct decision here..."
        }, func = function()
            Entropy.clean_up_dating_sim()
            G.GAME.chips = G.GAME.blind.chips
            G.STATE = G.STATES.HAND_PLAYED
            G.STATE_COMPLETE = false
            Entropy.win_EE()
        end, type = "text"
    },

    ee_good_to_sacrifice_1 = {
        type = "text", emotion = "normal", strings = {
            "With much trouble, you pick one of them.",
            "It's one you don't particularly care about.",
            "You feel conflicted about this decision, but hand it over you must.",
            "You hand it over to her.",
            "She inspects it with a keen eye.",
            "You don't have a good feeling about this."
        }, next = "ee_good_to_sacrifice_2", music = "evil"
    },

    ee_good_to_sacrifice_2 = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
            "Let's take a look...",
        }, next = "ee_good_to_sacrifice_3"
    },

    ee_good_to_sacrifice_3 = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
            "This feels quite flimsy...",
            "And not particularly heavy too...",
            "And..."
        }, next = "ee_good_to_sacrifice_4"
    },

    ee_good_to_sacrifice_4 = {
        type = "text", emotion = "dark", strings = {
            "The joker starts floating in her hand.",
            "And it starts spinning,",
            "faster and faster."
        }, next = "ee_good_to_sacrifice_5"
    },

    ee_good_to_sacrifice_5 = {
        type = "text", emotion = "dark", strings = {
            "Before finally exploding in a dissapointingly quiet pop.",
            "She snatches the remains out of the air.",
        }, next = "ee_good_to_sacrifice_6"
    },

    ee_good_to_sacrifice_6 = {
        speaker = "ee", type = "text", emotion = "dismissive", strings = {
            "Is that truly the cream of the crop?",
            "It feels... weak.",
            "I'm dissapointed.",
            "I expected more based on your appraisals."
        }, next = "ee_good_to_sacrifice_7"
    },
    ee_good_to_sacrifice_1_alt = {
        type = "text", emotion = "dark", strings = {
            "With much trouble, you decide to refuse her order.",
            "Who's she to tell you what to do or not.",
            "Or maybe you're just flat out broke.",
            "You don't have a good feeling about this."
        }, next = "ee_good_to_sacrifice_7_alt", music = "evil"
    },
    ee_good_to_sacrifice_7 = {
        type = "text", emotion = "dismissive", strings = {
            "Uh oh.",
            "Her gaze shifts upon you."
        }, next = "ee_good_to_sacrifice_8"
    },
    ee_good_to_sacrifice_7_alt = {
        type = "text", emotion = "dismissive", strings = {
            "Uh oh.",
            "Her gaze shifts upon you."
        }, next = "ee_good_to_sacrifice_8_alt"
    },

    ee_good_to_sacrifice_8 = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
            "But fret not.",
            "I shall grant you a second chance to prove yourself."
        }, next = "ee_good_to_sacrifice_9"
    },
    ee_good_to_sacrifice_8_alt = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
            "You're lucky I dont kill you where you stand.",
            "I shall grant you a second chance to prove yourself."
        }, next = "ee_good_to_sacrifice_9"
    },

    ee_good_to_sacrifice_9 = {
        type = "text", emotion = "dark", strings = {
            "She turns towards the bloody altar.",
            "Your stomach drops."
        }, next = "ee_good_to_sacrifice_10"
    },

    ee_good_to_sacrifice_10 = {
        speaker = "ee", type = "text", emotion = "dark", strings = {
            "To prove your willingness to serve me."
        }, next = "ee_good_to_sacrifice_11"
    },

    ee_good_to_sacrifice_11 = {
        type = "text", emotion = "dark", strings = {
            "She walks towards the altar",
            "You follow her. It's not like you have a choice, after all.",
            "You have to prove yourself.",
            "You know she is not messing around.",
            "You can't afford to fail."
        }, next = "ee_sacrifice_1"
    },

    ee_sacrifice_1 = {
        type = "text", emotion = "dark", strings = {
            "She hands you a dagger.",
            "It feels as heavy as the decision you are about to make.",
            "You get up close to the altar.",
            "You won't waste a single drop."
        }, next = "ee_sacrifice_3"
    },

    ee_sacrifice_3 = {
        speaker = "ee", type = "text", emotion = "dark", strings = {
            "Do what you must."
        }, next = "ee_sacrifice_4"
    },

    ee_sacrifice_4 = {
        speaker = "ee", type = "choice", emotion = "dark", choices = {
            {string = "Stab yourself.", func = function()
                G.GAME.entr_red_vignette_power = 0
                G.GAME.entr_current_dialog = "ee_sacrifice_5"
                G.GAME.entr_hovered_choice = nil
                G.GAME.entr_dialog_string = ""
                G.GAME.entr_dialog_char_ind = 1
                G.GAME.entr_dialog_string_ind = 1
                play_sound("entr_stab_"..math.random(1, 3))
                G.E_MANAGER:add_event(Event({
                    trigger = 'ease',
                    ease = 'outexpo',
                    ref_table = G.GAME,
                    ref_value = 'entr_red_vignette_power',
                    ease_to = 2,
                    delay = 0.25,
                    timer = "REAL",
                    func = (function(t) return t end),
                    blockable = false,
                }))
                --play_sound()
            end},
        },
    },

    ee_sacrifice_5 = {
        type = "text", emotion = "dark", strings = {
            "You stab yourself."
        }, next = "ee_sacrifice_6"
    },

    ee_sacrifice_6 = {
        type = "choice", emotion = "dark", choices = {
            {string = "Stab yourself.", func = function()
                G.GAME.entr_current_dialog = "ee_sacrifice_7"
                G.GAME.entr_hovered_choice = nil
                G.GAME.entr_dialog_string = ""
                G.GAME.entr_dialog_char_ind = 1
                G.GAME.entr_dialog_string_ind = 1
                play_sound("entr_stab_"..math.random(1, 3))
                G.E_MANAGER:add_event(Event({
                    trigger = 'ease',
                    ease = 'outexpo',
                    ref_table = G.GAME,
                    ref_value = 'entr_red_vignette_power',
                    ease_to = 3,
                    delay = 0.5,
                    timer = "REAL",
                    func = (function(t) return t end),
                    blockable = false,
                }))
                --play_sound()
            end},
        },
    },

    ee_sacrifice_7 = {
        type = "text", emotion = "dark", strings = {
            "Again."
        }, next = "ee_sacrifice_8"
    },
    
    ee_sacrifice_8 = {
        type = "choice", emotion = "dark", choices = {
            {string = "Stab yourself.", func = function()
                G.GAME.entr_current_dialog = "ee_sacrifice_9"
                G.GAME.entr_hovered_choice = nil
                G.GAME.entr_dialog_string = ""
                G.GAME.entr_dialog_char_ind = 1
                G.GAME.entr_dialog_string_ind = 1
                play_sound("entr_stab_"..math.random(1, 3))
                G.E_MANAGER:add_event(Event({
                    trigger = 'ease',
                    ease = 'outexpo',
                    ref_table = G.GAME,
                    ref_value = 'entr_red_vignette_power',
                    ease_to = 4,
                    delay = 0.5,
                    timer = "REAL",
                    func = (function(t) return t end),
                    blockable = false,
                }))
                --play_sound()
            end},
        },
    },

    ee_sacrifice_9 = {
        type = "text", emotion = "dismissive", strings = {
            "And again."
        }, next = "ee_sacrifice_10"
    },
    
    ee_sacrifice_10 = {
        type = "choice", emotion = "dismissive", choices = {
            {string = "Stab yourself.", func = function()
                G.GAME.entr_current_dialog = "ee_sacrifice_11"
                G.GAME.entr_hovered_choice = nil
                G.GAME.entr_dialog_string = ""
                G.GAME.entr_dialog_char_ind = 1
                G.GAME.entr_dialog_string_ind = 1
                play_sound("entr_stab_"..math.random(1, 3))
                G.E_MANAGER:add_event(Event({
                    trigger = 'ease',
                    ease = 'outexpo',
                    ref_table = G.GAME,
                    ref_value = 'entr_red_vignette_power',
                    ease_to = 5,
                    delay = 0.65,
                    timer = "REAL",
                    func = (function(t) return t end),
                    blockable = false,
                }))
                --play_sound()
            end},
        },
    },

    ee_sacrifice_11 = {
        type = "text", emotion = "shocked", strings = {
            "And again."
        }, func = function()
            G.GAME.entr_current_dialog = "ee_sacrifice_12"
            G.GAME.entr_hovered_choice = nil
            G.GAME.entr_dialog_string = ""
            G.GAME.entr_dialog_char_ind = 1
            G.GAME.entr_dialog_string_ind = 1
            play_sound("entr_stab_"..math.random(1, 3))
            G.E_MANAGER:add_event(Event({
                trigger = 'ease',
                ease = 'insine',
                ref_table = G.GAME,
                ref_value = 'entr_red_vignette_power',
                ease_to = 7,
                delay = 0.25,
                timer = "REAL",
                func = (function(t) return t end),
                blockable = false,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.75,
                func = function() 
                    play_sound("entr_stab_"..math.random(1, 3))
                    return true
                end,
                blockable = false,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 1.5,
                func = function() 
                    play_sound("entr_stab_"..math.random(1, 3))
                    return true
                end,
                blockable = false,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 2.25,
                func = function() 
                    play_sound("entr_stab_"..math.random(1, 3))
                    return true
                end,
                blockable = false,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 3.0,
                func = function() 
                    G.GAME.entr_current_dialog = "ee_sacrifice_14"
                    G.GAME.entr_hovered_choice = nil
                    G.GAME.entr_dialog_string = ""
                    G.GAME.entr_dialog_char_ind = 1
                    G.GAME.entr_dialog_string_ind = 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'ease',
                        ref_table = G.GAME,
                        ref_value = 'entr_red_vignette_power',
                        ease_to = 3,
                        delay = 0.5,
                        timer = "REAL",
                        func = (function(t) return t end),
                        blockable = false,
                    }))
                    return true
                end,
                blockable = false,
            }))
        end
    },

    ee_sacrifice_12 = {
        type = "text", emotion = "shocked", strings = {
            "And again and again and again and again and-"
        }, next = "ee_sacrifice_13"
    },

    ee_sacrifice_13 = {
        type = "choice", emotion = "shocked", choices = {
            {string = "Stab yourself.", func = function() return end},
        },
    },

    ee_sacrifice_14 = {
        speaker = "ee", type = "text", emotion = "shocked", strings = {
            "STOP!",
        }, next = "ee_sacrifice_15", music = "normal",
    },

    ee_sacrifice_15 = {
        type = "text", emotion = "shocked", strings = {
            "She grabs your wrist, holding you back.",
            "The raw fear in her eyes fills you",
            "with a mixture of emotions you can't quite name individually.",
        }, next = "ee_sacrifice_16"
    },

    ee_sacrifice_16 = {
        type = "text", emotion = "shocked", strings = {
            "You look down at what you have done."
        }, next = "ee_sacrifice_16"
    },

    ee_sacrifice_16 = {
        type = "text", emotion = "shocked", strings = {
            "Blood flows in a solid stream onto the altar.",
            "Your blood.",
            "Right. That makes sense.",
            "You drop the dagger out of your hand.",
            "Your legs buckle as consciousness begins fading.",
        }, next = "ee_sacrifice_17"
    },

    ee_sacrifice_17 = {
        type = "text", emotion = "shocked", strings = {
            "She catches you.",
            "You try leaning on the altar to keep your balance,",
            "But you have trouble holding yourself up."
        }, next = "ee_sacrifice_18"
    },

    ee_sacrifice_18 = {
        speaker = "ee", type = "text", emotion = "shocked", strings = {
            "What are you doing??",
        }, next = "ee_sacrifice_19"
    },

    ee_sacrifice_19 = {
        type = "text", emotion = "shocked", strings = {
            "She shoves her hand against your wounds.",
            "Both to stop the bloodflow, and to do something else.",
            "A warm sensation slowly fills your chest.",
            "Less and less blood flows onto the altar.",
            "And yet you feel better and better.",
        }, next = "ee_sacrifice_20", func = function()
            G.GAME.entr_current_dialog = "ee_sacrifice_20"
            G.GAME.entr_hovered_choice = nil
            G.GAME.entr_dialog_string = ""
            G.GAME.entr_dialog_char_ind = 1
            G.GAME.entr_dialog_string_ind = 1
            G.E_MANAGER:add_event(Event({
                    trigger = 'ease',
                    ref_table = G.GAME,
                    ref_value = 'entr_red_vignette_power',
                    ease_to = 0,
                    delay = 0.25,
                    timer = "REAL",
                    func = (function(t) return t end),
                    blockable = false,
                }))
         end,
    },

    ee_sacrifice_20 = {
        speaker = "ee", type = "text", emotion = "shocked", strings = {
            "I appreciate your devotion. I truly do.",
            "But even that is too much.",
            "I- I didn't expect you to-",
            "I just wanted to- to...",
        }, next = "ee_sacrifice_21", func = function()
            G.GAME.entr_current_dialog = "ee_sacrifice_21"
            G.GAME.entr_hovered_choice = nil
            G.GAME.entr_dialog_string = ""
            G.GAME.entr_dialog_char_ind = 1
            G.GAME.entr_dialog_string_ind = 1
            G.GAME.entr_red_vignette_power = nil
         end,
    },

    ee_sacrifice_21 = {
        type = "text", emotion = "shocked", strings = {
            "She retracts her hand from your chest.",
            "You look down again, just to see none of the wounds anymore.",
            "She healed you up.",
            "You look back up to her.",
            "She looks like she is on the verge of tears."
        }, next = "ee_sacrifice_22"
    },

    ee_sacrifice_22 = {
        type = "text", emotion = "shocked", strings = {
            "Without any warning, she pulls you into a hug.",
            "Rather than the warmth of a person, she almost feels like a fire.",
            "Yet somehow, it is still soothing, as you accept her embrance",
            "and hug her back.",
        }, next = "ee_sacrifice_23"
    },

    ee_sacrifice_23 = {
        speaker = "ee", type = "text", emotion = "shocked", strings = {
           "You... you idiot...",
        }, next = "ee_sacrifice_24"
    },

    ee_sacrifice_23 = {
        speaker = "ee", type = "choice", emotion = "shocked", choices = {
            {string = "Stay silent.", next = "ee_sacrifice_24_alt"},
            {string = "Apologise.", next = "ee_sacrifice_24"},
        },
    },

    ee_sacrifice_24_alt = {
        type = "text", emotion = "shocked", strings = {
           "You both just hug each other for a while.",
           "Without uttering a single word.",
           "Eventually, she speaks up."
        }, next = "ee_sacrifice_26"
    },

    ee_sacrifice_24 = {
        speaker = "Y/N", type = "text", emotion = "shocked", strings = {
           "I'm- I'm sorry...",
        }, next = "ee_sacrifice_25"
    },

    ee_sacrifice_25 = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
           "Nono, don't be.",
           "I shouldn't have told you to do it.",
           "I didn't think you would.",
           "And definitely not like that...",
           "But..."
        }, next = "ee_sacrifice_26"
    },

    ee_sacrifice_26 = {
        speaker = "ee", type = "text", emotion = "blush", strings = {
           "I'm... glad to know just how devoted you are",
           "If I am to take something away from this."
        }, next = "ee_sacrifice_27"
    },

    ee_sacrifice_27 = {
        type = "text", emotion = "normal", strings = {
            "She releases you from the hug.",
            "She glances at the altar, drenched in your blood.",
        }, next = "ee_sacrifice_28"
    },

    ee_sacrifice_28 = {
        speaker = "ee", type = "text", emotion = "normal", strings = {
           "I suppose you have proven yourself.",
           "Congratulations.",
           "Now, is there something you wish for?",
           "As a small recoup for... this."
        }, next = "ee_sacrifice_29"
    },

    ee_sacrifice_29 = {
        speaker = "ee", emotion = "normal", choices = {
            {string = "Wish for her to journey with you", next = "ee_good_end_1"},
            {string = "Wish for power", next = "ee_wish_to_sacrifice_1"},
        }, type = "choice"
    },

    ee_bad_1 = {
        speaker = "ee", music = "evil", emotion = "dark", strings = {
            "Then..."
        }, next = "ee_bad_2", type = "text"
    },
    ee_bad_2 = {
        speaker = "ee", emotion = "dark", strings = {
            "Give me a reason to not kill you where you stand."
        }, next = "ee_bad_3", type = "text"
    },
    ee_bad_3 = {
        speaker = "ee", emotion = "dark", choices = {
            {string = "Speak.", next = "ee_bad_4"},
        }, type = "choice"
    },
    ee_bad_4 = {
        emotion = "dark", strings = {
            "You try to speak but before you can even utter",
            "a word you find a dagger's edge held against",
            "your neck, adrenaline surges through your body."
        }, next = "ee_bad_5", type = "text"
    },
    ee_bad_5 = {
        emotion = "dark", strings = {
            "She gets even closer to you. You can feel her",
            "gaze burning a hole through your chest. You",
            "cant help but to tense up."
        }, next = "ee_bad_6", type = "text"
    },
    ee_bad_6 = {
        speaker = "ee", emotion = "dark", strings = {
            "Do you even know who I am?"
        }, next = "ee_bad_7", type = "text"
    },
    ee_bad_7 = {
        speaker = "ee", emotion = "dark", choices = {
            {string = "Defend Yourself.", next = "ee_bad_8_alt"},
            {string = "Listen To Her.", next = "ee_bad_8"},
        }, type = "choice"
    },
    ee_bad_8 = {
        emotion = "dark", strings = {
            "She rests her hands on your shoulders. You cant",
            "tell what this feeling is, but you have decided",
            "it is probably the best idea to listen to her."
        }, next = "ee_bad_9", type = "text"
    },
    ee_bad_8_alt = {
        emotion = "dark", strings = {
            "You try to defend yourself, you open your mouth",
            "to speak but you fail to think of any words. She",
            "puts her hand on your lips and closes them for you.",
            "Seems like you had no choice in this matter."
        }, next = "ee_bad_9", type = "text"
    },
    ee_bad_9 = {
        speaker = "ee", emotion = "dark", strings = {
            "Many like you have come to this cathedral. Wishing for",
            "something greater... Thinking they are someone greater,",
            "but I somehow SOMEHOW... thought you would be different...",
        }, next = "ee_bad_10", type = "text"
    },
    ee_bad_10 = {
        speaker = "ee", emotion = "dark", strings = {
            "I have been watching you, for as long as I have been",
            "unleashed into this world I have been watching you.",
            "This may not even be the first time you have tried this",
            "encounter and maybe then it would have went differently...",
            "but everything blurs together."
        }, next = "ee_bad_11", type = "text"
    },
    ee_bad_11 = {
        speaker = "ee", emotion = "dark", strings = {
            "Im sure you haven't missed the bloodstains across this",
            "cathedral. There used to be people here to clean this place.",
            "For one reason or another all of them are gone now."
        }, next = "ee_bad_12", type = "text"
    },
    ee_bad_12 = {
        speaker = "ee", emotion = "dark", choices = {
            {string = "Ask her about herself.", next = "ee_bad_13"},
            {string = "Interrupt her.", next = "ee_bad_13_alt"}
        }, type = "choice"
    },
    ee_bad_13 = {
        speaker = "Y/N", emotion = "dark", strings = {
            "Well. What even is this place? and why",
            "are you still here if everyone else is gone?"
        }, next = "ee_bad_14", type = "text"
    },
    ee_bad_13_alt = {
        emotion = "dark", strings = {
            "You try to interrupt her..."
        }, next = "ee_bad_13_alt_2", type = "text"
    },
    ee_bad_13_alt_2 = {
        speaker = "ee", emotion = "dark", strings = {
            "BE QUIET."
        }, next = "ee_bad_13_alt_3", type = "text"
    },
    ee_bad_13_alt_3 = {
        speaker = "ee", emotion = "dark", strings = {
            "DO YOU WANT TO BECOME LIKE ALL THOSE WHO",
            "CAME TO THIS CATHEDRAL BEFORE YOU?"
        }, next = "ee_bad_13_alt_4", type = "text"
    },
    ee_bad_13_alt_4 = {
        emotion = "dark", strings = {
            "You sink backwards and let her keep speaking."
        }, next = "ee_bad_13_alt_5", type = "text"
    },
    ee_bad_13_alt_5 = {
        emotion = "dark", choices = {
            {string = "Ask her about herself.", next = "ee_bad_13"}
        }, type = "choice"
    },

    ee_bad_14 = {
        speaker = "ee", emotion = "dark", strings = {
            "Many people who once inhabited this cathedral",
            "thought they knew better than me. They are much",
            "like you in that regard."
        }, next = "ee_bad_15", type = "text"
    },
    ee_bad_15 = {
        speaker = "ee", emotion = "dark", strings = {
            "The further I get away from the confines of this",
            "cathedral the weaker I become. I see no reason to",
            "go out searching so I just sit here waiting for",
            "sinners like you to arrive."
        }, next = "ee_bad_16", type = "text"
    },
    ee_bad_16 = {
        speaker = "ee", emotion = "dark", strings = {
            "But for once I've decided to be generous and",
            "not kill you where you stand."
        }, next = "ee_bad_17", type = "text"
    },
    ee_bad_17 = {
        speaker = "ee", emotion = "normal", strings = {
            "So why dont you make yourself useful."
        }, next = "ee_bad_18", type = "text", music = "normal"
    },
    ee_bad_18 = {
        speaker = "ee", emotion = "normal", strings = {
            "And clean up this cathedral in place of those",
            "who were here before you."
        }, next = "ee_bad_19", type = "text"
    },
    ee_bad_19 = {
        speaker = "ee", emotion = "normal", choices = {
            {string = "Clean", next = "ee_bad_20"},
            {string = "Refuse", func = function()end}
        }, type = "choice"
    },
    ee_bad_20 = {
        speaker = "ee", emotion = "blush", strings = {
            "And look how willing you are to do what I",
            "tell you huh. I expected more resistance than that."
        }, next = "ee_bad_21", type = "text"
    },
    ee_bad_21 = {
        emotion = "normal", strings = {
            "She snaps her fingers, a bucket and a sponge appears",
            "infront of you. You better get to work."
        }, next = "ee_bad_22", type = "text", music = "normal"
    },
    ee_bad_22 = {
        emotion = "normal", strings = {
            "You sit there cleaning for about an hour",
            "theres still much to do but you are getting tired"
        }, next = "ee_bad_23", type = "text"
    },
    ee_bad_23 = {
        emotion = "normal", choices = {
            {string = "Keep Going.", next = "ee_bad_to_offering_1"},
            {string = "Give Up.", next = "ee_bad_24"},
        }, type = "choice"
    },

    ee_bad_to_offering_1 = {
        speaker = "ee", emotion = "normal", strings = {
            "Well. You did a pretty good job with that huh?",
            "Good.",
            "Maybe I can forgive you after all.",
            "But if you think I'm done with you then you're mistaken."
        }, next = "ee_bad_to_offering_2", type = "text"
    },
    ee_bad_to_offering_2 = {
        speaker = "ee", emotion = "dark", strings = {
            "It took you a lot of tools to get here didn't it."
        }, next = "ee_bad_to_offering_3", type = "text", music = "evil"
    },
    ee_bad_to_offering_3 = {
        speaker = "ee", emotion = "dark", strings = {
            "I've seen all of your shiny little toys on your journey",
            "to this cathedral... and. I wan't you to choose one",
            "to give up. To prove yourself fully to me."
        }, next = "ee_good_28", type = "text",
    },

    ee_bad_24 = {
        speaker = "ee", emotion = "dark", music = "evil", strings = {
            "Such a pitiful creature...",
            "To think I had hope for you."
        }, next = "ee_bad_25", type = "text"
    },
    ee_bad_25 = {
        speaker = "ee", emotion = "dark", strings = {
            "In the end you are the same as all of the others.",
            "Worthless."
        }, next = "ee_bad_26", type = "text"
    },
    ee_bad_26 = {
        speaker = "ee", emotion = "dark", strings = {
            "Worthless. Worthless. Worthless."
        }, next = "ee_bad_27", type = "text"
    },
    ee_bad_27 = {
        speaker = "ee", emotion = "dark", strings = {
            "You should be dead where you stand with the level of",
            "sloth that you showcase."
        }, next = "ee_bad_28", type = "text"
    },
    ee_bad_28 = {
        speaker = "ee", emotion = "dark", strings = {
            "And yet... here you stand.",
            "You insolent wretched creature."
        }, next = "ee_bad_29", type = "text"
    },
    ee_bad_29 = {
        speaker = "ee", emotion = "dark", strings = {
            "Disgusting Heretic."
        }, next = "ee_bad_30", type = "text"
    },
    ee_bad_30 = {
        emotion = "dark", strings = {
            "She gets closer to you. You try",
            "to back away but the doors to the",
            "cathedral have vanished. The room",
            "feels small."
        }, next = "ee_bad_31", type = "text"
    },
    ee_bad_31 = {
        speaker = "ee", emotion = "dark", strings = {
            "Let me show you...",
            "Let me show you where this attitude gets you."
        }, next = "ee_bad_32", type = "text"
    },
    ee_bad_32 = {
        speaker = "ee", emotion = "dark", strings = {
            "Suddenly, a searing pain...",
            "She-"
        }, func = function()
            Entropy.clean_up_dating_sim()
            G.STATE = G.STATES.GAME_OVER
            G.STATE_COMPLETE = false 
            play_sound("entr_snd_ominous")
        end, type = "text"
    },
}
Entropy.orig_dialog = copy_table(Entropy.ee_dialog)

function Entropy.get_speaker_colour(speaker)
    if speaker == "ee" or speaker == "???" then return {1,0,0,1} end
    return G.C.ORANGE
end

function Entropy.get_speaker(speaker)
    if G.PROFILES[G.SETTINGS.profile] and speaker == "ee" and ({
        nxkoo_ = true, nxkoo = true, nxkoozie = true, imadetangentsbtw = true, greetingsfemalesofbalatro = true
    })[string.lower(G.PROFILES[G.SETTINGS.profile].name)] then
        return "Ruby Crimsonfang"
    end
    return speaker == "ee" and "Endless Entropy" or speaker
end

function Entropy.clean_up_dating_sim()
    if G.ENTR_DATING_CANVAS then    
        G.ENTR_DATING_CANVAS:remove()
    end
    G.ENTR_DATING_CANVAS = nil
    G.GAME.entr_dating_start = nil
    G.SETTINGS.paused = nil
    G.GAME.entr_dialog_height = nil
    G.GAME.entr_dialog_height_target = nil
    G.GAME.entr_current_dialog = nil
    G.GAME.entr_dialog_string = nil
    G.GAME.entr_dialog_char_ind = nil
    G.GAME.entr_dialog_string_ind = nil
    G.GAME.entr_text_speed = nil
end
local dialog_inc = 0
local bump_dir = 0
function Entropy.setup_dating_sim(key)
    G.ENTR_DATING_CANVAS = SMODS.CanvasSprite(
        {X=0, Y=0, W=1440, H=1080, canvasW=1440, canvasH=1080, canvasScale=1}
    )
    G.GAME.entr_dating_start = true
    G.SETTINGS.paused = true
    G.GAME.entr_dialog_height = -300
    G.GAME.entr_dialog_height_target = 0
    G.GAME.entr_current_dialog = key or "ee_intro_1"
    G.GAME.entr_dialog_string = ""
    G.GAME.entr_dialog_char_ind = 1
    G.GAME.entr_dialog_string_ind = 1
    G.GAME.entr_text_speed = 0.05
    G.GAME.entr_portrait_offset = {
        x = -480, y = 0
    }

    Entropy.ee_images = {

    }
    for i, v in pairs({
        "normal",
        "dark",
        "dismissive",
        "frown",
        "blush",
        "shocked",
        "embarrased",
        "blush_heavy"
    }) do
        local pref = Entropy.get_speaker("ee") == "Ruby Crimsonfang" and "ruby_" or "ee_"
        local data = NFS.newFileData(Entropy.path .."/assets/emotions/"..pref..v..".png")
        if data then
            local sprite = love.graphics.newImage(data)
            Entropy.ee_images[v] = sprite
        end
    end
    Entropy.ee_dialog = copy_table(Entropy.orig_dialog)
    if Entropy.get_speaker("ee") == "Ruby Crimsonfang" then
        for i, v in pairs(Entropy.ee_dialog) do
            if v.speaker == "ee" or v.speaker == "???" then
                if v.strings then
                    for i, s in pairs(v.strings) do
                        v.strings[i] = string.lower(s):gsub("%.", ""):gsub("%,", ""):gsub("endless entropy", "Ruby Crimsonfang")
                    end
                end
            end
            if v.strings then
                for i, s in pairs(v.strings) do
                    v.strings[i] = s:gsub("Endless Entropy", "Ruby Crimsonfang")
                end
            end
        end
    end
    bump_dir = 0
end

function Entropy.update_dating(dt)
    local p = math.min(8 * dt, 1)
    G.GAME.entr_dialog_height = G.GAME.entr_dialog_height * (1-p) + G.GAME.entr_dialog_height_target * p
    dialog_inc = dialog_inc + dt
    if love.mouse.isDown(1) or love.keyboard.isDown("lshift") then
        G.GAME.entr_text_speed = 0.01
    else
        G.GAME.entr_text_speed = 0.05
    end
    if dialog_inc > G.GAME.entr_text_speed and Entropy.ee_dialog[G.GAME.entr_current_dialog].type == "text" then
        local str = Entropy.ee_dialog[G.GAME.entr_current_dialog].strings[G.GAME.entr_dialog_string_ind]
        if str and string.len(str) >= G.GAME.entr_dialog_char_ind then
            local char = string.sub(str, G.GAME.entr_dialog_char_ind, G.GAME.entr_dialog_char_ind)
            G.GAME.entr_dialog_string = G.GAME.entr_dialog_string..char
            G.GAME.entr_dialog_char_ind = G.GAME.entr_dialog_char_ind + 1
        elseif str then
            G.GAME.entr_dialog_string = G.GAME.entr_dialog_string.."\n"
            G.GAME.entr_dialog_string_ind = G.GAME.entr_dialog_string_ind + 1
            G.GAME.entr_dialog_char_ind = 1
        end
        dialog_inc = 0
    end
    if Entropy.ee_dialog[G.GAME.entr_current_dialog].type == "choice" then
        local last = G.GAME.entr_hovered_choice
        G.GAME.entr_hovered_choice = nil
        local mx = love.mouse.getX()
        local my = love.mouse.getY()
        local scale = math.min(love.graphics.getWidth() / 1440, love.graphics.getHeight() / 1080)
        local xoffset = 1440 * scale - love.graphics.getWidth()
        local yoffset = 1080 * scale - love.graphics.getHeight()
        for i, v in pairs(Entropy.ee_dialog[G.GAME.entr_current_dialog].choices) do
            local x = 20
            local y = 1080+(-270 - G.GAME.entr_dialog_height + 260 + 60 * (i-1))
            local width = 1440 - 40
            local height = 50

            x = x * scale
            y = y * scale
            width = width * scale
            height = height * scale

            x = x - xoffset / 2
            y = y - yoffset / 2

            if mx >= x and mx <= x + width and my >= y and my <= y + height then
                if last ~= i then
                    play_sound("card1")
                end
                G.GAME.entr_hovered_choice = i
            end
        end

    end
    if Entropy.ee_dialog[G.GAME.entr_current_dialog].emotion then 
        G.GAME.entr_portrait_offset.x = G.GAME.entr_portrait_offset.x*(1-p) + 0*p
        if G.GAME.entr_last_emotion ~= Entropy.ee_dialog[G.GAME.entr_current_dialog].emotion then
            if bump_dir == 0 then
                G.GAME.entr_portrait_offset.y = G.GAME.entr_portrait_offset.y*(1-p) + 150*p
                if G.GAME.entr_portrait_offset.y > 20 then
                    bump_dir = 1
                end
            else
                G.GAME.entr_portrait_offset.y = G.GAME.entr_portrait_offset.y*(1-p)
            end
        else
            G.GAME.entr_portrait_offset.y = G.GAME.entr_portrait_offset.y*(1-p)
        end
    else
        G.GAME.entr_portrait_offset.x = G.GAME.entr_portrait_offset.x*(1-p) + -480*p
    end
end

function Entropy.process_dating_vars(v)
    local vars = v.loc_vars and v:loc_vars() or {}
    if v.strings then
        for i, s in pairs(v.strings) do
            for _i, av in pairs(vars or {}) do
                v.strings[i] = v.strings[i]:gsub("#".._i.."#", av)
            end
        end
    end
    if v.choices then
        for i, av in pairs(vars or {}) do
            for _i, s in pairs(v.choices) do
                v.choices[i].string = v.choices[i].string:gsub("#".._i.."#", av)
            end
        end
    end
end

local mousepressed = love.mousepressed
function love.mousepressed(x, y, button, istouch)
    mousepressed(x, y, button, istouch)
    if G.GAME.entr_dating_start then
        if Entropy.ee_dialog[G.GAME.entr_current_dialog].type == "text" and not Entropy.ee_dialog[G.GAME.entr_current_dialog].strings[G.GAME.entr_dialog_string_ind] then
            if Entropy.ee_dialog[G.GAME.entr_current_dialog].func then
                Entropy.ee_dialog[G.GAME.entr_current_dialog].func()
            else
                G.GAME.entr_last_emotion = Entropy.ee_dialog[G.GAME.entr_current_dialog].emotion
                G.GAME.entr_current_dialog = Entropy.ee_dialog[G.GAME.entr_current_dialog].next

                Entropy.process_dating_vars(Entropy.ee_dialog[G.GAME.entr_current_dialog])
                
                bump_dir = 0
                if Entropy.ee_dialog[G.GAME.entr_current_dialog].type == "text" then
                    G.GAME.entr_dialog_string = ""
                    G.GAME.entr_dialog_char_ind = 1
                    G.GAME.entr_dialog_string_ind = 1
                end
                if Entropy.ee_dialog[G.GAME.entr_current_dialog].music then
                    G.GAME.entr_dating_start_music = Entropy.ee_dialog[G.GAME.entr_current_dialog].music == "normal"
                    G.GAME.entr_dating_start_music_evil = Entropy.ee_dialog[G.GAME.entr_current_dialog].music == "evil"
                end
                if Entropy.ee_dialog[G.GAME.entr_current_dialog].sound then
                    play_sound(Entropy.ee_dialog[G.GAME.entr_current_dialog].sound)
                end
            end
        end
        if G.GAME.entr_hovered_choice then  
            play_sound("tarot1")
            if Entropy.ee_dialog[G.GAME.entr_current_dialog].choices[G.GAME.entr_hovered_choice].func then
                Entropy.ee_dialog[G.GAME.entr_current_dialog].choices[G.GAME.entr_hovered_choice].func()
            else
                G.GAME.entr_last_emotion = Entropy.ee_dialog[G.GAME.entr_current_dialog].emotion
                G.GAME.entr_current_dialog = Entropy.ee_dialog[G.GAME.entr_current_dialog].choices[G.GAME.entr_hovered_choice].next

                Entropy.process_dating_vars(Entropy.ee_dialog[G.GAME.entr_current_dialog])

                G.GAME.entr_hovered_choice = nil
                bump_dir = 0
                if Entropy.ee_dialog[G.GAME.entr_current_dialog].type == "text" then
                    G.GAME.entr_dialog_string = ""
                    G.GAME.entr_dialog_char_ind = 1
                    G.GAME.entr_dialog_string_ind = 1
                end
                if Entropy.ee_dialog[G.GAME.entr_current_dialog].music then
                    G.GAME.entr_dating_start_music = Entropy.ee_dialog[G.GAME.entr_current_dialog].music == "normal"
                    G.GAME.entr_dating_start_music_evil = Entropy.ee_dialog[G.GAME.entr_current_dialog].music == "evil"
                end
                if Entropy.ee_dialog[G.GAME.entr_current_dialog].sound then
                    play_sound(Entropy.ee_dialog[G.GAME.entr_current_dialog].sound)
                end
            end
        end
    end
end

local update = love.update
function love.update(dt)
    update(dt)
    if G.GAME.entr_dating_start then
        Entropy.update_dating(dt)
    end
end

local scp = G.CONTROLLER.set_cursor_position
function G.CONTROLLER:set_cursor_position(...)
    scp(self, ...)
    if G.GAME.entr_dating_start then
        G.CURSOR.T.x = 99999
        G.CURSOR.T.y = 99999
        G.CURSOR.VT.x = G.CURSOR.T.x
        G.CURSOR.VT.y = G.CURSOR.T.y
    end
end

local adata = NFS.newFileData(Entropy.path .."/assets/eearrow.png")
local arrow_sprite = love.graphics.newImage(adata)

function Entropy.draw_dating()
    love.graphics.clear({0,0,0,1})
    G.ENTR_DATING_CANVAS = G.ENTR_DATING_CANVAS or SMODS.CanvasSprite(
        {X=0, Y=0, W=1440, H=1080, canvasW=1440, canvasH=1080, canvasScale=1}
    )
    G.ENTR_DATING_CANVAS.canvas:renderTo(function()
        love.graphics.clear({0,0,0,1})
        --ratio clamped to 1 : 0.75
        local height = 1080
        local width = height / 0.75
        local offset = 1440/2 - width / 2 
        love.graphics.translate(offset, 0)
        --render swirl
        love.graphics.setShader(G.SHADERS.entr_entropic_vortex)
        for i, v in pairs({
            {name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
            {name = 'fade_in', ref_table = {EE_FADE = 10}, ref_value = "EE_FADE"},
            {name = 'flame_height', ref_table = {EE_FLAMES = 0.2}, ref_value = "EE_FLAMES"},
        }) do
            G.SHADERS.entr_entropic_vortex:send(v.name, v.ref_table[v.ref_value])
        end
        love.graphics.rectangle("fill", 0, 0, width, height)
        love.graphics.setShader()

        Entropy.render9slice(20, height-270 - G.GAME.entr_dialog_height, width - 40, 250)

        love.graphics.setColor(Entropy.get_speaker_colour(Entropy.ee_dialog[G.GAME.entr_current_dialog].speaker))
        if Entropy.ee_dialog[G.GAME.entr_current_dialog].speaker then
            love.graphics.print(Entropy.get_speaker(Entropy.ee_dialog[G.GAME.entr_current_dialog].speaker),
                40, height-270 - G.GAME.entr_dialog_height + 10, 0, 2, 2, 0, 0)
            love.graphics.setColor(G.C.WHITE)
            love.graphics.print(G.GAME.entr_dialog_string, 80, height-270 - G.GAME.entr_dialog_height + 55, 0, 1.5, 1.5, 0, 0)
            love.graphics.print("*", 60, height-270 - G.GAME.entr_dialog_height + 55, 0, 1.5, 1.5, 0, 0)
        else
            love.graphics.setColor(G.C.WHITE)
            love.graphics.print(G.GAME.entr_dialog_string, 80, height-270 - G.GAME.entr_dialog_height + 10, 0, 1.5, 1.5, 0, 0)
            love.graphics.print("*", 60, height-270 - G.GAME.entr_dialog_height + 10, 0, 1.5, 1.5, 0, 0)
        end

        if Entropy.ee_dialog[G.GAME.entr_current_dialog].type == "text" then
            G.GAME.entr_dialog_height_target = 0
            if not Entropy.ee_dialog[G.GAME.entr_current_dialog].strings[G.GAME.entr_dialog_string_ind] then
                love.graphics.draw(arrow_sprite, width - 30 * 2.5 - 25, height - 20 * 2.5 - 30 + math.sin(G.TIMERS.REAL)*5, 0, 2.5, 2.5, 0, 0)
            end
        else
            -- render choice box here
            G.GAME.entr_dialog_height_target = 60 * #Entropy.ee_dialog[G.GAME.entr_current_dialog].choices
            for i, v in pairs(Entropy.ee_dialog[G.GAME.entr_current_dialog].choices) do
                love.graphics.setColor(G.C.WHITE)
                Entropy.render9slice(20, height-270 - G.GAME.entr_dialog_height + 260 + 60 * (i-1), width - 40, 50)
                if G.GAME.entr_hovered_choice == i then
                    love.graphics.setColor(G.C.ORANGE)
                end
                love.graphics.print("* "..v.string, 40, height-270 - G.GAME.entr_dialog_height + 260 + 60 * (i-1) + 7.5, 0, 1.5, 1.5, 0, 0)
            end
        end

        if Entropy.ee_dialog[G.GAME.entr_current_dialog].emotion then
            love.graphics.setColor(G.C.WHITE)
            local image = Entropy.ee_images[Entropy.ee_dialog[G.GAME.entr_current_dialog].emotion]
            love.graphics.draw(image, 20 + G.GAME.entr_portrait_offset.x, height - 270 - G.GAME.entr_dialog_height - 480 - G.GAME.entr_portrait_offset.y, 0, 1, 1, 0, 0)
        end

        love.graphics.translate(-offset, 0)
    end)
    local scale = math.min(love.graphics.getWidth() / 1440, love.graphics.getHeight() / 1080)
    love.graphics.draw(G.ENTR_DATING_CANVAS.canvas, love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, scale, scale, 1440/2, 1080/2)
end

local data = NFS.newFileData(Entropy.path .."/assets/ee9slice.png")
local sprite = love.graphics.newImage(data)
function Entropy.render9slice(x, y, w, h)
    --top
    local hfac = 1
    if h < 100 then
        hfac = 0.8
    end
    love.graphics.draw(sprite, love.graphics.newQuad(0, 0, 7, 7, 25, 25), x, y, 0, 2, 2, 0, 0)
    love.graphics.draw(sprite, love.graphics.newQuad(9, 0, 9, 7, 25, 25), x+14, y, 0, 1.1*(w+10)/9, 2, 0, 0)
    love.graphics.draw(sprite, love.graphics.newQuad(19, 0, 7, 7, 25, 25), x+w-14, y, 0, 2, 2, 0, 0)
    --middle
    love.graphics.draw(sprite, love.graphics.newQuad(0, 9, 7, 9, 25, 25), x, y+14, 0, 2, hfac*(h)/9, 0, 0)
    love.graphics.draw(sprite, love.graphics.newQuad(9, 9, 9, 9, 25, 25), x+14, y+14, 0, 1.1*(w+10)/9,hfac*(h)/9, 0, 0)
    love.graphics.draw(sprite, love.graphics.newQuad(19, 9, 7, 9, 25, 25), x+w-14, y+14, 0, 2, hfac*(h)/9, 0, 0)
    --bottom
    love.graphics.draw(sprite, love.graphics.newQuad(0, 19, 7, 7, 25, 25), x, y+h-14, 0, 2, 2, 0, 0)
    love.graphics.draw(sprite, love.graphics.newQuad(9, 19, 9, 7, 25, 25), x+14, y+h-14, 0, 1.1*(w+10)/9, 2, 0, 0)
    love.graphics.draw(sprite, love.graphics.newQuad(19, 19, 7, 7, 25, 25), x+w-14, y+h-14, 0, 2, 2, 0, 0)
end


--cultist
Entropy.Blind{
    dependencies = {
        items = {
        "set_entr_blinds"
        }
    },
    order = 6665,
    key = "entropic_cultist",
    pos = { x = 0, y = 6 },
    atlas = "blinds",
    boss_colour = HEX("FF0000"),
    mult=6,
    dollars = 0,
    boss = {
        min = 16,
        max = 16,
    },
    no_token = true,
    no_disable=true,
    in_pool = function() return false end,
    setting_blind = function()
        G.GAME.entropic_cultist_blinds = G.GAME.entropic_cultist_blinds or {
            get_new_boss(),
            get_new_boss(),
            get_new_boss(),
        }
    end,
    loc_vars = function()
        if not G.SETTINGS.paused then
            G.GAME.entropic_cultist_blinds = G.GAME.entropic_cultist_blinds or {
                get_new_boss(),
                get_new_boss(),
                get_new_boss(),
            }
        end
    end,
    get_copied_blinds = function()
        return G.GAME.entropic_cultist_blinds
    end,
    defeat = function()
        G.GAME.entropic_cultist_blinds = {}
    end
}

--add fakeout blinds
for i, v in pairs({
    "endless_entropy_phase_one",
    "ee_church",
    "ee_puppet",
    "ee_erebus",
    "ee_decay",
    "ee_extinction",
    "ee_nadir",
    "ee_euphoria",
    "ee_fracture",
    "ee_feast",
    "ee_cleave",
    "ee_desperation"
}) do
    Entropy.Blind{
        dependencies = {
            items = {
            "set_entr_blinds"
            }
        },
        no_token = true,
        order = 6666+i,
        key = v,
        pos = { x = 0, y = i-1 },
        atlas = "eev4fucksmanybitches",
        boss_colour = HEX("FF0000"),
        mult=6,
        dollars = 8,
        boss = {
            min = 32,
            max = 32,
        },
        no_disable=true,
        in_pool = function() return false end,
        set_blind = function()
            Entropy.setup_dating_sim()
        end
    }
end

--TODO: add later
SMODS.Sound({
	key = "music_endless_entropy_is_verysexy",
	path = "music_endless_entropy_is_verysexy.ogg",
	select_music_track = function()
		return G.GAME.entr_dating_start_music and 10^306
	end,
})

SMODS.Sound({
	key = "music_endless_entropy_is_verymean",
	path = "music_endless_entropy_is_verymean.ogg",
	select_music_track = function()
		return G.GAME.entr_dating_start_music_evil and 10^307
	end,
})

SMODS.Sound{
    key = "eev4_shocked",
    path = "eev4_shocked.ogg",
    volume = 2
}

SMODS.ScreenShader({
    key="redvignette",
    path="redvignette.fs",
    send_vars = function (sprite, card)
        return {
            power = G.GAME.entr_red_vignette_power,
            realtime = G.TIMERS.REAL
        }
    end,
    should_apply = function()
        return G.GAME.entr_red_vignette_power
    end
})

SMODS.Sound{
    key = "stab_1", path = "stab_1.ogg" , volume = 2.5
}
SMODS.Sound{
    key = "stab_2", path = "stab_2.ogg" , volume = 2.5
}
SMODS.Sound{
    key = "stab_3", path = "stab_3.ogg" , volume = 2.5
}
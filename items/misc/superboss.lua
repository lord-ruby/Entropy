SMODS.Shader({
    key="entropic_vortex",
    path="splash.fs"
})

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
    return true
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
    G.GAME.round_resets.blind_choices.Boss = "bl_entr_brimstone"
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
    --G.EE_DOOR_SPRITE = SMODS.create_sprite(0, 0, 6, 6, "entr_intro_door")
    local t = {n=G.UIT.ROOT, config = {align = 'tm',r = 0.15, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0.5}, nodes={
        {n=G.UIT.O, config={align = "cm", object = 
            UIBox{definition = {n=G.UIT.ROOT, config={
                align = "cm", colour = G.C.CLEAR}, 
                nodes={
                    UIBox_dyn_container({create_UIBox_blind_choice_ee()},false,G.C.CLEAR, G.C.CLEAR)}}, 
                    config = {align="bmi", offset = {x=0,y=0}}} or nil
        }} or nil}}
    }}
    return t 
end

function _G.create_UIBox_blind_choice_ee()
  G.EE_DOOR_SPRITE = SMODS.create_sprite(0,0, 6, 6, "entr_intro_door")

  G.EE_DOOR_SPRITE:define_draw_steps({
    {shader = 'dissolve', shadow_height = 0.05},
    {shader = 'dissolve'}
  })
  local t = 
  {n=G.UIT.R, config={id = type, align = "tm", minh = 6, ref_table = {}, r = 0.1, padding = 0.05}, nodes={
    {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR, r = 0.1, outline = 1, outline_colour = G.C.CLEAR}, nodes={  
      {n=G.UIT.R, config={align = "cm", padding = 0.2}, nodes={}},
        {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
          {n=G.UIT.R, config={id = 'blind_desc', align = "cm", padding = 0.05}, nodes={
            {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.R, config={align = "cm", minh = 1.8}},
              {n=G.UIT.R, config={align = "cm", minh = 1.5, button = "enter_ee", func = "can_enter_ee"}, nodes={
                {n=G.UIT.O, config={object = G.EE_DOOR_SPRITE}},
              }},
            }},
          }},
        }},
      }},

    }}
  return t
end

local unblind_void_ref = UnBlind_create_UIBox_blind
function UnBlind_create_UIBox_blind(type)
    if Entropy.can_ee_spawn() then
        if to_big(G.GAME.round_resets.ante) < to_big(32) then G.GAME.EEBeaten = false end
        if Entropy.is_ee_or_buildup() then
            G.GAME.round_resets.blind_choices.Boss = "bl_entr_brimstone"
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
        return G.GAME.EEBuildup or Entropy.is_EE() or (G.GAME.EE_FADE or 0) > 0
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
    if G.GAME.blind.config.blind.defeat then
        G.GAME.blind.config.blind:defeat(G.GAME.blind)
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

--cultist
Entropy.Blind{
    dependencies = {
        items = {
        "set_entr_blinds"
        }
    },
    order = 6666-13,
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

function G.FUNCS.can_enter_ee(e)
    e.config.colour = G.C.CLEAR
    e.config.button = 'enter_ee'
end
function G.FUNCS.enter_ee(e)
    stop_use()
    G.EE_DOOR_SPRITE:remove()
    G.EE_DOOR_SPRITE = SMODS.create_sprite(0, 0, 6, 6, "entr_intro_door_anim")
    if G.blind_select then 
        G.E_MANAGER:add_event(Event{
            trigger = "after",
            delay = 1.99,
            timer = "REAL",
            func = function()
                if G.EE_DOOR_SPRITE then
                    G.EE_DOOR_SPRITE:remove()
                    G.EE_DOOR_SPRITE = nil
                end
                G.GAME.facing_blind = true
                G.E_MANAGER:add_event(Event({
                trigger = 'before', delay = 0.2,
                func = function()
                    G.blind_select.alignment.offset.y = 40
                    G.blind_select.alignment.offset.x = 0
                    return true
                end}))
                G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    ease_round(1)
                    inc_career_stat('c_rounds', 1)
                    if _DEMO then
                    G.SETTINGS.DEMO_ROUNDS = (G.SETTINGS.DEMO_ROUNDS or 0) + 1
                    inc_steam_stat('demo_rounds')
                    G:save_settings()
                    end
                    G.GAME.blind_on_deck = "Boss"
                    local _tag = e.UIBox:get_UIE_by_ID('tag_container')
                    G.GAME.round_resets.blind_tag = _tag and _tag.config and _tag.config.ref_table or nil
                    G.GAME.round_resets.blind = e.config.ref_table
                    G.GAME.round_resets.blind_states["Boss"] = 'Current'
                    G.blind_select:remove()
                    G.blind_select = nil
                    delay(0.2)
                    return true
                end}))
                G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    new_round()
                    return true
                end
                }))
                G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            G.GAME.blind:set_blind(G.P_BLINDS.bl_entr_brimstone)
                            return true
                        end
                    }))
                    return true
                end
                }))
                return true
            end
        })
    end
end

function Entropy.get_unscored_text()
    if G.GAME.puppet_hands then
        return localize('ph_hand_notcorrect')
    end
    return G.bad_arg and localize('ph_hand_notreal') or localize('ph_unscored_hand')
end

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
    order = 6666-12,
	key = "brimstone",
	pos = { x = 0, y = 0 },
	atlas = "ee_blinds",
	boss_colour = HEX("FF0000"),
    mult=3,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true, no_token = true,
    next_phase = "bl_entr_church",
	in_pool = function() return false end,
	set_blind = function()
        if G.GAME.modifiers.entr_gfb then
            Entropy.setup_dating_sim()
        end
	end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
    order = 6666-11,
	key = "ekklisia",
	pos = { x = 0, y = 1 },
	atlas = "ee_blinds",
	boss_colour = HEX("FF0000"),
    mult=3,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true, no_token = true,
    next_phase = "bl_entr_puppet",
	in_pool = function() return false end,
	get_copied_blinds = function()
        return {
            "bl_final_leaf",
            "bl_entr_choir",
            "bl_entr_alabaster_anchor"
        }
    end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
    order = 6666-10,
	key = "puppet",
	pos = { x = 0, y = 2 },
	atlas = "ee_blinds",
	boss_colour = HEX("FF0000"),
    mult=3,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true, no_token = true,
    next_phase = "bl_entr_erebus",
    prevent_score_change = function()
        for i, v in pairs(G.GAME.puppet_hands or {}) do
            return true
        end
    end,
	in_pool = function() return false end,
    set_blind = function()
        local hands = {}
        for i, v in pairs(G.GAME.hands) do
            if v.visible then hands[#hands+1] = v end
        end
        pseudoshuffle(hands, pseudoseed("entr_puppet_hands"))
        if not G.GAME.puppet_hands then
            G.GAME.puppet_hands = G.GAME.puppet_hands or {}
            G.GAME.blind.effect.full_puppet = G.GAME.blind.effect.full_puppet or {}
            for i = 1, 3 do
                G.GAME.puppet_hands[i] = hands[i].key
                G.GAME.blind.effect.full_puppet[i] = hands[i].key
            end
        end
    end,
    calculate = function(self, blind, context)
        if context.after then
            local hand = context.scoring_name
            for i, v in pairs(G.GAME.puppet_hands or {}) do
                if v == hand then 
                    G.GAME.puppet_hands[i] = nil 
                    play_sound("gong")
                end
            end
        end
    end,
    collection_loc_vars = function()
        return {
            vars = {
                "[Random Poker Hand]",
                "[Random Poker Hand]",
                "[Random Poker Hand]"
            }
        }
    end,
    loc_vars = function()
        local hands = {}
        for i, v in pairs(G.GAME.hands) do
            if v.visible then hands[#hands+1] = v end
        end
        pseudoshuffle(hands, pseudoseed("entr_puppet_hands"))
        if not G.GAME.puppet_hands then
            G.GAME.puppet_hands = G.GAME.puppet_hands or {}
            G.GAME.blind.effect.full_puppet = G.GAME.blind.effect.full_puppet or {}
            for i = 1, 3 do
                G.GAME.puppet_hands[i] = hands[i].key
                G.GAME.blind.effect.full_puppet[i] = hands[i].key
            end
        end
        return {
            vars = {
                localize(G.GAME.blind.effect.full_puppet[1], "poker_hands"),
                localize(G.GAME.blind.effect.full_puppet[2], "poker_hands"),
                localize(G.GAME.blind.effect.full_puppet[3], "poker_hands")
            }
        }
    end,
    defeat = function()
        G.GAME.puppet_hands = nil
    end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
    order = 6666-9,
	key = "erebus",
	pos = { x = 0, y = 3 },
	atlas = "ee_blinds",
	boss_colour = HEX("FF0000"),
    mult=3,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true, no_token = true,
    next_phase = "bl_entr_decay",
	in_pool = function() return false end,
	get_copied_blinds = function()
        return {
            "bl_final_acorn",
            "bl_entr_styx",
            "bl_entr_diamond_dawn"
        }
    end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
    order = 6666-8,
	key = "decay",
	pos = { x = 0, y = 4 },
	atlas = "ee_blinds",
	boss_colour = HEX("FF0000"),
    mult=3,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true, no_token = true,
    next_phase = "bl_entr_extinction",
	in_pool = function() return false end,
	set_blind = function()
        G.GAME.EE_JOKERS = G.jokers:save()
		G.GAME.EE_HANDS = copy_table(G.GAME.hands)
		for i, v in pairs(G.GAME.hands) do
			v.mult = v.s_mult
			v.chips = v.s_chips
			v.level = 1
			G.GAME.hands[i] = v
		end
		G.E_MANAGER:add_event(Event{
			func = function()
				for i, v in pairs(G.jokers.cards) do
					local c = v
					G.E_MANAGER:add_event(Event{
						trigger = "after",
						delay = 0.15 * G.SETTINGS.GAMESPEED,	
						func = function()
							c:juice_up()
							c.debuff = true
							play_sound("multhit1")
							return true
						end
					})
				end
				G.E_MANAGER:add_event(Event{
					trigger = "after",
					delay = 0.4 * G.SETTINGS.GAMESPEED,
					func = function()
						for i, v in pairs(G.jokers.cards) do
							v:start_dissolve()
						end
						play_sound("glass6")
						return true
					end
				})
				G.E_MANAGER:add_event(Event{
					trigger = "after",
					func = function()
						save_run()
						return true
					end
				})
				return true
			end
		})
        G.GAME.blind.chips = 10000
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		G.HUD_blind:recalculate()
    end,
    defeat = function()
        G.jokers:load(G.GAME.EE_JOKERS)
        G.GAME.hands = copy_table(G.GAME.EE_HANDS)
        G.GAME.EE_HANDS = nil
        G.GAME.EE_JOKERS = nil
    end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
    order = 6666-7,
	key = "extinction",
	pos = { x = 0, y = 5 },
	atlas = "ee_blinds",
	boss_colour = HEX("FF0000"),
    mult=3,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true, no_token = true,
    next_phase = "bl_entr_nadir",
	in_pool = function() return false end,
	get_copied_blinds = function()
        return {
            "bl_final_bell",
            "bl_entr_labyrinth",
            "bl_entr_citrine_comet"
        }
    end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
    order = 6666-6,
	key = "nadir",
	pos = { x = 0, y = 6 },
	atlas = "ee_blinds",
	boss_colour = HEX("FF0000"),
    mult=3,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true, no_token = true,
    next_phase = "bl_entr_euphoria",
	in_pool = function() return false end,
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
    order = 6666-5,
	key = "euphoria",
	pos = { x = 0, y = 7 },
	atlas = "ee_blinds",
	boss_colour = HEX("FF0000"),
    mult=12,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true, no_token = true,
    next_phase = "bl_entr_fracture",
	in_pool = function() return false end,
	get_copied_blinds = function()
        return {
            "bl_entr_pandora",
            "bl_entr_olive_orchard"
        }
    end
}

--debuffs
-- 1. Rot - Your Rightmost Joker is debuffed
-- 2. Famine - Remove all discards and all but one hand
-- 3. Hellfire - One half of all cards held in hand and scored are debuffed
Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
    order = 6666-4,
	key = "fracture",
	pos = { x = 0, y = 8 },
	atlas = "ee_blinds",
	boss_colour = HEX("FF0000"),
    mult=3,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true, no_token = true,
    next_phase = "bl_entr_feast",
	in_pool = function() return false end,
    setting_blind = function()
        G.C.EE_DIM_COL = darken(G.C.BLACK, 0.75)
        G.C.EE_DIM_COL[4] = 0
        G.E_MANAGER:add_event(Event({
            trigger = 'ease',
            ref_table = G.C.EE_DIM_COL,
            ref_value = 4,
            ease_to = 0.9,
            delay = 1,
            timer = "REAL",
            func = (function(t) return t end),
            blockable = false,
            blocking = false,
        }), "other")
        G.FUNCS.overlay_menu({definition = create_UIBox_ee_fracture()})
        G.E_MANAGER:add_event(Event{
            func = function()
                local c = SMODS.add_card{key = "j_entr_hellfire", area = G.fracture_area}
                c.config.h_popup_dir = "bm"
                c.ability.use_on_click_ee = true

                c = SMODS.add_card{key = "j_entr_rot", area = G.fracture_area}
                c.config.h_popup_dir = "bm"
                c.ability.use_on_click_ee = true

                c = SMODS.add_card{key = "j_entr_famine", area = G.fracture_area}
                c.config.h_popup_dir = "bm"
                c.ability.use_on_click_ee = true
                return true
            end
        })
    end
}

function _G.create_UIBox_ree_fracture()
	return {
		n = G.UIT.O,
		config = { object = UIBox{
			definition = create_UIBox_ee_fracture_content(),
			config = { offset = {x=0, y=0}, align = 'cm' }
		}, id = 'soul_asc', align = 'cm' },
	}
end
function _G.create_UIBox_ee_fracture()
    G.fracture_area =CardArea(
        0, 0,
        5.3*G.CARD_W,0.95*G.CARD_H, 
        {card_limit = 5, type = 'play', negative_info = 'playing_card'})
    local t = create_UIBox_generic_options({
        no_back = true,
        colour = {0,0,0,0},
        outline_colour = {0,0,0,0},
        bg_colour = G.C.EE_DIM_COL;
        contents = {
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cm" },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = localize("k_ee_fracture_select"),
                                    colour = G.C.UI.TEXT_LIGHT,
                                    scale = 0.8,
                                },
                            },
                            {n=G.UIT.O, config = {object = G.fracture_area}},
                        },
                    },
                },
            },
        },
    })
    return t
end

local card_click = Card.click
function Card:click(...)
    if self.ability.use_on_click_ee then
        G.E_MANAGER:add_event(Event{
            trigger = "after",
            func = function()
                self.config.center:ee_debuff(self)
                return true
            end
        })
        G.E_MANAGER:add_event(Event{
            trigger = "after",
            delay = 2,
            blocking = false, blockable = false,
            func = function()
                for i, v in pairs(G.fracture_area.cards) do
                    v:start_dissolve()
                end
                return true
            end
        })
        G.E_MANAGER:add_event(Event({
            trigger = 'ease',
            ref_table = G.C.EE_DIM_COL,
            ref_value = 4,
            ease_to = 0,
            delay = 1,
            timer = "REAL",
            func = (function(t) return t end),
            blockable = false,
            blocking = false,
        }), "other")
        G.E_MANAGER:add_event(Event{
            trigger = "after",
            delay = 1.1,
            timer = "REAL",
            blocking = false, blockable = false,
            func = function()
                G.FUNCS.exit_overlay_menu()
                G.fracture_area:remove()
                G.fracture_area = nil
                return true
            end
        })
    else    
        card_click(self, ...)
    end
end

SMODS.Joker {
    no_collection = true,
    pos = {x = 0, y = 19},
    atlas = "jokers",
    in_pool = function() return false end,
    rarity = "entr_entropic",
    cost = 0,
    key = "hellfire",
    ee_debuff = function() G.GAME.ee_hellfire_debuff = true end
}

SMODS.Joker {
    no_collection = true,
    pos = {x = 1, y = 19},
    atlas = "jokers",
    in_pool = function() return false end,
    rarity = "entr_entropic",
    cost = 0,
    key = "famine",
    ee_debuff = function()
        G.GAME.ee_famine_hands = G.GAME.round_resets.hands
        G.GAME.round_resets.hands = 1
        G.GAME.ee_famine_discards = G.GAME.round_resets.discards
        G.GAME.round_resets.discards = 0
        ease_hands_played(G.GAME.round_resets.hands-G.GAME.current_round.hands_left)
		ease_discard(math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards) - G.GAME.current_round.discards_left)
    end
}

SMODS.Joker {
    no_collection = true,
    pos = {x = 2, y = 19},
    atlas = "jokers",
    in_pool = function() return false end,
    rarity = "entr_entropic",
    cost = 0,
    key = "rot",
    ee_debuff = function() G.GAME.ee_rot_debuff = true end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
    order = 6666-3,
	key = "feast",
	pos = { x = 0, y = 9 },
	atlas = "ee_blinds",
	boss_colour = HEX("FF0000"),
    mult=3,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true, no_token = true,
    next_phase = "bl_entr_cleave",
	in_pool = function() return false end,
	get_copied_blinds = function()
        return {
            "bl_final_heart",
            "bl_entr_barracuda",
            "bl_entr_condemned_cassandra"
        }
    end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
    order = 6666-2,
	key = "cleave",
	pos = { x = 0, y = 10 },
	atlas = "ee_blinds",
	boss_colour = HEX("FF0000"),
    mult=3,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true, no_token = true,
    next_phase = "bl_entr_endless",
	in_pool = function() return false end,
    calculate = function(self, blind, context)
        if context.after then
            SMODS.destroy_cards(G.play.cards)
        end
        if context.pre_discard then
            SMODS.destroy_cards(G.hand.highlighted)
        end
    end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
    order = 6666-1,
	key = "endless",
	pos = { x = 0, y = 11 },
	atlas = "ee_blinds",
	boss_colour = HEX("FF0000"),
    mult=3,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true, no_token = true,
	in_pool = function() return false end,
    defeat = function()
        if G.GAME.ee_famine_hands then
            G.GAME.round_resets.hands = G.GAME.ee_famine_hands
            G.GAME.round_resets.discards = G.GAME.ee_famine_discards
            G.GAME.ee_famine_discards = nil
            G.GAME.ee_famine_hands = nil
        end
        G.GAME.ee_rot_debuff = nil
        G.GAME.ee_hellfire_debuff = nil
    end
}

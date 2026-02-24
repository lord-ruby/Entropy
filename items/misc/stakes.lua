local copper = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	object_type = "Stake",
    order = 1,
    key = "copper",
    pos = { x = 0, y = 0 },
    atlas = "stakes",
    applied_stakes = { "gold" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=0,y=0},
    modifiers = function()
        G.GAME.modifiers.entr_copper = true
    end,
    shiny = true,
    colour = HEX("ff7747")
}

local platinum = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	object_type = "Stake",
    order = 2,
    key = "platinum",
    pos = { x = 1, y = 0 },
    atlas = "stakes",
    applied_stakes = { "entr_copper" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=1,y=0},
    modifiers = function()
        G.GAME.modifiers.entr_platinum = 1.2
    end,
    shiny = true,
    colour = HEX("aebac1")
}

local meteorite = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	object_type = "Stake",
    order = 3,
    key = "meteorite",
    pos = { x = 2, y = 0 },
    atlas = "stakes",
    applied_stakes = { "entr_platinum" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=2,y=0},
    modifiers = function()
        G.GAME.modifiers.entr_meteorite = 0.33
    end,
    shiny = true,
    colour = HEX("983443")
}

local level_up_handref = level_up_hand
function level_up_hand(card, hand, ...)
    if G.GAME.modifiers.entr_meteorite and pseudorandom("entr_platinum_stake") < G.GAME.modifiers.entr_meteorite  then
        if card then
            card_eval_status_text(
                card,
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_nope_ex"), colour = HEX("983443") }
            )
        end
    else
        return level_up_handref(card, hand, ...)
    end
end

local obsidian = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	object_type = "Stake",
    order = 4,
    key = "obsidian",
    pos = { x = 3, y = 0 },
    atlas = "stakes",
    applied_stakes = { "entr_meteorite" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=3,y=0},
    modifiers = function()
        G.GAME.curse_rate_mod = 1
    end,
    colour = HEX("583175"),
    shiny = true,
}

Entropy.curses = {
    ["entr_blind"] = {
        key = "k_curse_blind",
        desc_key = "k_curse_blind_desc",
        sprite_pos = {x = 0, y = 0},
    },
    ["entr_darkness"] = {
        key = "k_curse_darkness",
        desc_key = "k_curse_darkness_desc",
        sprite_pos = {x = 1, y = 0},
    },
    ["entr_lost"] = {
        key = "k_curse_lost",
        desc_key = "k_curse_lost_desc",
        sprite_pos = {x = 2, y = 0},
    },
    ["entr_maze"] = {
        key = "k_curse_maze",
        desc_key = "k_curse_maze_desc",
        in_pool = function()
            return G.GAME.ante ~= G.GAME.win_ante
        end,
        sprite_pos = {x = 3, y = 0},
    }
}

SMODS.Tag {
    key = "curse_indicator",
    atlas = "curse_icons",
    no_collection = true,
    in_pool = function() return false end,
    loc_vars = function()
        return {
            key = G.GAME.curse and "tag_curse_"..G.GAME.curse
        }
    end
}

function _G.add_curse_icon(_tag, no_copy)
    G.HUD_curses = G.HUD_curses or {}
    local tag_sprite_ui, tag_sprite = _tag:generate_UI()
    G.HUD_curses[#G.HUD_curses+1] = UIBox{
        definition = {n=G.UIT.ROOT, config={align = "tm", padding = 0.05, colour = G.C.CLEAR}, nodes={
          tag_sprite_ui
        }},
        config = {
          align = G.HUD_curses[1] and 'bm' or 'br',
          offset = G.HUD_curses[1] and {x=0,y=0} or {x=-0.8,y=0.4},
          major = G.HUD_curses[1] and G.HUD_curses[#G.HUD_curses] or G.consumeables}
    }
    discover_card(G.P_TAGS[_tag.key])
    unlock_card(G.P_TAGS[_tag.key])

    _tag.HUD_tag = G.HUD_curses[#G.HUD_curses]
    _tag.HUD_tag.actual = _tag
    _tag.HUD_sprite = tag_sprite
    _tag.ability.index = #G.HUD_curses
    if #G.HUD_curses > 6 then
		for i = 2, #G.HUD_curses do
			G.HUD_curses[i].config.offset.y = -0.9 + 0.9 * (6 / #G.HUD_curses)
		end
	end
end

function Entropy.get_curse_rate()
    if not Entropy.config.curses_enabled then return 0 end
    if to_big(G.GAME.round_resets.ante) <= to_big(G.GAME.win_ante or 8) then return 0 end
    local key = G.GAME.selected_back and G.GAME.selected_back.effect.center.original_key
    local wins = G.PROFILES and G.SETTINGS.profile and G.PROFILES[G.SETTINGS.profile].deck_usage and G.PROFILES[G.SETTINGS.profile].deck_usage[key] and G.PROFILES[G.SETTINGS.profile].deck_usage[key].wins or {}
    return 0.04 + (G.GAME.entr_alt and 0.06 or 0)
end

function sprite_attention_text(args)
    local a = {}
    for i, v in pairs(args) do a[i] = v end
    args = args or {}
    args.text = args.text or 'test'
    args.scale = args.scale or 1
    args.colour = SMODS.shallow_copy(args.colour or G.C.WHITE)
    args.hold = (args.hold or 0) + 0.1*(G.SPEEDFACTOR)
    args.pos = args.pos or {x = 0, y = 0}
    args.align = args.align or 'cm'
    args.emboss = args.emboss or nil

    args.fade = 1

    if args.cover then
      args.cover_colour = SMODS.shallow_copy(args.cover_colour or G.C.RED)
      args.cover_colour_l = SMODS.shallow_copy(lighten(args.cover_colour, 0.2))
      args.cover_colour_d = SMODS.shallow_copy(darken(args.cover_colour, 0.2))
    else
      args.cover_colour = copy_table(G.C.CLEAR)
    end

    args.uibox_config = {
      align = args.align or 'cm',
      offset = args.offset or {x=0,y=0}, 
      major = args.cover or args.major or nil,
    }
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0,
      blockable = false,
      blocking = false,
      func = function()
        local sprite
            if args.atlas then
                sprite = SMODS.create_sprite(args.X, args.Y, args.W, args.H, args.atlas, args.spos or {x = 0, y = 0})
            end
          args.AT = UIBox{
            T = {args.pos.x + args.X,args.pos.y + args.Y,0,0},
            definition = 
              {n=G.UIT.ROOT, config = {
                align = args.cover_align or 'cm', minw = (args.cover and args.cover.T.w or 0.001) + (args.cover_padding or 0), 
                minh = (args.cover and args.cover.T.h or 0.001) + (args.cover_padding or 0), padding = 0.03, r = 0.1, 
                emboss = args.emboss, colour = args.cover_colour}, nodes={
                sprite and {n=G.UIT.O, config={draw_layer = 1, object = sprite}} or nil,
              }}, 
            config = args.uibox_config
          }
          args.AT.attention_text = true

          args.sprite = args.AT.UIRoot.children[1].config.object
          --args.text:pulse(0.5)
          return true
      end
      }))

      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = args.hold,
        blockable = false,
        blocking = false,
        func = function()
          if not args.start_time then
            args.start_time = G.TIMERS.TOTAL
            --args.text:pop_out(3)
          else
            --args.AT:align_to_attach()
            args.fade = math.max(0, 1 - 3*(G.TIMERS.TOTAL - args.start_time))
            if args.cover_colour then args.cover_colour[4] = math.min(args.cover_colour[4], 2*args.fade) end
            if args.cover_colour_l then args.cover_colour_l[4] = math.min(args.cover_colour_l[4], args.fade) end
            if args.cover_colour_d then args.cover_colour_d[4] = math.min(args.cover_colour_d[4], args.fade) end
            if args.backdrop_colour then args.backdrop_colour[4] = math.min(args.backdrop_colour[4], args.fade) end
            args.colour[4] = math.min(args.colour[4], args.fade)
            if args.fade <= 0 then
              args.AT:remove()
              return true
            end
          end
        end
      }))
      attention_text(a)
  end

function Entropy.create_curse(key)
    G.GAME.entr_maze_applied = nil
    local curses = {}
    for i, v in pairs(Entropy.curses) do
        if not v.in_pool or v:in_pool() then
            curses[#curses+1] = i
        end
    end
    G.GAME.curse = key or pseudorandom_element(curses, pseudoseed("entr_curse"))
    local atlas = Entropy.curses[G.GAME.curse].atlas or "entr_curse_icons"
    local pos = Entropy.curses[G.GAME.curse].sprite_pos or {x = 0, y = 0}
    attention_text({
        scale = 1,
        text = localize(Entropy.curses[G.GAME.curse].key),
        hold = 8,
        align = "cm",
        offset = { x = 0, y = -2.7 },
        major = G.play,
    })
    attention_text({
        scale = 0.7,
        text = localize(Entropy.curses[G.GAME.curse].desc_key),
        hold = 8,
        align = "cm",
        offset = { x = 0, y = -1.8 },
        major = G.play,
    })
    if G.GAME.curse == "entr_lost" then
        G.GAME.modifiers.cry_no_small_blind_last = G.GAME.modifiers.cry_no_small_blind
        G.GAME.modifiers.cry_no_small_blind = true
    else
        G.GAME.modifiers.cry_no_small_blind = G.GAME.modifiers.cry_no_small_blind_last
        G.GAME.modifiers.cry_no_small_blind_last = nil
    end
    if not G.HUD_curses or #G.HUD_curses < 1 then
        add_curse_icon(Tag("tag_entr_curse_indicator"))
    elseif G.HUD_curses then
        G.HUD_curses[1].actual:juice_up()
    end
    local sprite = G.HUD_curses[1].actual.HUD_sprite
    sprite.atlas = G.ASSET_ATLAS[atlas]
    sprite:set_sprite_pos(pos)
end

local dft = Blind.defeat
function Blind:defeat(s)
    dft(self, s)
    if G.GAME.blind_on_deck == "Boss" then
        G.GAME.curse_rate = (G.GAME.curse_rate_mod or Entropy.get_curse_rate()) * G.GAME.round_resets.ante
        if to_big(G.GAME.curse_rate_mod or 0) < to_big(1) and to_big(G.GAME.round_resets.ante) <= to_big(G.GAME.win_ante or 8) then G.GAME.curse_rate = 0 end
        if not (MP and MP.LOBBY and MP.LOBBY.code) then
            if pseudorandom("entr_curse") < G.GAME.curse_rate then
                Entropy.create_curse()
            else
                if G.HUD_curses and G.HUD_curses[1] then
                    G.HUD_curses[1].actual:yep('+', G.C.PURPLE, function() 
                        return true end)
                    G.HUD_curses = nil
                end
                G.GAME.entr_maze_applied = nil
                G.GAME.curse = nil
            end
        end
    end
end

local ccfs = create_card_for_shop
function create_card_for_shop(...)
    local card = ccfs(...)
    if G.GAME.curse == "entr_blind" then
        if pseudorandom("entr_blind_curse") < 0.5 then
            card.cry_flipped = true
        end
    end
    return card
end

local iridium = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	object_type = "Stake",
    order = 5,
    key = "iridium",
    pos = { x = 4, y = 0 },
    atlas = "stakes",
    applied_stakes = { "entr_obsidian" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=4,y=0},
    modifiers = function()
        G.GAME.win_ante = 10
    end,
    colour = HEX("983443"),
    shiny = true,
}

local zenith = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	object_type = "Stake",
    order = 6,
    key = "zenith",
    pos = { x = 5, y = 0 },
    atlas = "stakes",
    applied_stakes = { "entr_iridium" },
    prefix_config = { applied_stakes = { mod = false } },
    sticker_atlas = "stake_stickers",
    sticker_pos = {x=5,y=0},
    modifiers = function()
        G.GAME.modifiers.zenith = true
    end,
    colour = HEX("ff00ff")
}

return {
    items = {
        copper,
        platinum,
        meteorite,
        obsidian,
        iridium,
        zenith
    }
}

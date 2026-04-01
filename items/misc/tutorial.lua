G.FUNCS.entropy_tutorial_controller = function()
  if G.F_SKIP_TUTORIAL then
      G.SETTINGS.entropy_tutorial_complete = true -- this is basically saying "if tutorial is skipped, set all relevant variables
      G.SETTINGS.entropy_tutorial_progress = nil
      return
  end
  G.SETTINGS.entropy_tutorial_progress = G.SETTINGS.entropy_tutorial_progress or 
  {
    -- this is where you declare all of the keys for forced items
    -- by default it only supports a few things
    -- forced_shop is a table that queues up the jokers that are generated
    -- forced_voucher is the first voucher that shows up in the shop
    -- forced_tags are the tags that show up for the first two blinds specifically
    -- and then these last two are forced for things to work
    hold_parts = {},
    completed_parts = {},
    forced_shop = {"j_entr_sunny_joker"},
    custom_forced = {
        voucher = {{key = "v_entr_diviner", ante = 2}},
        pack = {{key = "p_entr_twisted_pack_normal", ante = 2, blind = "Small", pos = 1},{key = "p_celestial_normal_1", ante = 2, blind = "Small", pos = 2}},
    }
  }
  -- and then finally, the main meat of this controller is the one that manages which part of the tutorial you're in
  -- it generally goes in this format:
  if G.STATE == G.STATES.SELECTING_HAND and not G.SETTINGS.entropy_tutorial_progress.completed_parts['intro'] then
    G.FUNCS.entropy_tutorial_part('intro')
    G.SETTINGS.entropy_tutorial_progress.completed_parts['intro']  = true
    G:save_progress()
  end
  if G.STATE == G.STATES.SHOP and not G.SETTINGS.entropy_tutorial_progress.completed_parts['ascension_power'] then
    G.FUNCS.entropy_tutorial_part('ascension_power')
    G.SETTINGS.entropy_tutorial_progress.completed_parts['ascension_power']  = true
    G:save_progress()
  end
  if G.STATE == G.STATES.SHOP and G.GAME.round_resets.ante == 2 and not G.SETTINGS.entropy_tutorial_progress.completed_parts['alt_path'] then
    G.FUNCS.entropy_tutorial_part('alt_path')
    G.SETTINGS.entropy_tutorial_progress.completed_parts['alt_path']  = true
    G:save_progress()
  end
  if G.STATE == G.STATES.SHOP and G.GAME.round_resets.ante == 2 and G.GAME.round_resets.blind_states["Small"] == "Defeated" 
    and not G.SETTINGS.entropy_tutorial_progress.completed_parts['packs']
  then
    G.FUNCS.entropy_tutorial_part('packs')
    G.SETTINGS.entropy_tutorial_progress.completed_parts['packs'] = true
    G:save_progress()
  end
end

G.FUNCS.entropy_tutorial_part = function(_part)
    local step = 1
    G.SETTINGS.paused = true
    if _part == "intro" then
        step = entropy_tutorial_info({
            text_key = 'entr_tut_intro_1',
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 0, y = 0}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_tut_intro_2',
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 0, y = 0}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_tut_intro_3',
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 0, y = 0}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_tut_intro_4',
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 0, y = 0}},
            step = step,
        })
    end
    if _part == "ascension_power" then
        step = entropy_tutorial_info({
            text_key = 'entr_ap_1',
            highlight = {
                G.SHOP_SIGN,
                G.HUD:get_UIE_by_ID('dollar_text_UI').parent.parent.parent
            },
            attach = {major = G.shop, type = 'tm', offset = {x = 0, y = 4}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_ap_2',
            highlight = function() 
                G.E_MANAGER:add_event(Event{
                    func = function()
                        G.OVERLAY_TUTORIAL.highlights[#G.OVERLAY_TUTORIAL.highlights+1] = G.shop_jokers.cards[1]
                        return true
                    end
                })
                return {
                    G.SHOP_SIGN,
                    G.HUD:get_UIE_by_ID('dollar_text_UI').parent.parent.parent, 
                } 
            end,
            snap_to = function() return G.shop_jokers.cards[1] end,
            no_button = true,
            button_listen = 'buy_from_shop',
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_ap_3',
            loc_vars = {
                Entropy.count_jokers()
            },
            highlight = {
                G.SHOP_SIGN,
                G.HUD:get_UIE_by_ID('dollar_text_UI').parent.parent.parent,
                G.jokers.cards[1]
            },
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_ap_4',
            highlight = {
                G.SHOP_SIGN,
                G.HUD:get_UIE_by_ID('dollar_text_UI').parent.parent.parent,
                G.jokers.cards[1]
            },
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_ap_5',
            highlight = {
                G.SHOP_SIGN,
                G.HUD:get_UIE_by_ID('dollar_text_UI').parent.parent.parent,
                G.jokers.cards[1]
            },
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_ap_6',
            highlight = {
                G.SHOP_SIGN,
                G.HUD:get_UIE_by_ID('dollar_text_UI').parent.parent.parent,
                G.jokers.cards[1]
            },
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_ap_7',
            highlight = {
                G.SHOP_SIGN,
                G.HUD:get_UIE_by_ID('dollar_text_UI').parent.parent.parent,
                G.jokers.cards[1]
            },
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_ap_8',
            highlight = {
                G.SHOP_SIGN,
                G.HUD:get_UIE_by_ID('dollar_text_UI').parent.parent.parent,
                G.jokers.cards[1]
            },
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step,
        })
    end
    if _part == "alt_path" then
        step = entropy_tutorial_info({
            text_key = 'entr_alt_1',
            highlight = {},
            attach = {major = G.shop, type = 'tm', offset = {x = 0, y = 4}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_alt_2',
            highlight = {G.shop:get_UIE_by_ID('change_path_button')},
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step 
        })
        step = entropy_tutorial_info({
            text_key = 'entr_alt_3',
            highlight = {},
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step 
        })
        step = entropy_tutorial_info({
            text_key = 'entr_alt_4',
            highlight = {},
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step
        })
        step = entropy_tutorial_info({
            text_key = 'entr_alt_5',
            highlight = {},
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step
        })
        step = entropy_tutorial_info({
            text_key = 'entr_alt_6',
            highlight = {},
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step 
        })
        step = entropy_tutorial_info({
            text_key = 'entr_alt_7',
            highlight = {},
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step
        })
        step = entropy_tutorial_info({
            text_key = 'entr_alt_8',
            highlight = function()
                return {G.shop:get_UIE_by_ID('change_path_button')}
            end,
            no_button = true,
            button_listen = 'toggle_path',
            attach = {major = G.shop, type = 'tr', offset = {x = -0.5, y = 6}},
            step = step,
        })
    end
    if _part == "packs" then
        step = entropy_tutorial_info({
            text_key = 'entr_packs_1',
            highlight = function() 
                return {
                    G.SHOP_SIGN,
                    G.HUD:get_UIE_by_ID('dollar_text_UI').parent.parent.parent
                }
            end,
            attach = {major = G.shop, type = 'tm', offset = {x = 0, y = 4}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_packs_2',
            highlight = function() 
                return {
                    G.SHOP_SIGN,
                    G.HUD:get_UIE_by_ID('dollar_text_UI').parent.parent.parent,
                    G.shop_booster.cards[1]
                }
            end,
            attach = {major = G.shop, type = 'tm', offset = {x = -4, y = 4}},
            step = step,
            no_button = true,
            button_listen = 'use_card',
        })
        step = entropy_tutorial_info({
            text_key = 'entr_packs_3',
            highlight = {},
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 0, y = 0}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_packs_4',
            highlight = {},
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 0, y = 0}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_packs_5',
            highlight = function() return {
                G.pack_cards.cards[1]
            } end,
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 6, y = 0}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_packs_6',
            highlight = {},
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 6, y = 0}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_packs_7',
            highlight = {},
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 6, y = 0}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_packs_8',
            highlight = function() return {
                G.pack_cards.cards[1],
                G.jokers.cards[1]
            } end,
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 6, y = 0}},
            step = step,
            no_button = true,
            button_listen = "use_card"
        })

        step = entropy_tutorial_info({
            text_key = 'entr_packs_9',
            highlight = function() 
                return {
                    G.SHOP_SIGN,
                    G.HUD:get_UIE_by_ID('dollar_text_UI').parent.parent.parent,
                    G.shop_booster.cards[1]
                }
            end,
            attach = {major = G.shop, type = 'tm', offset = {x = -4, y = 4}},
            step = step,
            no_button = true,
            button_listen = 'use_card',
        })
        step = entropy_tutorial_info({
            text_key = 'entr_packs_10',
            highlight = {},
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 6, y = 0}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_packs_11',
            highlight = function() return {
                G.pack_cards.cards[1]
            } end,
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 6, y = 0}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_packs_12',
            highlight = function() return {
                G.pack_cards.cards[1]
            } end,
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 6, y = 0}},
            step = step,
        })
        step = entropy_tutorial_info({
            text_key = 'entr_packs_13',
            highlight = function() return {
                G.pack_cards.cards[1]
            } end,
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 6, y = 0}},
            step = step,
            no_button = true,
            button_listen = "use_card"
        })
        step = entropy_tutorial_info({
            text_key = 'entr_packs_14',
            highlight = function()
                G.SETTINGS.entropy_tutorial_complete = true
            end,
            attach = {major = G.ROOM_ATTACH, type = 'cm', offset = {x = 0, y = 0}},
            step = step,
        })
    end
    G.E_MANAGER:add_event(Event({
        blockable = false,
        timer = 'REAL',
        func = function()
            if G.OVERLAY_TUTORIAL and ((G.OVERLAY_TUTORIAL.step == step and
            not G.OVERLAY_TUTORIAL.step_complete) or G.OVERLAY_TUTORIAL.skip_steps) then
                if G.OVERLAY_TUTORIAL.Jimbo then G.OVERLAY_TUTORIAL.Jimbo:remove() end
                if G.OVERLAY_TUTORIAL.content then G.OVERLAY_TUTORIAL.content:remove() end
                G.OVERLAY_TUTORIAL:remove()
                G.OVERLAY_TUTORIAL = nil
                G.SETTINGS.entropy_tutorial_progress.hold_parts[_part]=true
                return true
            end
            return G.OVERLAY_TUTORIAL.step > step or G.OVERLAY_TUTORIAL.skip_steps
        end
    }), 'tutorial') 
    G.SETTINGS.paused = false
end


function entropy_tutorial_info(args)
    local overlay_colour = {0.32,0.36,0.41,0}
    ease_value(overlay_colour, 4, 0.6, nil, 'REAL', true,0.4)
    G.OVERLAY_TUTORIAL = G.OVERLAY_TUTORIAL or UIBox{
        definition = {n=G.UIT.ROOT, config = {align = "cm", padding = 32.05, r=0.1, colour = overlay_colour, emboss = 0.05}, nodes={
            {n=G.UIT.R, config={align = "tr", minh = G.ROOM.T.h, minw = G.ROOM.T.w}, nodes={
                UIBox_button{label = {localize('b_skip').." >"}, button = "skip_entr_tutorial_section", minw = 1.3, scale = 0.45, colour = G.C.JOKER_GREY}
            }}
        }},
        config = {
            align = "cm",
            offset = {x=0,y=3.2},
            major = G.ROOM_ATTACH,
            bond = 'Weak'
          }
      }
    G.OVERLAY_TUTORIAL.step = G.OVERLAY_TUTORIAL.step or 1
    G.OVERLAY_TUTORIAL.step_complete = false
    local row_dollars_chips = G.HUD:get_UIE_by_ID('row_dollars_chips')
    local align = args.align or "tm"
    local step = args.step or 1
    local attach = args.attach or {major = row_dollars_chips, type = 'tm', offset = {x=0, y=-0.5}}
    local pos = args.pos or {x=attach.major.T.x + attach.major.T.w/2, y=attach.major.T.y + attach.major.T.h/2}
    pos.center = 'j_entr_teacherruby'
    pos.googly = true
    local button = args.button or {button = localize('b_next'), func = 'tut_next'}
    args.highlight = args.highlight or {}
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.3,
        func = function()
            if G.OVERLAY_TUTORIAL and G.OVERLAY_TUTORIAL.step == step and
            not G.OVERLAY_TUTORIAL.step_complete then
                G.CONTROLLER.interrupt.focus = true
                G.OVERLAY_TUTORIAL.Jimbo = G.OVERLAY_TUTORIAL.Jimbo or Card_Character(pos)
                G.OVERLAY_TUTORIAL.Jimbo.children.card.googly = true
                G.OVERLAY_TUTORIAL.Jimbo.children.card.force_look_dir = args.look
                if type(args.highlight) == 'function' then args.highlight = args.highlight() end
                args.highlight[#args.highlight+1] = G.OVERLAY_TUTORIAL.Jimbo
                G.OVERLAY_TUTORIAL.Jimbo:add_speech_bubble(args.text_key, align, args.loc_vars)
                G.OVERLAY_TUTORIAL.Jimbo:set_alignment(attach)
                if args.hard_set then G.OVERLAY_TUTORIAL.Jimbo:hard_set_VT() end
                G.OVERLAY_TUTORIAL.button_listen = nil
                if G.OVERLAY_TUTORIAL.content then G.OVERLAY_TUTORIAL.content:remove() end
                if args.content then
                    G.OVERLAY_TUTORIAL.content = UIBox{
                        definition = args.content(),
                        config = {
                            align = args.content_config and args.content_config.align or "cm",
                            offset = args.content_config and args.content_config.offset or {x=0,y=0},
                            major = args.content_config and args.content_config.major or G.OVERLAY_TUTORIAL.Jimbo,
                            bond = 'Weak'
                          }
                      }
                    args.highlight[#args.highlight+1] = G.OVERLAY_TUTORIAL.content
                end
                if args.button_listen then G.OVERLAY_TUTORIAL.button_listen = args.button_listen end
                if not args.no_button then G.OVERLAY_TUTORIAL.Jimbo:add_button(button.button, button.func, button.colour, button.update_func, true) end
                G.OVERLAY_TUTORIAL.Jimbo:say_stuff(2*(#(G.localization.misc.tutorial[args.text_key] or {}))+1)
                if args.snap_to then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        blocking = false, blockable = false,
                        func = function()
                            if G.OVERLAY_TUTORIAL and G.OVERLAY_TUTORIAL.Jimbo and not G.OVERLAY_TUTORIAL.Jimbo.talking then 
                            local _snap_to = args.snap_to()
                            if _snap_to then
                                G.CONTROLLER.interrupt.focus = false
                                G.CONTROLLER:snap_to({node = args.snap_to()})
                            end
                            return true
                            end
                        end
                    }), 'tutorial') 
                end
                if args.highlight then G.OVERLAY_TUTORIAL.highlights = args.highlight end 
                G.OVERLAY_TUTORIAL.step_complete = true
            end
            return not G.OVERLAY_TUTORIAL or G.OVERLAY_TUTORIAL.step > step or G.OVERLAY_TUTORIAL.skip_steps
        end
    }), 'tutorial') 
    return step+1
end

G.FUNCS.skip_entr_tutorial_section = function(e)
    G.OVERLAY_TUTORIAL.skip_steps = true

    if G.OVERLAY_TUTORIAL.Jimbo then G.OVERLAY_TUTORIAL.Jimbo:remove() end
    if G.OVERLAY_TUTORIAL.content then G.OVERLAY_TUTORIAL.content:remove() end
    G.OVERLAY_TUTORIAL:remove()
    G.OVERLAY_TUTORIAL = nil
    G.E_MANAGER:clear_queue('tutorial')   
end

SMODS.Joker {
    key = "teacherruby",
    atlas = "jokers",
    no_collection = true,
    in_pool = function() return false end,
    rarity = "entr_zenith",
    pos = {x = 9, y = 17},
    no_doe = true,
    no_collection = true,
	in_pool = function()
		return false
	end,
    cry_order = 999999,
    discovered = true,
    unlocked = true
}

function Entropy.get_forced_voucher()
    for i, v in pairs(((G.SETTINGS.entropy_tutorial_progress or {}).custom_forced or {}).voucher or {}) do
        if G.GAME.round_resets.ante == v.ante then return v.key end
    end
    return (G.SETTINGS.entropy_tutorial_progress or {}).forced_voucher
end

function Entropy.get_forced_booster(i)
    for _, v in pairs(((G.SETTINGS.entropy_tutorial_progress or {}).custom_forced or {}).pack or {}) do
        if G.GAME.round_resets.ante == v.ante and G.GAME.round_resets.blind_states[v.blind] == "Defeated" and v.pos == i then return v.key end
    end
end

G.FUNCS.start_entropy_run = function(e, args) 
  G.SETTINGS.paused = true
  if e and e.config.id == 'restart_button' then G.GAME.viewed_back = nil end
  args = args or {}
  G.GAME.selected_back = Back(G.P_CENTERS['b_red'])
  args.seed = "EENTROPY"
  G.E_MANAGER:clear_queue()
  G.FUNCS.wipe_on()
  G.E_MANAGER:add_event(Event({
    no_delete = true,
    func = function()
      G:delete_run()
      return true
    end
  }))
  G.E_MANAGER:add_event(Event({
    trigger = 'immediate',
    no_delete = true,
    func = function()
      G:start_run(args)
      return true
    end
  }))
  G.FUNCS.wipe_off()
end

local ccfs = create_card_for_shop
function create_card_for_shop(area,...)
    if area == G.shop_jokers and G.SETTINGS.entropy_tutorial_progress and G.SETTINGS.entropy_tutorial_progress.forced_shop and G.SETTINGS.entropy_tutorial_progress.forced_shop[#G.SETTINGS.entropy_tutorial_progress.forced_shop] then
        local t = G.SETTINGS.entropy_tutorial_progress.forced_shop
        local _center = G.P_CENTERS[t[#t]] or G.P_CENTERS.c_empress
        local card = Card(area.T.x + area.T.w/2, area.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, _center, {bypass_discovery_center = true, bypass_discovery_ui = true})
        t[#t] = nil
        if not t[1] then G.SETTINGS.entropy_tutorial_progress.forced_shop = nil end
        card.cost = 2
        create_shop_card_ui(card)
        return card
    end
    return ccfs(area,...)
end

function Entropy.count_jokers()
    local c = 0
    for i, v in pairs(Entropy.contents.Joker) do
        if not v.no_collection then
            c = c + 1
        end
    end
    return c
end

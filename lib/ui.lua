function G.UIDEF.bought_decks()

    local silent = false
    local keys_used = {}
    local area_count = 0
    local voucher_areas = {}
    local voucher_tables = {}
    local voucher_table_rows = {}
    for k, v in ipairs(G.GAME.entr_bought_decks or {}) do
      local key = 1 + math.floor((k-0.1)/2)
      keys_used[#keys_used+1] = G.P_CENTERS[v]
    end
    for k, v in ipairs(keys_used) do 
      area_count = area_count + 1
    end
    for k, v in ipairs(keys_used) do 
      if next(v) then
        if #voucher_areas == 5 or #voucher_areas == 10 then 
          table.insert(voucher_table_rows, 
          {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes=voucher_tables}
          )
          voucher_tables = {}
        end
        voucher_areas[#voucher_areas + 1] = CardArea(
            G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
            (#v == 1 and 1 or 1.33)*G.CARD_W,
            (area_count >=10 and 0.75 or 1.07)*G.CARD_H, 
            {card_limit = 1, type = 'voucher', highlight_limit = 0})
            local center = v
            local card = Card(voucher_areas[#voucher_areas].T.x + voucher_areas[#voucher_areas].T.w/2, voucher_areas[#voucher_areas].T.y, G.CARD_W, G.CARD_H, nil, center, {bypass_discovery_center=true,bypass_discovery_ui=true,bypass_lock=true})
            card.ability.order = v.order
            card:start_materialize(nil, silent)
            silent = true
            voucher_areas[#voucher_areas]:emplace(card)
        table.insert(voucher_tables, 
        {n=G.UIT.C, config={align = "cm", padding = 0, no_fill = true}, nodes={
          {n=G.UIT.O, config={object = voucher_areas[#voucher_areas]}}
        }}
        )
      end
    end
    table.insert(voucher_table_rows,
            {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes=voucher_tables}
          )
  
    
    local t = silent and {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
      {n=G.UIT.R, config={align = "cm"}, nodes={
        {n=G.UIT.O, config={object = DynaText({string = {localize('ph_decks_bought')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}}
      }},
      {n=G.UIT.R, config={align = "cm", minh = 0.5}, nodes={
      }},
      {n=G.UIT.R, config={align = "cm", colour = G.C.BLACK, r = 1, padding = 0.15, emboss = 0.05}, nodes={
        {n=G.UIT.R, config={align = "cm"}, nodes=voucher_table_rows},
      }}
    }} or 
    {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
      {n=G.UIT.O, config={object = DynaText({string = {localize('ph_no_decks')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}}
    }}
    return t
  end
  
if CardSleeves then
    function CardSleeves.Sleeve.get_current_deck_key()
        if Galdur and Galdur.config.use and Galdur.run_setup.choices.deck then
            return Galdur.run_setup.choices.deck.effect.center.key
        elseif G.GAME.viewed_back and G.GAME.viewed_back.effect then
            return G.GAME.viewed_back.effect.center.key
        elseif G.GAME.selected_back and G.GAME.selected_back.effect then
            return G.GAME.selected_back.effect.center.key
        end
        return "b_red"
    end
end


function G.UIDEF.define_keys()

    local silent = false
    local keys_used = {}
    local area_count = 0
    local voucher_areas = {}
    local voucher_tables = {}
    local voucher_table_rows = {}
    for k, v in pairs(G.GAME.DefineKeys or {}) do
      keys_used[k] = v
    end
    for k, v in pairs(keys_used) do 
      area_count = area_count + 1
    end
    for k, v in pairs(keys_used) do 
      if next(G.P_CENTERS[v] or {}) or next(v or {}) then
        if #voucher_areas == 5 or #voucher_areas == 10 then 
          table.insert(voucher_table_rows, 
          {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes=voucher_tables}
          )
          voucher_tables = {}
        end
        voucher_areas[#voucher_areas + 1] = CardArea(
            G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
            (#v == 1 and 1 or 1.33)*G.CARD_W,
            (area_count >=10 and 0.75 or 1.07)*G.CARD_H, 
            {card_limit = 2, type = 'voucher', highlight_limit = 0})
            local center = G.P_CENTERS[k]
            if center then
                local card = Card(voucher_areas[#voucher_areas].T.x + voucher_areas[#voucher_areas].T.w/2, voucher_areas[#voucher_areas].T.y, G.CARD_W, G.CARD_H, nil, center, {bypass_discovery_center=true,bypass_discovery_ui=true,bypass_lock=true})
                card.ability.order = 1
                card:start_materialize(nil, silent)
                silent = true
                voucher_areas[#voucher_areas]:emplace(card)
                local center = G.P_CENTERS[v]
            else
                local t = {}
                for v in string.gmatch(k, "[^%s]+") do
                    t[#t+1]=v
                end
                local card = Card(voucher_areas[#voucher_areas].T.x + voucher_areas[#voucher_areas].T.w/2, voucher_areas[#voucher_areas].T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS["c_base"], {bypass_discovery_center=true,bypass_discovery_ui=true,bypass_lock=true})
                SMODS.change_base(card, t[3], t[1])
                card.ability.order = 1
                card:start_materialize(nil, silent)
                voucher_areas[#voucher_areas]:emplace(card)
            end
            local center = G.P_CENTERS[v]
            if center then
                local card = Card(voucher_areas[#voucher_areas].T.x + voucher_areas[#voucher_areas].T.w/2, voucher_areas[#voucher_areas].T.y, G.CARD_W, G.CARD_H, nil, center, {bypass_discovery_center=true,bypass_discovery_ui=true,bypass_lock=true})
                card.ability.order = 2
                card:start_materialize(nil, silent)
                silent = true
                voucher_areas[#voucher_areas]:emplace(card)
            else
                local card = Card(voucher_areas[#voucher_areas].T.x + voucher_areas[#voucher_areas].T.w/2, voucher_areas[#voucher_areas].T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[v._enh or "c_base"] or G.P_CENTERS["c_base"], {bypass_discovery_center=true,bypass_discovery_ui=true,bypass_lock=true})
                SMODS.change_base(card, v._suit, v._rank)
                if v._seal and v._seal ~= "" then card.seal = v._seal end
                if v._ed and v._ed ~= "" then card:set_edition(v._ed) end
                card.ability.order = 2
                card:start_materialize(nil, silent)
                silent = true
                voucher_areas[#voucher_areas]:emplace(card)
            end
        table.insert(voucher_tables, 
        {n=G.UIT.C, config={align = "cm", padding = 0, no_fill = true}, nodes={
          {n=G.UIT.O, config={object = voucher_areas[#voucher_areas]}}
        }}
        )
      end
    end
    table.insert(voucher_table_rows,
            {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes=voucher_tables}
          )
  
    
    local t = silent and {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
      {n=G.UIT.R, config={align = "cm"}, nodes={
        {n=G.UIT.O, config={object = DynaText({string = {localize('ph_cards_defined')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}},
      }},
      {n=G.UIT.R, config={align = "cm"}, nodes={
        {n=G.UIT.O, config={object = DynaText({string = {localize('ph_leftright')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}},
      }},
      {n=G.UIT.R, config={align = "cm", minh = 0.5}, nodes={
      }},
      {n=G.UIT.R, config={align = "cm", colour = G.C.BLACK, r = 1, padding = 0.15, emboss = 0.05}, nodes={
        {n=G.UIT.R, config={align = "cm"}, nodes=voucher_table_rows},
      }}
    }} or 
    {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
      {n=G.UIT.O, config={object = DynaText({string = {localize('ph_definitions')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}}
    }}
    return t
  end

  function create_UIBox_memleak(card)
    G.E_MANAGER:add_event(Event({
        blockable = false,
        func = function()
            G.REFRESH_ALERTS = true
            return true
        end,
    }))
    local t = create_UIBox_generic_options({
        no_back = true,
        colour = HEX("04200c"),
        outline_colour = G.C.Entropy.RCode,
        contents = {
            {
                n = G.UIT.R,
                nodes = {
                    create_text_input({
                        colour = G.C.Entropy.RCode,
                        hooked_colour = darken(copy_table(G.C.Entropy.RCode), 0.3),
                        w = 4.5,
                        h = 1,
                        max_length = 2500,
                        extended_corpus = true,
                        prompt_text = "???",
                        ref_table = G,
                        ref_value = "ENTERED_ACE",
                        keyboard_offset = 1,
                    }),
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    UIBox_button({
                        colour = G.C.Entropy.RCode,
                        button = "ca",
                        label = { localize("cry_code_execute") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
        },
    })
    return t
end

function create_UIBox_inherit(card)
  G.E_MANAGER:add_event(Event({
      blockable = false,
      func = function()
          G.REFRESH_ALERTS = true
          return true
      end,
  }))
  local t = create_UIBox_generic_options({
      no_back = true,
      colour = HEX("04200c"),
      outline_colour = HEX("FF0000"),
      contents = {
          {
              n = G.UIT.R,
              nodes = {
                  create_text_input({
                      colour = HEX("FF0000"),
                      hooked_colour = darken(copy_table(HEX("FF0000")), 0.3),
                      w = 4.5,
                      h = 1,
                      max_length = 16,
                      prompt_text = localize("cry_code_enh"),
                      ref_table = G,
                      ref_value = "ENTERED_ENH",
                      keyboard_offset = 1,
                  }),
              },
          },
          {
              n = G.UIT.R,
              nodes = {
                  UIBox_button({
                      colour = HEX("FF0000"),
                      button = "inherit_apply",
                      label = { localize("cry_code_apply") },
                      minw = 4.5,
                      focus_args = { snap_to = true },
                  }),
              },
          },
          {
              n = G.UIT.R,
              nodes = {
                  UIBox_button({
                      colour = G.C.RED,
                      button = "inherit_apply_previous",
                      label = { localize("cry_code_apply_previous") },
                      minw = 4.5,
                      focus_args = { snap_to = true },
                  }),
              },
          },
          {
              n = G.UIT.R,
              nodes = {
                  UIBox_button({
                      colour = G.C.RED,
                      button = "inherit_cancel",
                      label = { localize("cry_code_cancel") },
                      minw = 4.5,
                      focus_args = { snap_to = true },
                  }),
              },
          },
      },
  })
  return t
end

G.FUNCS.inherit_apply_previous = function()
  if G.PREVIOUS_ENTERED_ENH then
      G.ENTERED_ENH = G.PREVIOUS_ENTERED_ENH or ""
  end
  G.FUNCS.inherit_apply()
end
--todo: mod support
G.FUNCS.inherit_apply = function()
  local base_enh = G.hand and G.hand.highlighted[1] and G.hand.highlighted[1].config.center.key or ""
  if base_enh == "" then
      G.PREVIOUS_ENTERED_ENH = G.ENTERED_ENH
      G.GAME.USING_CODE = false
      Entropy.ChangeEnhancements({G.discard, G.deck, G.hand}, enh_suffix, base_enh, true)
      G.CHOOSE_ENH:remove()
  end
  local enh_table = Cryptid.enhancement_alias_list

  local enh_suffix = nil

  for i, v in pairs(enh_table) do
      for j, k in pairs(v) do
          if string.lower(G.ENTERED_ENH) == string.lower(k) then
              enh_suffix = i
          end
      end
  end

  if enh_suffix and base_enh ~= "c_base" then
      G.PREVIOUS_ENTERED_ENH = G.ENTERED_ENH
      G.GAME.USING_CODE = false
      Entropy.ChangeEnhancements({G.discard, G.deck, G.hand}, enh_suffix, base_enh, true)
      G.CHOOSE_ENH:remove()
  end
end

G.FUNCS.inherit_cancel = function()
  G.GAME.USING_CODE = false
  G.CHOOSE_ENH:remove()
end

function create_UIBox_sudo(card)
  G.E_MANAGER:add_event(Event({
      blockable = false,
      func = function()
          G.REFRESH_ALERTS = true
          return true
      end,
  }))
  local t = create_UIBox_generic_options({
      no_back = true,
      colour = HEX("04200c"),
      outline_colour = HEX("FF0000"),
      contents = {
          {
              n = G.UIT.R,
              nodes = {
                  create_text_input({
                      colour = HEX("FF0000"),
                      hooked_colour = darken(copy_table(G.C.SET.RCode), 0.3),
                      w = 4.5,
                      h = 1,
                      max_length = 24,
                      extended_corpus = true,
                      prompt_text = localize("cry_code_hand"),
                      ref_table = G,
                      ref_value = "ENTERED_HAND",
                      keyboard_offset = 1,
                  }),
              },
          },
          {
              n = G.UIT.R,
              nodes = {
                  UIBox_button({
                      colour = HEX("FF0000"),
                      button = "sudo_apply",
                      label = { localize("entr_code_sudo") },
                      minw = 4.5,
                      focus_args = { snap_to = true },
                  }),
              },
          },
          {
              n = G.UIT.R,
              nodes = {
                  UIBox_button({
                      colour = HEX("FF0000"),
                      button = "sudo_apply_previous",
                      label = { localize("entr_code_sudo_previous") },
                      minw = 4.5,
                      focus_args = { snap_to = true },
                  }),
              },
          },
          {
              n = G.UIT.R,
              nodes = {
                  UIBox_button({
                      colour = G.C.RED,
                      button = "sudo_cancel",
                      label = { localize("cry_code_cancel") },
                      minw = 4.5,
                      focus_args = { snap_to = true },
                  }),
              },
          },
      },
  })
  return t
end
G.FUNCS.sudo_apply_previous = function()
  if G.PREVIOUS_ENTERED_HAND then
      G.ENTERED_HAND = G.PREVIOUS_ENTERED_HAND or ""
  end
  G.FUNCS.sudo_apply()
end
G.FUNCS.sudo_apply = function()
  local hand_table = {
      ["High Card"] = { "high card", "high", "1oak", "1 of a kind", "haha one" },
      ["Pair"] = { "pair", "2oak", "2 of a kind", "m" },
      ["Two Pair"] = { "two pair", "2 pair", "mm", "pairpair" },
      ["Three of a Kind"] = { "three of a kind", "3 of a kind", "3oak", "trips", "triangle" },
      ["Straight"] = { "straight", "lesbian", "gay", "bisexual", "asexual" },
      ["Flush"] = { "flush", "skibidi", "toilet", "floosh" },
      ["Full House"] = {
          "full house",
          "full",
          "that 70s show",
          "modern family",
          "family matters",
          "the middle",
      },
      ["Four of a Kind"] = {
          "four of a kind",
          "4 of a kind",
          "4oak",
          "22oakoak",
          "quads",
          "four to the floor",
      },
      ["Straight Flush"] = { "straight flush", "strush", "slush", "slushie", "slushy" },
      ["Five of a Kind"] = { "five of a kind", "5 of a kind", "5oak", "quints" },
      ["Flush House"] = { "flush house", "flouse", "outhouse" },
      ["Flush Five"] = { "flush five", "fish", "you know what that means", "five of a flush" },
      ["cry_Bulwark"] = { "bulwark", "flush rock", "stoned", "stone flush", "flush stone" },
      ["cry_Clusterfuck"] = { "clusterfuck", "fuck", "wtf" },
      ["cry_UltPair"] = { "ultimate pair", "ultpair", "ult pair", "pairpairpair" },
      ["cry_WholeDeck"] = { "the entire fucking deck", "deck", "tefd", "fifty-two", "you are fuck deck" },
  }
  local current_hand = nil
  for k, v in pairs(SMODS.PokerHands) do
      local index = v.key
      local current_name = G.localization.misc.poker_hands[index]
      if not hand_table[v.key] then
          hand_table[v.key] = { current_name }
      end
  end
  for i, v in pairs(hand_table) do
      for j, k in pairs(v) do
          if string.lower(G.ENTERED_HAND) == string.lower(k) then
              current_hand = i
          end
      end
  end
  if current_hand == "cry_WholeDeck" then current_hand = nil end
  if current_hand then
      G.PREVIOUS_ENTERED_HAND = G.ENTERED_HAND
      local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
      G.FUNCS.get_poker_hand_info(G.hand.highlighted)
      if not G.GAME.SudoHand then G.GAME.SudoHand = {} end
      G.GAME.SudoHand[text] = current_hand
      G.FUNCS.sudo_cancel()
      return
  end
end
G.FUNCS.sudo_cancel = function()
  G.CHOOSE_HAND:remove()
  G.GAME.USING_CODE = false
  G.GAME.USINGSUDO = nil
end


G.FUNCS.cant_reroll_button = function(e)
    if (G.GAME.used_vouchers["v_retcon"] or
    (G.GAME.used_vouchers["v_directors_cut"] and not G.GAME.round_resets.boss_rerolled)) then 
        e.config.colour = G.C.RED
        e.config.button = 'dont_reroll_boss'
        e.children[1].children[1].config.shadow = true
    end
end

G.FUNCS.dont_reroll_boss = function(e) 
    stop_use()
    G.E_MANAGER:add_event(Event({
		trigger = "before",
		func = function()
			play_sound("cry_forcetrigger", 1, 0.6)
			return true
		end,
	}))
end

Cryptid.notifications.antireal = {
    nodes = function()
        return {
            n = G.UIT.R,
            config = {
                align = "cm",
                colour = empty and G.C.CLEAR or G.C.UI.BACKGROUND_WHITE,
                r = 0.1,
                padding = 0.04,
                minw = 2,
                minh = 0.8,
                emboss = not empty and 0.05 or nil,
                filler = true,
            },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm", padding = 0.03 },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0 },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = localize("cry_notif_antireal_d1"),
                                        scale = 0.5,
                                        colour = G.C.BLACK,
                                    },
                                },
                            },
                        },
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0 },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = localize("cry_notif_antireal_d2"),
                                        scale = 0.5,
                                        colour = G.C.BLACK,
                                    },
                                },
                            },
                        },
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0 },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = localize("cry_notif_antireal_d3"),
                                        scale = 0.5,
                                        colour = G.C.BLACK,
                                    },
                                },
                            },
                        },
                    },
                },
            },
        }
    end,
    cta = {
        label = "k_disable_music",
    },
}

G.FUNCS.notif_antireal = function()
    Entropy.config.freebird = false
    G:save_settings()
    G.FUNCS:exit_overlay_menu()
    -- todo: autosave settings (Not sure if this autosaves it)
end

G.FUNCS.can_toggle_path = function(e)
    local c1 = e.config.ref_table
    if
        not G.GAME.round_resets.path_toggled
    then
        e.config.colour = G.C.PURPLE
        e.config.button = "toggle_path"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.toggle_path = function(e)
    G.GAME.round_resets.path_toggled = true
    G.GAME.entr_alt = not G.GAME.entr_alt
    G.GAME.round_resets.blind_choices.Boss = get_new_boss()
    ease_background_colour{new_colour = G.GAME.entr_alt and G.C.ALTBG or G.C.BLIND['Small'], contrast = 1}
    G.ARGS.spin.real = (G.SETTINGS.reduced_motion and 0 or 1)*(G.GAME.entr_alt and 0.3 or -0.3)
end

local ref = G.UIDEF.challenge_description
function G.UIDEF.challenge_description(id, ...)
    if id == "daily" then 
        Entropy.UpdateDailySeed()
        Entropy.GetDailyChallenge() 
    end
    return ref(id, ...)    
end
local idref = get_challenge_int_from_id
function get_challenge_int_from_id(_id)
    if _id == "daily" then return "daily" end
    return idref(_id)
end
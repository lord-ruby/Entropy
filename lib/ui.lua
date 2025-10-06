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
        outline_colour = G.C.Entropy.Command,
        contents = {
            {
                n = G.UIT.R,
                nodes = {
                    create_text_input({
                        colour = G.C.Entropy.Command,
                        hooked_colour = darken(copy_table(G.C.Entropy.Command), 0.3),
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
                        colour = G.C.Entropy.Command,
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

if SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load then
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
    SMODS.calculate_context{entr_path_changed = true, on_alt_path = G.GAME.entr_alt}
    play_sound("highlight2")
    play_sound("glass6")
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

G.FUNCS.can_reserve_card = function(e)
    local c1 = e.config.ref_table
    if
        #G.consumeables.cards
        < G.consumeables.config.card_limit + (Cryptid.safe_get(c1, "edition", "negative") and 1 or 0)
        and Entropy.can_be_pulled(c1)
    then
        e.config.colour = G.C.GREEN
        e.config.button = "reserve_card"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS.reserve_card = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.1,
        func = function()
            c1.area:remove_card(c1)
            c1:add_to_deck()
            if c1.children.price then
                c1.children.price:remove()
            end
            c1.children.price = nil
            if c1.children.buy_button then
                c1.children.buy_button:remove()
            end
            c1.children.buy_button = nil
            remove_nils(c1.children)
            G.consumeables:emplace(c1)
            SMODS.calculate_context({ pull_card = true, card = c1 })
            G.GAME.pack_choices = G.GAME.pack_choices - 1
            if G.GAME.pack_choices <= 0 then
                G.FUNCS.end_consumeable(nil, delay_fac)
            end
            return true
        end,
    }))
end
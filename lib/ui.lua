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
                print(t)
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
  local base_enh = G.hand.highlighted[1].config.center.key
  local enh_table = {
      m_bonus = { "bonus" },
      m_mult = { "mult", "red" },
      m_wild = { "wild", "suit" },
      m_glass = { "glass", "xmult" },
      m_steel = { "steel", "metal", "grey" },
      m_stone = { "stone", "chip", "chips" },
      m_gold = { "gold", "money", "yellow" },
      m_lucky = { "lucky", "rng" },
      m_cry_echo = { "echo", "retrigger", "retriggers" },
      m_cry_light = { "light" },
      c_base = {"base", "default", "none"},
      ccd = { "ccd" },
      null = { "nil" },
  }

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
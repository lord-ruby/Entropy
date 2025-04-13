SMODS.Atlas { key = 'miscc', path = 'other_consumables.png', px = 71, py = 95 }

Entropy.FlipsideInversions = {
    --spectrals
    ["c_cry_gateway"] = "c_entr_beyond",
    ["c_soul"] = "c_entr_fervour",
    --tarots
    --["c_fool"] = "c_entr_fool",
    --planets
    ["c_cry_white_hole"] = "c_entr_pulsar",
    ["c_black_hole"] = "c_entr_quasar",
    --code
    ["c_cry_crash"] = "c_entr_memory_leak",
    ["c_cry_payload"] = "c_entr_root_kit",
    ["c_cry_run"] = "c_entr_break",
    ["c_cry_oboe"] = "c_entr_overflow",
    ["c_cry_spaghetti"] = "c_entr_cookies",
    ["c_cry_merge"] = "c_entr_fork",
    ["c_cry_divide"] = "c_entr_increment",
    ["c_cry_multiply"] = "c_entr_decrement",
    ["c_cry_rework"] = "c_entr_refactor",
    ["c_cry_ctrl_v"] = "c_entr_ctrl_x",
    ["c_cry_exploit"] = "c_entr_sudo",
    ["c_cry_commit"] = "c_entr_push",
    ["c_cry_machinecode"] = "c_entr_segfault",
    ["c_cry_malware"] = "c_entr_interference",
    ["c_cry_variable"] = "c_entr_constant",
    ["c_cry_semicolon"] = "c_entr_new",
    ["c_cry_inst"] = "c_entr_multithread",
    ["c_cry_delete"] = "c_entr_invariant",
    ["c_cry_class"] = "c_entr_inherit",
    ["c_cry_alttab"] = "c_entr_autostart",
    ["c_cry_revert"] = "c_entr_quickload",
    ["c_cry_patch"] = "c_entr_hotfix",
    ["c_cry_seed"] = "c_entr_pseudorandom",
    ["c_cry_reboot"] = "c_entr_bootstrap",
    ["c_cry_pointer"] = "c_entr_define"
}
SMODS.Consumable({
    key = "flipside",
    set = "Spectral",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {
        extra = {
            selected = 1
        }
    },
    immutable = true,
    name = "entr-Flipside",
    pos = {x=3,y=0},
    use = function(self, card, area, copier)
            local c, a, i = GetSelectedConsumable()
                    if c and c.config.center and (Entropy.FlipsideInversions[c.config.center.key] or (c.ability and Entropy.FlipsideInversions[GetID(c.ability.name)])) then
                        local card
                        if a.config.type == "hand" then
                            a.highlighted[i]:set_ability(G.P_CENTERS[Entropy.FlipsideInversions[GetID(c.ability.name)]], true, nil)
                            return
                        else
                            if a.config.type == "shop" then card = CreateShopInversion(Entropy.FlipsideInversions[c.config.center.key], c.config.center.set, a)
                            else card = create_card(c.config.center.set, a, nil, nil, nil, nil, Entropy.FlipsideInversions[c.config.center.key], 'sho') end
                            card:add_to_deck()
                            a:emplace(card)
                            c:start_dissolve()
                            return
                        end
                    end
    end,
    can_use = function(self, card)
        return GetSelectedConsumable() ~= nil and (Entropy.FlipsideInversions[GetSelectedConsumable().config.center.key] or (GetSelectedConsumable().ability and Entropy.FlipsideInversions[GetID(GetSelectedConsumable().ability.name)]))
	end,
    loc_vars = function(self, q, card)
        return {vars = {
            card.ability.extra.selected > 1 and "up to " or "",
            card.ability.extra.selected,
            card.ability.extra.selected > 1 and " selected cards " or " selected card ",
        }}
    end
})
local banned_sets ={
    ["Joker"]=true,
    ["Voucher"]=true,
    ["Booster"]=true
}
function GetID(id)
    for i, v in pairs(G.P_CENTERS) do if v.name == id then return i end end
    return id
end
function GetSelectedConsumable()
    if #G.hand.highlighted > 0 then
        for i, v in pairs(G.hand.highlighted) do
            if v.ability.consumeable and GetID(v.ability.name) ~= "c_entr_flipside" then
                return v, G.hand, i
            end
        end
    end
    if G.pack_cards and #G.pack_cards.highlighted > 0 then
        for i, v in pairs(G.pack_cards.highlighted) do
            if v.config.center.name ~= "entr-flipside" and not banned_sets[v.config.center.set] then
                return v, G.pack_cards, i
            end
        end
    end
    if G.shop_jokers and #G.shop_jokers.highlighted > 0 then
        for i, v in pairs(G.shop_jokers.highlighted) do
            if v.config.center.name ~= "entr-flipside" and not banned_sets[v.config.center.set] then
                return v, G.shop_jokers, i
            end
        end
    end
    if #G.consumeables.highlighted > 0 then
        for i, v in pairs(G.consumeables.highlighted) do
            if v.config.center.name ~= "entr-flipside" then
                return v, G.consumeables, i
            end
        end
    end
    return nil
end
function GetHighlightedConsumables()
    local total  = 0
    if #G.consumeables.highlighted > 0 then
        for i, v in pairs(G.consumeables.highlighted) do
            if v.config.center.name ~= "entr-flipside" then
                total = total + 1
            end
        end
    end
    if G.shop_jokers and #G.shop_jokers.highlighted > 0 then
        for i, v in pairs(G.shop_jokers.highlighted) do
            if v.config.center.name ~= "entr-flipside" and not banned_sets[v.config.center.set] then
                total = total + 1
            end
        end
    end
    if G.pack_cards and #G.pack_cards.highlighted > 0 then
        for i, v in pairs(G.pack_cards.highlighted) do
            if v.config.center.name ~= "entr-flipside" and not banned_sets[v.config.center.set] then
                total = total + 1
            end
        end
    end
    return total
end
function CreateShopInversion(key, set, area)

    local forced_tag = nil
    for k, v in ipairs(G.GAME.tags) do
      if not forced_tag then
        forced_tag = v:apply_to_run({type = 'store_joker_create', area = area})
        if forced_tag then
          for kk, vv in ipairs(G.GAME.tags) do
            if vv:apply_to_run({type = 'store_joker_modify', card = forced_tag}) then break end
          end
          return forced_tag end
      end
    end
          local card = create_card(set, area, nil, nil, nil, nil, key, 'sho')
          create_shop_card_ui(card, set, area)
          G.E_MANAGER:add_event(Event({
              func = (function()
                  for k, v in ipairs(G.GAME.tags) do
                    if v:apply_to_run({type = 'store_joker_modify', card = card}) then break end
                  end
                  return true
              end)
          }))
          return card
end
function HasFlipside()
    Entropy.ReverseFlipsideInversions()
    if G.consumeables and G.consumeables.cards then for i, v in pairs(G.consumeables.cards) do if v.config.center.name == "entr-Flipside" then return true end end end
    if G.pack_cards and G.pack_cards.cards then for i, v in pairs(G.pack_cards.cards) do if v.config.center.name == "entr-Flipside" then return true end end end
    --ccd support
    if G.deck and G.deck.cards then for i, v in pairs(G.deck.cards) do if v.ability.consumeable and v.ability.name == "entr-Flipside" then return true end end end
    if G.hand and G.hand.cards then for i, v in pairs(G.hand.cards) do if v.ability.consumeable and v.ability.name == "entr-Flipside" then return true end end end
end

G.FUNCS.can_reserve_joker = function(e)
    local c1 = e.config.ref_table
    if
        #G.jokers.cards
        < G.jokers.config.card_limit + (Cryptid.safe_get(c1, "edition", "negative") and 1 or 0)
    then
        e.config.colour = G.C.GREEN
        e.config.button = "reserve_joker"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS.reserve_joker = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.1,
        func = function()
            local c2 = copy_card(c1, nil, nil, true, false)
            c1:remove()
            c2:add_to_deck()
            G.jokers:emplace(c2)
            SMODS.calculate_context({ pull_card = true, card = c1 })
            return true
        end,
    }))
end

G.FUNCS.can_open_booster = function(e)
    if
        not G.pack_cards or #G.pack_cards.cards <= 0
    then
        e.config.colour = G.C.GREEN
        e.config.button = "open_booster"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS.open_booster = function(e)
    local c1 = e.config.ref_table
    G.GAME.DefineBoosterState = G.STATE
    delay(0.1)
    if c1.ability.booster_pos then G.GAME.current_round.used_packs[c1.ability.booster_pos] = 'USED' end
    --draw_card(G.hand, G.play, 1, 'up', true, card, nil, true) 
    if not c1.from_tag then 
      G.GAME.round_scores.cards_purchased.amt = G.GAME.round_scores.cards_purchased.amt + 1
    end
    if c1.RPerkeoPack then
        G.RPerkeoPack = true
    end
    if G.blind_select then
        G.blind_select:remove()
        G.blind_prompt_box:remove()
    end
    if c1.edition and c1.edition.negative and c1.area == G.consumeables then
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
    end
    e.config.ref_table.cost = 0
    e.config.ref_table:open()
    --c1:remove()
end

G.FUNCS.can_open_voucher = function(e)
    local c1 = e.config.ref_table
    e.config.colour = G.C.GREEN
    e.config.button = "open_voucher"
end
G.FUNCS.open_voucher = function(e)
    local c1 = e.config.ref_table
    c1.cost = 0
    c1:redeem()
    c1:start_dissolve()
    c1:remove()
end

G.FUNCS.can_reserve_booster = function(e)
    local c1 = e.config.ref_table
    if
        #G.consumeables.cards
        < G.consumeables.config.card_limit + (Cryptid.safe_get(c1, "edition", "negative") and 1 or 0)
    then
        e.config.colour = G.C.GREEN
        e.config.button = "reserve_booster"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS.reserve_booster = function(e)
    local c1 = e.config.ref_table
    --G.GAME.DefineBoosterState = G.STATE
    --c1:open()
    G.pack_cards:remove_card(c1)
    G.consumeables.cards[#G.consumeables.cards + 1] = c1
    c1.area = G.consumeables
    c1.parent = G.consumeables
    c1.layered_parallax = G.consumeables.layered_parallax
    G.consumeables:set_ranks()
    G.consumeables:align_cards()

    SMODS.calculate_context({ pull_card = true, card = c1 })
    G.GAME.pack_choices = G.GAME.pack_choices - 1
    if G.GAME.pack_choices <= 0 then
        G.FUNCS.end_consumeable(nil, delay_fac)
    end
    --c1:remove()
end


G.FUNCS.can_reserve_card_to_deck = function(e)
    local c1 = e.config.ref_table
    e.config.colour = G.C.GREEN
    e.config.button = "reserve_card_to_deck"
end
G.FUNCS.reserve_card_to_deck = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.1,
        func = function()
            local c2 = copy_card(c1, nil, nil, true, false)
            c1:remove()
            c2:add_to_deck()
			table.insert(G.playing_cards, c2)
			G.deck:emplace(c2)
			playing_card_joker_effects({ c2 })
            SMODS.calculate_context({ pull_card = true, card = c1 })
            return true
        end,
    }))
end
--som
local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local abc = G_UIDEF_use_and_sell_buttons_ref(card)
	-- Allow code cards to be reserved
	if (card.area == G.pack_cards and G.pack_cards) and (card.ability.consumeable) then --Add a use button
        if card.ability.set == "RCode" or not SMODS.OPENED_BOOSTER.draw_hand and card.children.front then
			return {
				n = G.UIT.ROOT,
				config = { padding = -0.1, colour = G.C.CLEAR },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							ref_table = card,
							r = 0.08,
							padding = 0.1,
							align = "bm",
							minw = 0.5 * card.T.w - 0.15,
							minh = 0.7 * card.T.h,
							maxw = 0.7 * card.T.w - 0.15,
							hover = true,
							shadow = true,
							colour = G.C.UI.BACKGROUND_INACTIVE,
							one_press = true,
							button = "use_card",
							func = card.ability.set == "RCode" and "can_reserve_card" or "can_reserve_card_to_deck",
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = card.ability.set == "RCode" and localize("b_pull")  or localize("b_select"),
									colour = G.C.UI.TEXT_LIGHT,
									scale = 0.55,
									shadow = true,
								},
							},
						},
					},
					{
						n = G.UIT.R,
						config = {
							ref_table = card,
							r = 0.08,
							padding = 0.1,
							align = "bm",
							minw = 0.5 * card.T.w - 0.15,
							maxw = 0.9 * card.T.w - 0.15,
							minh = 0.1 * card.T.h,
							hover = true,
							shadow = true,
							colour = G.C.UI.BACKGROUND_INACTIVE,
							one_press = true,
							button = "Do you know that this parameter does nothing?",
							func = "can_use_consumeable",
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("b_use"),
									colour = G.C.UI.TEXT_LIGHT,
									scale = 0.45,
									shadow = true,
								},
							},
						},
					},
					{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
					{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
					{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
					{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
					-- Betmma can't explain it, neither can I
				},
			}
		end
		if card.ability.name == "entr-Flipside" or G.RPerkeoPack then
			return {
				n = G.UIT.ROOT,
				config = { padding = -0.1, colour = G.C.CLEAR },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							ref_table = card,
							r = 0.08,
							padding = 0.1,
							align = "bm",
							minw = 0.5 * card.T.w - 0.15,
							minh = 0.7 * card.T.h,
							maxw = 0.7 * card.T.w - 0.15,
							hover = true,
							shadow = true,
							colour = G.C.UI.BACKGROUND_INACTIVE,
							one_press = true,
							button = "use_card",
							func = "can_reserve_card",
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("b_select_custom"),
									colour = G.C.UI.TEXT_LIGHT,
									scale = 0.55,
									shadow = true,
								},
							},
						},
					},
					{
						n = G.UIT.R,
						config = {
							ref_table = card,
							r = 0.08,
							padding = 0.1,
							align = "bm",
							minw = 0.5 * card.T.w - 0.15,
							maxw = 0.9 * card.T.w - 0.15,
							minh = 0.1 * card.T.h,
							hover = true,
							shadow = true,
							colour = G.C.UI.BACKGROUND_INACTIVE,
							one_press = true,
							button = "Do you know that this parameter does nothing?",
							func = "can_use_consumeable",
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("b_use"),
									colour = G.C.UI.TEXT_LIGHT,
									scale = 0.45,
									shadow = true,
								},
							},
						},
					},
					{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
					{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
					{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
					{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
					-- Betmma can't explain it, neither can I
				},
			}
		end
	end
    if (card.area == G.consumeables and G.consumeables and card.ability.set == "Booster") then
        sell = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card'}, nodes={
              {n=G.UIT.B, config = {w=0.1,h=0.6}},
              {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                  {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                  {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                }}
              }}
            }},
          }}
        use = 
        {n=G.UIT.C, config={align = "cr"}, nodes={
          
          {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'open_booster', func = 'can_open_booster'}, nodes={
            {n=G.UIT.B, config = {w=0.1,h=0.6}},
            {n=G.UIT.T, config={text = localize('b_open'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
          }}
        }}
        return {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  sell
                }},
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  use
                }},
              }},
          }}
    end
    if (card.area == G.hand and G.hand) then --Add a use button
		if card.ability.set == "Joker" then
			return  {
                n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
                  {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'reserve_joker', func = 'can_reserve_joker'}, nodes={
                    {n=G.UIT.T, config={text = localize('b_select'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
                  }},
              }}
		end
        if card.ability.set == "Booster" then
			return  {
                n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
                  {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'open_booster', func = 'can_open_booster'}, nodes={
                    {n=G.UIT.T, config={text = localize('b_open'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
                  }},
              }}
		end
        if card.ability.set == "Voucher" then
			return  {
                n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
                  {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'open_voucher', func = 'can_open_voucher'}, nodes={
                    {n=G.UIT.T, config={text = localize('b_redeem'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
                  }},
              }}
		end
	end
    if (card.area == G.consumeables and G.consumeables) and card.ability.set == "Voucher" then
        sell = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card'}, nodes={
              {n=G.UIT.B, config = {w=0.1,h=0.6}},
              {n=G.UIT.C, config={align = "tm"}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                  {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                  {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                }}
              }}
            }},
          }}
        use = 
        {n=G.UIT.C, config={align = "cr"}, nodes={
          
          {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'open_voucher', func = 'can_open_voucher'}, nodes={
            {n=G.UIT.B, config = {w=0.1,h=0.6}},
            {n=G.UIT.T, config={text = localize('b_redeem'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
          }}
        }}
        return {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  sell
                }},
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                  use
                }},
              }},
          }}
    end
    --let boosters not be recursive
    if (card.area == G.pack_cards and G.pack_cards) and card.ability.set == "Booster" then
        return  {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'reserve_booster', func = 'can_reserve_booster'}, nodes={
                {n=G.UIT.T, config={text = localize('b_select'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
              }},
          }}
    end
    --remove sell button if beyond exists in pack
    if
        (PackHasBeyond() or (PackHasGateway() and HasFlipside())) and card and card.config and card.config.center and card.config.center.set == "Joker"
    then
        table.remove(abc.nodes[1].nodes, 1)
    end
	return abc
end

function PackHasBeyond()
    if not G.pack_cards or not G.pack_cards.cards then return false end
    for i, v in pairs(G.pack_cards.cards) do
        if v.ability.name == "entr-Beyond" then return true end
    end
    return false
end

function PackHasGateway()
    if not G.pack_cards or not G.pack_cards.cards then return false end
    for i, v in pairs(G.pack_cards.cards) do
        if v.ability.name == "cry-Gateway" then return true end
    end
    return false
end
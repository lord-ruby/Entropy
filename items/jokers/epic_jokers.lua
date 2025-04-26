SMODS.Joker({
    key = "burnt_m",
    config = {
        per_jolly=1
    },
    rarity = "cry_epic",
    cost = 10,
    unlocked = true,

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 0 },
    atlas = "jokers",
    pools = { ["M"] = true },
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        if not center.edition or (center.edition and not center.edition.sol) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_solar
		end
        info_queue[#info_queue+1] = G.P_CENTERS.e_cry_m
        return {
            vars = {
                center.config.per_jolly
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then

            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            if next(poker_hands["Pair"]) then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                    G.play.cards[1]:set_edition("e_entr_solar")
                    return true
                end}))
                local jollycount = 0
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i]:is_jolly() then
                        jollycount = jollycount + 1
                    end
                end
                if jollycount > 0 then
                    for i = 2, 2+jollycount do
                        local card2 = G.play.cards[i]
                        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                            if card2 then card:set_edition("e_entr_solar") end
                            return true
                        end}))
                    end
                end
            end
        end
        if context.forcetrigger then
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                G.play.cards[1]:set_edition("e_entr_solar")
                return true
            end}))
            local jollycount = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i]:is_jolly() then
                    jollycount = jollycount + 1
                end
            end
            if jollycount > 0 then
                for i = 2, 2+jollycount do
                    local card2 = G.play.cards[i]
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                        if card2 then card:set_edition("e_entr_solar") end
                        return true
                    end}))
                end
            end
        end
	end
})

SMODS.Joker({
    key = "chaos",
    rarity = "cry_epic",
    cost = 15,
    unlocked = true,

    eternal_compat = true,
    pos = { x = 0, y = 1 },
    atlas = "jokers",
    loc_vars = function(self, info_queue, center)
    end,
})
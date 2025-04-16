return function()
    SMODS.PokerHand({
        key = "entr_All",
        visible = true,
        chips = to_big(848484848484):arrow(84,848484848484),
        mult = to_big(848484848484):arrow(84,848484848484),
        l_chips = to_big(848484848484):arrow(84,848484848484),
        l_mult = to_big(848484848484):arrow(84,848484848484),
        example = {
            { "S_A", true },
            { "H_A", true },
            { "C_A", true },
            { "D_A", true },
            --{ "cj_O_A", true },
            { "entr_nil_A", true },
            { "S_K", true },
            { "H_K", true },
            { "C_K", true },
            { "D_K", true },
            --{ "cj_O_K", true },
            { "entr_nil_K", true },
            { "S_Q", true },
            { "H_Q", true },
            { "C_Q", true },
            { "D_Q", true },
            --{ "cj_O_Q", true },
            { "entr_nil_Q", true },
            { "S_J", true },
            { "H_J", true },
            { "C_J", true },
            { "D_J", true },
            --{ "cj_O_J", true },
            { "entr_nil_J", true },
            { "S_T", true },
            { "H_T", true },
            { "C_T", true },
            { "D_T", true },
            --{ "cj_O_T", true },
            { "entr_nil_T", true },
            { "S_9", true },
            { "H_9", true },
            { "C_9", true },
            { "D_9", true },
            --{ "cj_O_9", true },
            { "entr_nil_9", true },
            { "S_8", true },
            { "H_8", true },
            { "C_8", true },
            { "D_8", true },
            --{ "cj_O_8", true },
            { "entr_nil_8", true },
            { "S_7", true },
            { "H_7", true },
            { "C_7", true },
            { "D_7", true },
            --{ "cj_O_7", true },
            { "entr_nil_7", true },
            { "S_6", true },
            { "H_6", true },
            { "C_6", true },
            { "D_6", true },
            --{ "cj_O_6", true },
            { "entr_nil_6", true },
            { "S_5", true },
            { "H_5", true },
            { "C_5", true },
            { "D_5", true },
            --{ "cj_O_5", true },
            { "entr_nil_5", true },
            { "S_4", true },
            { "H_4", true },
            { "C_4", true },
            { "D_4", true },
            --{ "cj_O_4", true },
            { "entr_nil_4", true },
            { "S_3", true },
            { "H_3", true },
            { "C_3", true },
            { "D_3", true },
            --{ "cj_O_3", true },
            { "entr_nil_3", true },
            { "S_2", true },
            { "H_2", true },
            { "C_2", true },
            { "D_2", true },
            --{ "cj_O_2", true },
            { "entr_nil_2", true },

            { "S_entr_nil", true },
            { "H_entr_nil", true },
            { "C_entr_nil", true },
            { "D_entr_nil", true },
            --{ "cj_O_entr_nil", true },
            { "entr_nil_entr_nil", true },
        },
        evaluate = function(parts, hand)
            if #hand >= 84 then
                local deck_booleans = {}
                local scored_cards = {}
                local cards = {}
                local amount = 0
                for i, card in ipairs(hand) do
                    if not cards[card.base.id.."of"..card.base.suit] then
                        cards[card.base.id.."of"..card.base.suit] = true
                        amount = amount + 1
                    end
                end
                if amount >= 84 then
                    return { scored_cards }
                end
            end
            return
        end,
    })
    local ref = Game.start_run
    function Game:start_run(args)
        ref(self, args)
        if not args.savetext then
            G.GAME.hands.entr_All.mult = to_big(848484848484):arrow(84,848484848484)
            G.GAME.hands.entr_All.l_mult = to_big(848484848484):arrow(84,848484848484)
            G.GAME.hands.entr_All.chips = to_big(848484848484):arrow(84,848484848484)
            G.GAME.hands.entr_All.l_chips = to_big(848484848484):arrow(84,848484848484)
        end
    end
end
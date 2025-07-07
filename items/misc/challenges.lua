local hyperbolic_chamber = {
	object_type = "Challenge",
	key = "hyperbolic_chamber",
	order = 1,
	rules = {
        custom = {
			{ id = "entr_starting_ante_mten" },
            { id = "entr_reverse_redeo" },
        }
	},
	restrictions = {
		banned_cards = {
			{ id = "c_cry_analog" },
		},
		banned_other = {
            { id = "bl_cry_joke", type = "blind" },
        },
	},
    jokers = {
		{ id = "j_cry_redeo", stickers = { "entr_aleph" } },
        { id = "j_entr_xekanos", stickers = { "entr_aleph" } },
	},
	deck = {
		type = "Challenge Deck",
	},
}

local gsr = Game.start_run
function Game:start_run(args)
        G.butterfly_jokers = CardArea(
            9999, 9999,
            0,
            0, 
            {card_limit = 9999, type = 'joker', highlight_limit = 0}
        )
	gsr(self, args)
	if G.GAME.modifiers.entr_starting_ante_mten and not args.savetext then
        ease_ante(-11, nil, true)
	end
    for i, v in pairs(G.butterfly_jokers.cards) do
        v:add_to_deck()
    end
    if Entropy.DeckOrSleeve("doc") then
        -- G.HUD:remove()
        -- G.HUD = nil
        -- G.HUD = UIBox{
        --     definition = create_UIBox_HUD(),
        --     config = {align=('cli'), offset = {x=-1.3,y=0},major = G.ROOM_ATTACH}
        -- }
        -- G.HUD_blind:remove()
        -- G.HUD_blind = UIBox{
        --     definition = create_UIBox_HUD_blind(),
        --     config = {major = G.HUD:get_UIE_by_ID('row_blind'), align = 'cm', offset = {x=0,y=-10}, bond = 'Weak'}
        -- }
        -- for i, v in pairs(G.hand_text_area) do
        --     G.hand_text_area[i] = G.HUD:get_UIE_by_ID(v.config.id)
        -- end
    end
    local saveTable = args.savetext or nil
    G.GAME.runes = {}
    if saveTable then
        local tags = saveTable.runes or {}
        for k, v in ipairs(tags) do
            local _tag = Tag('rune_entr_jera')
            _tag:load(v)
            add_rune(_tag, nil, true)
        end
    end
end

local set_abilityref = Card.set_ability
function Card:set_ability(center, initial, delay)
    set_abilityref(self, center, initial, delay)
    if (G.GAME.modifiers.entr_reverse_redeo or G.GAME.ReverseRedeo) and self.config.center.key == "j_cry_redeo" then
        self.ability.extra.ante_reduction = -1
    end
end

local change_ref = G.FUNCS.change_challenge_description
G.FUNCS.change_challenge_description = function(e)
    change_ref(e)
    local hyperbolic
    for i, v in ipairs(G.CHALLENGES) do
        if v.key == "c_entr_hyperbolic_chamber" then
            hyperbolic = i
        end
    end
    if e.config.id == hyperbolic then G.GAME.ReverseRedeo = true else G.GAME.ReverseRedeo = false end
end

return {
    items = {
        hyperbolic_chamber
    }
}
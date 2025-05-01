SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "RTarot",
	primary_colour = HEX("da7272"),
	secondary_colour = HEX("a54747"),
	collection_rows = { 4, 4 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_fool"
})
-- 0 - Fool -     Master (Coded)
-- 1 - Magician -     Carpenter
-- 2 - High Priestess -     Oracle
-- 3 - Empress -     Princess
-- 4 - Emperor -     Servant
-- 5 - Hierophant -     Heretic
-- 6 - Lovers -     Feud
-- 7 - Chariot -     Scar
-- 8 - Justice -     Dagger
-- 9 - Hermit -     Earl
-- 10 - Wheel of Fortune -     Whetstone
-- 11 - Strength -     Endurance
-- 12 - Hanged Man -     Advisor
-- 13 - Death -     Statue
-- 14 - Temperance -     Feast
-- 15 - Devil -     Companion
-- 16 - Tower -     Village
-- 17 - Star -     Ocean
-- 18 - Moon -     Forest
-- 19 - Sun -     Mountain
-- 20 - Judgement -     Forgiveness
-- 21 - World -     Tent
-- 23 - Eclipse -     Noon (Zenith) [Penumbra] {Umbra} <Bra> 'Shadow'
-- 29 - Seraph -     Imp
-- 29 - Instability -     Equality
-- 28 - Blessing -     Prophecy
-- 27 - Automaton -     Mallet
SMODS.Atlas { key = 'rtarot', path = 'reverse_tarots.png', px = 71, py = 95 }
local master = {
    key = "master",
    set = "RTarot",
    atlas = "rtarot",
    object_type = "Consumable",
    order = -901,
    dependencies = {
        items = {
            "set_entr_inversions"
        }
    },
    use = function(self, card, area, copier)
        local c = create_card(G.GAME.last_inversion.set, G.consumeables, nil, nil, nil, nil, G.GAME.last_inversion.key)
        G.GAME.last_inversion = nil
        c:add_to_deck()
        G.consumeables:emplace(c)
    end,
    can_use = function(self, card)
        return G.GAME.last_inversion
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                G.GAME.last_inversion and G.GAME.last_inversion.key or "None"
            }
        }
    end
}
local ref = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
    local card = e.config.ref_table
    if Entropy.FlipsideInversions[card.config.center.key] and not Entropy.FlipsidePureInversions[card.config.center.key] then
        G.GAME.last_inversion = {
            key = card.config.center.key,
            set = card.config.center.set
        }
    end
    ref(e, mute, nosave)
end
return {
    items = {
        master
    }
}
if (SMODS.Mods["TSpectrals"] or {}).can_load then
    AltTexture{
        key = 'entrspecs',
        set = 'Spectral',
        path = 'malverk/spectrans/other_consumables.png',
        original_sheet = true,
        keys = {
            "c_entr_flipside",
            "c_entr_lust",
            "c_entr_destiny",
            "c_entr_shatter",
            "c_entr_null",
            "c_entr_antithesis"
        }
    }
    
    AltTexture{
        key = 'entrspecs2',
        set = 'Spectral',
        path = 'malverk/spectrans/second_consumables.png',
        original_sheet = true,
        keys = {
            "c_entr_enchant"
        }
    }
    AltTexture{
        key = 'entrrunes',
        set = 'Spectral',
        path = 'malverk/spectrans/runes.png',
        soul = 'malverk/spectrans/runes.png',
        original_sheet = true,
        keys = {
            "c_entr_oss"
        }
    }

    local loadmodsref = SMODS.injectItems
    function SMODS.injectItems(...)
        loadmodsref(...)
        if G.P_CENTERS.c_entr_oss then  
            G.P_CENTERS.c_entr_oss.soul_pos = {x=4, y = 3}
        end
    end
    local set_abilityref = Card.set_ability
    function Card:set_ability(center, ...)
        if G.P_CENTERS.c_entr_oss.soul_pos and not G.P_CENTERS.c_entr_oss.soul_pos.soul_pos then
            G.P_CENTERS.c_entr_oss.soul_pos = {x = 4, y = 3}
        end
        set_abilityref(self, center, ...)
    end
end
SMODS.Atlas { 
    key = 'artbox_collectibles', 
    path = 'crossmod/artbox_collectibles.png', 
    px = 71, 
    py = 95
}
local c = {
    m_entr_flesh = { atlas = 'entr_artbox_collectibles', pos = { x = 0, y = 0 }, soul_pos = { x = 0, y = 1 }},
    m_entr_disavowed = { atlas = 'entr_artbox_collectibles', pos = { x = 1, y = 0 }, soul_pos = { x = 1, y = 1 }},
    m_entr_dark = { atlas = 'entr_artbox_collectibles', pos = { x = 2, y = 0 }, soul_pos = { x = 2, y = 1 }},
    m_entr_prismatic = { atlas = 'entr_artbox_collectibles', pos = { x = 3, y = 0 }, soul_pos = { x = 3, y = 1 }},
    m_entr_ceramic = { atlas = 'entr_artbox_collectibles', pos = { x = 4, y = 0 }, soul_pos = { x = 4, y = 1 }},

    entr_crimson = { atlas = 'entr_artbox_collectibles', pos = { x = 0, y = 2 }, soul_pos = { x = 0, y = 3 }},
    entr_sapphire = { atlas = 'entr_artbox_collectibles', pos = { x = 1, y = 2 }, soul_pos = { x = 1, y = 3 }},
    entr_silver = { atlas = 'entr_artbox_collectibles', pos = { x = 2, y = 2 }, soul_pos = { x = 2, y = 3 }, shader = "Voucher"},
    entr_pink = { atlas = 'entr_artbox_collectibles', pos = { x = 3, y = 2 }, soul_pos = { x = 3, y = 3 }},
    entr_verant = { atlas = 'entr_artbox_collectibles', pos = { x = 4, y = 2 }, soul_pos = { x = 4, y = 3 }},
    entr_cerulean = { atlas = 'entr_artbox_collectibles', pos = { x = 5, y = 2 }, soul_pos = { x = 5, y = 3 }},

    e_entr_neon = { atlas = 'entr_artbox_collectibles', pos = { x = 0, y = 4 }, soul_pos = { x = 0, y = 5 }, shader = "entr_neon"},
    e_entr_lowres = { atlas = 'entr_artbox_collectibles', pos = { x = 1, y = 4 }, soul_pos = { x = 0, y = 5 }, shader = "entr_lowres"},
    e_entr_sunny = { atlas = 'entr_artbox_collectibles', pos = { x = 2, y = 4 }, soul_pos = { x = 0, y = 5 }, shader = "entr_sunny"},
    e_entr_solar = { atlas = 'entr_artbox_collectibles', pos = { x = 3, y = 4 }, soul_pos = { x = 0, y = 5 }, shader = "entr_solar"},
    e_entr_fractured = { atlas = 'entr_artbox_collectibles', pos = { x = 4, y = 4 }, soul_pos = { x = 0, y = 5 }, shader = "entr_fractured"},
    e_entr_freaky = { atlas = 'entr_artbox_collectibles', pos = { x = 5, y = 4 }, soul_pos = { x = 3, y = 0 }, shader = "entr_freaky"},
    e_entr_kaleidoscopic = { atlas = 'entr_artbox_collectibles', pos = { x = 6, y = 4 }, soul_pos = { x = 0, y = 5 }, shader = "entr_kaleidoscopic"},
}
for i, v in pairs(c) do
    ArtBox.Collectables[i] = v
end
if (SMODS.Mods["malverk"] or {}).can_load then
	AltTexture({
		key = "rubycard",
		set = "Enhanced",
		path = "malverk/enhancements.png",
		loc_txt = {
			name = "Ruby Card",
		},
        original_sheet = true,
        keys = {
            "m_entr_prismatic"
        }
	})
    TexturePack({
    key = "rubycard",
    textures = {
        "entr_rubycard",
    },
    loc_txt = {
        name = "Ruby over Prismatic",
        text = {
            "Ruby card replaces Prismatic",
            "Art by Lil. Mr. Slipstream",
        },
    },
})
end
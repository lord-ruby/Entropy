local mod_path = "" .. SMODS.current_mod.path
Entropy.path = mod_path

assert(SMODS.load_file("lib/utils.lua"))()

local i = {
    "lib/colours",
    "lib/config",
    "lib/hooks",
    "lib/loader",
    "lib/ui",
    "lib/fixes",
    "lib/ascended",

    "items/misc/atlases",
    "items/misc/rarities",
    "items/misc/spectrals",
    "items/misc/content_sets",
    "items/misc/consumable_types",
    "items/misc/enhancements",
    "items/misc/seals",
    "items/misc/editions",
    "items/misc/sounds",
    "items/misc/tags",
    "items/misc/boosters",
    "items/misc/vouchers",
    "items/misc/decks",
    "items/misc/blinds",
    "items/misc/stakes",
    "items/misc/challenges",
    "items/misc/achievements",
    "items/misc/other",
    "items/misc/quips",

    --"items/jokers/cursed_jokers",
    "items/jokers/misc_jokers",
    --"items/jokers/epic_jokers",
    --"items/jokers/exotic_jokers",
    "items/jokers/rlegendary_jokers",
    "items/jokers/entropic_jokers",

    "items/jokers/dice_jokers",

    "items/inversions/reverse_tarots",
    "items/inversions/reverse_spectrals",
    "items/inversions/reverse_planets",
    "items/inversions/reverse_runes",
    --"items/inversions/reverse_codes",

    "items/misc/blind_tokens",
    --"items/inversions/define",

    "items/misc/dailies",

    "items/altpath/blinds",
    "items/misc/runes",

    "items/jokers/void_jokers",

    "compat/compat_loader"
}
Entropy.load_files(i)
Entropy.display_name = SMODS.current_mod.display_name
SMODS.current_mod.optional_features = {
	retrigger_joker = true,
    post_trigger = true,
}

if not Cryptid.mod_whitelist then Cryptid.mod_whitelist = {} end
Cryptid.mod_whitelist["Entropy"] = true
if not Cryptid.mod_gameset_whitelist then Cryptid.mod_gameset_whitelist = {} end
Cryptid.mod_gameset_whitelist["entr"] = true
Cryptid.mod_gameset_whitelist["Entropy"] = true

Entropy.update_daily_seed()

if Entropy.config.family_mode then
    Cryptid_config.family_mode = true
end

for i, category in pairs(Entropy.contents) do
    table.sort(category, function(a, b) return a.order < b.order end)
    for i2, item in pairs(category) do
        if not SMODS[item.object_type] then Entropy.fucker = item.object_type
        else
            SMODS[item.object_type](item)
            if item.init then item.init() end
        end
        item = nil
    end
    category = nil
end

if Cryptid.misprintize_value_blacklist then
    Cryptid.misprintize_value_blacklist.debuff_timer = false
    Cryptid.misprintize_value_blacklist.superego_copies = false
    Cryptid.misprintize_value_blacklist.entr_hotfix_rounds = false
    Cryptid.misprintize_value_blacklist.debuff_timer = false
    Cryptid.misprintize_value_blacklist.debuff_timer_max = false
    Cryptid.misprintize_value_blacklist.left = false
end
SMODS.current_mod.calculate = function(self, context)
    return Entropy.misc_calculations(self, context)
end
if G.P_CENTERS.e_negative then
    G.P_CENTERS.e_negative.no_doe = true
end

SMODS.current_mod.menu_cards = function()
    return {
        func = function()
            for i, v in pairs(G.title_top.cards) do
                if v.config.center.key == "c_cryptid" then
                    G.title_top:remove_card(v)
                    v:remove()
                end
                if v.base and v.base.value and v.base.value == "Ace" then
                    --G.title_top:remove_card(v)
                    --v:remove()
                    v:set_base()
                    v:set_ability(G.P_CENTERS.j_entr_title_card)
                    if v.children.front then
                        v.children.front:remove()
                        v.children.front = nil
                    end
                    math.randomseed(os.time())
                    if math.random() < 0.01 then
                        v:set_edition("e_entr_freaky") 
                    else
                        v:set_edition("e_entr_solar") 
                    end
                end
            end
        end,
    }
end

SMODS.Joker {
    key = "title_card",
    atlas = "titlecard",
    no_collection = true,
    in_pool = function() return false end,
    rarity = "entr_zenith",
    pos = {x=0, y=0},
    soul_pos = {x=1, y=0},
    no_doe = true,
    no_collection = true,
    display_size = { w = 122, h = 122 },
	in_pool = function()
		return false
	end,
    cry_order = 999999
}
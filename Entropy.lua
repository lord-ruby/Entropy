local mod_path = "" .. SMODS.current_mod.path
Entropy.path = mod_path

SMODS.load_file("lib/utils.lua")()

local i = {
    "lib/colours",
    "lib/config",
    "lib/hooks",
    "lib/loader",
    "lib/ui",
    "lib/fixes",

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

    --"items/jokers/cursed_jokers",
    "items/jokers/misc_jokers",
    --"items/jokers/epic_jokers",
    --"items/jokers/exotic_jokers",
    "items/jokers/rlegendary_jokers",
    --"items/jokers/entropic_jokers",
    "items/jokers/zenith_jokers",

    "items/jokers/dice_jokers",

    "items/inversions/reverse_tarots",
    "items/inversions/reverse_spectrals",
    "items/inversions/reverse_planets",
    --"items/inversions/reverse_codes",

    "items/misc/blind_tokens",
    --"items/inversions/define",

    "items/misc/dailies",

    "items/altpath/blinds",
    "items/misc/runes",

    "compat/partners",
    "compat/finity",
    "compat/malverk",
    "compat/cryptid",
    "compat/multiplayer",
    "compat/artbox"
}
Entropy.load_files(i)
SMODS.current_mod.optional_features = {
	retrigger_joker = true,
}

if not Cryptid.mod_whitelist then Cryptid.mod_whitelist = {} end
Cryptid.mod_whitelist["Entropy"] = true
if not Cryptid.mod_gameset_whitelist then Cryptid.mod_gameset_whitelist = {} end
Cryptid.mod_gameset_whitelist["entr"] = true
Cryptid.mod_gameset_whitelist["Entropy"] = true

Entropy.UpdateDailySeed()

if Entropy.config.family_mode then
    Cryptid_config.family_mode = true
end
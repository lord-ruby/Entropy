local i = {
    "compat/partners",
    "compat/finity",
    "compat/malverk",
    "compat/cryptid",
    "compat/multiplayer",
    "compat/artbox",
    "compat/thefamily",
    "compat/revosvault",
    "compat/aikoshen",
    "compat/tspectrals",
    "compat/grabbag",
    "compat/bunco"
    "compat/hotpotato"
}
Entropy.load_files(i)

if Penumbra then
    Penumbra.loc_keys["entr_music_entropic"] = "k_joker_in_greek"
    Penumbra.loc_keys["entr_music_red_room"] = "k_mirrored_in_crimson"
    Penumbra.loc_keys["entr_music_freebird"] = "k_freebird"
    Penumbra.loc_keys["entr_music_fall"] = "k_portal_reference"
    Penumbra.loc_keys["entr_music_entropy_is_endless"] = "k_entropy_is_endless"
end
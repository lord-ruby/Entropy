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
    "compat/bunco",
    "compat/hotpotato",
    "compat/vallkarri",
    "compat/blindside"
}
Entropy.load_files(i)

if Penumbra then
    Penumbra.register_track({key = "entr_music_entropic", loc_key = "k_joker_in_greek", author = "gemstonez"})
    Penumbra.register_track({key = "entr_music_red_room", loc_key = "k_mirrored_in_crimson", author = "lord.ruby"})
    Penumbra.register_track({key = "entr_music_freebird", loc_key = "k_freebird", author = "Lynyrd Skynyrd"})
    Penumbra.register_track({key = "entr_music_fall", loc_key = "k_portal_reference", author = "lord.ruby"})
    Penumbra.register_track({key = "entr_music_entropy_is_endless", loc_key = "k_entropy_is_endless", author = "gemstonez"})
    Penumbra.register_track({key = "entr_music_entropic_ominous", loc_key = "k_snd_ominous", author = "lord.ruby"})
end

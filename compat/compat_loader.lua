local i = {
    compat = {
        "partners",
        "finity",
        "malverk",
        "cryptid",
        "multiplayer",
        "artbox",
        "thefamily",
        "revosvault",
        "aikoshen",
        "tspectrals",
        "grabbag",
        "bunco",
        "hotpotato",
        "vallkarri",
        "blindside"
    }
}
Entropy.load_table(i)

if Penumbra then
    Penumbra.register_track({key = "entr_music_entropic", loc_key = "k_joker_in_greek", author = "gemstonez"})
    Penumbra.register_track({key = "entr_music_red_room", loc_key = "k_mirrored_in_crimson", author = "lord.ruby",icon_path = "assets/sounds/covers/redroomspiral.png"})
    Penumbra.register_track({key = "entr_music_freebird", loc_key = "k_freebird", author = "Lynyrd Skynyrd"})
    Penumbra.register_track({key = "entr_music_fall", loc_key = "k_ruby_reference", author = "lord.ruby", icon_path = "assets/sounds/covers/eeintro.png"})
    Penumbra.register_track({key = "entr_music_entropy_is_endless", loc_key = "k_entropy_is_endless", author = "gemstonez"})
    Penumbra.register_track({key = "entr_music_entropic_ominous", loc_key = "k_snd_ominous", author = "lord.ruby"})
    Penumbra.register_track({key = "entr_music_endless_entropy_is_verysexy", loc_key = "k_ee_goodmusic", author = "metanite64", icon_path = "assets/sounds/covers/eegood.png"})
    Penumbra.register_track({key = "entr_music_endless_entropy_is_verymean", loc_key = "k_ee_badmusic", author = "metanite64", icon_path = "assets/sounds/covers/eebad.png"})
end

if (SMODS.Mods["Blindside"] or {}).can_load then

    local files = {
        "compat/blindside/tags",
        "compat/blindside/blinds"
    }
    local items = Entropy.collect_files(files)

end
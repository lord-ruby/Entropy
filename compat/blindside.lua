if (SMODS.Mods["Blindside"] or {}).can_load then

    local files = {
        "compat/blindside/tags",
    }
    local items = Entropy.collect_files(files)

end
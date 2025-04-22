local Compatibilities = {
    {
        checkMod = "CorruptionMod", --change when corruption releases
        file = "corruption"
    }
}

function LoadCompatibilities()
    for i, v in pairs(Compatibilities) do
        if _G[v.checkMod] or v.checkMod == true then SMODS.load_file("compat/"..v.file..".lua", "entr")()() end
    end
end

local loadmodsref = SMODS.injectItems
function SMODS.injectItems(...)
    LoadCompatibilities()
    Entropy.FlipsidePureInversions = copy_table(Entropy.FlipsideInversions)
    --Entropy.RegisterBlinds()
    loadmodsref(...)
    SMODS.ObjectType({
        key = "Twisted",
        default = "j_entr_memory_leak",
        cards = {},
        inject = function(self)
            SMODS.ObjectType.inject(self)
            for i, v in pairs(Entropy.FlipsidePureInversions) do
                --if G.P_CENTERS[v] then self:inject_card(G.P_CENTERS[v]) end
            end
        end,
    })
    SMODS.ObjectTypes.Twisted:inject()
    Entropy.ReverseFlipsideInversions()
    for i, v in pairs(SMODS.ConsumableType.ctype_buffer) do
        if SMODS.ConsumableType.obj_table[v].hidden then table.remove(SMODS.ConsumableType.ctype_buffer, i) end
    end
end

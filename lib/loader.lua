local loadmodsref = SMODS.injectItems
function SMODS.injectItems(...)
    loadmodsref(...)
    Entropy.FlipsidePureInversions = copy_table(Entropy.FlipsideInversions)
    for i, v in pairs(Entropy.FlipsideInversions) do
        Entropy.FlipsideInversions[v]=i
    end
    G.ASSET_ATLAS["cry_gameset"] = Entropy.GamesetAtlas
end
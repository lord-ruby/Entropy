local i = {

}
local items = {}
for _, v in pairs(i) do
    local f, err = SMODS.load_file(v..".lua")
    if f then 
        local results = f() 
        if results then
            if results.init then results.init(results) end
            if results.items then
                for i, result in pairs(results.items) do
                    if not items[result.object_type] then items[result.object_type] = {} end
                    result.cry_order = result.order
                    items[result.object_type][#items[result.object_type]+1]=result
                end
            end
        end
    else error("error in file "..v..": "..err) end
end
for i, category in pairs(items) do
    table.sort(category, function(a, b) return a.order < b.order end)
    for i2, item in pairs(category) do
        if not SMODS[item.object_type] then print(item.object_type);Entropy.fucker = item.object_type
    else SMODS[item.object_type](item) end
    end
end
SMODS.current_mod.optional_features = {
	retrigger_joker = true,
}

Cryptid.mod_whitelist["Entropy"] = true
if not Cryptid.mod_gameset_whitelist then Cryptid.mod_gameset_whitelist = {} end
Cryptid.mod_gameset_whitelist["entr"] = true
Cryptid.mod_gameset_whitelist["Entropy"] = true

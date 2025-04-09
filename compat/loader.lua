--everything other than cryptid will go here
--loads after everything else so priority doesnt matter
--super snide remark but dont use infinity priority thats just stupid   
--and this system is proof that it doesnt matter

--feel free to copy the code in this file 1:1 no credit needed if you ever need to load after someone with an absurdly high priority

local Compatibilities = {
    --{
    --    checkMod = "ModGlobal",
    --    file = "filename no .lua" file must return a function
    --}
}

--hijack loading

math.randomseed(os.time())
Entropy.charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~#$^~#$^~#$^~#$^~#$^"
function srandom(length) 
    local total = ""
    for i = 0, length do
        local val = math.random(1,#Entropy.charset)
        total = total..(Entropy.charset:sub(val, val))
    end
    return total
end

--i doubt this whole section will ever be needed but this is an 
--extra failsafe to make sure we load last and no one can stop it
--no matter what they want to try and do
--if someone wants to be really really annoying about this ill just pretend to be cryptid instead
local obf_key = srandom(30)

function LoadCompatibilities()
    for i, v in pairs(Compatibilities) do
        if _G[v.checkMod] then SMODS.load_file("compat/"..v.file..".lua", obf_key)()() end
    end
end

local loadmodsref = SMODS.injectItems
function SMODS.injectItems()
    LoadCompatibilities()
    Deobfuscate()
    loadmodsref()
    Entropy.FlipsidePureInversions = copy_table(Entropy.FlipsideInversions)
    SMODS.ObjectType({
        key = "Twisted",
        default = "j_entr_memory_leak",
        cards = {},
        inject = function(self)
            SMODS.ObjectType.inject(self)
            for i, v in pairs(Entropy.FlipsidePureInversions) do
                self:inject_card(G.P_CENTERS[v])
            end
        end,
    })
    SMODS.ObjectTypes.Twisted:inject()
    Entropy.ReverseFlipsideInversions()
end


function Obfuscate()
    local mod = SMODS.Mods["entr"]
    SMODS.Mods["entr"] = nil
    SMODS.Mods[obf_key] = mod    
end
function Deobfuscate()
    local mod = SMODS.Mods[obf_key]
    SMODS.Mods[obf_key] = nil
    SMODS.Mods["entr"] = mod
end

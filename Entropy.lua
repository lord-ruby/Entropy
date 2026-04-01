local mod_path = "" .. SMODS.current_mod.path
Entropy.path = mod_path

assert(Spectrallib, "Please make sure Spectrallib is installed instead of Cryptlib\nhttps://github.com/SpectralPack/Spectrallib/")

assert(SMODS.load_file("lib/utils.lua"))()
assert(SMODS.load_file("lib/loader.lua"))()

local i = {
    lib = {
        "ascended", "colours", "config", 
        "fixes", "hooks", "ui"
    },
    items = {
        ".*"
    },
    compat = {
        "compat_loader",
    },
    order = {
        lib = 1,
        items = 2,
        compat = 3
    }
}
Entropy.load_table(i)
Entropy.display_name = SMODS.current_mod.display_name
SMODS.current_mod.optional_features = {
	retrigger_joker = true,
    post_trigger = true,
}

if not Spectrallib.mod_whitelist then Cryptid.mod_whitelist = {} end
Spectrallib.mod_whitelist["Entropy"] = true
if not Spectrallib.mod_gameset_whitelist then Cryptid.mod_gameset_whitelist = {} end
Spectrallib.mod_gameset_whitelist["entr"] = true
Spectrallib.mod_gameset_whitelist["Entropy"] = true

--Entropy.update_daily_seed()

if Entropy.config.family_mode then
    Cryptid_config.family_mode = true
end

for i, category in pairs(Entropy.contents) do
    table.sort(category, function(a, b) return a.order < b.order end)
    for i2, item in pairs(category) do
        if not SMODS[i] then Entropy.fucker = i
        else
            item.cry_order = item.order
            item.perishable_compat = item.perishable_compat or false
            item.blueprint_compat = item.blueprint_compat or false
            item.eternal_compat = item.eternal_compat or false
            item.order = nil
            SMODS[i](item)
        end
    end
end

if Spectrallib.misprintize_value_blacklist then
    Spectrallib.misprintize_value_blacklist.debuff_timer = false
    Spectrallib.misprintize_value_blacklist.superego_copies = false
    Spectrallib.misprintize_value_blacklist.entr_hotfix_rounds = false
    Spectrallib.misprintize_value_blacklist.debuff_timer = false
    Spectrallib.misprintize_value_blacklist.debuff_timer_max = false
    Spectrallib.misprintize_value_blacklist.left = false
end
SMODS.current_mod.calculate = function(self, context)
    local ret = {}
    for i, v in pairs({
        "misc_calculations"
    }) do
        local r = Entropy[v](self, context)
        if r then
            ret = SMODS.merge_effects({ret, r})
        end
    end
    return next(ret) and ret or nil
end
if G.P_CENTERS.e_negative then
    G.P_CENTERS.e_negative.no_doe = true
end

SMODS.current_mod.menu_cards = function()
    return {
        func = function()
            for i, v in pairs(G.title_top.cards) do
                if v.config.center.key == "c_cryptid" then
                    G.title_top:remove_card(v)
                    v:remove()
                end
                if v.base and v.base.value and v.base.value == "Ace" then
                    --G.title_top:remove_card(v)
                    --v:remove()
                    v:set_base()
                    G.P_CENTERS.j_entr_title_card.discovered = true
                    v:set_ability(G.P_CENTERS.j_entr_title_card)
                    if v.children.front then
                        v.children.front:remove()
                        v.children.front = nil
                    end
                    math.randomseed(os.time())
                    if math.random() < 0.01 then
                        v:set_edition("e_entr_freaky") 
                    else
                        v:set_edition("e_entr_solar") 
                    end
                end
            end
        end,
    }
end

SMODS.Joker {
    key = "title_card",
    atlas = "titlecard",
    no_collection = true,
    in_pool = function() return false end,
    rarity = "entr_zenith",
    pos = {x=0, y=0},
    soul_pos = {x=1, y=0},
    no_doe = true,
    no_collection = true,
    display_size = { w = 122, h = 122 },
	in_pool = function()
		return false
	end,
    cry_order = 999999,
    discovered = true,
    unlocked = true
}

Spectrallib.death_can_eternal = true
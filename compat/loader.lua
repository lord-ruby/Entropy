local Compatibilities = {
    {
        checkMod = "CorruptionMod", --change when corruption releases
        file = "corruption"
    },
    {
        checkMod="MP",
        file = "multiplayer"
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
    local results = Entropy.RegisterBlinds()
    local items = {}
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
    for i, category in pairs(items) do
        table.sort(category, function(a, b) return a.order < b.order end)
        for i2, item in pairs(category) do
            SMODS[item.object_type](item)
        end
    end
    SMODS.load_file("items/misc/content_sets.lua", "entr")()
    loadmodsref(...)
    SMODS.ObjectType({
        key = "Twisted",
        default = "j_entr_memory_leak",
        cards = {},
        inject = function(self)
            SMODS.ObjectType.inject(self)
            for i, v in pairs(Entropy.FlipsidePureInversions) do
                if G.P_CENTERS[v] then self:inject_card(G.P_CENTERS[v]) end
            end
        end,
    })
    SMODS.ObjectTypes.Twisted:inject()

    local references = {
        "j_hack",
        "j_four_fingers",
        "j_credit_card",
        "j_misprint",
        "j_raised_fist",
        "j_fibonacci",
        "j_pareidolia",
        "j_gros_michel",
        "j_business_card",
        "j_ride_the_bus",
        "j_space_joker",
        "j_egg",
        "j_runner",
        "j_ice_cream",
        "j_splash",
        "j_sixth_sense",
        "j_superposition",
        "j_cavendish",
        "j_card_sharp",
        "j_riff_raff",
        "j_midas_mask",
        "j_mail_in_rebate",
        "j_to_the_moon",
        "j_ancient_joker",
        "j_golden_ticket",
        "j_sock_and_buskin",
        "j_smeared_joker",
        "j_throwback",
        "j_hanging_chad",
        "j_flower_pot",
        "j_oops",
        "j_stuntman",
        "j_boostraps",
        "j_canio",
        "j_triboulet",
        "j_yorick",
        "j_chicot",
        "j_perkeo",
        "j_cry_m",
        "j_cry_happyhouse",
        "j_cry_jimball",
        "j_cry_googol_play",
        "j_cry_krustytheclown",
        "j_cry_membershipcard",
        "j_cry_oldcandy",
        "j_cry_mondrian",
        "j_cry_busdriver",
        "j_cry_membershipcardtwo",
        "j_cry_altgoogol",
        "j_cry_supercell",
        "j_cry_cryptidmoment",
        "j_cry_gardenfork",
        "j_cry_lightupthenight",
        "j_cry_nosound",
        "j_cry_antennastoheaven",
        "j_cry_chad",
        "j_cry_error",
        "j_cry_sus",
        "j_cry_waluigi",
        "j_cry_wario",
        "j_cry_pot_of_jokes",
        "j_cry_oil_lamp",
        "j_cry_tax_fraud",
        "j_cry_digitalhallucinations",
        "j_cry_lebaron_james",
        "j_cry_clicked_cookie",
        "j_cry_huntingseason",
        "j_cry_familiar_currency",
        "j_cry_fleshpanopticon",
        "j_cry_M",
        "j_cry_bubblem",
        "j_cry_foodm",
        "j_cry_mstack",
        "j_cry_neonm",
        "j_cry_notebook",
        "j_cry_bonk",
        "j_cry_loopy",
        "j_cry_scrabble",
        "j_cry_sacrifice",
        "j_cry_reverse",
        "j_cry_longboi",
        "j_cry_Megg",
        "j_cry_macabre",
        "j_cry_smallestm",
        "j_cry_virgo",
        "j_cry_doodlem",
        "j_cry_biggestm",
        "j_cry_jollysus",
        "j_cry_demicolon",
        "j_cry_stella_mortis",
        "j_cry_python",
        "j_cry_primus",
        "j_cry_circulus_pistoris",
        "j_entr_stillicidium",
        "j_entr_surreal_joker",
        "j_entr_xekanos",
        "j_entr_burnt_m",
        "j_entr_anaptyxi",
        "j_entr_chaos",
        "j_entr_strawberry_pie"
    }
    SMODS.ObjectType({
        key = "Reference",
        default = "j_hack",
        cards = {},
        inject = function(self)
            SMODS.ObjectType.inject(self)
            for i, v in pairs(references) do
                if G.P_CENTERS[v] then self:inject_card(G.P_CENTERS[v]) end
            end
            for i, v in pairs(Entropy.References) do
                if G.P_CENTERS[v] then self:inject_card(G.P_CENTERS[v]) end
            end
        end,
    })
    SMODS.ObjectTypes.Reference:inject()

    SMODS.ObjectType({
        key = "BlindTokens",
        default = "c_entr_bl_small",
        cards = {},
        inject = function(self)
            SMODS.ObjectType.inject(self)
            for i, v in pairs(Entropy.BlindC) do
                if G.P_CENTERS[v] then self:inject_card(G.P_CENTERS[v]) end
            end
        end,
    })
    SMODS.ObjectTypes.BlindTokens:inject()
    Entropy.ReverseFlipsideInversions()
    
end


if SMODS.Mods.DereJkr and SMODS.Mods.DereJkr.can_load then
    local set_spritesref = Card.set_sprites
    function Card:set_sprites(_center, _front)
        set_spritesref(self, _center, _front)
        if _center and ({
            j_entr_perkeo = true,
            j_entr_canio = true,
            j_entr_triboulet = true,
            j_entr_yorick = true,
            j_entr_chicot = true
        })[_center.key] then
            self.children.floating_sprite = Sprite(
                self.T.x,
                self.T.y,
                self.T.w * (self.no_ui and 1.1*1.2 or 1),
                self.T.h * (self.no_ui and 1.1*1.2 or 1),
                G.ASSET_ATLAS["Jokers-Legendere"],
                ({
                    j_entr_perkeo = {x=4,y=1},
                    j_entr_canio =  {x=0,y=1},
                    j_entr_triboulet = {x=1,y=1},
                    j_entr_yorick = {x=2,y=1},
                    j_entr_chicot = {x=3,y=1}
                })[_center.key]
            )
            self.children.floating_sprite.role.draw_major = self
            self.children.floating_sprite.states.hover.can = false
            self.children.floating_sprite.states.click.can = false
        end
    end
end
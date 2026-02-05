local loadmodsref = SMODS.injectItems
function SMODS.injectItems(...)
    if Entropy.config.blind_tokens then
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
    end    
    if Cryptid.pin_debuff then
        Cryptid.pin_debuff["entr_entropic"] = true
        Cryptid.pin_debuff["entr_reverse_legendary"] = true
    end
    loadmodsref(...)
    for i, v in pairs(G.P_TAGS) do
        if v.blindside then
            SMODS.ObjectTypes.bld_obj_blindside.cards[#SMODS.ObjectTypes.bld_obj_blindside.cards+1] = v.key
        end
    end
    G.ASSET_ATLAS["cry_gameset"] = Entropy.GamesetAtlas
    if StockingStuffer then StockingStuffer.Ruby.get_dummy = Entropy.GetDummy end
    if not G.entr_hooked then

        local oldfunc = Game.main_menu
        Game.main_menu = function(change_context)
            if not G.SAVED_GAME then 
                G.SAVED_GAME = get_compressed(G.SETTINGS.profile..'/'..'save.jkr')
                if G.SAVED_GAME ~= nil then G.SAVED_GAME = STR_UNPACK(G.SAVED_GAME) end
            end
            if G.SAVED_GAME and G.SAVED_GAME.GAME and G.SAVED_GAME.GAME.EEBuildup then
                G.GAME.EEBuildup = true
                G.E_MANAGER:add_event(Event{
                    trigger = "after",
                    blocking = false,
                    blockable = false,
                    delay = 0.25 * G.SETTINGS.GAMESPEED,
                    func = function()
                        G.GAME.EE_SCREEN = true 
                        G.GAME.EE_R = true
                        if not G.SPLASH_EE then
                        G.SPLASH_EE = Sprite(-30, -13, G.ROOM.T.w+60, G.ROOM.T.h+22, G.ASSET_ATLAS["ui_1"], {x = 9999, y = 0})
                        G.GAME.EE_FADE = 0
                        G.GAME.EE_FADE_SPEED = 10
                        G.E_MANAGER:add_event(Event{
                            trigger = "after",
                            blocking = false,
                            blockable = false,
                            delay = 0.25 * G.SETTINGS.GAMESPEED,
                            func = function()
                            G.GAME.EE_FADE = 0
                            G.SPLASH_EE:define_draw_steps({{
                                shader = 'entr_entropic_vortex',
                                send = {
                                {name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
                                {name = 'vort_speed', val = 1},
                                {name = 'colour_1', ref_table = G.C, ref_value = 'BLUE'},
                                {name = 'colour_2', ref_table = G.C, ref_value = 'WHITE'},
                                {name = 'mid_flash', val = 0},
                                {name = 'transgender', ref_table = G.GAME, ref_value = "EE_FADE"},
                                {name = 'vort_offset', val = (2*90.15315131*os.time())%100000},
                                }}}
                            )
                            return true
                            end
                        })
                        end
                        return true
                    end
                })
            else
                G.E_MANAGER:add_event(Event{
                    trigger = "after",
                    blocking = false,
                    blockable = false,
                    delay = 0.25 * G.SETTINGS.GAMESPEED,
                    func = function()
                        G.E_MANAGER:add_event(Event{
                            trigger = "after",
                            blocking = false,
                            blockable = false,
                            delay = 0.25 * G.SETTINGS.GAMESPEED,
                            func = function()
                                G.GAME.EE_SCREEN = nil
                                G.GAME.EE_R = true
                                return true
                            end
                        })
                        return true
                    end
                })
            end
            local ret = oldfunc(change_context)
            G.SPLASH_BACK:define_draw_steps({
                {
                    shader = "splash",
                    send = {
                        { name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                        { name = "vort_speed", val = 0.4 },
                        { name = "colour_1", ref_table = Entropy, ref_value = "entropic_gradient" },
                        { name = "colour_2", ref_table = Entropy, ref_value = "reverse_legendary_gradient" },
                    },
                },
            })
            return ret
        end

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
            "j_cry_python",
            "j_entr_surreal_joker",
            "j_entr_burnt_m",
            "j_entr_chaos",
            "j_entr_strawberry_pie",
            "j_entr_dr_sunshine",
            "j_entr_sunny_joker",
            "j_entr_rusty_shredder",
            "j_entr_chocolate_egg",
            "j_entr_devilled_suns",
            "j_entr_eden",
            "j_entr_seventyseven",
            "j_entr_dating_simbo",
            "j_entr_tenner",
            "j_entr_qu",
            "j_entr_memento_mori",
            "j_entr_milk_chocolate",
            "j_entr_insurance_fraud",
            "j_entr_chalice_of_blood",
            "j_entr_torn_photograph",
            "j_entr_feynman_point",
            "j_entr_jestradiol",
            "j_entr_menger_sponge",
            "j_entr_arbitration",
            "j_entr_d1",
            "j_entr_d4",
            "j_entr_d6",
            "j_entr_eternal_d6",
            "j_entr_d7",
            "j_entr_d8",
            "j_entr_d10",
            "j_entr_d12",
            "j_entr_d100",
            "j_entr_girldinner",
            "j_entr_gold_bar",
            "j_entr_prayer_card",
            "j_entr_petrichor",
            "j_entr_otherworldly_joker",
            "j_entr_error",
            "j_entr_thirteen_of_stars",
            "j_entr_prismatic_shard",
            "j_entr_redkey",
            "j_entr_deck_enlargement_pills",
            "j_entr_black_rose_green_sun",
            "j_entr_jack_off",
            "j_entr_antipattern",
            "j_entr_spiral_of_ants",
            "j_entr_fork_bomb",
            "j_entr_kintsugi",
            "j_entr_blooming_crimson",
            "j_entr_overpump",
            "j_entr_shadow_crystal",
            "j_entr_meridian",
            "j_entr_kitchenjokers",
            "j_entr_stand_arrow",
            "j_entr_magic_skin",
            "j_entr_lambda_calculus",
            "j_entr_mark_of_the_beast",
            "j_entr_dice_shard",
            "j_entr_nostalgic_d6"

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

        G.P_CENTERS.c_entr_bl_entr_alabaster_anchor.entr_credits = {idea = {"cassknows"}}
        G.P_CENTERS.c_entr_bl_entr_burgundy_baracuda.entr_credits = {idea = {"cassknows"}}
        G.P_CENTERS.c_entr_bl_entr_citrine_comet.entr_credits = {idea = {"cassknows"}}
        G.P_CENTERS.c_entr_bl_entr_diamond_dawn.entr_credits = {idea = {"cassknows"}}
        G.P_CENTERS.c_entr_bl_entr_olive_orchard.entr_credits = {idea = {"cassknows"}}

        G.P_CENTERS.c_entr_bl_entr_styx.entr_credits = {idea = {"cassknows"}}
        G.P_CENTERS.c_entr_bl_entr_choir.entr_credits = {idea = {"cassknows"}}
        G.P_CENTERS.c_entr_bl_entr_pandora.entr_credits = {idea = {"cassknows"}}
        G.P_CENTERS.c_entr_bl_entr_cassandra.entr_credits = {idea = {"cassknows"}}
        G.P_CENTERS.c_entr_bl_entr_labyrinth.entr_credits = {idea = {"cassknows"}}

        if MP then
            function MP.DECK.ban_card(card_id)
                if card_id:sub(1, 1) == "j" then
                    if not MP.DECK.BANNED_JOKERS then MP.DECK.BANNED_JOKERS = {} end
                    MP.DECK.BANNED_JOKERS[card_id] = true
                elseif card_id:sub(1, 1) == "c" then
                    if not MP.DECK.BANNED_CONSUMABLES then MP.DECK.BANNED_CONSUMABLES = {} end
                    MP.DECK.BANNED_CONSUMABLES[card_id] = true
                elseif card_id:sub(1, 1) == "v" then
                    if not MP.DECK.BANNED_VOUCHERS then MP.DECK.BANNED_VOUCHERS = {} end
                    MP.DECK.BANNED_VOUCHERS[card_id] = true
                elseif card_id:sub(1, 1) == "m" then
                    if not MP.DECK.BANNED_ENHANCEMENTS then MP.DECK.BANNED_ENHANCEMENTS = {} end
                    MP.DECK.BANNED_ENHANCEMENTS[card_id] = true
                end
            end
            sendDebugMessage("Entropy compatibility detected", "MULTIPLAYER")
            --MP.DECK.ban_card("j_entr_ruby")
            MP.DECK.ban_card("c_entr_new")
            for i, b in pairs(SMODS.Consumable.obj_table) do
                if b.set == "CBlind" then
                    MP.DECK.ban_card(b.key)
                end
            end
            MP.DECK.ban_card("j_entr_xekanos")
            MP.DECK.ban_card("j_entr_prayer_card")
            MP.DECK.ban_card("c_entr_raido")
        end
        for i, v in pairs(G.P_CENTERS) do
            if v.inversion then 
                Entropy.FlipsidePureInversions[v.inversion]=i 
                Entropy.FlipsideInversions[v.inversion]=i 
                Entropy.FlipsideInversions[i]=v.inversion
            end
        end
        for i, v in pairs(G.P_BLINDS) do
            if v.altpath then
                Entropy.AltBlinds[#Entropy.AltBlinds+1] = v
            end
        end
        SMODS.ObjectType({
            key = "Twisted",
            default = "c_entr_memory_leak",
            cards = {},
            inject = function(self)
                SMODS.ObjectType.inject(self)
                for i, v in pairs(Entropy.FlipsidePureInversions) do
                    if G.P_CENTERS[v] then self:inject_card(G.P_CENTERS[v]) end
                end
            end,
        })
        SMODS.ObjectTypes.Twisted:inject()
        SMODS.ObjectTypes.Sunny:inject()
        SMODS.ObjectType({
            key = "RedeemableBacks",
            default = "b_red",
            cards = {},
            inject = function(self)
                local cards = {
                    "b_entr_twisted",
                    --"b_entr_destiny",
                    "b_entr_ambisinister",
                    "b_entr_butterfly",
                    "b_entr_gemstone",
                    "b_entr_corrupted",
                    HotPotato and "b_hpot_lime" or nil,
                    HotPotato and "b_hpot_ublockdeck" or nil,
                    HotPotato and "b_hpot_domn" or nil,
                    HotPotato and "b_hpot_window" or nil,
                }
                SMODS.ObjectType.inject(self)
                for i, v in pairs(cards) do
                    self:inject_card(G.P_CENTERS[v])
                end
                self:inject_card(G.P_CENTERS.b_red)
                self:inject_card(G.P_CENTERS.b_blue)
                self:inject_card(G.P_CENTERS.b_yellow)
                self:inject_card(G.P_CENTERS.b_green)
                self:inject_card(G.P_CENTERS.b_black)
                self:inject_card(G.P_CENTERS.b_magic)
                self:inject_card(G.P_CENTERS.b_nebula)
                self:inject_card(G.P_CENTERS.b_ghost)
                self:inject_card(G.P_CENTERS.b_zodiac)
                self:inject_card(G.P_CENTERS.b_painted)
                self:inject_card(G.P_CENTERS.b_anaglyph)
                self:inject_card(G.P_CENTERS.b_plasma)
                self:inject_card(G.P_CENTERS.b_erratic)
                self:inject_card(G.P_CENTERS.b_abandoned)
                self:inject_card(G.P_CENTERS.b_checkered)
            end,
        })
        SMODS.ObjectTypes.RedeemableBacks:inject()
        G.entr_hooked = true
        SMODS.ObjectTypes.Dice:inject()
        if (SMODS.Mods["Cryptid"] or {}).can_load then
            Entropy.RareInversions[#Entropy.RareInversions+1] = "c_entr_define"
            Entropy.RareInversions[#Entropy.RareInversions+1] = "c_entr_pulsar"
            Entropy.RareInversions[#Entropy.RareInversions+1] = "c_entr_beyond"
        end
    end
    if Cryptid.add_circus_rarity then
        --true here as the last argument means dont reload localisation, only the last one needs to reload so its more optimised this way
        Cryptid.add_circus_rarity({rarity = "entr_entropic", base_mult = 50, order = 5, colour = Entropy.entropic_gradient}, true) 
        Cryptid.add_circus_rarity({rarity = "entr_reverse_legendary", base_mult = 4, order = 9999, colour = G.C.RARITY.Legendary, hidden=true})
    end
end

if SMODS.Mods.DereJkr and SMODS.Mods.DereJkr.can_load then
    local set_spritesref = Card.set_sprites
    function Card:set_sprites(_center, _front)
        set_spritesref(self, _center, _front)
        if _center and ({
            j_entr_oekrep = true,
            j_entr_oinac = true,
            j_entr_teluobirt = true,
            j_entr_kciroy = true,
            j_entr_tocihc = true
        })[_center.key] then
            self.children.floating_sprite = Sprite(
                self.T.x,
                self.T.y,
                self.T.w * (self.no_ui and 1.1*1.2 or 1),
                self.T.h * (self.no_ui and 1.1*1.2 or 1),
                G.ASSET_ATLAS["Jokers-Legendere"],
                ({
                    j_entr_oekrep = {x=4,y=1},
                    j_entr_oinac =  {x=0,y=1},
                    j_entr_teluobirt = {x=1,y=1},
                    j_entr_kciroy = {x=2,y=1},
                    j_entr_tocihc = {x=3,y=1}
                })[_center.key]
            )
            self.children.floating_sprite.role.draw_major = self
            self.children.floating_sprite.states.hover.can = false
            self.children.floating_sprite.states.click.can = false
        end
    end
end
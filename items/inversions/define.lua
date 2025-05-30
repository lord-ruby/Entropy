local define = {
    object_type = "Consumable",
    order = 2000 + 32,
    key = "define",
    inversion = "c_cry_pointer",
    pos = {x = 4, y = 4},
    dependencies = {
        items = {"set_entr_inversions"}
    },
    atlas = "consumables",
    set = "RSpectral",
    hidden=true,
    soul_rate = 0,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand, G.consumeables, G.jokers, G.shop_booster, G.pack_cards, G.shop_jokers, G.shop_vouchers}, card)
        return num > 0 and num <= 1
    end,

    use = function(self, card)
		G.GAME.USING_CODE = true
		G.GAME.USING_DEFINE = true
		G.ENTERED_CARD = ""
		G.CHOOSE_CARD = UIBox({
			definition = G.FUNCS.create_UIBox_define(card),
			config = {
				align = "cm",
				offset = { x = 0, y = 10 },
				major = G.ROOM_ATTACH,
				bond = "Weak",
				instance_type = "POPUP",
			},
		})
		G.CHOOSE_CARD.alignment.offset.y = 0
		G.ROOM.jiggle = G.ROOM.jiggle + 1
		G.CHOOSE_CARD:align_to_major()
    end,
    loc_vars = function()
        return {
            vars = {
                "#"
            }
        }
    end
}

G.FUNCS.create_UIBox_define = function(card)
    if not G.GAME.DefineKeys then
        G.GAME.DefineKeys = {}
    end
    G.E_MANAGER:add_event(Event({
        blockable = false,
        func = function()
            G.REFRESH_ALERTS = true
            return true
        end,
    }))
    local t = create_UIBox_generic_options({
        no_back = true,
        colour = HEX("04200c"),
        outline_colour = G.C.SET.RSpectral,
        contents = {
            {
                n = G.UIT.R,
                nodes = {
                    create_text_input({
                        colour = G.C.SET.RSpectral,
                        hooked_colour = darken(copy_table(G.C.SET.RSpectral), 0.3),
                        w = 4.5,
                        h = 1,
                        max_length = 100,
                        extended_corpus = true,
                        prompt_text = localize("cry_code_enter_card"),
                        ref_table = G,
                        ref_value = "ENTERED_CARD",
                        keyboard_offset = 1,
                    }),
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    UIBox_button({
                        colour = G.C.SET.RSpectral,
                        button = "define_apply",
                        label = { localize("cry_code_create") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    UIBox_button({
                        colour = G.C.SET.RSpectral,
                        button = "your_collection",
                        label = { localize("b_collection_cap") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    UIBox_button({
                        colour = G.C.RED,
                        button = "define_apply_previous",
                        label = { localize("cry_code_create_previous") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    UIBox_button({
                        colour = G.C.RED,
                        button = "define_cancel",
                        label = { localize("cry_code_cancel") },
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
        },
    })
    return t
end
G.FUNCS.define_cancel = function()
    G.CHOOSE_CARD:remove()
    G.GAME.USING_CODE = false
    G.GAME.USING_DEFINE = false
    G.DEBUG_DEFINE = false
    if G.GAME.define_in_pack then
        G.GAME.pack_choices = G.GAME.pack_choices - 1
        G.GAME.define_in_pack = nil
    end
end
G.FUNCS.define_apply_previous = function()
    if G.PREVIOUS_ENTERED_CARD then
        G.ENTERED_CARD = G.PREVIOUS_ENTERED_CARD or ""
    end
    G.FUNCS.define_apply()
end
G.FUNCS.define_apply = function()
    local current_card
    local cards = Entropy.GetHighlightedCards({G.hand, G.consumeables, G.jokers, G.shop_booster, G.pack_cards, G.shop_jokers, G.shop_vouchers})
    local entered_card = G.ENTERED_CARD

    G.PREVIOUS_ENTERED_CARD = G.ENTERED_CARD
    for i, v in pairs(Cryptid.pointeralias) do
        for i2, a in pairs(v or {}) do
            if entered_card == a then entered_card = i end
        end
    end
    for i, v in pairs(G.P_CENTERS) do
        if v.name and string.lower(entered_card) == string.lower(v.name) then
            current_card = i
        end
        if string.lower(entered_card or "") == string.lower(i) then
            current_card = i
        end
        if string.lower(entered_card or "") == string.lower(localize({ type = "name_text", set = v.set, key = i })) then
            current_card = i
        end
    end
    --Cryptid.pointerblisttype.rarity[]
    --eval local current_card = "e_entr_shatter"
    if not Entropy.DefineBlacklist[current_card] and not Cryptid.pointergetblist(current_card)[1] and G.P_CENTERS[current_card] and not Entropy.DefineBlacklist[G.P_CENTERS[current_card].set] then

        if cards[1].config.center.key == "j_obelisk" and entered_card == "j_cry_sob" then
            check_for_unlock({ type = "event_horizon" })
        end
        for i, card in ipairs(cards) do
            if card.config.center.set == "Default" then
                G.GAME.DefineKeys[card.base.name] = current_card
            else
                G.GAME.DefineKeys[card.config.center.key] = current_card
            end
            card:start_dissolve()
        end
        G.CHOOSE_CARD:remove()
        G.GAME.USING_CODE = false
        G.GAME.USING_DEFINE = false
        G.DEBUG_DEFINE = false
    else
        --try playing card
        local words = {}
				for i in string.gmatch(string.lower(entered_card), "%S+") do -- not using apply_lower because we actually want the spaces here
					table.insert(words, i)
				end

				local rank_table = {
					{ "stone" },
					{ "2", "Two", "II" },
					{ "3", "Three", "III" },
					{ "4", "Four", "IV" },
					{ "5", "Five", "V" },
					{ "6", "Six", "VI" },
					{ "7", "Seven", "VII" },
					{ "8", "Eight", "VIII" },
					{ "9", "Nine", "IX" },
					{ "10", "1O", "Ten", "X", "T" },
					{ "J", "Jack" },
					{ "Q", "Queen" },
					{ "K", "King" },
					{ "A", "Ace", "One", "1", "I" },
				} -- ty variable
				local _rank = nil
				for m = #words, 1, -1 do -- the legendary TRIPLE LOOP, checking from end since rank is most likely near the end
					for i, v in pairs(rank_table) do
						for j, k in pairs(v) do
							if words[m] == string.lower(k) then
								_rank = i
								break
							end
						end
						if _rank then
							break
						end
					end
					if _rank then
						break
					end
				end
				if _rank then -- a playing card is going to get created at this point, but we can find additional descriptors
					local suit_table = {
						["Spades"] = { "spades" },
						["Hearts"] = { "hearts" },
						["Clubs"] = { "clubs" },
						["Diamonds"] = { "diamonds" },
					}
					for k, v in pairs(SMODS.Suits) do
						local index = v.key
						local current_name = G.localization.misc.suits_plural[index]
						if not suit_table[v.key] then
							suit_table[v.key] = { string.lower(current_name) }
						end
					end
					-- i'd rather be pedantic and not forgive stuff like "spade", there's gonna be a lot of checks
					-- can change that if need be
					local enh_table = {
						["m_lucky"] = { "lucky" },
						["m_mult"] = { "mult" },
						["m_bonus"] = { "bonus" },
						["m_wild"] = { "wild" },
						["m_steel"] = { "steel" },
						["m_glass"] = { "glass" },
						["m_gold"] = { "gold" },
						["m_stone"] = { "stone" },
						["m_cry_echo"] = { "echo" },
					}
					for k, v in pairs(G.P_CENTER_POOLS.Enhanced) do
						local index = v.key
						local current_name = G.localization.descriptions.Enhanced[index].name
						current_name = current_name:gsub(" Card$", "")
						if not enh_table[v.key] then
							enh_table[v.key] = { string.lower(current_name) }
						end
					end
					local ed_table = {
						["e_base"] = { "base" },
						["e_foil"] = { "foil" },
						["e_holo"] = { "holo" },
						["e_polychrome"] = { "polychrome" },
						["e_negative"] = { "negative" },
						["e_cry_mosaic"] = { "mosaic" },
						["e_cry_oversat"] = { "oversat" },
						["e_cry_glitched"] = { "glitched" },
						["e_cry_astral"] = { "astral" },
						["e_cry_blur"] = { "blurred" },
						["e_cry_gold"] = { "golden" },
						["e_cry_glass"] = { "fragile" },
						["e_cry_m"] = { "jolly" },
						["e_cry_noisy"] = { "noisy" },
						["e_cry_double_sided"] = { "double-sided", "double_sided", "double" }, -- uhhh sure
					}
					for k, v in pairs(G.P_CENTER_POOLS.Edition) do
						local index = v.key
						local current_name = G.localization.descriptions.Edition[index].name
						if not ed_table[v.key] then
							ed_table[v.key] = { string.lower(current_name) }
						end
					end
					local seal_table = {
						["Red"] = { "red" },
						["Blue"] = { "blue" },
						["Purple"] = { "purple" },
						["Gold"] = { "gold", "golden" }, -- don't worry we're handling seals differently
						["cry_azure"] = { "azure" },
						["cry_green"] = { "green" },
					}
					local sticker_table = {
						["eternal"] = { "eternal" },
						["perishable"] = { "perishable" },
						["rental"] = { "rental" },
						["pinned"] = { "pinned" },
						["banana"] = { "banana" }, -- no idea why this evades prefixing
						["entr_pinned"] = { "rigged" },
						["cry_flickering"] = { "flickering" },
						["cry_possessed"] = { "possessed" },
						["cry_absolute"] = { "absolute" },
					}
					local function parsley(_table, _word)
						for i, v in pairs(_table) do
							for j, k in pairs(v) do
								if _word == string.lower(k) then
									return i
								end
							end
						end
						return ""
					end
					local function to_rank(rrank)
						if rrank <= 10 then
							return tostring(rrank)
						elseif rrank == 11 then
							return "Jack"
						elseif rrank == 12 then
							return "Queen"
						elseif rrank == 13 then
							return "King"
						elseif rrank == 14 then
							return "Ace"
						end
					end

					-- ok with all that fluff out the way now we can figure out what on earth we're creating

					local _seal_att = false
					local _suit = ""
					local _enh = ""
					local _ed = ""
					local _seal = ""
					local _stickers = {}

					for m = #words, 1, -1 do
						-- we have a word. figure out what that word is
						-- this is dodgy spaghetti but w/ever
						local wword = words[m]
						if _suit == "" then
							_suit = parsley(suit_table, wword)
						end
						if _enh == "" then
							_enh = parsley(enh_table, wword)
							if _enh == "m_gold" and _seal_att == true then
								_enh = ""
							end
						end
						if _ed == "" then
							_ed = parsley(ed_table, wword)
							if _ed == "e_cry_gold" and _seal_att == true then
								_ed = ""
							end
						end
						if _seal == "" then
							_seal = parsley(seal_table, wword)
							if _seal == "Gold" and _seal_att == false then
								_seal = ""
							end
						end
						local _st = parsley(sticker_table, wword)
						if _st then
							_stickers[#_stickers + 1] = _st
						end
						if wword == "seal" or wword == "sealed" then
							_seal_att = true
						else
							_seal_att = false
						end -- from end so the next word should describe the seal
                    end
                    for i, card in ipairs(cards) do
                        if card and card.config.center.set == "Default" then
                            G.GAME.DefineKeys[card.base.name] = {
                                ["playing_card"] = true,
                                ["_seal_att"] = _seal_att,
                                ["_suit"] = _suit,
                                ["_enh"] = _enh,
                                ["_ed"] = _ed,
                                ["_seal"] = _seal,
                                ["_stickers"] = stickers,
                                ["_rank"] = to_rank(_rank)

                            }
                        elseif card then
                            G.GAME.DefineKeys[card.config.center.key] = {
                                ["playing_card"] = true,
                                ["_seal_att"] = _seal_att,
                                ["_suit"] = _suit,
                                ["_enh"] = _enh,
                                ["_ed"] = _ed,
                                ["_seal"] = _seal,
                                ["_stickers"] = stickers,
                                ["_rank"] = to_rank(_rank)

                            }
                        end
                        if card then card:start_dissolve() end
                    end
                    G.CHOOSE_CARD:remove()
                    G.GAME.USING_CODE = false
                    G.GAME.USING_DEFINE = false
                    G.DEBUG_DEFINE = false
                end

    end
    if not G.GAME.USING_DEFINE then
        if G.GAME.define_in_pack then
            G.GAME.pack_choices = G.GAME.pack_choices - 1
            G.GAME.define_in_pack = nil
        end
    end
end

local set_abilityref = Card.set_ability
function Card:set_ability(center, initial, delay)
    if type(center) == "string" then center = G.P_CENTERS[center] end
    if not self.ability then self.ability = {} end
    if not self.ability.bonus then self.ability.bonus = 0 end
    if center and G.GAME.DefineKeys and G.GAME.DefineKeys[center.key] and not G.SETTINGS.paused then
        local definekey = G.GAME.DefineKeys[center.key or self.base.name]
        if type(definekey) == "table" and definekey.playing_card then
            set_abilityref(self, G.P_CENTERS[definekey._enh or "c_base"] or G.P_CENTERS["c_base"], initial, delay)
            SMODS.change_base(self, definekey._suit, definekey._rank)
            if definekey._ed ~= "" then self:set_edition(definekey._ed) end
            if definekey._seal ~= "" then self:set_seal(definekey._seal) end
        else    
            set_abilityref(self, G.P_CENTERS[definekey or ""] or center, initial, delay)
        end
        self.fromdefine = true
    else
        set_abilityref(self, center, initial, delay)
    end
end

local set_baseref = Card.set_base
function Card:set_base(card, initial)
    set_baseref(self, card, initial)
    local definekey = G.GAME.DefineKeys and G.GAME.DefineKeys[self.base.name] or nil
    if definekey then
        if type(definekey) == "table" and definekey.playing_card then
            set_abilityref(self, G.P_CENTERS[definekey._enh or "c_base"] or G.P_CENTERS["c_base"], initial, delay)
            SMODS.change_base(self, definekey._suit, definekey._rank)
            if definekey._ed ~= "" then self:set_edition(definekey._ed) end
            if definekey._seal ~= "" then self:set_seal(definekey._seal) end
        else  
            set_abilityref(self, G.P_CENTERS[definekey], initial, delay)
        end
        self.fromdefine = true
    end
end

local add_ref = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    if G.SETTINGS.paused or (not G.GAME.DefineKeys and not ((next(find_joker("j_entr_chaos")) or next(find_joker("j_entr_parakmi"))))) or G.GAME.akyrs_any_drag or (self == G.shop_jokers or self == G.shop_booster or self == G.shop_vouchers or self == G.pack_cards) then
        add_ref(self, card, location, stay_flipped)
    elseif card.fromdefine then
        local area = ({
            Default= G.hand,
            Enhanced = G.hand,
            Joker = G.jokers
        })[card.config.center.set] or G.consumeables
        if area then add_ref(area, card, location, stay_flipped) end
        if area == G.hand and G.hand then
            table.insert(G.playing_cards, card)
        end
    else
        add_ref(self, card, location, stay_flipped)
    end
end
return {
    items = {
        define
    }
}
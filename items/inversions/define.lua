local define = {
    object_type = "Consumable",
    order = 2000 + 32,
    key = "define",
    inversion = "c_cry_pointer",
    pos = {x = 4, y = 4},
    dependencies = {
        items = {"set_entr_inversions"}
    },
    no_select = true,
    atlas = "consumables",
    set = "Omen",
    hidden=true,
    soul_rate = 0,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand, G.consumeables, G.jokers, G.shop_booster, G.pack_cards, G.shop_jokers, G.shop_vouchers}, card, 1, 1)
        return num > 0 and num <= 1
    end,

    use = function(self, card)
        if not card.ability.cry_multiuse or to_big(card.ability.cry_multiuse) <= to_big(1) then
			G.GAME.CODE_DESTROY_CARD = copy_card(card)
			G.consumeables:emplace(G.GAME.CODE_DESTROY_CARD)
		else
			card.ability.cry_multiuse = card.ability.cry_multiuse + 1
		end
		G.GAME.USING_CODE = true
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.USING_DEFINE = true
                G.GAME.POINTER_COLLECTION = true
				G.FUNCS.overlay_menu({definition = create_UIBox_your_collection()})
				return true
			end
		}))
		G.GAME.POINTER_SUBMENU = nil
    end,
    init = function(self)
		local ccl = Card.click
		function Card:click()
			if G.GAME.USING_DEFINE then
				if not self.debuff then
					if self.config.center.key == "c_base" or self.config.center.set == "Enhanced" or self.edition or G.GAME.POINTER_SUBMENU == "Edition" then
						--submenu stuff
						if G.GAME.POINTER_SUBMENU == "Rank" then
							G.GAME.POINTER_PLAYING.rank = self.base.value
							G.FUNCS.overlay_menu{
								definition = create_UIBox_pointer_suit()
							}
						elseif G.GAME.POINTER_SUBMENU == "Suit" then
							G.GAME.POINTER_PLAYING.suit = self.base.suit
							G.FUNCS.overlay_menu{
								definition = create_UIBox_pointer_enhancement()
							}
						elseif G.GAME.POINTER_SUBMENU == "Enhancement" then
							G.GAME.POINTER_PLAYING.center = self.config.center.key
							G.FUNCS.overlay_menu{
								definition = create_UIBox_pointer_edition()
							}
						elseif G.GAME.POINTER_SUBMENU == "Edition" then
							if self.edition then
								G.GAME.POINTER_PLAYING.edition = self.edition.key
							end
							G.FUNCS.overlay_menu{
								definition = create_UIBox_pointer_seal()
							}
						elseif G.GAME.POINTER_SUBMENU == "Seal" then
							G.GAME.POINTER_PLAYING.seal = self.seal
                            if G.GAME.POINTER_PLAYING then
                                local cards = Entropy.GetHighlightedCards({G.hand, G.consumeables, G.jokers, G.shop_booster, G.pack_cards, G.shop_jokers, G.shop_vouchers}, {}, 1, 1)
                                for i, card in pairs(cards) do
                                    if card.config.center.set == "Default" or card.config.center.set == "Enhanced" then
                                        G.GAME.DefineKeys = G.GAME.DefineKeys or {}
                                        G.GAME.DefineKeys[card.base.name] = {
                                            ["playing_card"] = true,
                                            ["_suit"] = G.GAME.POINTER_PLAYING.suit,
                                            ["_enh"] = G.GAME.POINTER_PLAYING.center,
                                            ["_ed"] = G.GAME.POINTER_PLAYING.edition,
                                            ["_seal"] = G.GAME.POINTER_PLAYING.seal,
                                            ["_rank"] = G.GAME.POINTER_PLAYING.rank
                                        }
                                    else    
                                        G.GAME.DefineKeys[card.config.center.key] = {
                                            ["playing_card"] = true,
                                            ["_suit"] = G.GAME.POINTER_PLAYING.suit,
                                            ["_enh"] = G.GAME.POINTER_PLAYING.center,
                                            ["_ed"] = G.GAME.POINTER_PLAYING.edition,
                                            ["_seal"] = G.GAME.POINTER_PLAYING.seal,
                                            ["_rank"] = G.GAME.POINTER_PLAYING.rank
                                        }
                                    end
                                    card:start_dissolve()
                                end
                            end
							G.FUNCS.exit_overlay_menu_code()
							G.GAME.POINTER_PLAYING = nil
							if G.GAME.CODE_DESTROY_CARD then
								G.GAME.CODE_DESTROY_CARD:start_dissolve()
								G.GAME.CODE_DESTROY_CARD = nil
							end
						end
					else
						ccl(self)
                        if G.GAME.CODE_DESTROY_CARD then
                            G.GAME.CODE_DESTROY_CARD:start_dissolve()
                            G.GAME.CODE_DESTROY_CARD = nil
                        end
                        local cards = Entropy.GetHighlightedCards({G.hand, G.consumeables, G.jokers, G.shop_booster, G.pack_cards, G.shop_jokers, G.shop_vouchers}, {}, 1, 1)
                        if not G.GAME.DefineKeys then G.GAME.DefineKeys = {} end
                        for i, card in pairs(cards) do
                            if card.config.center.set == "Default" or card.config.center.set == "Enhanced" then
                                G.GAME.DefineKeys[card.base.name] = self.config.center.key
                            else
                                G.GAME.DefineKeys[card.config.center.key] = self.config.center.key
                            end
                            card:start_dissolve()
                        end
                        G.FUNCS.exit_overlay_menu_code()
					end
				end
			else
				ccl(self)
			end
		end
		local emplace_ref = CardArea.emplace
		function CardArea:emplace(card, ...)
			if G.GAME.USING_DEFINE then
				if Cryptid.pointergetblist(card.config.center.key)[1] or Entropy.DefineBlacklist[card.config.center.set] or Entropy.DefineBlacklist[card.config.center.key] then
					card.debuff = true
				end
			end
			return emplace_ref(self, card, ...)
		end
    end,
    loc_vars = function()
        return {
            vars = {
                "#"
            }
        }
    end
}

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
    if definekey and not G.SETTINGS.paused then
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
        if G.GAME.banned_keys[card.config.center.key] and G.GAME.challenge == "c_entr_daily" then
            if card.config.center.key == "c_entr_define" then card:set_ability(G.P_CENTERS.c_entr_disavow) end
            if card.config.center.key == "c_cry_pointer" then card:set_ability(G.P_CENTERS.c_cry_oboe) end
        end
        add_ref(self, card, location, stay_flipped)
    end
end
return {
    items = {
        define
    }
}
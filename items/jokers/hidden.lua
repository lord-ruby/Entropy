SMODS.Atlas { key = 'ruby', path = 'ruby.png', px = 71, py = 95 }

function Entropy.RegisterZenithSkin(key, atlas, pos, soul_pos, loc_vars,rare_color)
    Entropy.Zeniths[#Entropy.Zeniths+1]="j_entr_"..(key or "ruby")
    SMODS.Joker{
        key = key or "ruby",
        rarity = "entr_zenith",
        cost = 10^300,
        atlas = atlas or "ruby",
        soul_pos = soul_pos or { x = 1, y = 0},
        unlocked = false,
        discovered = false,
        blueprint_compat = true,
        eternal_compat = true,
        hidden = true,
        no_collection = true,
        pos = pos or { x = 0, y = 0 },
        no_doe = true,
        config = {
            extra = to_big(-1):tetrate(-0.5)
        },
        --atlas = "jokers",
        loc_vars = loc_vars or function(self, info_queue, card)
            return {
                vars = {
                    pseudorandom_element({"Mult{Infinity}Infinity","+Infinity Mult", "xInfinity Mult", "Mult = Infinity", "Mult^^Infinity", "Mult^Infinity"},pseudoseed("ruby")),
                    colours = {
                        {4,4,4,4}
                    }
                }
            }
        end,
        add_to_deck = function()
            G.jokers.config.card_limit = 1
            G.GAME.Ruby = "j_entr_"..(key or "ruby")
            --G.GAME.round_resets.ante = 0
        end,
        calculate = function (self, card, context)
            if context.joker_main then
                G.GAME.current_round.hands_left = 0
                G.GAME.RubyAnteNum = (G.GAME.RubyAnteNum or 0.886) + 0.114
                ease_dollars(to_big(G.GAME.dollars):arrow(math.floor(G.GAME.RubyAnteNum/1.5)+1, to_big(G.GAME.RubyAnteNum+1)) - G.GAME.dollars)
                G.GAME.RubyAnteTextNum = get_blind_amount()
                return {
                    Xmult_mod = self.config.extra
                }
            end
            if context.game_over then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.current_round.hands_left = G.GAME.round_resets.hands
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound("tarot1")
                        return true
                    end,
                }))
                G.GAME.Ruby = card.config.center.key
                return {
                    message = localize("k_saved_ruby"),
                    saved = true,
                    colour = G.C.RED,
                }
            end
        end,
        rare_color = rare_color
    }
end
if not SMODS.Mods.jen or not SMODS.Mods.jen.can_load then
    Entropy.RegisterZenithSkin()
else
    SMODS.Joker{
        key = "ruby_jens",
        rarity = "entr_hyper_exotic",
        cost = 20,
        atlas = atlas or "ruby",
        soul_pos = soul_pos or { x = 1, y = 0},
        blueprint_compat = true,
        eternal_compat = true,
        pos = pos or { x = 0, y = 0 },
        config = {
            pentation = 6.66
        },
        loc_vars = loc_vars or function(self, info_queue, card)
            return {
                vars = {
                    card.ability.pentation
                }
            }
        end,
        add_to_deck = function()
        end,
        calculate = function (self, card, context)
            if context.cardarea == G.play and not context.repetition then
                if context.other_card and context.other_card.config.center.key == "m_cry_light" then
                    return {
                        hypermult_mod = {
                            3,
                            card.ability.pentation
                        },
                        message =   '^^^'..number_format(card.ability.pentation)..'Mult',
                        colour = { 0.8, 0.45, 0.85, 1 },
                    }
                end
            end
        end,
    }
end
local update_ref = Game.update
local check_dt = 0
function Game:update(dt)
    update_ref(self, dt)
    check_dt = check_dt + dt
    if not G.GAME.Ruby then
        G.GAME.RubyAnteTextNum = G.GAME.round_resets.ante
    end
    if G.GAME.Ruby and G.hand then
        if G.GAME.current_round.current_hand.mult ~= "Infinity" and #G.hand.highlighted > 0 or #G.play.cards > 0 and not G.pack_cards then
            update_hand_text_random(
                { nopulse = true, immediate=true },
                { mult = "Infinity", chips = "1"}
            )
        end
    end
    if G.GAME.Ruby and G.jokers and check_dt > 0.5 then
        local has_ruby = 0
        for i, v in pairs(G.jokers.cards) do
            if v.config.center.key == G.GAME.Ruby and has_ruby <= 0 then
                has_ruby = has_ruby + 1
                v.debuff = false
            elseif not v.debuff then v:start_dissolve();v.debuff = true end
        end
        if has_ruby <= 0 then add_joker(G.GAME.Ruby) end
        G.jokers.config.card_limit = 1
        if G.shop_booster and G.shop_booster.cards then
            for i, v in pairs(G.shop_booster.cards) do
                if v.config.center.key == G.GAME.Ruby and not v.die then
                    v:start_dissolve();v.die = true
                end
            end
            for i, v in pairs(G.shop_jokers.cards) do
                if v.config.center.key == G.GAME.Ruby and not v.die then
                    v:start_dissolve();v.die = true
                end
            end
            for i, v in pairs(G.shop_vouchers.cards) do
                if v.config.center.key == G.GAME.Ruby and not v.die then
                    v:start_dissolve();v.die = true
                end
            end
        end
        if G.pack_cards then
            for i, v in pairs(G.pack_cards.cards) do
                if v.config.center.key == G.GAME.Ruby and not v.die then
                    v:start_dissolve();v.die = true
                end
            end
        end
        check_dt = 0
    end
end

local matref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    matref(self, center, initial, delay_sprites)
    if self.config.center.key == G.GAME.Ruby then
        if self.area and self.area.config.type ~= "joker" then
            self:start_dissolve()
        end
        if not self.ability.cry_absolute then
            self.ability.cry_absolute = true
        end
    end
    
end



local gba = get_blind_amount
function get_blind_amount(ante)
    if not ante and not G.GAME.Ruby then return 0 end
    if not G.GAME.Ruby then
        if math.abs(ante - math.floor(ante)) > 0.01 then

            local p = (ante - math.floor(ante))
            return get_blind_amount(math.floor(ante) + (ante < 0 and -1 or 0))*(1-p) + get_blind_amount(math.floor(ante)+1 + (ante < 0 and -1 or 0))*p
        end
        if ante < 0 then
            return 100 * (0.95^(-ante))
        end
    end
    if G.GAME.Ruby then 
        return lerp(to_big(100):arrow(math.floor(G.GAME.RubyAnteNum or 1),G.GAME.RubyAnteNum or 1),to_big(100):arrow(math.floor(G.GAME.RubyAnteNum or 1)+1,G.GAME.RubyAnteNum or 1),to_big(G.GAME.RubyAnteNum or 1)-to_big(G.GAME.RubyAnteNum or 1):floor())
    end
    if (Entropy.config.ante_scaling and ante > 8 and #Cryptid.advanced_find_joker(nil, "entr_hyper_exotic", nil, nil, true) ~= 0) or G.GAME.modifiers.entropic then
        return to_big(gba(ante)):tetrate(1.25)
    end
    return gba(ante) or 100
end
function lerp(f1,f2,p)
    p = p * p
    return f1 * (1-p) + f2*p
end

local SaveNum = 7
for i = 1, SaveNum do
    Entropy.RubySaves[i] = "k_saved_ruby_"..i
end

function ease_ante(mod)
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
          local ante_UI = G.hand_text_area.ante
          mod = mod or 0
          local text = '+'
          local col = G.C.IMPORTANT
          if to_big(mod) < to_big(0) then
              text = '-'
              col = G.C.RED
          end
          if HasJoker("j_entr_xekanos",true) then
            local mod2 = 0
            for i, v in pairs(G.jokers.cards) do
                if v.ability and v.ability.ante_mod then
                    mod2 = -v.ability.ante_mod
                    v.ability.ante_mod = v.ability.ante_mod - v.ability.ante_mod_mod
                    v.ability.ante_mod_mod = v.ability.ante_mod_mod * 1.25
                    if v.ability.ante_mod < 0 then v.ability.ante_mod = 0 end
                    if v.ability.ante_mod_mod > 1 then 
                        v.ability.ante_mod_mod = 0
                    else

                    end
                end
            end
            if mod2 ~= 0 then mod = mod * mod2 end
          end
          G.GAME.round_resets.ante = G.GAME.round_resets.ante + mod
          G.GAME.round_resets.ante_disp = number_format(G.GAME.round_resets.ante)
          G.GAME.round_resets.ante = Big and (to_number(to_big(G.GAME.round_resets.ante))) or G.GAME.round_resets.ante
          check_and_set_high_score('furthest_ante', G.GAME.round_resets.ante)
          ante_UI.config.object:update()
          G.HUD:recalculate()
          --Popup text next to the chips in UI showing number of chips gained/lost
          attention_text({
            text = text..tostring(math.abs(mod)),
            scale = 1, 
            hold = 0.7,
            cover = ante_UI.parent,
            cover_colour = col,
            align = 'cm',
            })
          --Play a chip sound
          play_sound('highlight2', 0.685, 0.2)
          play_sound('generic1')
          return true
      end
    }))
end
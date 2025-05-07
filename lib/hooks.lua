local card_drawref = Card.draw
function Card:draw(layer)
    card_drawref(self, layer)
    if self.config and self.config.center then
        if self.config.center.set == "RSpectral" and self.sprite_facing == "front" then
            self.children.center:draw_shader('booster', nil, self.ARGS.send_to_shader)
        end
        if self.config.center.tsoul_pos then
            local scale_mod2 = 0.07 -- + 0.02*math.cos(1.8*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local rotate_mod2 = 0 --0.05*math.cos(1.219*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
            self.children.floating_sprite2:draw_shader(
                "dissolve",
                0,
                nil,
                nil,
                self.children.center,
                scale_mod2,
                rotate_mod2,
                nil,
                0.1 --[[ + 0.03*math.cos(1.8*G.TIMERS.REAL)--]],
                nil,
                0.6
            )
            self.children.floating_sprite2:draw_shader(
                "dissolve",
                nil,
                nil,
                nil,
                self.children.center,
                scale_mod2,
                rotate_mod2
            )
    
            local scale_mod = 0.05
                + 0.05 * math.sin(1.8 * G.TIMERS.REAL)
                + 0.07
                    * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14)
                    * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL)
                + 0.07
                    * math.sin(G.TIMERS.REAL * math.pi * 5)
                    * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2
    
            self.children.floating_sprite.role.draw_major = self
            self.children.floating_sprite:draw_shader(
                "dissolve",
                0,
                nil,
                nil,
                self.children.center,
                scale_mod,
                rotate_mod,
                nil,
                0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL),
                nil,
                0.6
            )
            self.children.floating_sprite:draw_shader(
                "dissolve",
                nil,
                nil,
                nil,
                self.children.center,
                scale_mod,
                rotate_mod
            )
        end
    end
end

local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
	set_spritesref(self, _center, _front)
    if _center then
        if _center.tsoul_pos then
            self.children.floating_sprite = Sprite(
                self.T.x,
                self.T.y,
                self.T.w * (self.no_ui and 1.1*1.2 or 1),
                self.T.h * (self.no_ui and 1.1*1.2 or 1),
                G.ASSET_ATLAS[_center.atlas or _center.set],
                _center.tsoul_pos
            )
            self.children.floating_sprite.role.draw_major = self
            self.children.floating_sprite.states.hover.can = false
            self.children.floating_sprite.states.click.can = false
            if _center.tsoul_pos.extra then
                self.children.floating_sprite2 = Sprite(
                    self.T.x,
                    self.T.y,
                    self.T.w * (self.no_ui and 1.1*1.2 or 1),
                    self.T.h * (self.no_ui and 1.1*1.2 or 1),
                    G.ASSET_ATLAS[_center.atlas or _center.set],
                    _center.tsoul_pos.extra
                )
                self.children.floating_sprite2.role.draw_major = self
                self.children.floating_sprite2.states.hover.can = false
                self.children.floating_sprite2.states.click.can = false
            end
        end
    end
end

local e_round = end_round
function end_round()
    e_round()
    local remove_temp = {}
    for i, v in pairs({G.jokers, G.hand, G.consumeables, G.discard, G.deck}) do
            for ind, card in pairs(v.cards) do
                if card.ability then
                    if card.ability.entr_hotfix then
                        card.ability.entr_hotfix_rounds = (card.ability.entr_hotfix_rounds or 5) - 1
                        if card.ability.entr_hotfix_rounds <= 0 then
                            card.ability.entr_hotfix = false
                            
                            card:set_edition({
                                cry_glitched = true,
                            })
                        end
                    end
                    if card.ability.temporary or card.ability.temporary2 then
                        if card.area ~= G.hand and card.area ~= G.play and card.area ~= G.jokers and card.area ~= G.consumeables then card.states.visible = false end
                        card:remove_from_deck()
                        card:start_dissolve()
                        if card.ability.temporary then remove_temp[#remove_temp+1]=card end
                    end
                    if card.ability.entr_yellow_sign then card.ability.entr_yellow_sign = nil end
                    if card.ability.superego then
                        card.ability.superego_copies = (card.ability.superego_copies or 0) + 0.5
                    end
                    card.perma_debuff = nil
                    if card.ability.entr_pseudorandom then
                        card.ability.entr_pseudorandom = false
                        card.ability.cry_rigged = false
                    end
                end
            end
    end
    if #remove_temp > 0 then
        SMODS.calculate_context({remove_playing_cards = true, removed=remove_temp})
    end
end
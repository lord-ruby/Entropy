Entropy.BlindC = {}
local blinds = {}
function Entropy.RegisterBlinds()
    local order = 12000
    for i, v in pairs(G.P_BLINDS) do
        order = order + 1
        Entropy.BlindC[#Entropy.BlindC+1]="entr_"..i
        blinds[#blinds+1] = {
            key = "entr_"..i,
            set = "CBlind",
            
            pos = {x=9999,y=9999},
            config = {
                blind = i,
                pos = v.pos,
            },
            object_type = "Consumable",
            order=order,
            dependencies = {
                items = {
                    "set_entr_entropic"
                }
            },
            weight = 0,
            no_doe = true,
            atlas="entr_consumables",
            --soul_pos = { x = 5, y = 0},
            in_pool = function()
                return false
            end,
            use = function(self, card, area, copier,amt)
                local bl = "Small"
                for i, v in pairs(G.GAME.round_resets.blind_states) do
                    if v == "Select" or v == "Current" then bl = i end
                end
                G.GAME.round_resets.blind_choices[bl] = self.config.blind
                if G.blind_select then        
                    G.blind_select:remove()
                    G.blind_prompt_box:remove()
                    G.STATE_COMPLETE = false
                else
                    G.GAME.blind:disable()
                    G.GAME.blind:set_blind(G.P_BLINDS[self.config.blind])
                end
            end,
            can_use = function(self, card)
                if not G.GAME.round_resets then return false end
                for i, v in pairs(G.GAME.round_resets.blind_states or {}) do
                    if v == "Select" or (not SMODS.Mods.NotJustYet or (not SMODS.Mods.NotJustYet.can_load and v == "Current")) then return true end
                end
                if G.GAME.round_resets.ante_disp == "32" or G.GAME.EEBuildup then return false end
                return false
            end,
            loc_vars = function(self,q,c)
                q[#q+1]={set="Blind",key=self.config.blind}
            end,
            set_sprites = function(self, card, front)
                card.children.floating_sprite = AnimatedSprite(
                    card.T.x+0.7,
                    card.T.y+0.7,
                    1.4 * (card.no_ui and 1.1*1.2 or 1),
                    1.4 * (card.no_ui and 1.1*1.2 or 1),
                    G.ANIMATION_ATLAS["blind_chips"],
                    self.config.pos
                )
                card.children.floating_sprite.role.draw_major = card
                card.children.floating_sprite.states.hover.can = false
                card.children.floating_sprite.states.click.can = false
            end,
        }
    end
    for i, v in pairs(SMODS.Blind.obj_table) do
        if not Entropy.BlindTokenBlacklist[i] and not v.no_collection then
            order = order + 1
            Entropy.BlindC[#Entropy.BlindC+1]="entr_"..i
            blinds[#blinds+1] = {
                object_type = "Consumable",
                order=order,
                dependencies = {
                    items = {
                        "set_entr_entropic"
                    }
                },
                key = "entr_"..i,
                set = "CBlind",
                atlas="entr_consumables",
                
                pos = {x=9999,y=9999},
                config = {
                    blind = i,
                    pos = v.pos,
                    atlas = v.atlas,
                },
                weight = 0,
                no_doe = true,
                --soul_pos = { x = 5, y = 0},
                in_pool = function()
                    return false
                end,
                use = function(self, card, area, copier,amt)
                    local bl = "Small"
                    for i, v in pairs(G.GAME.round_resets.blind_states) do
                        if v == "Select" or v == "Current" then bl = i end
                    end
                    G.GAME.round_resets.blind_choices[bl] = self.config.blind
                    if G.blind_select then        
                        G.blind_select:remove()
                        G.blind_prompt_box:remove()
                        G.STATE_COMPLETE = false
                    else
                        G.GAME.blind:disable()
                        G.GAME.blind:set_blind(G.P_BLINDS[self.config.blind])
                    end
                end,
                can_use = function(self, card)
                    if not G.GAME.round_resets then return false end
                    for i, v in pairs(G.GAME.round_resets.blind_states or {}) do
                        if v == "Select" or (not SMODS.Mods.NotJustYet or (not SMODS.Mods.NotJustYet.can_load and v == "Current")) then return true end
                    end
                    if G.GAME.round_resets.ante_disp == "32" or G.GAME.EEBuildup then return false end
                    return false
                end,
                loc_vars = function(self,q,c)
                    q[#q+1]={set="Blind",key=self.config.blind}
                end,
                entr_credits = v.entr_credits,
                cry_credits = v.cry_credits,
                set_sprites = function(self, card, front)
                    card.children.floating_sprite = AnimatedSprite(
                        card.T.x+0.7,
                        card.T.y+0.7,
                        1.4 * (card.no_ui and 1.1*1.2 or 1),
                        1.4 * (card.no_ui and 1.1*1.2 or 1),
                        G.ANIMATION_ATLAS[self.config.atlas or ""] or G.ANIMATION_ATLAS["blind_chips"],
                        self.config.pos
                    )
                    card.children.floating_sprite.role.draw_major = card
                    card.children.floating_sprite.states.hover.can = false
                    card.children.floating_sprite.states.click.can = false
                end,
                set_badges = function(self, card, badges)
                    if v.original_mod then badges[#badges+1] = create_badge(v.original_mod.name, v.original_mod.badge_colour, G.C.WHITE, 1 ) end
                end,
            }
        end
    end
    return {items = blinds}
end

local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_spritesref(self,_center,_front)
    if _center and _center.set_sprites then
        _center:set_sprites(self, _front)
    end
end


local card_hoverref = Card.draw

function Card:draw(layer)
    card_hoverref(self, layer)
    if self.config.center.set_sprites and self.children and self.children.floating_sprite then
        local scale_mod = 0.6
        local rotate_mod = 0

        self.children.floating_sprite.role.draw_major = self
        self.children.floating_sprite:draw_shader(
            (G.P_CENTERS[self.edition and self.edition.key or ""] or {shader="dissolve"}).shader or "dissolve",
            0,
            nil,
            nil,
            self.children.center,
            scale_mod,
            rotate_mod,
            0.85,
            1.3,
            nil,
            0.6
        )
        self.children.floating_sprite:draw_shader(
            (G.P_CENTERS[self.edition and self.edition.key or ""] or {shader="dissolve"}).shader or "dissolve",
            nil,
            nil,
            nil,
            self.children.center,
            scale_mod,
            rotate_mod,
            0.85,
            1.3
        )
    end
end
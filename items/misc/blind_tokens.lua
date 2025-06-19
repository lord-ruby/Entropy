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
            pixel_size = { w = 34, h = 34 },
            display_size = { w = 68, h = 68 },
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
            blpos = v.pos,
            blatlas = v.atlas,
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
                if G.STATE ~= G.STATES.BLIND_SELECT and G.STATE ~= G.STATES.SELECTING_HAND then return false end
                for i, v in pairs(G.GAME.round_resets.blind_states or {}) do
                    if v == "Select" or (not SMODS.Mods.NotJustYet or (not SMODS.Mods.NotJustYet.can_load and v == "Current")) then return true end
                end
                if (to_big(G.GAME.round_resets.ante) >= to_big(32) and not G.GAME.EEBeaten) or G.GAME.EEBuildup then return false end
                return false
            end,
            loc_vars = function(self,q,c)
                q[#q+1]={set="Blind",key=self.config.blind}
            end,
            set_sprites = function(self, card, front)
                card.children.center.atlas = G.ANIMATION_ATLAS["blind_chips"]
                card.children.center:set_sprite_pos(self.blpos)
            end,
            demicoloncompat = true,
            force_use = function(self, card, area)
                self:use(card, area)
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
                --atlas="entr_consumables",
                pixel_size = { w = 34, h = 34 },
                display_size = { w = 68, h = 68 },
                blpos = v.pos,
                blatlas = v.atlas,
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
                    if G.STATE ~= G.STATES.BLIND_SELECT and G.STATE ~= G.STATES.SELECTING_HAND then return false end
                    for i, v in pairs(G.GAME.round_resets.blind_states or {}) do
                        if v == "Select" or (not SMODS.Mods.NotJustYet or (not SMODS.Mods.NotJustYet.can_load and v == "Current")) then return true end
                    end
                    if (to_big(G.GAME.round_resets.ante) >= to_big(32) and not G.GAME.EEBeaten) or G.GAME.EEBuildup then return false end
                    return false
                end,
                loc_vars = function(self,q,c)
                    q[#q+1]={set="Blind",key=self.config.blind}
                end,
                entr_credits = v.entr_credits,
                cry_credits = v.cry_credits,
                set_sprites = function(self, card, front)
                    card.children.center.sprite_pos = self.blpos
                    card.children.center:reset()
                    card.children.center.atlas = G.ANIMATION_ATLAS[self.blatlas] or G.ANIMATION_ATLAS["blind_chips"]
                end,
                set_badges = function(self, card, badges)
                    if v.original_mod then badges[#badges+1] = create_badge(v.original_mod.name, v.original_mod.badge_colour, G.C.WHITE, 1 ) end
                end,
                demicoloncompat = true,
                force_use = function(self, card, area)
                    self:use(card, area)
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
    local ref = card_hoverref(self, layer)
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
    return ref
end
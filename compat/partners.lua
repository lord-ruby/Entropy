if Partner_API then
    SMODS.Atlas{
        key = "entr_partners",
        px = 46,
        py = 58,
        path = "partners.png"
    }

    Partner_API.Partner{
        key = "parakmi",
        name = "Parakmi Partner",
        unlocked = true,
        discovered = true,
        pos = {x = 0, y = 0},
        soul_pos = {x=1, y=0, extra = {x=2,y=0}},
        atlas = "entr_partners",
        config = {
            extra = {
                related_card = "j_entr_parakmi"
            }
        }
    }

    local getpackref = get_pack
    function get_pack(_key, _type)
        local abc = getpackref(_key, _type)
        if G.GAME.viewed_partner and G.GAME.viewed_partner.name == "Parakmi Partner" then            
            local keys = {}
            for i, v in pairs(G.P_CENTER_POOLS.Booster) do
                if not G.GAME.banned_keys[v.key] and not v.no_doe then
                    keys[#keys+1]=v.key
                end
            end
            return G.P_CENTERS[pseudorandom_element(
                keys,
                pseudoseed("cry_equipackbrium" .. G.GAME.round_resets.ante)
            )]
        else    
            return abc
        end
    end
    local gcp = get_current_pool
    function get_current_pool(_type, _rarity, _legendary, _append, override_equilibrium_effect)
        local equib = G.GAME.modifiers.cry_equilibrium
        if G.GAME.viewed_partner and G.GAME.viewed_partner.name == "Parakmi Partner" and next(SMODS.find_card("j_entr_parakmi")) then
            G.GAME.modifiers.cry_equilibrium = true
        end
        local ret, ret2 = gcp(_type, _rarity, _legendary, _append, override_equilibrium_effect)
        G.GAME.modifiers.cry_equilibrium = equib
        return ret, ret2
    end
end
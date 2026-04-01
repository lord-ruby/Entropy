G.C.Entropy = {}
G.C.Entropy.Star = HEX("845baa")
G.C.Entropy.Omen = HEX("ff00c4")
G.C.Entropy.Fraud = HEX("da7272")
G.C.Entropy.Command = HEX("ff0000")
G.C.Entropy.Rune = HEX("b47bbb")
G.C.Entropy.Pact = HEX("ab124c")
G.C.Entropy.Transient = HEX("81598c")
G.C.Entropy.Dissolve = {
    Star = G.C.Entropy.Star,
    Omen = G.C.Entropy.Omen,
    Command = G.C.Entropy.Command,
    Fraud = G.C.Entropy.Fraud,
    Transient = G.C.Entropy.Transient,
    Pact = G.C.Entropy.Pact,
    Rune = G.C.Entropy.Rune
}

G.C.ALTBG = HEX("41566f")

G.C.Entropy.ORANGE = HEX("ff5e00")

G.C.Entropy.DARK_GRAY = HEX("6a7895")
G.C.Entropy.LIGHT_GRAY = HEX("95ade0")

local gradients = {
    entropic_gradient = {
        G.C.RED,G.C.GOLD,G.C.GREEN,
        G.C.BLUE,G.C.PURPLE
    },
    transgender_gradient = {
        HEX("5bcefa"), HEX("f5a9b8"),
    },
    reverse_legendary_gradient = {
        HEX("ff00c4"),HEX("FF00FF"),HEX("FF0000"),
    },
    zenith_gradient = {
        HEX("a20000"),HEX("a15000"),HEX("a3a101"),
        HEX("626262"),HEX("416600"),HEX("028041"),
        HEX("008284"),HEX("005683"),HEX("000056"),
        HEX("2b0157"),HEX("6a016a"),HEX("77003c"),
    },
    reverse_zenith_gradient = {
        HEX("00FF00"), HEX("FF0000")
    },
    void_gradient = {
        HEX("c678b4"), HEX("c67886")
    },
    cmult_gradient = {
        G.C.BLUE,
        G.C.RED
    },
    eta_gradient = {
        HEX("b95c96"),
        HEX("ac9db4"),
        HEX("a9a295"),
        HEX("b9cb92")
    },
    pearl_gradient = {
        HEX("ff9ff3"),
        HEX("7049dc"),
        HEX("00c8ff")
    }
}

for i, v in pairs(gradients) do
    Entropy[i] = SMODS.Gradient {
        key = i,
        colours = v
    }
    Entropy[i] = SMODS.Gradients["entr_"..i]
end
Entropy.add_extra_gradient = function(gradient, mixc, mixp)
    local o_grad = SMODS.Gradients[gradient]
    if not o_grad then return end
    local k = o_grad.key..mixc[1]..mixc[2]..mixc[3]..mixp
    if SMODS.Gradients[k] then
        return SMODS.Gradients[k]
    end
    local colours = copy_table(o_grad.colours)
    for i, v in pairs(colours) do
        colours[i] = mix_colours(v, mixc, mixp)
    end
    local grad = {
        key = k,
        original_mod = o_grad.original_mod,
        original_key = o_grad.original_key,
        _saved_d_v = true,
        registered = true,
        mod = o_grad.mod,
        prefix_config = o_grad.prefix_config,
        colours = colours,
        cycle = o_grad.cycle,
        interpolation = o_grad.interpolation,
        [1] = colours[1][1],
        [2] = colours[1][2],
        [3] = colours[1][3],
        [4] = colours[1][4],
        update = function(self)
            if #self.colours < 2 then return end
            local timer = G.TIMERS.REAL%self.cycle
            local start_index = math.ceil(timer*#self.colours/self.cycle)
            local end_index = start_index == #self.colours and 1 or start_index+1
            local start_colour, end_colour = self.colours[start_index], self.colours[end_index]
            local partial_timer = (timer%(self.cycle/#self.colours))*#self.colours/self.cycle
            for i = 1, 4 do
                if self.interpolation == 'linear' then

                    self[i] = start_colour[i] + partial_timer*(end_colour[i]-start_colour[i])
                elseif self.interpolation == 'trig' then
                    self[i] = start_colour[i] + 0.5*(1-math.cos(partial_timer*math.pi))*(end_colour[i]-start_colour[i])
                end
            end
        end
    }
    SMODS.Gradients[k] = grad
    return grad
end

local mix_c = mix_colours
function mix_colours(c1, c2, mixp)
    if (c1.colours or c2.colours) and not (c1.colours and c2.colours) then
        return Entropy.add_extra_gradient(c1.colours and c1.key or c2.key, c1.colours and c2 or c1, mixp)
    end
    return mix_c(c1, c2, mixp)
end

local d = darken
function darken(co, p, nt)
    if co.colours then
        local ret = mix_colours(co, G.C.BLACK, 1- p)
        if ret then
            if nt then
                return ret[1], ret[2], ret[3], ret[4]
            end
            return ret
        end
    end
    return d(co, p, nt)
end

local l = lighten
function lighten(co, p, nt)
    if co.colours then
        local ret = mix_colours(co, G.C.WHITE, p)
        if ret then
            if nt then
                return ret[1], ret[2], ret[3], ret[4]
            end
            return ret
        end
    end
    return l(co, p, nt)
end

local upd = Game.update
function Game:update(...)
    upd(self, ...)
    if G.GAME.modifiers.entr_gfb or (G.GAME.blind and G.GAME.blind.config.blind and G.GAME.blind.config.blind.boss_colour and G.GAME.blind.config.blind.boss_colour.colours) then
        local args
        if G.GAME.modifiers.entr_gfb then
            args = {new_colour = mix_colours(Entropy.zenith_gradient, G.C.BLACK, 0.3), special_colour = Entropy.zenith_gradient, contrast = 2}
        else
            args = {new_colour = mix_colours(G.GAME.blind.config.blind.boss_colour, G.C.BLACK, 0.3), special_colour = G.GAME.blind.config.blind.boss_colour, contrast = 2}
        end
        for k, v in pairs(G.C.BACKGROUND) do
            if args.new_colour and (k == 'C' or k == 'L' or k == 'D') then 
                if args.special_colour and args.tertiary_colour then 
                    local col_key = k == 'L' and 'new_colour' or k == 'C' and 'special_colour' or k == 'D' and 'tertiary_colour'
                    v[1] = args[col_key][1]
                    v[2] = args[col_key][2]
                    v[3] = args[col_key][3]
                else
                    local brightness = k == 'L' and 1.3 or k == 'D' and (args.special_colour and 0.4 or 0.7) or 0.9
                    if k == 'C' and args.special_colour then
                        v[1] = args.special_colour[1]
                        v[2] = args.special_colour[2]
                        v[3] = args.special_colour[3]
                    else
                        v[1] = args.new_colour[1]*brightness
                        v[2] = args.new_colour[2]*brightness
                        v[3] = args.new_colour[3]*brightness
                    end
                end
            end
        end
        if args.contrast then 
            G.C.BACKGROUND.contrast = args.contrast
        end
        local col = G.GAME.blind.config.blind.boss_colour
        if not G.GAME.modifiers.entr_gfb then
            local dark = darken(col, 0.6)
            for i, v in ipairs(col) do
                G.C.DYN_UI.MAIN[i] = v
                G.C.DYN_UI.BOSS_MAIN[i] = v
            end
            for i, v in ipairs(dark) do
                G.C.DYN_UI.DARK[i] = v
            end
            local dark2 = darken(col, 0.8)
            for i, v in ipairs(dark2) do
                G.C.DYN_UI.BOSS_DARK[i] = v
            end
        end
    end
end

local set_blind = Blind.set_blind
function Blind:set_blind(...)
    set_blind(self, ...)
    if G.GAME.blind.config.blind.boss_colour and G.GAME.blind.config.blind.boss_colour.colours then
        G.HUD_blind:get_UIE_by_ID("HUD_blind").children[1].config.colour = G.GAME.blind.config.blind.boss_colour 
        G.HUD_blind:get_UIE_by_ID("HUD_blind").children[2].config.colour = darken(G.GAME.blind.config.blind.boss_colour, 0.4)
    end
    if G.GAME.blind_on_deck == "Boss" and G.GAME.round_resets.ante >= 8 then
        G.GAME.entr_ante_8_boss = localize{type="name_text", set = "Blind", key = G.GAME.blind.config.blind.key}
    end
    if G.GAME.entr_ante_8_boss and G.GAME.blind_on_deck == "Boss" and G.GAME.round_resets.ante >= 12 then
        G.GAME.entr_ante_12_boss = localize{type="name_text", set = "Blind", key = G.GAME.blind.config.blind.key}
    end
end

local defeat = Blind.defeat
function Blind:defeat(...)
    if G.GAME.blind.config.blind.boss_colour and G.GAME.blind.config.blind.boss_colour.colours then
        blind_col = G.C.BLACK
        local dark_col = mix_colours(blind_col, G.C.BLACK, 0.4)
        ease_colour(G.C.DYN_UI.MAIN, blind_col)
        ease_colour(G.C.DYN_UI.DARK, dark_col)
        blind_col = darken(G.C.BLACK, 0.05)
        dark_col = lighten(G.C.BLACK, 0.07)
        ease_colour(G.C.DYN_UI.BOSS_MAIN, blind_col)
        ease_colour(G.C.DYN_UI.BOSS_DARK, dark_col)
        G.E_MANAGER:add_event(Event{
            func = function()
                
                G.HUD_blind:get_UIE_by_ID("HUD_blind").children[1].config.colour = G.C.DYN_UI.MAIN
                G.HUD_blind:get_UIE_by_ID("HUD_blind").children[2].config.colour = G.C.DYN_UI.DARK
                return true
            end
        })
    end
    defeat(self, ...)
end

G.C.UI.HANDS = copy_table(G.C.BLUE)
G.C.UI.DISCARDS = copy_table(G.C.RED)
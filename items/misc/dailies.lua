
local succ, https = pcall(require, "SMODS.https")
local function check_daily_seed(code, body, headers)
    if body then
        pcall(function()
            local json = JSON.decode(body)
            Entropy.DAILYSEED = string.format("%02d", json.month).."/"..string.format("%02d", json.day).."/"..string.format("%02d", string.sub(json.year, 3))
        end)
    end
    if not Entropy.DAILYSEED then
        Entropy.DAILYSEED = os.date("%x")
    end
end
function Entropy.update_daily_seed()
    if Cryptid_config.HTTPS and https and https.asyncRequest then
        https.asyncRequest(
            "https://tools.aimylogic.com/api/now?tz=Europa/England&format=dd/MM/yyyy",
            check_daily_seed
        )   
    else
        Entropy.DAILYSEED = os.date("%x")
    end
end

local function hash(str)
    local h = 5381

    for i = 1, #str do
       h = h*32 + h + str:byte(i)
    end
    return h
end

function Entropy.get_daily_challenge()
    Entropy.update_daily_seed()
    local seed = Entropy.DAILYSEED
    --https://tools.aimylogic.com/api/now?tz=Europa/England&format=dd/MM/yyyy to:do use this
    math.randomseed(hash(seed))
    G.CHALLENGES["daily"] = Entropy.SpecialDailies[seed] or Entropy.SpecialDailies[os.date("%m").."/"..os.date("%d")] or Entropy.generate_daily()
end
function Entropy.generate_daily()
    Entropy.update_daily_seed()
    local seed = Entropy.DAILYSEED
    math.randomseed(hash(seed))
    local allowed_rules = {
        "no_shop_jokers",
        "no_reward",
        "no_interest",
        "no_extra_hand_money",
        "inflation",
        "all_eternal",
    }
    local rules = math.random(0, 1)
    local generate = {}
    local arules = {}
    if rules > 0 then
        for i = 1, rules do
            local rule= allowed_rules[math.random(1, #allowed_rules)]
            while generate[rule] do
                rule = allowed_rules[math.random(1, #allowed_rules)]
            end
            generate[rule] = true
            table.insert(arules, {id=rule})
        end
    end
    local seed = Entropy.DAILYSEED
    math.randomseed(hash(seed))
    table.insert(arules, {id = 'entr_set_seed', value = Entropy.srandom(8, "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")})
    return {
        consumeables = {
            {id = Entropy.get_in_pool_daily("Consumeables")},
            math.random(1, 100) < 40 and {id = Entropy.get_in_pool_daily("Consumeables")} or nil,
        },
        vouchers = {
            math.random(1, 100) < 50 and {
                id = Entropy.get_in_pool_daily("Voucher")
            } or nil,
            math.random(1, 100) < 10 and {
                id = Entropy.get_in_pool_daily("Voucher")
            } or nil
        },
        jokers = {
            math.random(1, 100) < 75 and {
                id = Entropy.get_in_pool_daily("Joker")
            } or nil,
            math.random(1, 100) < 25 and {
                id = Entropy.get_in_pool_daily("Joker")
            } or nil,
            math.random(1, 100) < 2 and {
                id = Entropy.get_in_pool_daily("Joker")
            } or nil
        },
        rules = {
            custom = arules,
        },
        key = "c_entr_daily",
        id = "c_entr_daily",
        original_key = "daily",
        registered = true,
        deck = {
            type = "Challenge Deck"
        },
        restrictions = Entropy.daily_banlist()
        -- consumeables = {
        --     {id = G.P_CENTER_POOLS.Consumeables[math.random(1, #G.P_CENTER_POOLS.Consumeables)].key},
        --     {id = G.P_CENTER_POOLS.Consumeables[math.random(1, #G.P_CENTER_POOLS.Consumeables)].key}
        -- }
    }
end

function Entropy.get_in_pool_daily(pool)
    local allowed = {
        entr = true,
        Cryptid = true
    }
    local actual = {}
    for i, v in pairs(G.P_CENTER_POOLS[pool]) do
        if (not v.no_doe and v.set ~= "CBlind" and (not v.original_mod or allowed[v.original_mod.id])) and not Entropy.daily_banlistContains(v.key) then
            actual[#actual+1] = v 
        end
    end
    return actual[math.random(1,#actual)].key
end

G.FUNCS.start_challenge_run = function(e)
    if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
    local seed = nil
    for i, v in ipairs(G.CHALLENGES[e.config.id].rules and type(G.CHALLENGES[e.config.id].rules.custom) == "table" and G.CHALLENGES[e.config.id].rules.custom or {}) do
        if v.id == "entr_set_seed" then seed = v.value end
    end
    G.FUNCS.start_run(e, {stake = 1, challenge = G.CHALLENGES[e.config.id], seed =seed})
  end

  function Entropy.daily_banlist()
    return {
        banned_cards = {
            {id="c_entr_decrement"},
            {id="c_entr_push"},
            {id="c_entr_evocation"},
            {id="c_entr_memory_leak"},
            {id="c_entr_define"},
            {id="c_cry_crash"},
            {id="c_cry_pointer"},
            {id="c_cry_hook"},
            {id="c_entr_desync"},
            {id="c_entr_shatter"},
            {id="c_entr_break"},
            {id="c_cry_revert"},

            {id="v_cry_asteroglyph"},

            {id="j_cry_pity_prize"},
            {id="j_cry_demicolon"},
            {id="j_cry_crustulum"},
            {id="j_entr_ieros"},
            {id="j_entr_dekatria"},
            {id="j_cry_cotton_candy"},
            {id="j_cry_coin"},
            {id="j_cry_copypaste"},
            {id="j_entr_trapezium_cluster"},
            {id="j_entr_antidagger"},
            {id="e_entr_fractured", type="Edition"}
        },
        banned_tags = {
            {id="tag_entr_fractured"},
            {id="tag_entr_ascendant_fractured"},
        },
        banned_other = {
        }
    }
end

function Entropy.daily_banlistContains(key)
    for i, v in pairs(Entropy.daily_banlist().banned_cards) do
        if v.id == key then return true end
    end
end

Entropy.SpecialDailies["06/01"] = {
    jokers = {
        { id = "j_blueprint", edition = "entr_freaky", stickers = {"entr_aleph"} },
        { id = "j_brainstorm", edition = "entr_freaky", stickers = {"entr_aleph"} },
        { id = "j_banner", edition = "polychrome" }
    },
    rules = {
        custom = {
          {id="entr_set_seed", value = "PRIDMNTH"}
        }
    },
    restrictions = Entropy.daily_banlist(),
    key = "c_entr_daily",
    id = "c_entr_daily",
    original_key = "daily",
    registered = true,
    deck = {
        type = "Challenge Deck"
    },
}

Entropy.SpecialDailies["06/02"] = {
    jokers = {
        { id = "j_jolly", edition = "entr_sunny", stickers = {"entr_aleph"} },
        { id = "j_entr_sunny_joker", edition = "cry_m", stickers = {"entr_aleph"} }
    },
    consumeables = {
        { id = "c_entr_hydrae", edition = "entr_freaky" },
        { id = "c_lovers"}
    },
    rules = {
        custom = {
          {id="entr_set_seed", value = "ASCPAIR2"}
        }
    },
    restrictions = Entropy.daily_banlist(),
    key = "c_entr_daily",
    id = "c_entr_daily",
    original_key = "daily",
    registered = true,
    deck = {
        type = "Challenge Deck"
        --,enhancement = "m_wild"
    },
}

Entropy.SpecialDailies["06/04"] = {
    jokers = {
        { id = "j_entr_rusty_shredder", stickers = {"entr_aleph"} },
        { id = "j_entr_metanoia", edition = "negative", stickers = {"entr_aleph"} }
    },
    consumeables = {
        { id = "c_entr_multithread"}
    },
    rules = {
        custom = {
          {id="entr_set_seed", value = "MEATNOIA"}
        }
    },
    restrictions = Entropy.daily_banlist(),
    key = "c_entr_daily",
    id = "c_entr_daily",
    original_key = "daily",
    registered = true,
    deck = {
        type = "Challenge Deck"
    },
}

Entropy.SpecialDailies["06/05"] = {
    jokers = {
        { id = "j_egg", edition = "entr_neon" },
        { id = "j_cry_megg", edition = "cry_m" },
        { id = "j_entr_chocolate_egg", edition = "entr_sunny" }
    },
    consumeables = {
        { id = "c_entr_shatter"}
    },
    rules = {
        custom = {
          {id="entr_set_seed", value = "CRACKEGG"}
        }
    },
    restrictions = Entropy.daily_banlist(),
    key = "c_entr_daily",
    id = "c_entr_daily",
    original_key = "daily",
    registered = true,
    deck = {
        type = "Challenge Deck"
    },
}

Entropy.SpecialDailies["06/06"] = {
    jokers = {
        { id = "j_cry_nice", stickers = {"entr_aleph"}}
    },
    consumeables = {
        { id = "c_entr_lust"}
    },
    rules = {
        custom = {
          {id="entr_set_seed", value = "FRKYFDAY"}
        }
    },
    restrictions = Entropy.daily_banlist(),
    key = "c_entr_daily",
    id = "c_entr_daily",
    original_key = "daily",
    registered = true,
    deck = {
        type = "Challenge Deck",
        edition = "entr_freaky"
    },
}

Entropy.SpecialDailies["06/08"] = {
    jokers = {
        { id = "j_hiker", stickers = {"entr_aleph"}},
        { id = "j_entr_libra", stickers = {"perishable", "superego"}}
    },
    consumeables = {
        { id = "c_entr_cleanse"},
        { id = "c_entr_endurance", edition = "negative" }
    },
    vouchers = {
        { id = "v_tarot_merchant" }
    },
    rules = {
        custom = {
          {id="entr_set_seed", value = "LOSEFACE"}
        }
    },
    restrictions = Entropy.daily_banlist(),
    key = "c_entr_daily",
    id = "c_entr_daily",
    original_key = "daily",
    registered = true,
    deck = {
        type = "Challenge Deck",
        cards = {
            {s='D', r='2',}, {s='C', r='2',}, {s='S', r='2',}, {s='H', r='2',},
            {s='D', r='3',}, {s='C', r='3',}, {s='S', r='3',}, {s='H', r='3',},
            {s='D', r='4',}, {s='C', r='4',}, {s='S', r='4',}, {s='H', r='4',},
            {s='D', r='5',}, {s='C', r='5',}, {s='S', r='5',}, {s='H', r='5',},
            {s='D', r='6',}, {s='C', r='6',}, {s='S', r='6',}, {s='H', r='6',},
            {s='D', r='7',}, {s='C', r='7',}, {s='S', r='7',}, {s='H', r='7',},
            {s='D', r='8',}, {s='C', r='8',}, {s='S', r='8',}, {s='H', r='8',},
            {s='D', r='9',}, {s='C', r='9',}, {s='S', r='9',}, {s='H', r='9',},
            --{s='D', r='T',}, {s='C', r='T',}, {s='S', r='T',}, {s='H', r='T',},
            --{s='D', r='J',}, {s='C', r='J',}, {s='S', r='J',}, {s='H', r='J',},
            --{s='D', r='Q',}, {s='C', r='Q',}, {s='S', r='Q',}, {s='H', r='Q',},
            --{s='D', r='K',}, {s='C', r='K',}, {s='S', r='K',}, {s='H', r='K',},
            {s='D', r='A',}, {s='C', r='A',}, {s='S', r='A',}, {s='H', r='A',}
        }
    },
}


Entropy.SpecialDailies["06/09"] = {
    jokers = {
        { id = "j_cry_curse_sob", edition = "entr_neon"}
    },
    consumeables = {
        { id = "c_entr_badarg"}
    },
    rules = {
        custom = {
          {id="entr_set_seed", value = "5083L15K"}
        }
    },
    restrictions = Entropy.daily_banlist(),
    key = "c_entr_daily",
    id = "c_entr_daily",
    original_key = "daily",
    registered = true,
    deck = {
        type = "Challenge Deck"
    },
}

Entropy.SpecialDailies["06/10"] = {
    jokers = {
        { id = "j_to_the_moon", edition = "negative"}
    },
    consumeables = {
        { id = "c_cry_exploit", edition = "negative" },
        { id = "c_cry_exploit", edition = "negative" },
        { id = "c_cry_exploit", edition = "negative" },
        { id = "c_cry_exploit", edition = "negative" },
        { id = "c_cry_exploit", edition = "negative" }
    },
    rules = {
        custom = {
          {id="entr_set_seed", value = "00000O00"}
        }
    },
    restrictions = Entropy.daily_banlist(),
    key = "c_entr_daily",
    id = "c_entr_daily",
    original_key = "daily",
    registered = true,
    deck = {
        type = "Challenge Deck",
        cards = {}
    },
}

Entropy.SpecialDailies["06/11"] = {
    jokers = {
        { id = "j_entr_ridiculus_absens", stickers = {"entr_aleph"} },
        { id = "j_entr_chaos", edition = "entr_lowres", stickers = {"eternal", "perishable", "rental", "desync", "entr_hotfix", "entr_pseudorandom"}}
    },
    consumeables = {
        { id = "c_cry_machinecode" },
        { id = "c_entr_interference" }
    },
    rules = {
        custom = {
          {id="entr_set_seed", value = "M1551NGN0"}
        }
    },
    restrictions = Entropy.daily_banlist(),
    key = "c_entr_daily",
    id = "c_entr_daily",
    original_key = "daily",
    registered = true,
    deck = {
        type = "Challenge Deck",
        cards = {
            {s='D', r='2',}, {s='C', r='9',}, {s='S', r='9',}, {s='H', r='2',},
            {s='D', r='A',}, {s='C', r='8',}, {s='S', r='3',}, {s='H', r='Q',},
            {s='D', r='2',}, {s='C', r='4',}, {s='D', r='T',}, {s='H', r='4',},
            {s='D', r='5',}, {s='C', r='5',}, {s='S', r='T',}, {s='H', r='5',},
            {s='D', r='6',}, {s='C', r='7',}, {s='S', r='2',}, {s='H', r='Q',},
            {s='D', r='2',}, {s='D', r='7',}, {s='S', r='7',}, {s='S', r='Q',},
            {s='D', r='8',}, {s='C', r='8',}, {s='S', r='8',}, {s='H', r='8',},
            {s='D', r='9',}, {s='C', r='9',}, {s='S', r='T',}, {s='H', r='9',},
            {s='D', r='T',}, {s='C', r='A',}, {s='S', r='T',}, {s='S', r='K',},
            {s='D', r='A',}, {s='D', r='J',}, {s='S', r='J',}, {s='H', r='J',},
            {s='D', r='3',}, {s='C', r='6',}, {s='S', r='J',}, {s='H', r='Q',},
            {s='D', r='K',}, {s='S', r='K',}, {s='S', r='K',}, {s='H', r='K',},
            {s='D', r='4',}, {s='C', r='5',}, {s='S', r='A',}, {s='H', r='A',}
        }
    },
}

Entropy.SpecialDailies["06/13"] = {
    jokers = {
        { id = "j_cry_necromancer", stickers = {"entr_aleph"}},
        { id = "j_entr_recursive_joker", edition = "entr_neon"}
    },
    consumeables = {
        { id = "c_cry_divide"}
    },
    rules = {
        custom = {
          {id="entr_set_seed", value = "1D4BL00N"}
        }
    },
    restrictions = Entropy.daily_banlist(),
    key = "c_entr_daily",
    id = "c_entr_daily",
    original_key = "daily",
    registered = true,
    deck = {
        type = "Challenge Deck",
    },
}

Entropy.SpecialDailies["06/14"] = {
    jokers = {
        { id = "j_cry_night", edition = "negative", stickers = {"entr_aleph"}},
        { id = "j_space", edition = "negative", stickers = {"entr_aleph"}},
        { id = "j_cry_universum", edition = "entr_lowres", stickers = {"entr_aleph"}},
                { id = "j_constellation", edition = "negative"},
    },
    consumeables = {
        { id = "c_black_hole", stickers = {"eternal", "perishable"}}
    },
    rules = {
        custom = {
          {id="entr_set_seed", value = "ST4RG4ZE"}
        }
    },
    restrictions = Entropy.daily_banlist(),
    key = "c_entr_daily",
    id = "c_entr_daily",
    original_key = "daily",
    registered = true,
    deck = {
        type = "Challenge Deck",
    },
}

Entropy.SpecialDailies["06/15"] = {
    jokers = {
        { id = "j_entr_stillicidium", edition = "negative", stickers = {"entr_aleph", "pinned"}},
    },
    consumeables = {
        { id = "c_entr_mbr" }
    },
    rules = {
        custom = {
          {id="entr_set_seed", value = "DELT4T43"}
        }
    },
    restrictions = Entropy.daily_banlist(),
    key = "c_entr_daily",
    id = "c_entr_daily",
    original_key = "daily",
    registered = true,
    deck = {
        type = "Challenge Deck",
    },
}
Entropy.srandom = Spectrallib.string_random

function Entropy.inversion(card)
    if not card then return end
    local card = card.config and card.config.center or card
    local key = card.key or card.config.center and card.config.center_key or ""
    if card.can_be_inverted or card.corruptions then return key end
    if card.set == "Joker" then
        for i, v in pairs(G.P_CENTER_POOLS.Joker) do
            if v.corruptions then
                for i, c in pairs(v.corruptions) do if c == key then return v.key end end
            end
        end
    end
    return Entropy.FlipsideInversions[card.key]
end

function Entropy.is_inverted(card)
    if not card then return end
    local card = card.config and card.config.center or card
    local key = card.key or card.config.center and card.config.center_key or ""
    if card.set == "Joker" then
        if card.corruptions then return true end
    end
    return Entropy.FlipsideInversions[key] and not Entropy.FlipsidePureInversions[key]
end

function Entropy.inversion_queue(card, _c, first_pass)
    local info_queue = {}
    if (Entropy.inversion(card) or _c.key == "c_entr_flipside" or _c.corruptions) and first_pass and Entropy.show_flipside(card, _c) and Entropy.config.inversion_queues > 1 and not c then 
        if _c.key ~= "c_entr_flipside" and _c.key ~= Entropy.inversion(card) and not _c.corruptions then
          local inversion = G.P_CENTERS[Entropy.inversion(_c)] 
          info_queue[#info_queue+1] = {key = "inversion_allowed", set = "Other", vars = {G.localization.descriptions[inversion.set][inversion.key].name}}
          if Entropy.config.inversion_queues > 2 then
            info_queue[#info_queue+1] = inversion
          end
        elseif Entropy.show_flipside(card, _c) and Entropy.config.inversion_queues > 1 then
          info_queue[#info_queue+1] = {key = "inversion_allowed", set = "Other", vars = {"???"}}
        end
    end
    return info_queue
end

function Entropy.invert(cards, flip, filter)
    if cards.start_dissolve then cards = {cards} end
    local c_temp = {}
    for i, v in pairs(cards) do
        if Entropy.inversion(v) or v.config.center.corruptions or not filter then
            c_temp[#c_temp+1] = v
        end
    end
    cards = c_temp
    if flip and not Entropy.should_skip_animations() then
        Entropy.flip_then(cards, {
        {func = function(c)
             c:juice_up()
             play_sound("tarot1")
        end, delay = 1.5},
        {func = function(c)
             c:juice_up()
             play_sound("tarot1")
        end, delay = 1.5},
        {func = function(c)
             c:juice_up()
             play_sound("entr_invert")
        end, delay = 1.5},
        {func = function(c)
            local key = c.config.center_key
            local i = Entropy.inversion(c)
            if c.config.center.corruptions then
                G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
                for i, v in pairs(c.config.center.corruptions) do
                    G.GAME.entr_perma_inversions[v] = c.config.center.key
                end
                if c.ability.original_corruption then 
                    i = c.ability.original_corruption 
                else 
                    i = pseudorandom_element(c.config.center.corruptions, pseudoseed("entr_get_corruption"))
                end
            end
            if i then
                local ret = {}
                if c.config.center.calculate then
                    ret = c.config.center:calculate(c, {being_inverted = true}) or {}
                end
                if not ret or not ret.prevent_inversion then
                    c.ability.fromflipside = true
                    c:set_ability(G.P_CENTERS[i])
                    if G.P_CENTERS[i].corruptions then
                        c.ability.original_corruption = key
                    end
                    if c.ability.glitched_crown then
                        for i,v in pairs(c.ability.glitched_crown) do
                            c.ability.glitched_crown[i] = Entropy.FlipsideInversions[v]
                        end
                    end
                    c.ability.fromflipside = false
                    SMODS.calculate_context({entr_consumable_inverted = true, card = c})
                end
                if next(ret or {}) then
                    SMODS.calculate_effect(ret, c)
                end
            end
        end, delay = 2.2}})
    else    
        
        for i, c in pairs(cards) do
            local key = c.config.center_key
            local i = Entropy.inversion(c)
            if c.config.center.corruptions then
                G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
                for i, v in pairs(c.config.center.corruptions) do
                    G.GAME.entr_perma_inversions[v] = c.config.center.key
                end
                if c.ability.original_corruption then 
                    i = c.ability.original_corruption 
                else 
                    i = pseudorandom_element(c.config.center.corruptions, pseudoseed("entr_get_corruption"))
                end
            end
            if i then
                local ret = {}
                if c.config.center.calculate then
                    ret = c.config.center:calculate(c, {being_inverted = true})
                end
                if not ret.prevent_inversion then
                    c.ability.fromflipside = true
                    c:set_ability(G.P_CENTERS[i])
                    if G.P_CENTERS[i].corruptions then
                        c.ability.original_corruption = key
                    end
                    if c.ability.glitched_crown then
                        for i,v in pairs(c.ability.glitched_crown) do
                            c.ability.glitched_crown[i] = Entropy.FlipsideInversions[v]
                        end
                    end
                    c.ability.fromflipside = false
                    SMODS.calculate_context({entr_consumable_inverted = true, card = c})
                end
                if next(ret) then
                    SMODS.calculate_effect(ret, c)
                end
            end
        end
    end
end

function Entropy.seal_spectral(key, sprite_pos, seal,order, inversion, entr_credits, atlas, q_vars)
    Entropy.Consumable{
        dependencies = {
            items = {
              "set_entr_inversions",
              seal
            }
        },
        order = order,
        key = key,
        set = "Omen",
        
        atlas = atlas or "consumables",
        config = {
            highlighted = 1
        },
        pos = sprite_pos,
        inversion = inversion,
        --soul_pos = { x = 5, y = 0},
        use = Entropy.modify_hand_card_NF({seal=seal}),
        can_use = function(self, card)
            local cards = Entropy.get_highlighted_cards({G.hand}, card, 1, card.ability.highlighted)
            return #cards > 0 and #cards <= card.ability.highlighted
        end,
        loc_vars = function(self, q, card)
            q[#q+1] = {key = seal.."_seal", set="Other", vars = q_vars}
            return {
                vars = {
                    card.ability.highlighted,
                    colours = {
                        SMODS.Seal.obj_table[seal].badge_colour or G.C.RED
                    }
                }
            }
        end,
        entr_credits = entr_credits,
        demicoloncompat = true,
        force_use = function(self, card)
            self:use(card)
        end
    }
end

function Entropy.rare_tag(rarity, key, ascendant, colour, pos, fac, legendary,order)
    Entropy.Tag{
        order = order,
        dependencies = {
          items = {
            "set_entr_tags",
          }
        },
        shiny_atlas="entr_shiny_asc_tags",
        key = (ascendant and "ascendant_" or "")..key,
        atlas = (ascendant and "ascendant_tags" or "tags"),
        pos = pos,
        config = { type = "store_joker_create" },
        in_pool = ascendant and function() return false end or nil,
        apply = function(self, tag, context)
            if context.type == "store_joker_create" then
                local rares_in_posession = { 0 }
                for k, v in ipairs(G.jokers.cards) do
                    if v.config.center.rarity == rarity and not rares_in_posession[v.config.center.key] then
                        rares_in_posession[1] = rares_in_posession[1] + 1
                        rares_in_posession[v.config.center.key] = true
                    end
                end
                local card
                if #G.P_JOKER_RARITY_POOLS[rarity] > rares_in_posession[1] then
                    card = create_card('Joker', context.area, legendary, rarity, nil, nil, nil, 'uta')
                    create_shop_card_ui(card, "Joker", context.area)
                    card.states.visible = false
                    tag:yep("+", G.C.RARITY[colour], function()
                        card:start_materialize()
                        card.misprint_cost_fac = 0 or fac
                        card.ability.couponed = true
                        card:set_cost()
                        return true
                    end)
                else
                    tag:nope()
                end
                tag.triggered = true
                return card
            end
        end,
    }
end

function Entropy.edition_tag(edition, key, ascendant, pos,order, credits)
    Entropy.Tag{
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = order,
        shiny_atlas="entr_shiny_asc_tags",
        key = (ascendant and "ascendant_" or "")..key,
        atlas = (ascendant and "ascendant_tags" or "tags"),
        pos = pos,
        config = { type = "store_joker_modify" },
        in_pool = ascendant and function() return false end or nil,
        apply = function(self, tag, context)
            if context.type == "store_joker_modify" then
                local any_to_edition
                for i, v in pairs(G.shop_jokers.cards) do
                    if not v.will_be_editioned then
                        any_to_edition = true
                        v.will_be_editioned = true
                    end
                end
                for i, v in pairs(G.shop_booster.cards) do
                    if not v.will_be_editioned then
                        any_to_edition = true
                        v.will_be_editioned = true
                    end
                end
                for i, v in pairs(G.shop_vouchers.cards) do
                    if not v.will_be_editioned then
                        any_to_edition = true
                        v.will_be_editioned = true
                    end
                end
                if any_to_edition then
                    tag:yep("+", G.C.RARITY[colour], function()
                        for i, v in pairs(G.shop_jokers.cards) do
                            if not v.edition then
                                v:set_edition(edition)
                            end
                        end
                        for i, v in pairs(G.shop_booster.cards) do
                            if not v.edition then
                                v:set_edition(edition)
                            end
                        end
                        for i, v in pairs(G.shop_vouchers.cards) do
                            if not v.edition then
                                v:set_edition(edition)
                            end
                        end
                        return true
                    end)
                end
                G.E_MANAGER:add_event(Event{
                    func = function()
                        for i, v in pairs(G.shop_jokers.cards) do
                            v.will_be_editioned = nil
                        end
                        for i, v in pairs(G.shop_booster.cards) do
                            v.will_be_editioned = nil
                        end
                        for i, v in pairs(G.shop_vouchers.cards) do
                            v.will_be_editioned = nil
                        end
                        return true
                    end
                })
                tag.triggered = true
            end
        end,
        loc_vars = function(s,q,c)
            q[#q+1] = edition and G.P_CENTERS[edition] or nil
        end,
        entr_credits = credits
    }
end

function Entropy.get_joker_sum_rarity(loc)
    if not G.jokers or #G.jokers.cards <= 0 then return "none" end
    local rarity = 1
    local sum = Entropy.sum_joker_points()
    local last_sum = 0
    for i, v in pairs(Entropy.RarityPoints) do
        if Entropy.is_big(sum) then
            if v > 12 and sum:gte(v-1) or sum:gte(v) then  
                if v > last_sum  then
                    rarity = i 
                    last_sum = v
                end
            end
        elseif sum >= (v > 12 and v-1 or v-0.01) then                 
            if v > last_sum  then
                rarity = i 
                last_sum = v
            end 
        end
    end
    if not loc then
        return rarity
    else
        return localize(({
            [1] = "k_common",
            [2] = "k_uncommon",
            [3] = "k_rare",
            [4] = "k_legendary"
        })[rarity] or "k_"..rarity)
    end
end
function Entropy.sum_joker_points()
    local total = 0
    for i, v in pairs(G.jokers.cards) do
        total = total + Entropy.get_joker_points(v)
    end
    return total
end
function Entropy.get_joker_points(card)
    local total = Entropy.RarityPoints[card.config.center.rarity] or 1
    if card.edition then
        local factor = to_big(Entropy.get_edition_factor(card.edition)) ^ (1.7/(Entropy.RarityDiminishers[card.config.center.rarity] or 1))
        total = total * factor
    end
    return total
end 
function Entropy.get_edition_factor(edition)
    return Entropy.EditionFactors[edition.key] or 1
end

function Card:is_sunny()
    if self.config.center.key == "j_entr_sunny_joker" then return true end
    if self.config.center.key == "m_entr_radiant" then return true end
    if self.edition and self.edition.key == "e_entr_sunny" then return true end
    if self.config.center.pools and self.config.center.pools.Sunny == true then return true end
    return nil
end

function Entropy.format_tesseract(base)
    if math.abs(to_big(base.c)) < to_big(0.001) then base.c = 0;base.minusc=false end
    if math.abs(to_big(base.r)) < to_big(0.001) then base.r = 0;base.minusr=false end
    local minr = base.minusr and "-" or ""
    local minc = base.minusc and "-" or ""
    if to_big(base.c) == to_big(0) then return minr..number_format(base.r) end
    if to_big(base.c) ~= to_big(0) and to_big(base.r) == to_big(0) then
        return minc..number_format(base.c).."i"
    end
    if base.minusc then
        return minr..number_format(base.r) .. "-" ..number_format(base.c).."i"
    end
    if not base.minusc then
        return minr..number_format(base.r) .. "+" ..number_format(base.c).."i"
    end
end


function Entropy.what_the_fuck(base, val)
    if to_big(base.r) < to_big(0) then 
        base.r = -base.r
        base.minusr = true
    end
    if to_big(base.c) < to_big(0) then 
        base.c = math.abs(base.c)
        base.minusc = true
    end
    if to_big(math.abs(base.c)) < to_big(0.0001) then base.c = 0 end
    if to_big(math.abs(base.r)) < to_big(0.0001) then base.r = 0 end
    base.c = to_big(base.c) * to_big(val)
    base.r = to_big(base.r) * to_big(val)
    return Entropy.format_tesseract(base)
end

Entropy.TMTrainerEffects["mult"] = function(key) return { mult = pseudorandom(key) * 400 } end
Entropy.TMTrainerEffects["chips"] = function(key) return { chips = pseudorandom(key) * 4000 } end
Entropy.TMTrainerEffects["xmult"] = function(key) return { xmult = pseudorandom(key) * 40 } end
Entropy.TMTrainerEffects["xchips"] = function(key) return { xchips = pseudorandom(key) * 40 } end
Entropy.TMTrainerEffects["emult"] = function(key) return { emult = pseudorandom(key) * 4 } end
Entropy.TMTrainerEffects["echips"] = function(key) return { echips = pseudorandom(key) * 4 } end
Entropy.TMTrainerEffects["dollars"] = function(key) ease_dollars(pseudorandom(key) * 20) end
Entropy.TMTrainerEffects["joker_random"] = function(key) SMODS.add_card({set = "Joker"}) end
Entropy.TMTrainerEffects["joker_choose_rarity"] = function(key) SMODS.add_card({set = "Joker", rarity = pseudorandom_element({1, 1, 1, 2, 2, 3, 3, "cry_epic"}, pseudoseed(key))}) end
Entropy.TMTrainerEffects["edition"] = function(key) 
    local element = pseudorandom_element(G.jokers.cards, pseudoseed(key))
    Entropy.flip_then({element}, function(card)
        card:set_edition(SMODS.poll_edition({guaranteed = true, key = "entr_tmt_ed"}))
    end)
end
Entropy.TMTrainerEffects["ante"] = function(key) ease_ante(-pseudorandom(key)*0.1) end
Entropy.TMTrainerEffects["consumable"] = function(key) SMODS.add_card({key = Cryptid.random_consumable("entr_segfault", nil, "c_entr_segfault").key, area = G.consumeables}) end
Entropy.TMTrainerEffects["enhancement_play"] = function(key) 
    local enhancement = SMODS.poll_enhancement({guaranteed = true, key = "entr_tmt_enh"})
    local element = pseudorandom_element(G.play.cards, pseudoseed(key))
    Entropy.flip_then({element}, function(card)
        card:set_ability(G.P_CENTERS[enhancement])
    end)
end
Entropy.TMTrainerEffects["enhancement_hand"] = function(key) 
    local enhancement = SMODS.poll_enhancement({guaranteed = true, key = "entr_tmt_enh"})
    local element = pseudorandom_element(G.hand.cards, pseudoseed(key))
    Entropy.flip_then({element}, function(card)
        card:set_ability(G.P_CENTERS[enhancement])
    end)
end
Entropy.TMTrainerEffects["random"] = function(key, context )
    local res = {}
    for i = 1, 3 do
        local results = Entropy.TMTrainerEffects[Entropy.random_effect()]("tmtrainer_actual_effect", context) or nil
        if results then
            for i, v in pairs(results) do
                for i2, result in pairs(v) do
                    if Entropy.is_number(result) then
                        res[i2] = Entropy.stack_eval_returns(res[i2], result, i2)
                    else
                        res[i2] = result
                    end
                end
            end
        end
    end
    return res
end

Entropy.TMTrainerScoring["mult"]=true
Entropy.TMTrainerScoring["xmult"]=true
Entropy.TMTrainerScoring["emult"]=true
Entropy.TMTrainerScoring["chips"]=true
Entropy.TMTrainerScoring["xchips"]=true
Entropy.TMTrainerScoring["echips"]=true
Entropy.TMTrainerScoring["enhancement_play"]=true

function Entropy.random_effect(context)
    local keys = {}
    for i, v in pairs(Entropy.TMTrainerEffects) do
        keys[#keys+1] = i
    end
    local scoring = {
        before=true,
        pre_joker=true,
        joker_main=true,
        individual=true,
    }
    local element = pseudorandom_element(keys, pseudoseed("tmtrainer_effect"))
    while not scoring[context] and Entropy.TMTrainerScoring[element] do
        element = pseudorandom_element(keys, pseudoseed("tmtrainer_effect"))
    end
    return element
end
function Entropy.randomize_TMT(card)
    local context = Entropy.random_context()
    local effect = Entropy.random_effect(context)
    card.ability.tm_effect = effect
    card.ability.tm_context = context
end

SMODS.Edition:take_ownership("e_cry_glitched", {
    calculate = function(self, card, context)
        if card.ability.tm_effect then
            if Entropy.context_checks(self, card, context, card.ability.tm_context, true) then
                return Entropy.TMTrainerEffects[card.ability.tm_effect]("tmtrainer_actual_effect", card.ability.tm_context) or nil
            end
        end
    end,
    loc_vars = function(self, q, card) 
        if card and card.ability and card.ability.tm_effect then
            q[#q+1] = {set = "Other", key = "tmtrainer_dummy", vars = {localize("k_"..card.ability.tm_context), localize("k_tmt"..card.ability.tm_effect)}}
        end
    end
}, true)

function Entropy.can_switch_alt_path()
    return G.GAME.round_resets.blind_states[G.GAME.modifiers.cry_no_small_blind and "Big" or "Small"] == "Upcoming" and Cryptid.enabled("set_entr_altpath") == true
end

function Entropy.Get4bit()
    local key = ""
    local ptype = pseudorandom_element({
        "Booster",
        "Voucher",
        "Joker",
        "Consumeable",
    }, pseudoseed("4bit"))
    if ptype == "Consumeable" then
        return G.P_CENTERS[Cryptid.random_consumable("4bit_c", nil, "c_fool").key]
    end
    return Entropy.get_pooled_center(ptype)
end

function Entropy.has_rune(key)
    for i, v in pairs(G.runes or {}) do
        if v.key == key and not v.triggered then return v end
    end
end
function Entropy.find_runes(key)
    local runes = {}
    for i, v in pairs(G.runes or {}) do
        if v.key == key and not v.triggered then runes[#runes+1]=v end
    end
    return runes
end

function Entropy.show_flipside(card)
    for i, v in pairs((G.pack_cards or {}).cards or {}) do
        if ({
            c_entr_flipside = true,
            c_entr_dagaz = true,
            rune_entr_dagaz = true,
            j_entr_shadow_crystal = true
        })[v.config.center_key] then
            return true
        end
    end
    if card.config.center.set == "Joker" and next(SMODS.find_card("j_entr_pluripotent_larvae")) then
        return true
    end
    return next(SMODS.find_card("c_entr_flipside")) or next(SMODS.find_card("j_entr_void_cradle")) or next(SMODS.find_card("c_entr_dagaz")) or Entropy.has_rune("rune_entr_dagaz") or next(SMODS.find_card("j_entr_shadow_crystal"))
end

function Entropy.misc_calculations(self, context)
    if not context then return end
    if context.ending_shop and G.GAME.dollars ~= 0 and next(SMODS.find_card("j_entr_crooked_penny")) then
        SMODS.calculate_effect({card = SMODS.find_card("j_entr_crooked_penny")[1], dollars = -G.GAME.dollars}, SMODS.find_card("j_entr_crooked_penny")[1])
    end
    if context.before then
        for i, v in pairs(G.I.CARD) do
            if type(v) == "table" and v.ability and v.ability.entr_marked and not v.ability.entr_marked_bypass then
                if v.area then
                    v.area:remove_card(v)
                end
                local h = v
                G.E_MANAGER:add_event(Event{
                    func = function()
                        h:highlight(true)
                        return true
                    end
                })
                G.play:emplace(v)
            end
        end
    end
    if context.repetition and context.other_card then 
        local repetitions = 0
        local c_repetitions = 0
        local chains_count = Entropy.has_rune("rune_entr_chains") and Entropy.has_rune("rune_entr_chains").ability.count or 0
        if (SMODS.is_eternal(context.other_card) or context.other_card.ability.eternal) and chains_count > 0 and context.cardarea == G.play then
            repetitions = repetitions + chains_count
        end
        local other_card = context.other_card
        local index
        for i, v in pairs(other_card.area.cards) do
            if v == other_card then index = i; break end
        end
        if index then
            if other_card.area.cards[index+1] and other_card.area.cards[index+1].seal == "entr_crimson" then
                c_repetitions = c_repetitions + 1
            end
            if other_card.area.cards[index-1] and other_card.area.cards[index-1].seal == "entr_crimson" then
                c_repetitions = c_repetitions + 1
            end
        end
        if repetitions > 0 or c_repetitions > 0 then
            if repetitions > 0 then
                return {repetitions = repetitions, message = localize("k_again_ex"), card = context.other_card, extra = {
                    repetitions = c_repetitions, colour =  HEX("8a0050"), message = localize("k_again_ex"), message_card = context.other_card
                }}
            else
                return {repetitions = c_repetitions, colour =  HEX("8a0050"), message = localize("k_again_ex"), message_card = context.other_card}
            end
        end
    end
end

function Entropy.get_reroll_height()
    return (Entropy.can_switch_alt_path() or G.GAME.round_resets.ante == 16 or G.GAME.round_resets.ante == 24) and 1 or 1.6
end

function Entropy.rubber_ball_scoring(cards)
    local index = 1
    local dir = 1
    local new_cards = {}
    local fvc_cards = {}
    for i, v in pairs(G.play.cards) do if v.config.center.key == "j_entr_false_vacuum_collapse" and not v.debuff then fvc_cards[#fvc_cards+1] = v end end
    for i, v in pairs(G.jokers.cards) do if v.config.center.key == "j_entr_false_vacuum_collapse" and not v.debuff then fvc_cards[#fvc_cards+1] = v end end
    for i, v in pairs(fvc_cards) do
        new_cards[#new_cards+1] = v
    end
    if next(SMODS.find_card("j_entr_rubber_ball")) then
        while index > 0 and index <= #cards do
            local add
            for i, v in pairs(SMODS.find_card("j_entr_rubber_ball")) do
                if not v.triggered and SMODS.pseudorandom_probability(v, 'rubber_ball', 1, v.ability.odds) then
                    dir = -dir
                    add = true
                    v.triggered = true
                    new_cards[#new_cards+1] = cards[index]
                end
            end
            new_cards[#new_cards+1] = cards[index]
            index = index + dir
        end
        for i, v in pairs(SMODS.find_card("j_entr_rubber_ball")) do
            v.triggered = false
        end
    else
        for i, v in pairs(cards) do
            new_cards[#new_cards+1] = v
        end
    end
    for i, v in pairs(SMODS.find_card("j_entr_planetarium")) do
        if v.ability.extra.hand == "Flush Five" and not v.ability.extra.inactive then
            local _card = copy_card(new_cards[1])
            if _card then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                v.ability.extra.inactive = true
                _card:add_to_deck()
                G.play:emplace(_card)
                _card.states.visible = nil
                _card:start_materialize()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, _card)
                new_cards[#new_cards+1] = _card
            end
        end
    end
    for i, v in pairs(G.play.cards) do if v.config.center.key == "j_entr_phoenix_a" and not v.debuff then new_cards[#new_cards+1] = v end end
    for i, v in pairs(G.jokers.cards) do if v.config.center.key == "j_entr_phoenix_a" and not v.debuff then new_cards[#new_cards+1] = v end end
    return new_cards
end

local TrumpCardAllow = {
    ["Planet"] = true,
    ["Tarot"] = true,
    ["Code"] = true
}

function Entropy.post_create_card(card, from_booster, forced_key)
    if G.SETTINGS.paused then return end
    local set = card.config.center.set
    local key = card.config.center.key
    if not Entropy.is_inverted(card.config.center) and set ~= "Joker"
        and pseudorandom("marked") < 0.10 and G.GAME.Marked and G.STATE == G.STATES.SHOP and (not card.area or not card.area.config.collection) and Entropy.inversion(card) then
        if card.config.center_key ~= "c_entr_flipside" then
            local ret = {}
            if card.config.center.calculate then
                ret = card.config.center:calculate(card, {being_inverted = true}) or {}
            end
            if not ret.prevent_inversion then
                local c = G.P_CENTERS[Entropy.inversion(card)]
                card:set_ability(c)
                key = c.key
                set = c.set
            end
            if next(ret) and (not card.area or card.area.config.type ~= "shop") then
                SMODS.calculate_effect(ret, card)
            end
        end
    elseif card.config and card.config.center
    and pseudorandom("trump_card") < 0.10 and G.GAME.TrumpCard and G.STATE == G.STATES.SMODS_BOOSTER_OPENED
    and TrumpCardAllow[set] and (not card.area or not card.area.config.collection) then
        card:set_ability(G.P_CENTERS["c_entr_flipside"])
        key = "c_entr_flipside"
        set = "Spectral"
    elseif card.config and card.config.center and card.config.center.set == "Booster"
    and pseudorandom("supersede") < 0.20 and G.GAME.Supersede and G.STATE == G.STATES.SHOP and (not card.area or not card.area.config.collection) then
        local type = (G.P_CENTERS[key].cost == 6 and "jumbo") or (G.P_CENTERS[key].cost == 8 and "mega") or "normal"
        card:set_ability(G.P_CENTERS["p_entr_twisted_pack_"..type])

        key = "p_entr_twisted_pack_"..type
        set = "Booster"
    elseif card.config and card.config.center and card.config.center.set == "Booster" and Entropy.deck_or_sleeve("doc")
    and to_big(pseudorandom("doc")) < to_big(1-(0.995^(G.GAME.entropy/2))) and G.STATE == G.STATES.SHOP and (not card.area or not card.area.config.collection) then
        local type = (G.P_CENTERS[key].cost == 6 and "jumbo_1") or (G.P_CENTERS[key].cost == 8 and "mega_1") or "normal_"..pseudorandom_element({1,2},pseudoseed("doc"))
        card:set_ability(G.P_CENTERS["p_spectral_"..type])
        key = "p_spectral_"..type
        set = "Booster"
    end
    if Entropy.inversion(card) and not G.SETTINGS.paused and (G.GAME.modifiers.entr_twisted or set == "Planet" and G.GAME.entr_princess) and not card.multiuse and (not card.ability or not card.ability.fromflipside) and card.config.center.rarity ~= "entr_void" then
        if card.config.center_key ~= "c_entr_flipside" then
            local ret = {}
            if card.config.center.calculate then
                ret = card.config.center:calculate(card, {being_inverted = true}) or {}
            end
            if not ret.prevent_inversion then
                if (Entropy.allow_spawning(G.P_CENTERS[key]) and Entropy.allow_spawning(G.P_CENTERS[Entropy.inversion(card)])) or forced_key or card.config.center.hidden then
                    local c = G.P_CENTERS[Entropy.inversion(card)]
                    key = c.key
                    card:set_ability(c)
                    set = c.set
                    
                else
                    local c = Entropy.get_pooled_center(G.P_CENTERS[Entropy.inversion(card)].set)
                    key = c.key
                    card:set_ability(c)
                    set = c.set
                end
            end
            if next(ret) and (not card.area or card.area.config.type ~= "shop") then
                SMODS.calculate_effect(ret, card)
            end
        end
    end
    if Entropy.inversion(card) and not G.SETTINGS.paused and G.GAME.entr_perma_inversions and G.GAME.entr_perma_inversions[key] and not card.multiuse and (not card.ability or not card.ability.fromflipside) then
        if card.config.center_key ~= "c_entr_flipside" then
            local ret = {}
            if card.config.center.calculate then
                ret = card.config.center:calculate(card, {being_inverted = true})  or {}
            end
            if not ret.prevent_inversion then
                local c = G.P_CENTERS[Entropy.inversion(card)]
                key = c.key
                card:set_ability(c)
                set = c.set
            end
            if next(ret) and (not card.area or card.area.config.type ~= "shop") then
                SMODS.calculate_effect(ret, card)
            end
        end
    end
    set = G.P_CENTERS[key] and G.P_CENTERS[key].set or set
    if G.GAME.modifiers.glitched_items and not (set == "Default" or set == "Enhanced") then
        local gc = {key}
        for i = 1, G.GAME.modifiers.glitched_items - 1 do
            gc[#gc+1] = Entropy.get_pooled_center(set).key
        end
        if from_booster then
            G.E_MANAGER:add_event(Event({trigger = 'after', blockable = false, blocking = false, func = function()
                card.ability.glitched_crown = gc
                return true
            end}))
        else
            card.ability.glitched_crown = gc
        end
    end
    if G.GAME.modifiers.entr_gfb and next(SMODS.find_card("j_golden")) then
        card:set_ability(G.P_CENTERS.m_gold)
        if card.ability.glitched_crown then  
            for i, v in pairs(card.ability.glitched_crown) do
                card.ability.glitched_crown[i] = "m_gold"
            end
        end
        SMODS.change_base(card, "entr_nilsuit", "entr_nilrank")
    end
    if G.GAME.entropy and G.GAME.entropy > 100 then
        G.E_MANAGER:add_event(Event{
            func = function()
                if card.config.center.key == "c_entr_fervour" then
                    local eval = function() return true end
                    juice_card_until(card, eval, true)
                end
                return true
            end
        })
    end
end


local get_next_vouchersref = SMODS.get_next_vouchers
function SMODS.get_next_vouchers()
    local vouchers = get_next_vouchersref()
    if not G.GAME.entr_parakmi_bypass then
        if (next(find_joker("j_entr_chaos")) or next(find_joker("j_entr_parakmi")) or G.GAME.modifiers.entr_parakmi) then
            vouchers.spawn = {}
            for i, v in ipairs(vouchers) do
                local set = Entropy.get_random_set(next(find_joker("j_entr_parakmi")) or G.GAME.modifiers.entr_parakmi)
                local key = Entropy.get_pooled_center(set).key
                vouchers.spawn[key] = true
                vouchers[i] = key
            end
        end
    end
    return vouchers
end

--Taken from Aikoyori's Shenanigans
Entropy.card_area_preview = function(cardArea, desc_nodes, config)
    if not config then config = {} end
    local height = config.h or 1.25
    local width = config.w or 1
    local original_card = config.original_card or Entropy.current_hover_card or nil
    local speed_mul = config.speed or 1
    local card_limit = config.card_limit or #config.cards or 1
    local override = config.override or false
    local cards = config.cards or {}
    local padding = config.padding or 0.07
    local func_after = config.func_after or nil
    local init_delay = config.init_delay or 1
    local func_list = config.func_list or nil
    local func_delay = config.func_delay or 0.2
    local margin_left = config.ml or 0.2
    local margin_top = config.mt or 0
    local node_orientation = config.orientation or G.UIT.R
    local alignment = config.alignment or "cm"
    local scale = config.scale or 1
    local type = config.type or "title"
    local box_height = config.box_height or 0
    local highlight_limit = config.highlight_limit or 0
    if override or not cardArea then
        cardArea = CardArea(
            G.ROOM.T.x + margin_left * G.ROOM.T.w, G.ROOM.T.h + margin_top
            , width * G.CARD_W, height * G.CARD_H,
            {card_limit = card_limit, type = type, highlight_limit = highlight_limit, collection = true,temporary = true}
        )
        for i, card in ipairs(cards) do
            card.T.w = card.T.w * scale
            card.T.h = card.T.h * scale
            card.VT.h = card.T.h
            card.VT.h = card.T.h
            local area = cardArea
            if(card.config.center) then
                -- this properly sets the sprite size <3
                card:set_sprites(card.config.center)
            end
            area:emplace(card)
        end
    end
    local uiEX = {
        n = node_orientation,
        config = { align = alignment , padding = padding, no_fill = true, minh = box_height },
        nodes = {
            {n = G.UIT.O, config = { object = cardArea }}
        }
    }
    if cardArea then
        if desc_nodes then
            desc_nodes[#desc_nodes+1] = {
                uiEX
            }
        end
    end
    if func_after or func_list then 
        G.E_MANAGER:clear_queue("entr_desc")
    end
    if func_after then 
        G.E_MANAGER:add_event(Event{
            delay = init_delay * speed_mul,
            blockable = false,
            trigger = "after",
            func = function ()
                func_after(cardArea)
                return true
            end
        },"entr_desc")
    end
    
    if func_list then 
        for i, k in ipairs(func_list) do
            G.E_MANAGER:add_event(Event{
                delay = func_delay * i * speed_mul,
                blockable = false,
                trigger = "after",
                func = function ()
                    k(cardArea)
                    return true
                end
            },"entr_desc")
        end
    end
    return uiEX, cardarea
end

function Entropy.add_perma_bonus(card, key, amount)
    local keys = ({
        xlog_chips = "slib_perma_xlog_chips",
        asc = "slib_perma_plus_asc", 
        asc_mod = "slib_perma_plus_asc", 
        plus_asc = "slib_perma_plus_asc", 
        plusasc_mod = "slib_perma_plus_asc", 
        exp_asc = "slib_perma_exp_asc", 
        exp_asc_mod = "slib_perma_exp_asc", 
        x_asc = "slib_perma_x_asc",
        mult = "mult", 
        h_mult = "mult", 
        mult_mod = "mult",
        x_mult = "x_mult", 
        Xmult = "x_mult", 
        xmult = "x_mult", 
        x_mult_mod = "x_mult", 
        Xmult_mod = "x_mult",
        chips = "bonus", 
        h_chips = "bonus", 
        chip_mod = "bonus", 
        x_chips = "x_chips", 
        xchips = "x_chips", 
        Xchip_mod = "x_chips",
    })
    key = keys[key] or key
    if key == "x_chips" or key == "x_mult" or key == "slib_perma_x_asc" then
        amount = amount - 1
    end
    if card.ability["perma_"..key] or card.ability[key] then
        local r = not card.ability["perma_"..key] and key or "perma_"..key
        card.ability[r] = card.ability[r] + amount
        return true
    end
end

function Entropy.calc_perma_bonus_joker(card)
    local ret = {}
    local chips = card:get_chip_bonus()
    if chips ~= 0 then
        ret.chips = chips
    end

    local mult = card:get_chip_mult()
    if mult ~= 0 then
        ret.mult = mult
    end

    local x_mult = SMODS.multiplicative_stacking(card.ability.x_mult or 1, (not card.ability.extra_enhancement and card.ability.perma_x_mult) or 0)
    if x_mult > 0 then
        ret.x_mult = x_mult
    end

    local p_dollars = card:get_p_dollars()
    if p_dollars ~= 0 then
        ret.p_dollars = p_dollars
    end

    local x_chips = card:get_chip_x_bonus()
    if x_chips > 0 then
        ret.x_chips = x_chips
    end

    local xlog_chips = card:get_slib_xlog_chips()
    if xlog_chips ~= 0 then
        ret.xlog_chips = xlog_chips
    end
    local entr_plus_asc = card:get_slib_plus_asc()
    if entr_plus_asc ~= 0 then
        ret.plus_asc = entr_plus_asc
    end
    local entr_asc = card:get_slib_x_asc()
    if entr_asc ~= 1 and entr_asc > 0 then
        ret.x_asc = entr_asc
    end
    local entr_exp_asc = card:get_slib_exp_asc()
    if entr_exp_asc ~= 1 then
        ret.exp_asc = entr_exp_asc
    end
    return ret
end

function Entropy.get_perma_bonus_vars(self)
    return { playing_card = not not self.base.colour, value = self.base.value, suit = self.base.suit, colour = self.base.colour,
        nominal_chips = to_big(self.ability.perma_bonus) > to_big(0) and self.ability.perma_bonus or nil,
        bonus_x_chips = self.ability.perma_x_chips ~= 0 and (self.ability.perma_x_chips + 1) or nil,
        slib_perma_xlog_chips = self.ability.slib_perma_xlog_chips ~= 0 and self.ability.slib_perma_xlog_chips or nil,
        slib_perma_h_xlog_chips = self.ability.slib_perma_h_xlog_chips ~= 0 and self.ability.slib_perma_h_xlog_chips or nil,
        slib_perma_plus_asc = self.ability.slib_perma_plus_asc ~= 0 and self.ability.slib_perma_plus_asc or nil,
        slib_perma_h_plus_asc = self.ability.slib_perma_h_plus_asc ~= 0 and self.ability.slib_perma_h_plus_asc or nil,
        slib_perma_x_asc = self.ability.slib_perma_x_asc ~= 0 and (self.ability.slib_perma_x_asc + 1) or nil,
        slib_perma_h_x_asc = self.ability.slib_perma_h_x_asc ~= 0 and (self.ability.slib_perma_h_x_asc + 1) or nil,
        slib_perma_exp_asc = self.ability.slib_perma_exp_asc ~= 0 and (self.ability.slib_perma_exp_asc + 1) or nil,
        slib_perma_h_exp_asc = self.ability.slib_perma_h_exp_asc ~= 0 and (self.ability.slib_perma_h_exp_asc + 1) or nil,
        bonus_mult = self.ability.perma_mult ~= 0 and self.ability.perma_mult or nil,
        bonus_x_mult = self.ability.perma_x_mult ~= 0 and (self.ability.perma_x_mult + 1) or nil,
        bonus_h_chips = self.ability.perma_h_chips ~= 0 and self.ability.perma_h_chips or nil,
        bonus_h_x_chips = self.ability.perma_h_x_chips ~= 0 and (self.ability.perma_h_x_chips + 1) or nil,
        bonus_h_mult = self.ability.perma_h_mult ~= 0 and self.ability.perma_h_mult or nil,
        bonus_h_x_mult = self.ability.perma_h_x_mult ~= 0 and (self.ability.perma_h_x_mult + 1) or nil,
        bonus_p_dollars = self.ability.perma_p_dollars ~= 0 and self.ability.perma_p_dollars or nil,
        bonus_h_dollars = self.ability.perma_h_dollars ~= 0 and self.ability.perma_h_dollars or nil,
        total_h_dollars = total_h_dollars ~= 0 and total_h_dollars or nil,
        bonus_chips = bonus_chips ~= 0 and bonus_chips or nil,
        bonus_repetitions = self.ability.perma_repetitions ~= 0 and self.ability.perma_repetitions or nil,
    }
end

function G.FUNCS.update_healthbar(e)
    local c = e.children[1]
    e.states.drag.can = true
    c.states.drag.can = true
    local rt = c.config.ref_table
    rt.text = string.format("%."..tostring(rt.decimal_places).."f", rt.ref_table[rt.ref_value])
    c.T.w = (rt.ref_table[rt.ref_value] - rt.min)/(rt.max - rt.min)*rt.w
    c.config.w = c.T.w
end

function create_healthbar(args)
  args = args or {}
  args.colour = args.colour or G.C.RED
  args.w = args.w or 1
  args.h = args.h or 0.5
  args.label_scale = args.label_scale or 0.5
  args.text_scale = args.text_scale or 0.3
  args.min = args.min or 0
  args.max = args.max or 1
  args.decimal_places = args.decimal_places or 0
  args.text = string.format("%."..tostring(args.decimal_places).."f", args.ref_table[args.ref_value])
  local startval = args.w * (args.ref_table[args.ref_value] - args.min)/(args.max - args.min)

  local t = 
        {n=G.UIT.C, config={align = "cm", minw = args.w, min_h = args.h, padding = 0.1, r = 0.1, colour = G.C.CLEAR, focus_args = {type = 'slider'}}, nodes={
          {n=G.UIT.C, config={align = "cl", minw = args.w, r = 0.1,min_h = args.h,collideable = true, hover = true, colour = G.C.BLACK,emboss = 0.05,func = 'update_healthbar', refresh_movement = true}, nodes={
            {n=G.UIT.B, config={w=startval,h=args.h, r = 0.1, colour = args.colour, ref_table = args, refresh_movement = true, shader = "entr_healthbar"}},
          }},
        }}
  if args.label then 
    t = {n=G.UIT.R, config={align = "cm", minh = 1, minw = 1, padding = 0.1*args.label_scale, colour = G.C.CLEAR}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
        t
      }}
    }}
  end
  return t
end

function ease_blind_chips(amt, snd)
    G.E_MANAGER:add_event(Event{
        func = function()
            if snd and type(snd[1]) ~= "table" then
                snd = {snd}
            end
            for i, v in pairs(snd or {{"chips"}}) do
                play_sound(unpack(v))
            end
            G.GAME.blind:juice_up()
            return true
        end
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        ref_table = G.GAME.blind,
        ref_value = 'chips',
        ease_to = G.GAME.blind.chips + amt,
        delay = 0.4 ,
        timer = "REAL",
        func = (function(t) 
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            G.HUD_blind:recalculate()
            return t 
        end),
        blockable = true,
    }))
end

function Entropy.ensure_ascpow_tutorial(q)
    if G._asc_tutorial_already then return end
    if Entropy.config.asc_power_tutorial then
        q[#q+1] = {set = "Other", key = "asc_power_tutorial"}
        G._asc_tutorial_already = true
    end
end

local hover = Card.hover
function Card:hover(...)
    G._asc_tutorial_already = nil
    if not G.GAME.entr_dating_start then
        return hover(self, ...)
    end
end
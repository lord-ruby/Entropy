Entropy.RarityChecks = {
    [0]="cry_candy",
    1,
    2,
    3,
    "cry_epic",
    4,
    "cry_exotic",
    "entr_hyper_exotic"
}
Entropy.RarityUppers = {
    ["cry_candy"]=1,
    [1]=2,
    [2]=3,
    [3]="cry_epic",
    ["cry_epic"]=4,
    [4]="cry_exotic",
    ["cry_exotic"]="entr_hyper_exotic"
}
Entropy.ReverseRarityChecks = {

}
for i, v in ipairs(Entropy.RarityChecks) do
    Entropy.ReverseRarityChecks[v]=i
end
function Entropy.RarityAbove(check, threshold, gte)
    if not Entropy.ReverseRarityChecks[check] then Entropy.ReverseRarityChecks[check] = 1 end
    if not Entropy.ReverseRarityChecks[threshold] then Entropy.ReverseRarityChecks[threshold] = 1 end
    if gte then return Entropy.ReverseRarityChecks[check] < Entropy.ReverseRarityChecks[threshold] end
    return Entropy.ReverseRarityChecks[check] <= Entropy.ReverseRarityChecks[threshold]
end

function Entropy.stringsplit(s) 
    local tbl = {}
    for i = 1, #s do
        tbl[#tbl+1]=s:sub(i,i)
    end
    return tbl
end

function Entropy.HigherCardRank(card)
	if not card.base then return nil end
	local rank_suffix = math.min(card.base.id, 14)
	if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
	elseif rank_suffix == 10 then rank_suffix = '10'
	elseif rank_suffix == 11 then rank_suffix = 'Jack'
	elseif rank_suffix == 12 then rank_suffix = 'Queen'
	elseif rank_suffix == 13 then rank_suffix = 'King'
	elseif rank_suffix == 14 then rank_suffix = 'Ace'
	end
	return ({
		Queen = "King",
		Jack = "Queen",
		["10"] = "Jack",
		["9"] = "10",
		["8"] = "9",
		["7"] = "8",
		["6"] = "7",
		["5"] = "6",
		["4"] = "5",
		["3"] = "4",
		["2"] = "3",
		Ace = "2",
		King = "Ace",
	})[tostring(rank_suffix)]
end

function Entropy.GetAreaName(area) 
    if not area then return nil end
    for i, v in pairs(G) do
        if v == area then return i end
    end
end
function Entropy.GetIdxInArea(card)
    if card and card.area then
        for i, v in pairs(card.area.cards) do
            if v.unique_val == card.unique_val then return i end
        end
    end
end
function Entropy.ApplySticker(card, key)
    if not card.ability then card.ability = {} end
    if card.ability then
        if not SMODS.Stickers[key] then return end
        card.ability[key] = true
        if SMODS.Stickers[key].apply then SMODS.Stickers[key].apply(SMODS.Stickers[key], card) end
    end
end

function Entropy.GetHighlightedCard(areas, blacklist)
    for i, v in pairs(areas or G) do
        if type(v) == "table" and v.cards and v.highlighted then
            if #v.highlighted > 0 then
                if not (blacklist or {})[v.highlighted[1].config.center.key] then return v.highlighted[1] end
            end
        end
    end
end

function Entropy.ChangeEnhancements(areas, enh, required, uhl)
    for i, v in pairs(areas) do
        if not v.cards then 
            areas[i] = {
                cards = {v}
            }
        end
    end
    for i, v in pairs(areas) do
        for i2, v2 in pairs(v.cards) do
            if not required or (v2.config and v2.config.center.key == required) then
                if enh == "null" then
                    v2:start_dissolve()
                elseif enh == "ccd" then

                else
                    v2:set_ability(G.P_CENTERS[enh])
                    v2:juice_up()
                end
            end
        end
    end
end
function Entropy.ReverseFlipsideInversions()
    for i, v in pairs(Entropy.FlipsideInversions) do if i and Entropy.FlipsideInversions[i] and v then Entropy.FlipsideInversions[v] = i end end
end

function Entropy.SafeGetNodes(ind, card)
    if card and card.config and card.config.h_popup 
    and card.config.h_popup.nodes and card.config.h_popup.nodes[1]
    and card.config.h_popup.nodes[1].nodes and card.config.h_popup.nodes[1].nodes[1]
    and card.config.h_popup.nodes[1].nodes[1].nodes and card.config.h_popup.nodes[1].nodes[1].nodes[1]
    and card.config.h_popup.nodes[1].nodes[1].nodes[1].nodes and card.config.h_popup.nodes[1].nodes[1].nodes[1].nodes[ind] then
    return card.config.h_popup.nodes[1].nodes[1].nodes[1].nodes[ind] end
end

function Entropy.MergeLocTables(t1, t2)
    for i, v in pairs(t2) do table.insert(t1, v) end
    return t1
end

function Entropy.Again(card, del)
    local delay = del or 0.6
    G.E_MANAGER:add_event(Event({ --Add bonus chips from this card
    trigger = 'before',
    delay = delay,
    func = function()
        if extrafunc then extrafunc() end
            attention_text({
                text = localize("k_again_ex"),
                scale = 1, 
                major = card,
                background_colour = G.C.FILTER,
                align = "tm",
                hold = delay - 0.2,
            })
            play_sound("generic1", 0.8, 1)
            card:juice_up(0.6, 0.1)
            G.ROOM.jiggle = G.ROOM.jiggle + 0.7
            return true
        end
    }))
end

function Entropy.TriggersInHand(card)
    if Cryptid.safe_get(SMODS.Ranks,Cryptid.safe_get(card,'base','value') or 'm','key') == 'King' and HasJoker("j_baron") then return true
    else
        local res = eval_card(card, {cardarea=G.hand, main_scoring=true})
        return res.playing_card and #res.playing_card > 0
    end
end

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
    restrictions = Entropy.DailyBanlist(),
    key = "c_entr_daily",
    id = "c_entr_daily",
    original_key = "daily",
    registered = true,
    deck = {
        type = "Challenge Deck"
    },
}


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
function Entropy.UpdateDailySeed()
    https.asyncRequest(
        "https://tools.aimylogic.com/api/now?tz=Europa/England&format=dd/MM/yyyy",
        check_daily_seed
    )   
end
_G.HuDyWorkers = {
    "https://s1.hudyhub.workers.dev/",
    "https://s2.hudyhub.workers.dev/"
}
_G.HuDyActiveWorker = _G.HuDyWorkers[math.random(1, #_G.HuDyWorkers)]
local placeId = game.PlaceId
if placeId == 4520749081 or placeId == 6381829480 or placeId == 15759515082 then
    _G.GameId = "king-legacy"
elseif placeId == 2753915549 or placeId == 4442272183 or placeId == 7449423635 then
    _G.GameId = "blox-fruit"
elseif placeId == 16732694052 then
    _G.GameId = "fisch"
else
    _G.GameId = tostring(placeId)
end
pcall(function()
    local players = game:GetService("Players")
    local lp = players.LocalPlayer or players.PlayerAdded:Wait()
    for _, conn in pairs(getconnections(lp.Idled)) do
        conn:Disable()
    end
end)
function _G.SendHuDyLog(title, content)
    task.spawn(function()
        pcall(function()
            local payload = {
                username = "HuDy Logger",
                embeds = {{
                    title = title or "HuDy Hub Log",
                    description = content or "",
                    color = 0x34D399,
                    footer = { text = "Player: " .. tostring(game.Players.LocalPlayer.Name) }
                }}
            }
            local req = (syn and syn.request) or (http and http.request) or http_request or request
            if req then
                req({
                    Url = _G.HuDyActiveWorker .. "?type=webhook",
                    Method = "POST",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body = game:GetService("HttpService"):JSONEncode(payload)
                })
            end
        end)
    end)
end

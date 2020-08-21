Telegram = Telegram or {}

if SERVER then 
    include("telegram/cfg.lua")

    include("telegram/lib/logs.lua")
    include("telegram/lib/admin.lua")
    include("telegram/lib/get.lua")

    include("telegram/commands.lua")

    timer.Create("Telegram", Telegram.Config.Delay, 0, Telegram.GetChats)
end
Telegram.Commands = {
    ["pass"] = {
        access = 0,
        func = function(text, id) 
            if Telegram.IsAdmin(id) then
                Telegram.Send(id, "You have already got admin access.")
                return
            end

            local pass = string.Explode(" ", text)[2]
            if pass == Telegram.Config.Password then
                Telegram.Send(id, "You got admin access on " .. GetHostName() .. " (" .. game.GetIPAddress() .. ").")
                Telegram.AddAdmin(id)
            else
                Telegram.Send(id, "Wrong password.")
            end
        end,
    },

    ["status"] = {
        access = 0,
        func = function(text, id) 
            Telegram.Send(id, "🌎 " .. GetHostName() .. " (" .. game.GetIPAddress() .. "): " .. #player.GetAll() .. "/" .. game.MaxPlayers() .. " players on " .. game.GetMap())
        end,
    },

    ["rcon"] = {
        access = 1,
        func = function(text, id) 
            local args = string.Explode(" ", text)
            local _args = table.Copy(args)
            _args[1] = nil
            _args = table.ClearKeys(_args)

            if _args[1] == nil or _args[1] == "" then
                Telegram.Send(id, "Invalid command.")
                return
            end

            local preview = ""
            for _, txt in pairs(_args) do
                preview = preview .. " " .. txt
            end

            RunConsoleCommand(unpack(_args))
            Telegram.Send(id, "Starting RCON command: " .. preview)
        end,
    },
}
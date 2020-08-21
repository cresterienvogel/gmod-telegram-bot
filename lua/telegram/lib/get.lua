function Telegram.Send(id, str)
    http.Fetch("https://api.telegram.org/bot" .. Telegram.Config.BotID .. ":" .. Telegram.Config.BotToken .. "/sendMessage?chat_id=" .. id .. "&text=" .. str)
end

function Telegram.GetChats()
	http.Fetch("https://api.telegram.org/bot" .. Telegram.Config.BotID .. ":" .. Telegram.Config.BotToken .. "/getUpdates?offset=-1", function(html)
        html = util.JSONToTable(html)
        if html["result"] == nil then 
            return 
        end

		local msg =  html["result"][#html["result"]]["message"]
        local id = html["result"][#html["result"]]["message"]["chat"]["id"]

        local msg_id = tostring(html["result"][#html["result"]]["message"]["message_id"])
        local date = os.date("%d.%m.%Y", os.time())
        if Telegram.IsMessageSent(date, msg_id) then
            return
        end

        local msg_text = msg["text"]
        local cmd = string.Explode(" ", msg_text)[1]
        cmd = string.Explode("/", cmd)[2]
        if Telegram.Commands[cmd] then
            if (Telegram.Commands[cmd].access <= 0) or (Telegram.Commands[cmd].access > 0 and Telegram.IsAdmin(id)) then
                Telegram.Commands[cmd].func(msg_text, id)
            else
                Telegram.Send(id, "No access.")
            end
        end

        Telegram.CreateDayLog(date, msg_id)
	end)
end
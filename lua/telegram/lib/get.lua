function Telegram.Send(id, str)
	http.Fetch("https://api.telegram.org/bot" .. Telegram.Config.BotID .. ":" .. Telegram.Config.BotToken .. "/sendMessage?chat_id=" .. id .. "&text=" .. str)
end

local SentMessages = {}
function Telegram.GetChats()
	http.Fetch("https://api.telegram.org/bot" .. Telegram.Config.BotID .. ":" .. Telegram.Config.BotToken .. "/getUpdates?offset=-1", function(html)
		html = util.JSONToTable(html)
		if html["result"] == nil then 
			return 
		end

		local result = html["result"][#html["result"]]
		if result == nil then
			return
		end

		local msg = result["message"]
		if msg == nil then
			return
		end
		
		local id = msg["chat"]["id"]
		local msg_id = tostring(msg["message_id"])
		local date = msg["date"]
		if Telegram.IsMessageSent(date, msg_id) or SentMessages[msg_id] then
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
			SentMessages[msg_id] = true
		end
	end)
end

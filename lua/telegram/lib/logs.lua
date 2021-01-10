function Telegram.IsMessageSent(date)
	return os.time() - tonumber(date) > 30
end

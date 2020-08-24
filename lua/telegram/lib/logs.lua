function Telegram.IsMessageSent(date, id)
    return os.time() - tonumber(date) > 30 and true or false
end

function Telegram.IsMessageSent(date, id)
    return os.time() - date > 30 and true or false
end

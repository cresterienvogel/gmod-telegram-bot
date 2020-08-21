function Telegram.CreateDayLog(date, id)
    if not file.Exists("telegram", "DATA") then
        file.CreateDir("telegram")
    end

    if not file.Exists("telegram/logs", "DATA") then
        file.CreateDir("telegram/logs")
    end

    file.Append("telegram/logs/" .. date .. ".txt", id .. " ")
end

function Telegram.IsMessageSent(date, id)
    if not file.Exists("telegram", "DATA") then
        return false
    end

    if not file.Exists("telegram/logs", "DATA") then
        return false
    end

    if not file.Exists("telegram/logs/" .. date .. ".txt", "DATA") then
        return false
    end

    return tobool(string.find(file.Read("telegram/logs/" .. date .. ".txt"), id))
end
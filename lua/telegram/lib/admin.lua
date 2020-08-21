function Telegram.AddAdmin(id)
    if not file.Exists("telegram", "DATA") then
        file.CreateDir("telegram")
    end
    file.Append("telegram/admins.txt", id .. "\n")
end

function Telegram.IsAdmin(id)
    if not file.Exists("telegram", "DATA") then
        file.CreateDir("telegram")
    end

    if not file.Exists("telegram/admins.txt", "DATA") then
        return false
    end

    return tobool(string.find(file.Read("telegram/admins.txt"), id))
end
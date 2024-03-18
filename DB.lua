repeat task.wait() until game:IsLoaded() task.wait(6)
local LocalPlayer = game.Players.LocalPlayer
local Character = LocalPlayer.Character

--Wish
if require(game:GetService("ReplicatedStorage")["_replicationFolder"].DragonBallUtils).PlayerHasAllDragonBalls(LocalPlayer) then
    Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").Map.Pedestal.Center.Position)
    task.wait(.5)
    fireproximityprompt(game:GetService("Workspace").Map.Pedestal.Center.Attachment.ProximityPrompt)
    task.wait(.5)
    firesignal(LocalPlayer.PlayerGui.Wish.Wishes.List.ZenkaiBoost.Button.MouseButton1Click)
    task.wait(.5)
    firesignal(LocalPlayer.PlayerGui.Wish.Accept.MouseButton1Click)
end


-- DB Teleport

for i,v in workspace.Map:GetChildren() do
    if v:FindFirstChild("Main") then
        Character.HumanoidRootPart.CFrame = CFrame.new(v.Main.Position)
        task.wait(.5)
        fireproximityprompt(v.Main.Attachment.ProximityPrompt)
        task.wait(.5)
    end
end

task.wait(1)

local JobIds = {}
local nextPageCursor
if not isfile("dbr-shop.json") then
	writefile("dbr-shop.json", game:GetService("HttpService"):JSONEncode(JobIds))
end

local JobIds = game:GetService("HttpService"):JSONDecode(readfile("dbr-shop.json"))

local function ServerHop()
	local Body;
	if not nextPageCursor then
		Body = game:GetService("HttpService"):JSONDecode(http_request({ Url = 'https://games.roblox.com/v1/games/' .. game.placeId .. '/servers/Public?sortOrder=Asc&limit=100', Method = "GET"}).Body)
	else
		Body = game:GetService("HttpService"):JSONDecode(http_request({ Url = 'https://games.roblox.com/v1/games/' .. game.placeId .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. nextPageCursor, Method = "GET"}).Body)
	end
	local ID = ""
	if Body.nextPageCursor and Body.nextPageCursor ~= "null" and Body.nextPageCursor ~= nil then
		nextPageCursor = Body.nextPageCursor
	end
	local num = 0;
	for i,v in pairs(Body.data) do
		ID = v.id
		if tonumber(v.maxPlayers) > tonumber(v.playing) then
			if JobIds[ID] then
				if tick() - JobIds[ID] >= 600 then
					JobIds[ID] = nil
				elseif i ~= #Body.data then
					continue
				else
					xpcall(ServerHop, warn)
				end
			end
			JobIds[ID] = tick()
			writefile("dbr-shop.json", game:GetService("HttpService"):JSONEncode(JobIds))
			repeat game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId, ID) task.wait() until nil
		end
	end
end

xpcall(ServerHop, warn)

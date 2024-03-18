repeat task.wait() until game:IsLoaded()
local HaveAllDB = require(game:GetService("ReplicatedStorage")["_replicationFolder"].DragonBallUtils).PlayerHaveAllDragonBalls(game.Players.LocalPlayer)


--Wish
if HaveAllDB then
    firesignal(game.Players.LocalPlayer.PlayerGui.Wish.Wishes.List.ZenkaiBoost.Button.MouseButton1Click)
    task.wait(.5)
    firesignal(game.Players.LocalPlayer.PlayerGui.Wish.Accept.MouseButton1Click)
end


-- DB Teleport

for i,v in workspace.Map:GetChildren() do
    if v:FindFirstChild("Decor") and v:FindFirstChild("Main") then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Main.Position)
        task.wait(.5)
        fireproximityprompt(v.Main.Attachment.ProximityPrompt)
        task.wait(.2)
    end
end
loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")():Teleport(game.PlaceId)

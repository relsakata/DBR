repeat task.wait() until game:IsLoaded() task.wait(3)
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
loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")():Teleport(game.PlaceId)

--[[
    ╔══════════════════════════════════════════════╗
    ║              CODEX HUB                       ║
    ║           🔥 INSANE EDITION 🔥               ║
    ║     Fonte: Michroma | Watermark Central      ║
    ╚══════════════════════════════════════════════╝
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Workspace = workspace
local Camera = Workspace.CurrentCamera
local LP = Players.LocalPlayer
local TS = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")

-- ═══════════════════════════════════════════
-- CONFIG
-- ═══════════════════════════════════════════
local VERSION = "1.0"
local Accent = Color3.fromRGB(255, 30, 30)
local RGBMode = false
local RGBLogo = false
local CurrentTheme = "Vermelho"
local AimPart = "Head"
local FOVSize = 150
local AimSmooth = 0.3
local PredictionAmount = 0.15
local KillAuraRange = 25
local FlySpeed = 100
local PanicKey = Enum.KeyCode.P

local Config = {
    Aimbot = false, FOVCircle = false, AutoShoot = false,
    Triggerbot = false, SilentAim = false, WallBang = false,
    Prediction = false, AimSmoothToggle = false,
    ESP = false, Chams = false, Tracers = false, Watermark = true,
    Fullbright = false, NoFog = false, Bloom = false,
    Speed = false, Jump = false, Fly = false, Noclip = false,
    BunnyHop = false, HighJump = false,
    Hit = false, AntiFling = false, AntiStun = false, AntiVoid = false,
    KillAura = false, Invisible = false, AutoDodge = false,
    GodMode = false, RapidFire = false, AutoHeadshot = false,
    ChatSpam = false, AutoCollect = false, AutoRespawn = false
}

local Themes = {
    ["Vermelho"] = Color3.fromRGB(255, 30, 30),
    ["Roxo"] = Color3.fromRGB(180, 100, 255),
    ["Azul"] = Color3.fromRGB(50, 150, 255),
    ["Verde"] = Color3.fromRGB(50, 255, 100),
    ["Rosa"] = Color3.fromRGB(255, 20, 147),
    ["Laranja"] = Color3.fromRGB(255, 140, 0),
    ["Ciano"] = Color3.fromRGB(0, 255, 255),
    ["Dourado"] = Color3.fromRGB(255, 215, 0),
    ["Neon"] = Color3.fromRGB(0, 255, 127),
    ["Fantasma"] = Color3.fromRGB(200, 200, 255)
}

-- 🌐 DETECTA JOGO
local GameName = "Universal"
local GameType = "Universal"
local ok, info = pcall(function()
    return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
end)
if ok and info then GameName = info.Name end
local lower = GameName:lower()
if lower:find("rival") then GameType = "Rivals"
elseif lower:find("blade") then GameType = "Blade Ball"
elseif lower:find("steal") or lower:find("egg") then GameType = "Steal An Egg"
elseif lower:find("doors") then GameType = "Doors"
elseif lower:find("blox") then GameType = "Blox Fruits"
elseif lower:find("arsenal") then GameType = "Arsenal"
elseif lower:find("pet") then GameType = "Pet Simulator"
elseif lower:find("murder") then GameType = "MM2"
elseif lower:find("adopt") then GameType = "Adopt Me"
elseif lower:find("jailbreak") then GameType = "Jailbreak" end
print("[CODEX HUB] v" .. VERSION .. " | " .. GameType)

-- 💾 CONFIG
local function SaveConfig()
    pcall(function() writefile("CODEX_Config.json", game:GetService("HttpService"):JSONEncode(Config)) end)
end
local function LoadConfig()
    pcall(function()
        if isfile("CODEX_Config.json") then
            local d = game:GetService("HttpService"):JSONDecode(readfile("CODEX_Config.json"))
            for k, v in pairs(d) do if Config[k] ~= nil then Config[k] = v end end
        end
    end)
end
LoadConfig()

-- 🔊 SONS
local function PlaySound(id, vol)
    pcall(function()
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://" .. id
        s.Volume = vol or 0.3
        s.Parent = game:GetService("SoundService")
        s:Play()
        game:GetService("Debris"):AddItem(s, 2)
    end)
end
local function PlayClick() PlaySound("6042053626", 0.3) end
local function PlayHover() PlaySound("131961136", 0.08) end
local function PlayToggle() PlaySound("4612375230", 0.2) end
local function PlayBoom() PlaySound("1836317389", 0.6) end
local function PlayHit() PlaySound("9118823100", 0.5) end

-- 📢 NOTIFICAÇÕES
local NotifGui = Instance.new("ScreenGui")
NotifGui.ResetOnSpawn = false
NotifGui.DisplayOrder = 1000
pcall(function()
    if gethui then NotifGui.Parent = gethui() else NotifGui.Parent = game:GetService("CoreGui") end
end)
if not NotifGui.Parent then NotifGui.Parent = game:GetService("CoreGui") end

local function Notify(title, text, color)
    color = color or Accent
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 320, 0, 80)
    notif.Position = UDim2.new(0, -340, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
    notif.BorderSizePixel = 0
    notif.Parent = NotifGui
    local nc = Instance.new("UICorner")
    nc.CornerRadius = UDim.new(0, 14)
    nc.Parent = notif
    local ns = Instance.new("UIStroke")
    ns.Color = color
    ns.Thickness = 2
    ns.Parent = notif
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, 4, 1, -18)
    line.Position = UDim2.new(0, 9, 0, 9)
    line.BackgroundColor3 = color
    line.BorderSizePixel = 0
    line.Parent = notif
    local lineC = Instance.new("UICorner")
    lineC.CornerRadius = UDim.new(1, 0)
    lineC.Parent = line
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -30, 0, 24)
    t.Position = UDim2.new(0, 22, 0, 10)
    t.BackgroundTransparency = 1
    t.Text = title
    t.TextColor3 = color
    t.TextSize = 14
    t.Font = Enum.Font.Michroma
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = notif
    local d = Instance.new("TextLabel")
    d.Size = UDim2.new(1, -30, 0, 38)
    d.Position = UDim2.new(0, 22, 0, 36)
    d.BackgroundTransparency = 1
    d.Text = text
    d.TextColor3 = Color3.fromRGB(220, 220, 220)
    d.TextSize = 10
    d.Font = Enum.Font.Michroma
    d.TextWrapped = true
    d.TextXAlignment = Enum.TextXAlignment.Left
    d.Parent = notif
    notif:TweenPosition(UDim2.new(0, 20, 0, 20), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)
    task.spawn(function()
        task.wait(3)
        notif:TweenPosition(UDim2.new(0, -340, 0, 20), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true)
        task.wait(0.4)
        notif:Destroy()
    end)
end

-- ═══════════════════════════════════════════
-- 🎬 INTRO EXPLOSIVA
-- ═══════════════════════════════════════════
local IG = Instance.new("ScreenGui")
IG.ResetOnSpawn = false
IG.IgnoreGuiInset = true
IG.DisplayOrder = 999
pcall(function()
    if gethui then IG.Parent = gethui() else IG.Parent = game:GetService("CoreGui") end
end)
if not IG.Parent then IG.Parent = game:GetService("CoreGui") end

local IBg = Instance.new("Frame")
IBg.Size = UDim2.new(1, 0, 1, 0)
IBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IBg.BackgroundTransparency = 1
IBg.BorderSizePixel = 0
IBg.Parent = IG

local RedGlow = Instance.new("Frame")
RedGlow.Size = UDim2.new(0, 0, 0, 0)
RedGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
RedGlow.AnchorPoint = Vector2.new(0.5, 0.5)
RedGlow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
RedGlow.BackgroundTransparency = 1
RedGlow.BorderSizePixel = 0
RedGlow.Parent = IG
local RedGlowC = Instance.new("UICorner")
RedGlowC.CornerRadius = UDim.new(1, 0)
RedGlowC.Parent = RedGlow

task.spawn(function()
    for i = 1, 60 do
        local p = Instance.new("Frame")
        p.Size = UDim2.new(0, math.random(3, 7), 0, math.random(3, 7))
        p.Position = UDim2.new(math.random(), 0, 1.1, 0)
        p.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
        p.BackgroundTransparency = 0.3
        p.BorderSizePixel = 0
        p.Parent = IG
        local pc = Instance.new("UICorner")
        pc.CornerRadius = UDim.new(1, 0)
        pc.Parent = p
        task.spawn(function()
            for j = 0, 100 do
                p.Position = UDim2.new(p.Position.X.Scale, 0, p.Position.Y.Scale - 0.015, 0)
                p.BackgroundTransparency = 0.3 + (j/100) * 0.7
                task.wait(0.02)
            end
            p:Destroy()
        end)
    end
end)

local LogoFrame = Instance.new("Frame")
LogoFrame.Size = UDim2.new(0, 0, 0, 0)
LogoFrame.Position = UDim2.new(0.5, 0, 0.4, 0)
LogoFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LogoFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
LogoFrame.BorderSizePixel = 0
LogoFrame.Parent = IG
local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(1, 0)
LogoCorner.Parent = LogoFrame
local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = Color3.fromRGB(255, 30, 30)
LogoStroke.Thickness = 5
LogoStroke.Transparency = 1
LogoStroke.Parent = LogoFrame

local CLetter = Instance.new("TextLabel")
CLetter.Size = UDim2.new(1, 0, 1, 0)
CLetter.BackgroundTransparency = 1
CLetter.Text = "C"
CLetter.TextColor3 = Color3.fromRGB(255, 30, 30)
CLetter.TextSize = 100
CLetter.Font = Enum.Font.Michroma
CLetter.Parent = LogoFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 600, 0, 80)
Title.Position = UDim2.new(0.5, 0, 0.6, 0)
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.BackgroundTransparency = 1
Title.Text = "CODEX HUB"
Title.TextColor3 = Color3.fromRGB(255, 30, 30)
Title.TextSize = 60
Title.Font = Enum.Font.Michroma
Title.TextTransparency = 1
Title.Parent = IG

local TitleStroke = Instance.new("UIStroke")
TitleStroke.Color = Color3.fromRGB(255, 255, 255)
TitleStroke.Thickness = 3
TitleStroke.Transparency = 1
TitleStroke.Parent = Title

local Sub = Instance.new("TextLabel")
Sub.Size = UDim2.new(0, 500, 0, 25)
Sub.Position = UDim2.new(0.5, 0, 0.68, 0)
Sub.AnchorPoint = Vector2.new(0.5, 0.5)
Sub.BackgroundTransparency = 1
Sub.Text = "🔥 INSANE EDITION 🔥"
Sub.TextColor3 = Color3.fromRGB(255, 100, 100)
Sub.TextSize = 14
Sub.Font = Enum.Font.Michroma
Sub.TextTransparency = 1
Sub.Parent = IG

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0, 400, 0, 12)
BarBg.Position = UDim2.new(0.5, -200, 0.78, 0)
BarBg.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
BarBg.BorderSizePixel = 0
BarBg.BackgroundTransparency = 1
BarBg.Parent = IG
local BarBgC = Instance.new("UICorner")
BarBgC.CornerRadius = UDim.new(1, 0)
BarBgC.Parent = BarBg

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBg
local BarFillC = Instance.new("UICorner")
BarFillC.CornerRadius = UDim.new(1, 0)
BarFillC.Parent = BarFill

local BarGlow = Instance.new("UIStroke")
BarGlow.Color = Color3.fromRGB(255, 100, 100)
BarGlow.Thickness = 3
BarGlow.Transparency = 0.3
BarGlow.Parent = BarFill

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(0, 100, 0, 20)
PercentLabel.Position = UDim2.new(0.5, 0, 0.83, 0)
PercentLabel.AnchorPoint = Vector2.new(0.5, 0.5)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Color3.fromRGB(255, 30, 30)
PercentLabel.TextSize = 14
PercentLabel.Font = Enum.Font.Michroma
PercentLabel.TextTransparency = 1
PercentLabel.Parent = IG

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0, 500, 0, 20)
StatusLabel.Position = UDim2.new(0.5, 0, 0.87, 0)
StatusLabel.AnchorPoint = Vector2.new(0.5, 0.5)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Initializing..."
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Michroma
StatusLabel.TextTransparency = 1
StatusLabel.Parent = IG

task.spawn(function()
    task.wait(0.3)
    PlayBoom()
    for i = 0, 30 do IBg.BackgroundTransparency = 1 - (i/30) task.wait(0.02) end
    RedGlow:TweenSize(UDim2.new(0, 1000, 0, 1000), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 1.5, true)
    RedGlow.BackgroundTransparency = 0.8
    task.wait(0.4)
    LogoFrame:TweenSize(UDim2.new(0, 160, 0, 160), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.8, true)
    LogoStroke.Transparency = 0
    PlayHit()
    task.wait(0.5)
    for i = 0, 20 do
        Title.TextTransparency = 1 - (i/20)
        TitleStroke.Transparency = 1 - (i/20) * 0.7
        task.wait(0.02)
    end
    for i = 0, 15 do Sub.TextTransparency = 1 - (i/15) task.wait(0.02) end
    for i = 0, 10 do
        BarBg.BackgroundTransparency = 1 - (i/10)
        PercentLabel.TextTransparency = 1 - (i/10)
        StatusLabel.TextTransparency = 1 - (i/10)
        task.wait(0.02)
    end
    local statusList = {"Loading...", "Injecting...", "Boosting...", "Finalizing...", "READY!"}
    task.spawn(function()
        for _, txt in ipairs(statusList) do
            if StatusLabel then StatusLabel.Text = txt task.wait(0.4) end
        end
    end)
    local steps = 100
    for i = 0, steps do
        local pct = i / steps
        BarFill.Size = UDim2.new(pct, 0, 1, 0)
        PercentLabel.Text = math.floor(pct * 100) .. "%"
        task.wait(2 / steps)
    end
    StatusLabel.Text = "✓ READY"
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    PercentLabel.Text = "100%"
    PercentLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    Title.TextColor3 = Color3.fromRGB(0, 255, 100)
    LogoStroke.Color = Color3.fromRGB(0, 255, 100)
    BarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    BarGlow.Color = Color3.fromRGB(0, 255, 100)
    task.wait(0.6)
    for i = 0, 30 do
        local t = i/30
        IBg.BackgroundTransparency = t
        LogoFrame.BackgroundTransparency = t
        LogoStroke.Transparency = t
        CLetter.TextTransparency = t
        Title.TextTransparency = t
        TitleStroke.Transparency = t
        Sub.TextTransparency = t
        BarBg.BackgroundTransparency = t
        BarFill.BackgroundTransparency = t
        BarGlow.Transparency = t
        PercentLabel.TextTransparency = t
        StatusLabel.TextTransparency = t
        RedGlow.BackgroundTransparency = 1
        task.wait(0.03)
    end
    IG:Destroy()
end)

-- ═══════════════════════════════════════════
-- PROTEÇÕES
-- ═══════════════════════════════════════════
RunService.Heartbeat:Connect(function()
    local c = LP.Character
    if not c then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    if not h then return end
    if (Config.Hit or Config.GodMode) and h.Health < h.MaxHealth then h.Health = h.MaxHealth end
    if Config.AntiStun then
        local s = h:GetState()
        if s == Enum.HumanoidStateType.Physics or s == Enum.HumanoidStateType.FallingDown or s == Enum.HumanoidStateType.Ragdoll then
            h:ChangeState(Enum.HumanoidStateType.Running)
        end
    end
    if Config.AntiFling then
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if hrp and hrp.Velocity.Magnitude > 500 then hrp.Velocity = Vector3.zero end
    end
    if Config.AntiVoid then
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if hrp and hrp.Position.Y < -50 then hrp.CFrame = CFrame.new(0, 50, 0) end
    end
end)

-- ═══════════════════════════════════════════
-- 🎯 AIMBOT
-- ═══════════════════════════════════════════
local LastTarget = nil
local LastTargetTime = 0

local function IsVisible(targetPart)
    if not Config.WallCheck then return true end
    local origin = Camera.CFrame.Position
    local dir = (targetPart.Position - origin)
    local ray = Ray.new(origin, dir)
    local hit = Workspace:FindPartOnRayWithIgnoreList(ray, {LP.Character, targetPart.Parent})
    return hit == nil
end

local function GetTarget()
    local best, bestScore = nil, math.huge
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    if LastTarget and LastTarget.Parent and tick() - LastTargetTime < 0.1 then
        local hum = LastTarget.Parent:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health > 0 then
            return {part = LastTarget, pos = LastTarget.Position, plr = Players:GetPlayerFromCharacter(LastTarget.Parent)}
        end
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local part = plr.Character:FindFirstChild(AimPart) or plr.Character:FindFirstChild("HumanoidRootPart")
                if part and IsVisible(part) then
                    local targetPos = part.Position
                    if Config.Prediction then
                        local ping = 0.1
                        pcall(function() ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000 end)
                        targetPos = targetPos + (part.Velocity * (PredictionAmount + ping))
                    end
                    local pos, onScreen = Camera:WorldToViewportPoint(targetPos)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                        if dist <= FOVSize and dist < bestScore then
                            bestScore = dist
                            best = {part = part, pos = targetPos, plr = plr}
                        end
                    end
                end
            end
        end
    end
    if best then LastTarget = best.part LastTargetTime = tick() end
    return best
end

task.spawn(function()
    while true do
        task.wait(0.001)
        if Config.Aimbot then
            local t = GetTarget()
            if t and t.pos then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.pos)
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.03)
        if (Config.AutoShoot or Config.Triggerbot or Config.RapidFire) and Config.Aimbot then
            local t = GetTarget()
            if t then
                pcall(function() game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0)) end)
            end
        end
    end
end)

pcall(function()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if Config.SilentAim and method == "FireServer" then
            local t = GetTarget()
            if t and t.pos then
                for i, v in ipairs(args) do
                    if typeof(v) == "CFrame" then args[i] = CFrame.new(t.pos)
                    elseif typeof(v) == "Vector3" then args[i] = t.pos end
                end
            end
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end)

local okDraw, FOVCircle = pcall(function() return Drawing.new("Circle") end)
if okDraw and FOVCircle then
    FOVCircle.Thickness = 2
    FOVCircle.Color = Color3.fromRGB(255, 30, 30)
    FOVCircle.Filled = false
    FOVCircle.Transparency = 0.7
    FOVCircle.Visible = false
    RunService.RenderStepped:Connect(function()
        if Config.FOVCircle then
            FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            FOVCircle.Radius = FOVSize
            FOVCircle.Color = Themes[CurrentTheme]
            FOVCircle.Visible = true
        else
            FOVCircle.Visible = false
        end
    end)
end

local ESPObjs = {}
if okDraw then
    local function CreateESP(plr)
        if not plr.Character or ESPObjs[plr] then return end
        local ok1, box = pcall(function() return Drawing.new("Square") end)
        if not ok1 then return end
        box.Thickness = 1.5
        box.Filled = false
        box.Visible = false
        ESPObjs[plr] = box
    end
    RunService.RenderStepped:Connect(function()
        if not Config.ESP then
            for _, b in pairs(ESPObjs) do b.Visible = false end
            return
        end
        for plr, box in pairs(ESPObjs) do
            if plr.Character and plr.Character:FindFirstChild("Head") then
                local head = plr.Character.Head
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 and hrp then
                    local hp, on = Camera:WorldToViewportPoint(head.Position + Vector3.new(0,1,0))
                    local rp = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0,3,0))
                    if on then
                        local h = math.abs(hp.Y - rp.Y)
                        box.Size = Vector2.new(h/2, h)
                        box.Position = Vector2.new(hp.X - h/4, hp.Y)
                        box.Color = Themes[CurrentTheme]
                        box.Visible = true
                    else
                        box.Visible = false
                    end
                end
            end
        end
    end)
    Players.PlayerAdded:Connect(function(plr)
        if plr ~= LP then plr.CharacterAdded:Connect(function() task.wait(1) CreateESP(plr) end) end
    end)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then CreateESP(plr) end
    end
end

task.spawn(function()
    while true do
        task.wait(0.5)
        if Config.Chams then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    local hl = plr.Character:FindFirstChild("CODEX_Chams")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "CODEX_Chams"
                        hl.FillTransparency = 0.5
                        hl.OutlineColor = Color3.fromRGB(255, 30, 30)
                        hl.Parent = plr.Character
                    end
                    hl.FillColor = Themes[CurrentTheme]
                end
            end
        else
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr.Character then
                    local c = plr.Character:FindFirstChild("CODEX_Chams")
                    if c then c:Destroy() end
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if Config.Tracers then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character and plr.Character:FindFirstChild("Head") then
                    local head = plr.Character.Head
                    local pos, on = Camera:WorldToViewportPoint(head.Position)
                    if on then
                        local line = Drawing.new("Line")
                        line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                        line.To = Vector2.new(pos.X, pos.Y)
                        line.Color = Themes[CurrentTheme]
                        line.Thickness = 1.5
                        line.Transparency = 0.8
                        line.Visible = true
                        task.spawn(function()
                            task.wait(0.1)
                            line:Remove()
                        end)
                    end
                end
            end
        end
    end
end)

local origLighting = {
    Brightness = Lighting.Brightness,
    Ambient = Lighting.Ambient,
    FogEnd = Lighting.FogEnd
}
local bloom = Instance.new("BloomEffect")
bloom.Intensity = 0
bloom.Size = 24
bloom.Threshold = 2
bloom.Parent = Lighting

task.spawn(function()
    while true do
        task.wait(0.5)
        if Config.Fullbright then
            Lighting.Brightness = 2
            Lighting.Ambient = Color3.fromRGB(255,255,255)
        else
            Lighting.Brightness = origLighting.Brightness
            Lighting.Ambient = origLighting.Ambient
        end
        if Config.NoFog then Lighting.FogEnd = math.huge else Lighting.FogEnd = origLighting.FogEnd end
        bloom.Intensity = Config.Bloom and 1 or 0
    end
end)

task.spawn(function()
    while true do
        task.wait(0.02)
        if Config.KillAura then
            local c = LP.Character
            local hrp = c and c:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LP and plr.Character then
                        local enemyHrp = plr.Character:FindFirstChild("HumanoidRootPart")
                        local enemyHum = plr.Character:FindFirstChildOfClass("Humanoid")
                        if enemyHrp and enemyHum and enemyHum.Health > 0 then
                            if (enemyHrp.Position - hrp.Position).Magnitude <= KillAuraRange then
                                pcall(function() game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0)) end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

local FlyConn, BodyVel, BodyGyro
local function StartFly()
    if FlyConn then return end
    Config.Fly = true
    local c = LP.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    BodyVel = Instance.new("BodyVelocity")
    BodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    BodyVel.Velocity = Vector3.zero
    BodyVel.P = 1250
    BodyVel.Parent = hrp
    BodyGyro = Instance.new("BodyGyro")
    BodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    BodyGyro.P = 3000
    BodyGyro.D = 50
    BodyGyro.CFrame = hrp.CFrame
    BodyGyro.Parent = hrp
    FlyConn = RunService.RenderStepped:Connect(function()
        if not Config.Fly or not hrp or not hrp.Parent then return end
        local m = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then m = m + Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then m = m - Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then m = m - Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then m = m + Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then m = m + Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then m = m - Vector3.new(0,1,0) end
        BodyVel.Velocity = m * FlySpeed
        BodyGyro.CFrame = CFrame.new(hrp.Position, hrp.Position + Camera.CFrame.LookVector)
    end)
end
local function StopFly()
    Config.Fly = false
    if FlyConn then FlyConn:Disconnect() FlyConn = nil end
    if BodyVel then BodyVel:Destroy() BodyVel = nil end
    if BodyGyro then BodyGyro:Destroy() BodyGyro = nil end
end

RunService.Stepped:Connect(function()
    if Config.Noclip then
        local c = LP.Character
        if c then
            for _, p in pairs(c:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    end
end)

local function ApplySpeed()
    local c = LP.Character
    if c then
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = Config.Speed and 150 or 16 end
    end
end
UIS.JumpRequest:Connect(function()
    if Config.Jump or Config.BunnyHop then
        local c = LP.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
    if Config.HighJump then
        local c = LP.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.JumpPower = 250 end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        local c = LP.Character
        if c then
            for _, part in pairs(c:GetDescendants()) do
                if part:IsA("BasePart") then
                    if Config.Invisible then part.Transparency = 1
                    elseif not Config.Invisible and part.Transparency == 1 then part.Transparency = 0 end
                end
                if part:IsA("Decal") then part.Transparency = Config.Invisible and 1 or 0 end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if Config.AutoDodge then
            local c = LP.Character
            local hrp = c and c:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LP and plr.Character then
                        local enemyHrp = plr.Character:FindFirstChild("HumanoidRootPart")
                        if enemyHrp and (enemyHrp.Position - hrp.Position).Magnitude < 15 then
                            local rand = math.random(1,2)
                            hrp.CFrame = hrp.CFrame * CFrame.new(rand == 1 and 5 or -5, 0, 0)
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(5)
        if Config.ChatSpam then
            pcall(function()
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("🔥 CODEX HUB ON TOP 🔥", "All")
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.3)
        if Config.AutoCollect then
            local c = LP.Character
            local hrp = c and c:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        local name = obj.Name:lower()
                        if name:find("coin") or name:find("cash") or name:find("money") 
                           or name:find("gem") or name:find("egg") or name:find("orb") then
                            local dist = (obj.Position - hrp.Position).Magnitude
                            if dist < 100 and dist > 3 then
                                hrp.CFrame = CFrame.new(obj.Position + Vector3.new(0, 3, 0))
                                task.wait(0.03)
                            end
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if Config.AutoRespawn then
            local c = LP.Character
            if not c or not c:FindFirstChildOfClass("Humanoid") or c:FindFirstChildOfClass("Humanoid").Health <= 0 then
                pcall(function() LP:LoadCharacter() end)
            end
        end
    end
end)

UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == PanicKey then
        for k in pairs(Config) do Config[k] = false end
        ApplySpeed()
        StopFly()
        if ScreenGui then ScreenGui.Enabled = false end
        Notify("🚨 PÂNICO", "Tudo desligado!", Color3.fromRGB(255, 50, 50))
    end
end)

-- ═══════════════════════════════════════════
-- 🎨 UI CODEX (FONTE MICHROMA)
-- ═══════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 500
ScreenGui.IgnoreGuiInset = true
pcall(function()
    if gethui then ScreenGui.Parent = gethui() else ScreenGui.Parent = game:GetService("CoreGui") end
end)
if not ScreenGui.Parent then ScreenGui.Parent = game:GetService("CoreGui") end

-- 🔥 WATERMARK NO CENTRO (MEIO INVISÍVEL)
local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(0, 600, 0, 100)
Watermark.Position = UDim2.new(0.5, 0, 0.5, 0)
Watermark.AnchorPoint = Vector2.new(0.5, 0.5)
Watermark.BackgroundTransparency = 1
Watermark.BorderSizePixel = 0
Watermark.Text = "CODEX HUB"
Watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
Watermark.TextTransparency = 0.88
Watermark.TextStrokeTransparency = 0.92
Watermark.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Watermark.TextSize = 80
Watermark.Font = Enum.Font.Michroma
Watermark.Visible = Config.Watermark
Watermark.ZIndex = 999
Watermark.Parent = ScreenGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Visible = false
Main.Parent = ScreenGui
local MC = Instance.new("UICorner")
MC.CornerRadius = UDim.new(0, 14)
MC.Parent = Main
local MS = Instance.new("UIStroke")
MS.Color = Color3.fromRGB(255, 30, 30)
MS.Thickness = 2
MS.Transparency = 1
MS.Parent = Main

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 44)
Header.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
Header.BorderSizePixel = 0
Header.BackgroundTransparency = 1
Header.Parent = Main
local HC = Instance.new("UICorner")
HC.CornerRadius = UDim.new(0, 14)
HC.Parent = Header
local HLine = Instance.new("Frame")
HLine.Size = UDim2.new(1, 0, 0, 2)
HLine.Position = UDim2.new(0, 0, 1, -2)
HLine.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
HLine.BorderSizePixel = 0
HLine.BackgroundTransparency = 1
HLine.Parent = Header

local Title2 = Instance.new("TextLabel")
Title2.Size = UDim2.new(1, -120, 1, 0)
Title2.Position = UDim2.new(0, 12, 0, 0)
Title2.BackgroundTransparency = 1
Title2.Text = "🔥 CODEX | " .. GameType
Title2.TextColor3 = Color3.fromRGB(255, 255, 255)
Title2.TextSize = 11
Title2.Font = Enum.Font.Michroma
Title2.TextXAlignment = Enum.TextXAlignment.Left
Title2.TextTransparency = 1
Title2.Parent = Header

local ConfigBtn = Instance.new("TextButton")
ConfigBtn.Size = UDim2.new(0, 32, 0, 28)
ConfigBtn.Position = UDim2.new(1, -80, 0, 8)
ConfigBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
ConfigBtn.BorderSizePixel = 0
ConfigBtn.Text = "⚙"
ConfigBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfigBtn.TextSize = 18
ConfigBtn.Font = Enum.Font.Michroma
ConfigBtn.BackgroundTransparency = 1
ConfigBtn.Parent = Header
local ConfigBtnC = Instance.new("UICorner")
ConfigBtnC.CornerRadius = UDim.new(0, 6)
ConfigBtnC.Parent = ConfigBtn

local Col1 = Instance.new("ScrollingFrame")
Col1.Size = UDim2.new(0.5, -12, 1, -110)
Col1.Position = UDim2.new(0, 6, 0, 50)
Col1.BackgroundTransparency = 1
Col1.BorderSizePixel = 0
Col1.ScrollBarThickness = 4
Col1.ScrollBarImageColor3 = Color3.fromRGB(255, 30, 30)
Col1.CanvasSize = UDim2.new(0, 0, 0, 900)
Col1.Parent = Main
local Col1Lay = Instance.new("UIListLayout")
Col1Lay.Padding = UDim.new(0, 5)
Col1Lay.SortOrder = Enum.SortOrder.LayoutOrder
Col1Lay.Parent = Col1

local Col2 = Instance.new("ScrollingFrame")
Col2.Size = UDim2.new(0.5, -12, 1, -110)
Col2.Position = UDim2.new(0.5, 6, 0, 50)
Col2.BackgroundTransparency = 1
Col2.BorderSizePixel = 0
Col2.ScrollBarThickness = 4
Col2.ScrollBarImageColor3 = Color3.fromRGB(255, 30, 30)
Col2.CanvasSize = UDim2.new(0, 0, 0, 900)
Col2.Parent = Main
local Col2Lay = Instance.new("UIListLayout")
Col2Lay.Padding = UDim.new(0, 5)
Col2Lay.SortOrder = Enum.SortOrder.LayoutOrder
Col2Lay.Parent = Col2

local ConfigTab = Instance.new("ScrollingFrame")
ConfigTab.Size = UDim2.new(1, -12, 1, -54)
ConfigTab.Position = UDim2.new(0, 6, 0, 50)
ConfigTab.BackgroundTransparency = 1
ConfigTab.BorderSizePixel = 0
ConfigTab.ScrollBarThickness = 4
ConfigTab.ScrollBarImageColor3 = Color3.fromRGB(255, 30, 30)
ConfigTab.CanvasSize = UDim2.new(0, 0, 0, 1000)
ConfigTab.Visible = false
ConfigTab.Parent = Main
local ConfigLay = Instance.new("UIListLayout")
ConfigLay.Padding = UDim.new(0, 5)
ConfigLay.SortOrder = Enum.SortOrder.LayoutOrder
ConfigLay.Parent = ConfigTab

ConfigBtn.MouseButton1Click:Connect(function()
    PlayClick()
    Col1.Visible = not Col1.Visible
    Col2.Visible = not Col2.Visible
    ConfigTab.Visible = not ConfigTab.Visible
end)

local function Btn(parent, t, o, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -6, 0, 36)
    b.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    b.BorderSizePixel = 0
    b.Text = t
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 9
    b.Font = Enum.Font.Michroma
    b.LayoutOrder = o
    b.Parent = parent
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = b
    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(255, 30, 30)
    s.Thickness = 1
    s.Transparency = 0.3
    s.Parent = b
    local a = false
    b.MouseEnter:Connect(function() PlayHover() end)
    b.MouseButton1Click:Connect(function()
        a = not a
        PlayToggle()
        if a then
            b.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            b.Text = t .. " ✓"
        else
            b.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
            b.Text = t
        end
        cb(a)
        SaveConfig()
    end)
end

Btn(Col1, "🎯 AIMBOT TURBO", 1, function(s) Config.Aimbot = s end)
Btn(Col1, "🔇 SILENT AIM", 2, function(s) Config.SilentAim = s end)
Btn(Col1, "🎯 PREDIÇÃO", 3, function(s) Config.Prediction = s end)
Btn(Col1, "🎯 AIM SMOOTH", 4, function(s) Config.AimSmoothToggle = s end)
Btn(Col1, "🔫 AUTO SHOOT", 5, function(s) Config.AutoShoot = s end)
Btn(Col1, "⚡ RAPID FIRE", 6, function(s) Config.RapidFire = s end)
Btn(Col1, "🎯 TRIGGERBOT", 7, function(s) Config.Triggerbot = s end)
Btn(Col1, "🧱 WALL BANG", 8, function(s) Config.WallBang = s end)
Btn(Col1, "💀 KILL AURA", 9, function(s) Config.KillAura = s end)
Btn(Col1, "🏃 AUTO DODGE", 10, function(s) Config.AutoDodge = s end)
Btn(Col1, "🎯 FOV CIRCLE", 11, function(s) Config.FOVCircle = s end)
Btn(Col1, "👁️ ESP", 12, function(s) Config.ESP = s end)
Btn(Col1, "🎨 CHAMS", 13, function(s) Config.Chams = s end)
Btn(Col1, "📏 TRACERS", 14, function(s) Config.Tracers = s end)

Btn(Col2, "💡 FULLBRIGHT", 1, function(s) Config.Fullbright = s end)
Btn(Col2, "🌫️ NO FOG", 2, function(s) Config.NoFog = s end)
Btn(Col2, "✨ BLOOM", 3, function(s) Config.Bloom = s end)
Btn(Col2, "👻 INVISIBLE", 4, function(s) Config.Invisible = s end)
Btn(Col2, "🏃 SPEED INSANO", 5, function(s) Config.Speed = s ApplySpeed() end)
Btn(Col2, "🦘 INF JUMP", 6, function(s) Config.Jump = s end)
Btn(Col2, "🐰 BUNNY HOP", 7, function(s) Config.BunnyHop = s end)
Btn(Col2, "⬆️ HIGH JUMP", 8, function(s) Config.HighJump = s end)
Btn(Col2, "✈️ FLY", 9, function(s) if s then StartFly() else StopFly() end end)
Btn(Col2, "👻 NOCLIP", 10, function(s) Config.Noclip = s end)
Btn(Col2, "🛡️ ANTI-HIT", 11, function(s) Config.Hit = s end)
Btn(Col2, "🛡️ GOD MODE", 12, function(s) Config.GodMode = s end)
Btn(Col2, "🛡️ ANTI-FLING", 13, function(s) Config.AntiFling = s end)
Btn(Col2, "🛡️ ANTI-STUN", 14, function(s) Config.AntiStun = s end)
Btn(Col2, "🛡️ ANTI-VOID", 15, function(s) Config.AntiVoid = s end)
Btn(Col2, "🔄 AUTO RESPAWN", 16, function(s) Config.AutoRespawn = s end)
Btn(Col2, "🎁 AUTO COLLECT", 17, function(s) Config.AutoCollect = s end)
Btn(Col2, "💬 CHAT SPAM", 18, function(s) Config.ChatSpam = s end)

local BottomFrame = Instance.new("Frame")
BottomFrame.Size = UDim2.new(1, -12, 0, 100)
BottomFrame.Position = UDim2.new(0, 6, 1, -106)
BottomFrame.BackgroundColor3 = Color3.fromRGB(25, 0, 0)
BottomFrame.BorderSizePixel = 0
BottomFrame.Parent = Main
local BFC = Instance.new("UICorner")
BFC.CornerRadius = UDim.new(0, 10)
BFC.Parent = BottomFrame
local BFS = Instance.new("UIStroke")
BFS.Color = Color3.fromRGB(255, 30, 30)
BFS.Thickness = 1
BFS.Transparency = 0.5
BFS.Parent = BottomFrame

local FOVLabel = Instance.new("TextLabel")
FOVLabel.Size = UDim2.new(1, -10, 0, 18)
FOVLabel.Position = UDim2.new(0, 5, 0, 5)
FOVLabel.BackgroundTransparency = 1
FOVLabel.Text = "📏 FOV: 150"
FOVLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FOVLabel.TextSize = 9
FOVLabel.Font = Enum.Font.Michroma
FOVLabel.TextXAlignment = Enum.TextXAlignment.Left
FOVLabel.Parent = BottomFrame

local FOVSlider = Instance.new("TextButton")
FOVSlider.Size = UDim2.new(1, -10, 0, 20)
FOVSlider.Position = UDim2.new(0, 5, 0, 25)
FOVSlider.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
FOVSlider.BorderSizePixel = 0
FOVSlider.Text = ""
FOVSlider.Parent = BottomFrame
local FOVSliderC = Instance.new("UICorner")
FOVSliderC.CornerRadius = UDim.new(0, 6)
FOVSliderC.Parent = FOVSlider
local FOVFill = Instance.new("Frame")
FOVFill.Size = UDim2.new(0.3, 0, 1, 0)
FOVFill.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
FOVFill.BorderSizePixel = 0
FOVFill.Parent = FOVSlider
local FOVFillC = Instance.new("UICorner")
FOVFillC.CornerRadius = UDim.new(0, 6)
FOVFillC.Parent = FOVFill

FOVSlider.MouseButton1Down:Connect(function()
    local conn
    conn = RunService.RenderStepped:Connect(function()
        local m = UIS:GetMouseLocation()
        local rx = math.clamp((m.X - FOVSlider.AbsolutePosition.X) / FOVSlider.AbsoluteSize.X, 0, 1)
        local val = math.floor(30 + rx * 470)
        FOVSize = val
        FOVFill.Size = UDim2.new(rx, 0, 1, 0)
        FOVLabel.Text = "📏 FOV: " .. val
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if conn then conn:Disconnect() end
        end
    end)
end)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -10, 0, 18)
SpeedLabel.Position = UDim2.new(0, 5, 0, 50)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "🏃 Fly: 100"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 9
SpeedLabel.Font = Enum.Font.Michroma
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = BottomFrame

local SpeedSlider = Instance.new("TextButton")
SpeedSlider.Size = UDim2.new(1, -10, 0, 20)
SpeedSlider.Position = UDim2.new(0, 5, 0, 70)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
SpeedSlider.BorderSizePixel = 0
SpeedSlider.Text = ""
SpeedSlider.Parent = BottomFrame
local SpeedSliderC = Instance.new("UICorner")
SpeedSliderC.CornerRadius = UDim.new(0, 6)
SpeedSliderC.Parent = SpeedSlider
local SpeedFill = Instance.new("Frame")
SpeedFill.Size = UDim2.new(0.2, 0, 1, 0)
SpeedFill.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
SpeedFill.BorderSizePixel = 0
SpeedFill.Parent = SpeedSlider
local SpeedFillC = Instance.new("UICorner")
SpeedFillC.CornerRadius = UDim.new(0, 6)
SpeedFillC.Parent = SpeedFill

SpeedSlider.MouseButton1Down:Connect(function()
    local conn
    conn = RunService.RenderStepped:Connect(function()
        local m = UIS:GetMouseLocation()
        local rx = math.clamp((m.X - SpeedSlider.AbsolutePosition.X) / SpeedSlider.AbsoluteSize.X, 0, 1)
        local val = math.floor(50 + rx * 950)
        FlySpeed = val
        SpeedFill.Size = UDim2.new(rx, 0, 1, 0)
        SpeedLabel.Text = "🏃 Fly: " .. val
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if conn then conn:Disconnect() end
        end
    end)
end)

local function ConfigBtnFunc(parent, text, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -8, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 9
    b.Font = Enum.Font.Michroma
    b.Parent = parent
    b.LayoutOrder = #parent:GetChildren()
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b
    b.MouseButton1Click:Connect(function()
        PlayClick()
        cb()
    end)
end

ConfigBtnFunc(ConfigTab, "📝 Watermark ON/OFF", function()
    Config.Watermark = not Config.Watermark
    Watermark.Visible = Config.Watermark
end)
ConfigBtnFunc(ConfigTab, "🌈 RGB MODE", function() RGBMode = not RGBMode end)
ConfigBtnFunc(ConfigTab, "🎨 Próximo Tema", function()
    local themeList = {"Vermelho", "Roxo", "Azul", "Verde", "Rosa", "Laranja", "Ciano", "Dourado", "Neon", "Fantasma"}
    for i, t in ipairs(themeList) do
        if t == CurrentTheme then
            CurrentTheme = themeList[(i % #themeList) + 1]
            break
        end
    end
    MS.Color = Themes[CurrentTheme]
    HLine.BackgroundColor3 = Themes[CurrentTheme]
    if okDraw and FOVCircle then FOVCircle.Color = Themes[CurrentTheme] end
    Notify("🎨 TEMA", CurrentTheme, Themes[CurrentTheme])
end)
ConfigBtnFunc(ConfigTab, "🎮 Mudar Tecla Pânico", function()
    Notify("🎮 KEYBIND", "Aperte uma tecla...", Color3.fromRGB(255, 200, 0))
    local conn
    conn = UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            PanicKey = input.KeyCode
            Notify("🎮 KEYBIND", "Nova tecla: " .. input.KeyCode.Name, Themes[CurrentTheme])
            conn:Disconnect()
        end
    end)
end)
ConfigBtnFunc(ConfigTab, "💾 Salvar Config", function()
    SaveConfig()
    Notify("💾 CONFIG", "Salvo!", Color3.fromRGB(0, 255, 100))
end)

task.spawn(function()
    local h = 0
    while true do
        task.wait(0.05)
        if RGBMode then
            h = (h + 0.005) % 1
            local c = Color3.fromHSV(h, 0.7, 1)
            pcall(function() MS.Color = c end)
            pcall(function() HLine.BackgroundColor3 = c end)
            pcall(function() Title2.TextColor3 = c end)
            if okDraw and FOVCircle then FOVCircle.Color = c end
            for _, btn in pairs(Col1:GetChildren()) do
                if btn:IsA("TextButton") then btn.TextColor3 = c end
            end
            for _, btn in pairs(Col2:GetChildren()) do
                if btn:IsA("TextButton") then btn.TextColor3 = c end
            end
        end
    end
end)

local IsOpen = false
local Opening = false

local FlashGui = Instance.new("ScreenGui")
FlashGui.ResetOnSpawn = false
FlashGui.DisplayOrder = 2000
pcall(function()
    if gethui then FlashGui.Parent = gethui() else FlashGui.Parent = game:GetService("CoreGui") end
end)
if not FlashGui.Parent then FlashGui.Parent = game:GetService("CoreGui") end

local FlashFrame = Instance.new("Frame")
FlashFrame.Size = UDim2.new(1, 0, 1, 0)
FlashFrame.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
FlashFrame.BackgroundTransparency = 1
FlashFrame.BorderSizePixel = 0
FlashFrame.Parent = FlashGui

local function OpenPanel()
    if Opening then return end
    Opening = true
    PlayBoom()
    Main.Visible = true
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundTransparency = 1
    MS.Transparency = 1
    Header.BackgroundTransparency = 1
    HLine.BackgroundTransparency = 1
    Col1.Visible = false
    Col2.Visible = false
    BottomFrame.Visible = false
    Title2.TextTransparency = 1
    ConfigBtn.BackgroundTransparency = 1
    FlashFrame.BackgroundTransparency = 0.5
    task.wait(0.05)
    for i = 0, 10 do
        FlashFrame.BackgroundTransparency = 0.5 + (i/10) * 0.5
        task.wait(0.02)
    end
    FlashFrame.BackgroundTransparency = 1
    task.spawn(function()
        for i = 1, 30 do
            local particle = Instance.new("Frame")
            particle.Size = UDim2.new(0, 8, 0, 8)
            particle.Position = UDim2.new(0.5, 0, 0.5, 0)
            particle.AnchorPoint = Vector2.new(0.5, 0.5)
            particle.BackgroundColor3 = Themes[CurrentTheme]
            particle.BorderSizePixel = 0
            particle.Parent = Main
            local pc = Instance.new("UICorner")
            pc.CornerRadius = UDim.new(1, 0)
            pc.Parent = particle
            task.spawn(function()
                local angle = math.random() * math.pi * 2
                local distance = math.random(150, 300)
                local targetX = 0.5 + math.cos(angle) * (distance / 1000)
                local targetY = 0.5 + math.sin(angle) * (distance / 1000)
                for j = 0, 30 do
                    local t = j / 30
                    particle.Position = UDim2.new(0.5 + (targetX - 0.5) * t, 0, 0.5 + (targetY - 0.5) * t, 0)
                    particle.BackgroundTransparency = t
                    particle.Size = UDim2.new(0, 8 * (1 - t), 0, 8 * (1 - t))
                    task.wait(0.02)
                end
                particle:Destroy()
            end)
        end
    end)
    task.wait(0.1)
    Main.BackgroundTransparency = 0
    MS.Transparency = 0
    Header.BackgroundTransparency = 0
    HLine.BackgroundTransparency = 0
    TS:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 660, 0, 440),
        Position = UDim2.new(1, -680, 0, 30),
        AnchorPoint = Vector2.new(0, 0)
    }):Play()
    task.wait(0.3)
    for i = 0, 15 do
        Title2.TextTransparency = 1 - (i/15)
        ConfigBtn.BackgroundTransparency = 1 - (i/15)
        task.wait(0.02)
    end
    Col1.Visible = true
    Col2.Visible = true
    BottomFrame.Visible = true
    local function AnimateButtons(parent)
        for _, child in pairs(parent:GetChildren()) do
            if child:IsA("TextButton") then
                local originalSize = child.Size
                child.Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, 0)
                child.TextTransparency = 1
                task.spawn(function()
                    task.wait(math.random(1, 10) * 0.03)
                    TS:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = originalSize}):Play()
                    for i = 0, 10 do
                        child.TextTransparency = 1 - (i/10)
                        task.wait(0.02)
                    end
                end)
            end
        end
    end
    AnimateButtons(Col1)
    AnimateButtons(Col2)
    task.wait(0.5)
    Opening = false
    IsOpen = true
end

local function ClosePanel()
    if Opening then return end
    Opening = true
    PlayClick()
    TS:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    for i = 0, 15 do
        Main.BackgroundTransparency = (i/15)
        MS.Transparency = (i/15)
        Header.BackgroundTransparency = (i/15)
        HLine.BackgroundTransparency = (i/15)
        Title2.TextTransparency = (i/15)
        ConfigBtn.BackgroundTransparency = (i/15)
        task.wait(0.02)
    end
    Main.Visible = false
    Opening = false
    IsOpen = false
end

local TB = Instance.new("TextButton")
TB.Size = UDim2.new(0, 65, 0, 65)
TB.Position = UDim2.new(1, -85, 0, 60)
TB.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
TB.BorderSizePixel = 0
TB.Text = "🔥"
TB.TextSize = 32
TB.Font = Enum.Font.Michroma
TB.TextColor3 = Color3.fromRGB(255, 30, 30)
TB.Parent = ScreenGui

local TC = Instance.new("UICorner")
TC.CornerRadius = UDim.new(1, 0)
TC.Parent = TB

local TS_Stroke = Instance.new("UIStroke")
TS_Stroke.Color = Color3.fromRGB(255, 30, 30)
TS_Stroke.Thickness = 3
TS_Stroke.Parent = TB

task.spawn(function()
    local t = 0
    while true do
        task.wait(0.03)
        t = t + 0.1
        local pulse = 1 + math.sin(t) * 0.08
        pcall(function() TB.Size = UDim2.new(0, 65 * pulse, 0, 65 * pulse) end)
    end
end)

local OriginalSize = UDim2.new(0, 65, 0, 65)
local PressedSize = UDim2.new(0, 50, 0, 50)

TB.MouseButton1Down:Connect(function()
    TS:Create(TB, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = PressedSize}):Play()
    TS:Create(TB, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(80, 0, 0)}):Play()
    PlayClick()
end)

TB.MouseButton1Up:Connect(function()
    TS:Create(TB, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = OriginalSize}):Play()
    TS:Create(TB, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 0, 0)}):Play()
end)

TB.MouseButton1Click:Connect(function()
    if IsOpen then ClosePanel() else OpenPanel() end
end)

LP.CharacterAdded:Connect(function() task.wait(1) ApplySpeed() end)

task.wait(9)
Notify("🔥 CODEX HUB", "v" .. VERSION .. " carregado!", Color3.fromRGB(255, 30, 30))

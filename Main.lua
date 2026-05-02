local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Character = Player.Character or Player.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
local Camera = workspace.CurrentCamera
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

-- 1. PREMIUM UI TASARIMI (Neon Mavi & Koyu Gri)
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "Guzelyurt_Ultimate_V4"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 0, 0, 2)
MainFrame.ClipsDescendants = true
MainFrame.BorderSizePixel = 0

-- Premium Köşeler ve Neon Çerçeve
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(0, 150, 255)
UIStroke.Thickness = 2
UIStroke.Transparency = 1 -- Animasyonla belirecek

-- Başlık
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.BackgroundTransparency = 1
Title.Text = "SYSTEM: AWAKENED"
Title.TextColor3 = Color3.fromRGB(0, 150, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextTransparency = 1

-- 2. SİNEMATİK GİRİŞ ANİMASYONU (Pürüzsüz)
task.spawn(function()
    MainFrame:TweenSize(UDim2.new(0.2, 0, 0, 3), "Out", "Quint", 0.6, true)
    task.wait(0.6)
    MainFrame:TweenSize(UDim2.new(0.2, 0, 0.4, 0), "Out", "Elastic", 1, true)
    TS:Create(UIStroke, TweenInfo.new(1), {Transparency = 0}):Play()
    task.wait(1)
    
    local moveTween = TS:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.88, 0, 0.25, 0),
        Rotation = 360,
        Size = UDim2.new(0.18, 0, 0.45, 0)
    })
    moveTween:Play()
    task.wait(0.8)
    MainFrame.Rotation = 0
    TS:Create(Title, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
end)

-- 3. SİSTEM DEĞİŞKENLERİ
local Flying = false
local Awakening = false
local Speed = 2.5
local ForcedY = 0

local function createBtn(text, pos)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.85, 0, 0.16, 0)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.AutoButtonColor = false
    
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 6)
    
    -- Tıklama Efekti
    btn.MouseButton1Down:Connect(function()
        TS:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(0, 150, 255), TextColor3 = Color3.fromRGB(0,0,0)}):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        TS:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(55, 55, 65), TextColor3 = Color3.new(1,1,1)}):Play()
    end)
    
    btn.BackgroundTransparency = 1
    btn.TextTransparency = 1
    task.delay(2.5, function()
        TS:Create(btn, TweenInfo.new(0.5), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
    end)
    return btn
end

local flyBtn = createBtn("BOOT OFFLINE", UDim2.new(0.075, 0, 0.25, 0))
local speedBtn = createBtn("POWER: 75", UDim2.new(0.075, 0, 0.44, 0))
local upBtn = createBtn("ASCEND [^]", UDim2.new(0.075, 0, 0.63, 0))
local downBtn = createBtn("DESCEND [!^]", UDim2.new(0.075, 0, 0.82, 0))

-- 4. KUSURSUZ KLON MOTORU (Phantom Effect)
local function CreatePhantom()
    Character.Archivable = true
    local Clone = Character:Clone()
    Character.Archivable = false
    Clone.Parent = workspace
    
    for _, part in pairs(Clone:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = true
            part.CanCollide = false
            part.Color = Color3.fromRGB(0, 200, 255) -- Saf Neon Mavi
            part.Material = Enum.Material.Neon
            part.CastShadow = false
            TS:Create(part, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
        elseif part:IsA("Decal") or part:IsA("Texture") or part:IsA("Script") or part:IsA("LocalScript") then
            part:Destroy()
        end
    end
    Debris:AddItem(Clone, 1.5)
end

-- 5. KONTROL MERKEZİ (Awakening & Superposition)
flyBtn.MouseButton1Click:Connect(function()
    if Awakening then return end -- Spam engelleme
    
    if not Flying then
        Awakening = true
        flyBtn.Text = "SUPERPOSITION..."
        Title.Text = "OVERLOADING..."
        Title.TextColor3 = Color3.fromRGB(255, 50, 50)
        UIStroke.Color = Color3.fromRGB(255, 50, 50)
        Humanoid.PlatformStand = true
        
        -- Titreme ve Klon Bırakma
        local startTime = tick()
        while tick() - startTime < 1 do
            CreatePhantom()
            local shake = Vector3.new(math.random(-20,20)/10, math.random(-20,20)/10, math.random(-20,20)/10)
            RootPart.CFrame = RootPart.CFrame * CFrame.new(shake)
            task.wait(0.08)
        end
        
        Awakening = false
        Flying = true
        flyBtn.Text = "FLIGHT ACTIVE"
        Title.Text = "SYSTEM: ONLINE"
        Title.TextColor3 = Color3.fromRGB(0, 255, 100)
        UIStroke.Color = Color3.fromRGB(0, 255, 100)
    else
        Flying = false
        Awakening = false
        flyBtn.Text = "BOOT OFFLINE"
        Title.Text = "SYSTEM: STANDBY"
        Title.TextColor3 = Color3.fromRGB(0, 150, 255)
        UIStroke.Color = Color3.fromRGB(0, 150, 255)
        Humanoid.PlatformStand = false
        ForcedY = 0
    end
end)

speedBtn.MouseButton1Click:Connect(function()
    Speed = (Speed + 1 > 10) and 2.5 or Speed + 1
    speedBtn.Text = "POWER: "..(Speed * 30)
end)

upBtn.MouseButton1Down:Connect(function() if Flying then ForcedY = Speed end end)
upBtn.MouseButton1Up:Connect(function() ForcedY = 0 end)
downBtn.MouseButton1Down:Connect(function() if Flying then ForcedY = -Speed end end)
downBtn.MouseButton1Up:Connect(function() ForcedY = 0 end)

-- 6. PÜRÜZSÜZ UÇUŞ (Smooth CFrame & Superman Pose)
RunService.RenderStepped:Connect(function()
    if (Flying or Awakening) and RootPart then
        local MoveDir = Humanoid.MoveDirection
        local LookVector = Camera.CFrame.LookVector
        local VerticalMove = Vector3.new(0, ForcedY, 0)
        
        if Awakening then
            RootPart.Velocity = Vector3.new(0,0,0)
        elseif Flying then
            if MoveDir.Magnitude > 0 then
                -- Yere paralel tam Superman yatışı (-80 Derece)
                local targetCF = CFrame.new(RootPart.Position, RootPart.Position + LookVector) * CFrame.Angles(math.rad(-80), 0, 0)
                RootPart.CFrame = RootPart.CFrame:Lerp(targetCF + LookVector * (MoveDir.Magnitude * Speed) + VerticalMove, 0.12)
            else
                -- İleri bakarak dik durma
                local idleCF = CFrame.new(RootPart.Position, RootPart.Position + Vector3.new(LookVector.X, 0, LookVector.Z))
                RootPart.CFrame = RootPart.CFrame:Lerp(idleCF + VerticalMove, 0.12)
            end
            RootPart.Velocity = Vector3.new(0, 0, 0) -- Fiziksel düşmeyi sıfırla
        end
    end
end)

return function(Window)
    local VisualTab = Window:CreateTab("Visual", 4483362458)
    
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Stats = game:GetService("Stats")
    local Lighting = game:GetService("Lighting")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local Debris = game:GetService("Debris")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    
    -- ==========================================
    -- ВСЕ ТАБЛИЦЫ НАСТРОЕК (В НАЧАЛЕ СКРИПТА)
    -- ==========================================
    local HudSettings = {
        Enabled = true,
        RGB = true,
        RGBSpeed = 3
    }

    local HatSettings = {
        Enabled = false,
        Color = Color3.fromRGB(60, 255, 150)
    }

    local CrosshairSettings = {
        Enabled = false,
        Color = Color3.fromRGB(0, 255, 0),
        Size = 10,
        Gap = 5,
        Thickness = 2
    }

    local FOVSettings = {
        Enabled = false,
        Value = 70
    }

    local CustomWorldSettings = {
        Enabled = false,
        Color = Color3.fromRGB(255, 255, 255),
        Strength = 0.5,
        Transparency = 0,
        FogEnabled = false,
        FogEnd = 1000,
        OriginalColors = {},
        OriginalTransparencies = {}
    }

    local AtmosphereSettings = {
        Enabled = false,
        Color = Color3.fromRGB(0, 0, 0),
        Decay = Color3.fromRGB(0, 0, 0),
        Density = 0.35,
        Haze = 2.0,
        Glare = 0,
        Offset = 0.25,
        DarkLighting = true,
        ClockTime = 0,
        Brightness = 0.4,
        Exposure = -1.2,
        LightInfluence = 100
    }

    local PeakSettings = {
        Enabled = false,
        ColorSafe = Color3.fromRGB(0, 255, 100),   
        ColorUnsafe = Color3.fromRGB(255, 30, 30)  
    }

    local GunSettings = {
        Enabled = false,
        Style = "Снайперка",
        Color = Color3.fromRGB(138, 43, 226),
        Particles = true,
        Scale = 1,
        HideOriginal = true
    }

    local WeaponChamsSettings = {
        Enabled = false,
        TargetKnife = true,
        TargetGun = true,
        TargetScope = "Все (Я и другие)",
        Style = "Сплошной (Без текстуры)",
        ThroughWalls = true,
        Color = Color3.fromRGB(255, 45, 110),
        OutlineColor = Color3.fromRGB(255, 255, 255),
        Transparency = 0.2
    }

    local TracerSettings = {
        Enabled = false,
        Color = Color3.fromRGB(0, 170, 255),
        ThroughWalls = true,
        Duration = 2,
        Thickness = 0.15,
        OtherPlayers = true
    }

    -- ==========================================
    -- HUD (XCLIENT)
    -- ==========================================
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "XCLIENT_HUD"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    
    local success = pcall(function() ScreenGui.Parent = CoreGui end)
    if not success then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
    
    local HudFrame = Instance.new("Frame")
    HudFrame.Name = "HudFrame"
    HudFrame.Parent = ScreenGui
    HudFrame.AnchorPoint = Vector2.new(0.5, 0)
    HudFrame.Position = UDim2.new(0.5, 0, 0, 15)
    HudFrame.Size = UDim2.new(0, 0, 0, 26)
    HudFrame.AutomaticSize = Enum.AutomaticSize.X
    HudFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    HudFrame.BackgroundTransparency = 0.2
    HudFrame.BorderSizePixel = 0
    
    local HudCorner = Instance.new("UICorner")
    HudCorner.CornerRadius = UDim.new(0, 6)
    HudCorner.Parent = HudFrame
    
    local HudPadding = Instance.new("UIPadding")
    HudPadding.PaddingLeft = UDim.new(0, 12)
    HudPadding.PaddingRight = UDim.new(0, 12)
    HudPadding.Parent = HudFrame
    
    local HudStroke = Instance.new("UIStroke")
    HudStroke.Color = Color3.fromRGB(138, 43, 226)
    HudStroke.Thickness = 1.2
    HudStroke.Parent = HudFrame
    
    local HudText = Instance.new("TextLabel")
    HudText.Name = "HudText"
    HudText.Parent = HudFrame
    HudText.BackgroundTransparency = 1
    HudText.Size = UDim2.new(0, 0, 1, 0)
    HudText.AutomaticSize = Enum.AutomaticSize.X
    HudText.Font = Enum.Font.GothamSemibold
    HudText.Text = ""
    HudText.TextColor3 = Color3.fromRGB(220, 220, 220)
    HudText.TextSize = 13
    HudText.RichText = true

    local murdererName = "Searching..."
    local sheriffName = "Searching..."

    -- ==========================================
    -- ОКНО WATERMARK
    -- ==========================================
    local DragWindow = Instance.new("Frame")
    DragWindow.Name = "XCLIENTWaterMark"
    DragWindow.Parent = ScreenGui
    DragWindow.Position = UDim2.new(0.1, 0, 0.2, 0)
    DragWindow.Size = UDim2.new(0, 250, 0, 105) 
    DragWindow.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    DragWindow.BorderSizePixel = 0
    DragWindow.Visible = true

    local WindowCorner = Instance.new("UICorner")
    WindowCorner.CornerRadius = UDim.new(0, 8)
    WindowCorner.Parent = DragWindow

    local WindowStroke = Instance.new("UIStroke")
    WindowStroke.Color = Color3.fromRGB(70, 70, 70)
    WindowStroke.Thickness = 1
    WindowStroke.Parent = DragWindow

    local WindowTitle = Instance.new("TextLabel")
    WindowTitle.Name = "Title"
    WindowTitle.Parent = DragWindow
    WindowTitle.Size = UDim2.new(1, 0, 0, 30)
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.Font = Enum.Font.GothamBold
    WindowTitle.Text = "XClient Info"
    WindowTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    WindowTitle.TextSize = 12

    local ExtraText = Instance.new("TextLabel")
    ExtraText.Name = "MurdererText"
    ExtraText.Parent = DragWindow 
    ExtraText.Position = UDim2.new(0, 12, 0, 30) 
    ExtraText.Size = UDim2.new(1, -24, 0, 22) 
    ExtraText.BackgroundTransparency = 1
    ExtraText.Font = Enum.Font.Gotham
    ExtraText.TextXAlignment = Enum.TextXAlignment.Left
    ExtraText.Text = "Murderer: " .. murdererName
    ExtraText.TextColor3 = Color3.fromRGB(255, 85, 85)
    ExtraText.TextSize = 12

    local ExtraText2 = Instance.new("TextLabel")
    ExtraText2.Name = "SheriffText"
    ExtraText2.Parent = DragWindow 
    ExtraText2.Position = UDim2.new(0, 12, 0, 52) 
    ExtraText2.Size = UDim2.new(1, -24, 0, 22) 
    ExtraText2.BackgroundTransparency = 1
    ExtraText2.Font = Enum.Font.Gotham
    ExtraText2.TextXAlignment = Enum.TextXAlignment.Left
    ExtraText2.Text = "Sheriff: " .. sheriffName
    ExtraText2.TextColor3 = Color3.fromRGB(85, 170, 255)
    ExtraText2.TextSize = 12

    local LogoImage = Instance.new("ImageLabel")
    LogoImage.Name = "LogoIcon"
    LogoImage.Parent = DragWindow
    LogoImage.AnchorPoint = Vector2.new(0, 1)
    LogoImage.Position = UDim2.new(0, 12, 1, -8)
    LogoImage.Size = UDim2.new(0, 16, 0, 16)
    LogoImage.BackgroundTransparency = 1
    LogoImage.Image = ""
    
    _G.XClientWatermarkLogo = LogoImage

    task.spawn(function()
        local githubUrl = "https://github.com/geragori11/visual/blob/main/logo.png"
        local filename = "logo.png"
        
        if writefile and getcustomasset and isfile then
            local downloadSuccess, downloadResult = pcall(function()
                if not isfile(filename) then
                    writefile(filename, game:HttpGet(githubUrl))
                end
                return getcustomasset(filename)
            end)
            
            if downloadSuccess then
                LogoImage.Image = downloadResult
            else
                warn("[XCLIENT] Ошибка кэширования картинки: " .. tostring(downloadResult))
            end
        else
            LogoImage.Image = "rbxassetid://0"
        end
    end)

    local ExtraText3 = Instance.new("TextLabel")
    ExtraText3.Name = "GameText"
    ExtraText3.Parent = DragWindow 
    ExtraText3.AnchorPoint = Vector2.new(0, 1) 
    ExtraText3.Position = UDim2.new(0, 34, 1, -8)
    ExtraText3.Size = UDim2.new(1, -46, 0, 16) 
    ExtraText3.BackgroundTransparency = 1
    ExtraText3.Font = Enum.Font.Gotham
    ExtraText3.TextXAlignment = Enum.TextXAlignment.Left
    ExtraText3.Text = "Murder Mystery 2" 
    ExtraText3.TextColor3 = Color3.fromRGB(220, 220, 220) 
    ExtraText3.TextSize = 9
    
    _G.XClientWatermarkLabel = ExtraText3

    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        DragWindow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    DragWindow.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = DragWindow.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    DragWindow.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- ==========================================
    -- ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ПОИСКА
    -- ==========================================
    local function getLocalGun()
        local character = LocalPlayer.Character
        if not character then return nil end
        for _, child in ipairs(character:GetChildren()) do
            if child:IsA("Tool") then
                local name = string.lower(child.Name)
                if (name:match("gun") or name:match("revolver") or name:match("пистолет") or name:match("luger") or name:match("shotgun")) and not name:match("knife") then
                    return child
                end
                if child:FindFirstChild("GunServer") or child:FindFirstChild("GunScript") then
                    return child
                end
            end
        end
        return nil
    end

    local function getMurderer()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hasKnife = p.Character:FindFirstChild("Knife") or (p:FindFirstChild("Backpack") and p.Backpack:FindFirstChild("Knife"))
                if hasKnife then
                    return p
                end
            end
        end
        return nil
    end

    local function getSheriff()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hasGunItem = p.Character:FindFirstChild("Gun") or p.Character:FindFirstChild("Revolver") or 
                                   (p:FindFirstChild("Backpack") and (p.Backpack:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Revolver")))
                if hasGunItem then
                    return p
                end
            end
        end
        return nil
    end

    local function hasGun()
        local char = LocalPlayer.Character
        local backpack = LocalPlayer:FindFirstChild("Backpack")
        
        local gunInChar = char and (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver"))
        local gunInBackpack = backpack and (backpack:FindFirstChild("Gun") or backpack:FindFirstChild("Revolver"))
        
        return not not (gunInChar or gunInBackpack)
    end

    -- ==========================================
    -- СИСТЕМА CUSTOM GUN
    -- ==========================================
    local GunModelHandle = nil
    local GunModelStyle = nil
    local GunParts = {}
    local GunOriginalProperties = {}
    local GunOriginalMeshScale = {}
    local GunMuzzle = nil
    local GunLight = nil

    local function destroyGunParts()
        for _, part in ipairs(GunParts) do
            if part and part.Parent then part:Destroy() end
        end
        table.clear(GunParts)
        GunMuzzle = nil
        GunLight = nil
        GunModelHandle = nil
        GunModelStyle = nil
    end

    local function restoreGunVisibility()
        for part, props in pairs(GunOriginalProperties) do
            if part and part.Parent then
                pcall(function()
                    part.Transparency = props.Transparency
                    part.LocalTransparencyModifier = props.LocalTransparencyModifier
                end)
            end
        end
        table.clear(GunOriginalProperties)

        for mesh, scale in pairs(GunOriginalMeshScale) do
            if mesh and mesh.Parent then
                pcall(function()
                    mesh.Scale = scale
                end)
            end
        end
        table.clear(GunOriginalMeshScale)
    end

    local function clearCustomGun()
        destroyGunParts()
        restoreGunVisibility()
    end

    local function addGunPart(handle, name, size, offsetCFrame, shape, material)
        local tool = handle.Parent
        local part = Instance.new("Part")
        part.Name = "XCLIENT_" .. name
        part.Size = size * GunSettings.Scale
        part.Color = GunSettings.Color
        part.Material = material or Enum.Material.Metal
        part.Anchored = false
        part.CanCollide = false
        part.Massless = true
        part.CanQuery = false
        part.CanTouch = false
        part.CastShadow = false
        part.TopSurface = Enum.SurfaceType.Smooth
        part.BottomSurface = Enum.SurfaceType.Smooth
        if shape then part.Shape = shape end
        part:SetAttribute("BaseSize", size)
        part:SetAttribute("BaseOffset", offsetCFrame)

        local scaledOffset = CFrame.new(offsetCFrame.Position * GunSettings.Scale) * (offsetCFrame - offsetCFrame.Position)
        part.CFrame = handle.CFrame * scaledOffset
        part.Parent = tool

        local weld = Instance.new("Weld")
        weld.Name = "XCLIENT_Weld"
        weld.Part0 = handle
        weld.Part1 = part
        weld.C0 = scaledOffset
        weld.C1 = CFrame.new()
        weld.Parent = part

        table.insert(GunParts, part)
        return part
    end

    local function addMuzzle(handle, offsetCFrame)
        local muzzle = addGunPart(handle, "Muzzle", Vector3.new(0.22, 0.24, 0.24), offsetCFrame, Enum.PartType.Cylinder, Enum.Material.Neon)
        local emitter = Instance.new("ParticleEmitter")
        emitter.Name = "XCLIENT_MuzzleFlash"
        emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        emitter.Color = ColorSequence.new(GunSettings.Color, Color3.new(1, 1, 1))
        emitter.LightEmission = 1
        emitter.LightInfluence = 0
        emitter.Size = NumberSequence.new(0.7, 0)
        emitter.Transparency = NumberSequence.new(0)
        emitter.Lifetime = NumberRange.new(0.12, 0.25)
        emitter.Speed = NumberRange.new(4, 9)
        emitter.SpreadAngle = Vector2.new(25, 25)
        emitter.Rate = GunSettings.Particles and 12 or 0
        emitter.Enabled = true
        emitter.Parent = muzzle

        local light = Instance.new("PointLight")
        light.Name = "XCLIENT_MuzzleLight"
        light.Color = GunSettings.Color
        light.Range = 12
        light.Brightness = GunSettings.Particles and 3 or 0
        light.Parent = muzzle

        GunMuzzle = muzzle
        GunLight = light
        return muzzle
    end

    local function buildSniper(handle)
        addGunPart(handle, "Body", Vector3.new(0.32, 0.32, 1.3), CFrame.new(0, 0.12, -0.55))
        addGunPart(handle, "Barrel", Vector3.new(2.1, 0.16, 0.16), CFrame.new(0, 0.22, -1.7) * CFrame.Angles(0, math.rad(90), 0), Enum.PartType.Cylinder)
        addGunPart(handle, "Scope", Vector3.new(0.2, 0.2, 0.95), CFrame.new(0, 0.62, -0.7))
        addGunPart(handle, "ScopeLens", Vector3.new(0.12, 0.24, 0.24), CFrame.new(0, 0.62, -1.2) * CFrame.Angles(0, math.rad(90), 0), Enum.PartType.Cylinder, Enum.Material.Neon)
        addGunPart(handle, "Stock", Vector3.new(0.22, 0.28, 0.9), CFrame.new(0, -0.02, 0.5))
        addGunPart(handle, "Grip", Vector3.new(0.16, 0.55, 0.22), CFrame.new(0, -0.4, 0.2))
        addMuzzle(handle, CFrame.new(0, 0.22, -2.72) * CFrame.Angles(0, math.rad(90), 0))
    end

    local function buildPistol(handle)
        addGunPart(handle, "Body", Vector3.new(0.26, 0.3, 0.85), CFrame.new(0, 0.1, -0.35), nil, Enum.Material.SmoothPlastic)
        addGunPart(handle, "Barrel", Vector3.new(0.7, 0.14, 0.14), CFrame.new(0, 0.2, -0.95) * CFrame.Angles(0, math.rad(90), 0), Enum.PartType.Cylinder)
        addGunPart(handle, "Slide", Vector3.new(0.24, 0.12, 0.85), CFrame.new(0, 0.28, -0.4), nil, Enum.Material.SmoothPlastic)
        addGunPart(handle, "Grip", Vector3.new(0.16, 0.55, 0.24), CFrame.new(0, -0.4, 0.02), nil, Enum.Material.SmoothPlastic)
        addMuzzle(handle, CFrame.new(0, 0.2, -1.35) * CFrame.Angles(0, math.rad(90), 0))
    end

    local function buildMinigun(handle)
        addGunPart(handle, "Body", Vector3.new(0.5, 0.5, 1.1), CFrame.new(0, 0.1, -0.4))
        for i = 0, 5 do
            local angle = (math.pi * 2 / 6) * i
            local x = math.sin(angle) * 0.13
            local y = 0.2 + math.cos(angle) * 0.13
            addGunPart(handle, "Barrel" .. i, Vector3.new(1.7, 0.09, 0.09), CFrame.new(x, y, -1.6) * CFrame.Angles(0, math.rad(90), 0), Enum.PartType.Cylinder)
        end
        addGunPart(handle, "Grip", Vector3.new(0.18, 0.5, 0.22), CFrame.new(0, -0.4, 0.15))
        addMuzzle(handle, CFrame.new(0, 0.2, -2.45) * CFrame.Angles(0, math.rad(90), 0))
    end

    local function buildVanilla(handle)
        addGunPart(handle, "Body", Vector3.new(0.3, 0.3, 1.0), CFrame.new(0, 0.1, -0.45), nil, Enum.Material.SmoothPlastic)
        addGunPart(handle, "Barrel", Vector3.new(1.3, 0.14, 0.14), CFrame.new(0, 0.2, -1.4) * CFrame.Angles(0, math.rad(90), 0), Enum.PartType.Cylinder, Enum.Material.SmoothPlastic)
    end

    local function buildCustomGun(handle)
        local style = GunSettings.Style
        if style == "Пистолет" then
            buildPistol(handle)
        elseif style == "Мини-ган" then
            buildMinigun(handle)
        elseif style == "Ванильный" then
            buildVanilla(handle)
        else
            buildSniper(handle)
        end
    end

    local function applyGunAppearance()
        for _, part in ipairs(GunParts) do
            part.Color = GunSettings.Color
            local base = part:GetAttribute("BaseSize")
            if base then part.Size = base * GunSettings.Scale end
        end
        if GunMuzzle then
            local emitter = GunMuzzle:FindFirstChildOfClass("ParticleEmitter")
            if emitter then
                emitter.Rate = GunSettings.Particles and 12 or 0
                emitter.Color = ColorSequence.new(GunSettings.Color, Color3.new(1, 1, 1))
            end
        end
        if GunLight then
            GunLight.Color = GunSettings.Color
            GunLight.Brightness = GunSettings.Particles and 3 or 0
        end
    end

    -- ==========================================
    -- BULLET TRACERS (ТРАССЕРЫ ПУЛЬ)
    -- ==========================================
    local TracersFolder = workspace:FindFirstChild("XCLIENT_Tracers")
    if not TracersFolder then
        TracersFolder = Instance.new("Folder")
        TracersFolder.Name = "XCLIENT_Tracers"
        TracersFolder.Parent = workspace
    end

    local function getLocalGunMuzzle()
        if GunSettings.Enabled and GunMuzzle and GunMuzzle.Parent then
            return GunMuzzle.Position
        end

        local gun = getLocalGun()
        if gun then
            local muzzle = gun:FindFirstChild("Muzzle") or gun:FindFirstChild("Flash")
            if muzzle and muzzle:IsA("BasePart") then
                return muzzle.Position
            end
            local handle = gun:FindFirstChild("Handle") or gun:FindFirstChildWhichIsA("BasePart")
            if handle then
                return (handle.CFrame * CFrame.new(0, 0.2, -1.2)).Position
            end
        end

        local char = LocalPlayer.Character
        local rightHand = char and (char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm"))
        if rightHand then
            return rightHand.Position
        end
        return nil
    end

    local function getTargetPositionFromMouse()
        local mousePos = UserInputService:GetMouseLocation()
        local x = mousePos.X
        local y = mousePos.Y
        if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
            x = Camera.ViewportSize.X / 2
            y = Camera.ViewportSize.Y / 2
        end

        local ray = Camera:ViewportPointToRay(x, y)
        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Exclude

        local ignoreList = {TracersFolder}
        if LocalPlayer.Character then
            table.insert(ignoreList, LocalPlayer.Character)
        end
        rayParams.FilterDescendantsInstances = ignoreList

        local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, rayParams)
        if result then
            return result.Position
        else
            return ray.Origin + ray.Direction * 500
        end
    end

    local function spawnTracer(startPos, endPos)
        if not TracerSettings.Enabled then return end
        local distance = (endPos - startPos).Magnitude
        if distance < 0.5 then return end

        local tracer = Instance.new("Part")
        tracer.Name = "XCLIENT_BulletTracer"
        tracer.Anchored = true
        tracer.CanCollide = false
        tracer.CanQuery = false
        tracer.CanTouch = false
        tracer.CastShadow = false
        tracer.Material = Enum.Material.Neon
        tracer.Color = TracerSettings.Color
        tracer.Shape = Enum.PartType.Cylinder
        tracer.Size = Vector3.new(distance, TracerSettings.Thickness, TracerSettings.Thickness)
        tracer.CFrame = CFrame.lookAt(startPos, endPos) * CFrame.new(0, 0, -distance / 2) * CFrame.Angles(0, math.rad(90), 0)
        tracer.Parent = TracersFolder

        local highlight = nil
        if TracerSettings.ThroughWalls then
            highlight = Instance.new("Highlight")
            highlight.Name = "TracerHl"
            highlight.Adornee = tracer
            highlight.FillColor = TracerSettings.Color
            highlight.OutlineColor = TracerSettings.Color
            highlight.FillTransparency = 0
            highlight.OutlineTransparency = 1
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = tracer
        end

        local tweenInfo = TweenInfo.new(TracerSettings.Duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(tracer, tweenInfo, {
            Transparency = 1
        })
        tween:Play()

        if highlight then
            local hlTween = TweenService:Create(highlight, tweenInfo, {
                FillTransparency = 1
            })
            hlTween:Play()
        end

        Debris:AddItem(tracer, TracerSettings.Duration)
    end

    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        
        if GunSettings.Enabled and GunMuzzle then
            local emitter = GunMuzzle:FindFirstChildOfClass("ParticleEmitter")
            if emitter and GunSettings.Particles then
                emitter:Emit(18)
                if GunLight then
                    GunLight.Brightness = 8
                    task.delay(0.08, function()
                        if GunLight then GunLight.Brightness = GunSettings.Particles and 3 or 0 end
                    end)
                end
            end
        end

        if TracerSettings.Enabled then
            local gun = getLocalGun()
            if gun then
                local startPos = getLocalGunMuzzle()
                if startPos then
                    local endPos = getTargetPositionFromMouse()
                    spawnTracer(startPos, endPos)
                end
            end
        end
    end)

    local function monitorWeaponSound(descendant)
        if descendant:IsA("Sound") then
            local name = string.lower(descendant.Name)
            if name:match("shoot") or name:match("shot") or name:match("fire") or name:match("bang") then
                descendant:GetPropertyChangedSignal("Playing"):Connect(function()
                    if descendant.Playing and TracerSettings.Enabled and TracerSettings.OtherPlayers then
                        local parentPart = descendant.Parent
                        if parentPart and parentPart:IsA("BasePart") then
                            local tool = parentPart:FindFirstAncestorOfClass("Tool")
                            local char = tool and tool.Parent
                            if char and char:IsA("Model") and char ~= LocalPlayer.Character then
                                local startPos = parentPart.Position
                                local forward = parentPart.CFrame.LookVector
                                local rayParams = RaycastParams.new()
                                rayParams.FilterType = Enum.RaycastFilterType.Exclude
                                rayParams.FilterDescendantsInstances = {char, TracersFolder}
                                local result = workspace:Raycast(startPos, forward * 1000, rayParams)
                                local endPos = result and result.Position or (startPos + forward * 500)
                                spawnTracer(startPos, endPos)
                            end
                        end
                    end
                end)
            end
        end
    end

    for _, desc in ipairs(workspace:GetDescendants()) do
        monitorWeaponSound(desc)
    end
    workspace.DescendantAdded:Connect(monitorWeaponSound)

    -- ==========================================
    -- ШЛЯПА CHINA HAT
    -- ==========================================
    local ChinaHat = Instance.new("Part")
    ChinaHat.Name = "XCLIENT_ChinaHat"
    ChinaHat.Anchored = true
    ChinaHat.CanCollide = false
    ChinaHat.Material = Enum.Material.Neon
    ChinaHat.Transparency = 0.5
    ChinaHat.Size = Vector3.new(1.16, 0.46, 1.16) 
    ChinaHat.Color = HatSettings.Color
    
    local HatMesh = Instance.new("SpecialMesh", ChinaHat)
    HatMesh.MeshType = Enum.MeshType.FileMesh
    HatMesh.MeshId = "rbxassetid://1033714"
    HatMesh.Scale = Vector3.new(1.16, 0.46, 1.16)

    -- ==========================================
    -- КАСТОМНЫЙ ПРИЦЕЛ (CROSSHAIR)
    -- ==========================================
    local CrosshairFolder = Instance.new("Folder", ScreenGui)
    CrosshairFolder.Name = "Crosshair"
    
    local Lines = {}
    for i = 1, 4 do
        local Line = Instance.new("Frame", CrosshairFolder)
        Line.BorderSizePixel = 0
        Line.Visible = false
        table.insert(Lines, Line)
    end

    -- ==========================================
    -- ШЕЙДЕРЫ
    -- ==========================================
    local ShadersFolder = Instance.new("Folder")
    ShadersFolder.Name = "XCLIENT_Shaders"

    local Bloom = Instance.new("BloomEffect", ShadersFolder)
    Bloom.Intensity = 1.2
    Bloom.Size = 24
    Bloom.Threshold = 0.8

    local ColorCorr = Instance.new("ColorCorrectionEffect", ShadersFolder)
    ColorCorr.Contrast = 0.15
    ColorCorr.Saturation = 0.25
    ColorCorr.Brightness = 0.02

    local SunRays = Instance.new("SunRaysEffect", ShadersFolder)
    SunRays.Intensity = 0.25

    -- ==========================================
    -- CUSTOM WORLD ЛОГИКА
    -- ==========================================
    local OriginalLighting = {
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        FogColor = Lighting.FogColor,
        FogEnd = Lighting.FogEnd,
        FogStart = Lighting.FogStart
    }

    local function applyCustomWorld()
        if not CustomWorldSettings.Enabled then
            for part, original in pairs(CustomWorldSettings.OriginalColors) do
                if part and part.Parent then
                    pcall(function() part.Color = original end)
                end
            end
            for part, original in pairs(CustomWorldSettings.OriginalTransparencies) do
                if part and part.Parent then
                    pcall(function() part.Transparency = original end)
                end
            end
            table.clear(CustomWorldSettings.OriginalColors)
            table.clear(CustomWorldSettings.OriginalTransparencies)
            
            Lighting.Ambient = OriginalLighting.Ambient
            Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient
            Lighting.FogColor = OriginalLighting.FogColor
            Lighting.FogEnd = OriginalLighting.FogEnd
            Lighting.FogStart = OriginalLighting.FogStart
            return
        end

        for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part:IsDescendantOf(LocalPlayer.Character) and not part.Name:match("XCLIENT") then
                local isWall = string.lower(part.Name):match("wall") or string.lower(part.Name):match("стена")
                
                if not CustomWorldSettings.OriginalColors[part] then
                    CustomWorldSettings.OriginalColors[part] = part.Color
                end
                if not CustomWorldSettings.OriginalTransparencies[part] then
                    CustomWorldSettings.OriginalTransparencies[part] = part.Transparency
                end

                local baseColor = CustomWorldSettings.OriginalColors[part]
                if isWall then
                    pcall(function()
                        part.Color = baseColor:Lerp(CustomWorldSettings.Color, CustomWorldSettings.Strength)
                        part.Transparency = CustomWorldSettings.Transparency
                    end)
                else
                    pcall(function()
                        part.Color = baseColor:Lerp(CustomWorldSettings.Color, CustomWorldSettings.Strength * 0.4)
                    end)
                end
            end
        end

        Lighting.Ambient = CustomWorldSettings.Color:Lerp(Color3.fromRGB(0, 0, 0), 0.4)
        Lighting.OutdoorAmbient = CustomWorldSettings.Color:Lerp(Color3.fromRGB(0, 0, 0), 0.2)
        
        if CustomWorldSettings.FogEnabled then
            Lighting.FogColor = CustomWorldSettings.Color
            Lighting.FogEnd = CustomWorldSettings.FogEnd
            Lighting.FogStart = 0
        else
            Lighting.FogEnd = 100000
        end
    end

    workspace.DescendantAdded:Connect(function(part)
        if CustomWorldSettings.Enabled then
            task.wait(0.1)
            if part:IsA("BasePart") and not part:IsDescendantOf(LocalPlayer.Character) and not part.Name:match("XCLIENT") then
                local isWall = string.lower(part.Name):match("wall") or string.lower(part.Name):match("стена")
                
                if not CustomWorldSettings.OriginalColors[part] then
                    CustomWorldSettings.OriginalColors[part] = part.Color
                end
                if not CustomWorldSettings.OriginalTransparencies[part] then
                    CustomWorldSettings.OriginalTransparencies[part] = part.Transparency
                end
                
                local baseColor = CustomWorldSettings.OriginalColors[part]
                if isWall then
                    pcall(function()
                        part.Color = baseColor:Lerp(CustomWorldSettings.Color, CustomWorldSettings.Strength)
                        part.Transparency = CustomWorldSettings.Transparency
                    end)
                else
                    pcall(function()
                        part.Color = baseColor:Lerp(CustomWorldSettings.Color, CustomWorldSettings.Strength * 0.4)
                    end)
                end
            end
        end
    end)

    -- ==========================================
    -- CUSTOM ATMOSPHERE ЛОГИКА
    -- ==========================================
    local CustomAtmosphere = nil
    local OriginalAtmosphere = nil
    local OriginalAtmosphereParent = nil
    local OriginalLightingAtmosphereState = {
        ClockTime = Lighting.ClockTime,
        Brightness = Lighting.Brightness,
        ExposureCompensation = Lighting.ExposureCompensation,
        EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
        EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale
    }
    local OriginalMapLights = {}

    local function applyLightInfluence()
        local mult = AtmosphereSettings.LightInfluence / 100

        for _, light in ipairs(workspace:GetDescendants()) do
            if light:IsA("Light") and not light.Name:match("XCLIENT") and not light:IsDescendantOf(LocalPlayer.Character) then
                if OriginalMapLights[light] == nil then
                    OriginalMapLights[light] = light.Brightness
                end
                light.Brightness = OriginalMapLights[light] * mult
            end
        end

        pcall(function()
            Lighting.EnvironmentDiffuseScale = OriginalLightingAtmosphereState.EnvironmentDiffuseScale * mult
            Lighting.EnvironmentSpecularScale = OriginalLightingAtmosphereState.EnvironmentSpecularScale * mult
        end)
    end

    local function restoreMapLights()
        for light, origBrightness in pairs(OriginalMapLights) do
            if light and light.Parent then
                pcall(function()
                    light.Brightness = origBrightness
                end)
            end
        end
        table.clear(OriginalMapLights)

        pcall(function()
            Lighting.EnvironmentDiffuseScale = OriginalLightingAtmosphereState.EnvironmentDiffuseScale
            Lighting.EnvironmentSpecularScale = OriginalLightingAtmosphereState.EnvironmentSpecularScale
        end)
    end

    workspace.DescendantAdded:Connect(function(descendant)
        if AtmosphereSettings.Enabled and descendant:IsA("Light") and not descendant.Name:match("XCLIENT") and not descendant:IsDescendantOf(LocalPlayer.Character) then
            task.wait(0.05)
            if OriginalMapLights[descendant] == nil then
                OriginalMapLights[descendant] = descendant.Brightness
            end
            descendant.Brightness = OriginalMapLights[descendant] * (AtmosphereSettings.LightInfluence / 100)
        end
    end)

    local function applyCustomAtmosphere()
        if not AtmosphereSettings.Enabled then
            if CustomAtmosphere then
                CustomAtmosphere:Destroy()
                CustomAtmosphere = nil
            end
            if OriginalAtmosphere and OriginalAtmosphereParent then
                OriginalAtmosphere.Parent = OriginalAtmosphereParent
                OriginalAtmosphere = nil
                OriginalAtmosphereParent = nil
            end

            Lighting.ClockTime = OriginalLightingAtmosphereState.ClockTime
            Lighting.Brightness = OriginalLightingAtmosphereState.Brightness
            Lighting.ExposureCompensation = OriginalLightingAtmosphereState.ExposureCompensation
            restoreMapLights()
            return
        end

        local existing = Lighting:FindFirstChildOfClass("Atmosphere")
        if existing and existing ~= CustomAtmosphere then
            OriginalAtmosphere = existing
            OriginalAtmosphereParent = existing.Parent
            existing.Parent = nil
        end

        if not CustomAtmosphere or CustomAtmosphere.Parent ~= Lighting then
            CustomAtmosphere = Instance.new("Atmosphere")
            CustomAtmosphere.Name = "XCLIENT_Atmosphere"
            CustomAtmosphere.Parent = Lighting
        end

        CustomAtmosphere.Color = Color3.fromRGB(0, 0, 0)
        CustomAtmosphere.Decay = Color3.fromRGB(0, 0, 0)
        CustomAtmosphere.Density = AtmosphereSettings.Density
        CustomAtmosphere.Haze = AtmosphereSettings.Haze
        CustomAtmosphere.Glare = AtmosphereSettings.Glare
        CustomAtmosphere.Offset = AtmosphereSettings.Offset

        if AtmosphereSettings.DarkLighting then
            Lighting.ClockTime = 0
            Lighting.Brightness = AtmosphereSettings.Brightness
            Lighting.ExposureCompensation = AtmosphereSettings.Exposure
        else
            Lighting.ClockTime = OriginalLightingAtmosphereState.ClockTime
            Lighting.Brightness = OriginalLightingAtmosphereState.Brightness
            Lighting.ExposureCompensation = OriginalLightingAtmosphereState.ExposureCompensation
        end

        applyLightInfluence()
    end

    -- ==========================================
    -- PEAK ASSISTANT ЛОГИКА
    -- ==========================================
    local PeakMarker = Instance.new("Part")
    PeakMarker.Name = "XCLIENT_PeakMarker"
    PeakMarker.Anchored = true
    PeakMarker.CanCollide = false
    PeakMarker.Shape = Enum.PartType.Cylinder
    PeakMarker.Size = Vector3.new(0.05, 5, 5)
    PeakMarker.Material = Enum.Material.Neon
    PeakMarker.Transparency = 0.5

    local function isBehindWall(targetChar)
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return false end
        if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then return false end
        
        local origin = LocalPlayer.Character.HumanoidRootPart.Position
        local targetPos = targetChar.HumanoidRootPart.Position
        local direction = targetPos - origin
        
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, targetChar, ChinaHat, PeakMarker, TracersFolder}
        
        local result = workspace:Raycast(origin, direction, raycastParams)
        return result ~= nil
    end

    local function checkPeekCondition(targetChar)
        if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then return false end
        local targetHrp = targetChar.HumanoidRootPart
        local myHrp = LocalPlayer.Character.HumanoidRootPart
        
        local velocity = targetHrp.AssemblyLinearVelocity
        
        if velocity.Magnitude < 2 then
            return true
        end
        
        local toMeDirection = (myHrp.Position - targetHrp.Position).Unit
        local movementDirection = velocity.Unit
        local dotProduct = movementDirection:Dot(toMeDirection)
        
        if dotProduct > 0.85 then
            return true
        end
        
        return false
    end

    -- ==========================================
    -- WEAPON CHAMS ЛОГИКА
    -- ==========================================
    local ChammedParts = {}
    local ChammedHighlights = {}
    local ChammedLights = {}
    local ChammedMeshTextures = {}
    local ChammedMeshPartTextures = {}
    local ChammedDecalTransparencies = {}
    local ChammedSurfaceAppearances = {}

    local function getVibrantColor(baseColor)
        local h, s, v = baseColor:ToHSV()
        return Color3.fromHSV(h, math.clamp(s * 0.9, 0, 1), math.min(v * 1.25, 1))
    end

    local function restoreWeaponTextures()
        for mesh, texId in pairs(ChammedMeshTextures) do
            if mesh and mesh.Parent then
                pcall(function() mesh.TextureId = texId end)
            end
        end
        table.clear(ChammedMeshTextures)

        for meshPart, texId in pairs(ChammedMeshPartTextures) do
            if meshPart and meshPart.Parent then
                pcall(function() meshPart.TextureID = texId end)
            end
        end
        table.clear(ChammedMeshPartTextures)

        for decal, trans in pairs(ChammedDecalTransparencies) do
            if decal and decal.Parent then
                pcall(function() decal.Transparency = trans end)
            end
        end
        table.clear(ChammedDecalTransparencies)

        for sa, parent in pairs(ChammedSurfaceAppearances) do
            if sa then
                pcall(function() sa.Parent = parent end)
            end
        end
        table.clear(ChammedSurfaceAppearances)
    end

    local function restoreWeaponChams()
        for part, orig in pairs(ChammedParts) do
            if part and part.Parent then
                pcall(function()
                    part.Color = orig.Color
                    part.Material = orig.Material
                    part.Transparency = orig.Transparency
                    part.Reflectance = orig.Reflectance
                end)
            end
        end
        table.clear(ChammedParts)

        restoreWeaponTextures()

        for tool, hl in pairs(ChammedHighlights) do
            if hl and hl.Parent then
                hl:Destroy()
            end
        end
        table.clear(ChammedHighlights)

        for part, light in pairs(ChammedLights) do
            if light and light.Parent then
                light:Destroy()
            end
        end
        table.clear(ChammedLights)
    end

    local function getActiveWeapons()
        local weapons = {}

        local function checkTool(tool, isLocal)
            if not tool or not tool:IsA("Tool") then return end
            local nameLower = string.lower(tool.Name)
            local isKnife = nameLower:match("knife") or nameLower:match("нож") or tool:FindFirstChild("KnifeServer")
            local isGun = nameLower:match("gun") or nameLower:match("revolver") or nameLower:match("пистолет") or tool:FindFirstChild("GunServer")

            if (isKnife and WeaponChamsSettings.TargetKnife) or (isGun and WeaponChamsSettings.TargetGun) then
                if isLocal and isGun and GunSettings.Enabled then
                    return
                end
                table.insert(weapons, tool)
            end
        end

        for _, p in ipairs(Players:GetPlayers()) do
            local isLocal = (p == LocalPlayer)
            local allowed = false
            if WeaponChamsSettings.TargetScope == "Все (Я и другие)" then
                allowed = true
            elseif WeaponChamsSettings.TargetScope == "Только моё" and isLocal then
                allowed = true
            elseif WeaponChamsSettings.TargetScope == "Только нож/оружие других" and not isLocal then
                allowed = true
            end

            if allowed and p.Character then
                for _, child in ipairs(p.Character:GetChildren()) do
                    if child:IsA("Tool") then
                        checkTool(child, isLocal)
                    end
                end
            end
        end

        if WeaponChamsSettings.TargetGun then
            local gunDrop = workspace:FindFirstChild("GunDrop")
            if gunDrop then
                table.insert(weapons, gunDrop)
            end
        end

        return weapons
    end

    local function updateWeaponChams()
        if not WeaponChamsSettings.Enabled then
            if next(ChammedParts) ~= nil or next(ChammedHighlights) ~= nil or next(ChammedMeshTextures) ~= nil or next(ChammedLights) ~= nil then
                restoreWeaponChams()
            end
            return
        end

        local activeWeapons = getActiveWeapons()
        local activeWeaponSet = {}
        local activePartSet = {}
        local brightColor = getVibrantColor(WeaponChamsSettings.Color)

        for _, weapon in ipairs(activeWeapons) do
            activeWeaponSet[weapon] = true

            local hl = ChammedHighlights[weapon]
            if not hl or hl.Parent ~= ScreenGui then
                hl = Instance.new("Highlight")
                hl.Name = "XCLIENT_WeaponHighlight"
                hl.Parent = ScreenGui
                ChammedHighlights[weapon] = hl
            end

            hl.Adornee = weapon
            hl.FillColor = brightColor
            hl.OutlineColor = WeaponChamsSettings.OutlineColor
            hl.DepthMode = WeaponChamsSettings.ThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded

            local isSolid = (WeaponChamsSettings.Style == "Сплошной (Без текстуры)")

            if isSolid then
                hl.FillTransparency = 0
                hl.OutlineTransparency = 0
                hl.Enabled = true
            elseif WeaponChamsSettings.Style == "Highlight" then
                hl.FillTransparency = WeaponChamsSettings.Transparency
                hl.OutlineTransparency = 0
                hl.Enabled = true
            else
                hl.FillTransparency = math.clamp(WeaponChamsSettings.Transparency * 0.7, 0, 0.75)
                hl.OutlineTransparency = 0
                hl.Enabled = true
            end

            for _, descendant in ipairs(weapon:GetDescendants()) do
                if descendant:IsA("BasePart") and not descendant.Name:match("XCLIENT") then
                    activePartSet[descendant] = true

                    if not ChammedParts[descendant] then
                        ChammedParts[descendant] = {
                            Color = descendant.Color,
                            Material = descendant.Material,
                            Transparency = descendant.Transparency,
                            Reflectance = descendant.Reflectance
                        }
                    end

                    local partLight = ChammedLights[descendant]
                    if not partLight or partLight.Parent ~= descendant then
                        partLight = Instance.new("PointLight")
                        partLight.Name = "XCLIENT_ChamsLight"
                        partLight.Range = 8
                        partLight.Shadows = false
                        partLight.Parent = descendant
                        ChammedLights[descendant] = partLight
                    end
                    partLight.Color = brightColor
                    partLight.Brightness = 2.5
                    partLight.Enabled = true

                    local style = WeaponChamsSettings.Style
                    local tr = WeaponChamsSettings.Transparency

                    if isSolid then
                        pcall(function()
                            descendant.Material = Enum.Material.Neon
                            descendant.Color = brightColor
                            descendant.Transparency = 0
                            descendant.Reflectance = 0

                            if descendant:IsA("MeshPart") then
                                if ChammedMeshPartTextures[descendant] == nil then
                                    ChammedMeshPartTextures[descendant] = descendant.TextureID
                                end
                                descendant.TextureID = ""
                            end

                            for _, child in ipairs(descendant:GetChildren()) do
                                if child:IsA("SpecialMesh") then
                                    if ChammedMeshTextures[child] == nil then
                                        ChammedMeshTextures[child] = child.TextureId
                                    end
                                    child.TextureId = ""
                                elseif child:IsA("Decal") or child:IsA("Texture") then
                                    if ChammedDecalTransparencies[child] == nil then
                                        ChammedDecalTransparencies[child] = child.Transparency
                                    end
                                    child.Transparency = 1
                                elseif child:IsA("SurfaceAppearance") then
                                    if ChammedSurfaceAppearances[child] == nil then
                                        ChammedSurfaceAppearances[child] = child.Parent
                                    end
                                    child.Parent = nil
                                end
                            end
                        end)
                    else
                        pcall(function()
                            if style == "Стекло" then
                                descendant.Material = Enum.Material.Glass
                                descendant.Color = brightColor
                                descendant.Transparency = math.clamp(tr, 0.1, 0.85)
                                descendant.Reflectance = 0.6
                            elseif style == "Неон" then
                                descendant.Material = Enum.Material.Neon
                                descendant.Color = brightColor
                                descendant.Transparency = tr
                                descendant.Reflectance = 0
                            elseif style == "Силовое поле" then
                                descendant.Material = Enum.Material.ForceField
                                descendant.Color = brightColor
                                descendant.Transparency = tr
                                descendant.Reflectance = 0
                            elseif style == "Глянец" then
                                descendant.Material = Enum.Material.SmoothPlastic
                                descendant.Color = brightColor
                                descendant.Transparency = tr
                                descendant.Reflectance = 0.9
                            end
                        end)
                    end
                end
            end
        end

        for weapon, hl in pairs(ChammedHighlights) do
            if not activeWeaponSet[weapon] or not weapon.Parent then
                if hl and hl.Parent then hl:Destroy() end
                ChammedHighlights[weapon] = nil
            end
        end

        for part, light in pairs(ChammedLights) do
            if not activePartSet[part] or not part.Parent then
                if light and light.Parent then light:Destroy() end
                ChammedLights[part] = nil
            end
        end

        for part, orig in pairs(ChammedParts) do
            if not activePartSet[part] or not part.Parent then
                pcall(function()
                    part.Color = orig.Color
                    part.Material = orig.Material
                    part.Transparency = orig.Transparency
                    part.Reflectance = orig.Reflectance
                end)
                ChammedParts[part] = nil
            end
        end
    end

    -- ==========================================
    -- РЕНДЕР ЦИКЛ И ЛОГИКА
    -- ==========================================
    local hue = 0
    local frames = 0
    local fps = 0
    
    task.spawn(function()
        while task.wait(1) do
            fps = frames
            frames = 0
        end
    end)

    RunService.RenderStepped:Connect(function(deltaTime)
        frames = frames + 1
        
        if FOVSettings.Enabled then
            Camera.FieldOfView = FOVSettings.Value
        end

        if PeakSettings.Enabled then
            local murderer = getMurderer()
            local myChar = LocalPlayer.Character
            local iHaveGun = hasGun()
            
            if murderer and myChar and myChar:FindFirstChild("HumanoidRootPart") and myChar:FindFirstChild("Humanoid") and myChar.Humanoid.Health > 0 and iHaveGun then
                if isBehindWall(murderer.Character) then
                    PeakMarker.Parent = workspace
                    
                    local floorParams = RaycastParams.new()
                    floorParams.FilterType = Enum.RaycastFilterType.Exclude
                    floorParams.FilterDescendantsInstances = {myChar, murderer.Character, ChinaHat, PeakMarker, TracersFolder}
                    
                    local floorRay = workspace:Raycast(myChar.HumanoidRootPart.Position, Vector3.new(0, -15, 0), floorParams)
                    if floorRay then
                        PeakMarker.CFrame = CFrame.new(floorRay.Position + Vector3.new(0, 0.05, 0)) * CFrame.Angles(0, 0, math.rad(90))
                    else
                        PeakMarker.CFrame = CFrame.new(myChar.HumanoidRootPart.Position - Vector3.new(0, 2.5, 0)) * CFrame.Angles(0, 0, math.rad(90))
                    end
                    
                    if checkPeekCondition(murderer.Character) then
                        PeakMarker.Color = PeakSettings.ColorSafe
                    else
                        PeakMarker.Color = PeakSettings.ColorUnsafe
                    end
                else
                    PeakMarker.Parent = nil
                end
            else
                PeakMarker.Parent = nil
            end
        end
        
        if HudSettings.Enabled then
            local ping = 0
            pcall(function()
                ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
            
            if HudSettings.RGB then
                hue = hue + (deltaTime * (HudSettings.RGBSpeed / 10))
                if hue > 1 then hue = 0 end
                
                local rgbColor = Color3.fromHSV(hue, 1, 1)
                HudStroke.Color = rgbColor
                
                local hexColor = string.format("#%02X%02X%02X", rgbColor.R * 255, rgbColor.G * 255, rgbColor.B * 255)
                HudText.Text = string.format('<b><font color="%s">xclient</font></b> <font color="#A0A0A0">|</font> geragori <font color="#A0A0A0">|</font> %d fps <font color="#A0A0A0">|</font> %d ms', hexColor, fps, ping)
            else
                HudText.Text = string.format('<b><font color="#8A2BE2">xclient</font></b> <font color="#A0A0A0">|</font> geragori <font color="#A0A0A0">|</font> %d fps <font color="#A0A0A0">|</font> %d ms', fps, ping)
            end
        end

        if HatSettings.Enabled then
            local Character = LocalPlayer.Character
            if Character and Character:FindFirstChild("Head") and Character:FindFirstChild("Humanoid") and Character.Humanoid.Health > 0 then
                ChinaHat.Parent = workspace
                ChinaHat.CFrame = Character.Head.CFrame * CFrame.new(0, 0.8, 0)
            else
                ChinaHat.Parent = nil
            end
        end
        
        if CrosshairSettings.Enabled then
            local Viewport = Camera.ViewportSize
            local CenterX = Viewport.X / 2
            local CenterY = Viewport.Y / 2
            
            local size = CrosshairSettings.Size
            local gap = CrosshairSettings.Gap
            local thick = CrosshairSettings.Thickness
            local color = CrosshairSettings.Color
            
            Lines[1].Size = UDim2.new(0, thick, 0, size)
            Lines[1].Position = UDim2.new(0, CenterX - thick / 2, 0, CenterY - gap - size)
            
            Lines[2].Size = UDim2.new(0, thick, 0, size)
            Lines[2].Position = UDim2.new(0, CenterX - thick / 2, 0, CenterY + gap)
            
            Lines[3].Size = UDim2.new(0, size, 0, thick)
            Lines[3].Position = UDim2.new(0, CenterX - gap - size, 0, CenterY - thick / 2)
            
            Lines[4].Size = UDim2.new(0, size, 0, thick)
            Lines[4].Position = UDim2.new(0, CenterX + gap, 0, CenterY - thick / 2)
            
            for _, line in ipairs(Lines) do
                line.BackgroundColor3 = color
            end
        end

        local currentMurderer = getMurderer()
        if currentMurderer then
            ExtraText.Text = "Murderer: " .. currentMurderer.Name
        else
            ExtraText.Text = "Murderer: Searching..."
        end

        local currentSheriff = getSheriff()
        if currentSheriff then
            ExtraText2.Text = "Sheriff: " .. currentSheriff.Name
        else
            ExtraText2.Text = "Sheriff: Searching..."
        end

        -- Кастомное оружие
        if not GunSettings.Enabled then
            if #GunParts > 0 or next(GunOriginalProperties) ~= nil then clearCustomGun() end
        else
            local gun = getLocalGun()
            local handle = gun and (gun:FindFirstChild("Handle") or gun:FindFirstChildWhichIsA("BasePart"))

            if not handle then
                if #GunParts > 0 then destroyGunParts() end
            else
                if GunSettings.HideOriginal then
                    for _, descendant in ipairs(gun:GetDescendants()) do
                        if descendant:IsA("BasePart") and not descendant.Name:match("XCLIENT") then
                            if GunOriginalProperties[descendant] == nil then
                                GunOriginalProperties[descendant] = {
                                    Transparency = descendant.Transparency,
                                    LocalTransparencyModifier = descendant.LocalTransparencyModifier
                                }
                            end
                            descendant.Transparency = 1
                            descendant.LocalTransparencyModifier = 1
                        elseif descendant:IsA("SpecialMesh") then
                            if GunOriginalMeshScale[descendant] == nil then
                                GunOriginalMeshScale[descendant] = descendant.Scale
                            end
                            descendant.Scale = Vector3.new(0, 0, 0)
                        end
                    end
                elseif next(GunOriginalProperties) ~= nil then
                    restoreGunVisibility()
                end

                if GunModelHandle ~= handle or GunModelStyle ~= GunSettings.Style then
                    destroyGunParts()
                    buildCustomGun(handle)
                    GunModelHandle = handle
                    GunModelStyle = GunSettings.Style
                    applyGunAppearance()
                end

                for _, part in ipairs(GunParts) do
                    if part and part.Parent then
                        part.LocalTransparencyModifier = 0
                    end
                end
            end
        end

        updateWeaponChams()
    end)

    -- ==========================================
    -- ЭЛЕМЕНТЫ UI
    -- ==========================================
    VisualTab:CreateToggle({
        Name = "Отображать HUD",
        CurrentValue = true,
        Flag = "VisualHUDToggle",
        Callback = function(Value)
            HudFrame.Visible = Value
            DragWindow.Visible = Value 
            HudSettings.Enabled = Value
        end
    })
    
    VisualTab:CreateToggle({
        Name = "Переливающийся HUD (RGB)",
        CurrentValue = true,
        Flag = "VisualHUDRGB",
        Callback = function(Value)
            HudSettings.RGB = Value
            if not Value then
                HudStroke.Color = Color3.fromRGB(138, 43, 226)
            end
        end
    })

    VisualTab:CreateToggle({
        Name = "China Hat (На себя)",
        CurrentValue = false,
        Flag = "ChinaHatToggle",
        Callback = function(Value)
            HatSettings.Enabled = Value
            if not Value then ChinaHat.Parent = nil end
        end
    })
    
    VisualTab:CreateColorPicker({
        Name = "Цвет China Hat",
        Color = Color3.fromRGB(60, 255, 150),
        Flag = "ChinaHatColor",
        Callback = function(Value)
            HatSettings.Color = Value
            ChinaHat.Color = Value
        end
    })

    VisualTab:CreateToggle({
        Name = "Кастомный прицел",
        CurrentValue = false,
        Flag = "CrosshairToggle",
        Callback = function(Value)
            CrosshairSettings.Enabled = Value
            for _, line in ipairs(Lines) do line.Visible = Value end
        end
    })
    
    VisualTab:CreateColorPicker({
        Name = "Цвет прицела",
        Color = Color3.fromRGB(0, 255, 0),
        Flag = "CrosshairColor",
        Callback = function(Value) CrosshairSettings.Color = Value end
    })

    VisualTab:CreateSlider({
        Name = "Размер прицела",
        Range = {2, 50},
        Increment = 1,
        CurrentValue = 10,
        Flag = "CrosshairSize",
        Callback = function(Value) CrosshairSettings.Size = Value end
    })

    VisualTab:CreateSlider({
        Name = "Зазор прицела (Gap)",
        Range = {0, 30},
        Increment = 1,
        CurrentValue = 5,
        Flag = "CrosshairGap",
        Callback = function(Value) CrosshairSettings.Gap = Value end
    })

    VisualTab:CreateSlider({
        Name = "Толщина прицела",
        Range = {1, 10},
        Increment = 1,
        CurrentValue = 2,
        Flag = "CrosshairThickness",
        Callback = function(Value) CrosshairSettings.Thickness = Value end
    })

    VisualTab:CreateToggle({
        Name = "Изменять угол обзора (FOV)",
        CurrentValue = false,
        Flag = "FOVToggle",
        Callback = function(Value)
            FOVSettings.Enabled = Value
            if not Value then 
                Camera.FieldOfView = 70
            end
        end
    })

    VisualTab:CreateSlider({
        Name = "Значение FOV",
        Range = {30, 120},
        Increment = 1,
        CurrentValue = 70,
        Flag = "FOVValue",
        Callback = function(Value)
            FOVSettings.Value = Value
        end
    })

    VisualTab:CreateToggle({
        Name = "Кинематографичные шейдеры",
        CurrentValue = false,
        Flag = "ShadersToggle",
        Callback = function(Value)
            if Value then
                ShadersFolder.Parent = Lighting
            end
        end
    })

    VisualTab:CreateSection("Custom World (Настройка мира)")

    VisualTab:CreateToggle({
        Name = "Кастомный мир (Custom World)",
        CurrentValue = false,
        Flag = "CustomWorldToggle",
        Callback = function(Value)
            CustomWorldSettings.Enabled = Value
            applyCustomWorld()
        end
    })

    VisualTab:CreateColorPicker({
        Name = "Цвет мира",
        Color = Color3.fromRGB(255, 255, 255),
        Flag = "CustomWorldColor",
        Callback = function(Value)
            CustomWorldSettings.Color = Value
            if CustomWorldSettings.Enabled then applyCustomWorld() end
        end
    })

    VisualTab:CreateSlider({
        Name = "Сила тона (Интенсивность)",
        Range = {0, 100},
        Increment = 1,
        CurrentValue = 50,
        Flag = "CustomWorldStrength",
        Callback = function(Value)
            CustomWorldSettings.Strength = Value / 100
            if CustomWorldSettings.Enabled then applyCustomWorld() end
        end
    })

    VisualTab:CreateSlider({
        Name = "Прозрачность стен",
        Range = {0, 100},
        Increment = 1,
        CurrentValue = 0,
        Flag = "CustomWorldTransparency",
        Callback = function(Value)
            CustomWorldSettings.Transparency = Value / 100
            if CustomWorldSettings.Enabled then applyCustomWorld() end
        end
    })

    VisualTab:CreateToggle({
        Name = "Включить туман",
        CurrentValue = false,
        Flag = "CustomWorldFogToggle",
        Callback = function(Value)
            CustomWorldSettings.FogEnabled = Value
            if CustomWorldSettings.Enabled then applyCustomWorld() end
        end
    })

    VisualTab:CreateSlider({
        Name = "Дальность тумана",
        Range = {100, 5000},
        Increment = 50,
        CurrentValue = 1000,
        Flag = "CustomWorldFogEnd",
        Callback = function(Value)
            CustomWorldSettings.FogEnd = Value
            if CustomWorldSettings.Enabled then applyCustomWorld() end
        end
    })

    VisualTab:CreateSection("Custom Atmosphere (Кастомная атмосфера)")

    VisualTab:CreateToggle({
        Name = "Включить атмосферу",
        CurrentValue = false,
        Flag = "AtmosphereToggle",
        Callback = function(Value)
            AtmosphereSettings.Enabled = Value
            applyCustomAtmosphere()
        end
    })

    VisualTab:CreateSlider({
        Name = "Плотность тумана (Density)",
        Range = {0, 100},
        Increment = 1,
        CurrentValue = 35,
        Flag = "AtmosphereDensity",
        Callback = function(Value)
            AtmosphereSettings.Density = Value / 100
            if AtmosphereSettings.Enabled then applyCustomAtmosphere() end
        end
    })

    VisualTab:CreateSlider({
        Name = "Интенсивность дымки (Haze)",
        Range = {0, 500},
        Increment = 5,
        CurrentValue = 20,
        Flag = "AtmosphereHaze",
        Callback = function(Value)
            AtmosphereSettings.Haze = Value / 10
            if AtmosphereSettings.Enabled then applyCustomAtmosphere() end
        end
    })

    VisualTab:CreateSlider({
        Name = "Влияние света на темноту",
        Range = {0, 100},
        Increment = 1,
        CurrentValue = 100,
        Flag = "AtmosphereLightInfluence",
        Callback = function(Value)
            AtmosphereSettings.LightInfluence = Value
            if AtmosphereSettings.Enabled then
                applyLightInfluence()
            end
        end
    })

    VisualTab:CreateToggle({
        Name = "Кинематографичная тьма (Dark World)",
        CurrentValue = true,
        Flag = "AtmosphereDarkToggle",
        Callback = function(Value)
            AtmosphereSettings.DarkLighting = Value
            if AtmosphereSettings.Enabled then applyCustomAtmosphere() end
        end
    })

    VisualTab:CreateSlider({
        Name = "Затемнение экспозиции (Exposure)",
        Range = {-100, 20},
        Increment = 1,
        CurrentValue = -12,
        Flag = "AtmosphereExposure",
        Callback = function(Value)
            AtmosphereSettings.Exposure = Value / 10
            if AtmosphereSettings.Enabled and AtmosphereSettings.DarkLighting then applyCustomAtmosphere() end
        end
    })

    VisualTab:CreateSection("Peak Assistant (Помощник пиков)")

    VisualTab:CreateToggle({
        Name = "Peak Assistant (Углы)",
        CurrentValue = false,
        Flag = "PeakAssistantToggle",
        Callback = function(Value)
            PeakSettings.Enabled = Value
            if not Value then PeakMarker.Parent = nil end
        end
    })

    VisualTab:CreateSection("Custom Gun (Кастомный пистолет)")

    VisualTab:CreateToggle({
        Name = "Кастомный пистолет (только у тебя)",
        CurrentValue = false,
        Flag = "CustomGunToggle",
        Callback = function(Value)
            GunSettings.Enabled = Value
            if not Value then
                clearCustomGun()
            else
                local gun = getLocalGun()
                local handle = gun and (gun:FindFirstChild("Handle") or gun:FindFirstChildWhichIsA("BasePart"))
                if handle then
                    destroyGunParts()
                    buildCustomGun(handle)
                    GunModelHandle = handle
                    GunModelStyle = GunSettings.Style
                    applyGunAppearance()
                end
            end
        end
    })

    VisualTab:CreateDropdown({
        Name = "Модель оружия",
        Options = {"Снайперка", "Пистолет", "Мини-ган", "Ванильный"},
        CurrentOption = "Снайперка",
        Flag = "CustomGunStyle",
        Callback = function(Value)
            if type(Value) == "table" then Value = Value[1] end
            if Value then
                GunSettings.Style = Value
                if GunSettings.Enabled and GunModelHandle then
                    destroyGunParts()
                    buildCustomGun(GunModelHandle)
                    GunModelStyle = GunSettings.Style
                    applyGunAppearance()
                end
            end
        end
    })

    VisualTab:CreateToggle({
        Name = "Скрыть оригинальный пистолет",
        CurrentValue = true,
        Flag = "CustomGunHideOriginal",
        Callback = function(Value)
            GunSettings.HideOriginal = Value
            if not Value then
                restoreGunVisibility()
            end
        end
    })

    VisualTab:CreateToggle({
        Name = "Партиклы (Muzzle Flash)",
        CurrentValue = true,
        Flag = "CustomGunParticles",
        Callback = function(Value)
            GunSettings.Particles = Value
            applyGunAppearance()
        end
    })

    VisualTab:CreateSlider({
        Name = "Размер оружия",
        Range = {0.5, 2.5},
        Increment = 0.1,
        CurrentValue = 1,
        Flag = "CustomGunScale",
        Callback = function(Value)
            GunSettings.Scale = Value
            if GunSettings.Enabled and GunModelHandle then
                destroyGunParts()
                buildCustomGun(GunModelHandle)
                applyGunAppearance()
            end
        end
    })

    VisualTab:CreateColorPicker({
        Name = "Цвет оружия",
        Color = Color3.fromRGB(138, 43, 226),
        Flag = "CustomGunColor",
        Callback = function(Value)
            GunSettings.Color = Value
            applyGunAppearance()
        end
    })

    VisualTab:CreateSection("Bullet Tracers (Трассеры пуль)")

    VisualTab:CreateToggle({
        Name = "Включить Bullet Tracers",
        CurrentValue = false,
        Flag = "BulletTracersToggle",
        Callback = function(Value)
            TracerSettings.Enabled = Value
            if not Value then
                for _, obj in ipairs(TracersFolder:GetChildren()) do
                    obj:Destroy()
                end
            end
        end
    })

    VisualTab:CreateToggle({
        Name = "Видимость сквозь стены (Wallhack)",
        CurrentValue = true,
        Flag = "BulletTracersThroughWalls",
        Callback = function(Value)
            TracerSettings.ThroughWalls = Value
        end
    })

    VisualTab:CreateToggle({
        Name = "Трассеры других игроков",
        CurrentValue = true,
        Flag = "BulletTracersOtherPlayers",
        Callback = function(Value)
            TracerSettings.OtherPlayers = Value
        end
    })

    VisualTab:CreateColorPicker({
        Name = "Цвет трассеров",
        Color = Color3.fromRGB(0, 170, 255),
        Flag = "BulletTracersColor",
        Callback = function(Value)
            TracerSettings.Color = Value
        end
    })

    VisualTab:CreateSlider({
        Name = "Длительность (сек)",
        Range = {1, 10},
        Increment = 1,
        CurrentValue = 2,
        Flag = "BulletTracersDuration",
        Callback = function(Value)
            TracerSettings.Duration = Value
        end
    })

    VisualTab:CreateSlider({
        Name = "Толщина луча",
        Range = {1, 10},
        Increment = 1,
        CurrentValue = 2,
        Flag = "BulletTracersThickness",
        Callback = function(Value)
            TracerSettings.Thickness = Value / 10
        end
    })

    VisualTab:CreateSection("Weapon Chams (Чамсы оружия)")

    VisualTab:CreateToggle({
        Name = "Включить Weapon Chams",
        CurrentValue = false,
        Flag = "WeaponChamsToggle",
        Callback = function(Value)
            WeaponChamsSettings.Enabled = Value
            if not Value then restoreWeaponChams() end
        end
    })

    VisualTab:CreateToggle({
        Name = "Чамсы на Нож",
        CurrentValue = true,
        Flag = "WeaponChamsKnife",
        Callback = function(Value)
            WeaponChamsSettings.TargetKnife = Value
            if not Value then restoreWeaponChams() end
        end
    })

    VisualTab:CreateToggle({
        Name = "Чамсы на Пистолет",
        CurrentValue = true,
        Flag = "WeaponChamsGun",
        Callback = function(Value)
            WeaponChamsSettings.TargetGun = Value
            if not Value then restoreWeaponChams() end
        end
    })

    VisualTab:CreateToggle({
        Name = "Видимость сквозь стены (Wallhack)",
        CurrentValue = true,
        Flag = "WeaponChamsThroughWalls",
        Callback = function(Value)
            WeaponChamsSettings.ThroughWalls = Value
        end
    })

    VisualTab:CreateDropdown({
        Name = "Вид / Материал чамсов",
        Options = {"Сплошной (Без текстуры)", "Стекло", "Неон", "Силовое поле", "Глянец", "Highlight"},
        CurrentOption = "Сплошной (Без текстуры)",
        Flag = "WeaponChamsStyle",
        Callback = function(Value)
            if type(Value) == "table" then Value = Value[1] end
            if Value then
                restoreWeaponChams()
                WeaponChamsSettings.Style = Value
            end
        end
    })

    VisualTab:CreateDropdown({
        Name = "Применять к",
        Options = {"Все (Я и другие)", "Только нож/оружие других", "Только моё"},
        CurrentOption = "Все (Я и другие)",
        Flag = "WeaponChamsScope",
        Callback = function(Value)
            if type(Value) == "table" then Value = Value[1] end
            if Value then
                restoreWeaponChams()
                WeaponChamsSettings.TargetScope = Value
            end
        end
    })

    VisualTab:CreateColorPicker({
        Name = "Цвет чамсов оружия",
        Color = Color3.fromRGB(255, 45, 110),
        Flag = "WeaponChamsColor",
        Callback = function(Value)
            WeaponChamsSettings.Color = Value
        end
    })

    VisualTab:CreateColorPicker({
        Name = "Цвет контура сквозь стены",
        Color = Color3.fromRGB(255, 255, 255),
        Flag = "WeaponChamsOutlineColor",
        Callback = function(Value)
            WeaponChamsSettings.OutlineColor = Value
        end
    })

    VisualTab:CreateSlider({
        Name = "Прозрачность чамсов",
        Range = {0, 100},
        Increment = 5,
        CurrentValue = 20,
        Flag = "WeaponChamsTransparency",
        Callback = function(Value)
            WeaponChamsSettings.Transparency = Value / 100
        end
    })
end

return function(Window)

    local VisualTab = Window:CreateTab("Visual", 4483362458)

    

    local CoreGui = game:GetService("CoreGui")

    local Players = game:GetService("Players")

    local RunService = game:GetService("RunService")

    local Stats = game:GetService("Stats")

    local Lighting = game:GetService("Lighting")

    local UserInputService = game:GetService("UserInputService")

    local LocalPlayer = Players.LocalPlayer

    local Camera = workspace.CurrentCamera

    

    -- ==========================================

    -- HUD (XCLIENT)

    -- ==========================================

    local ScreenGui = Instance.new("ScreenGui")

    ScreenGui.Name = "XCLIENT_HUD"

    ScreenGui.IgnoreGuiInset = true

    ScreenGui.ResetOnSpawn = false

    

    -- Защита GUI

    local success = pcall(function() ScreenGui.Parent = CoreGui end)

    if not success then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    

    -- Главный фрейм подложки (авто-расширение под текст)

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

    

    -- Обводка HUD

    local HudStroke = Instance.new("UIStroke")

    HudStroke.Color = Color3.fromRGB(138, 43, 226)

    HudStroke.Thickness = 1.2

    HudStroke.Parent = HudFrame

    

    -- Текст

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


    -- ==========================================

    -- СТАРТОВЫЕ ЗНАЧЕНИЯ ДЛЯ ТЕКСТА ОКОН

    -- ==========================================

    local murdererName = "Searching..."

    local sheriffName = "Searching..."


    -- ==========================================

    -- НОВОЕ СЕРОЕ ПЕРЕТАСКИВАЕМОЕ ОКНО (WATERMARK)

    -- ==========================================

    local DragWindow = Instance.new("Frame")

    DragWindow.Name = "XCLIENTWaterMark"

    DragWindow.Parent = ScreenGui

    DragWindow.Position = UDim2.new(0.1, 0, 0.2, 0)

    DragWindow.Size = UDim2.new(0, 250, 0, 105) 

    DragWindow.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    DragWindow.BorderSizePixel = 0

    DragWindow.Visible = true


    -- Скругление углов серого окна

    local WindowCorner = Instance.new("UICorner")

    WindowCorner.CornerRadius = UDim.new(0, 8)

    WindowCorner.Parent = DragWindow


    -- Обводка для красоты

    local WindowStroke = Instance.new("UIStroke")

    WindowStroke.Color = Color3.fromRGB(70, 70, 70)

    WindowStroke.Thickness = 1

    WindowStroke.Parent = DragWindow


    -- 1. ЗАГОЛОВОК ВНУТРИ ОКНА

    local WindowTitle = Instance.new("TextLabel")

    WindowTitle.Name = "Title"

    WindowTitle.Parent = DragWindow

    WindowTitle.Size = UDim2.new(1, 0, 0, 30)

    WindowTitle.BackgroundTransparency = 1

    WindowTitle.Font = Enum.Font.GothamBold

    WindowTitle.Text = "XClient Info"

    WindowTitle.TextColor3 = Color3.fromRGB(200, 200, 200)

    WindowTitle.TextSize = 12


    -- 2. НАДПИСЬ МАРДЕРА

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


    -- 3. НАДПИСЬ ШЕРИФА

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


    -- 4. ИКОНКА (ЛОГОТИП ИЗ ГИТХАБА)

    local LogoImage = Instance.new("ImageLabel")

    LogoImage.Name = "LogoIcon"

    LogoImage.Parent = DragWindow

    LogoImage.AnchorPoint = Vector2.new(0, 1)

    LogoImage.Position = UDim2.new(0, 12, 1, -8) -- Выравнивание по нижнему краю (отступ 8px)

    LogoImage.Size = UDim2.new(0, 16, 0, 16)     -- Квадратный аккуратный логотип

    LogoImage.BackgroundTransparency = 1

    LogoImage.Image = "" -- Изначально пустой, загрузится асинхронно

    

    _G.XClientWatermarkLogo = LogoImage -- Экспорт логотипа в глобальную среду


    -- Асинхронный поток для скачивания и установки картинки

    task.spawn(function()

        -- СЮДА ВСТАВЬ СВОЮ RAW ССЫЛКУ НА КАРТИНКУ С ГИТХАБА:

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

            -- Если запущено в Roblox Studio без функций читов, подгрузит стандартную заглушку

            LogoImage.Image = "rbxassetid://0"

        end

    end)


    -- 5. НАДПИСЬ ПОД ЛОАДСТРИНГ (Смещена вправо с учетом иконки)

    local ExtraText3 = Instance.new("TextLabel")

    ExtraText3.Name = "GameText"

    ExtraText3.Parent = DragWindow 

    ExtraText3.AnchorPoint = Vector2.new(0, 1) 

    ExtraText3.Position = UDim2.new(0, 34, 1, -8) -- 12px (край) + 16px (лого) + 6px (отступ между ними) = 34px

    ExtraText3.Size = UDim2.new(1, -46, 0, 16) 

    ExtraText3.BackgroundTransparency = 1

    ExtraText3.Font = Enum.Font.Gotham

    ExtraText3.TextXAlignment = Enum.TextXAlignment.Left

    ExtraText3.Text = "Murder Mystery 2" 

    ExtraText3.TextColor3 = Color3.fromRGB(220, 220, 220) 

    ExtraText3.TextSize = 9

    

    _G.XClientWatermarkLabel = ExtraText3


    -- Логика перетаскивания (Roblox-style)

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

    

    local HudSettings = {

        Enabled = true,

        RGB = true,

        RGBSpeed = 3

    }

    

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

    -- ==========================================

    -- CHINA HAT (Шляпа на себя)

    -- ==========================================

    local HatSettings = {

        Enabled = false,

        Color = Color3.fromRGB(60, 255, 150)

    }

    

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


    -- ==========================================

    -- КАСТОМНЫЙ ПРИЦЕЛ (Crosshair)

    -- ==========================================

    local CrosshairSettings = {

        Enabled = false,

        Color = Color3.fromRGB(0, 255, 0),

        Size = 10,

        Gap = 5,

        Thickness = 2

    }

    

    local CrosshairFolder = Instance.new("Folder", ScreenGui)

    CrosshairFolder.Name = "Crosshair"

    

    local Lines = {}

    for i = 1, 4 do

        local Line = Instance.new("Frame", CrosshairFolder)

        Line.BorderSizePixel = 0

        Line.Visible = false

        table.insert(Lines, Line)

    end


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


    -- ==========================================

    -- НАСТРОЙКА FOV (Угол обзора)

    -- ==========================================

    local FOVSettings = {

        Enabled = false,

        Value = 70

    }


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


    -- ==========================================

    -- ШЕЙДЕРЫ И КРАСИВАЯ ГРАФИКА

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


    -- ==========================================

    -- CUSTOM WORLD (Настройка мира)

    -- ==========================================

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


    -- Сохраняем исходные настройки освещения карты

    local OriginalLighting = {

        Ambient = Lighting.Ambient,

        OutdoorAmbient = Lighting.OutdoorAmbient,

        FogColor = Lighting.FogColor,

        FogEnd = Lighting.FogEnd,

        FogStart = Lighting.FogStart

    }


    local function applyCustomWorld()

        if not CustomWorldSettings.Enabled then

            -- Восстанавливаем оригинальные цвета и прозрачность деталей

            for part, original in pairs(CustomWorldSettings.OriginalColors) do

                if part and part.Parent then

                    pcall(function() 

                        part.Color = original 

                    end)

                end

            end

            for part, original in pairs(CustomWorldSettings.OriginalTransparencies) do

                if part and part.Parent then

                    pcall(function() 

                        part.Transparency = original 

                    end)

                end

            end

            table.clear(CustomWorldSettings.OriginalColors)

            table.clear(CustomWorldSettings.OriginalTransparencies)

            

            -- Восстанавливаем освещение

            Lighting.Ambient = OriginalLighting.Ambient

            Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient

            Lighting.FogColor = OriginalLighting.FogColor

            Lighting.FogEnd = OriginalLighting.FogEnd

            Lighting.FogStart = OriginalLighting.FogStart

            return

        end


        -- Применяем изменения к существующим деталям в workspace

        for _, part in ipairs(workspace:GetDescendants()) do

            if part:IsA("BasePart") and not part:IsDescendantOf(LocalPlayer.Character) and not part.Name:match("XCLIENT") then

                local isWall = string.lower(part.Name):match("wall") or string.lower(part.Name):match("стена")

                

                -- Запоминаем дефолтные параметры, если они еще не сохранены

                if not CustomWorldSettings.OriginalColors[part] then

                    CustomWorldSettings.OriginalColors[part] = part.Color

                end

                if not CustomWorldSettings.OriginalTransparencies[part] then

                    CustomWorldSettings.OriginalTransparencies[part] = part.Transparency

                end


                local baseColor = CustomWorldSettings.OriginalColors[part]

                if isWall then

                    -- Стены перекрашиваются сильнее и к ним применяется прозрачность

                    pcall(function()

                        part.Color = baseColor:Lerp(CustomWorldSettings.Color, CustomWorldSettings.Strength)

                        part.Transparency = CustomWorldSettings.Transparency

                    end)

                else

                    -- Остальные детали красятся чуть мягче, чтобы мир не сливался в кашу

                    pcall(function()

                        part.Color = baseColor:Lerp(CustomWorldSettings.Color, CustomWorldSettings.Strength * 0.4)

                    end)

                end

            end

        end


        -- Настраиваем глобальное освещение под выбранный цвет тона

        Lighting.Ambient = CustomWorldSettings.Color:Lerp(Color3.fromRGB(0, 0, 0), 0.4)

        Lighting.OutdoorAmbient = CustomWorldSettings.Color:Lerp(Color3.fromRGB(0, 0, 0), 0.2)

        

        -- Логика тумана

        if CustomWorldSettings.FogEnabled then

            Lighting.FogColor = CustomWorldSettings.Color

            Lighting.FogEnd = CustomWorldSettings.FogEnd

            Lighting.FogStart = 0

        else

            Lighting.FogEnd = 100000 -- Виртуально отключаем туман

        end

    end


    -- Автоматическое окрашивание новых деталей, которые спавнятся по ходу игры

    workspace.DescendantAdded:Connect(function(part)

        if CustomWorldSettings.Enabled then

            task.wait(0.1) -- Небольшая задержка, чтобы свойства детали успели прогрузиться

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


    -- ЭЛЕМЕНТЫ UI ДЛЯ НАСТРОЙКИ CUSTOM WORLD

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


    -- ==========================================

    -- PEAK ASSISTANT (Помощник пиков)

    -- ==========================================

    local PeakSettings = {

        Enabled = false,

        ColorSafe = Color3.fromRGB(0, 255, 100),   

        ColorUnsafe = Color3.fromRGB(255, 30, 30)  

    }


    local PeakMarker = Instance.new("Part")

    PeakMarker.Name = "XCLIENT_PeakMarker"

    PeakMarker.Anchored = true

    PeakMarker.CanCollide = false

    PeakMarker.Shape = Enum.PartType.Cylinder

    PeakMarker.Size = Vector3.new(0.05, 5, 5)

    PeakMarker.Material = Enum.Material.Neon

    PeakMarker.Transparency = 0.5


    VisualTab:CreateToggle({

        Name = "Peak Assistant (Углы)",

        CurrentValue = false,

        Flag = "PeakAssistantToggle",

        Callback = function(Value)

            PeakSettings.Enabled = Value

            if not Value then PeakMarker.Parent = nil end

        end

    })


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


    local function isBehindWall(targetChar)

        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return false end

        if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then return false end

        

        local origin = LocalPlayer.Character.HumanoidRootPart.Position

        local targetPos = targetChar.HumanoidRootPart.Position

        local direction = targetPos - origin

        

        local raycastParams = RaycastParams.new()

        raycastParams.FilterType = Enum.RaycastFilterType.Exclude

        raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, targetChar, ChinaHat, PeakMarker}

        

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

                    floorParams.FilterDescendantsInstances = {myChar, murderer.Character, ChinaHat, PeakMarker}

                    

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


        -- ==========================================

        -- ОБНОВЛЕНИЕ ДАННЫХ В ОКНЕ

        -- ==========================================

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

    end)


    -- ==========================================

    -- CUSTOM GUN (Клиентский кастомный пистолет)

    -- ==========================================

    local GunSettings = {

        Enabled = false,

        Style = "Снайперка",

        Color = Color3.fromRGB(138, 43, 226),

        Particles = true,

        Scale = 1,

        HideOriginal = true

    }



    local GunModelHandle = nil

    local GunModelStyle = nil

    local GunParts = {}

    local GunOriginalTransparency = {}

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

        for handle, trans in pairs(GunOriginalTransparency) do

            if handle and handle.Parent then

                pcall(function() handle.Transparency = trans end)

            end

        end

        table.clear(GunOriginalTransparency)

    end



    local function clearCustomGun()

        destroyGunParts()

        restoreGunVisibility()

    end



    local function addGunPart(handle, name, size, offsetCFrame, shape, material)

        local part = Instance.new("Part")

        part.Name = "XCLIENT_" .. name

        part.Size = size

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

        part.CFrame = handle.CFrame * offsetCFrame

        part.Parent = handle

        local weld = Instance.new("WeldConstraint")

        weld.Part0 = handle

        weld.Part1 = part

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



    VisualTab:CreateSection("Custom Gun (Кастомный пистолет)")



    VisualTab:CreateToggle({

        Name = "Кастомный пистолет (только у тебя)",

        CurrentValue = false,

        Flag = "CustomGunToggle",

        Callback = function(Value)

            GunSettings.Enabled = Value

            if not Value then clearCustomGun() end

        end

    })



    VisualTab:CreateDropdown({

        Name = "Модель оружия",

        Options = {"Снайперка", "Пистолет", "Мини-ган", "Ванильный"},

        CurrentOption = "Снайперка",

        Flag = "CustomGunStyle",

        Callback = function(Value)

            if type(Value) == "table" then Value = Value[1] end

            if Value then GunSettings.Style = Value end

        end

    })



    VisualTab:CreateToggle({

        Name = "Скрыть оригинальный пистолет",

        CurrentValue = true,

        Flag = "CustomGunHideOriginal",

        Callback = function(Value) GunSettings.HideOriginal = Value end

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

            applyGunAppearance()

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



    -- Локальный всплеск партиклов при выстреле (ЛКМ)

    UserInputService.InputBegan:Connect(function(input, processed)

        if processed then return end

        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

        if not GunSettings.Enabled or not GunMuzzle then return end

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

    end)



    -- Цикл обслуживания кастомного оружия (полностью клиентский)

    RunService.RenderStepped:Connect(function()

        if not GunSettings.Enabled then

            if #GunParts > 0 or next(GunOriginalTransparency) ~= nil then clearCustomGun() end

            return

        end



        local character = LocalPlayer.Character

        local gun = character and (character:FindFirstChild("Gun") or character:FindFirstChild("Revolver"))

        local handle = gun and gun:FindFirstChild("Handle")



        if not handle then

            if #GunParts > 0 then destroyGunParts() end

            return

        end



        -- Скрываем/возвращаем оригинальный пистолет

        if GunSettings.HideOriginal then

            if GunOriginalTransparency[handle] == nil then

                GunOriginalTransparency[handle] = handle.Transparency

            end

            if handle.Transparency ~= 1 then handle.Transparency = 1 end

        elseif GunOriginalTransparency[handle] ~= nil then

            handle.Transparency = GunOriginalTransparency[handle]

            GunOriginalTransparency[handle] = nil

        end



        -- Пересобираем модель при смене инструмента или стиля

        if GunModelHandle ~= handle or GunModelStyle ~= GunSettings.Style then

            destroyGunParts()

            buildCustomGun(handle)

            GunModelHandle = handle

            GunModelStyle = GunSettings.Style

            applyGunAppearance()

        end

    end)

end

return function(Window)
    local VisualTab = Window:CreateTab("Visual", 4483362458)
    
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    -- Создание HUD
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "XCLIENT_HUD"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    
    -- Защита GUI (CoreGui)
    local success = pcall(function()
        ScreenGui.Parent = CoreGui
    end)
    if not success then
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    
    local Watermark = Instance.new("TextLabel")
    Watermark.Name = "WatermarkText"
    Watermark.Parent = ScreenGui
    Watermark.BackgroundTransparency = 1
    Watermark.Position = UDim2.new(0, 15, 0, 15)
    Watermark.Size = UDim2.new(0, 200, 0, 30)
    Watermark.Font = Enum.Font.GothamBold
    Watermark.Text = "XCLIENT"
    Watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
    Watermark.TextSize = 24
    Watermark.TextXAlignment = Enum.TextXAlignment.Left
    Watermark.TextStrokeTransparency = 0.5
    Watermark.Visible = true 
    
    VisualTab:CreateToggle({
        Name = "Отображать HUD (XCLIENT)",
        CurrentValue = true,
        Flag = "VisualHUDToggle",
        Callback = function(Value)
            Watermark.Visible = Value
        end
    })
end
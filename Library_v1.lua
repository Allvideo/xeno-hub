local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("MarkBeatsIsGay") then
    CoreGui.MarkBeatsIsGay:Destroy()
end

local Library = {RainbowColor = Color3.new(1,0,0)}
local UserInput = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")
local Run = game:GetService("RunService")

Run.Heartbeat:Connect(function()
    Library.RainbowColor = Color3.fromHSV(tick() % 5 / 5,1,1)
end)

local function MakeDraggable(TopBar,Object) 
    local Dragging = false
    local DragInput,MousePosition,FramePosition
    
    TopBar.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            MousePosition = Input.Position
            FramePosition = Object.Position
            
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)
    
    TopBar.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            DragInput = Input
        end
    end)
    
    UserInput.InputChanged:Connect(function(Input)
        if Input == DragInput and Dragging and Object.Parent.Enabled then
            local Delta = Input.Position - MousePosition
            
            Object.Position = FramePosition + UDim2.new(0,Delta.X,0,Delta.Y)
        end
    end)
end

local function Ripple(Object)
    task.spawn(function()
        local MouseLocation = UserInput:GetMouseLocation() - Vector2.new(0,36)
        local Circle = Instance.new("ImageLabel",Object)
        
        Circle.BackgroundTransparency = 1
        Circle.Name = "Circle"
        Circle.Position = UDim2.new(0,MouseLocation.X - Circle.AbsolutePosition.X,0,MouseLocation.Y - Circle.AbsolutePosition.Y)
        Circle.ZIndex = 10
        Circle.Image = "rbxassetid://266543268"
        Circle.ImageColor3 = Color3.fromRGB(211,211,211)
        Circle.ImageTransparency = 0.6
        
        local Size = math.max(Object.AbsoluteSize.X,Object.AbsoluteSize.Y)
        
        Circle:TweenSizeAndPosition(UDim2.new(0,Size,0,Size),UDim2.new(0.5,-Size / 2,0.5,-Size / 2),"Out","Quad",0.2)
        
        Tween:Create(Circle,TweenInfo.new(0.25,Enum.EasingStyle.Linear),{ImageTransparency = 1}):Play()
        
        task.wait(0.25)
        
        Circle:Destroy()
    end)
end

local Gui = Instance.new("ScreenGui")

Gui.DisplayOrder = 1
Gui.Name = "MarkBeatsIsGay"
Gui.ZIndexBehavior = "Sibling"

if syn and syn.protect_gui then
    syn.protect_gui(Gui)
end

Gui.Parent = gethui and gethui() or CoreGui

UserInput.InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.RightControl then
        Gui.Enabled = not Gui.Enabled
        
        if Gui:FindFirstChild("MainFrame") then
            for i,v in next,Gui.MainFrame.Containers:GetChildren() do
                for i2,v2 in next,v.ItemHolder:GetChildren() do
                    if v2.Name == "Button" or v2.Name == "Toggle" or v2.Name == "Dropdown" or v2.Name == "Colorpicker" or v2.Name == "Bind" then
                        v2.BackgroundColor3 = Color3.fromRGB(39,39,39)
                    elseif v2.Name == "DropdownFrame" then
                        for i3,v3 in next,v2.DropItemHolder:GetChildren() do
                            if v3:IsA("TextButton") then
                                v3.BackgroundColor3 = Color3.fromRGB(39,39,39)
                            end
                        end
                    end
                end
            end
        end
    end
end)

function Library:Window(Text)
    local FirstTab = false
    local MainFrame = Instance.new("Frame",Gui)
    local MainFrameCorner = Instance.new("UICorner",MainFrame)
    local TopBar = Instance.new("Frame",MainFrame)
    local Title = Instance.new("TextLabel",TopBar)
    local Containers = Instance.new("Folder",MainFrame)
    local TabHolderFrame = Instance.new("Frame",MainFrame)
    local TabHolderFrameCorner = Instance.new("UICorner",TabHolderFrame)
    local TabHolder = Instance.new("Frame",TabHolderFrame)
    local TabHolderList = Instance.new("UIListLayout",TabHolder)
    local TabHolderPadding = Instance.new("UIPadding",TabHolder)
    
    MainFrame.AnchorPoint = Vector2.new(0.5,0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(29,29,29)
    MainFrame.Name = "MainFrame"
    MainFrame.Position = UDim2.new(0.5,0,0.5,0)
    MainFrame.Size = UDim2.new(0,547,0,341)
    
    MainFrameCorner.CornerRadius = UDim.new(0,11)
    MainFrameCorner.Name = "MainFrameCorner"
    
    TopBar.BackgroundTransparency = 1
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1,0,0,59)
    
    Title.BackgroundTransparency = 1
    Title.Name = "Title"
    Title.Size = UDim2.new(1,0,1,0)
    Title.Font = "Gotham"
    Title.Text = Text
    Title.TextColor3 = Color3.fromRGB(168,168,168)
    Title.TextSize = 20
    
    Containers.Name = "Containers"
    
    TabHolderFrame.BackgroundColor3 = Color3.fromRGB(33,33,33)
    TabHolderFrame.Name = "TabHolderFrame"
    TabHolderFrame.Position = UDim2.new(0,14,0,59)
    TabHolderFrame.Size = UDim2.new(1,-28,0,31)
    
    TabHolderFrameCorner.CornerRadius = UDim.new(0,11)
    TabHolderFrameCorner.Name = "TabHolderFrameCorner"
    
    TabHolder.BackgroundTransparency = 1
    TabHolder.Name = "TabHolder"
    TabHolder.Size = UDim2.new(1,0,1,0)
    
    TabHolderList.Name = "TabHolderList"
    TabHolderList.FillDirection = "Horizontal"
    TabHolderList.SortOrder = "LayoutOrder"
    
    TabHolderPadding.Name = "TabHolderPadding"
    TabHolderPadding.PaddingLeft = UDim.new(0,4)
    TabHolderPadding.PaddingTop = UDim.new(0,4)
    
    MakeDraggable(TopBar,MainFrame)
    
    local Window = {}
    
    function Window:Tab(Text)
        local Tab = Instance.new("TextButton",TabHolder)
        local Container = Instance.new("Frame",Containers)
        local ContainerCorner = Instance.new("UICorner",Container)
        local ItemHolder = Instance.new("ScrollingFrame",Container)
        local ItemHolderList = Instance.new("UIListLayout",ItemHolder)
        local Glow = Instance.new("ImageLabel",Container)
        
        Tab.BackgroundTransparency = 1
        Tab.Name = Text.."Tab"
        Tab.Font = "Gotham"
        Tab.Text = Text
        Tab.TextColor3 = Color3.fromRGB(195,195,195)
        Tab.TextSize = 14
        Tab.TextTransparency = 0.5
        Tab.Size = UDim2.new(0,Tab.TextBounds.X + 10,0,24)
        
        Container.BackgroundColor3 = Color3.fromRGB(33,33,33)
        Container.Name = "Container"
        Container.Position = UDim2.new(0,14,0,98)
        Container.Size = UDim2.new(1,-28,0,227)
        Container.Visible = false
        
        ContainerCorner.CornerRadius = UDim.new(0,11)
        ContainerCorner.Name = "ContainerCorner"
        
        ItemHolder.Active = true
        ItemHolder.BackgroundTransparency = 1
        ItemHolder.BorderSizePixel = 0
        ItemHolder.Name = "ItemHolder"
        ItemHolder.Position = UDim2.new(0,14,0,14)
        ItemHolder.Size = UDim2.new(1,-20,1,-27)
        ItemHolder.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
        ItemHolder.CanvasSize = UDim2.new()
        ItemHolder.ScrollBarThickness = 2
        ItemHolder.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
        
        ItemHolderList.Padding = UDim.new(0,3)
        ItemHolderList.Name = "ItemHolderList"
        ItemHolderList.SortOrder = "LayoutOrder"
        
        Glow.BackgroundTransparency = 1
        Glow.Name = "Glow"
        Glow.Position = UDim2.new(0,-15,0,-15)
        Glow.Size = UDim2.new(1,30,1,30)
        Glow.ZIndex = 0
        Glow.Image = "rbxassetid://4996891970"
        Glow.ImageColor3 = Color3.fromRGB(15,15,15)
        Glow.ScaleType = "Slice"
        Glow.SliceCenter = Rect.new(20,20,280,280)
        
        if not FirstTab then
            FirstTab = true
            Container.Visible = true
            Tab.TextTransparency = 0
        end
        
        Tab.MouseButton1Click:Connect(function()
            for i,v in next,Containers:GetChildren() do
                if v.Name == "Container" then
                    v.Visible = false
                end
            end
            
            for i,v in next,TabHolder:GetChildren() do
                if v:IsA("TextButton") then
                    Tween:Create(v,TweenInfo.new(0.3),{TextTransparency = 0.5}):Play()
                end
            end
            
            Tween:Create(Tab,TweenInfo.new(0.3),{TextTransparency = 0}):Play()
            
            Container.Visible = true
        end)
        
        local TabContainer = {}
        
        function TabContainer:Button(Text,Callback)
            local Object = {}
            
            local Button = Instance.new("TextButton",ItemHolder)
            local ButtonCorner = Instance.new("UICorner",Button)
            
            Button.AutoButtonColor = false
            Button.BackgroundColor3 = Color3.fromRGB(39,39,39)
            Button.Name = "Button"
            Button.Size = UDim2.new(1,-8,0,29)
            Button.ClipsDescendants = true
            Button.Font = "Gotham"
            Button.TextColor3 = Color3.fromRGB(195,195,195)
            Button.TextSize = 14
            Button.Text = Text
            
            ButtonCorner.CornerRadius = UDim.new(0,6)
            ButtonCorner.Name = "ButtonCorner"
            
            Button.MouseEnter:Connect(function()
                Tween:Create(Button,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(44,44,44)}):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                Tween:Create(Button,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(39,39,39)}):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                Ripple(Button)
                
                task.spawn(function()
                    pcall(Callback)
                end)
                
                Tween:Create(Button,TweenInfo.new(0.4),{TextSize = 0}):Play()
                task.wait(0.1)
                Tween:Create(Button,TweenInfo.new(0.1),{TextSize = 14}):Play()
            end)
            
            ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
            
            function Object:Update(NewText,NewCallback)
                Button.Text = NewText
                
                if NewCallback then
                    Callback = NewCallback
                end
            end
            
            return Object
        end
        
        function TabContainer:Toggle(Text,Callback,Toggled)
            local Object = {}
            
            local Toggled = Toggled or false
            local Toggle = Instance.new("TextButton",ItemHolder)
            local ToggleCorner = Instance.new("UICorner",Toggle)
            local Title = Instance.new("TextLabel",Toggle)
            local Status = Instance.new("Frame",Toggle)
            local StatusCorner = Instance.new("UICorner",Status)
            
            Toggle.AutoButtonColor = false
            Toggle.BackgroundColor3 = Color3.fromRGB(39,39,39)
            Toggle.Name = "Toggle"
            Toggle.Size = UDim2.new(1,-8,0,29)
            Toggle.ClipsDescendants = true
            Toggle.Text = ""
            
            ToggleCorner.CornerRadius = UDim.new(0,6)
            ToggleCorner.Name = "ToggleCorner"
            
            Title.BackgroundTransparency = 1
            Title.Name = "Title"
            Title.Position = UDim2.new(0,12,0,3)
            Title.Size = UDim2.new(0,0,0,24)
            Title.Font = "Gotham"
            Title.Text = Text
            Title.TextColor3 = Color3.fromRGB(195,195,195)
            Title.TextSize = 14
            Title.TextXAlignment = "Left"
            
            Status.BackgroundColor3 = Toggled and Color3.fromRGB(44,255,58) or Color3.fromRGB(255,39,42)
            Status.Name = "Status"
            Status.Position = UDim2.new(1,-26,0,5)
            Status.Size = UDim2.new(0,19,0,19)
            
            StatusCorner.CornerRadius = UDim.new(0,6)
            StatusCorner.Name = "StatusCorner"
            
            if Toggled then
                task.spawn(function()
                    pcall(Callback,true)
                end)
            end
            
            Toggle.MouseEnter:Connect(function()
                Tween:Create(Toggle,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(44,44,44)}):Play()
            end)
            
            Toggle.MouseLeave:Connect(function()
                Tween:Create(Toggle,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(39,39,39)}):Play()
            end)
            
            Toggle.MouseButton1Click:Connect(function()
                Ripple(Toggle)
                
                Toggled = not Toggled
                Tween:Create(Status,TweenInfo.new(0.3),{BackgroundColor3 = Toggled and Color3.fromRGB(44,255,58) or Color3.fromRGB(255,39,42)}):Play()
                
                pcall(Callback,Toggled)
            end)
            
            ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
            
            function Object:Update(NewText,NewCallback,NewToggled)
                Title.Text = NewText
                
                if NewCallback then
                    Callback = NewCallback
                end
                
                Toggled = NewToggled
                Tween:Create(Status,TweenInfo.new(0.3),{BackgroundColor3 = Toggled and Color3.fromRGB(44,255,58) or Color3.fromRGB(255,39,42)}):Play()
                
                pcall(Callback,Toggled)
            end
            
            return Object
        end
        
        function TabContainer:Slider(Text,Min,Max,Callback,Default,Increment)
            local Object = {}
            
            local Dragging = false
            local Slider = Instance.new("Frame",ItemHolder)
            local SliderCorner = Instance.new("UICorner",Slider)
            local Title = Instance.new("TextLabel",Slider)
            local SlideFrame = Instance.new("Frame",Slider)
            local SlideCorner = Instance.new("UICorner",SlideFrame)
            local ValueFrame = Instance.new("Frame",SlideFrame)
            local ValueCorner = Instance.new("UICorner",ValueFrame)
            local Value = Instance.new("TextLabel",SlideFrame)
            
            Slider.BackgroundColor3 = Color3.fromRGB(39,39,39)
            Slider.Name = "Slider"
            Slider.Size = UDim2.new(1,-8,0,37)
            
            SliderCorner.CornerRadius = UDim.new(0,6)
            SliderCorner.Name = "SliderCorner"
            
            Title.BackgroundTransparency = 1
            Title.Name = "Title"
            Title.Position = UDim2.new(0,12,0,7)
            Title.Size = UDim2.new(0,0,0,24)
            Title.Font = "Gotham"
            Title.Text = Text
            Title.TextColor3 = Color3.fromRGB(195,195,195)
            Title.TextSize = 14
            Title.TextXAlignment = "Left"
            
            SlideFrame.AnchorPoint = Vector2.new(1,0)
            SlideFrame.BackgroundColor3 = Color3.fromRGB(33,33,33)
            SlideFrame.Name = "SlideFrame"
            SlideFrame.Position = UDim2.new(1,-7,0,5)
            SlideFrame.Size = UDim2.new(0,192,0,26)
            
            SlideCorner.CornerRadius = UDim.new(0,3)
            SlideCorner.Name = "SlideCorner"
            
            ValueFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
            ValueFrame.BorderSizePixel = 0
            ValueFrame.Name = "ValueFrame"
            ValueFrame.Size = UDim2.new(0,0,1,0)
            
            ValueCorner.CornerRadius = UDim.new(0,3)
            ValueCorner.Name = "ValueCorner"
            
            Value.BackgroundTransparency = 1
            Value.Name = "Value"
            Value.Size = UDim2.new(1,0,1,0)
            Value.Font = "Gotham"
            Value.Text = Min
            Value.TextColor3 = Color3.fromRGB(195,195,195)
            Value.TextSize = 14
            
            Increment = Increment or 1
            Increment = 1 / Increment
            
            if Default then
                local Position = UDim2.new((math.clamp(Default,Min,Max) - Min) * (SlideFrame.AbsoluteSize.X / (Max - Min)) / SlideFrame.AbsoluteSize.X,0,1,0)
                
                ValueFrame.Size = Position
                
                local SlideValue = math.round((Position.X.Scale * (Max - Min) + Min) * Increment) / Increment
                
                Value.Text = SlideValue
                
                task.spawn(function()
                    pcall(Callback,SlideValue)
                end)
            end
            
            local function Slide(Input)
                local Position = UDim2.new(math.clamp((Input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X,0,1),0,1,0)
                
                ValueFrame:TweenSize(Position,"Out","Quart",0.3,true)
                
                local SlideValue = math.round((Position.X.Scale * (Max - Min) + Min) * Increment) / Increment
                
                Value.Text = SlideValue
                
                pcall(Callback,SlideValue)
            end
            
            SlideFrame.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true
                    Slide(Input)
                end
            end)
            
            SlideFrame.InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = false
                end
            end)
            
            UserInput.InputChanged:Connect(function(Input)
                if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) and Dragging then
                    if Gui.Enabled then
                        Slide(Input)
                    else
                        Dragging = false
                    end
                end
            end)
            
            ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
            
            function Object:Update(NewText,NewMin,NewMax,NewCallback,NewDefault,NewIncrement)
                Title.Text = NewText
                
                if NewCallback then
                    Callback = NewCallback
                end
                
                if NewMin then
                    Min = NewMin
                end
                
                if NewMax then
                    Max = NewMax
                end
                
                if NewDefault then
                    Default = NewDefault
                end
                
                if NewIncrement then
                    Increment = 1 / NewIncrement
                end
                
                local Position = UDim2.new((math.clamp(Default,Min,Max) - Min) * (SlideFrame.AbsoluteSize.X / (Max - Min)) / SlideFrame.AbsoluteSize.X,0,1,0)
                
                ValueFrame:TweenSize(Position,"Out","Quart",0.3,true)
                
                local SlideValue = math.round((Position.X.Scale * (Max - Min) + Min) * Increment) / Increment
                
                Value.Text = SlideValue
                
                pcall(Callback,SlideValue)
            end
            
            return Object
        end
        
        function TabContainer:Dropdown(Text,List,Callback)
            local Object = {}
            
            local Down = false
            local DropdownFrameSize = 0
            local ItemFrameSize = 0
            local Selected = Text
            local Dropdown = Instance.new("TextButton",ItemHolder)
            local DropdownCorner = Instance.new("UICorner",Dropdown)
            local Title = Instance.new("TextLabel",Dropdown)
            local DropToggle = Instance.new("ImageLabel",Dropdown)
            
            Dropdown.AutoButtonColor = false
            Dropdown.BackgroundColor3 = Color3.fromRGB(39,39,39)
            Dropdown.Name = "Dropdown"
            Dropdown.Size = UDim2.new(1,-8,0,29)
            Dropdown.Text = ""
            
            DropdownCorner.CornerRadius = UDim.new(0,6)
            DropdownCorner.Name = "DropdownCorner"
            
            Title.Name = "Title"
            Title.BackgroundTransparency = 1
            Title.Position = UDim2.new(0,12,0,3)
            Title.Size = UDim2.new(0,0,0,24)
            Title.Font = "Gotham"
            Title.Text = Text
            Title.TextColor3 = Color3.fromRGB(195,195,195)
            Title.TextSize = 14
            Title.TextXAlignment = "Left"
            
            DropToggle.BackgroundTransparency = 1
            DropToggle.Name = "DropToggle"
            DropToggle.Position = UDim2.new(1,-28,0,4)
            DropToggle.Size = UDim2.new(0,20,0,20)
            DropToggle.ZIndex = 2
            DropToggle.Image = "rbxassetid://3926307971"
            DropToggle.ImageColor3 = Color3.fromRGB(195,195,195)
            DropToggle.ImageRectOffset = Vector2.new(324,364)
            DropToggle.ImageRectSize = Vector2.new(36,36)
            
            local DropdownFrame = Instance.new("Frame",ItemHolder)
            local DropdownFrameCorner = Instance.new("UICorner",DropdownFrame)
            local DropItemHolder = Instance.new("ScrollingFrame",DropdownFrame)
            local DropItemHolderList = Instance.new("UIListLayout",DropItemHolder)
            
            DropdownFrame.BackgroundColor3 = Color3.fromRGB(39,39,39)
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Name = "DropdownFrame"
            DropdownFrame.Size = UDim2.new(1,-8,0,0)
            DropdownFrame.Visible = false
            DropdownFrame.ClipsDescendants = true
            
            DropdownFrameCorner.CornerRadius = UDim.new(0,6)
            DropdownFrameCorner.Name = "DropdownFrameCorner"
            
            DropItemHolder.Active = true
            DropItemHolder.BackgroundTransparency = 1
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Position = UDim2.new(0,12,0,4)
            DropItemHolder.Size = UDim2.new(1,-21,0,0)
            DropItemHolder.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
            DropItemHolder.CanvasSize = UDim2.new()
            DropItemHolder.ScrollBarThickness = 2
            DropItemHolder.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
            
            DropItemHolderList.Padding = UDim.new(0,3)
            DropItemHolderList.Name = "DropItemHolderList"
            DropItemHolderList.SortOrder = "LayoutOrder"
            
            Dropdown.MouseEnter:Connect(function()
                Tween:Create(Dropdown,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(44,44,44)}):Play()
            end)
            
            Dropdown.MouseLeave:Connect(function()
                Tween:Create(Dropdown,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(39,39,39)}):Play()
            end)
            
            Dropdown.MouseButton1Click:Connect(function()
                if Down then
                    Down = false
                    
                    Tween:Create(Title,TweenInfo.new(0.3),{TextTransparency = 0}):Play()
                    Tween:Create(DropToggle,TweenInfo.new(0.3),{Rotation = 0}):Play()
                    
                    Title.Text = Text
                    
                    DropdownFrame:TweenSize(UDim2.new(1,-8,0,0),"Out","Quart",0.1,true)
                    DropItemHolder:TweenSize(UDim2.new(1,-21,0,0),"Out","Quart",0.1,true)
                    task.wait(0.05)
                    
                    DropdownFrame.Visible = false
                    
                    task.wait(0.05)
                    
                    ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
                else
                    Down = true
                    
                    Tween:Create(Title,TweenInfo.new(0.3),{TextTransparency = 0.5}):Play()
                    Tween:Create(DropToggle,TweenInfo.new(0.3),{Rotation = 360}):Play()
                    
                    Title.Text = Selected
                    DropdownFrame.Visible = true
                    
                    DropdownFrame:TweenSize(UDim2.new(1,-8,0,DropdownFrameSize),"Out","Quart",0.1,true)
                    DropItemHolder:TweenSize(UDim2.new(1,-21,0,ItemFrameSize),"Out","Quart",0.1,true)
                    task.wait(0.1)
                    
                    ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
                end
            end)
            
            for i,v in next,List do
                local Option = Instance.new("TextButton",DropItemHolder)
                local OptionCorner = Instance.new("UICorner",Option)
                
                Option.AutoButtonColor = false
                Option.BackgroundColor3 = Color3.fromRGB(39,39,39)
                Option.Name = "Option"
                Option.Size = UDim2.new(1,-5,0,25)
                Option.Font = "Gotham"
                Option.Text = v
                Option.TextColor3 = Color3.fromRGB(195,195,195)
                Option.TextSize = 14
                
                OptionCorner.CornerRadius = UDim.new(0,6)
                OptionCorner.Name = "OptionCorner"
                
                if i < 4 then
                    DropdownFrameSize = DropItemHolderList.AbsoluteContentSize.Y + 8
                    ItemFrameSize = DropItemHolderList.AbsoluteContentSize.Y
                else
                    DropItemHolder.CanvasSize = UDim2.new(0,0,0,DropItemHolderList.AbsoluteContentSize.Y)
                end
                
                Option.MouseEnter:Connect(function()
                    Tween:Create(Option,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(44,44,44)}):Play()
                end)
                
                Option.MouseLeave:Connect(function()
                    Tween:Create(Option,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(39,39,39)}):Play()
                end)
                
                Option.MouseButton1Click:Connect(function()
                    Down = false
                    
                    Tween:Create(Title,TweenInfo.new(0.3),{TextTransparency = 0}):Play()
                    Tween:Create(DropToggle,TweenInfo.new(0.3),{Rotation = 0}):Play()
                    
                    Title.Text = Text
                    Selected = v
                    
                    DropdownFrame:TweenSize(UDim2.new(1,-8,0,0),"Out","Quart",0.1,true)
                    DropItemHolder:TweenSize(UDim2.new(1,-21,0,0),"Out","Quart",0.1,true)
                    
                    task.spawn(function()
                        pcall(Callback,v)
                    end)
                    
                    task.wait(0.05)
                    
                    DropdownFrame.Visible = false
                    
                    task.wait(0.05)
                    
                    ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
                end)
            end
            
            ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
            
            function Object:Update(NewText,NewList,NewCallback)
                Text = NewText
                
                if not Down then
                    Title.Text = NewText
                end
                
                if NewCallback then
                    Callback = NewCallback
                end
                
                if not table.find(NewList,Selected) then
                    Selected = NewText
                    
                    task.spawn(function()
                        pcall(Callback,NewText)
                    end)
                end
                
                local OldPosition = DropItemHolder.CanvasPosition
                
                List = NewList
                
                for i,v in next,DropItemHolder:GetChildren() do
                    if v:IsA("TextButton") then
                        v:Destroy()
                    end
                end
                
                DropdownFrameSize = 0
                ItemFrameSize = 0
                DropItemHolder.CanvasSize = UDim2.new()
                
                for i,v in next,List do
                    local Option = Instance.new("TextButton",DropItemHolder)
                    local OptionCorner = Instance.new("UICorner",Option)
                    
                    Option.AutoButtonColor = false
                    Option.BackgroundColor3 = Color3.fromRGB(39,39,39)
                    Option.Name = "Option"
                    Option.Size = UDim2.new(1,-5,0,25)
                    Option.Font = "Gotham"
                    Option.Text = v
                    Option.TextColor3 = Color3.fromRGB(195,195,195)
                    Option.TextSize = 14
                    
                    OptionCorner.CornerRadius = UDim.new(0,6)
                    OptionCorner.Name = "OptionCorner"
                    
                    if i < 4 then
                        DropdownFrameSize = DropItemHolderList.AbsoluteContentSize.Y + 8
                        ItemFrameSize = DropItemHolderList.AbsoluteContentSize.Y
                    else
                        DropItemHolder.CanvasSize = UDim2.new(0,0,0,DropItemHolderList.AbsoluteContentSize.Y)
                    end
                    
                    Option.MouseEnter:Connect(function()
                        Tween:Create(Option,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(44,44,44)}):Play()
                    end)
                    
                    Option.MouseLeave:Connect(function()
                        Tween:Create(Option,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(39,39,39)}):Play()
                    end)
                    
                    Option.MouseButton1Click:Connect(function()
                        Down = false
                        
                        Tween:Create(Title,TweenInfo.new(0.3),{TextTransparency = 0}):Play()
                        Tween:Create(DropToggle,TweenInfo.new(0.3),{Rotation = 0}):Play()
                        
                        Title.Text = Text
                        Selected = v
                        
                        DropdownFrame:TweenSize(UDim2.new(1,-8,0,0),"Out","Quart",0.1,true)
                        DropItemHolder:TweenSize(UDim2.new(1,-21,0,0),"Out","Quart",0.1,true)
                        
                        task.spawn(function()
                            pcall(Callback,v)
                        end)
                        
                        task.wait(0.05)
                        
                        DropdownFrame.Visible = false
                        
                        task.wait(0.05)
                        
                        ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
                    end)
                end
                
                DropItemHolder.CanvasPosition = OldPosition
                
                if Down then
                    DropdownFrame:TweenSize(UDim2.new(1,-8,0,DropdownFrameSize),"Out","Quart",0.1,true)
                    DropItemHolder:TweenSize(UDim2.new(1,-21,0,ItemFrameSize),"Out","Quart",0.1,true)
                    task.wait(0.1)
                    
                    ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
                end
            end
            
            return Object
        end
        
        function TabContainer:Colorpicker(Text,Default,Callback)
            local Object = {}
            
            local Down = false
            local OldToggleColor = Color3.fromRGB()
            local OldColor = Color3.fromRGB()
            local OldColorSelectionPosition,OldHueSelectionPosition
            local ColorH,ColorS,ColorV = 1,1,1
            local RainbowColorPicker = false
            local ColorPickerInput,ColorInput,HueInput
            local Colorpicker = Instance.new("TextButton",ItemHolder)
            local ColorpickerCorner = Instance.new("UICorner",Colorpicker)
            local Title = Instance.new("TextLabel",Colorpicker)
            local CurrentColor = Instance.new("Frame",Colorpicker)
            local ColorCorner = Instance.new("UICorner",CurrentColor)
            
            Colorpicker.BackgroundColor3 = Color3.fromRGB(39,39,39)
            Colorpicker.Name = "Colorpicker"
            Colorpicker.Size = UDim2.new(1,-8,0,29)
            Colorpicker.AutoButtonColor = false
            Colorpicker.Text = ""
            
            ColorpickerCorner.CornerRadius = UDim.new(0,6)
            ColorpickerCorner.Name = "ColorpickerCorner"
            
            Title.BackgroundTransparency = 1
            Title.Name = "Title"
            Title.Position = UDim2.new(0,12,0,3)
            Title.Size = UDim2.new(0,0,0,24)
            Title.Font = "Gotham"
            Title.Text = Text
            Title.TextColor3 = Color3.fromRGB(195,195,195)
            Title.TextSize = 14
            Title.TextXAlignment = "Left"
            
            CurrentColor.BackgroundColor3 = Default
            CurrentColor.Name = "CurrentColor"
            CurrentColor.Position = UDim2.new(1,-26,0,5)
            CurrentColor.Size = UDim2.new(0,19,0,19)
            
            ColorCorner.CornerRadius = UDim.new(0,6)
            ColorCorner.Name = "ColorCorner"
            
            local ColorpickerFrame = Instance.new("Frame",ItemHolder)
            local ColorpickerFrameCorner = Instance.new("UICorner",ColorpickerFrame)
            local Color = Instance.new("ImageLabel",ColorpickerFrame)
            local ColorCorner = Instance.new("UICorner",Color)
            local ColorSelection = Instance.new("ImageLabel",Color)
            local Hue = Instance.new("Frame",ColorpickerFrame)
            local HueCorner = Instance.new("UICorner",Hue)
            local HueGradient = Instance.new("UIGradient",Hue)
            local HueSelection = Instance.new("ImageLabel",Hue)
            local Confirm = Instance.new("TextButton",ColorpickerFrame)
            local RainbowToggle = Instance.new("TextButton",ColorpickerFrame)
            local RainbowTitle = Instance.new("TextLabel",RainbowToggle)
            local RainbowStatus = Instance.new("Frame",RainbowToggle)
            local RainbowStatusCorner = Instance.new("UICorner",RainbowStatus)
            
            ColorpickerFrame.BackgroundColor3 = Color3.fromRGB(39,39,39)
            ColorpickerFrame.BorderSizePixel = 0
            ColorpickerFrame.Name = "ColorpickerFrame"
            ColorpickerFrame.Size = UDim2.new(1,-8,0,0)
            ColorpickerFrame.Visible = false
            ColorpickerFrame.ClipsDescendants = true
            
            ColorpickerFrameCorner.CornerRadius = UDim.new(0,6)
            ColorpickerFrameCorner.Name = "ColorpickerFrameCorner"
            
            Color.BackgroundColor3 = Color3.fromHSV(Default:ToHSV(),1,1)
            Color.Name = "Color"
            Color.Position = UDim2.new(0,11,0,9)
            Color.Size = UDim2.new(0,212,0,93)
            Color.ZIndex = 10
            Color.Image = "rbxassetid://4155801252"
            
            ColorCorner.CornerRadius = UDim.new(0,3)
            ColorCorner.Name = "ColorCorner"
            
            ColorSelection.AnchorPoint = Vector2.new(0.5,0.5)
            ColorSelection.BackgroundTransparency = 1
            ColorSelection.Name = "ColorSelection"
            ColorSelection.Position = UDim2.new(select(2,Default:ToHSV()),0,1 - select(3,Default:ToHSV()),0)
            ColorSelection.Size = UDim2.new(0,18,0,18)
            ColorSelection.ZIndex = 25
            ColorSelection.Image = "rbxassetid://4805639000"
            ColorSelection.ScaleType = "Fit"
            
            Hue.BackgroundColor3 = Color3.fromRGB(255,255,255)
            Hue.Name = "Hue"
            Hue.Position = UDim2.new(0,233,0,9)
            Hue.Size = UDim2.new(0,25,0,93)
            
            HueCorner.CornerRadius = UDim.new(0,3)
            HueCorner.Name = "HueCorner"
            
            HueGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,4)),
                ColorSequenceKeypoint.new(0.2,Color3.fromRGB(234,255,0)),
                ColorSequenceKeypoint.new(0.4,Color3.fromRGB(21,255,0)),
                ColorSequenceKeypoint.new(0.6,Color3.fromRGB(0,255,255)),
                ColorSequenceKeypoint.new(0.8,Color3.fromRGB(0,17,255)),
                ColorSequenceKeypoint.new(0.9,Color3.fromRGB(255,0,251)),
                ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,4))
            })
            HueGradient.Rotation = 270
            HueGradient.Name = "HueGradient"
            
            HueSelection.AnchorPoint = Vector2.new(0.5,0.5)
            HueSelection.BackgroundTransparency = 1
            HueSelection.Name = "HueSelection"
            HueSelection.Position = UDim2.new(0.5,0,1 - Default:ToHSV(),0)
            HueSelection.Size = UDim2.new(0,18,0,18)
            HueSelection.Image = "rbxassetid://4805639000"
            
            RainbowToggle.BackgroundTransparency = 1
            RainbowToggle.Name = "RainbowToggle"
            RainbowToggle.Position = UDim2.new(0,268,0,27)
            RainbowToggle.Size = UDim2.new(0,212,0,29)
            RainbowToggle.Text = ""
            
            RainbowTitle.BackgroundTransparency = 1
            RainbowTitle.Name = "Title"
            RainbowTitle.Position = UDim2.new(0,6,0,3)
            RainbowTitle.Size = UDim2.new(0,0,0,24)
            RainbowTitle.Font = "Gotham"
            RainbowTitle.Text = "Rainbow"
            RainbowTitle.TextColor3 = Color3.fromRGB(195,195,195)
            RainbowTitle.TextSize = 14
            RainbowTitle.TextXAlignment = "Left"
            
            RainbowStatus.BackgroundColor3 = Color3.fromRGB(255,39,42)
            RainbowStatus.Name = "Status"
            RainbowStatus.Position = UDim2.new(1,-19,0,5)
            RainbowStatus.Size = UDim2.new(0,19,0,19)
            
            RainbowStatusCorner.CornerRadius = UDim.new(0,6)
            RainbowStatusCorner.Name = "StatusCorner"
            
            Confirm.BackgroundTransparency = 1
            Confirm.Name = "Confirm"
            Confirm.Position = UDim2.new(0,268,0,59)
            Confirm.Size = UDim2.new(0,212,0,29)
            Confirm.Font = "Gotham"
            Confirm.Text = "Confirm"
            Confirm.TextColor3 = Color3.fromRGB(195,195,195)
            Confirm.TextSize = 14
            
            Colorpicker.MouseEnter:Connect(function()
                Tween:Create(Colorpicker,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(44,44,44)}):Play()
            end)
            
            Colorpicker.MouseLeave:Connect(function()
                Tween:Create(Colorpicker,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(39,39,39)}):Play()
            end)
            
            local function UpdateColorPicker()
                CurrentColor.BackgroundColor3 = Color3.fromHSV(ColorH,ColorS,ColorV)
                Color.BackgroundColor3 = Color3.fromHSV(ColorH,1,1)
                
                task.spawn(function()
                    pcall(Callback,CurrentColor.BackgroundColor3)
                end)
            end
            
            ColorH = 1 - math.clamp(HueSelection.AbsolutePosition.Y + 9 - Hue.AbsolutePosition.Y,0,Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y
            ColorS = math.clamp(ColorSelection.AbsolutePosition.X + 9 - Color.AbsolutePosition.X,0,Color.AbsoluteSize.X) / Color.AbsoluteSize.X
            ColorV = 1 - math.clamp(ColorSelection.AbsolutePosition.Y + 9 - Color.AbsolutePosition.Y,0,Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y
            
            UpdateColorPicker()
            
            Colorpicker.MouseButton1Click:Connect(function()
                if Down then
                    Down = false
                    
                    ColorpickerFrame:TweenSize(UDim2.new(1,-8,0,0),"Out","Quart",0.1,true)
                    task.wait(0.05)
                    
                    ColorpickerFrame.Visible = false
                    
                    task.wait(0.05)
                    
                    ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
                else
                    Down = true
                    
                    ColorpickerFrame.Visible = true
                    
                    ColorpickerFrame:TweenSize(UDim2.new(1,-8,0,111),"Out","Quart",0.1,true)
                    task.wait(0.1)
                    
                    ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
                end
            end)
            
            Color.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and not RainbowColorPicker then
                    if ColorInput then
                        ColorInput:Disconnect()
                    end
                    
                    ColorInput = Run.Heartbeat:Connect(function()
                        local MouseLocation = UserInput:GetMouseLocation() - Vector2.new(0,36)
                        local ColorX = math.clamp(MouseLocation.X - Color.AbsolutePosition.X,0,Color.AbsoluteSize.X) / Color.AbsoluteSize.X
                        local ColorY = math.clamp(MouseLocation.Y - Color.AbsolutePosition.Y,0,Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y
                        
                        ColorSelection.Position = UDim2.new(ColorX,0,ColorY,0)
                        ColorS = ColorX
                        ColorV = 1 - ColorY
                        
                        if not Gui.Enabled then
                            ColorInput:Disconnect()
                        end
                        
                        UpdateColorPicker()
                    end)
                end
            end)
            
            Color.InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and ColorInput then
                    ColorInput:Disconnect()
                end
            end)
            
            Hue.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and not RainbowColorPicker then
                    if HueInput then
                        HueInput:Disconnect()
                    end
                    
                    HueInput = Run.Heartbeat:Connect(function()
                        local HueY = math.clamp(UserInput:GetMouseLocation().Y - 36 - Hue.AbsolutePosition.Y,0,Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y
                        
                        HueSelection.Position = UDim2.new(0.5,0,HueY,0)
                        ColorH = 1 - HueY
                        
                        if not Gui.Enabled then
                            HueInput:Disconnect()
                        end
                        
                        UpdateColorPicker()
                    end)
                end
            end)
            
            Hue.InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and HueInput then
                    HueInput:Disconnect()
                end
            end)
            
            RainbowToggle.MouseButton1Down:Connect(function()
                RainbowColorPicker = not RainbowColorPicker
                
                if ColorInput then
                    ColorInput:Disconnect()
                end
                
                if HueInput then
                    HueInput:Disconnect()
                end
                
                if RainbowColorPicker then
                    Tween:Create(RainbowStatus,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(44,255,58)}):Play()
                    
                    OldToggleColor = CurrentColor.BackgroundColor3
                    OldColor = Color.BackgroundColor3
                    OldColorSelectionPosition = ColorSelection.Position
                    OldHueSelectionPosition = HueSelection.Position
                    
                    while RainbowColorPicker do
                        CurrentColor.BackgroundColor3 = Library.RainbowColor
                        Color.BackgroundColor3 = Library.RainbowColor
                        
                        ColorSelection.Position = UDim2.new(1,0,0,0)
                        HueSelection.Position = UDim2.new(0.5,0,1 - Color3.toHSV(Library.RainbowColor),0)
                        
                        task.spawn(function()
                            pcall(Callback,CurrentColor.BackgroundColor3)
                        end)
                        
                        Run.Heartbeat:Wait()
                    end
                else
                    Tween:Create(RainbowStatus,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(255,39,42)}):Play()
                    
                    CurrentColor.BackgroundColor3 = OldToggleColor
                    Color.BackgroundColor3 = OldColor
                    
                    ColorSelection.Position = OldColorSelectionPosition
                    HueSelection.Position = OldHueSelectionPosition
                    
                    pcall(Callback,CurrentColor.BackgroundColor3)
                end
            end)
            
            Confirm.MouseButton1Click:Connect(function()
                Down = not Down
                
                ColorpickerFrame:TweenSize(UDim2.new(1,-8,0,0),"Out","Quart",0.1,true)
                task.wait(0.05)
                
                ColorpickerFrame.Visible = false
                
                task.wait(0.05)
                
                ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
            end)
            
            ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
            
            function Object:Update(NewText,NewDefault,NewCallback)
                Title.Text = NewText
                
                if NewCallback then
                    Callback = NewCallback
                end
                
                Default = NewDefault
                
                ColorH,ColorS,ColorV = Default:ToHSV()
                
                ColorSelection.Position = UDim2.new(ColorS,0,1 - ColorV,0)
                HueSelection.Position = UDim2.new(0.5,0,1 - ColorH,0)
                
                UpdateColorPicker()
            end
            
            return Object
        end
        
        function TabContainer:Textbox(Text,Disappear,Callback,Default)
            local Object = {}
            
            local Textbox = Instance.new("Frame",ItemHolder)
            local TextboxCorner = Instance.new("UICorner",Textbox)
            local Title = Instance.new("TextLabel",Textbox)
            local TextBox = Instance.new("TextBox",Textbox)
            local TextBoxCorner = Instance.new("UICorner",TextBox)
            
            Textbox.BackgroundColor3 = Color3.fromRGB(39,39,39)
            Textbox.Name = "Textbox"
            Textbox.Size = UDim2.new(1,-8,0,37)
            
            TextboxCorner.CornerRadius = UDim.new(0,6)
            TextboxCorner.Name = "TextboxCorner"
            
            Title.BackgroundTransparency = 1
            Title.Name = "Title"
            Title.Position = UDim2.new(0,12,0,7)
            Title.Size = UDim2.new(0,0,0,24)
            Title.Font = "Gotham"
            Title.Text = Text
            Title.TextColor3 = Color3.fromRGB(195,195,195)
            Title.TextSize = 14
            Title.TextXAlignment = "Left"
            
            TextBox.AnchorPoint = Vector2.new(1,0)
            TextBox.BackgroundColor3 = Color3.fromRGB(33,33,33)
            TextBox.ClearTextOnFocus = false
            TextBox.Position = UDim2.new(1,-7,0,5)
            TextBox.Size = UDim2.new(0,192,0,26)
            TextBox.Font = "Gotham"
            TextBox.Text = not Disappear and Default or ""
            TextBox.TextColor3 = Color3.fromRGB(195,195,195)
            TextBox.TextSize = 14
            
            TextBoxCorner.CornerRadius = UDim.new(0,6)
            TextBoxCorner.Name = "TextBoxCorner"
            
            TextBox.Focused:Connect(function()
                TextBox:TweenSize(UDim2.new(0,240,0,26),"Out","Quart",0.1,true)
            end)
            
            TextBox.FocusLost:Connect(function(Enter)
                if #TextBox.Text > 0 then
                    if Enter then
                        TextBox:TweenSize(UDim2.new(0,192,0,26),"Out","Quart",0.1,true)
                        
                        local Text = TextBox.Text
                        
                        if Disappear then
                            TextBox.Text = ""
                        end
                        
                        pcall(Callback,Text)
                    end
                else
                    TextBox:TweenSize(UDim2.new(0,192,0,26),"Out","Quart",0.1,true)
                end
            end)
            
            ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
            
            function Object:Update(NewText,NewDisappear,NewCallback,NewDefault)
                Title.Text = NewText
                
                if NewCallback then
                    Callback = NewCallback
                end
                
                if NewDisappear then
                    Disappear = NewDisappear
                end
                
                if NewDefault then
                    pcall(Callback,NewDefault)
                end
            end
            
            return Object
        end
        
        function TabContainer:Keybind(Text,Key,Callback)
            local Object = {}
            
            local KeyName = Key.Name
            local Bind = Instance.new("TextButton",ItemHolder)
            local BindCorner = Instance.new("UICorner",Bind)
            local Title = Instance.new("TextLabel",Bind)
            local BindFrame = Instance.new("Frame",Bind)
            local BindFrameCorner = Instance.new("UICorner",BindFrame)
            local BindLabel = Instance.new("TextLabel",BindFrame)
            
            Bind.AutoButtonColor = false
            Bind.BackgroundColor3 = Color3.fromRGB(39,39,39)
            Bind.Name = "Bind"
            Bind.Size = UDim2.new(1,-8,0,29)
            Bind.Text = ""
            
            BindCorner.CornerRadius = UDim.new(0,6)
            BindCorner.Name = "BindCorner"
            
            Title.BackgroundTransparency = 1
            Title.Name = "Title"
            Title.Position = UDim2.new(0,12,0,3)
            Title.Size = UDim2.new(0,0,0,24)
            Title.Font = "Gotham"
            Title.Text = Text
            Title.TextColor3 = Color3.fromRGB(195,195,195)
            Title.TextSize = 14
            Title.TextXAlignment = "Left"
            
            BindFrame.AnchorPoint = Vector2.new(1,0)
            BindFrame.BackgroundColor3 = Color3.fromRGB(33,33,33)
            BindFrame.Name = "BindFrame"
            BindFrame.Position = UDim2.new(1,-7,0,5)
            BindFrame.Size = UDim2.new(0,103,0,19)
            
            BindFrameCorner.CornerRadius = UDim.new(0,6)
            BindFrameCorner.Name = "BindFrameCorner"
            
            BindLabel.BackgroundTransparency = 1
            BindLabel.Name = "BindLabel"
            BindLabel.Size = UDim2.new(1,0,1,0)
            BindLabel.Font = "Gotham"
            BindLabel.Text = KeyName
            BindLabel.TextColor3 = Color3.fromRGB(195,195,195)
            BindLabel.TextSize = 13
            
            Bind.MouseEnter:Connect(function()
                Tween:Create(Bind,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(44,44,44)}):Play()
            end)
            
            Bind.MouseLeave:Connect(function()
                Tween:Create(Bind,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(39,39,39)}):Play()
            end)
            
            Bind.MouseButton1Click:Connect(function()
                BindLabel.Text = "..."
                
                local Input = UserInput.InputBegan:Wait()
                
                if Input.KeyCode.Name ~= "Unknown" then
                    Run.Heartbeat:Wait()
                    
                    BindLabel.Text = Input.KeyCode.Name
                    KeyName = Input.KeyCode.Name
                end
            end)
            
            UserInput.InputBegan:Connect(function(Input,Pressed)
                if not Pressed and Input.KeyCode.Name == KeyName then
                    pcall(Callback)
                end
            end)
            
            ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
            
            function Object:Update(NewText,NewKey,NewCallback)
                Title.Text = NewText
                
                if NewCallback then
                    Callback = NewCallback
                end
                
                if NewKey then
                    BindLabel.Text = NewKey.KeyCode.Name
                    KeyName = NewKey.KeyCode.Name
                end
            end
            
            return Object
        end
        
        function TabContainer:Label(Text)
            local Object = {}
            
            local Label = Instance.new("TextLabel",ItemHolder)
            local LabelCorner = Instance.new("UICorner",Label)
            
            Label.BackgroundColor3 = Color3.fromRGB(39,39,39)
            Label.Name = "Label"
            Label.Size = UDim2.new(1,-8,0,29)
            Label.Font = "Gotham"
            Label.Text = Text
            Label.TextColor3 = Color3.fromRGB(195,195,195)
            Label.TextSize = 14
            
            LabelCorner.CornerRadius = UDim.new(0,6)
            LabelCorner.Name = "LabelCorner"
            
            ItemHolder.CanvasSize = UDim2.new(0,0,0,ItemHolderList.AbsoluteContentSize.Y)
            
            function Object:Update(NewText)
                Label.Text = NewText
            end
            
            return Object
        end
        
        return TabContainer
    end
    
    return Window
end

return Library

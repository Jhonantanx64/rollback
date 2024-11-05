-- โค้ดทั้งหมดที่รวมกัน (LocalScript และ ServerScript)
-- LocalScript
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local rollbackEvent = ReplicatedStorage:WaitForChild("RollbackEvent")

-- GUI elements
local screenGui = script.Parent
local frame = screenGui:WaitForChild("Frame")
local rollbackButton = frame:WaitForChild("TextButton")

-- สถานะการเปิด/ปิด Rollback
local isRollbackEnabled = false

-- ฟังก์ชันสำหรับการเปลี่ยนแปลงปุ่ม
local function toggleRollback()
    isRollbackEnabled = not isRollbackEnabled
    
    if isRollbackEnabled then
        rollbackButton.Text = "Disable Rollback"
    else
        rollbackButton.Text = "Enable Rollback"
    end

    -- ส่ง event ไปที่ server เพื่อทำการ rollback
    rollbackEvent:FireServer(isRollbackEnabled)
end

-- การคลิกปุ่ม
rollbackButton.MouseButton1Click:Connect(toggleRollback)

-- ServerScript
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local rollbackEvent = ReplicatedStorage:WaitForChild("RollbackEvent")

rollbackEvent.OnServerEvent:Connect(function(player, enableRollback)
    -- หาก enableRollback เป็น true จะทำการ rollback
    if enableRollback then
        -- ที่นี่คุณสามารถใส่ฟังก์ชัน rollback ของคุณได้
        print(player.Name .. " enabled rollback")
        
        -- ตัวอย่างการ rollback ตัวละครกลับไปที่ตำแหน่งเดิม
        local character = player.Character
        if character then
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            local initialPosition = Vector3.new(0, 10, 0) -- กำหนดตำแหน่งเริ่มต้นที่ต้องการ
            humanoidRootPart.CFrame = CFrame.new(initialPosition)
        end
    else
        -- หากไม่ enable rollback ก็สามารถทำอะไรเพิ่มเติมได้
        print(player.Name .. " disabled rollback")
    end
end)

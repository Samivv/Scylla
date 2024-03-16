function CreateBaseFrame()
    local baseFrame = CreateFrame("Frame", "DailyToDoFrame", UIParent)
    
    baseFrame:SetSize(GetScreenWidth() * 0.2, GetScreenHeight() * 0.25)
    baseFrame:SetPoint("CENTER")
    baseFrame:SetMovable(true)
    baseFrame:EnableMouse(true)
    baseFrame:RegisterForDrag("LeftButton")
    baseFrame:SetScript("OnDragStart", baseFrame.StartMoving)
    baseFrame:SetScript("OnDragStop", baseFrame.StopMovingOrSizing)
    
    -- Create the background
    local bg = baseFrame:CreateTexture(nil, "BACKGROUND")
    -- bg:SetColorTexture(0, 0, 0, 0.5) -- RGBA for black with 50% opacity
    bg:SetAllPoints(baseFrame)
    bg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
    
    -- Add close button to the frame
    local close = CreateFrame("Button", "DailyToDoFrameCloseButton", baseFrame)
    close:SetSize(20, baseFrame:GetHeight() / 8)
    close:SetPoint("TOPRIGHT", baseFrame, "TOPRIGHT")

    local closeText = close:CreateFontString()
    closeText:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
    closeText:SetText("X")
    closeText:SetTextColor(1, 1, 1)
    closeText:SetPoint("CENTER", close)
    close:SetFontString(closeText)
    
    close:SetScript("OnEnter", function(self)
        closeText:SetTextColor(1, 0, 0) -- RGB for red
    end)
    
    close:SetScript("OnLeave", function(self)
        closeText:SetTextColor(1, 1, 1) -- RGB for white
    end)

    close:SetScript("OnClick", function()
        baseFrame:Hide()
    end)
    
    -- Create the title
    local title = baseFrame:CreateFontString(nil, "OVERLAY")
    local titleBG = baseFrame:CreateTexture(nil, "BACKGROUND")
    titleBG:SetAllPoints(title)
    titleBG:SetColorTexture(1, 0, 0, 0.5) -- RGBA for red with 50% opacity
    title:SetSize(baseFrame:GetWidth(), baseFrame:GetHeight() / 8)
    title:SetFontObject("GameFontHighlightLarge")
    title:SetPoint("TOP", baseFrame, "TOP", 0, 0)
    title:SetText(UnitName("player").."'s Dailies")
    --title:SetText("Daily Checker")
    
    return baseFrame
end


-- Create the footer
function CreateFooter(baseFrame)
    local footer = baseFrame:CreateFontString(nil, "OVERLAY")
    footer:SetFontObject("GameFontHighlight")
    footer:SetPoint("BOTTOM", baseFrame, "BOTTOM", 0, 0)
    footer:SetSize(baseFrame:GetWidth(), baseFrame:GetHeight() / 8)

    local titleBG = baseFrame:CreateTexture(nil, "BACKGROUND")
    titleBG:SetAllPoints(footer)
    titleBG:SetColorTexture(1, 0, 0, 0.5) -- RGBA for black with 50% opacity
    
    local function UpdateFooter()
        local dailyResetTime = GetQuestResetTime()
        local dailyHours = math.floor(dailyResetTime / 3600)
        local dailyMinutes = math.floor((dailyResetTime % 3600) / 60)
    
        local weeklyResetTime = C_DateAndTime.GetSecondsUntilWeeklyReset()
        local weeklyTimeText
        if weeklyResetTime > 86400 then
            local weeklyDays = math.floor(weeklyResetTime / 86400)
            local weeklyHours = math.floor((weeklyResetTime % 86400) / 3600)
            weeklyTimeText = weeklyDays .. "d " .. weeklyHours .. "h"
        else
            local weeklyHours = math.floor(weeklyResetTime / 3600)
            local weeklyMinutes = math.floor((weeklyResetTime % 3600) / 60)
            weeklyTimeText = weeklyHours .. "h " .. weeklyMinutes .. "m"
        end
    
        footer:SetText("Daily reset in " .. dailyHours .. "h " .. dailyMinutes .. "m\n" ..
                       "Weekly reset in " .. weeklyTimeText)
    end
    
    baseFrame:SetScript("OnUpdate", function(self, elapsed)
        self.timeSinceLastUpdate = (self.timeSinceLastUpdate or 0) + elapsed
        if self.timeSinceLastUpdate >= 1.0 then
            UpdateFooter()
            self.timeSinceLastUpdate = 0
        end
    end)
end


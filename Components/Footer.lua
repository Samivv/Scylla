-- Create the footer
function CreateFooter(baseFrame, baseFrameWidth, baseFrameHeight)
    local footerFrame = CreateFrame("Frame", nil, baseFrame)
    footerFrame:SetPoint("TOP", baseFrame, "BOTTOM", 0, 0)
    footerFrame:SetSize(baseFrameWidth, baseFrameHeight / 8)

    local footerText1 = footerFrame:CreateFontString(nil, "OVERLAY")
    footerText1:SetFontObject("GameFontHighlight")
    footerText1:SetPoint("TOP", footerFrame, "TOP", 0, -10)

    local footerText2 = footerFrame:CreateFontString(nil, "OVERLAY")
    footerText2:SetFontObject("GameFontHighlight")
    footerText2:SetPoint("BOTTOM", footerFrame, "BOTTOM", 0, 10)

    local titleBG = footerFrame:CreateTexture(nil, "BACKGROUND")
    titleBG:SetAllPoints(footerFrame)
    titleBG:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")

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

        footerText1:SetText("Daily reset in " .. dailyHours .. "h " .. dailyMinutes .. "m")
        footerText2:SetText("Weekly reset in " .. weeklyTimeText)

        -- Adjust frame height based on text size
        local textHeight = footerText1:GetStringHeight() + footerText2:GetStringHeight() + 20
        footerFrame:SetSize(baseFrameWidth, textHeight)
    end

    footerFrame:SetScript("OnUpdate", function(self, elapsed)
        self.timeSinceLastUpdate = (self.timeSinceLastUpdate or 0) + elapsed
        if self.timeSinceLastUpdate >= 1.0 then
            UpdateFooter()
            self.timeSinceLastUpdate = 0
        end
    end)

    return footerFrame
end
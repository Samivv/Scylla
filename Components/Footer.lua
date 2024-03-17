-- Create the footer
function CreateFooter(baseFrame, baseFrameWidth, baseFrameHeight)
    local footerFrame = CreateFrame("Frame", nil, baseFrame)
    footerFrame:SetPoint("TOP", baseFrame, "BOTTOM", 0, 0)
    footerFrame:SetSize(baseFrameWidth, baseFrameHeight / 10)

    local footerBG = footerFrame:CreateTexture(nil, "BACKGROUND")
    footerBG:SetAllPoints(footerFrame)
    footerBG:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")

    local footerText1 = footerFrame:CreateFontString(nil, "OVERLAY")
    footerText1:SetFontObject("GameFontHighlight")
    footerText1:SetPoint("TOP", footerFrame, "CENTER", 0, 0)

    local footerText2 = footerFrame:CreateFontString(nil, "OVERLAY")
    footerText2:SetFontObject("GameFontHighlight")
    footerText2:SetPoint("BOTTOM", footerText1, "BOTTOM", 0, 12)

    local titleBG = footerFrame:CreateTexture(nil, "BACKGROUND")
    titleBG:SetAllPoints(footerFrame)
    titleBG:SetColorTexture(1, 0, 0, 0.5)

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

        local textHeight1 = footerText1:GetStringHeight()
        local textHeight2 = footerText2:GetStringHeight()
        local totalTextHeight = textHeight1 + textHeight2 + 10
        footerFrame:SetSize(baseFrameWidth, totalTextHeight)
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
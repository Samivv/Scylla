--Generate reputation frame with the ashen verdict and the argent crusade standing shown.
function CreateReputationsFrame(baseFrame, baseFrameWidth, baseFrameHeight)
    local reputationsFrame = CreateFrame("Frame", nil, baseFrame)
    reputationsFrame:SetPoint("TOP", baseFrame, "BOTTOM", 0, 0)
    reputationsFrame:SetSize(baseFrameWidth, baseFrameHeight / 10)

    local reputationsBG = reputationsFrame:CreateTexture(nil, "BACKGROUND")
    reputationsBG:SetAllPoints(reputationsFrame)
    reputationsBG:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")

    local reputationsText1 = reputationsFrame:CreateFontString(nil, "OVERLAY")
    reputationsText1:SetFontObject("GameFontHighlight")
    reputationsText1:SetPoint("TOP", reputationsFrame, "CENTER", 0, 0)

    local reputationsText2 = reputationsFrame:CreateFontString(nil, "OVERLAY")
    reputationsText2:SetFontObject("GameFontHighlight")
    reputationsText2:SetPoint("BOTTOM", reputationsText1, "BOTTOM", 0, 12)

    local titleBG = reputationsFrame:CreateTexture(nil, "BACKGROUND")
    titleBG:SetAllPoints(reputationsFrame)
    titleBG:SetColorTexture(1, 0, 0, 0.5)

    local function UpdateReputations()
        local ashenVerdictStanding = GetFactionInfoByID(1156)
        local argentCrusadeStanding = GetFactionInfoByID(1106)

        reputationsText1:SetText("Ashen Verdict: " .. ashenVerdictStanding)
        reputationsText2:SetText("Argent Crusade: " .. argentCrusadeStanding)

        local textHeight1 = reputationsText1:GetStringHeight()
        local textHeight2 = reputationsText2:GetStringHeight()
        local totalTextHeight = textHeight1 + textHeight2 + 10
        reputationsFrame:SetSize(baseFrameWidth, totalTextHeight)
    end

    reputationsFrame:SetScript("OnUpdate", function(self, elapsed)
        self.timeSinceLastUpdate = (self.timeSinceLastUpdate or 0) + elapsed
        if self.timeSinceLastUpdate >= 1.0 then
            UpdateReputations()
            self.timeSinceLastUpdate = 0
        end
    end)

    return reputationsFrame
end
function CreateCurrencyDisplay(baseFrame, baseFrameWidth, baseFrameHeight)
    local currencyIDs = {341, 301, 2711, 101}
    local currencyDisplay = CreateFrame("Frame", "ScyllaCurrencyDisplay", baseFrame)
    currencyDisplay:SetSize(baseFrameWidth, baseFrameHeight*0.95)
    currencyDisplay:SetPoint("TOP", baseFrame, "BOTTOM", 0, 0)
    local cdBG = currencyDisplay:CreateTexture(nil, "BACKGROUND")
    cdBG:SetAllPoints(currencyDisplay)
    cdBG:SetColorTexture(1, 0, 0, 0.5) -- RGBA for red with 50% opacity
    cdBG:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")

    local currencyTexts = {}
    local totalWidth = 0
    for i, currencyID in ipairs(currencyIDs) do
        local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
        
        -- Create a texture for the icon
        local currencyIcon = currencyDisplay:CreateTexture(nil, "OVERLAY")
        currencyIcon:SetSize(16, 16) -- Set the size of the icon
        currencyIcon:SetTexture(currencyInfo.iconFileID) -- Set the texture of the icon

        -- Create a font string for the amount
        local currencyDisplayText = currencyDisplay:CreateFontString(nil, "OVERLAY")
        currencyDisplayText:SetFontObject("GameFontHighlight")
        currencyDisplayText:SetText(currencyInfo.quantity)
        currencyDisplayText:Show()

        totalWidth = totalWidth + currencyIcon:GetWidth() + currencyDisplayText:GetStringWidth() + 5 -- 5 is the space between icon and text
        table.insert(currencyTexts, {icon = currencyIcon, text = currencyDisplayText})
    end

    local startX = (currencyDisplay:GetWidth() - totalWidth) / 2
    for i, currencyDisplayItem in ipairs(currencyTexts) do
        if i == 1 then
            currencyDisplayItem.icon:SetPoint("LEFT", currencyDisplay, "LEFT", startX, 0)
        else
            currencyDisplayItem.icon:SetPoint("LEFT", currencyTexts[i-1].text, "RIGHT", 5, 0)
        end
        currencyDisplayItem.text:SetPoint("LEFT", currencyDisplayItem.icon, "RIGHT", 5, 0)
    end

    local function UpdateCurrencyDisplay()
        for i, currencyID in ipairs(currencyIDs) do
            local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
            currencyTexts[i].text:SetText(currencyInfo.quantity)
        end
    end

    currencyDisplay:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
    currencyDisplay:SetScript("OnEvent", function(self, event, ...)
        if event == "CURRENCY_DISPLAY_UPDATE" then
            UpdateCurrencyDisplay()
        end
    end)

    UpdateCurrencyDisplay()

    return currencyDisplay
end
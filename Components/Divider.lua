function CreateDivider(parentFrame, width, height, text)
    local divider = CreateFrame("Frame", nil, parentFrame)
    divider:SetPoint("TOP", parentFrame, "BOTTOM", 0, 0)
    divider:SetWidth(width)
    divider:SetHeight(height*0.8)

    local title = divider:CreateFontString(nil, "OVERLAY")
    title:SetFontObject("GameFontHighlight")
    title:SetHeight(height*0.8)
    title:SetAllPoints(divider) -- Occupy the entire divider space
    title:SetText(text)
    
    local textBG = divider:CreateTexture(nil, "BACKGROUND")
    textBG:SetAllPoints(title)
    textBG:SetColorTexture(1, 0, 0, 0.5) -- RGBA for red with 50% opacity
    local bg = ApplyBG(divider)

    
    
    return divider
end
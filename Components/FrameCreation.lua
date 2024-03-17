function CreateBaseFrame()
    local baseFrame = CreateFrame("Frame", "DailyToDoFrame", UIParent)
    
    baseFrame:SetSize(GetScreenWidth() * 0.2, GetScreenHeight() * 0.03)
    local width = baseFrame:GetWidth()
    local height = baseFrame:GetHeight()
    baseFrame:SetPoint("CENTER")
    baseFrame:SetMovable(true)
    baseFrame:EnableMouse(true)
    baseFrame:RegisterForDrag("LeftButton")
    baseFrame:SetScript("OnDragStart", baseFrame.StartMoving)
    baseFrame:SetScript("OnDragStop", baseFrame.StopMovingOrSizing)
    
    -- Create the background
    local bg = baseFrame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints(baseFrame)
    bg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
    
    -- Add close button to the frame
    local close = CreateFrame("Button", "DailyToDoFrameCloseButton", baseFrame)
    -- close:SetSize(20, baseFrame:GetHeight() / 8)
    close:SetSize(20, GetScreenHeight() * 0.03)
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
    title:SetSize(width, height)
    title:SetFontObject("GameFontHighlightLarge")
    title:SetPoint("TOP", baseFrame, "TOP", 0, 0)
    -- title:SetText(UnitName("player").."'s Dailies")
    title:SetText("S C Y L L A")
    
    local borderBottom = CreateFrame("Frame", nil, baseFrame)
    borderBottom:SetPoint("BOTTOMLEFT", baseFrame, "BOTTOMLEFT")
    borderBottom:SetPoint("BOTTOMRIGHT", baseFrame, "BOTTOMRIGHT")
    borderBottom:SetHeight(1) -- 1 pixel tall

    local borderBottomBG = borderBottom:CreateTexture(nil, "BACKGROUND")
    borderBottomBG:SetAllPoints(borderBottom)
    borderBottomBG:SetColorTexture(0, 0, 0,0.5) -- RGB for black

    baseFrame:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            self:Hide()
            self:SetPropagateKeyboardInput(false)
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)
    baseFrame:SetPropagateKeyboardInput(true)

    return baseFrame, width, height
end

function ApplyBG(x)
    local bg = x:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints(x)
    bg:SetColorTexture(1, 0, 0, 0.5) -- RGBA for red with 50% opacity
    bg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
    return bg
end
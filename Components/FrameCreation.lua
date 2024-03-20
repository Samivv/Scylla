function CreateBaseFrame()
    local baseFrame = CreateFrame("Frame", "Scylla", UIParent)
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
    local close = CreateFrame("Button", "ScyllaCloseButton", baseFrame)
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
    titleBG:SetColorTexture(1, 0, 0, 0.5) -- RGBA for dark red with 50% opacity
    title:SetSize(width, height)
    title:SetFontObject("GameFontHighlightLarge")
    title:SetPoint("TOP", baseFrame, "TOP", 0, 0)
    -- title:SetText(UnitName("player").."'s Dailies")
    title:SetText("S C Y L L A")
    
    local borderBottom = CreateBorderBottom(baseFrame)

    baseFrame:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            print("|cFFFF0000[S C Y L L A]|r: Hiding frame. |cFFFF0000/scylla|r to show again")
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

-- add ccolor options to this {}
function CreateHoverableFrame(parent, width, height)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetSize(width, height)

    -- Create a texture for the background
    local bg = frame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(1, 1, 1, 0)  -- Set the initial background color to transparent

    -- Set the scripts for the hover effect
    frame:SetScript("OnEnter", function(self)
        bg:SetColorTexture(0, 0, 0, 1)  -- Change the background color to black on hover
    end)
    frame:SetScript("OnLeave", function(self)
        bg:SetColorTexture(1, 1, 1, 0)  -- Change the background color back to transparent when the mouse leaves
    end)

    return frame
end

--local frame = CreateHoverableFrame(ScyllaInstanceSectionFrame, frameWidth, frameHeight)


function CreateBorderBottom(baseFrame)
    local borderBottom = CreateFrame("Frame", nil, baseFrame)
    borderBottom:SetPoint("BOTTOMLEFT", baseFrame, "BOTTOMLEFT")
    borderBottom:SetPoint("BOTTOMRIGHT", baseFrame, "BOTTOMRIGHT")
    borderBottom:SetHeight(1) -- 1 pixel tall

    local borderBottomBG = borderBottom:CreateTexture(nil, "BACKGROUND")
    borderBottomBG:SetAllPoints(borderBottom)
    borderBottomBG:SetColorTexture(0, 0, 0,0.5) -- RGB for black

    return borderBottom
end
-- local borderBottom = CreateBorderBottom(myFrame)

-- Helper function to create a text label
function CreateTextLabel(parent, fontObject, text, width, point, relativeTo, relativePoint, offsetX, offsetY, textColor)
    local label = parent:CreateFontString(nil, "OVERLAY")
    label:SetFontObject(fontObject)
    label:SetText(text)
    label:SetWidth(width)
    label:SetPoint(point, relativeTo, relativePoint, offsetX, offsetY)
    label:SetTextColor(unpack(textColor))

    return label
end

function CreateLabelFrame(parentFrame, frameWidth, labels)
    -- Create a frame for the labels
    local labelFrame = CreateFrame("Frame", nil, parentFrame)
    labelFrame:SetSize(frameWidth, 30)  -- Set this to the desired height of the label frame
    labelFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 0, 0)
    local borderBottom = CreateBorderBottom(labelFrame)



    -- Create labels
    for i, labelText in ipairs(labels) do
        local label = CreateTextLabel(labelFrame, "GameFontHighlight", labelText, frameWidth / #labels, "LEFT", labelFrame, "LEFT", (i - 1) * frameWidth / #labels, 0, {1, 1, 1})
    end

    return labelFrame
end

--local labelTexts = {"Kills", "Name", "Difficulty"}
--local labelFrame = CreateLabelFrame(ScyllaInstanceSectionFrame, baseFrameWidth, labelTexts)



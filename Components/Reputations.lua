function CreateReputationsFrame(baseFrame, baseFrameWidth, baseFrameHeight)
    local trackedReputations = 
    {
        {name= "The Ashen Verdict", id=1156},
        {name= "Argent Crusade", id=1106},
        {name= "Kirin Tor", id=1090},
        {name= "The Wyrmrest Accord", id=1091},
        {name= "Knights of the Ebon Blade", id=1098},
        {name= "The Sons of Hodir", id=1119}
    }

    local reputationsFrame = CreateFrame("Frame", "ScyllaReputations", baseFrame)
    reputationsFrame:SetPoint("TOP", baseFrame, "BOTTOM", 0, 0)
    reputationsFrame:SetSize(baseFrameWidth, baseFrameHeight)
    
    local bg = ApplyBG(reputationsFrame)
    
    local frameWidth = reputationsFrame:GetWidth() / 3
    local frameHeight = 30  -- Set this to the desired height of each frame
    local frames = {}
    
    for index, item in ipairs(trackedReputations) do
        local frame = CreateHoverableFrame(reputationsFrame, frameWidth, frameHeight)
    
        local text1 = frame:CreateFontString(nil, "OVERLAY")
        text1:SetFontObject("AchievementDateFont")
        text1:SetText(item.name)
        text1:SetPoint("CENTER", frame, "CENTER", 0, frameHeight / 4) 
        text1:SetTextColor(1, 1, 1)  -- Set the text color to white
    
        local text2 = frame:CreateFontString(nil, "OVERLAY")
        text2:SetFontObject("AchievementDateFont")
        -- text2:SetText(item.id)
        text2:SetText("0/0")
        text2:SetPoint("CENTER", frame, "CENTER", 0, -frameHeight / 4)
        text2:SetTextColor(1, 1, 1)  -- Set the text color to white
        local row = math.floor((index - 1) / 3)
        local col = (index - 1) % 3
    
        if row == 0 and col == 0 then
            frame:SetPoint("TOPLEFT", reputationsFrame, "TOPLEFT", 0, 0)
        elseif row == 0 then
            frame:SetPoint("TOPLEFT", frames[index - 1], "TOPRIGHT", 0, 0)
        else
            frame:SetPoint("TOPLEFT", frames[index - 3], "BOTTOMLEFT", 0, 0)
        end
    
        table.insert(frames, frame)
    end
    
    reputationsFrame:SetHeight(frameHeight * math.ceil(#trackedReputations / 3))
    
    return reputationsFrame
end
-- Characterframe button for easy access
function CreateCFrameButton(baseFrame,width,height)
    local cfFrame = CreateFrame("Button", "ScyllaCharacterFrameButton", CharacterFrameTab5, "CharacterFrameTabButtonTemplate")
    --Right most tab of the character panel.
    cfFrame:SetPoint("LEFT", CharacterFrameTab5, "RIGHT", -15, -5)  -- Anchor to the right of CharacterFrameTab5
    -- Create a black background texture with transparency
    local text = cfFrame:CreateFontString(nil, "OVERLAY", "AchievementDateFont")
    text:SetPoint("CENTER", cfFrame)
    text:SetText("SCYLLA")
    text:SetPoint("CENTER", cfFrame, 0, 0)
    cfFrame:SetSize(width*0.1,height*0.9)

    -- cfFrame:SetScript("OnEnter", function ()
    --     background:SetColorTexture(1,1,1,0.5)
    -- end)
    -- cfFrame:SetScript("OnLeave", function ()
    --     background:SetColorTexture(0,0,0,0.5)
    -- end)

    cfFrame:SetScript("OnClick", function()
        if baseFrame:IsVisible() then
            baseFrame:Hide()
        else
            baseFrame:Show()
        end
    end)
end
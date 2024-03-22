-- Characterframe button for easy access
function CreateCFrameButton(baseFrame,width,height)
    local cfFrame = CreateFrame("Button", "ScyllaCharacterFrameButton", CharacterFrameTab5, "CharacterFrameTabButtonTemplate")
    --Right most tab of the character panel.
    cfFrame:SetPoint("LEFT", CharacterFrameTab5, "RIGHT", -20, 0)  -- Anchor to the right of CharacterFrameTab5

    local text = cfFrame:CreateFontString(nil, "OVERLAY", "AchievementDateFont")
    text:SetPoint("CENTER", cfFrame)
    text:SetText("SCYLLA")
    text:SetPoint("CENTER", cfFrame, 0, 0)
    cfFrame:SetSize(width*0.1,height*0.9)

    cfFrame:SetScript("OnClick", function()
        if baseFrame:IsVisible() then
            baseFrame:Hide()
        else
            baseFrame:Show()
        end
    end)
end
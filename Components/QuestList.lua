function CreateQuestList(baseFrame, baseFrameWidth, baseFrameHeight)
    local questIDList = {78752, 78753, 24584}
    local questList = {"Daily Gamma", "Daily HC", "Weekly"}
    local labelTexts = {"Completed", "Name", "IsOnQuest?"}
    local margin = 10

    local ScyllaQuestsSectionFrame = CreateFrame("Frame", "ScyllaQuestsSectionFrame", baseFrame)
    ScyllaQuestsSectionFrame:SetWidth(baseFrameWidth)
    ScyllaQuestsSectionFrame:SetPoint("TOP", baseFrame, "BOTTOM", 0, 0)
    local ISCFBG = ApplyBG(ScyllaQuestsSectionFrame)
    -- Create a frame for the labels
    local labelFrame = CreateLabelFrame(ScyllaQuestsSectionFrame, baseFrameWidth, labelTexts)
    -- Create a table to store the quest frames
    local questFrames = {}
    -- Create a frame for each quest
    for i, quest in ipairs(questList) do
        local questFrame = CreateFrame("Frame", "ScyllaQuestFrame"..i, baseFrame)
        questFrame:SetSize(baseFrameWidth, 30) -- Set this to the desired height of the quest frame
        if i == 1 then
            questFrame:SetPoint("TOPLEFT", labelFrame, "BOTTOMLEFT", 0, 0) -- Position the first quest frame below the label frame
        else
            questFrame:SetPoint("TOPLEFT", getglobal("ScyllaQuestFrame"..(i-1)), "BOTTOMLEFT", 0, 0) -- Position the other quest frames below the previous quest frame
        end
    
        -- Create a texture for the quest frame
        local bgTexture = questFrame:CreateTexture(nil, "BACKGROUND")
        bgTexture:SetAllPoints(questFrame)
        -- Create the quest status label
        local statusLabel = questFrame:CreateFontString(nil, "OVERLAY")
        statusLabel:SetFontObject("GameFontHighlight")
        statusLabel:SetText(C_QuestLog.IsQuestFlaggedCompleted(questIDList[i]) and "+" or "-")
        statusLabel:SetWidth(baseFrameWidth / 3)
        statusLabel:SetPoint("CENTER", questFrame, "CENTER", -(baseFrameWidth / 3), 0) -- Position it at the center of the quest frame
        statusLabel:SetTextColor(1, 1, 1)  -- Set the text color to white

        -- Create the quest name label
        local nameLabel = questFrame:CreateFontString(nil, "OVERLAY")
        nameLabel:SetFontObject("GameFontHighlight")
        nameLabel:SetText(quest)
        nameLabel:SetWidth(baseFrameWidth / 3)
        nameLabel:SetPoint("CENTER", questFrame, "CENTER", 0, 0) -- Position it at the center of the quest frame
        nameLabel:SetTextColor(1, 1, 1)  -- Set the text color to white

        -- Create the quest active label
        local activeLabel = questFrame:CreateFontString(nil, "OVERLAY")
        activeLabel:SetFontObject("GameFontHighlight")
        activeLabel:SetText(C_QuestLog.IsOnQuest(questIDList[i]) and "Yes" or "No")
        activeLabel:SetWidth(baseFrameWidth / 3)
        activeLabel:SetPoint("CENTER", questFrame, "CENTER", baseFrameWidth / 3, 0) -- Position it at the center of the quest frame
        activeLabel:SetTextColor(1, 1, 1)  -- Set the text color to white
            
        ScyllaQuestsSectionFrame:SetHeight(ScyllaQuestsSectionFrame:GetHeight()+questFrame:GetHeight()+margin)
        questFrames[i] = {
            frame = questFrame,
            statusLabel = statusLabel,
            nameLabel = nameLabel,
            activeLabel = activeLabel,
            bgTexture = bgTexture
        }
    end
    function UpdateQuests()
        for i, questData in ipairs(questFrames) do
            local isCompleted = C_QuestLog.IsQuestFlaggedCompleted(questIDList[i])
            local isOnQuest = C_QuestLog.IsOnQuest(questIDList[i])
    
            questData.statusLabel:SetText(C_QuestLog.IsQuestFlaggedCompleted(questIDList[i]) and "Yes" or "No")
            questData.nameLabel:SetText(questList[i])
            questData.activeLabel:SetText(C_QuestLog.IsOnQuest(questIDList[i]) and "Yes" or "-")
            -- Change the color of the quest frame based on the quest status
            questFrames[i].frame:SetScript("OnEnter", function()
                if isCompleted then
                    questFrames[i].bgTexture:SetColorTexture(0, 1, 0, 0.5) -- Green for completed quests
                elseif isOnQuest then
                    questFrames[i].bgTexture:SetColorTexture(1, 1, 0, 0.5) -- Yellow for active quests
                else
                    questFrames[i].bgTexture:SetColorTexture(1, 0, 0, 0.7) -- Red for not completed or not active quests
                end
            end)
                
            questFrames[i].frame:SetScript("OnLeave", function()
                questFrames[i].bgTexture:SetColorTexture(0, 0, 0, 0) -- Reset to default color
            end)
        end
    end

    ScyllaQuestsSectionFrame:RegisterEvent("QUEST_LOG_UPDATE")

    -- Create an event handler function
    ScyllaQuestsSectionFrame:SetScript("OnEvent", function(self, event)
        if event == "QUEST_LOG_UPDATE" then
            -- Update the quests
            UpdateQuests()
        end
    end)

    UpdateQuests()
    return ScyllaQuestsSectionFrame
end
-- Create the quest list
function CreateQuestList(baseFrame)
    local questIDList = {78752, 78753, 24584}
    local questList = {"Daily Gamma", "Daily HC", "Weekly"}
    
    for index, questID in ipairs(questIDList) do
        if C_QuestLog.IsOnQuest(questID) then
            questList[index] = questList[index] .. " - "..GetQuestLink(questIDList[index]).." |cFF00FF00(You are on this quest)|r"
        end
    end
    
    local checkboxes = {}
    
    for i, quest in ipairs(questList) do
        local checkbox = CreateFrame("CheckButton", "DailyToDoFrameQuest"..i, baseFrame, "UICheckButtonTemplate")
        checkbox:SetPoint("TOPLEFT", 0, -30 * i)
        local checkboxText = getglobal(checkbox:GetName() .. 'Text')
        checkboxText:SetText(quest)
        checkbox:EnableMouse(false)

        -- Create the custom checkbox appearance
        local checkboxTexture = checkbox:CreateTexture(nil, "ARTWORK")
        checkboxTexture:SetAllPoints()
        checkboxTexture:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
        checkboxTexture:SetTexCoord(0, 1, 0, 1)
        checkboxTexture:SetDesaturated(true)
        checkboxTexture:SetVertexColor(1, 0, 0) -- Set white color
        
        checkbox:SetCheckedTexture(checkboxTexture)
        checkbox:SetDisabledCheckedTexture(checkboxTexture)
        
        local function UpdateCheckbox()
            local isCompleted = C_QuestLog.IsQuestFlaggedCompleted(questIDList[i])
            checkbox:SetChecked(isCompleted)
            if isCompleted then
                checkboxText:SetTextColor(1, 1, 1) -- Set white color
                checkboxText:SetText(questList[i])
            else
                checkboxText:SetTextColor(1, 0, 0) -- RGB for red
            end
        end

        checkbox:RegisterEvent("QUEST_TURNED_IN")
        checkbox:SetScript("OnEvent", function(self, event, ...)
            if event == "QUEST_TURNED_IN" then
                UpdateCheckbox()
            end
        end)

        UpdateCheckbox()
        checkboxes[i] = checkbox
    end
    
    return checkboxes
end
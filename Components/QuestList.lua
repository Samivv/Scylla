function CreateQuestList(baseFrame,baseFrameWidth, baseFrameHeight)
    local questIDList = {78752, 78753, 24584}
    local questList = {"Daily Gamma", "Daily HC", "Weekly"}
    local checkboxes = {}

    local checkboxFrame = CreateFrame("Frame", "ScyllaQuestList", baseFrame)
    checkboxFrame:SetWidth(baseFrameWidth)
    checkboxFrame:SetPoint("TOP", baseFrame, "BOTTOM", 0, 0)
    local checkboxBG = checkboxFrame:CreateTexture(nil, "BACKGROUND")
    checkboxBG:SetAllPoints(checkboxFrame)
    checkboxBG:SetColorTexture(1, 0, 0, 0.5) -- RGBA for red with 50% opacity
    checkboxBG:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")

    

    for i, quest in ipairs(questList) do
        local checkbox = CreateFrame("CheckButton", "ScyllaQuest"..i, checkboxFrame, "UICheckButtonTemplate") -- Parent the checkbox to checkboxFrame
        if i == 1 then
            checkbox:SetPoint("TOPLEFT", checkboxFrame, "TOPLEFT", 0, 0) -- Position the first checkbox at the top left corner of checkboxFrame
        else
            checkbox:SetPoint("TOPLEFT", checkboxes[i-1], "BOTTOMLEFT", 0, 0) -- Position the other checkboxes below the previous checkbox
        end
        local checkboxText = getglobal(checkbox:GetName() .. 'Text')
        checkboxText:SetText(quest)
        checkbox:EnableMouse(false)

        -- dynamic scaling
        checkboxFrame:SetHeight(checkboxFrame:GetHeight() + checkbox:GetHeight())

        -- Create the custom checkbox appearance
        local checkboxTexture = checkbox:CreateTexture(nil, "ARTWORK")
        checkboxTexture:SetAllPoints()
        checkboxTexture:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
        checkboxTexture:SetTexCoord(0, 1, 0, 1)
        checkboxTexture:SetDesaturated(true)
        checkboxTexture:SetVertexColor(1, 0, 0) -- Set red color
        
        checkbox:SetCheckedTexture(checkboxTexture)
        checkbox:SetDisabledCheckedTexture(checkboxTexture)
        
        -- Create a new FontString for the quest status
        local statusText = checkbox:CreateFontString(nil, "OVERLAY")
        statusText:SetFontObject("GameFontHighlight")
        statusText:SetPoint("LEFT", checkboxText, "RIGHT", 10, 0) -- Position it to the right of the checkbox

        local function UpdateCheckbox()
            local isCompleted = C_QuestLog.IsQuestFlaggedCompleted(questIDList[i])
            checkbox:SetChecked(isCompleted)
            if isCompleted then
                checkboxText:SetTextColor(1, 1, 1) -- Set white color
                statusText:SetText("") -- Clear the status text
            else
                checkboxText:SetTextColor(1, 0, 0) -- RGB for red
                if C_QuestLog.IsOnQuest(questIDList[i]) then
                    statusText:SetText("|cFF00FF00(You are on this quest)|r") -- Set the status text
                elseif not C_QuestLog.IsQuestFlaggedCompleted(questIDList[i]) and not C_QuestLog.IsOnQuest(questIDList[i]) then
                    statusText:SetText("|cFFFF0000(PICK UP THE QUEST!)|r") -- Set the status text
                else
                    statusText:SetText("") -- Clear the status text
                end
            end
        end

        checkbox:RegisterEvent("QUEST_LOG_UPDATE")
        checkbox:SetScript("OnEvent", function(self, event, ...)
            if event == "QUEST_LOG_UPDATE" then
                UpdateCheckbox()
            end
        end)

        UpdateCheckbox()
        checkboxes[i] = checkbox
    end
    
    return checkboxFrame -- Return the frame that holds the checkboxes
end
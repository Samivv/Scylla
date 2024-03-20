-- Create the instance section
function CreateInstanceSection(baseFrame, baseFrameWidth, baseFrameHeight)
    -- Create a new frame for the instance section
    local ScyllaInstanceSectionFrame = CreateFrame("Frame", "ScyllaScyllaInstanceSection", baseFrame)
    ScyllaInstanceSectionFrame:SetWidth(baseFrameWidth)
    ScyllaInstanceSectionFrame:SetPoint("TOP", baseFrame, "BOTTOM", 0, 0)

    local ISCFBG = ApplyBG(ScyllaInstanceSectionFrame)

    local instanceInfo = {}

    local labelTexts = {"Kills", "Name", "Difficulty"}
    local labelFrame = CreateLabelFrame(ScyllaInstanceSectionFrame, baseFrameWidth, labelTexts)
    
    
    local noInstancesText = ScyllaInstanceSectionFrame:CreateFontString(nil, "OVERLAY")
    noInstancesText:SetFontObject("GameFontHighlight")
    noInstancesText:SetText("No lockouts")
    noInstancesText:SetPoint("CENTER", ScyllaInstanceSectionFrame, "CENTER", 0, 0)
    noInstancesText:SetTextColor(1, 1, 1)  -- Set the text color to white

    local frames = {}
    local texts = {}

    local function UpdateInstanceSection()
        local numInstances = GetNumSavedInstances()
        local margin = 10
        local totalTextHeight = 0
        local frameWidth = ScyllaInstanceSectionFrame:GetWidth()
        local sectionWidth = frameWidth / 3
        local frameHeight = 30  -- Set this to the desired height of each frame

        -- Hide all frames and text labels
        for _, frame in ipairs(frames) do
            frame:Hide()
        end
        for _, text in ipairs(texts) do
            text:SetText("")
        end

        if numInstances > 0 then
            labelFrame:Show()
            for index = 1, numInstances do
                local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(index)
                instanceInfo[index] = {
                    name = name,
                    difficulty = difficultyName,
                    isRaid = isRaid,
                    locked = locked,
                    numEncounters = numEncounters,
                    encounterProgress = encounterProgress
                }

                -- Reuse or create a new frame
                local frame = frames[index]
                if not frame then
                    frame = CreateHoverableFrame(ScyllaInstanceSectionFrame, frameWidth, frameHeight)
                    table.insert(frames, frame)
                end
                frame:Show()

                -- Reuse or create new text labels
                local text1 = texts[index * 3 - 2]
                if not text1 then
                    text1 = CreateTextLabel(frame, "GameFontHighlight", "", sectionWidth, "LEFT", frame, "LEFT", 0, 0, {1, 1, 1})
                    table.insert(texts, text1)
                end
                text1:SetText(instanceInfo[index].encounterProgress.."/"..instanceInfo[index].numEncounters)
                text1:Show()

                local text2 = texts[index * 3 - 1]
                if not text2 then
                    text2 = CreateTextLabel(frame, "GameFontHighlight", "", sectionWidth, "LEFT", text1, "RIGHT", 0, 0, {1, 1, 1})
                    table.insert(texts, text2)
                end
                text2:SetText(instanceInfo[index].name)
                text2:Show()

                local text3 = texts[index * 3]
                if not text3 then
                    text3 = CreateTextLabel(frame, "GameFontHighlight", "", sectionWidth, "LEFT", text2, "RIGHT", 0, 0, {1, 1, 1})
                    table.insert(texts, text3)
                end
                text3:SetText(instanceInfo[index].difficulty)
                text3:Show()

                frame:SetPoint("TOPLEFT", labelFrame, "BOTTOMLEFT", 0, -totalTextHeight)
                noInstancesText:Hide()
                totalTextHeight = totalTextHeight + frameHeight
            end
        else
            -- If there are no instances, display a message
            labelFrame:Hide()
            noInstancesText:Show()
        end
        ScyllaInstanceSectionFrame:SetHeight(totalTextHeight +30)
    end

    ScyllaInstanceSectionFrame:RegisterEvent("UPDATE_INSTANCE_INFO")
    ScyllaInstanceSectionFrame:RegisterEvent("ENCOUNTER_END")
    ScyllaInstanceSectionFrame:SetScript("OnEvent", function(self, event, ...)
        if event == "UPDATE_INSTANCE_INFO" then
            UpdateInstanceSection()
        elseif event == "ENCOUNTER_END" then
            -- Request updated instance information after a boss kill
            RequestRaidInfo()
        end
    end)

    UpdateInstanceSection()
    return ScyllaInstanceSectionFrame
end



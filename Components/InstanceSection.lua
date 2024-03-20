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

    local function UpdateInstanceSection()
        local numInstances = GetNumSavedInstances()
        local margin = 10
        local totalTextHeight = 0
        local frameWidth = ScyllaInstanceSectionFrame:GetWidth()
        local sectionWidth = frameWidth / 3
        local frameHeight = 30  -- Set this to the desired height of each frame
        local frames = {}

        for _, frame in ipairs(frames) do
            frame:Hide()
        end
        wipe(frames)



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
                local frame = CreateHoverableFrame(ScyllaInstanceSectionFrame, frameWidth, frameHeight)

                local text1 = CreateTextLabel(frame, "GameFontHighlight", instanceInfo[index].encounterProgress.."/"..instanceInfo[index].numEncounters, sectionWidth, "LEFT", frame, "LEFT", 0, 0, {1, 1, 1})
                local text2 = CreateTextLabel(frame, "GameFontHighlight", instanceInfo[index].name, sectionWidth, "LEFT", text1, "RIGHT", 0, 0, {1, 1, 1})
                local text3 = CreateTextLabel(frame, "GameFontHighlight", instanceInfo[index].difficulty, sectionWidth, "LEFT", text2, "RIGHT", 0, 0, {1, 1, 1})
            
                text3:SetTextColor(1, 1, 1)  -- Set the text color to white

                --Help clearing the text on update.
                table.insert(frames, text1)
                table.insert(frames, text2)
                table.insert(frames, text3)


                frame:SetPoint("TOPLEFT", labelFrame, "BOTTOMLEFT", 0, -totalTextHeight)
                noInstancesText:Hide()
                table.insert(frames, frame)
                totalTextHeight = totalTextHeight + frameHeight
        end
        else
            -- If there are no instances, display a message
            labelFrame:Hide()
            noInstancesText:Show()
        end
        ScyllaInstanceSectionFrame:SetHeight(totalTextHeight + 2 * margin+30)
    end

    baseFrame:RegisterEvent("UPDATE_INSTANCE_INFO")
    baseFrame:SetScript("OnEvent", function(self, event, ...)
        if event == "UPDATE_INSTANCE_INFO" then
            UpdateInstanceSection()
        end
    end)

    UpdateInstanceSection()
    return ScyllaInstanceSectionFrame
end



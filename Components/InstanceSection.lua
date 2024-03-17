-- Create the instance section
function CreateInstanceSection(baseFrame, baseFrameWidth, baseFrameHeight)
    -- Create a new frame for the instance section
    local instanceSectionFrame = CreateFrame("Frame", "InstanceSectionFrame", baseFrame)
    instanceSectionFrame:SetWidth(baseFrameWidth)
    instanceSectionFrame:SetPoint("TOP", baseFrame, "BOTTOM", 0, 0)

    local ISCFBG = ApplyBG(instanceSectionFrame)

    local instanceInfo = {}
    local instanceTexts = {}

    local function UpdateInstanceSection()
        local numInstances = GetNumSavedInstances()
        local margin = 10
        local totalTextHeight = 0

        if numInstances == 0 then
            local instanceText = instanceSectionFrame:CreateFontString(nil, "OVERLAY")
            instanceText:SetFontObject("GameFontHighlight")
            instanceText:SetPoint("TOP", instanceSectionFrame, "TOP", 0, -margin) -- Position the text with top margin
            instanceText:SetText("No locked instances")
            instanceText:Show()
            totalTextHeight = instanceText:GetStringHeight() -- Update the total text height
        end

        for _, text in ipairs(instanceTexts) do
            text:Hide()
        end
        wipe(instanceTexts)

        if numInstances > 0 then
            for index = 1, numInstances do
                local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(index)
                instanceInfo[index] = {
                    name = name,
                    difficulty = difficultyName,
                    isRaid = isRaid,
                    locked = locked
                }

                local instanceText = instanceSectionFrame:CreateFontString(nil, "OVERLAY")
                instanceText:SetFontObject("GameFontHighlight")
                instanceText:SetPoint("TOP", instanceSectionFrame, "TOP", 0, -totalTextHeight - margin) -- Position the text below the previous one
                instanceText:SetText(instanceInfo[index].name .. " - " .. instanceInfo[index].difficulty)
                instanceText:Show()
    
                
                table.insert(instanceTexts, instanceText)
                totalTextHeight = totalTextHeight + instanceText:GetStringHeight()
            end
        end
        instanceSectionFrame:SetHeight(totalTextHeight + 2 * margin)
    end

    baseFrame:RegisterEvent("UPDATE_INSTANCE_INFO")
    baseFrame:SetScript("OnEvent", function(self, event, ...)
        if event == "UPDATE_INSTANCE_INFO" then
            UpdateInstanceSection()
            print("updated instances")
        end
    end)

    UpdateInstanceSection()
    return instanceSectionFrame
end



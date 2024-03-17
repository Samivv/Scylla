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

        if numInstances == 0 then
            local instanceText = instanceSectionFrame:CreateFontString(nil, "OVERLAY")
            instanceText:SetFontObject("GameFontHighlight")
            instanceText:SetPoint("TOP", instanceSectionFrame, "TOP", 0, 0)
            instanceText:SetText("No locked instances")
            instanceText:Show()
            instanceSectionFrame:SetHeight(instanceText:GetHeight() + 10)
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
                instanceText:SetPoint("TOP", instanceSectionFrame, "TOP", 0, -15 * (index - 1))
                instanceText:SetText(instanceInfo[index].name .. " - " .. instanceInfo[index].difficulty)
                instanceText:Show()

                table.insert(instanceTexts, instanceText)
                instanceSectionFrame:SetHeight(#instanceTexts * instanceText:GetHeight() + 10)
            end
        end
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



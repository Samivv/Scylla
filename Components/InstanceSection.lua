-- Create the instance section
function CreateInstanceSection(baseFrame)
    local instanceSectionTitle = baseFrame:CreateFontString(nil, "OVERLAY")
    instanceSectionTitle:SetFontObject("GameFontHighlight")
    instanceSectionTitle:SetPoint("TOP", baseFrame, "BOTTOM", 0, baseFrame:GetHeight()/2)
    instanceSectionTitle:SetWidth(baseFrame:GetWidth())
    instanceSectionTitle:SetHeight(baseFrame:GetHeight()*0.1)
    local instanceSection = baseFrame:CreateFontString(nil, "OVERLAY")
    instanceSection:SetFontObject("GameFontHighlight")
    instanceSection:SetPoint("TOP", instanceSectionTitle, "BOTTOM", 0, 0)
    instanceSection:SetWidth(baseFrame:GetWidth())

    local instanceBG = baseFrame:CreateTexture(nil, "BACKGROUND")
    instanceBG:SetAllPoints(instanceSectionTitle)
    instanceBG:SetColorTexture(1, 0, 0, 0.5) -- RGBA for black with 50% opacity
    local instanceInfo = {}
    local instanceTexts = {}

    local function UpdateInstanceSection()
        local numInstances = GetNumSavedInstances()

        if numInstances > 0 then
            instanceSectionTitle:SetText("Locked Instances")
        else
            instanceSectionTitle:SetText("No locked instances")
        end

        -- Remove old instance texts
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

                -- Create a new FontString for this instance
                local instanceText = baseFrame:CreateFontString(nil, "OVERLAY")
                instanceText:SetFontObject("GameFontHighlight")
                instanceText:SetPoint("TOP", instanceSection, "BOTTOM", 0, -15 * (index - 1)) -- Position it below the previous instance
                instanceText:SetText(instanceInfo[index].name .. " - " .. instanceInfo[index].difficulty)
                instanceText:Show()

                table.insert(instanceTexts, instanceText)
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
end

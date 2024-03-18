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

                local text1 = frame:CreateFontString(nil, "OVERLAY")
                text1:SetFontObject("GameFontHighlight")
                text1:SetText(instanceInfo[index].encounterProgress.."/"..instanceInfo[index].numEncounters)
                text1:SetWidth(sectionWidth)
                text1:SetPoint("LEFT", frame, "LEFT", 0, 0) 
                text1:SetTextColor(1, 1, 1)  -- Set the text color to white

                local text2 = frame:CreateFontString(nil, "OVERLAY")
                text2:SetFontObject("GameFontHighlight")
                text2:SetText(instanceInfo[index].name)
                text2:SetWidth(sectionWidth)
                text2:SetPoint("LEFT", text1, "RIGHT", 0, 0)
                text2:SetTextColor(1, 1, 1)  -- Set the text color to white

                local text3 = frame:CreateFontString(nil, "OVERLAY")
                text3:SetFontObject("GameFontHighlight")
                text3:SetText(instanceInfo[index].difficulty)
                text3:SetWidth(sectionWidth)
                text3:SetPoint("LEFT", text2, "RIGHT", 0, 0)
                text3:SetTextColor(1, 1, 1)  -- Set the text color to white

                frame:SetPoint("TOPLEFT", labelFrame, "BOTTOMLEFT", 0, -totalTextHeight)

                table.insert(frames, frame)
                totalTextHeight = totalTextHeight + frameHeight
            end
        end
        ScyllaInstanceSectionFrame:SetHeight(totalTextHeight + 2 * margin+30)
    end

    baseFrame:RegisterEvent("UPDATE_INSTANCE_INFO")
    baseFrame:SetScript("OnEvent", function(self, event, ...)
        if event == "UPDATE_INSTANCE_INFO" then
            UpdateInstanceSection()
            print("updated instances")
        end
    end)

    UpdateInstanceSection()
    return ScyllaInstanceSectionFrame
end



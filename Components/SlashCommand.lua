-- Create the slash command
function CreateSlashCommand(baseFrame)
    SLASH_SCYLLA1 = "/scylla"
    SlashCmdList["SCYLLA"] = function(msg)
        if baseFrame:IsShown() then
            baseFrame:Hide()
        else
            baseFrame:Show()
        end
    end
end
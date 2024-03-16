-- Create the slash command
function CreateSlashCommand(baseFrame)
    SLASH_DAILY1 = "/daily"
    SlashCmdList["DAILY"] = function(msg)
        if baseFrame:IsShown() then
            baseFrame:Hide()
        else
            baseFrame:Show()
        end
    end
end
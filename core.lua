function Main()
  local status, err = pcall(function()
    local baseFrame,width,height = CreateBaseFrame()
    local dockerFrame1 = CreateDivider(baseFrame, width, height,"Quests")
    local QuestList = CreateQuestList(dockerFrame1,width,height)
    local dockerFrame2 = CreateDivider(QuestList, width, height,"Instance lockouts")
    local instanceSection = CreateInstanceSection(dockerFrame2,width,height)
    local dockerFrame4 = CreateDivider(instanceSection, width, height,"Reputations")
    local reputationFrame = CreateReputationsFrame(dockerFrame4,width,height)
    local footer = CreateFooter(reputationFrame,width,height)
    local currencyDisplay = CreateCurrencyDisplay(footer,width,height)
    CreateSlashCommand(baseFrame)
  end)

  if not status then
    print("Error occurred: ", err)
  end
end


-- run main after UPDATE_INSTANCE_INFO
local frame = CreateFrame("FRAME", "ScyllaFrame")
frame:RegisterEvent("UPDATE_INSTANCE_INFO")
frame:SetScript("OnEvent", function(self, event)
  if event == "UPDATE_INSTANCE_INFO" then
    Main()
    frame:UnregisterEvent("UPDATE_INSTANCE_INFO")
  end
end)

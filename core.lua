function Main()
  local baseFrame,width,height = CreateBaseFrame()
  local QuestList = CreateQuestList(baseFrame,width,height)
  local dockerFrame2 = CreateDivider(QuestList, width, height,"Instance lockouts")
  local instanceSection = CreateInstanceSection(dockerFrame2,width,height)
  local footer = CreateFooter(instanceSection,width,height)
  local currencyDisplay = CreateCurrencyDisplay(footer,width,height)
  -- local dockerFrame4 = CreateDivider(footer, width, height,"Currency Display")
  CreateSlashCommand(baseFrame)
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

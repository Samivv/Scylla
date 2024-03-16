function Main()
  local baseFrame = CreateBaseFrame()
  local checkboxes = CreateQuestList(baseFrame)
  CreateInstanceSection(baseFrame)
  CreateSlashCommand(baseFrame)
  CreateFooter(baseFrame)
  CreateCurrencyDisplay(baseFrame)
end

-- run main after UPDATE_INSTANCE_INFO
local frame = CreateFrame("FRAME", "DailyToDoFrameFrame")
frame:RegisterEvent("UPDATE_INSTANCE_INFO")
frame:SetScript("OnEvent", function(self, event)
  if event == "UPDATE_INSTANCE_INFO" then
    Main()
    frame:UnregisterEvent("UPDATE_INSTANCE_INFO")
  end
end)

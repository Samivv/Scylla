function Main()
  local baseFrame,width,height = CreateBaseFrame()
  local mF1 = CreateDivider(baseFrame, width, height,"Quests")
  local QL = CreateQuestList(mF1,width,height)
  local mF2 = CreateDivider(QL, width, height,"Instance lockouts")
  local IS = CreateInstanceSection(mF2,width,height)
  local mF3 = CreateDivider(IS, width, height,"Footer")
  local F = CreateFooter(mF3,width,height)
  local mF4 = CreateDivider(F, width, height,"Currency Display")
  local CD = CreateCurrencyDisplay(mF4,width,height)
  CreateSlashCommand(baseFrame)
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

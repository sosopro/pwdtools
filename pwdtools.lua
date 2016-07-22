-- 游戏内小功能
-- 2016.6.3  主要测试SlashCmdList
-- reloadui
-- 2016.7.21 加入github 

-- 配置开关
local cfgBool			= true		-- true 显示runeframe，false则否
local DkRuneFrameHide	= true		-- false隐藏dk符文条，true显示	 
local cfgAction 		= false		-- true 技能条变红，false则否，bt4无用

-- 配置开关 

SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"

-- 隐藏dk符文条
local frame = CreateFrame("Frame",nil,UIParent)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

function frame:OnUpdate()
		 local class, classFileName = UnitClass("player")
		 
		 
		 -- 角色显示
		 local color = RAID_CLASS_COLORS[classFileName]
		 ChatFrame4:AddMessage(class, color.r, color.g, color.b)	
		 ChatFrame4:AddMessage(classFileName, color.r, color.g, color.b)
		 
		 -- dk RuneFrame
		 if (cfgBool == true and RuneFrame) then
			parent = RuneFrame:GetParent()
			RuneFrame:ClearAllPoints()
			-- 以头像为锚点
			-- RuneFrame:SetPoint("TOP", parent, "center", 30, 60) 
			-- 以屏幕为锚点
			RuneFrame:SetPoint("center",WORLDFRAME,"center",0,-160)
			RuneFrame:SetScale(1.3)
		 end
		 if (RuneFrame and DkRuneFrameHide == false) then
			RuneFrame:Hide()
		 end
		 
end
frame:SetScript("OnEvent",frame.OnUpdate)




--[超出距离技能栏变红，若用bt4等动作条，无效]

if cfgAction == true then 
	hooksecurefunc("ActionButton_OnUpdate", function(self, elapsed) 
	   if ( self.rangeTimer == TOOLTIP_UPDATE_TIME and self.action) then 
		  local range = false 
		  if ( IsActionInRange(self.action) == false ) then 
			 getglobal(self:GetName().."Icon"):SetVertexColor(1, 0, 0) 
			 getglobal(self:GetName().."NormalTexture"):SetVertexColor(1, 0, 0) 
			 range = true 
		  end
		  if ( self.range ~= range and range == false ) then 
			 ActionButton_UpdateUsable(self) 
		  end
		  self.range = range 
	   end 
	end)
end
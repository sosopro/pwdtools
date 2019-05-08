-- 游戏内小功能
-- 2016.6.3  主要测试SlashCmdList
-- reloadui
-- 2016.7.21 加入github 

-- 配置开关

local cfgAction             = true -- true 技能条变红，false则否，bt4无用

-- 配置开关 

SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"


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



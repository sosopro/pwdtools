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
		 -- 70000 nameplate
		SetCVar("ShowClassColorInNameplate", 1) 
			--名條寬高設定：預設是1，啟用大型名條後，預設是是1.39寬2.7高 
			--數值可以自訂，如下例：改成1寬3高 
		SetCVar("NamePlateHorizontalScale", 1) 
		SetCVar("NamePlateVerticalScale", 3) 
			--#顯示名條的最遠距離：legion默認是60，以前是40；60太遠了，容易干擾畫面 
		SetCVar("nameplateMaxDistance", 40)
				--不讓名條貼邊 
		SetCVar("nameplateOtherTopInset", -1) 
		SetCVar("nameplateOtherBottomInset", -1)
			--*新的浮動戰鬥文字運動方式，1往上2往下3弧形 
		SetCVar("floatingCombatTextFloatMode", 3) 
				--舊的動戰鬥文字運動方式，0關；使用這項，浮動戰鬥文字就會垂直往上，如同過去 
			--SetCVar("floatingCombatTextCombatDamageDirectionalScale", 0) 

			--[[ 如果要關閉浮動戰鬥文字只要使用這兩項 ]]-- 

			--對目標傷害，0關；如果要關閉傷害數字，使用這項 
		SetCVar("floatingCombatTextCombatDamage", 1)   
			--對目標治療，0關；如果要關閉治療數字，使用這項 
		SetCVar("floatingCombatTextCombatHealing", 1) 

			--[[ 如果要調整細部(以前的子項目)再使用這些 0=關 1=開 ]]-- 

			--寵物對目標傷害 
		SetCVar("floatingCombatTextPetMeleeDamage", 1) 
		SetCVar("floatingCombatTextPetSpellDamage", 1) 
			--目標盾提示 
		SetCVar("floatingCombatTextCombatHealingAbsorbTarget", 1) 
			--自身得盾/護甲提示 
		SetCVar("floatingCombatTextCombatHealingAbsorbSelf", 1) 

			--[[ 進階設定自己的浮動戰鬥文字 ]]-- 
			--*閃招 
		SetCVar("floatingCombatTextDodgeParryMiss", 1) 
			--*傷害減免   
		SetCVar("floatingCombatTextDamageReduction", 1) 
			--周期性傷害 
		SetCVar("floatingCombatTextCombatLogPeriodicSpells", 1) 
			--*法術警示 
		SetCVar("floatingCombatTextReactives", 1) 
			--他人的糾纏效果(例如 誘補(xxxx-xxxx)) 
		SetCVar("floatingCombatTextSpellMechanics", 1) 
			--*聲望變化 
		SetCVar("floatingCombatTextRepChanges", 1) 
			--*友方治療者名稱 
		SetCVar("floatingCombatTextFriendlyHealers", 0) 
			--*進入/離開戰鬥文字提示 
		SetCVar("floatingCombatTextCombatState", 1) 
			--*低MP/低HP文字提示，預設是1開 
		SetCVar("floatingCombatTextLowManaHealth", 1)   
			--*連擊點 
		SetCVar("floatingCombatTextComboPoints", 1) 
			--*能量獲得 
		SetCVar("floatingCombatTextEnergyGains", 1) 
			--*周期性能量   
		SetCVar("floatingCombatTextPeriodicEnergyGains", 1) 
			--*榮譽擊殺 
		SetCVar("floatingCombatTextHonorGains", 1) 
			--*光環 
		SetCVar("floatingCombatTextAuras", 1)
			-- 战斗文字放大 默认为0
		SetCVar("floatingCombatTextCombatDamageDirectionalScale",1)


		 
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
local ImageButton = require "widgets/imagebutton"
local PopupDialogScreen = require "screens/redux/popupdialog"

local function SendCommand(fnstr)
	local x, _, z = TheSim:ProjectScreenPos(TheSim:GetPosition())
	local is_valid_time_to_use_remote = TheNet:GetIsClient() and TheNet:GetIsServerAdmin()
	if is_valid_time_to_use_remote then
		TheNet:SendRemoteExecute(fnstr, x, z)
	else
		ExecuteConsoleCommand(fnstr)
	end
end

local function GetCharacter()
	return "UserToPlayer('"..TOOMANYITEMS.CHARACTER_USERID.."')"
end

local function OperateAnnnounce(message)
	--判断用户是否开启了提示
	if _G.TOOMANYITEMS.G_TMIP_SPAWN_ITEMS_TIPS then
		if ThePlayer then
			ThePlayer:DoTaskInTime(0.1, function()
				if ThePlayer.components.talker then
					ThePlayer.components.talker:Say("[TMIP]("..UserToName(TOOMANYITEMS.CHARACTER_USERID)..") " .. message)
				end
			end)
		end
	end
end

local function HealthSet()
	if TheInput:IsKeyDown(KEY_CTRL) then
		SendCommand(string.format('local player = %s local v = player.components.health if player and not player:HasTag("playerghost") and v then v:SetPercent(0.05) end', GetCharacter()))
		OperateAnnnounce(STRINGS.NAMES.CTRLKEYDOWNTIP..STRINGS.TOO_MANY_ITEMS_UI.BUTTON_HEALTH_1)
	else
		SendCommand(string.format('local player = %s local v = player.components.health if player and not player:HasTag("playerghost") and v then v:SetPercent(1) end', GetCharacter()))
	end
end

local function SanitySet()
	if TheInput:IsKeyDown(KEY_CTRL) then
		SendCommand(string.format('local player = %s local v = player.components.sanity if player and not player:HasTag("playerghost") and v then v:SetPercent(0) end', GetCharacter()))
		OperateAnnnounce(STRINGS.NAMES.CTRLKEYDOWNTIP..STRINGS.TOO_MANY_ITEMS_UI.BUTTON_SANITY_1)
	else
		SendCommand(string.format('local player = %s local v = player.components.sanity if player and not player:HasTag("playerghost") and v then v:SetPercent(1) end', GetCharacter()))
	end
end

local function HungerSet()
	if TheInput:IsKeyDown(KEY_CTRL) then
		SendCommand(string.format('local player = %s local v = player.components.hunger if player and not player:HasTag("playerghost") and v then v:SetPercent(0) end', GetCharacter()))
		OperateAnnnounce(STRINGS.NAMES.CTRLKEYDOWNTIP..STRINGS.TOO_MANY_ITEMS_UI.BUTTON_HUNGER_1)
	else
		SendCommand(string.format('local player = %s local v = player.components.hunger if player and not player:HasTag("playerghost") and v then v:SetPercent(1) end', GetCharacter()))
	end
end

local function MoistureSet()
	if TheInput:IsKeyDown(KEY_CTRL) then
		SendCommand(string.format('local player = %s local v = player.components.moisture if player and not player:HasTag("playerghost") and v then v:SetPercent(1) end', GetCharacter()))
		OperateAnnnounce(STRINGS.NAMES.CTRLKEYDOWNTIP..STRINGS.TOO_MANY_ITEMS_UI.BUTTON_WET_1)
	else
		SendCommand(string.format('local player = %s local v = player.components.moisture if player and not player:HasTag("playerghost") and v then v:SetPercent(0) end', GetCharacter()))
	end
end

local function TemperatureSet()
	if TheInput:IsKeyDown(KEY_CTRL) then
		SendCommand(string.format('local player = %s local v = player.components.temperature if player and not player:HasTag("playerghost") and v and TheWorld and TheWorld.state.temperature then v:SetTemperature(TheWorld.state.temperature) end', GetCharacter()))
		OperateAnnnounce(STRINGS.NAMES.CTRLKEYDOWNTIP..STRINGS.TOO_MANY_ITEMS_UI.BUTTON_TEMPERATURE_1)
	else
		SendCommand(string.format('local player = %s local v = player.components.temperature if player and not player:HasTag("playerghost") and v then v:SetTemperature(25) end', GetCharacter()))
	end
end

local function BeavernessSet()
	if TheInput:IsKeyDown(KEY_CTRL) then
		SendCommand(string.format('local player = %s local v = player.components.wereness if player and not player:HasTag("playerghost") and v then v:SetWereMode("beaver") v:SetPercent(0) end', GetCharacter()))
		OperateAnnnounce(STRINGS.NAMES.CTRLKEYDOWNTIP..STRINGS.TOO_MANY_ITEMS_UI.BUTTON_BEAVER_WEREMETER_1)
	else
		SendCommand(string.format('local player = %s local v = player.components.wereness if player and not player:HasTag("playerghost") and v then v:SetWereMode("beaver") v:SetPercent(1) end', GetCharacter()))
	end
end
local function GoosenessSet()
	if TheInput:IsKeyDown(KEY_CTRL) then
		SendCommand(string.format('local player = %s local v = player.components.wereness if player and not player:HasTag("playerghost") and v then v:SetWereMode("goose") v:SetPercent(0) end', GetCharacter()))
		OperateAnnnounce(STRINGS.NAMES.CTRLKEYDOWNTIP..STRINGS.TOO_MANY_ITEMS_UI.BUTTON_GOOSE_WEREMETER_1)
	else
		SendCommand(string.format('local player = %s local v = player.components.wereness if player and not player:HasTag("playerghost") and v then v:SetWereMode("goose") v:SetPercent(1) end', GetCharacter()))
	end
end
local function MoosenessSet()
	if TheInput:IsKeyDown(KEY_CTRL) then
		SendCommand(string.format('local player = %s local v = player.components.wereness if player and not player:HasTag("playerghost") and v then v:SetWereMode("moose") v:SetPercent(0) end', GetCharacter()))
		OperateAnnnounce(STRINGS.NAMES.CTRLKEYDOWNTIP..STRINGS.TOO_MANY_ITEMS_UI.BUTTON_MOOSE_WEREMETER_1)
	else
		SendCommand(string.format('local player = %s local v = player.components.wereness if player and not player:HasTag("playerghost") and v then v:SetWereMode("moose") v:SetPercent(1) end', GetCharacter()))
	end
end

local function GodMode()
	SendCommand(string.format('local p = %s local me = UserToPlayer("%s") if p and me then local function SetGodeMode() if p.components.health and me.components.talker then local mode = p.components.health.invincible me.components.talker:Say("%s: "..(mode and STRINGS.UI.MODSSCREEN.STATUS.DISABLED_MANUAL or STRINGS.UI.MODSSCREEN.STATUS.WORKING_NORMALLY)) p.components.health:SetInvincible(not mode) end end if p:HasTag("playerghost") then p:PushEvent("respawnfromghost") p:DoTaskInTime(1, SetGodeMode) else SetGodeMode() end end', GetCharacter(), ThePlayer.userid, STRINGS.TOO_MANY_ITEMS_UI.BUTTON_GODMODE))
end

local function CreativeMode()
	SendCommand(string.format('local p = %s local me = UserToPlayer("%s") local builder = p.components.builder if builder and me and me.components.talker then me.components.talker:Say("%s: "..(builder.freebuildmode and STRINGS.UI.MODSSCREEN.STATUS.DISABLED_MANUAL or STRINGS.UI.MODSSCREEN.STATUS.WORKING_NORMALLY)) builder:GiveAllRecipes() end', GetCharacter(), ThePlayer.userid, STRINGS.TOO_MANY_ITEMS_UI.BUTTON_CREATIVEMODE))
end

local function OneHitKillMode()
	SendCommand(string.format('local combat_ = %s.components.combat or nil local me = UserToPlayer("%s") if me and me.components.talker and combat_ and combat_.CalcDamage then if combat_.OldCalcDamage then me.components.talker:Say("%s: "..STRINGS.UI.MODSSCREEN.STATUS.DISABLED_MANUAL) combat_.CalcDamage = combat_.OldCalcDamage combat_.OldCalcDamage = nil else me.components.talker:Say("%s: "..STRINGS.UI.MODSSCREEN.STATUS.WORKING_NORMALLY) combat_.OldCalcDamage = combat_.CalcDamage combat_.CalcDamage = function(...) return 9999999999*9 end end end', GetCharacter(), ThePlayer.userid, STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONEHITKILLMODE, STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONEHITKILLMODE))
end

local function RemoveBackpack()
		local confirmscreen
		confirmscreen = PopupDialogScreen(STRINGS.TOO_MANY_ITEMS_UI.BUTTON_EMPTYBACKPACK, STRINGS.TOO_MANY_ITEMS_UI.BUTTON_EMPTYBACKPACK,	{{text = STRINGS.UI.TRADESCREEN.ACCEPT, cb = function() SendCommand(string.format('local player = %s local inventory = player and player.components.inventory or nil local backpack = inventory and inventory:GetOverflowContainer() or nil local backpackSlotCount = backpack and backpack:GetNumSlots() or 0 for i = 1, backpackSlotCount do local item = backpack:GetItemInSlot(i) or nil inventory:RemoveItem(item, true) if item ~= nil then item:Remove() end end', GetCharacter()))
		TheFrontEnd:PopScreen(confirmscreen) end },	{ text = STRINGS.UI.TRADESCREEN.CANCEL, cb = function()	TheFrontEnd:PopScreen(confirmscreen) end}})
		TheFrontEnd:PushScreen(confirmscreen)
end

local Menu = Class(function(self, owner, pos)
    self.owner = owner
    self.shield = self.owner.owner.shield
		local pos_y1 = -178
		local pos_y2 = -218

    local function Close()
      self.owner.owner:Close()
    end
    local function ShowDebugMenu()
      self.owner.owner:ShowDebugMenu()
    end
		self.menu = {
			["hunger"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_HUNGER,
				fn = HungerSet,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_hunger.tex",
				pos = {pos[1], pos_y1},
			},
			["health"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_HEALTH,
				fn = HealthSet,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_health.tex",
				pos = {pos[3], pos_y1},
			},
			["sanity"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_SANITY,
				fn = SanitySet,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_sanity.tex",
				pos = {pos[2], pos_y1},
			},
			["moisture"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_WET,
				fn = MoistureSet,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_wet.tex",
				pos = {pos[4], pos_y1},
			},
			["godmode"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_GODMODE..STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONOROFF,
				fn = GodMode,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_godmode.tex",
				pos = {pos[5], pos_y1},
			},
			["creativemode"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_CREATIVEMODE..STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONOROFF,
				fn = CreativeMode,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_creativemode.tex",
				pos = {pos[6], pos_y1},
			},
			["onehitkillmode"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONEHITKILLMODE..STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONOROFF,
				fn = OneHitKillMode,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_onehitkillmode.tex",
				pos = {pos[7], pos_y1},
			},
			["prevbutton"] = {
				tip = STRINGS.UI.HELP.PREVPAGE,
				fn = function() self.owner.inventory:Scroll(-1) end,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_left.tex",
				pos = {pos[8], pos_y1},
			},
			["nextbutton"] = {
				tip = STRINGS.UI.HELP.NEXTPAGE,
				fn = function() self.owner.inventory:Scroll(1) end,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_right.tex",
				pos = {pos[9], pos_y1},
			},
			["beaverness"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_BEAVER_WEREMETER,
				fn = BeavernessSet,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_woodbeavermode.tex",
				pos = {pos[1], pos_y2},
			},
			["beaverness2"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_GOOSE_WEREMETER,
				fn = GoosenessSet,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_woodgoosemode.tex",
				pos = {pos[2], pos_y2},
			},
			["beaverness1"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_MOOSE_WEREMETER,
				fn = MoosenessSet,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_woodmoosemode.tex",
				pos = {pos[3], pos_y2},
			},
			["temperature"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_TEMPERATURE,
				fn = TemperatureSet,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_temperature.tex",
				pos = {pos[4], pos_y2},
			},
			["remove"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_EMPTYBACKPACK,
				fn = RemoveBackpack,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_empbackpack.tex",
				pos = {pos[5], pos_y2},
			},
			["debug"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_DEBUGMENU..STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONOROFF,
				fn = ShowDebugMenu,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_debugmod.tex",
				pos = {pos[6], pos_y2},
			},
			["cancel"] = {
				tip = STRINGS.UI.OPTIONS.CLOSE,
				fn = Close,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_close.tex",
				pos = {pos[7], pos_y2},
			},

		}

    self:MainButton()

	end)

function Menu:MainButton()
	self.mainbuttons = {}
	local function MakeMainButtonList(buttonlist)
		local function MakeMainButton(name, tip, fn, atlas, image, pos)
			if type(image) == "string" then
				self.mainbuttons[name] = self.shield:AddChild(ImageButton(atlas, image, image, image))
			elseif type(image) == "table" then
				self.mainbuttons[name] = self.shield:AddChild(ImageButton(atlas, image[1], image[2], image[3]))
			else
				return
			end
			self.mainbuttons[name]:SetTooltip(tip)
			self.mainbuttons[name]:SetOnClick(fn)
			self.mainbuttons[name]:SetPosition(pos[1], pos[2], 0)
			local w, h = self.mainbuttons[name].image:GetSize()
			local scale = math.min(35 / w, 35 / h)
			self.mainbuttons[name]:SetNormalScale(scale)
			self.mainbuttons[name]:SetFocusScale(scale * 1.1)
		end
		for k,v in pairs(buttonlist) do
			MakeMainButton(k, v.tip, v.fn, v.atlas, v.image, v.pos)
		end
	end

	if self.menu then
		MakeMainButtonList(self.menu)
		self.mainbuttons["remove"]:SetImageNormalColour(1,0.9,0.9,0.9)
		self.mainbuttons["remove"]:SetImageFocusColour(1,0.1,0.1,0.9)
		self.mainbuttons["remove"]:SetImageSelectedColour(1,0,0,0.9)
	end
end

return Menu

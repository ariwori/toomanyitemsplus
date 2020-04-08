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
	return "UserToPlayer('" .. TOOMANYITEMS.CHARACTER_USERID .. "')"
end

local function OperateAnnnounce(message)
	--判断用户是否开启了提示
	if _G.TOOMANYITEMS.DATA.SPAWN_ITEMS_TIPS then
		if ThePlayer then
			ThePlayer:DoTaskInTime(
				0.1,
				function()
					if ThePlayer.components.talker then
						--ThePlayer.components.talker:Say("[TMIP]("..UserToName(TOOMANYITEMS.CHARACTER_USERID)..") " .. message)
						ThePlayer.components.talker:Say("[TMIP]" .. message)
					end
				end
			)
		end
	end
end

local function HungerSet()
		SendCommand(
			string.format(
				'local player = %s if player == nil then UserToPlayer("' ..
					_G.TOOMANYITEMS.DATA.ThePlayerUserId ..
						'").components.talker:Say("' ..
							STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..
								'") end local h = player.components.hunger local hv = 1 local ctrlks = TheInput:IsKeyDown(KEY_CTRL) if player and not player:HasTag("playerghost") and h then if ctrlks then hv = 0 end h:SetPercent(hv) end',
				GetCharacter()
			)
		)
		OperateAnnnounce(STRINGS.TOO_MANY_ITEMS_UI.BUTTON_HUNGER)
end

local function SanitySet()
		SendCommand(
			string.format(
				'local player = %s if player == nil then UserToPlayer("' ..
					_G.TOOMANYITEMS.DATA.ThePlayerUserId ..
						'").components.talker:Say("' ..
							STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..
								'") end local h = player.components.sanity local hv = 1 local ctrlks = TheInput:IsKeyDown(KEY_CTRL) if player and not player:HasTag("playerghost") and h then if ctrlks then hv = 0 end h:SetPercent(hv) end',
				GetCharacter()
			)
		)
		OperateAnnnounce(STRINGS.TOO_MANY_ITEMS_UI.BUTTON_SANITY)
end

local function HealthSet()
		SendCommand(
			string.format(
				'local player = %s if player == nil then UserToPlayer("' ..
					_G.TOOMANYITEMS.DATA.ThePlayerUserId ..
						'").components.talker:Say("' ..
							STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..
								'") end local h = player.components.health local hv = 1 local ctrlks = TheInput:IsKeyDown(KEY_CTRL) if player and not player:HasTag("playerghost") and h then if ctrlks then hv = 0.05 end h:SetPercent(hv) end',
				GetCharacter()
			)
		)
		OperateAnnnounce(STRINGS.TOO_MANY_ITEMS_UI.BUTTON_HEALTH)
end

local function HealthLock()
		SendCommand(
			string.format(
				'local player = %s if player == nil then UserToPlayer("' ..
					_G.TOOMANYITEMS.DATA.ThePlayerUserId ..
						'").components.talker:Say("' ..
							STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..
								'") end local h = player.components.health local t = player.components.talker local hpgp = h:GetPercent() local hv local hlt = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_HEALTHLOCK..":" local hlton = STRINGS.UI.MODSSCREEN.STATUS.WORKING_NORMALLY local hltoff = STRINGS.UI.MODSSCREEN.STATUS.DISABLED_MANUAL if player and not player:HasTag("playerghost") and h then if h.minhealth == 0 then hv = 1 t:Say(hlt..hlton) elseif h.minhealth == 1 then hv = 0 t:Say(hlt..hltoff) else hv = 0 t:Say(hlt..hltoff) end end SuUsed("c_minhealth", true) h:SetMinHealth(hv) h:SetPercent(hpgp)',
				GetCharacter(),
				ThePlayer.userid,
				STRINGS.TOO_MANY_ITEMS_UI.BUTTON_HEALTH_LOCK
			)
		)
end

local function MoistureSet()
		SendCommand(
			string.format(
				'local player = %s if player == nil then UserToPlayer("' ..
					_G.TOOMANYITEMS.DATA.ThePlayerUserId ..
						'").components.talker:Say("' ..
							STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..
								'") end local h = player.components.moisture local hv = 0 local ctrlks = TheInput:IsKeyDown(KEY_CTRL) if player and not player:HasTag("playerghost") and h then if ctrlks then hv = 1 end h:SetPercent(hv) end',
				GetCharacter()
			)
		)
		OperateAnnnounce(STRINGS.TOO_MANY_ITEMS_UI.BUTTON_WET)
end

local function TemperatureSet()
		SendCommand(
			string.format(
				'local player = %s if player == nil then UserToPlayer("' ..
					_G.TOOMANYITEMS.DATA.ThePlayerUserId ..
						'").components.talker:Say("' ..
							STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..
								'") end local h = player.components.temperature local hv = 25 local ctrlks = TheInput:IsKeyDown(KEY_CTRL) if player and not player:HasTag("playerghost") and h then if ctrlks and TheWorld and TheWorld.state.temperature then hv = TheWorld.state.temperature end h:SetTemperature(hv) end',
				GetCharacter()
			)
		)
		OperateAnnnounce(		STRINGS.TOO_MANY_ITEMS_UI.BUTTON_TEMPERATURE)
end

local function GodMode()
	SendCommand(
		string.format(
			'local p = %s if p == nil then UserToPlayer("' ..
				_G.TOOMANYITEMS.DATA.ThePlayerUserId ..
					'").components.talker:Say("' ..
						STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..
							'") end local me = UserToPlayer("%s") if p and me then local function SetGodeMode() if p.components.health and me.components.talker then local mode = p.components.health.invincible me.components.talker:Say("%s: "..(mode and STRINGS.UI.MODSSCREEN.STATUS.DISABLED_MANUAL or STRINGS.UI.MODSSCREEN.STATUS.WORKING_NORMALLY)) p.components.health:SetInvincible(not mode) end end if p:HasTag("playerghost") then p:PushEvent("respawnfromghost") p.rezsource = "' ..
								STRINGS.TOO_MANY_ITEMS_UI.TMIP_CONSOLE .. '" p:DoTaskInTime(1, SetGodeMode) else SetGodeMode() end end',
			GetCharacter(),
			ThePlayer.userid,
			STRINGS.TOO_MANY_ITEMS_UI.BUTTON_GODMODE
		)
	)
end

local function CreativeMode()
	SendCommand(
		string.format(
			'local p = %s if p == nil then UserToPlayer("' ..
				_G.TOOMANYITEMS.DATA.ThePlayerUserId ..
					'").components.talker:Say("' ..
						STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..
							'") end local me = UserToPlayer("%s") local builder = p.components.builder if builder and me and me.components.talker then me.components.talker:Say("%s: "..(builder.freebuildmode and STRINGS.UI.MODSSCREEN.STATUS.DISABLED_MANUAL or STRINGS.UI.MODSSCREEN.STATUS.WORKING_NORMALLY)) builder:GiveAllRecipes() end',
			GetCharacter(),
			ThePlayer.userid,
			STRINGS.TOO_MANY_ITEMS_UI.BUTTON_CREATIVEMODE
		)
	)
end

local function OneHitKillMode()
	SendCommand(
		string.format(
			'local p = %s if p == nil then UserToPlayer("' ..
				_G.TOOMANYITEMS.DATA.ThePlayerUserId ..
					'").components.talker:Say("' ..
						STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..
							'") end local combat_ = p.components.combat or nil local me = UserToPlayer("%s") if me and me.components.talker and combat_ and combat_.CalcDamage then if combat_.OldCalcDamage then me.components.talker:Say("%s: "..STRINGS.UI.MODSSCREEN.STATUS.DISABLED_MANUAL) combat_.CalcDamage = combat_.OldCalcDamage combat_.OldCalcDamage = nil else me.components.talker:Say("%s: "..STRINGS.UI.MODSSCREEN.STATUS.WORKING_NORMALLY) combat_.OldCalcDamage = combat_.CalcDamage combat_.CalcDamage = function(...) return 9999999999*9 end end end',
			GetCharacter(),
			ThePlayer.userid,
			STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONEHITKILLMODE,
			STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONEHITKILLMODE
		)
	)
end

local function RemoveInventory()
	if _G.TOOMANYITEMS.DATA.SHOW_CONFIRM_SCREEN then
		local confirmscreen
		confirmscreen =
			PopupDialogScreen(
			STRINGS.TOO_MANY_ITEMS_UI.BUTTON_EMPINVENTORY,
			STRINGS.TOO_MANY_ITEMS_UI.BUTTON_EMPINVENTORYTIP,
			{
				{
					text = STRINGS.UI.TRADESCREEN.ACCEPT,
					cb = function()
						SendCommand(
							string.format(
								'local player = %s if player == nil then UserToPlayer("' ..
									_G.TOOMANYITEMS.DATA.ThePlayerUserId ..
										'").components.talker:Say("' ..
											STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..
												'") end local inventory = player and player.components.inventory or nil local backpack = inventory and inventory:GetOverflowContainer() or nil local inventorySlotCount = inventory and inventory:GetNumSlots() or 0 local backpackSlotCount = backpack and backpack:GetNumSlots() or 0 local ctrlks = TheInput:IsKeyDown(KEY_CTRL) for i = 1, inventorySlotCount do local item = inventory:GetItemInSlot(i) or nil inventory:RemoveItem(item, true) if item ~= nil then item:Remove() end end if ctrlks then for i = 1, backpackSlotCount do local item = backpack:GetItemInSlot(i) or nil inventory:RemoveItem(item, true) if item ~= nil then item:Remove() end end end',
								GetCharacter()
							)
						)
						TheFrontEnd:PopScreen(confirmscreen)
					end
				},
				{text = STRINGS.UI.TRADESCREEN.CANCEL, cb = function()
						TheFrontEnd:PopScreen(confirmscreen)
					end}
			}
		)
		TheFrontEnd:PushScreen(confirmscreen)
	else
		SendCommand(
			string.format(
				'local player = %s if player == nil then UserToPlayer("' ..
					_G.TOOMANYITEMS.DATA.ThePlayerUserId ..
						'").components.talker:Say("' ..
							STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..
								'") end local inventory = player and player.components.inventory or nil local backpack = inventory and inventory:GetOverflowContainer() or nil local inventorySlotCount = inventory and inventory:GetNumSlots() or 0 local backpackSlotCount = backpack and backpack:GetNumSlots() or 0 local ctrlks = TheInput:IsKeyDown(KEY_CTRL) for i = 1, inventorySlotCount do local item = inventory:GetItemInSlot(i) or nil inventory:RemoveItem(item, true) if item ~= nil then item:Remove() end end if ctrlks then for i = 1, backpackSlotCount do local item = backpack:GetItemInSlot(i) or nil inventory:RemoveItem(item, true) if item ~= nil then item:Remove() end end end',
				GetCharacter()
			)
		)
	end
end
local function RemoveBackpack()
	if _G.TOOMANYITEMS.DATA.SHOW_CONFIRM_SCREEN then
		local confirmscreen
		confirmscreen =
			PopupDialogScreen(
			STRINGS.TOO_MANY_ITEMS_UI.BUTTON_EMPTYBACKPACK,
			STRINGS.TOO_MANY_ITEMS_UI.BUTTON_EMPTYBACKPACKTIP,
			{
				{
					text = STRINGS.UI.TRADESCREEN.ACCEPT,
					cb = function()
						SendCommand(
							string.format(
								'local player = %s if player == nil then UserToPlayer("' ..
									_G.TOOMANYITEMS.DATA.ThePlayerUserId ..
										'").components.talker:Say("' ..
											STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..
												'") end local inventory = player and player.components.inventory or nil local backpack = inventory and inventory:GetOverflowContainer() or nil local inventorySlotCount = inventory and inventory:GetNumSlots() or 0 local backpackSlotCount = backpack and backpack:GetNumSlots() or 0 local ctrlks = TheInput:IsKeyDown(KEY_CTRL) for i = 1, backpackSlotCount do local item = backpack:GetItemInSlot(i) or nil inventory:RemoveItem(item, true) if item ~= nil then item:Remove() end end if ctrlks then for i = 1, inventorySlotCount do local item = inventory:GetItemInSlot(i) or nil inventory:RemoveItem(item, true) if item ~= nil then item:Remove() end end end',
								GetCharacter()
							)
						)
						TheFrontEnd:PopScreen(confirmscreen)
					end
				},
				{text = STRINGS.UI.TRADESCREEN.CANCEL, cb = function()
						TheFrontEnd:PopScreen(confirmscreen)
					end}
			}
		)
		TheFrontEnd:PushScreen(confirmscreen)
	else
		SendCommand(
			string.format(
				'local player = %s if player == nil then UserToPlayer("' ..
					_G.TOOMANYITEMS.DATA.ThePlayerUserId ..
						'").components.talker:Say("' ..
							STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..
								'") end local inventory = player and player.components.inventory or nil local backpack = inventory and inventory:GetOverflowContainer() or nil local inventorySlotCount = inventory and inventory:GetNumSlots() or 0 local backpackSlotCount = backpack and backpack:GetNumSlots() or 0 local ctrlks = TheInput:IsKeyDown(KEY_CTRL) for i = 1, backpackSlotCount do local item = backpack:GetItemInSlot(i) or nil inventory:RemoveItem(item, true) if item ~= nil then item:Remove() end end if ctrlks then for i = 1, inventorySlotCount do local item = inventory:GetItemInSlot(i) or nil inventory:RemoveItem(item, true) if item ~= nil then item:Remove() end end end',
				GetCharacter()
			)
		)
	end
end

local Menu =
	Class(
	function(self, owner, pos)
		self.owner = owner
		self.shield = self.owner.owner.shield
		local pos_y1 = -180
		local pos_y2 = -220
		local function Close()
			self.owner.owner:Close()
		end
		local function ShowDebugMenu()
			self.owner.owner:ShowDebugMenu()
		end

		local function ShowWoodieMenu()
			self.owner.owner:ShowWoodieMenu()
		end

		local function ShowAbigailMenu()
			self.owner.owner:ShowAbigailMenu()
		end

		self.menu = {
			--第一行
			["hunger"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_HUNGER,
				fn = HungerSet,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_hunger.tex",
				pos = {pos[1], pos_y1}
			},
			["sanity"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_SANITY,
				fn = SanitySet,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_sanity.tex",
				pos = {pos[2], pos_y1}
			},
			["health"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_HEALTH,
				fn = HealthSet,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_health.tex",
				pos = {pos[3], pos_y1}
			},
			["lockhealth"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_HEALTHLOCK .. STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONOROFF,
				fn = HealthLock,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_health_lock.tex",
				pos = {pos[4], pos_y1}
			},
			["moisture"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_WET,
				fn = MoistureSet,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_wet.tex",
				pos = {pos[5], pos_y1}
			},
			["temperature"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_TEMPERATURE,
				fn = TemperatureSet,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_temperature.tex",
				pos = {pos[6], pos_y1}
			},
			["cancel"] = {
				tip = STRINGS.UI.OPTIONS.CLOSE,
				fn = Close,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_close.tex",
				pos = {pos[8], pos_y1}
			},
			["prevbutton"] = {
				tip = STRINGS.UI.HELP.PREVPAGE,
				fn = function()
					self.owner.inventory:Scroll(-1)
				end,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_left.tex",
				pos = {pos[9], pos_y1}
			},
			["nextbutton"] = {
				tip = STRINGS.UI.HELP.NEXTPAGE,
				fn = function()
					self.owner.inventory:Scroll(1)
				end,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_right.tex",
				pos = {pos[10], pos_y1}
			},
			--第二行
			["woodiemenu"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_SUBMENU_WOODIEMENU,
				fn = ShowWoodieMenu,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_woodie.tex",
				pos = {pos[1], pos_y2}
			},
			["abigailmenu"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_SUBMENU_ABIGAIL,
				fn = ShowAbigailMenu,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_abigail.tex",
				pos = {pos[2], pos_y2}
			},
			["creativemode"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_CREATIVEMODE .. STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONOROFF,
				fn = CreativeMode,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_creativemode.tex",
				pos = {pos[3], pos_y2}
			},
			["godmode"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_GODMODE .. STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONOROFF,
				fn = GodMode,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_godmode.tex",
				pos = {pos[4], pos_y2}
			},
			["onehitkillmode"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONEHITKILLMODE .. STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONOROFF,
				fn = OneHitKillMode,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_onehitkillmode.tex",
				pos = {pos[5], pos_y2}
			},
				["removeinventory"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_EMPINVENTORY,
				fn = RemoveInventory,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_empinventory.tex",
				pos = {pos[6], pos_y2}
			},
			["removebackpack"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_EMPTYBACKPACK,
				fn = RemoveBackpack,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_empbackpack.tex",
				pos = {pos[7], pos_y2}
			},
			["debug"] = {
				tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_DEBUGMENU .. STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ONOROFF,
				fn = ShowDebugMenu,
				atlas = "images/customicobyysh.xml",
				image = "tmipbutton_debugmod.tex",
				pos = {pos[8], pos_y2}
			}
		}

		self:MainButton()
	end
)

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
		for k, v in pairs(buttonlist) do
			MakeMainButton(k, v.tip, v.fn, v.atlas, v.image, v.pos)
		end
	end

	if self.menu then
		MakeMainButtonList(self.menu)
		self.mainbuttons["removebackpack"]:SetImageNormalColour(1, 0.9, 0.9, 0.9)
		self.mainbuttons["removebackpack"]:SetImageFocusColour(1, 0.1, 0.1, 0.9)
		self.mainbuttons["removebackpack"]:SetImageSelectedColour(1, 0, 0, 0.9)
		self.mainbuttons["removeinventory"]:SetImageNormalColour(1, 0.9, 0.9, 0.9)
		self.mainbuttons["removeinventory"]:SetImageFocusColour(1, 0.1, 0.1, 0.9)
		self.mainbuttons["removeinventory"]:SetImageSelectedColour(1, 0, 0, 0.9)
	end
end

return Menu

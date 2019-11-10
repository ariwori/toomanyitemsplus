local ItemSlot = require "widgets/itemslot"

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
					ThePlayer.components.talker:Say("[TMIP]"..message)
					--ThePlayer.components.talker:Say("[TMIP]".. message.."["..UserToName(TOOMANYITEMS.CHARACTER_USERID).."]" )
				end
			end)
		end
	end
end

local function split(str,reps)
	local resultStrList = {}
	string.gsub(str,'[^'..reps..']+',function (w)
			table.insert(resultStrList,w)
	end)
	return resultStrList
end

-- 调料食物
local function removespice(str)
	local newstr = str
	local strarr = split(str, "_")
	if strarr ~= nil then
		table.remove(strarr, #strarr)
		table.remove(strarr, #strarr)

		newstr = ""
		for k,v in ipairs(strarr) do
			if k ~= #strarr then
				newstr = newstr..strarr[k].."_"
			else
				newstr = newstr..strarr[k]
			end
		end
	end
	return newstr
end

local function gotoonly(name)
	name = name or ""
	return string.format('local player = %s if player ~= nil then local function tmi_goto(prefab) if player.Physics ~= nil then player.Physics:Teleport(prefab.Transform:GetWorldPosition()) else player.Transform:SetPosition(prefab.Transform:GetWorldPosition()) end end local target = c_findnext("'..name..'") if target ~= nil then tmi_goto(target) end end' , GetCharacter())
end

local InvSlot = Class(ItemSlot, function(self, owner, atlas, bgim, item)
		ItemSlot._ctor(self, atlas, bgim, owner)
		self.owner = owner
		self.item = item
	end)

function InvSlot:OnControl(control, down)
	if InvSlot._base.OnControl(self, control, down) then return true end

	if down then

		if control == CONTROL_ACCEPT then
			self:Click(false)
		elseif control == CONTROL_SECONDARY then
			self:Click(true)
		end

		return true
	end

end

function InvSlot:GetDescription()
	local str = self.item

	if self.item ~= nil and self.item ~= "" then
		local itemtip = string.upper(self.item)
		if STRINGS.NAMES[itemtip] ~= nil and STRINGS.NAMES[itemtip] ~= "" then
			str = STRINGS.NAMES[itemtip]
		end
	end

	if TOOMANYITEMS.LIST.desclist[self.item] then
		str = TOOMANYITEMS.LIST.desclist[self.item]
	end

	if TOOMANYITEMS.LIST.desclist[self.oitem] then
		str = TOOMANYITEMS.LIST.desclist[self.oitem]
	end

	if type(str) == "table" then
		local itemtip = string.upper(self.item)
		if NAMES_DEFAULTS[itemtip] ~= nil then
			str = str[NAMES_DEFAULTS[itemtip]]
		else
			local _, v = next(str)
			str = v
		end
	end

	local strarr = split(self.item, "_")
	-- 调料食物
	if string.find(self.item, "_spice_") then
		local str1 = "Unknown"
		local itemtip = string.upper(removespice(self.item))
		if STRINGS.NAMES[itemtip] ~= nil and STRINGS.NAMES[itemtip] ~= "" then
			str1 = STRINGS.NAMES[itemtip]
		end
		local subfix = STRINGS.NAMES["SPICE_".. string.upper(strarr[3]).."_FOOD"]
		if subfix then str = subfmt(subfix, { food = str1 }) end
	-- 挂饰、彩灯
	elseif string.find(self.item, "winter_ornament_") then
		if #strarr == 4 then
			str = STRINGS.NAMES[string.upper(strarr[1].."_"..strarr[2]..strarr[3])]
		elseif string.find(strarr[3], "light") then
			str = STRINGS.NAMES[string.upper(strarr[1].."_"..strarr[2].."light")]
		else
			str = STRINGS.NAMES[string.upper(strarr[1].."_"..strarr[2])]
		end
	-- 桦树精
	elseif self.item == "deciduoustree" then
		str = STRINGS.NAMES[string.upper(strarr[1])]..STRINGS.NAMES.MONSTER
  -- 刷新点
	elseif string.find(self.item, "_spawner") and #strarr == 2 and STRINGS.NAMES[string.upper(strarr[1])] then
		str =STRINGS.NAMES[string.upper(strarr[1])]..STRINGS.NAMES.SPAWNER

  -- 雕像、雕像草图
	elseif string.find(self.item, "deer_") then
		str = STRINGS.NAMES["DEER_GEMMED"]
  -- 雕像、雕像草图
	elseif string.find(self.item, "chesspiece_") then
		local itemtip = string.upper(strarr[1].."_"..strarr[2])
		if string.find(self.item, "_sketch") then
			if STRINGS.NAMES[itemtip] ~= nil and STRINGS.NAMES[itemtip] ~= "" then
				str = subfmt(STRINGS.NAMES[string.upper(strarr[3])], { item = STRINGS.NAMES[itemtip] })
			end
		else
			if strarr[3] == "stone" then strarr[3] = "cutstone" end
			if STRINGS.NAMES[itemtip] ~= nil and STRINGS.NAMES[itemtip] ~= "" and strarr[3] ~= nil and strarr[3] ~= "" then
				str = STRINGS.NAMES[string.upper(strarr[3])]..STRINGS.NAMES[itemtip]
			end
		end
	end

	if not str then str = "Unknown" end

	return str
end

function InvSlot:Click(stack_mod)
	if self.item then
		local itemdescription = self:GetDescription()
		local spawnnum = stack_mod and TOOMANYITEMS.G_TMIP_R_CLICK_NUM or TOOMANYITEMS.G_TMIP_L_CLICK_NUM
		if TheInput:IsKeyDown(KEY_CTRL) then
			-- Ctrl+ALT+左键传送，要右键就取消下面一行里的注释
			if TheInput:IsKeyDown(KEY_ALT) and stack_mod then
				SendCommand(gotoonly(self.item))
				OperateAnnnounce(STRINGS.NAMES.SUPERGOTOTIP..itemdescription)
				print ("[TooManyItemsPlus] Teleport to: "..self.item)
			else
				local customitems = {}
				if table.contains(TOOMANYITEMS.DATA.customitems, self.item) then
					for i = 1, #TOOMANYITEMS.DATA.customitems do
						if TOOMANYITEMS.DATA.customitems[i] ~= self.item then
							table.insert(customitems, TOOMANYITEMS.DATA.customitems[i])
						end
					end
					TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/research_unlock")
					-- Ctrl按下，调整自定义物品
					OperateAnnnounce(STRINGS.NAMES.CTRLKEYDOWNTIP..itemdescription..STRINGS.NAMES.REMOVEEDITEMSTIP)
					print ("[TooManyItemsPlus] Remove Items: "..self.item)
				else
					table.insert(customitems, self.item)
					for i = 1, #TOOMANYITEMS.DATA.customitems do
						table.insert(customitems, TOOMANYITEMS.DATA.customitems[i])
					end
					TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/research_available")
					OperateAnnnounce(STRINGS.NAMES.CTRLKEYDOWNTIP..itemdescription..STRINGS.NAMES.ADDEDITEMSTIP)
					print ("[TooManyItemsPlus] Add Items: "..self.item)
				end
				TOOMANYITEMS.DATA.customitems = customitems
				if TOOMANYITEMS.DATA.listinuse == "custom" then
					if TOOMANYITEMS.DATA.issearch then
						self.owner:Search()
					else
						self.owner:TryBuild()
					end
				end
				if TOOMANYITEMS.G_TMIP_DATA_SAVE == 1 then
					TOOMANYITEMS.SaveNormalData()
				end
			end
		elseif TheInput:IsKeyDown(KEY_SHIFT) then
			local fnstr = 'local player = %s local function tmi_give(item) if player ~= nil and player.Transform then local x,y,z = player.Transform:GetWorldPosition() if item ~= nil and item.components then if item.components.inventoryitem ~= nil then if player.components and player.components.inventory then player.components.inventory:GiveItem(item) end else item.Transform:SetPosition(x,y,z) end end end end local function tmi_mat(name) local recipe = AllRecipes[name] if recipe then for _, iv in pairs(recipe.ingredients) do for i = 1, iv.amount do local item = SpawnPrefab(iv.type) tmi_give(item) end end end end for i = 1, %s or 1 do tmi_mat("%s") end'
			SendCommand(string.format(fnstr, GetCharacter(), spawnnum, self.item))
			TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/click_object")
			OperateAnnnounce(STRINGS.NAMES.SHIFTKEYDOWNTIP..STRINGS.NAMES.GETITEMSMATERIALHTIP..itemdescription..STRINGS.NAMES.GETITEMSMATERIALETIP.." *"..spawnnum)
			print ("[TooManyItemsPlus] Get material from: "..self.item)
		else
			local fnstr = "local player = %s if player ~= nil and player.Transform then local x,y,z = player.Transform:GetWorldPosition() for i = 1, %s or 1 do local inst = DebugSpawn('%s') if inst ~= nil and inst.components then if inst.components.skinner ~= nil and IsRestrictedCharacter(inst.prefab) then inst.components.skinner:SetSkinMode('normal_skin') end if inst.components.inventoryitem ~= nil then if player.components and player.components.inventory then player.components.inventory:GiveItem(inst) end else inst.Transform:SetPosition(x,y,z) if '%s' == 'deciduoustree' then inst:StartMonster(true) end end end end end"
			SendCommand(string.format(fnstr, GetCharacter(), spawnnum, self.item, self.item))
			TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/click_object")
			OperateAnnnounce(STRINGS.NAMES.SPAWNITEMSTIP..itemdescription.." *"..spawnnum)
			print ("[TooManyItemsPlus] SpawnPrefab: "..self.item)
		end
	end

end

return InvSlot

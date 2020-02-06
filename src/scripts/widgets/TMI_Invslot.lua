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
	if _G.TOOMANYITEMS.DATA.SPAWN_ITEMS_TIPS then
		if ThePlayer then
			ThePlayer:DoTaskInTime(0.1, function()
				if ThePlayer.components.talker then
					ThePlayer.components.talker:Say("[TMIP]"..message)
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
-- 移除最后一个
local function removelast(str)
	local newstr = str
	local strarr = split(str, "_")
	if strarr ~= nil then
		table.remove(strarr, #strarr)
		newstr=""
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

-- function FormatValue(val)
    -- if type(val) == "string" then
        -- return string.format("%q", val)
    -- end
    -- return tostring(val)
-- end

-- function FormatTable(t, tabcount)
    -- tabcount = tabcount or 0
    -- if tabcount > 5 then
        -- 防止栈溢出
        -- return "<table too deep>"..tostring(t)
    -- end
    -- local str = ""
    -- if type(t) == "table" then
        -- for k, v in pairs(t) do
            -- local tab = string.rep("\t", tabcount)
            -- if type(v) == "table" then
                -- str = str..tab..string.format("[%s] = {", FormatValue(k))..'\n'
                -- str = str..FormatTable(v, tabcount + 1)..tab..'}\n'
            -- else
                -- str = str..tab..string.format("[%s] = %s", FormatValue(k), FormatValue(v))..',\n'
            -- end
        -- end
    -- else
        -- str = str..tostring(t)..'\n'
    -- end
    -- return str
-- end

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
	-- print(FormatTable(str))
		local itemtip = string.upper(self.item)
		if self.item == "moon_altar" then
			str = str[itemtip]
		else
			if NAMES_DEFAULTS[itemtip] ~= nil then
				str = str[NAMES_DEFAULTS[itemtip]]
			else
				local _, v = next(str)
				str = v
			end
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
	elseif string.find(self.item, "_spawner") and #strarr <= 3 and STRINGS.NAMES[string.upper(strarr[1])] then
		str =STRINGS.NAMES[string.upper(strarr[1])]..STRINGS.NAMES.SPAWNER
	-- 纸条
	elseif string.find(self.item, "_tacklesketch") then
		local itemtip = string.upper(removelast(self.item))
		-- print(itemtip)
		if STRINGS.NAMES[itemtip] ~= nil and STRINGS.NAMES[itemtip] ~= "" then
			str = subfmt(STRINGS.NAMES[string.upper("tacklesketch")], { item = STRINGS.NAMES[itemtip] })
		end
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
			local skinname = self.item
			local leader = 1
			if string.find(self.item, "critter_") then
				skinname = self.item.."_builder"
				leader = GetCharacter()
			end
			local last_skin =	Profile:GetLastUsedSkinForItem(skinname)
			if last_skin ~= nil and string.find(self.item, "critter_") and skinname ~= last_skin then
				arr = split(last_skin, "_")
				last_skin = arr[1].."_"..arr[2]
			end
			last_skin = last_skin ~= nil and last_skin or self.item
			local fnstr = [[
			local player = %s
			local function onturnon(inst)
				if inst._stage == 3 then
					if inst.AnimState:IsCurrentAnimation("proximity_pre") or inst.AnimState:IsCurrentAnimation("proximity_loop") or inst.AnimState:IsCurrentAnimation("place3") then
						inst.AnimState:PushAnimation("proximity_pre")
					else
						inst.AnimState:PlayAnimation("proximity_pre")
					end

					inst.AnimState:PushAnimation("proximity_loop", true)
				end
			end
			local function onturnoff(inst)
				if inst._stage == 3 then
					inst.AnimState:PlayAnimation("proximity_pst")
					inst.AnimState:PushAnimation("idle3", false)
				end
			end
			if player ~= nil and player.Transform then
				if '%s' == 'klaus' then
					local pos = player:GetPosition()
					local minplayers = math.huge
					local spawnx, spawnz
					FindWalkableOffset(pos,
						math.random() * 2 * PI, 33, 16, true, true,
						function(pt)
							local count = #FindPlayersInRangeSq(pt.x, pt.y, pt.z, 625)
							if count < minplayers then
								minplayers = count
								spawnx, spawnz = pt.x, pt.z
								return count <= 0
							end
							return false
						end)
					if spawnx == nil then
						local offset = FindWalkableOffset(pos, math.random() * 2 * PI, 3, 8, false, true)
						if offset ~= nil then
							spawnx, spawnz = pos.x + offset.x, pos.z + offset.z
						end
					end
					local klaus = SpawnPrefab("klaus")
					klaus.Transform:SetPosition(spawnx or pos.x, 0, spawnz or pos.z)
					klaus:SpawnDeer()
					klaus.components.knownlocations:RememberLocation("spawnpoint", pos, false)
					klaus.components.spawnfader:FadeIn()
				else
					local x,y,z = player.Transform:GetWorldPosition()
					for i = 1, %s or 1 do
						local inst = SpawnPrefab('%s', '%s', nil, '%s')
						if inst ~= nil and inst.components then
							if inst.components.skinner ~= nil and IsRestrictedCharacter(inst.prefab) then
								inst.components.skinner:SetSkinMode('normal_skin')
							end
							if inst.components.inventoryitem ~= nil then
								if player.components and player.components.inventory then
									player.components.inventory:GiveItem(inst)
								end
							else
								inst.Transform:SetPosition(x,y,z)
								if '%s' == 'deciduoustree' then
									inst:StartMonster(true)
								end
							end
							if not inst.components.health then
								if inst.components.perishable then
									inst.components.perishable:SetPercent(%s)
								end
								if inst.components.finiteuses then
									inst.components.finiteuses:SetPercent(%s)
								end
								if inst.components.fueled then
									inst.components.fueled:SetPercent(%s)
								end
								if inst.components.temperature then
									inst.components.temperature:SetTemperature(%s)
								end
								if %s ~= 1 and inst.components.follower then
									inst.components.follower:SetLeader(player)
								end
								if '%s' == 'moon_altar' then
									inst._stage =3
									inst.AnimState:PlayAnimation('idle3')
									inst:AddComponent('prototyper')
									inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.MOON_ALTAR_FULL
									inst.components.prototyper.onturnon = onturnon
									inst.components.prototyper.onturnoff = onturnoff
									inst.components.lootdropper:SetLoot({ 'moon_altar_idol', 'moon_altar_glass', 'moon_altar_seed' })
								end
							end
						end
					end
				end
			end ]]
			SendCommand(string.format(fnstr, GetCharacter(), self.item, spawnnum, self.item, last_skin, TOOMANYITEMS.CHARACTER_USERID, self.item, _G.TOOMANYITEMS.DATA.xxd, _G.TOOMANYITEMS.DATA.syd, _G.TOOMANYITEMS.DATA.fuel,  _G.TOOMANYITEMS.DATA.temperature, leader, self.item))
			TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/click_object")
			OperateAnnnounce(STRINGS.NAMES.SPAWNITEMSTIP..itemdescription.." *"..spawnnum)
			print ("[TooManyItemsPlus] SpawnPrefab: "..self.item)
		end
	end

end

return InvSlot

require "../utils"

local ItemSlot = require "widgets/itemslot"

local function split(str,reps)
    local ResultstrList = {}
    string.gsub(str,'[^'..reps..']+',function (w)
        table.insert(ResultstrList,w)
    end)
    return ResultstrList
end

local function GetTableNum(Table)
local count = 0
	for k,v in pairs(Table) do
		count = count + 1
	end
	return(count)
end

local function IsString(str)
	if type(str) == "string" then
		return true
	end
	return false
end

local function GetPrefix(str,noreps)
	local strarr = split(str,"_")
	if noreps == true then
		return strarr[1]
	end
	return strarr[1].."_"
end

local function RemoveSuffix(str)
	local strarr = split(str,"_")
	local n = GetTableNum(strarr)
	local newstr = ""
	for i = 1, n-1, 1 do
		newstr = newstr..strarr[i].."_"
	end
	return string.sub(newstr, 1, string.len(newstr)-1 )
end

local function ReassSuffix(str)
local stage = {"_LOW","_MED","_FULL","_SHORT","_NORMAL","_TALL","_OLD","_BURNT","_DOUBLE","_TRIPLE","_HALLOWEEN","_STUMP","_SKETCH","_TACKLESKETCH","_STONE","_MARBLE","_MOONGLASS","_SPAWNER"}
local upperstr = string.upper(str)
local strarr = split(upperstr,"_")
local x = GetTableNum(stage)
local suffix
	if x > 0 then
		for v = 1, x, 1 do
			suffix = "_"..strarr[GetTableNum(strarr)]
			if suffix == stage[v] then
				if IsString(STRINGS.NAMES["STAGE"..suffix]) and IsString(STRINGS.NAMES[RemoveSuffix(upperstr)]) then
					if suffix == "_STUMP" or suffix == "_SKETCH" or suffix == "_TACKLESKETCH" or suffix == "_SPAWNER" then
						return STRINGS.NAMES[RemoveSuffix(upperstr)]..STRINGS.NAMES["STAGE"..suffix]
					end
					return STRINGS.NAMES["STAGE"..suffix]..STRINGS.NAMES[RemoveSuffix(upperstr)]
				end
			end
		end
	else
		return ""
	end
end

local function DelSuffix(str)
local stage = {"_INV","_1","_2","_3","_4","_LAND","_CONSTRUCTION1","_CONSTRUCTION2","_CONSTRUCTION3","_YOTC","_YOTP"}
local upperstr = string.upper(str)
local strarr = split(upperstr,"_")
local x = GetTableNum(stage)
local suffix
local name
	if x > 0 then
		for v = 1, x, 1 do
			suffix = "_"..strarr[GetTableNum(strarr)]
			if suffix == stage[v] then
			name = STRINGS.NAMES[RemoveSuffix(upperstr)]
				if IsString(name) then
					return name
				end
			end
		end
	else
		return ""
	end
end

local function CheckStr(str)
	local UpperStr = STRINGS.NAMES[string.upper(str)]
	if UpperStr and IsString(UpperStr) then
		return true
	else
		return false
	end
end

local function FindDstSpice(spice)
local dstspice = {"CHILI","GARLIC","SALT","SUGAR"}
spice = string.upper(spice)
	for v=1,4,1 do
		if spice == dstspice[v] then
			return true
		end
	end
	return false
end

local function gotoonly(name)
	name = name or ""
	return string.format(
		'local player = %s if player == nil then UserToPlayer("'.._G.TOOMANYITEMS.DATA.ThePlayerUserId..'").components.talker:Say("'..STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP..'") end  if player ~= nil then local function tmi_goto(prefab) if player.Physics ~= nil then player.Physics:Teleport(prefab.Transform:GetWorldPosition()) else player.Transform:SetPosition(prefab.Transform:GetWorldPosition()) end end local target = c_findnext("' ..
			name .. '") if target ~= nil then tmi_goto(target) end end',
		GetCharacter()
	)
end

local InvSlot =
	Class(
	ItemSlot,
	function(self, owner, atlas, bgim, item)
		ItemSlot._ctor(self, atlas, bgim, owner)
		self.owner = owner
		self.item = item
	end
)

function InvSlot:OnControl(control, down)
	if InvSlot._base.OnControl(self, control, down) then
		return true
	end

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
	local prefabsname = self.item
	local strname
	local repsarr = {}
	if prefabsname and prefabsname ~= "" then
		if TOOMANYITEMS.LIST.desclist[self.itemlangstr] then
			strname = TOOMANYITEMS.LIST.desclist[self.itemlangstr]
			return strname
		end
		if CheckStr(prefabsname) then
			strname = STRINGS.NAMES[string.upper(prefabsname)]
			return strname
		elseif string.find(prefabsname,"_") then
			prefabsname = string.upper(prefabsname)
			repsarr = split(prefabsname,"_")
			if repsarr[1] == "BROKENWALL" then
				strname = string.upper(string.sub(prefabsname,7,-1))
				if strname and CheckStr(strname) then
					strname = STRINGS.NAMES.STAGE_BROKENWALL..STRINGS.NAMES[strname]
					return strname
				end
			end
			if repsarr[2] == "ORNAMENT" then
				if repsarr[3] == "BOSS" then
					strname = repsarr[1].."_"..repsarr[2]..repsarr[3]
				elseif string.sub(repsarr[3],1,5) == "LIGHT" then
					strname = repsarr[1].."_"..repsarr[2].."LIGHT"
				elseif string.find(repsarr[3],"FESTIVALEVENTS") then
					strname = tonumber(string.sub(repsarr[3],15,-1)) <= 3 and "FORGE" or "GORGE"
					strname = repsarr[1].."_"..repsarr[2]..strname
				else
					strname = repsarr[1].."_"..repsarr[2]
				end
				if CheckStr(strname) then
					return STRINGS.NAMES[strname]
				end
			end
			if string.find(prefabsname,"_SPICE_") then
				if FindDstSpice(repsarr[3]) then
					prefabsname = GetPrefix(prefabsname,true)
					if CheckStr(STRINGS.NAMES[prefabsname]) then
						strname = subfmt(STRINGS.NAMES["SPICE_"..repsarr[3].."_FOOD"], {food = STRINGS.NAMES[prefabsname]})
						return strname
					end
				end
			end
			strname = ReassSuffix(prefabsname)
			if strname then
				return strname
			end
			strname = DelSuffix(prefabsname)
			if strname then
				return strname
			end
		end
		return string.lower(prefabsname)
	end
end

function InvSlot:Click(stack_mod)
	if self.item then
		local itemdescription = self:GetDescription()
		if not itemdescription then
			itemdescription = ""
		end
		local spawnnum = stack_mod and _G.TOOMANYITEMS.G_TMIP_R_CLICK_NUM or _G.TOOMANYITEMS.G_TMIP_L_CLICK_NUM
		if TheInput:IsKeyDown(KEY_CTRL) then
			-- Ctrl+ALT+左键传送，要右键就取消下面一行里的注释
			if TheInput:IsKeyDown(KEY_ALT) then
				if stack_mod then
					print ("[TooManyItemsPlus] Teleport to: "..self.item)
					SendCommand(gotoonly(self.item))
					OperateAnnnounce(STRINGS.NAMES.SUPERGOTOTIP .. itemdescription)
				else
					if _G.TOOMANYITEMS.DATA.ADVANCE_DELETE then
						local fnstr =
							'local a=%s if a == nil then UserToPlayer("'.._G.TOOMANYITEMS.DATA.ThePlayerUserId..'").components.talker:Say("'..STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP..'") end local function b(c)local d=c.components.inventoryitem;return d and d.owner and true or false end;local function e(f)if f and f~=TheWorld and not b(f)and f.Transform then if f:HasTag("player")then if f.userid==nil or f.userid==""then return true end else return true end end;return false end;if a and a.Transform then if a.components.burnable then a.components.burnable:Extinguish(true)end;local g,h,i=a.Transform:GetWorldPosition()local j=TheSim:FindEntities(g,h,i,%s)for k,l in pairs(j)do if e(l)then if l.components then if l.components.burnable then l.components.burnable:Extinguish(true)end;if l.components.firefx then if l.components.firefx.extinguishsoundtest then l.components.firefx.extinguishsoundtest=function()return true end end;l.components.firefx:Extinguish()end end;if l.prefab=="%s"then l:Remove()end end end end'
						SendCommand(string.format(fnstr, GetCharacter(), _G.TOOMANYITEMS.DATA.deleteradius, self.item))
					end
				end
			else
				local customitems = {}
				if table.contains(_G.TOOMANYITEMS.DATA.customitems, self.item) then
					print ("[TooManyItemsPlus] Remove custom items: "..self.item)
					for i = 1, #_G.TOOMANYITEMS.DATA.customitems do
						if _G.TOOMANYITEMS.DATA.customitems[i] ~= self.item then
							table.insert(customitems, _G.TOOMANYITEMS.DATA.customitems[i])
						end
					end
					TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/research_unlock")
					-- Ctrl按下，调整自定义物品
					OperateAnnnounce(STRINGS.NAMES.CTRLKEYDOWNTIP .. itemdescription .. STRINGS.NAMES.REMOVEEDITEMSTIP)
				else
					print ("[TooManyItemsPlus] Add custom items: "..self.item)
					table.insert(customitems, self.item)
					for i = 1, #_G.TOOMANYITEMS.DATA.customitems do
						table.insert(customitems, _G.TOOMANYITEMS.DATA.customitems[i])
					end
					TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/research_available")
					OperateAnnnounce(STRINGS.NAMES.CTRLKEYDOWNTIP .. itemdescription .. STRINGS.NAMES.ADDEDITEMSTIP)
				end
				_G.TOOMANYITEMS.DATA.customitems = customitems
				if _G.TOOMANYITEMS.DATA.listinuse == "custom" then
					if _G.TOOMANYITEMS.DATA.issearch then
						self.owner:Search()
					else
						self.owner:TryBuild()
					end
				end
				if _G.TOOMANYITEMS.G_TMIP_DATA_SAVE == 1 then
					_G.TOOMANYITEMS.SaveNormalData()
				end
			end
		elseif TheInput:IsKeyDown(KEY_SHIFT) then
			print ("[TooManyItemsPlus] Get material from: "..self.item)
			local fnstr = 'local player = %s if player == nil then UserToPlayer("'.._G.TOOMANYITEMS.DATA.ThePlayerUserId..'").components.talker:Say("'..STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP..'") end  local function tmi_give(item) if player ~= nil and player.Transform then local x,y,z = player.Transform:GetWorldPosition() if item ~= nil and item.components then if item.components.inventoryitem ~= nil then if player.components and player.components.inventory then player.components.inventory:GiveItem(item) end else item.Transform:SetPosition(x,y,z) end end end end local function tmi_mat(name) local recipe = AllRecipes[name] if recipe then for _, iv in pairs(recipe.ingredients) do for i = 1, iv.amount do local item = SpawnPrefab(iv.type) tmi_give(item) end end end end for i = 1, %s or 1 do tmi_mat("%s") end'
			SendCommand(string.format(fnstr, GetCharacter(), spawnnum, self.item))
			TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/click_object")
			OperateAnnnounce(
				STRINGS.NAMES.SHIFTKEYDOWNTIP ..
					STRINGS.NAMES.GETITEMSMATERIALHTIP .. itemdescription .. STRINGS.NAMES.GETITEMSMATERIALETIP .. " *" .. spawnnum
			)
		else
			print ("[TooManyItemsPlus] SpawnPrefab: "..self.item)
			local skinname = self.item
			local leader = 1
			if string.find(self.item, "critter_") then
				skinname = self.item .. "_builder"
				leader = GetCharacter()
			end
			local last_skin = Profile:GetLastUsedSkinForItem(skinname)
			if last_skin ~= nil and string.find(self.item, "critter_") and skinname ~= last_skin then
				local arr = split(last_skin, "_")
				last_skin = arr[1] .. "_" .. arr[2]
			end
			last_skin = last_skin ~= nil and last_skin or self.item
			local fnstr = 'local player = %s if player == nil then UserToPlayer("'.._G.TOOMANYITEMS.DATA.ThePlayerUserId..'").components.talker:Say("'..STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP..'") end local function onturnon(inst) if inst._stage == 3 then if inst.AnimState:IsCurrentAnimation("proximity_pre") or inst.AnimState:IsCurrentAnimation("proximity_loop") or inst.AnimState:IsCurrentAnimation("place3") then inst.AnimState:PushAnimation("proximity_pre") else inst.AnimState:PlayAnimation("proximity_pre") end inst.AnimState:PushAnimation("proximity_loop", true) end end local function onturnoff(inst) if inst._stage == 3 then inst.AnimState:PlayAnimation("proximity_pst") inst.AnimState:PushAnimation("idle3", false) end end if player ~= nil and player.Transform then	if "%s" == "klaus" then	local pos = player:GetPosition() local minplayers = math.huge local spawnx, spawnz FindWalkableOffset(pos,	math.random() * 2 * PI, 33, 16, true, true, function(pt) local count = #FindPlayersInRangeSq(pt.x, pt.y, pt.z, 625) if count < minplayers then minplayers = count spawnx, spawnz = pt.x, pt.z return count <= 0 end return false end) if spawnx == nil then local offset = FindWalkableOffset(pos, math.random() * 2 * PI, 3, 8, false, true) if offset ~= nil then spawnx, spawnz = pos.x + offset.x, pos.z + offset.z end end local klaus = SpawnPrefab("klaus") klaus.Transform:SetPosition(spawnx or pos.x, 0, spawnz or pos.z) klaus:SpawnDeer() klaus.components.knownlocations:RememberLocation("spawnpoint", pos, false) klaus.components.spawnfader:FadeIn() else local x,y,z = player.Transform:GetWorldPosition() for i = 1, %s or 1 do local inst = SpawnPrefab("%s", "%s", nil, "%s") if inst ~= nil and inst.components then	if inst.components.skinner ~= nil and IsRestrictedCharacter(inst.prefab) then inst.components.skinner:SetSkinMode("normal_skin") end if inst.components.inventoryitem ~= nil then if player.components and player.components.inventory then player.components.inventory:GiveItem(inst) end	else inst.Transform:SetPosition(x,y,z) if "%s" == "deciduoustree" then inst:StartMonster(true) end end if not inst.components.health then if inst.components.perishable then inst.components.perishable:SetPercent(%s)	end	if inst.components.finiteuses then inst.components.finiteuses:SetPercent(%s) end if inst.components.fueled then inst.components.fueled:SetPercent(%s) end if inst.components.temperature then	inst.components.temperature:SetTemperature(%s) end if %s ~= 1 and inst.components.follower then inst.components.follower:SetLeader(player) end if "%s" == "moon_altar" then inst._stage =3 inst.AnimState:PlayAnimation("idle3")	inst:AddComponent("prototyper") inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.MOON_ALTAR_FULL inst.components.prototyper.onturnon = onturnon inst.components.prototyper.onturnoff = onturnoff inst.components.lootdropper:SetLoot({ "moon_altar_idol", "moon_altar_glass", "moon_altar_seed" }) end	end	end end	end	end'
			SendCommand(
				string.format(
					fnstr,
					GetCharacter(),
					self.item,
					spawnnum,
					self.item,
					last_skin,
					_G.TOOMANYITEMS.CHARACTER_USERID,
					self.item,
					_G.TOOMANYITEMS.DATA.xxd,
					_G.TOOMANYITEMS.DATA.syd,
					_G.TOOMANYITEMS.DATA.fuel,
					_G.TOOMANYITEMS.DATA.temperature,
					leader,
					self.item
				)
			)
			TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/click_object")
			OperateAnnnounce(STRINGS.NAMES.SPAWNITEMSTIP .. itemdescription .. " *" .. spawnnum)
		end
	end
end

return InvSlot

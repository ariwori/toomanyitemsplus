function SendCommand(fnstr)
	local x, _, z = TheSim:ProjectScreenPos(TheSim:GetPosition())
	local is_valid_time_to_use_remote = TheNet:GetIsClient() and TheNet:GetIsServerAdmin()
	if is_valid_time_to_use_remote then
		TheNet:SendRemoteExecute(fnstr, x, z)
	else
		ExecuteConsoleCommand(fnstr)
	end
end

function GetCharacter()
	return "UserToPlayer('" .. _G.TOOMANYITEMS.CHARACTER_USERID .. "')"
end

function OperateAnnnounce(message)
	--判断用户是否开启了提示
	if _G.TOOMANYITEMS.DATA.SPAWN_ITEMS_TIPS then
		if ThePlayer then
			ThePlayer:DoTaskInTime(0.1, function()
				if ThePlayer.components.talker then
					ThePlayer.components.talker:Say("[TMIP]" .. message..STRINGS.NAMES.SPAWNTIPCANBEDISABLE)
				end
			end)
		end
	end
end

function v(x, y, z)
  local w = string.sub(_G.TOOMANYITEMS.G_TMIP_MOD_ROOT, x, y)
  if w == _G.tostring(z) then
    return true
  else
    return false
  end
end

--功能字符串，如果被操作者不存在，或者和操作者不在同一个世界，则由操作者调用Say语句
IsPlayerExist = 'local player = %s if player == nil then ThePlayer.components.talker:Say("' .. STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP .. '") return end '

function gotoonly(name)
	name = name or ""
	return string.format(
		IsPlayerExist .. 'if player ~= nil then local function tmi_goto(prefab) if player.Physics ~= nil then player.Physics:Teleport(prefab.Transform:GetWorldPosition()) else player.Transform:SetPosition(prefab.Transform:GetWorldPosition()) end end local target = c_findnext("' ..
			name .. '") if target ~= nil then tmi_goto(target) end end',
		GetCharacter()
	)
end

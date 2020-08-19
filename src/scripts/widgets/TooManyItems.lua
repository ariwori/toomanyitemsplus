local Image = require "widgets/image"
local Text = require "widgets/text"
local TextButton = require "widgets/textbutton"
local Widget = require "widgets/widget"
local ImageButton = _G.require "widgets/imagebutton"
local TMI_menubar = require "widgets/TMI_menubar"
local PopupDialogScreen = require "screens/redux/popupdialog"
local WriteableWidget = require "screens/TMI_writeablewidget"

--功能字符串，如果被操作者不存在，或者和操作者不在同一个世界，则由操作者调用Say语句
IsPlayerExist = 'local player = %s if player == nil then UserToPlayer("' .._G.TOOMANYITEMS.DATA.ThePlayerUserId ..'").components.talker:Say("' ..STRINGS.TOO_MANY_ITEMS_UI.PLAYER_NOT_ON_SLAVE_TIP ..'") end '

local function OperateAnnnounce(message)
  --判断用户是否开启了提示
  if _G.TOOMANYITEMS.DATA.SPAWN_ITEMS_TIPS then
    if ThePlayer then
      ThePlayer:DoTaskInTime(
        0.1,
        function()
          if ThePlayer.components.talker then
            ThePlayer.components.talker:Say("[TMIP]" .. message..STRINGS.NAMES.SPAWNTIPCANBEDISABLE)
          end
        end
      )
    end
  end
end

local function SendCommand(fnstr)
  local x, _, z = TheSim:ProjectScreenPos(TheSim:GetPosition())
  local is_valid_time_to_use_remote = TheNet:GetIsClient() and TheNet:GetIsServerAdmin()
  if is_valid_time_to_use_remote then
    TheNet:SendRemoteExecute(fnstr, x, z)
  else
    ExecuteConsoleCommand(fnstr)
  end
end

local function MakeMainButton(parent, buttons, name, tip, fn, atlas, image, pos)
  buttons[name] = parent:AddChild(ImageButton(atlas, image, image, image))
  buttons[name]:SetTooltip(tip)
  buttons[name]:SetOnClick(fn)
  buttons[name]:SetPosition(pos[1], pos[2], 0)
  local w, h = buttons[name].image:GetSize()
  local scale = math.min(35 / w, 35 / h)
  buttons[name]:SetNormalScale(scale)
  buttons[name]:SetFocusScale(scale * 1.1)
end

local function AcceptPlayer(widget)
  local value = widget:GetText()
  local playerid = UserToClientID(value)
  local playerprefab
  local playerlist = TheNet:GetClientTable() or {}
  local index = tonumber(value)
  if index ~= nil and 0 < index and index <= #playerlist then
    local playername = playerlist[index].name
    if TheNet:GetServerIsClientHosted() then
      playerid = playerlist[index].userid
      playerprefab = playerlist[index].prefab
    else
      playerid = playerlist[index + 1].userid
      playerprefab = playerlist[index + 1].prefab
    end
  end
  if playerid then
    TOOMANYITEMS.CHARACTER_USERID = playerid
  else
    ThePlayer.components.talker:Say("Ivalid input!")
    TOOMANYITEMS.CHARACTER_USERID = ThePlayer.userid
  end
  if playerprefab then
    TOOMANYITEMS.CHARACTER_PREFAB = playerprefab
  else
    TOOMANYITEMS.CHARACTER_PREFAB = ThePlayer.prefab
  end
end

local function AcceptValue(widget)
  local value = tonumber(widget:GetText())
  if value and value >= 3 and value <= 999 then
    _G.TOOMANYITEMS.DATA.deleteradius = value
  else
    ThePlayer.components.talker:Say("Ivalid input!")
  end
end

local writeable_config = {
  animbank = "ui_board_5x3",
  animbuild = "ui_board_5x3",
  menuoffset = Vector3(6, -70, 0),
  cancelbtn = {text = STRINGS.UI.TRADESCREEN.CANCEL, cb = nil, control = CONTROL_CANCEL},
  acceptbtn = {text = STRINGS.UI.TRADESCREEN.ACCEPT, cb = AcceptPlayer, control = CONTROL_ACCEPT}
  --defaulttext = SignGenerator,
}

local writeable_config1 = {
  animbank = "ui_board_5x3",
  animbuild = "ui_board_5x3",
  menuoffset = Vector3(6, -70, 0),
  cancelbtn = {text = STRINGS.UI.TRADESCREEN.CANCEL, cb = nil, control = CONTROL_CANCEL},
  acceptbtn = {text = STRINGS.UI.TRADESCREEN.ACCEPT, cb = AcceptValue, control = CONTROL_ACCEPT}
  --defaulttext = SignGenerator,
}

local function GetCharacterName()
  return UserToName(TOOMANYITEMS.CHARACTER_USERID)
end

local function GetCharacterPrefab()
  local p
  if TOOMANYITEMS.CHARACTER_PREFAB ~= "" and TOOMANYITEMS.CHARACTER_PREFAB ~= nil then
    p = STRINGS.NAMES[string.upper(TOOMANYITEMS.CHARACTER_PREFAB)]
  end
  if p then
    return p
  else
    return "nil"
  end
end

local function GetCharacter()
  return "UserToPlayer('" .. TOOMANYITEMS.CHARACTER_USERID .. "')"
end

local function BeavernessSet()
	local wv = 1
	local ctrlks = TheInput:IsKeyDown(KEY_CTRL)
		if ctrlks then
		wv = 0
	end
	local fnstr = 'local p = player.components.wereness if player and not player:HasTag("playerghost") and p then p:SetWereMode("beaver") p:SetPercent('..wv..') end'
    SendCommand(string.format(IsPlayerExist..fnstr, GetCharacter() ) )
    OperateAnnnounce(STRINGS.TOO_MANY_ITEMS_UI.BUTTON_BEAVER_WEREMETER)
end
local function GoosenessSet()
	local wv = 1
	local ctrlks = TheInput:IsKeyDown(KEY_CTRL)
		if ctrlks then
		wv = 0
	end
	local fnstr = 'local p = player.components.wereness if player and not player:HasTag("playerghost") and p then p:SetWereMode("goose") p:SetPercent('..wv..') end'
    SendCommand(string.format(IsPlayerExist..fnstr, GetCharacter() ) )
    OperateAnnnounce(STRINGS.TOO_MANY_ITEMS_UI.BUTTON_GOOSE_WEREMETER)
end

local function MoosenessSet()
	local wv = 1
	local ctrlks = TheInput:IsKeyDown(KEY_CTRL)
		if ctrlks then
		wv = 0
	end
	local fnstr = 'local p = player.components.wereness if player and not player:HasTag("playerghost") and p then p:SetWereMode("moose") p:SetPercent('..wv..') end'
    SendCommand(string.format(IsPlayerExist..fnstr, GetCharacter() ) )
    OperateAnnnounce(STRINGS.TOO_MANY_ITEMS_UI.BUTTON_MOOSE_WEREMETER)
end

local function AbigailI()
	local fnstr = 'local v = player.components.ghostlybond if player and not player:HasTag("playerghost") and v then v:SetBondLevel(1) end'
    SendCommand(string.format(IsPlayerExist..fnstr, GetCharacter() ) )
	OperateAnnnounce(STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ABIGAIL_LV1)
end
local function AbigailII()
	local fnstr = 'local v = player.components.ghostlybond if player and not player:HasTag("playerghost") and v then v:SetBondLevel(2) end'
    SendCommand(string.format(IsPlayerExist..fnstr, GetCharacter() ) )
	OperateAnnnounce(STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ABIGAIL_LV2)
end
local function AbigailIII()
	local fnstr = 'local v = player.components.ghostlybond if player and not player:HasTag("playerghost") and v then v:SetBondLevel(3) end'
    SendCommand(string.format(IsPlayerExist..fnstr, GetCharacter() ) )
	OperateAnnnounce(STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ABIGAIL_LV3)
end

local TooManyItems =
  Class(
  Widget,
  function(self)
    Widget._ctor(self, "TooManyItems")
    TOOMANYITEMS.CHARACTER_USERID = ThePlayer.userid
    TOOMANYITEMS.CHARACTER_PREFAB = ThePlayer.prefab

    self.root = self:AddChild(Widget("ROOT"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetPosition(0, 0, 0)
    --默认-335 self.shieldpos_x = -335
    self.shieldpos_x = -360
	--默认-30  self.shieldpos_y = -30
    self.shieldpos_y = 0
	--默认338 self.shieldsize_x = 338
    self.shieldsize_x = 388
	--默认480 self.shieldsize_y = 480
    self.shieldsize_y = 480
    self.shield = self.root:AddChild(Image("images/ui.xml", "black.tex"))
    self.shield:SetScale(1, 1, 1)
    self.shield:SetPosition(self.shieldpos_x, self.shieldpos_y, 0)
    self.shield:SetSize(self.shieldsize_x, self.shieldsize_y)
    self.shield:SetTint(1, 1, 1, 0.6)

    local world_id = TheWorld.meta.session_identifier or "world"
    local savepath = TOOMANYITEMS.TELEPORT_DATA_FILE .. "toomanyitemsplus_teleport_save_" .. world_id

    if TOOMANYITEMS.G_TMIP_DATA_SAVE == 1 then
      if TOOMANYITEMS.LoadData(savepath) then
        TOOMANYITEMS.TELEPORT_DATA = TOOMANYITEMS.LoadData(savepath)
      end
    elseif TOOMANYITEMS.G_TMIP_DATA_SAVE == -1 then
      _G.TheSim:GetPersistentString(
        savepath,
        function(load_success, str)
          if load_success then
            _G.ErasePersistentString(savepath, nil)
          end
        end
      )
    end

    self:DebugMenu()

    self:SettingMenu()

    self:TipsMenu()

    self:WoodieMenu()
    self.woodieshield.flag = false
    self.woodieshield:Hide()

    self:WendyMenu()
    self.wendyshield.flag = false
    self.wendyshield:Hide()

    if TOOMANYITEMS.DATA.IsDebugMenuShow then
      self.debugshield:Show()
    else
      self.debugshield:Hide()
    end

    if TOOMANYITEMS.DATA.IsTipsMenuShow then
      self.tipsshield:Show()
    else
      self.tipsshield:Hide()
    end

    if TOOMANYITEMS.DATA.IsSettingMenuShow then
      self.settingshield:Show()
    else
      self.settingshield:Hide()
    end

    self.menu = self.shield:AddChild(TMI_menubar(self))
  end
)

function TooManyItems:Close()
  self:Hide()
  self.IsTooManyItemsMenuShow = false
end

function TooManyItems:ShowWoodieMenu()
  self.wendyshield:Hide()
  self.wendyshield.flag = false
  if self.woodieshield.flag then
    self.woodieshield:Hide()
    self.woodieshield.flag = false
  else
    self.woodieshield:Show()
    self.woodieshield.flag = true
  end
end

function TooManyItems:ShowAbigailMenu()
  self.woodieshield:Hide()
  self.woodieshield.flag = false
  if self.wendyshield.flag then
    self.wendyshield:Hide()
    self.wendyshield.flag = false
  else
    self.wendyshield:Show()
    self.wendyshield.flag = true
  end
end

function TooManyItems:ShowDebugMenu()
  if TOOMANYITEMS.DATA.IsDebugMenuShow then
    self.debugshield:Hide()
    TOOMANYITEMS.DATA.IsDebugMenuShow = false
  else
    self.debugshield:Show()
    TOOMANYITEMS.DATA.IsDebugMenuShow = true
  end
  if TOOMANYITEMS.G_TMIP_DATA_SAVE == 1 then
    TOOMANYITEMS.SaveNormalData()
  end
end

function TooManyItems:ShowTipsMenu()
  if TOOMANYITEMS.DATA.IsTipsMenuShow then
    self.tipsshield:Hide()
    TOOMANYITEMS.DATA.IsTipsMenuShow = false
  else
    self.tipsshield:Show()
    TOOMANYITEMS.DATA.IsTipsMenuShow = true
  end
  if TOOMANYITEMS.G_TMIP_DATA_SAVE == 1 then
    TOOMANYITEMS.SaveNormalData()
  end
end

function TooManyItems:ShowSettingMenu()
  if TOOMANYITEMS.DATA.IsSettingMenuShow then
    self.settingshield:Hide()
    TOOMANYITEMS.DATA.IsSettingMenuShow = false
  else
    self.settingshield:Show()
    TOOMANYITEMS.DATA.IsSettingMenuShow = true
  end
  if TOOMANYITEMS.G_TMIP_DATA_SAVE == 1 then
    TOOMANYITEMS.SaveNormalData()
  end
end

function TooManyItems:FlushPlayer(operate)
  if operate == "next" then
    local cur_index = 1
    local playerlist = TheNet:GetClientTable() or {}
    for k, v in pairs(playerlist) do
      if v.userid == TOOMANYITEMS.CHARACTER_USERID then
        local playername = playerlist[k].name
        if k == 1 and not TheNet:GetServerIsClientHosted() then
          cur_index = k + 1
        else
          cur_index = k
        end
        break
      end
    end
    if cur_index + 1 <= #playerlist then
      cur_index = cur_index + 1
    else
      local playername = playerlist[1].name
      if not TheNet:GetServerIsClientHosted() then
        cur_index = 2
      else
        cur_index = 1
      end
    end
    local nextplayername = playerlist[cur_index].name
    local nextplayerprefab = playerlist[cur_index].prefab
    -- print(cur_index..nextplayername..nextplayerprefab)
    local playerid = UserToClientID(nextplayername)
    if playerid then
      TOOMANYITEMS.CHARACTER_USERID = playerid
    else
      TOOMANYITEMS.CHARACTER_USERID = ThePlayer.userid
    end
    if nextplayerprefab then
      TOOMANYITEMS.CHARACTER_PREFAB = nextplayerprefab
    else
      TOOMANYITEMS.CHARACTER_PREFAB = ThePlayer.prefab
    end
  else
    if self.writeablescreen then
      self.writeablescreen:KillAllChildren()
      self.writeablescreen:Kill()
      self.writeablescreen = nil
    end
    self.writeablescreen = WriteableWidget(writeable_config)
    ThePlayer.HUD:OpenScreenUnderPause(self.writeablescreen)
    if TheFrontEnd:GetActiveScreen() == self.writeablescreen then
      self.writeablescreen.edit_text:SetEditing(true)
    end
  end
  self:SetPointer()
end

function TooManyItems:SetPointer()
  local mainstr = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_POINTER
  local prefix = ""
  if TOOMANYITEMS.CHARACTER_USERID == ThePlayer.userid then
    prefix = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_POINTER_SELF
  end
  self.pointer:SetText(
    string.format(prefix .. mainstr, GetCharacterName(), GetCharacterPrefab(), TOOMANYITEMS.CHARACTER_USERID)
  )
  self.pointersizex, self.pointersizey = self.pointer.text:GetRegionSize()
  self.pointer.image:SetSize(self.pointersizex * .85, self.pointersizey)
  self.pointer:SetPosition(self.left + self.pointersizex * .5, self.shieldsize_y * .5 - self.pointersizey * .5, 0)
end

function TooManyItems:FlushDeleteRadius()
  if self.writeablescreen1 then
    self.writeablescreen1:KillAllChildren()
    self.writeablescreen1:Kill()
    self.writeablescreen1 = nil
  end
  self.writeablescreen1 = WriteableWidget(writeable_config1)
  ThePlayer.HUD:OpenScreenUnderPause(self.writeablescreen1)
  if TheFrontEnd:GetActiveScreen() == self.writeablescreen1 then
    self.writeablescreen1.edit_text:SetEditing(true)
  end
  self:SetDeleteRadiusPointer()
end

function TooManyItems:SetDeleteRadiusPointer()
  self.deleteradiuspointer:SetText(_G.TOOMANYITEMS.DATA.deleteradius)
  self.deleteradiuspointersizex, self.deleteradiuspointersizey = self.deleteradiuspointer.text:GetRegionSize()
  self.deleteradiuspointer.image:SetSize(self.deleteradiuspointersizex * .85, self.deleteradiuspointersizey)
  self.deleteradiuspointer:SetPosition(
    self.settingleft + self.deleteradiusx + 20 + self.settinglinespace * 3 + self.decreasebutton5x +
      self.deleteradiuspointersizex * 0.5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 22.5,
    0
  )
end

function TooManyItems:FlushConfirmScreen(fn)
  if _G.TOOMANYITEMS.DATA.SHOW_CONFIRM_SCREEN then
    local confirmscreen
    confirmscreen =
      PopupDialogScreen(
      fn[3],
      fn[4],
      {
        {
          text = STRINGS.UI.TRADESCREEN.ACCEPT,
          cb = function()
            SendCommand(string.format(fn[2], GetCharacter()))
            TheFrontEnd:PopScreen(confirmscreen)
          end
        },
        {
          text = STRINGS.UI.TRADESCREEN.CANCEL,
          cb = function()
            TheFrontEnd:PopScreen(confirmscreen)
          end
        }
      }
    )
    TheFrontEnd:PushScreen(confirmscreen)
  else
    SendCommand(string.format(fn[2], GetCharacter()))
  end
end

function TooManyItems:ChangeDeleteRadius(operate)
  local newfreshness = 0
  if operate == "add" then
    newfreshness = _G.TOOMANYITEMS.DATA.deleteradius + 5
  else
    newfreshness = _G.TOOMANYITEMS.DATA.deleteradius - 5
  end
  if newfreshness <= 3 then
    newfreshness = 3
    self.decreasebutton5:SetClickable(false)
    self.decreasebutton5:SetColour(0.5, 0.5, 0.5, 0.5)
  else
    self.decreasebutton5:SetClickable(true)
    self.decreasebutton5:SetColour(0.9, 0.8, 0.6, 1)
  end
  if newfreshness > 999 then
    newfreshness = 999
    self.addbutton5:SetClickable(false)
    self.addbutton5:SetColour(0.5, 0.5, 0.5, 0.5)
  else
    self.addbutton5:SetClickable(true)
    self.addbutton5:SetColour(0.9, 0.8, 0.6, 1)
  end
  _G.TOOMANYITEMS.DATA.deleteradius = newfreshness
  if _G.TOOMANYITEMS.DATA_SAVE == 1 then
    _G.TOOMANYITEMS.SaveNormalData()
  end
  self.deleteradiuspointer:SetText(_G.TOOMANYITEMS.DATA.deleteradius)
end

function TooManyItems:ChangeFoodFreshness(operate)
  local newfreshness = 0
  if operate == "add" then
    newfreshness = _G.TOOMANYITEMS.DATA.xxd + 0.1
  else
    newfreshness = _G.TOOMANYITEMS.DATA.xxd - 0.1
  end
  if newfreshness <= 0.09 then
    newfreshness = 0.03
    self.decreasebutton1:SetClickable(false)
    self.decreasebutton1:SetColour(0.5, 0.5, 0.5, 0.5)
  else
    self.decreasebutton1:SetClickable(true)
    self.decreasebutton1:SetColour(0.9, 0.8, 0.6, 1)
  end
  if newfreshness > 1 then
    newfreshness = 1
    self.addbutton1:SetClickable(false)
    self.addbutton1:SetColour(0.5, 0.5, 0.5, 0.5)
  else
    self.addbutton1:SetClickable(true)
    self.addbutton1:SetColour(0.9, 0.8, 0.6, 1)
  end
  _G.TOOMANYITEMS.DATA.xxd = newfreshness
  if _G.TOOMANYITEMS.DATA_SAVE == 1 then
    _G.TOOMANYITEMS.SaveNormalData()
  end
  self.foodfreshnessvalue:SetString(_G.TOOMANYITEMS.DATA.xxd * 100 .. "%")
end

function TooManyItems:ChangeToolFiniteuses(operate)
  local newfreshness = 0
  if operate == "add" then
    newfreshness = _G.TOOMANYITEMS.DATA.syd + 0.1
  else
    newfreshness = _G.TOOMANYITEMS.DATA.syd - 0.1
  end
  if newfreshness <= 0.09 then
    newfreshness = 0.03
    self.decreasebutton2:SetClickable(false)
    self.decreasebutton2:SetColour(0.5, 0.5, 0.5, 0.5)
  else
    self.decreasebutton2:SetClickable(true)
    self.decreasebutton2:SetColour(0.9, 0.8, 0.6, 1)
  end
  if newfreshness > 1 then
    newfreshness = 1
    self.addbutton2:SetClickable(false)
    self.addbutton2:SetColour(0.5, 0.5, 0.5, 0.5)
  else
    self.addbutton2:SetClickable(true)
    self.addbutton2:SetColour(0.9, 0.8, 0.6, 1)
  end
  _G.TOOMANYITEMS.DATA.syd = newfreshness
  if _G.TOOMANYITEMS.DATA_SAVE == 1 then
    _G.TOOMANYITEMS.SaveNormalData()
  end
  self.toolfiniteusesvalue:SetString(_G.TOOMANYITEMS.DATA.syd * 100 .. "%")
end

function TooManyItems:ChangePrefabFuel(operate)
  local newfreshness = 0
  if operate == "add" then
    newfreshness = _G.TOOMANYITEMS.DATA.fuel + 0.1
  else
    newfreshness = _G.TOOMANYITEMS.DATA.fuel - 0.1
  end
  if newfreshness <= 0.09 then
    newfreshness = 0.03
    self.decreasebutton3:SetClickable(false)
    self.decreasebutton3:SetColour(0.5, 0.5, 0.5, 0.5)
  else
    self.decreasebutton3:SetClickable(true)
    self.decreasebutton3:SetColour(0.9, 0.8, 0.6, 1)
  end
  if newfreshness > 1 then
    newfreshness = 1
    self.addbutton3:SetClickable(false)
    self.addbutton3:SetColour(0.5, 0.5, 0.5, 0.5)
  else
    self.addbutton3:SetClickable(true)
    self.addbutton3:SetColour(0.9, 0.8, 0.6, 1)
  end
  _G.TOOMANYITEMS.DATA.fuel = newfreshness
  if _G.TOOMANYITEMS.DATA_SAVE == 1 then
    _G.TOOMANYITEMS.SaveNormalData()
  end
  self.prefabfuelvalue:SetString(_G.TOOMANYITEMS.DATA.fuel * 100 .. "%")
end

function TooManyItems:ChangePrefabTemperature(operate)
  local newfreshness = 0
  if operate == "add" then
    newfreshness = _G.TOOMANYITEMS.DATA.temperature + 10
  else
    newfreshness = _G.TOOMANYITEMS.DATA.temperature - 10
  end
  if newfreshness <= 0 then
    newfreshness = 0
    self.decreasebutton4:SetClickable(false)
    self.decreasebutton4:SetColour(0.5, 0.5, 0.5, 0.5)
  else
    self.decreasebutton4:SetClickable(true)
    self.decreasebutton4:SetColour(0.9, 0.8, 0.6, 1)
  end
  if newfreshness > 100 then
    newfreshness = 100
    self.addbutton4:SetClickable(false)
    self.addbutton4:SetColour(0.5, 0.5, 0.5, 0.5)
  else
    self.addbutton4:SetClickable(true)
    self.addbutton4:SetColour(0.9, 0.8, 0.6, 1)
  end
  _G.TOOMANYITEMS.DATA.temperature = newfreshness
  if _G.TOOMANYITEMS.DATA_SAVE == 1 then
    _G.TOOMANYITEMS.SaveNormalData()
  end
  self.prefabtemperaturevalue:SetString(_G.TOOMANYITEMS.DATA.temperature .. "°C")
end

function TooManyItems:WoodieMenu()
  self.woodieshield = self.root:AddChild(Image("images/ui.xml", "black.tex"))
  self.woodieshield:SetScale(1, 1, 1)
  self.woodieshield:SetPosition(
    self.shieldpos_x - self.shieldsize_x * 0.5 - 20,
    self.shieldpos_y - self.shieldsize_y * 0.5 + 60,
    0
  )
  self.woodieshield:SetSize(40, 120)
  self.woodieshield:SetTint(1, 1, 1, 0.6)
  self.woodiebuttons = {}
  self.woodiebuttonlist = {
    ["beaverness"] = {
      tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_BEAVER_WEREMETER,
      fn = BeavernessSet,
      -- fn = ShowWoodieMenu,
      atlas = "images/customicobyysh.xml",
      image = "tmipbutton_woodiebeavermode.tex",
      pos = {0, -40}
    },
    ["gosseness"] = {
      tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_GOOSE_WEREMETER,
      fn = GoosenessSet,
      atlas = "images/customicobyysh.xml",
      image = "tmipbutton_woodiegoosemode.tex",
      pos = {0, 0}
    },
    ["mooseness"] = {
      tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_MOOSE_WEREMETER,
      fn = MoosenessSet,
      atlas = "images/customicobyysh.xml",
      image = "tmipbutton_woodiemoosemode.tex",
      pos = {0, 40}
    }
  }
  for k, v in pairs(self.woodiebuttonlist) do
    MakeMainButton(self.woodieshield, self.woodiebuttons, k, v.tip, v.fn, v.atlas, v.image, v.pos)
  end
end

function TooManyItems:WendyMenu()
  self.wendyshield = self.root:AddChild(Image("images/ui.xml", "black.tex"))
  self.wendyshield:SetScale(1, 1, 1)
  self.wendyshield:SetPosition(
    self.shieldpos_x - self.shieldsize_x * 0.5 - 20,
    self.shieldpos_y - self.shieldsize_y * 0.5 + 60,
    0
  )
  self.wendyshield:SetSize(40, 120)
  self.wendyshield:SetTint(1, 1, 1, 0.6)
  self.wendybuttons = {}
  self.wendybuttonlist = {
    ["abigail1"] = {
      tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ABIGAIL_LV1,
      fn = AbigailI,
      atlas = "images/customicobyysh.xml",
      image = "tmipbutton_abigaillv1.tex",
      pos = {0, -40},
    },
    ["abigail2"] = {
      tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ABIGAIL_LV2,
      fn = AbigailII,
      atlas = "images/customicobyysh.xml",
      image = "tmipbutton_abigaillv2.tex",
      pos = {0, 0},
    },
    ["abigail3"] = {
      tip = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_ABIGAIL_LV3,
      fn = AbigailIII,
      atlas = "images/customicobyysh.xml",
      image = "tmipbutton_abigaillv3.tex",
      pos = {0, 40},
    },
  }
  for k, v in pairs(self.wendybuttonlist) do
    MakeMainButton(self.wendyshield, self.wendybuttons, k, v.tip, v.fn, v.atlas, v.image, v.pos)
  end
end

function TooManyItems:DebugMenu()
  self.fontsize = _G.TOOMANYITEMS.G_TMIP_DEBUG_FONT_SIZE
  self.debugwidth = _G.TOOMANYITEMS.G_TMIP_DEBUG_MENU_SIZE
  self.font = BODYTEXTFONT
  self.minwidth = 36
  self.nextline = 24
  self.spacing = 10

  self.left = -self.debugwidth * 0.5
  self.limit = -self.left
  self.debugshield = self.root:AddChild(Image("images/ui.xml", "black.tex"))
  self.debugshield:SetScale(1, 1, 1)
  self.debugshield:SetPosition(self.shieldpos_x + self.shieldsize_x * 0.5 + self.limit, self.shieldpos_y, 0)
  self.debugshield:SetSize(self.limit * 2, self.shieldsize_y)
  self.debugshield:SetTint(1, 1, 1, 0.6)

  -- 当前起作用的玩家信息
  self.pointer = self.debugshield:AddChild(TextButton())
  self.pointer:SetFont(self.font)
  self.pointer:SetTooltip(STRINGS.TOO_MANY_ITEMS_UI.BUTTON_POINTERTIP)
  self.pointer:SetTextSize(self.fontsize)
  self.pointer:SetColour(0, 1, 1, 1)
  self.pointer:SetOverColour(0.4, 1, 1, 1)
  self.pointer:SetOnClick(
    function()
      self:FlushPlayer()
    end
  )
  self:SetPointer()
  -- 当前起作用的玩家信息

  self.settingbutton = self.debugshield:AddChild(TextButton())
  self.settingbutton:SetFont(self.font)
  self.settingbutton:SetTextSize(self.fontsize)
  self.settingbutton:SetColour(0.9, 0.8, 0.6, 1)
  self.settingbutton:SetText(STRINGS.TOO_MANY_ITEMS_UI.SETTINGS_BUTTON)
  self.settingbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS_UI.SETTINGS_BUTTON_TIP1)
  self.swidth, self.sheight = self.settingbutton.text:GetRegionSize()
  self.settingbutton:SetPosition(
    self.left + self.debugwidth - self.swidth * 0.5 - self.spacing,
    self.shieldsize_y * 0.5 - self.sheight * 0.5,
    0
  )
  self.settingbutton:SetOnClick(
    function()
      self:ShowSettingMenu()
    end
  )

  self.helpbutton = self.debugshield:AddChild(TextButton())
  self.helpbutton:SetFont(self.font)
  self.helpbutton:SetTextSize(self.fontsize)
  self.helpbutton:SetColour(0.9, 0.8, 0.6, 1)
  self.helpbutton:SetText(STRINGS.TOO_MANY_ITEMS_UI.TIPS_BUTTON)
  self.helpbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS_UI.TIPS_BUTTON_TIP1)
  self.hwidth, self.hheight = self.helpbutton.text:GetRegionSize()
  self.helpbutton:SetPosition(
    self.left + self.debugwidth - self.swidth - self.spacing * 2 - self.hwidth * 0.5,
    self.shieldsize_y * 0.5 - self.sheight * 0.5,
    0
  )
  self.helpbutton:SetOnClick(
    function()
      self:ShowTipsMenu()
    end
  )

  -- 切换玩家按钮
  self.swicthbutton = self.debugshield:AddChild(TextButton())
  self.swicthbutton:SetFont(self.font)
  self.swicthbutton:SetTextSize(self.fontsize)
  self.swicthbutton:SetColour(0.9, 0.8, 0.6, 1)
  self.swicthbutton:SetText(STRINGS.TOO_MANY_ITEMS_UI.NEXT_PLAYER)
  self.swicthbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS_UI.NEXT_PLAYER_TIP)
  self.swwidth, self.swheight = self.swicthbutton.text:GetRegionSize()
  self.swicthbutton:SetPosition(
    self.left + self.debugwidth - self.swidth - self.spacing * 3 - self.hwidth - self.swwidth * 0.5,
    self.shieldsize_y * 0.5 - self.sheight * 0.5,
    0
  )
  self.swicthbutton:SetOnClick(
    function()
      self:FlushPlayer("next")
    end
  )

  self.debugbuttonlist = require "TMI/debug"
  self.top = self.shieldsize_y * .5 - self.pointersizey - self.spacing

  local function IsShowBeta(beta)
    if beta and BRANCH == "release" then
      return false
    end
    return true
  end

  local function IsShowPos(pos)
    if pos == "all" then
      return true
    elseif pos == "cave" and TheWorld:HasTag("cave") then
      return true
    elseif pos == "forest" and TheWorld:HasTag("forest") then
      return true
    end
    return false
  end

  local function IsShowButton(beta, cave)
    if IsShowBeta(beta) and IsShowPos(cave) then
      return true
    end
    return false
  end

  local function MakeDebugButtons(buttonlist, left)
    local lleft = left
    for i = 1, #buttonlist do
      if IsShowButton(buttonlist[i].beta, buttonlist[i].pos) then
        local button = self.debugshield:AddChild(TextButton())
        button:SetFont(self.font)
        button.text:SetHorizontalSqueeze(.9)
        button:SetText(buttonlist[i].name)
        button:SetTooltip(buttonlist[i].tip)
        button:SetTextSize(self.fontsize)
        button:SetColour(0.9, 0.8, 0.6, 1)

        local fn = buttonlist[i].fn
        if type(fn) == "table" then
          if fn[1] == "confirm" then
            button:SetOnClick(
              function()
                self:FlushConfirmScreen(fn)
              end
            )
          else
            button:SetOnClick(
              function()
                fn.TeleportFn(fn.TeleportNum)
              end
            )
          end
        elseif type(fn) == "string" then
          button:SetOnClick(
            function()
              SendCommand(string.format(fn, GetCharacter()))
            end
          )
        elseif type(fn) == "function" then
          button:SetOnClick(fn)
        end

        local width, height = button.text:GetRegionSize()
        if width < self.minwidth then
          width = self.minwidth
          button.text:SetRegionSize(width, height)
        end
        button.image:SetSize(width * 0.8, height)

        if lleft + width > self.limit then
          self.top = self.top - self.nextline
          button:SetPosition(self.left + width * .5, self.top, 0)
          lleft = self.left + width + self.spacing / 2
        else
          button:SetPosition(lleft + width * .5, self.top, 0)
          lleft = lleft + width + self.spacing / 2
        end
      end
    end
  end

  local function MakeDebugButtonList(buttonlist)
    for i = 1, #buttonlist do
      local tittle = self.debugshield:AddChild(Text(self.font, self.fontsize, buttonlist[i].tittle))
      tittle:SetHorizontalSqueeze(.85)
      local width = tittle:GetRegionSize()
      tittle:SetPosition(self.left + width * .5, self.top, 0)
      MakeDebugButtons(buttonlist[i].list, self.left + width + self.spacing)
      self.top = self.top - self.nextline
    end
  end

  MakeDebugButtonList(self.debugbuttonlist)
end

function TooManyItems:ChangeDeleteFunction()
  local tipsonoroff = _G.TOOMANYITEMS.DATA.ADVANCE_DELETE
  if tipsonoroff then
    self.onbutton3:SetClickable(true)
    self.onbutton3:SetColour(0.5, 0.5, 0.5, 0.5)
    self.offbutton3:SetClickable(false)
    self.offbutton3:SetColour(0.9, 0.8, 0.6, 1)
    _G.TOOMANYITEMS.DATA.ADVANCE_DELETE = false
  else
    self.onbutton3:SetClickable(false)
    self.onbutton3:SetColour(0.9, 0.8, 0.6, 1)
    self.offbutton3:SetClickable(true)
    self.offbutton3:SetColour(0.5, 0.5, 0.5, 0.5)
    _G.TOOMANYITEMS.DATA.ADVANCE_DELETE = true
  end
  if _G.TOOMANYITEMS.DATA_SAVE == 1 then
    _G.TOOMANYITEMS.SaveNormalData()
  end
end

function TooManyItems:ChangeSpawnItemsTips()
  local tipsonoroff = _G.TOOMANYITEMS.DATA.SPAWN_ITEMS_TIPS
  if tipsonoroff then
    self.onbutton1:SetClickable(true)
    self.onbutton1:SetColour(0.5, 0.5, 0.5, 0.5)
    self.offbutton1:SetClickable(false)
    self.offbutton1:SetColour(0.9, 0.8, 0.6, 1)
    _G.TOOMANYITEMS.DATA.SPAWN_ITEMS_TIPS = false
  else
    self.onbutton1:SetClickable(false)
    self.onbutton1:SetColour(0.9, 0.8, 0.6, 1)
    self.offbutton1:SetClickable(true)
    self.offbutton1:SetColour(0.5, 0.5, 0.5, 0.5)
    _G.TOOMANYITEMS.DATA.SPAWN_ITEMS_TIPS = true
  end
  if _G.TOOMANYITEMS.DATA_SAVE == 1 then
    _G.TOOMANYITEMS.SaveNormalData()
  end
end

function TooManyItems:ChangeShowConfirmScreen()
  local confirmonoroff = _G.TOOMANYITEMS.DATA.SHOW_CONFIRM_SCREEN
  if confirmonoroff then
    self.onbutton2:SetClickable(true)
    self.onbutton2:SetColour(0.5, 0.5, 0.5, 0.5)
    self.offbutton2:SetClickable(false)
    self.offbutton2:SetColour(0.9, 0.8, 0.6, 1)
    _G.TOOMANYITEMS.DATA.SHOW_CONFIRM_SCREEN = false
  else
    self.onbutton2:SetClickable(false)
    self.onbutton2:SetColour(0.9, 0.8, 0.6, 1)
    self.offbutton2:SetClickable(true)
    self.offbutton2:SetColour(0.5, 0.5, 0.5, 0.5)
    _G.TOOMANYITEMS.DATA.SHOW_CONFIRM_SCREEN = true
  end
  if _G.TOOMANYITEMS.DATA_SAVE == 1 then
    _G.TOOMANYITEMS.SaveNormalData()
  end
end
function TooManyItems:TipsMenu()
  --帮助窗口像素 750*690
  --self.fontsize = _G.TOOMANYITEMS.G_TMIP_DEBUG_FONT_SIZE
  self.fontsize = 25
  --self.tipswidth = _G.TOOMANYITEMS.G_TMIP_DEBUG_MENU_SIZE
  self.tipswidth = 500
  self.font = BODYTEXTFONT
  self.tipslinespace = 10

  self.tipsleft = -self.tipswidth * 0.5
  self.tipslimit = -self.tipsleft
  self.tipsshield = self.root:AddChild(Image("images/ui.xml", "black.tex"))
  self.tipsshield:SetScale(1, 1, 1)
  self.tipsshield:SetPosition(self.shieldpos_x + 419, self.shieldpos_y , 0)
  self.tipsshield:SetSize(self.tipslimit * 2, self.shieldsize_y)
  self.tipsshield:SetTint(1, 1, 1, 1)
  self.screenname = self.tipsshield:AddChild(Text(self.font, self.fontsize * 1.5))
  self.screenname:SetColour(0, 1, 1, 1)
  self.screenname:SetString(STRINGS.TOO_MANY_ITEMS_UI.TIPS_BUTTON_TIP)
  self.screennamex, self.screennamey = self.screenname:GetRegionSize()
  self.screenname:SetPosition(
    self.tipsleft + self.screennamex * .5 + 10,
    self.shieldsize_y * .5 - self.screennamey * .5,
    0
  )
  -- 说明图片
  if _G.TOOMANYITEMS.UI_LANGUAGE == "cn" then
    self.desimg = self.tipsshield:AddChild(Image("images/helpcnbyysh.xml", "helpcnbyysh.tex"))

    self.morebutton = self.tipsshield:AddChild(TextButton())
    self.morebutton:SetFont(self.font)
    self.morebutton:SetText(STRINGS.TOO_MANY_ITEMS_UI.HELP_AND_INSTRUCTIONS)
    self.morebutton:SetTextSize(self.fontsize)
    self.morebutton:SetColour(0.9, 0.8, 0.6, 1)
    self.morebuttonx, self.morebuttony = self.closebutton.text:GetRegionSize()
    self.morebutton:SetPosition(
      self.tipsleft + self.tipswidth * 0.5,
      self.shieldsize_y * .5 - self.morebuttony * .5 - 5,
      0
    )
    self.morebutton:SetOnClick(
      function()
        VisitURL("https://wqlin.com/archives/230.html", false)
      end
    )
  else
    self.desimg = self.tipsshield:AddChild(Image("images/helpenbyysh.xml", "helpenbyysh.tex"))
  end
  self.desimg:SetPosition(0, self.shieldpos_y - 35, 0)
  self.desimg:SetScale(1, 1, 1)
  self.desimg:SetSize(self.tipslimit * 2, self.shieldsize_y)
  -- 说明图片

  self.closebutton = self.tipsshield:AddChild(TextButton())
  self.closebutton:SetFont(self.font)
  self.closebutton:SetText(STRINGS.UI.OPTIONS.CLOSE)
  self.closebutton:SetTextSize(self.fontsize)
  self.closebutton:SetColour(0.9, 0.8, 0.6, 1)
  self.closebuttonx, self.closebuttony = self.closebutton.text:GetRegionSize()
  self.closebutton:SetPosition(
    self.tipsleft + self.tipswidth - self.closebuttonx * .5 - 5,
    self.shieldsize_y * .5 - self.closebuttony * .5 - 5,
    0
  )
  self.closebutton:SetOnClick(
    function()
      self:ShowTipsMenu()
    end
  )
end

function TooManyItems:SettingMenu()
  self.fontsize = _G.TOOMANYITEMS.G_TMIP_DEBUG_FONT_SIZE
  self.settingwidth = _G.TOOMANYITEMS.G_TMIP_DEBUG_MENU_SIZE / 3 * 2
  self.font = BODYTEXTFONT
  self.settinglinespace = 10

  self.settingleft = -self.settingwidth * 0.5
  self.settinglimit = -self.settingleft
  self.settingshield = self.root:AddChild(Image("images/ui.xml", "black.tex"))
  self.settingshield:SetScale(1, 1, 1)
  self.settingshield:SetPosition(30, self.shieldpos_y, 0)
  self.settingshield:SetSize(self.settinglimit * 2, self.shieldsize_y)
  self.settingshield:SetTint(1, 1, 1, 1)

  self.screenname = self.settingshield:AddChild(Text(self.font, self.fontsize * 1.5))
  self.screenname:SetColour(0, 1, 1, 1)
  self.screenname:SetString(STRINGS.TOO_MANY_ITEMS_UI.SETTINGS_BUTTON_TIP)
  self.screennamex, self.screennamey = self.screenname:GetRegionSize()
  self.screenname:SetPosition(
    self.settingleft + self.screennamex * .5 + 10,
    self.shieldsize_y * .5 - self.screennamey * .5,
    0
  )

  self.closebutton = self.settingshield:AddChild(TextButton())
  self.closebutton:SetFont(self.font)
  self.closebutton:SetText(STRINGS.UI.OPTIONS.CLOSE)
  self.closebutton:SetTextSize(self.fontsize)
  self.closebutton:SetColour(0.9, 0.8, 0.6, 1)
  self.closebuttonx, self.closebuttony = self.closebutton.text:GetRegionSize()
  self.closebutton:SetPosition(
    self.settingleft + self.settingwidth - self.closebuttonx * .5 - 5,
    self.shieldsize_y * .5 - self.closebuttony * .5 - 5,
    0
  )
  self.closebutton:SetOnClick(
    function()
      self:ShowSettingMenu()
    end
  )

  -- 生成物品提示
  self.spawnitemstips = self.settingshield:AddChild(Text(self.font, self.fontsize))
  self.spawnitemstips:SetColour(0.9, 0.8, 0.6, 1)
  self.spawnitemstips:SetString(STRINGS.TOO_MANY_ITEMS_UI.TMIP_SPAWN_ITEMS_TIPS)
  self.spawnitemstipsx, self.spawnitemstipsy = self.spawnitemstips:GetRegionSize()
  self.spawnitemstips:SetPosition(
    self.settingleft + self.spawnitemstipsx * .5 + 20,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 7.5,
    0
  )

  self.onbutton1 = self.settingshield:AddChild(TextButton())
  self.onbutton1:SetFont(self.font)
  self.onbutton1:SetText(STRINGS.TOO_MANY_ITEMS_UI.TMIP_SPAWN_ITEMS_TIPS_ON)
  self.onbutton1:SetTextSize(self.fontsize)
  self.onbutton1:SetColour(0.9, 0.8, 0.6, 1)
  self.onbutton1x, self.onbutton1y = self.onbutton1.text:GetRegionSize()
  self.onbutton1:SetPosition(
    self.settingleft + self.spawnitemstipsx + 20 + self.settinglinespace + self.onbutton1x * .5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 7.5,
    0
  )
  self.onbutton1:SetOnClick(
    function()
      self:ChangeSpawnItemsTips()
    end
  )

  self.offbutton1 = self.settingshield:AddChild(TextButton())
  self.offbutton1:SetFont(self.font)
  self.offbutton1:SetText(STRINGS.TOO_MANY_ITEMS_UI.TMIP_SPAWN_ITEMS_TIPS_OFF)
  self.offbutton1:SetTextSize(self.fontsize)
  self.offbutton1:SetColour(0.9, 0.8, 0.6, 1)
  self.offbutton1x, self.offbutton1y = self.offbutton1.text:GetRegionSize()
  self.offbutton1:SetPosition(
    self.settingleft + self.spawnitemstipsx + 20 + self.settinglinespace * 2 + self.onbutton1x + self.offbutton1x * 0.5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 7.5,
    0
  )
  self.offbutton1:SetOnClick(
    function()
      self:ChangeSpawnItemsTips()
    end
  )

  local tipsonoroff = _G.TOOMANYITEMS.DATA.SPAWN_ITEMS_TIPS
  if tipsonoroff then
    self.onbutton1:SetClickable(false)
    self.offbutton1:SetColour(0.5, 0.5, 0.5, 0.5)
  else
    self.onbutton1:SetColour(0.5, 0.5, 0.5, 0.5)
    self.offbutton1:SetClickable(false)
  end
  -- 生成物品提示

  -- 高级删除开关
  self.deletefunction = self.settingshield:AddChild(Text(self.font, self.fontsize))
  self.deletefunction:SetColour(0.9, 0.8, 0.6, 1)
  self.deletefunction:SetString(STRINGS.TOO_MANY_ITEMS_UI.ADVANCED_DELETE)
  self.deletefunctionx, self.deletefunctiony = self.deletefunction:GetRegionSize()
  self.deletefunction:SetPosition(
    self.settingleft + self.deletefunctionx * .5 + 20,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 19.5,
    0
  )

  self.onbutton3 = self.settingshield:AddChild(TextButton())
  self.onbutton3:SetFont(self.font)
  self.onbutton3:SetText(STRINGS.TOO_MANY_ITEMS_UI.TMIP_ADVANCED_DELETE_ON)
  self.onbutton3:SetTooltip(STRINGS.TOO_MANY_ITEMS_UI.ADVANCED_DELETE_TIP)
  self.onbutton3:SetTextSize(self.fontsize)
  self.onbutton3:SetColour(0.9, 0.8, 0.6, 1)
  self.onbutton3x, self.onbutton3y = self.onbutton3.text:GetRegionSize()
  self.onbutton3:SetPosition(
    self.settingleft + self.deletefunctionx + 20 + self.settinglinespace + self.onbutton3x * .5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 19.5,
    0
  )
  self.onbutton3:SetOnClick(
    function()
      self:ChangeDeleteFunction()
    end
  )

  self.offbutton3 = self.settingshield:AddChild(TextButton())
  self.offbutton3:SetFont(self.font)
  self.offbutton3:SetText(STRINGS.TOO_MANY_ITEMS_UI.TMIP_ADVANCED_DELETE_OFF)
  self.offbutton3:SetTooltip(STRINGS.TOO_MANY_ITEMS_UI.ADVANCED_DELETE_TIP)
  self.offbutton3:SetTextSize(self.fontsize)
  self.offbutton3:SetColour(0.9, 0.8, 0.6, 1)
  self.offbutton3x, self.offbutton3y = self.offbutton3.text:GetRegionSize()
  self.offbutton3:SetPosition(
    self.settingleft + self.deletefunctionx + 20 + self.settinglinespace * 2 + self.onbutton3x + self.offbutton3x * 0.5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 19.5,
    0
  )
  self.offbutton3:SetOnClick(
    function()
      self:ChangeDeleteFunction()
    end
  )

  local tipsonoroff = _G.TOOMANYITEMS.DATA.ADVANCE_DELETE
  if tipsonoroff then
    self.onbutton3:SetClickable(false)
    self.offbutton3:SetColour(0.5, 0.5, 0.5, 0.5)
  else
    self.onbutton3:SetColour(0.5, 0.5, 0.5, 0.5)
    self.offbutton3:SetClickable(false)
  end
  -- 高级删除开关

  -- 高级删除搜索半径
  self.deleteradius = self.settingshield:AddChild(Text(self.font, self.fontsize))
  self.deleteradius:SetColour(0.9, 0.8, 0.6, 1)
  self.deleteradius:SetString(STRINGS.TOO_MANY_ITEMS_UI.ADVANCED_DELETE_RADIUS)
  self.deleteradiusx, self.deleteradiusy = self.deleteradius:GetRegionSize()
  self.deleteradius:SetPosition(
    self.settingleft + self.deleteradiusx * .5 + 20,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 22.5,
    0
  )

  self.decreasebutton5 = self.settingshield:AddChild(TextButton())
  self.decreasebutton5:SetFont(self.font)
  self.decreasebutton5:SetText("<")
  self.decreasebutton5:SetTextSize(self.fontsize * 2)
  self.decreasebutton5:SetColour(0.9, 0.8, 0.6, 1)
  self.decreasebutton5x, self.decreasebutton5y = self.decreasebutton5.text:GetRegionSize()
  self.decreasebutton5:SetPosition(
    self.settingleft + self.deleteradiusx + 20 + self.settinglinespace + self.decreasebutton5x * .5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 22.5,
    0
  )
  self.decreasebutton5:SetOnClick(
    function()
      self:ChangeDeleteRadius("decrease")
    end
  )

  self.deleteradiuspointer = self.settingshield:AddChild(TextButton())
  self.deleteradiuspointer:SetFont(self.font)
  self.deleteradiuspointer:SetTooltip("Click to edit: 3~999")
  self.deleteradiuspointer:SetTextSize(self.fontsize)
  self.deleteradiuspointer:SetColour(0, 1, 1, 1)
  self.deleteradiuspointer:SetOverColour(0.4, 1, 1, 1)
  self.deleteradiuspointer:SetOnClick(
    function()
      self:FlushDeleteRadius()
    end
  )
  self:SetDeleteRadiusPointer()

  self.addbutton5 = self.settingshield:AddChild(TextButton())
  self.addbutton5:SetFont(self.font)
  self.addbutton5:SetText(">")
  self.addbutton5:SetTextSize(self.fontsize * 2)
  self.addbutton5:SetColour(0.9, 0.8, 0.6, 1)
  self.addbutton5x, self.addbutton5y = self.addbutton5.text:GetRegionSize()
  self.addbutton5:SetPosition(
    self.settingleft + self.deleteradiusx + 20 + self.settinglinespace * 5 + self.decreasebutton5x +
      self.deleteradiuspointersizex +
      self.addbutton5x * 0.5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 22.5,
    0
  )
  self.addbutton5:SetOnClick(
    function()
      self:ChangeDeleteRadius("add")
    end
  )

  local newfreshness = _G.TOOMANYITEMS.DATA.deleteradius
  if newfreshness <= 3 then
    self.decreasebutton5:SetClickable(false)
    self.decreasebutton5:SetColour(0.5, 0.5, 0.5, 0.5)
  end
  if newfreshness >= 999 then
    self.addbutton5:SetClickable(false)
    self.addbutton5:SetColour(0.5, 0.5, 0.5, 0.5)
  end
  -- 高级删除搜索半径

  -- 确认弹窗
  self.showconfirmscreen = self.settingshield:AddChild(Text(self.font, self.fontsize))
  self.showconfirmscreen:SetColour(0.9, 0.8, 0.6, 1)
  self.showconfirmscreen:SetString(STRINGS.TOO_MANY_ITEMS_UI.SHOW_CONFIRM_SCREEN_TIPS)
  self.showconfirmscreenx, self.showconfirmscreeny = self.showconfirmscreen:GetRegionSize()
  self.showconfirmscreen:SetPosition(
    self.settingleft + self.showconfirmscreenx * .5 + 20,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 16.5,
    0
  )

  self.onbutton2 = self.settingshield:AddChild(TextButton())
  self.onbutton2:SetFont(self.font)
  self.onbutton2:SetText(STRINGS.TOO_MANY_ITEMS_UI.TMIP_SHOW_CONFIRM_SCREEN_ON)
  self.onbutton2:SetTextSize(self.fontsize)
  self.onbutton2:SetColour(0.9, 0.8, 0.6, 1)
  self.onbutton2x, self.onbutton2y = self.onbutton2.text:GetRegionSize()
  self.onbutton2:SetPosition(
    self.settingleft + self.showconfirmscreenx + 20 + self.settinglinespace + self.onbutton2x * .5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 16.5,
    0
  )
  self.onbutton2:SetOnClick(
    function()
      self:ChangeShowConfirmScreen()
    end
  )

  self.offbutton2 = self.settingshield:AddChild(TextButton())
  self.offbutton2:SetFont(self.font)
  self.offbutton2:SetText(STRINGS.TOO_MANY_ITEMS_UI.TMIP_SHOW_CONFIRM_SCREEN_OFF)
  self.offbutton2:SetTextSize(self.fontsize)
  self.offbutton2:SetColour(0.9, 0.8, 0.6, 1)
  self.offbutton2x, self.offbutton2y = self.offbutton2.text:GetRegionSize()
  self.offbutton2:SetPosition(
    self.settingleft + self.showconfirmscreenx + 20 + self.settinglinespace * 2 + self.onbutton2x +
      self.offbutton2x * 0.5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 16.5,
    0
  )
  self.offbutton2:SetOnClick(
    function()
      self:ChangeShowConfirmScreen()
    end
  )

  local tipsonoroff = _G.TOOMANYITEMS.DATA.SHOW_CONFIRM_SCREEN
  if tipsonoroff then
    self.onbutton2:SetClickable(false)
    self.offbutton2:SetColour(0.5, 0.5, 0.5, 0.5)
  else
    self.onbutton2:SetColour(0.5, 0.5, 0.5, 0.5)
    self.offbutton2:SetClickable(false)
  end
  -- 确认弹窗

  -- 食物新鲜度
  self.foodfreshness = self.settingshield:AddChild(Text(self.font, self.fontsize))
  self.foodfreshness:SetColour(0.9, 0.8, 0.6, 1)
  self.foodfreshness:SetString(STRINGS.TOO_MANY_ITEMS_UI.FOOD_FRESHNESS)
  self.foodfreshnessx, self.foodfreshnessy = self.foodfreshness:GetRegionSize()
  self.foodfreshness:SetPosition(
    self.settingleft + self.foodfreshnessx * .5 + 20,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 1.5,
    0
  )

  self.decreasebutton1 = self.settingshield:AddChild(TextButton())
  self.decreasebutton1:SetFont(self.font)
  self.decreasebutton1:SetText("<")
  self.decreasebutton1:SetTextSize(self.fontsize * 2)
  self.decreasebutton1:SetColour(0.9, 0.8, 0.6, 1)
  self.decreasebutton1x, self.decreasebutton1y = self.decreasebutton1.text:GetRegionSize()
  self.decreasebutton1:SetPosition(
    self.settingleft + self.foodfreshnessx + 20 + self.settinglinespace + self.decreasebutton1x * .5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 1.5,
    0
  )
  self.decreasebutton1:SetOnClick(
    function()
      self:ChangeFoodFreshness("decrease")
    end
  )

  self.foodfreshnessvalue = self.settingshield:AddChild(Text(self.font, self.fontsize))
  self.foodfreshnessvalue:SetColour(1, 1, 1, 1)
  self.foodfreshnessvalue:SetString(_G.TOOMANYITEMS.DATA.xxd * 100 .. "%")
  self.foodfreshnessvaluex, self.foodfreshnessvaluey = self.foodfreshnessvalue:GetRegionSize()
  self.foodfreshnessvalue:SetPosition(
    self.settingleft + self.foodfreshnessx + 20 + self.settinglinespace * 3 + self.decreasebutton1x +
      self.foodfreshnessvaluex * 0.5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 1.5,
    0
  )

  self.addbutton1 = self.settingshield:AddChild(TextButton())
  self.addbutton1:SetFont(self.font)
  self.addbutton1:SetText(">")
  self.addbutton1:SetTextSize(self.fontsize * 2)
  self.addbutton1:SetColour(0.9, 0.8, 0.6, 1)
  self.addbutton1x, self.addbutton1y = self.addbutton1.text:GetRegionSize()
  self.addbutton1:SetPosition(
    self.settingleft + self.foodfreshnessx + 20 + self.settinglinespace * 5 + self.decreasebutton1x +
      self.foodfreshnessvaluex +
      self.addbutton1x * 0.5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 1.5,
    0
  )
  self.addbutton1:SetOnClick(
    function()
      self:ChangeFoodFreshness("add")
    end
  )

  local newfreshness = _G.TOOMANYITEMS.DATA.xxd
  if newfreshness <= 0.09 then
    self.decreasebutton1:SetClickable(false)
    self.decreasebutton1:SetColour(0.5, 0.5, 0.5, 0.5)
  end
  if newfreshness >= 1 then
    self.addbutton1:SetClickable(false)
    self.addbutton1:SetColour(0.5, 0.5, 0.5, 0.5)
  end
  -- 食物新鲜度

  -- 工具使用度
  self.toolfiniteuses = self.settingshield:AddChild(Text(self.font, self.fontsize))
  self.toolfiniteuses:SetColour(0.9, 0.8, 0.6, 1)
  self.toolfiniteuses:SetString(STRINGS.TOO_MANY_ITEMS_UI.TOOL_FINITEUSES)
  self.toolfiniteusesx, self.toolfiniteusesy = self.toolfiniteuses:GetRegionSize()
  self.toolfiniteuses:SetPosition(
    self.settingleft + self.toolfiniteusesx * .5 + 20,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 4.5,
    0
  )

  self.decreasebutton2 = self.settingshield:AddChild(TextButton())
  self.decreasebutton2:SetFont(self.font)
  self.decreasebutton2:SetText("<")
  self.decreasebutton2:SetTextSize(self.fontsize * 2)
  self.decreasebutton2:SetColour(0.9, 0.8, 0.6, 1)
  self.decreasebutton2x, self.decreasebutton2y = self.decreasebutton2.text:GetRegionSize()
  self.decreasebutton2:SetPosition(
    self.settingleft + self.toolfiniteusesx + 20 + self.settinglinespace + self.decreasebutton2x * .5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 4.5,
    0
  )
  self.decreasebutton2:SetOnClick(
    function()
      self:ChangeToolFiniteuses("decrease")
    end
  )

  self.toolfiniteusesvalue = self.settingshield:AddChild(Text(self.font, self.fontsize))
  self.toolfiniteusesvalue:SetColour(1, 1, 1, 1)
  self.toolfiniteusesvalue:SetString(_G.TOOMANYITEMS.DATA.syd * 100 .. "%")
  self.toolfiniteusesvaluex, self.toolfiniteusesvaluey = self.toolfiniteusesvalue:GetRegionSize()
  self.toolfiniteusesvalue:SetPosition(
    self.settingleft + self.toolfiniteusesx + 20 + self.settinglinespace * 3 + self.decreasebutton2x +
      self.toolfiniteusesvaluex * 0.5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 4.5,
    0
  )

  self.addbutton2 = self.settingshield:AddChild(TextButton())
  self.addbutton2:SetFont(self.font)
  self.addbutton2:SetText(">")
  self.addbutton2:SetTextSize(self.fontsize * 2)
  self.addbutton2:SetColour(0.9, 0.8, 0.6, 1)
  self.addbutton2x, self.addbutton2y = self.addbutton2.text:GetRegionSize()
  self.addbutton2:SetPosition(
    self.settingleft + self.toolfiniteusesx + 20 + self.settinglinespace * 5 + self.decreasebutton2x +
      self.toolfiniteusesvaluex +
      self.addbutton2x * 0.5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 4.5,
    0
  )
  self.addbutton2:SetOnClick(
    function()
      self:ChangeToolFiniteuses("add")
    end
  )

  local newfreshness = _G.TOOMANYITEMS.DATA.syd
  if newfreshness <= 0.09 then
    self.decreasebutton2:SetClickable(false)
    self.decreasebutton2:SetColour(0.5, 0.5, 0.5, 0.5)
  end
  if newfreshness >= 1 then
    self.addbutton2:SetClickable(false)
    self.addbutton2:SetColour(0.5, 0.5, 0.5, 0.5)
  end
  -- 工具使用度

  -- 燃料剩余度
  self.prefabfuel = self.settingshield:AddChild(Text(self.font, self.fontsize))
  self.prefabfuel:SetColour(0.9, 0.8, 0.6, 1)
  self.prefabfuel:SetString(STRINGS.TOO_MANY_ITEMS_UI.PREFAB_FUEL)
  self.prefabfuelx, self.prefabfuely = self.prefabfuel:GetRegionSize()
  self.prefabfuel:SetPosition(
    self.settingleft + self.prefabfuelx * .5 + 20,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 10.5,
    0
  )

  self.decreasebutton3 = self.settingshield:AddChild(TextButton())
  self.decreasebutton3:SetFont(self.font)
  self.decreasebutton3:SetText("<")
  self.decreasebutton3:SetTextSize(self.fontsize * 2)
  self.decreasebutton3:SetColour(0.9, 0.8, 0.6, 1)
  self.decreasebutton3x, self.decreasebutton3y = self.decreasebutton3.text:GetRegionSize()
  self.decreasebutton3:SetPosition(
    self.settingleft + self.prefabfuelx + 20 + self.settinglinespace + self.decreasebutton3x * .5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 10.5,
    0
  )
  self.decreasebutton3:SetOnClick(
    function()
      self:ChangePrefabFuel("decrease")
    end
  )

  self.prefabfuelvalue = self.settingshield:AddChild(Text(self.font, self.fontsize))
  self.prefabfuelvalue:SetColour(1, 1, 1, 1)
  self.prefabfuelvalue:SetString(_G.TOOMANYITEMS.DATA.fuel * 100 .. "%")
  self.prefabfuelvaluex, self.prefabfuelvaluey = self.prefabfuelvalue:GetRegionSize()
  self.prefabfuelvalue:SetPosition(
    self.settingleft + self.prefabfuelx + 20 + self.settinglinespace * 3 + self.decreasebutton3x +
      self.prefabfuelvaluex * 0.5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 10.5,
    0
  )

  self.addbutton3 = self.settingshield:AddChild(TextButton())
  self.addbutton3:SetFont(self.font)
  self.addbutton3:SetText(">")
  self.addbutton3:SetTextSize(self.fontsize * 2)
  self.addbutton3:SetColour(0.9, 0.8, 0.6, 1)
  self.addbutton3x, self.addbutton3y = self.addbutton3.text:GetRegionSize()
  self.addbutton3:SetPosition(
    self.settingleft + self.prefabfuelx + 20 + self.settinglinespace * 5 + self.decreasebutton3x + self.prefabfuelvaluex +
      self.addbutton3x * 0.5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 10.5,
    0
  )
  self.addbutton3:SetOnClick(
    function()
      self:ChangePrefabFuel("add")
    end
  )

  local newfreshness = _G.TOOMANYITEMS.DATA.fuel
  if newfreshness <= 0.09 then
    self.decreasebutton3:SetClickable(false)
    self.decreasebutton3:SetColour(0.5, 0.5, 0.5, 0.5)
  end
  if newfreshness >= 1 then
    self.addbutton3:SetClickable(false)
    self.addbutton3:SetColour(0.5, 0.5, 0.5, 0.5)
  end
  -- 燃料剩余度

  -- 温度
  self.prefabtemperature = self.settingshield:AddChild(Text(self.font, self.fontsize))
  self.prefabtemperature:SetColour(0.9, 0.8, 0.6, 1)
  self.prefabtemperature:SetString(STRINGS.TOO_MANY_ITEMS_UI.PREFAB_TEMPERATURE)
  self.prefabtemperaturex, self.prefabtemperaturey = self.prefabtemperature:GetRegionSize()
  self.prefabtemperature:SetPosition(
    self.settingleft + self.prefabtemperaturex * .5 + 20,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 13.5,
    0
  )

  self.decreasebutton4 = self.settingshield:AddChild(TextButton())
  self.decreasebutton4:SetFont(self.font)
  self.decreasebutton4:SetText("<")
  self.decreasebutton4:SetTextSize(self.fontsize * 2)
  self.decreasebutton4:SetColour(0.9, 0.8, 0.6, 1)
  self.decreasebutton4x, self.decreasebutton4y = self.decreasebutton4.text:GetRegionSize()
  self.decreasebutton4:SetPosition(
    self.settingleft + self.prefabtemperaturex + 20 + self.settinglinespace + self.decreasebutton4x * .5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 13.5,
    0
  )
  self.decreasebutton4:SetOnClick(
    function()
      self:ChangePrefabTemperature("decrease")
    end
  )

  self.prefabtemperaturevalue = self.settingshield:AddChild(Text(self.font, self.fontsize))
  self.prefabtemperaturevalue:SetColour(1, 1, 1, 1)
  self.prefabtemperaturevalue:SetString(_G.TOOMANYITEMS.DATA.temperature .. "°C")
  self.prefabtemperaturevaluex, self.prefabtemperaturevaluey = self.prefabtemperaturevalue:GetRegionSize()
  self.prefabtemperaturevalue:SetPosition(
    self.settingleft + self.prefabtemperaturex + 20 + self.settinglinespace * 3 + self.decreasebutton4x +
      self.prefabtemperaturevaluex * 0.5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 13.5,
    0
  )

  self.addbutton4 = self.settingshield:AddChild(TextButton())
  self.addbutton4:SetFont(self.font)
  self.addbutton4:SetText(">")
  self.addbutton4:SetTextSize(self.fontsize * 2)
  self.addbutton4:SetColour(0.9, 0.8, 0.6, 1)
  self.addbutton4x, self.addbutton4y = self.addbutton4.text:GetRegionSize()
  self.addbutton4:SetPosition(
    self.settingleft + self.prefabtemperaturex + 20 + self.settinglinespace * 5 + self.decreasebutton4x +
      self.prefabtemperaturevaluex +
      self.addbutton4x * 0.5,
    self.shieldsize_y * .5 - self.screennamey - self.settinglinespace * 13.5,
    0
  )
  self.addbutton4:SetOnClick(
    function()
      self:ChangePrefabTemperature("add")
    end
  )

  local newfreshness = _G.TOOMANYITEMS.DATA.temperature
  if newfreshness <= 0 then
    self.decreasebutton4:SetClickable(false)
    self.decreasebutton4:SetColour(0.5, 0.5, 0.5, 0.5)
  end
  if newfreshness >= 100 then
    self.addbutton4:SetClickable(false)
    self.addbutton4:SetColour(0.5, 0.5, 0.5, 0.5)
  end
  -- 燃料剩余度
end

function TooManyItems:OnControl(control, down)
  if TooManyItems._base.OnControl(self, control, down) then
    return true
  end

  if not down then
    if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
      self:Close()
    end
  end
  return true
end

function TooManyItems:OnRawKey(key, down)
  if TooManyItems._base.OnRawKey(self, key, down) then
    return true
  end
end

return TooManyItems

local Image = require "widgets/image"
local Text = require "widgets/text"
local TextButton = require "widgets/textbutton"
local Widget = require "widgets/widget"

local WriteableWidget = require "screens/TMI_writeablewidget"
local TMI_menubar = require "widgets/TMI_menubar"

local function RandomPlayer(widget)
	widget:OverrideText(AllPlayers[math.random(1, #AllPlayers)]:GetDisplayName())
end

local function AcceptPlayer(widget)
	local playerid = UserToClientID(widget:GetText())
	if playerid then
		TOOMANYITEMS.CHARACTER_USERID = playerid
	else
		TOOMANYITEMS.CHARACTER_USERID = ThePlayer.userid
	end
end

local writeable_config = {
	animbank = "ui_board_5x3",
	animbuild = "ui_board_5x3",
	menuoffset = Vector3(6, -70, 0),

	cancelbtn = { text = STRINGS.UI.TRADESCREEN.CANCEL, cb = nil, control = CONTROL_CANCEL },
	middlebtn = { text = STRINGS.UI.HELP.RANDOM, cb = RandomPlayer, control = CONTROL_MENU_MISC_2 },
	acceptbtn = { text = STRINGS.UI.TRADESCREEN.ACCEPT, cb = AcceptPlayer, control = CONTROL_ACCEPT },

	--defaulttext = SignGenerator,
}

local function SendCommand(fnstr)
	local x, _, z = TheSim:ProjectScreenPos(TheSim:GetPosition())
	local is_valid_time_to_use_remote = TheNet:GetIsClient() and TheNet:GetIsServerAdmin()
	if is_valid_time_to_use_remote then
		TheNet:SendRemoteExecute(fnstr, x, z)
	else
		ExecuteConsoleCommand(fnstr)
	end
end

local function GetCharacterName()
	return UserToName(TOOMANYITEMS.CHARACTER_USERID)
end

local function GetCharacter()
	return "UserToPlayer('"..TOOMANYITEMS.CHARACTER_USERID.."')"
end

local TooManyItems = Class(Widget, function(self)
		Widget._ctor(self, "TooManyItems")
		TOOMANYITEMS.CHARACTER_USERID = ThePlayer.userid

		self.root = self:AddChild(Widget("ROOT"))
		self.root:SetVAnchor(ANCHOR_MIDDLE)
		self.root:SetHAnchor(ANCHOR_MIDDLE)
		self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
		self.root:SetPosition(0,0,0)

		self.shieldpos_x = -345
		self.shieldsize_x = 350
		self.shieldsize_y = 480
		self.shield = self.root:AddChild( Image("images/ui.xml", "black.tex") )
		self.shield:SetScale(1,1,1)
		self.shield:SetPosition(self.shieldpos_x,0,0)
		self.shield:SetSize(self.shieldsize_x, self.shieldsize_y)
		self.shield:SetTint(1,1,1,0.6)

		local world_id = TheWorld.meta.session_identifier or "world"
		local savepath = TOOMANYITEMS.TELEPORT_DATA_FILE .. "toomanyitems_teleport_save_"..world_id

		if TOOMANYITEMS.DATA_SAVE == 1 then
			if TOOMANYITEMS.LoadData(savepath) then
				TOOMANYITEMS.TELEPORT_DATA = TOOMANYITEMS.LoadData(savepath)
			end
		elseif TOOMANYITEMS.DATA_SAVE == -1 then
			_G.TheSim:GetPersistentString(savepath, function(load_success, str) if load_success then _G.ErasePersistentString(savepath, nil) end end)
		end

		self:DebugMenu()

		if TOOMANYITEMS.DATA.IsDebugMenuShow then
			self.debugshield:Show()
		else
			self.debugshield:Hide()
		end

		self.menu = self.shield:AddChild(TMI_menubar(self))

	end)

function TooManyItems:Close()
	self:Hide()
	self.IsTooManyItemsMenuShow = false
end

function TooManyItems:ShowDebugMenu()
	if TOOMANYITEMS.DATA.IsDebugMenuShow then
		self.debugshield:Hide()
		TOOMANYITEMS.DATA.IsDebugMenuShow = false
	else
		self.debugshield:Show()
		TOOMANYITEMS.DATA.IsDebugMenuShow = true
	end
	if TOOMANYITEMS.DATA_SAVE == 1 then
		TOOMANYITEMS.SaveNormalData()
	end
end

function TooManyItems:FlushPlayer()
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

	self:SetPointer()
end

function TooManyItems:SetPointer()
	local mainstr = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_POINTER
	local prefix = ""
	if TOOMANYITEMS.CHARACTER_USERID == ThePlayer.userid then
		prefix = STRINGS.TOO_MANY_ITEMS_UI.BUTTON_POINTER_SELF
	end
	self.pointer:SetText(string.format(prefix..mainstr, GetCharacterName(), TOOMANYITEMS.CHARACTER_USERID))
	self.pointersizex, self.pointersizey = self.pointer.text:GetRegionSize()
	self.pointer.image:SetSize(self.pointersizex * .85, self.pointersizey)
	self.pointer:SetPosition(self.left + self.pointersizex * .5, self.shieldsize_y * .5 - self.pointersizey * .5, 0)
end

function TooManyItems:DebugMenu()
	self.debugwidth = 450
	self.font = BODYTEXTFONT
	self.fontsize = 26
	self.minwidth = 36
	self.nextline = 24
	self.spacing = 10

	self.left = -self.debugwidth * 0.5
	self.limit = -self.left
	self.debugshield = self.root:AddChild( Image("images/ui.xml", "black.tex") )
	self.debugshield:SetScale(1,1,1)
	self.debugshield:SetPosition(self.shieldpos_x + self.shieldsize_x * 0.5 + self.limit, 0, 0)
	self.debugshield:SetSize(self.limit * 2, self.shieldsize_y)
	self.debugshield:SetTint(1,1,1,0.6)

	self.pointer = self.debugshield:AddChild(TextButton())
	self.pointer:SetFont(self.font)
	self.pointer:SetTooltip(STRINGS.TOO_MANY_ITEMS_UI.BUTTON_POINTERTIP)
	self.pointer:SetTextSize(self.fontsize)
	self.pointer:SetColour(0,1,1,1)
	self.pointer:SetOverColour(0.4,1,1,1)
	self.pointer:SetOnClick(function() self:FlushPlayer() end)

	self:SetPointer()

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
				button:SetColour(0.9,0.8,0.6,1)

				local fn = buttonlist[i].fn
				if type(fn) == "table" then
					button:SetOnClick( function() fn.TeleportFn(fn.TeleportNum) end)
				elseif type(fn) == "string" then
					button:SetOnClick( function() SendCommand(string.format(fn, GetCharacter())) end)
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
					lleft = self.left + width + self.spacing
				else
					button:SetPosition(lleft + width * .5, self.top, 0)
					lleft = lleft + width + self.spacing
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

function TooManyItems:OnControl(control, down)
	if TooManyItems._base.OnControl(self,control, down) then
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
	if TooManyItems._base.OnRawKey(self, key, down) then return true end
end

return TooManyItems

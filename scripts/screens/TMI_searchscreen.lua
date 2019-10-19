require "util"
local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local TextEdit = require "widgets/textedit"

local SearchScreen = Class(Screen, function(self, config)
		Screen._ctor(self, "SearchScreen")
		self.config = config

		self:DoInit()
	end)

function SearchScreen:OnBecomeActive()
	SearchScreen._base.OnBecomeActive(self)
	if self.config.activefn ~= nil then
		self.config.activefn()
	end
	self.edit_text:SetFocus()
	TheFrontEnd:LockFocus(true)
end

function SearchScreen:OnBecomeInactive()
	SearchScreen._base.OnBecomeInactive(self)
end

function SearchScreen:OnControl(control, down)
	if SearchScreen._base.OnControl(self, control, down) then return true end

	--jcheng: don't allow debug menu stuff going on right now
	if control == CONTROL_OPEN_DEBUG_CONSOLE then
		return true
	end

	if not down and (control == CONTROL_CANCEL ) then
		self:Close()
		return true
	end
end

function SearchScreen:OnRawKey(key, down)
	if SearchScreen._base.OnRawKey(self, key, down) then return true end

	if down then return end

	if self.config.rawkeyfn ~= nil then
		self.config.rawkeyfn(key, self)
	end

	return true
end

function SearchScreen:Run()
	if self.config.acceptfn ~= nil then
		self.config.acceptfn(self:GetText())
	end
end

function SearchScreen:Close()
	if self.config.closefn ~= nil then
		self.config.closefn()
	end
	TheInput:EnableDebugToggle(true)
	TheFrontEnd:PopScreen(self)
end

function SearchScreen:OnTextEntered()
	self:Run()
	self:Close()
end

function SearchScreen:DoInit()
	--SetPause(true,"console")
	TheInput:EnableDebugToggle(false)

	self.root = self:AddChild(Widget(""))
	self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
	self.root:SetHAnchor(ANCHOR_MIDDLE)
	self.root:SetVAnchor(ANCHOR_MIDDLE)
	self.root = self.root:AddChild(Widget(""))
	self.root:SetPosition(0,0,0)

	self.edit_text = self.root:AddChild( TextEdit( NEWFONT, self.config.fontsize, "" ) )
	self.edit_text:SetPosition(self.config.pos)
	self.edit_text:SetRegionSize( self.config.size[1], self.config.size[2] )
	self.edit_text.OnTextEntered = function() self:OnTextEntered() end
	self.edit_text:SetPassControlToScreen(CONTROL_CANCEL, true)
	self.edit_text:SetPassControlToScreen(CONTROL_MENU_MISC_2, true)
	self.edit_text:SetEditing(self.config.isediting)
	self.edit_text:SetForceEdit(self.config.isediting)

end

function SearchScreen:OverrideText(text)
	self.edit_text:SetString(text)
	self.edit_text:SetFocus()
end

function SearchScreen:GetText()
	return self.edit_text:GetString()
end

return SearchScreen

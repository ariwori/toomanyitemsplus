local Image = require "widgets/image"
local Text = require "widgets/text"
local TextButton = require "widgets/textbutton"
local Widget = require "widgets/widget"

local SearchScreen = require "screens/TMI_searchscreen"
local TMI_inventorybar = require "widgets/TMI_inventorybar"
local TMI_Menu = require "TMI/menu"

local function GetPrettyStr(str)
	return string.lower(TrimString(str))
end

local TMI_Menubar = Class(Widget, function(self, owner)
		Widget._ctor(self, "TMI_Menubar")
		self.owner = owner
		self:Init()
	end)

function TMI_Menubar:Init()
	self:InitSidebar()
	self:InitSearch()
	self:InitMenu()
	local function SetPage(currentpage, maxpages)
		self.pagetext:SetString(currentpage.." / "..maxpages)
		if currentpage <= 1 then
			self.TMI_Menu.mainbuttons["prevbutton"]:Hide()
		else
			self.TMI_Menu.mainbuttons["prevbutton"]:Show()
		end

		if currentpage >= maxpages then
			self.TMI_Menu.mainbuttons["nextbutton"]:Hide()
		else
			self.TMI_Menu.mainbuttons["nextbutton"]:Show()
		end
	end

	self.inventory = self:AddChild(TMI_inventorybar(SetPage))
	self:LoadSearchData()
end

function TMI_Menubar:InitMenu()
	local fontsize = 36
	if _G.TOOMANYITEMS.UI_LANGUAGE == "en" then
		fontsize = fontsize * 0.85
	end
	local spacing = 37
	local left = 20 - self.owner.shieldsize_x * .5
	local right = self.owner.shieldsize_x * .5
	local mid = self.sidebar_width * .5
	local pos = {
		left,
		left + spacing,
		left + spacing * 2,
		left + spacing * 3,
		left + spacing * 4,
		left + spacing * 5,
		left + spacing * 6,
		left + spacing * 7,
		left + spacing * 8,
		left + spacing * 9,
	}

	self.TMI_Menu = TMI_Menu(self, pos)

	self.pagetext = self:AddChild(Text(NEWFONT_OUTLINE, fontsize))
	self.pagetext:SetString("1 / 2")
	-- self.pagetext:SetTooltip("Current Page/Max Pages")
	self.pagetext:SetColour(1,1,1,0.6)
	self.pagetext:SetPosition(mid + 135, -220, 0)
end

function TMI_Menubar:InitSidebar()
	self.sidebar_width = 0
	self.sidebarlists = {
--第一列
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_CUSTOM,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPCUSTOM,
			fn = self:GetSideButtonFn("custom"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_FOOD,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPFOOD,
			fn = self:GetSideButtonFn("food"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_SEEDS,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPSEEDS,
			fn = self:GetSideButtonFn("seeds"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_EQUIP,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPEQUIP,
			fn = self:GetSideButtonFn("equip"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TOOLS,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPTOOLS,
			fn = self:GetSideButtonFn("tool"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_MAGIC,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPMAGIC,
			fn = self:GetSideButtonFn("magic"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_ANIMAL,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPANIMAL,
			fn = self:GetSideButtonFn("animal"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_BOSS,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPBOSS,
			fn = self:GetSideButtonFn("boss"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_FOLLOWER,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPFOLLOWER,
			fn = self:GetSideButtonFn("follower"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_MATERIAL,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPMATERIAL,
			fn = self:GetSideButtonFn("material"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_GIFT,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPGIFT,
			fn = self:GetSideButtonFn("gift"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_RUINS,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPRUINS,
			fn = self:GetSideButtonFn("ruins"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_YULIUA,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPYULIUA,
			fn = self:GetSideButtonFn("rot"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_EVENT,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPEVENT,
			fn = self:GetSideButtonFn("event"),
		},
--第二列
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_ALL,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPALL,
			fn = self:GetSideButtonFn("all"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_COOKING,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPCOOKING,
			fn = self:GetSideButtonFn("cooking"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_PROPS,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPPROPS,
			fn = self:GetSideButtonFn("props"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_CLOTHES,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPCLOTHES,
			fn = self:GetSideButtonFn("clothes"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_PUPPET,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPPUPPET,
			fn = self:GetSideButtonFn("puppet"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_BASE,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPBASE,
			fn = self:GetSideButtonFn("base"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_PLANT,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPPLANT,
			fn = self:GetSideButtonFn("plant"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_ORE,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPORE,
			fn = self:GetSideButtonFn("ore"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_DEN,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPDEN,
			fn = self:GetSideButtonFn("den"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_BUILDING,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPBUILDING,
			fn = self:GetSideButtonFn("building"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_SCULPTURE,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPSCULPTURE,
			fn = self:GetSideButtonFn("sculpture"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_NATURAL,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPNATURAL,
			fn = self:GetSideButtonFn("natural"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_YULIUB,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPYULIUB,
			fn = self:GetSideButtonFn("custom"),
		},
		{
			show = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_OTHER,
			tip = STRINGS.TOO_MANY_ITEMS_UI.SIDEBAR_TIPOTHER,
			fn = self:GetSideButtonFn("others"),
		},
	}

	local function MakeSidebar(buttonlist)
		--fontsize = 25
		local fontsize = _G.TOOMANYITEMS.G_TMIP_CATEGORY_FONT_SIZE
		if _G.TOOMANYITEMS.UI_LANGUAGE == "en" then
			fontsize = fontsize * 0.8
		end
		local left = -self.owner.shieldsize_x * .5
		local spacing = 1
		local top = self.owner.shieldsize_y * .5
		local mytop = self.owner.shieldsize_y * .5
		-- 固定取一个按钮的宽度
		local textwidth = 1
		local textheight = 1
		for i = 1, #buttonlist do
			local button = self:AddChild(TextButton())
			button:SetFont(NEWFONT)
			button:SetText(buttonlist[i].show)
			button:SetTooltip(buttonlist[i].tip)
			button:SetTextSize(fontsize)
			button:SetColour(0.9,0.8,0.6,1)
			button:SetOnClick(buttonlist[i].fn)

			local width, height = button.text:GetRegionSize()
			button.image:SetSize(width * 0.9, height)
			if width > self.sidebar_width then
				self.sidebar_width = width
			end
			if i == 1 then
				textwidth = width
				textheight = height
				spacing = (self.owner.shieldsize_y - 80 - 14*textheight) / 14
			end
			local maxlinesize = math.floor(#buttonlist / 2 + 0.5)
			if i <= maxlinesize then
				button:SetPosition(left + textwidth * .5, top - textheight * .5, 0)
				top = top - textheight - spacing
			else
				button:SetPosition(left + spacing + textwidth * 1.5, mytop - textheight * .5, 0)
				mytop = mytop - textheight - spacing
			end
		end
	end
	MakeSidebar(self.sidebarlists)
end

function TMI_Menubar:GetSideButtonFn(name)
	return function()
		TOOMANYITEMS.DATA.listinuse = name
		TOOMANYITEMS.DATA.issearch = false
		self:ShowNormal()
		self:SaveData()
	end
end

function TMI_Menubar:ShowNormal()
	self.inventory:TryBuild()
end

function TMI_Menubar:ShowSearch()
	TOOMANYITEMS.DATA.issearch = true
	self.inventory.currentpage = 1
	self.inventory:TryBuild()
end

function TMI_Menubar:InitSearch()
	self.searchbar_width = self.owner.shieldsize_x - 75
	self.search_fontsize = 26

	self.searchshield = self:AddChild( Image("images/ui.xml", "black.tex") )
	self.searchshield:SetScale(1,1,1)
	self.searchshield:SetTint(1,1,1,0.2)
	self.searchshield:SetSize(self.searchbar_width, self.search_fontsize)
	self.searchshield:SetPosition(self.sidebar_width + 5, self.owner.shieldsize_y * .5 - self.search_fontsize * .5, 0)

	self.searchbarbutton = self.searchshield:AddChild(TextButton())
	self.searchbarbutton:SetFont(NEWFONT)
	self.searchbarbutton:SetTextSize(self.search_fontsize)
	self.searchbarbutton:SetColour(0.9,0.8,0.6,1)
	self.searchbarbutton:SetText(STRINGS.TOO_MANY_ITEMS_UI.SEARCH_TEXT)
	self.searchbarbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS_UI.SEARCH_TIP)
	self.searchbarbutton:SetOnClick( function() self:Search(TOOMANYITEMS.DATA.search) end)
	self.searchbarbutton_width = self.searchbarbutton.text:GetRegionSize()
	self.searchbarbutton.image:SetSize(self.searchbarbutton_width * .9, self.search_fontsize)
	self.searchbarbutton_posx = self.searchbar_width * .5 - self.searchbarbutton_width * .5
	self.searchbarbutton:SetPosition(self.searchbarbutton_posx, 0, 0)

	self.searchtext_limitwidth = self.searchbar_width - self.searchbarbutton_width
	self:InitSearchScreen()

	self.searchhelptip = self.searchshield:AddChild(TextButton())
	self.searchhelptip:SetFont(NEWFONT)
	self.searchhelptip:SetTextSize(self.search_fontsize)
	self.searchhelptip:SetText(STRINGS.TOO_MANY_ITEMS_UI.SEARCHBAR_TEXT)
	self.searchhelptip:SetTooltip(STRINGS.TOO_MANY_ITEMS_UI.SEARCHBAR_TIP)
	self.searchhelptip:SetOnClick( function() self:SearchKeyWords() end)
	self.searchhelptip.text:SetRegionSize(self.searchtext_limitwidth, self.search_fontsize)
	self.searchhelptip.image:SetSize(self.searchtext_limitwidth * .9, self.search_fontsize)
	self.searchhelptip:SetPosition(self.searchtext_limitwidth * .5 - self.searchbar_width * .5, 0, 0)

	self.searchtext = self.searchshield:AddChild(Text(NEWFONT, self.search_fontsize))
	self.searchtext:SetColour(0.9,0.8,0.6,1)

	self:SearchTipSet()
end

function TMI_Menubar:SearchTipSet()
	if TOOMANYITEMS.DATA.search ~= "" then
		self.searchtext:SetString(TOOMANYITEMS.DATA.search)
		self.searchhelptip:SetColour(0.9,0.8,0.6,0)
		self.searchhelptip:SetOverColour(0.9,0.8,0.6,0)

		local searchtext_width, searchtext_height = self.searchtext:GetRegionSize()
		if searchtext_width > self.searchtext_limitwidth then
			self.searchtext:SetRegionSize( self.searchtext_limitwidth, searchtext_height )
			self.searchtext:SetPosition(self.searchtext_limitwidth * .5 - self.searchbar_width * .5, 0, 0)
		else
			self.searchtext:SetPosition(searchtext_width * .5 - self.searchbar_width * .5, 0, 0)
		end
	else
		self.searchtext:SetString("")
		self.searchhelptip:SetColour(0.9,0.8,0.6,1)
		self.searchhelptip:SetOverColour(0.9,0.8,0.6,1)
	end

end

function TMI_Menubar:Search(str)
	if str == TOOMANYITEMS.DATA.search then
		self:ShowSearch()
	else
		local search_str = GetPrettyStr(str)
		if search_str ~= "" then

			local history = {}
			local history_num = #TOOMANYITEMS.DATA.searchhistory
			for i = 1, history_num do
				local value = TOOMANYITEMS.DATA.searchhistory[i]
				if value ~= search_str then
					table.insert(history, value)
				end
			end
			table.insert(history, search_str)
			TOOMANYITEMS.DATA.searchhistory = history
			TOOMANYITEMS.DATA.search = search_str
			self:ShowSearch()
		else
			TOOMANYITEMS.DATA.issearch = false
			TOOMANYITEMS.DATA.search = ""
			self:ShowNormal()
		end
		self:SearchTipSet()
	end
	self:SaveData()
end

function TMI_Menubar:InitSearchScreen()
	local function SearchScreenActive()
		self.searchhelptip:Hide()
		self.searchtext:Hide()
	end
	local function SearchScreenAccept(str)
		if str then
			self:Search(str)
		end
	end
	local function SearchScreenClose()
		self.searchhelptip:Show()
		self.searchtext:Show()
	end
	local function SearchScreenRawKey(key, screen)
		if key == KEY_UP then
			local len = #TOOMANYITEMS.DATA.searchhistory
			if len > 0 then
				if self.history_idx ~= nil then
					self.history_idx = math.max( 1, self.history_idx - 1 )
				else
					self.history_idx = len
				end
				screen:OverrideText( TOOMANYITEMS.DATA.searchhistory[ self.history_idx ] )
			end
		elseif key == KEY_DOWN then
			local len = #TOOMANYITEMS.DATA.searchhistory
			if len > 0 then
				if self.history_idx ~= nil then
					if self.history_idx == len then
						screen:OverrideText( "" )
					else
						self.history_idx = math.min( len, self.history_idx + 1 )
						screen:OverrideText( TOOMANYITEMS.DATA.searchhistory[ self.history_idx ] )
					end
				else
					self.history_idx = len
					screen:OverrideText( "" )
				end
			end
		end
	end

	self.SearchScreenConfig = {
		fontsize = self.search_fontsize,
		size = {self.searchtext_limitwidth, self.search_fontsize},
		isediting = true,
		pos = Vector3(self.owner.shieldpos_x - self.owner.shieldsize_x * .5 + self.searchtext_limitwidth * .5 + self.sidebar_width * 3 -17, self.owner.shieldsize_y * .5 + 15, 0),
		acceptfn = SearchScreenAccept,
		closefn = SearchScreenClose,
		activefn = SearchScreenActive,
		rawkeyfn = SearchScreenRawKey,
	}
end

function TMI_Menubar:SearchKeyWords()
	if self.searchbar then
		self.searchbar:KillAllChildren()
		self.searchbar:Kill()
		self.searchbar = nil
	end
	self.searchbar = SearchScreen(self.SearchScreenConfig)
	ThePlayer.HUD:OpenScreenUnderPause(self.searchbar)
	if TheFrontEnd:GetActiveScreen() == self.searchbar then
		self.searchbar.edit_text:SetHAlign(ANCHOR_LEFT)
		self.searchbar.edit_text:SetIdleTextColour(0.9,0.8,0.6,1)
		self.searchbar.edit_text:SetEditTextColour(1,1,1,1)
		self.searchbar.edit_text:SetEditCursorColour(1,1,1,1)
		self.searchbar.edit_text:SetTextLengthLimit(200)
		self.searchbar.edit_text:EnableWordWrap(false)
		self.searchbar.edit_text:EnableRegionSizeLimit(true)
		self.searchbar.edit_text:EnableScrollEditWindow(false)
		self.searchbar.edit_text:SetString(TOOMANYITEMS.DATA.search)
		self.searchbar.edit_text.validrawkeys[KEY_UP] = true
		self.searchbar.edit_text.validrawkeys[KEY_DOWN] = true
	end
end

function TMI_Menubar:LoadSearchData()
	if TOOMANYITEMS.DATA.issearch then
		self:Search(TOOMANYITEMS.DATA.search)
	else
		self:ShowNormal()
	end
end

function TMI_Menubar:SaveData()
	if TOOMANYITEMS.G_TMIP_DATA_SAVE == 1 then
		TOOMANYITEMS.SaveNormalData()
	end
end

function TMI_Menubar:OnControl(control, down)
	if TMI_Menubar._base.OnControl(self,control, down) then
		return true
	end

	return true
end

function TMI_Menubar:OnRawKey(key, down)
	if TMI_Menubar._base.OnRawKey(self, key, down) then return true end
end

return TMI_Menubar

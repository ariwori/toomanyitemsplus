_G = GLOBAL
if _G.TheNet and ( ( _G.TheNet:GetIsServer() and _G.TheNet:GetServerIsDedicated() ) or ( _G.TheNet:GetIsClient() and not _G.TheNet:GetIsServerAdmin() ) ) then return end

Assets =
{
	Asset("IMAGE", "images/healthmeter.tex"),
	Asset("ATLAS", "images/healthmeter.xml"),
	Asset("IMAGE", "images/sanity.tex"),
	Asset("ATLAS", "images/sanity.xml"),
	Asset("IMAGE", "images/hunger.tex"),
	Asset("ATLAS", "images/hunger.xml"),
	Asset("IMAGE", "images/wdbeaver.tex"),
	Asset("ATLAS", "images/wdbeaver.xml"),
	Asset("IMAGE", "images/wdgoose.tex"),
	Asset("ATLAS", "images/wdgoose.xml"),
	Asset("IMAGE", "images/wdmoose.tex"),
	Asset("ATLAS", "images/wdmoose.xml"),
	Asset("IMAGE", "images/wetness_meter.tex"),
	Asset("ATLAS", "images/wetness_meter.xml"),
	Asset("IMAGE", "images/thermal_measurer_build.tex"),
	Asset("ATLAS", "images/thermal_measurer_build.xml"),
	Asset("ATLAS", "images/close.xml"),
	Asset("IMAGE", "images/close.tex"),
	Asset("ATLAS", "images/creativemode.xml"),
	Asset("IMAGE", "images/creativemode.tex"),
	Asset("ATLAS", "images/godmode.xml"),
	Asset("IMAGE", "images/godmode.tex"),
	Asset("ATLAS", "images/debug.xml"),
	Asset("IMAGE", "images/debug.tex"),
}

_G.TOOMANYITEMS = {
	DATA_FILE = "mod_config_data/toomanyitems_data_save",
	TELEPORT_DATA_FILE = "mod_config_data/",
	CHARACTER_USERID = "",
	DATA = {},
	TELEPORT_DATA = {},
	LIST = {},

	TMI_TOGGLE_KEY = GetModConfigData("TMI_TOGGLE_KEY"),
	L_CLICK_NUM = GetModConfigData("TMI_L_CLICK_NUM"),
	R_CLICK_NUM = GetModConfigData("TMI_R_CLICK_NUM"),
	DATA_SAVE = GetModConfigData("TMI_DATA_SAVE"),
	SEARCH_HISTORY_NUM = GetModConfigData("TMI_SEARCH_HISTORY_NUM"),
}

if _G.TOOMANYITEMS.DATA_SAVE == -1 then
	local filepath = _G.TOOMANYITEMS.DATA_FILE
	_G.TheSim:GetPersistentString(filepath, function(load_success, str) if load_success then _G.ErasePersistentString(filepath, nil) end end)
elseif _G.TOOMANYITEMS.DATA_SAVE == 1 then

	_G.TOOMANYITEMS.LoadData = function(filepath)
		local data = nil
		_G.TheSim:GetPersistentString(filepath,
			function(load_success, str)
				if load_success == true then
					local success, savedata = _G.RunInSandboxSafe(str)
					if success and string.len(str) > 0 then
						data = savedata
					else
						print ("[TooManyItems] Could not load "..filepath)
					end
				else
					print ("[TooManyItems] Can not find "..filepath)
				end
			end
		)
		return data
	end

	_G.TOOMANYITEMS.SaveData = function(filepath, data)
		if data and type(data) == "table" and filepath and type(filepath) == "string" then
			_G.SavePersistentString(filepath, _G.DataDumper(data, nil, true), false, nil)
		end
	end

	_G.TOOMANYITEMS.SaveNormalData = function()
		_G.TOOMANYITEMS.SaveData(_G.TOOMANYITEMS.DATA_FILE, _G.TOOMANYITEMS.DATA)
	end

end

STRINGS = _G.STRINGS
STRINGS.TOO_MANY_ITEMS_UI = {}

local steam_support_languages = {
	schinese = "chs",
	tchinese = "cht",
	russian = "ru",
	brazilian = "br",
}

local support_languages = {
	chs = true,
	cht = true,
	cn = "chs",
	zh_CN = "chs",
	TW = "cht",
	ru = true,
	br = true,
}

local function LoadTranslation()
	local steamlang = _G.TheNet:GetLanguageCode() or nil
	if steamlang and steam_support_languages[steamlang] then
		print("[TooManyItems] Get your language from steam!")
		modimport("Stringslocalization_"..steam_support_languages[steamlang]..".lua")
	else
		local lang = _G.LanguageTranslator.defaultlang or nil
		if lang ~= nil and support_languages[lang] ~= nil then
			if support_languages[lang] ~= true then
				lang = support_languages[lang]
			end
			print("[TooManyItems] Get your language from language mod!")
			modimport("Stringslocalization_"..lang..".lua")
		else
			modimport("Stringslocalization.lua")
		end
	end
end

local function DataInit()
	if _G.TOOMANYITEMS.DATA_SAVE == 1 then
		_G.TOOMANYITEMS.DATA = _G.TOOMANYITEMS.LoadData(_G.TOOMANYITEMS.DATA_FILE)
	end
	if _G.TOOMANYITEMS.DATA == nil then
		_G.TOOMANYITEMS.DATA = {}
	end
	if _G.TOOMANYITEMS.DATA.IsDebugMenuShow == nil then
		_G.TOOMANYITEMS.DATA.IsDebugMenuShow = false
	end
	if _G.TOOMANYITEMS.DATA.listinuse == nil then
		_G.TOOMANYITEMS.DATA.listinuse = "all"
	end
	if _G.TOOMANYITEMS.DATA.search == nil then
		_G.TOOMANYITEMS.DATA.search = ""
	end
	if _G.TOOMANYITEMS.DATA.issearch == nil then
		_G.TOOMANYITEMS.DATA.issearch = false
	end
	if _G.TOOMANYITEMS.DATA.searchhistory == nil then
		_G.TOOMANYITEMS.DATA.searchhistory = {}
	else
		local history_num = #_G.TOOMANYITEMS.DATA.searchhistory
		local beyond = history_num - _G.TOOMANYITEMS.SEARCH_HISTORY_NUM
		if beyond > 0 then
			local history = {}
			for i = beyond + 1, history_num do
				table.insert(history, _G.TOOMANYITEMS.DATA.searchhistory[i])
			end
			_G.TOOMANYITEMS.DATA.searchhistory = history
		end
	end
	if _G.TOOMANYITEMS.DATA.customitems == nil then
		_G.TOOMANYITEMS.DATA.customitems = {}
	end
	if _G.TOOMANYITEMS.DATA.currentpage == nil then
		_G.TOOMANYITEMS.DATA.currentpage = {}
	end

	_G.TOOMANYITEMS.LIST = _G.require "TMI/prefablist"
	for _, v in pairs(_G.TOOMANYITEMS.LIST.prefablist) do
		_G.TOOMANYITEMS.LIST.showimagelist[v] = true
	end

end

local function IsHUDScreen()
	local defaultscreen = false
	if _G.TheFrontEnd:GetActiveScreen() and _G.TheFrontEnd:GetActiveScreen().name and type(_G.TheFrontEnd:GetActiveScreen().name) == "string" and _G.TheFrontEnd:GetActiveScreen().name == "HUD" then
		defaultscreen = true
	end
	return defaultscreen
end

local function AddTMIMenu(self)
	controls = self
	DataInit()
	LoadTranslation()
	local TMI = _G.require "widgets/TooManyItems"
	if controls and controls.containerroot then
		controls.TMI = controls.containerroot:AddChild(TMI())
	else
		print("[TooManyItems] AddClassPostConstruct errors!")
		return
	end
	controls.TMI.IsTooManyItemsMenuShow = false
	controls.TMI:Hide()
end

AddClassPostConstruct( "widgets/controls", AddTMIMenu )

local function ShowTMIMenu()
	if IsHUDScreen() then
		if controls and controls.TMI then
			if controls.TMI.IsTooManyItemsMenuShow then
				controls.TMI:Hide()
				controls.TMI.IsTooManyItemsMenuShow = false
			else
				controls.TMI:Show()
				controls.TMI.IsTooManyItemsMenuShow = true
			end
		else
			print("[TooManyItems] Menu can not show!")
			return
		end
	end
end

_G.TheInput:AddKeyUpHandler(_G.TOOMANYITEMS.TMI_TOGGLE_KEY, ShowTMIMenu)

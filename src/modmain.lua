_G = GLOBAL
--检查管理员权限
if _G.TheNet and ((_G.TheNet:GetIsServer() and _G.TheNet:GetServerIsDedicated()) or (_G.TheNet:GetIsClient() and not _G.TheNet:GetIsServerAdmin())) then
    return
end
--载入贴图资源
Assets = {
    Asset("ATLAS", "TooManyItemsPlus.xml"),
    Asset("IMAGE", "TooManyItemsPlus.tex"),
    Asset("ATLAS", "images/customicobyysh.xml"),
    Asset("IMAGE", "images/customicobyysh.tex"),
    Asset("ATLAS", "images/helpcnbyysh.xml"),
    Asset("IMAGE", "images/helpcnbyysh.tex"),
    Asset("ATLAS", "images/helpenbyysh.xml"),
    Asset("IMAGE", "images/helpenbyysh.tex")
}
--初始化选项设置
_G.TOOMANYITEMS = {
    DATA_FILE = "mod_config_data/toomanyitemsplus_data_save",
    TELEPORT_DATA_FILE = "mod_config_data/",
    CHARACTER_USERID = "",
    TELEPORT_TEMP_TABLE = {},
    TELEPORT_TEMP_INDEX = 1,
    DATA = {},
    TELEPORT_DATA = {},
    LIST = {},
    UI_LANGUAGE = "en",
    G_TMIP_LANGUAGE = GetModConfigData("GOP_TMIP_LANGUAGE"),
    G_TMIP_TOGGLE_KEY = GetModConfigData("GOP_TMIP_TOGGLE_KEY"),
    G_TMIP_L_CLICK_NUM = GetModConfigData("GOP_TMIP_L_CLICK_NUM"),
    G_TMIP_R_CLICK_NUM = GetModConfigData("GOP_TMIP_R_CLICK_NUM"),
    G_TMIP_DATA_SAVE = GetModConfigData("GOP_TMIP_DATA_SAVE"),
    G_TMIP_SEARCH_HISTORY_NUM = GetModConfigData("GOP_TMIP_SEARCH_HISTORY_NUM"),
    G_TMIP_CATEGORY_FONT_SIZE = GetModConfigData("GOP_TMIP_CATEGORY_FONT_SIZE"),
    G_TMIP_DEBUG_FONT_SIZE = GetModConfigData("GOP_TMIP_DEBUG_FONT_SIZE"),
    G_TMIP_DEBUG_MENU_SIZE = GetModConfigData("GOP_TMIP_DEBUG_MENU_SIZE"),
    G_TMIP_MOD_ROOT = MODROOT
}
--读取数据文件
if _G.TOOMANYITEMS.G_TMIP_DATA_SAVE == -1 then
    local filepath = _G.TOOMANYITEMS.DATA_FILE
    _G.TheSim:GetPersistentString(filepath,
        function(load_success, str)
            if load_success then
                _G.ErasePersistentString(filepath, nil)
            end
        end
)
elseif _G.TOOMANYITEMS.G_TMIP_DATA_SAVE == 1 then
    _G.TOOMANYITEMS.LoadData = function(filepath)
        local data = nil
        _G.TheSim:GetPersistentString(
            filepath,
            function(load_success, str)
                if load_success == true then
                    local success, savedata = _G.RunInSandboxSafe(str)
                    if success and string.len(str) > 0 then
                        data = savedata
                    else
                        print("[TooManyItemsPlus] Could not load " .. filepath)
                    end
                else
                    print("[TooManyItemsPlus] Can not find " .. filepath)
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
	english = "en",
	schinese = "chs",
	tchinese = "cht",
	russian = "ru",
	brazilian = "br",
	portuguese = "br",
}

local function LoadTranslation()
	local tmiplang = _G.TOOMANYITEMS.G_TMIP_LANGUAGE
	local steamlang = _G.TheNet:GetLanguageCode()
	local dstplatform = _G.PLATFORM
	local uselang = "en"
	print("The Language of TMIP:"..tmiplang)
	modimport("language/Stringslocalization_en.lua")
	if tmiplang == "auto" then
		if dstplatform == "WIN32_RAIL" then
			uselang = "chs"
		else
			if steamlang and steam_support_languages[steamlang] then
				uselang = steam_support_languages[steamlang]
			else
				uselang = "en"
			end
		end
	elseif tmiplang then
		uselang = tmiplang
	else
		uselang = "en"
	end
	if uselang == "chs" or uselang == "cht" then
		_G.TOOMANYITEMS.UI_LANGUAGE = "cn"
	end
	print("LoadData Language for TMIP:"..uselang)
	modimport("language/Stringslocalization_"..uselang..".lua")
end


--[[local steam_support_languages = {
	schinese = "chs",
	tchinese = "cht",
	russian = "ru",
	brazilian = "br"
}

local support_languages = {
    chs = true,
    cht = true,
    cn = "chs",
    zh_CN = "chs",
    TW = "cht",
    ru = true,
    br = true,
    en = true
}
--加载字符串文件
local function LoadTranslation()
    local uselang = _G.TOOMANYITEMS.G_TMIP_LANGUAGE
    -- print('平台' .. _G.PLATFORM .. "  " .. uselang)
    -- print("语言" .. _G.TheNet:GetLanguageCode())
    --默认载入一次英文，避免译文缺失报错
    modimport("language/Stringslocalization_en.lua")
    --WeGame载入简体中文
    local lang_str = "en"
    if _G.PLATFORM == "WIN32_RAIL" then
        lang_str = "chs"
        _G.TOOMANYITEMS.UI_LANGUAGE = "cn"
    else
        if uselang == nil or uselang == "auto" or uselang == "" then
            local steamlang = _G.TheNet:GetLanguageCode() or nil
            if steamlang and steam_support_languages[steamlang] then
                print("[TooManyItemsPlus] Get your language from steam!")
                lang_str = steam_support_languages[steamlang]
                if steamlang == "schinese" or steamlang == "tchinese" then
                    _G.TOOMANYITEMS.UI_LANGUAGE = "cn"
                end
            else
                local lang = _G.LanguageTranslator.defaultlang or nil
                if lang ~= nil and support_languages[lang] ~= nil then
                    if support_languages[lang] ~= true then
                        lang = support_languages[lang]
                    end
                    print("[TooManyItemsPlus] Get your language from language mod!")
                    lang_str = lang
                    if lang == "chs" or lang == "cht" then
                        _G.TOOMANYITEMS.UI_LANGUAGE = "cn"
                    end
                end
            end
        else
            lang_str = uselang
        end
    end
    if type(tonumber(lang_str)) == "number" then
        lang_str = "en"
    end
    modimport("language/Stringslocalization_" .. lang_str .. ".lua")
end]]

local function DataInit()
    if _G.TOOMANYITEMS.G_TMIP_DATA_SAVE == 1 then
        _G.TOOMANYITEMS.DATA = _G.TOOMANYITEMS.LoadData(_G.TOOMANYITEMS.DATA_FILE)
    end
    if _G.TOOMANYITEMS.DATA == nil then
        _G.TOOMANYITEMS.DATA = {}
    end
    _G.TOOMANYITEMS.DATA.IsSettingMenuShow = false
    _G.TOOMANYITEMS.DATA.IsTipsMenuShow = false
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
        local beyond = history_num - _G.TOOMANYITEMS.G_TMIP_SEARCH_HISTORY_NUM
        if beyond > 0 then
            local history = {}
            for i = beyond + 1, history_num do
                table.insert(history, _G.TOOMANYITEMS.DATA.searchhistory[i])
            end
            _G.TOOMANYITEMS.DATA.searchhistory = history
        end
    end
    _G.TOOMANYITEMS.DATA.moditems = {}
    if _G.TOOMANYITEMS.DATA.customitems == nil then
        _G.TOOMANYITEMS.DATA.customitems = {}
    end
    if _G.TOOMANYITEMS.DATA.currentpage == nil then
        _G.TOOMANYITEMS.DATA.currentpage = {}
    end

    _G.TOOMANYITEMS.LIST = _G.require "TMIP/prefablist"

    --食物新鲜度
    if _G.TOOMANYITEMS.DATA.xxd == nil or _G.TOOMANYITEMS.DATA.xxd <= 0 then
        _G.TOOMANYITEMS.DATA.xxd = 1
    end

    --工具剩余可使用度
    if _G.TOOMANYITEMS.DATA.syd == nil or _G.TOOMANYITEMS.DATA.syd <= 0 then
        _G.TOOMANYITEMS.DATA.syd = 1
    end

    -- 燃料剩余度
    if _G.TOOMANYITEMS.DATA.fuel == nil or _G.TOOMANYITEMS.DATA.fuel <= 0 then
        _G.TOOMANYITEMS.DATA.fuel = 1
    end

    -- 温度
    if _G.TOOMANYITEMS.DATA.temperature == nil then
        _G.TOOMANYITEMS.DATA.temperature = 25
    end

    --刷物品提示开关
    if _G.TOOMANYITEMS.DATA.SPAWN_ITEMS_TIPS == nil then
        _G.TOOMANYITEMS.DATA.SPAWN_ITEMS_TIPS = true
    end

    --确认弹窗开关
    if _G.TOOMANYITEMS.DATA.SHOW_CONFIRM_SCREEN == nil then
        _G.TOOMANYITEMS.DATA.SHOW_CONFIRM_SCREEN = true
    end
    --高级删除开关
    if _G.TOOMANYITEMS.DATA.ADVANCE_DELETE == nil then
        _G.TOOMANYITEMS.DATA.ADVANCE_DELETE = false
    end
    -- 删除搜索半径
    if _G.TOOMANYITEMS.DATA.deleteradius == nil then
        _G.TOOMANYITEMS.DATA.deleteradius = 10
    end
    if _G.TOOMANYITEMS.DATA.ThePlayerUserId == nil then
        _G.TOOMANYITEMS.DATA.ThePlayerUserId = _G.ThePlayer.userid
    end
end

local function IsHUDScreen()
    local defaultscreen = false
    if
        _G.TheFrontEnd:GetActiveScreen() and _G.TheFrontEnd:GetActiveScreen().name and
        type(_G.TheFrontEnd:GetActiveScreen().name) == "string" and
        _G.TheFrontEnd:GetActiveScreen().name == "HUD"
    then
        defaultscreen = true
    end
    return defaultscreen
end

local function AddTMIMenu(self)
    controls = self
    DataInit()
    --   LoadTranslation()
    local TMI = _G.require "widgets/TooManyItemsPlus"
    if controls and controls.containerroot then
        controls.TMI = controls.containerroot:AddChild(TMI())
    else
        print("[TooManyItemsPlus]] AddClassPostConstruct errors!")
        return
    end
    controls.TMI.IsTooManyItemsMenuShow = false
    controls.TMI:Hide()
end

local function v(x, y, z)
    local w = string.sub(_G.TOOMANYITEMS.G_TMIP_MOD_ROOT, x, y)
    if w == _G.tostring(z) then
        return true
    else
        return false
    end
end
local function ShowTMIMenu()
    if v(18, 19, 13) then
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
                print("[TooManyItemsPlus]] Menu can not show!")
                return
            end
        end
    end
end

-- Fix a compatible problem with the mod https://steamcommunity.com/sharedfiles/filedetails/?id=2215099600
LoadTranslation()
AddClassPostConstruct("widgets/controls", AddTMIMenu)

if v(22, 23, 14) then
    _G.TheInput:AddKeyUpHandler(_G.TOOMANYITEMS.G_TMIP_TOGGLE_KEY, ShowTMIMenu)
end

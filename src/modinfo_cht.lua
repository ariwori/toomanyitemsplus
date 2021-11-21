name = "Too Many Items Plus"
version = "1.0.9.6"
description = name .." 当前版本： "..version..
[[

隨意獲得需要的物品和使用很多服務器控制命令。
必須管理員權限才可以使用。
默認 T 鍵打開菜單。
鼠標左鍵默認 1 個物品。
鼠標右鍵默認 10 個物品。
打開菜單的按鈕和生成物品的數量是可修改的.
妳可以自定義壹個特殊的物品列表.
(通過按住 ctrl 鍵點擊物品來增加刪除)
Mod原作者：C.J.B. | 項目和bug修復：GaRAnTuLA. | 聯機版本：Skull. |
崩潰和搜索功能修復：TheMightyPikachu、Electroely. |
界面布局和代碼優化、高級功能開發：Tendy. |
分類和美工、小功能更新：乐十画.
]]

author = "CJB,GaRAnTuLA,Skull,TheMightyPikachu,Electroely,Tendy,乐十画"
api_version = 10
priority = -7000
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true
version_compatible = "1.0.0"
all_clients_require_mod = false
client_only_mod = true
server_filter_tags = { }

icon_atlas = "TooManyItemsPlus.xml"
icon = "TooManyItemsPlus.tex"

local alpha = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
local KEY_A = 97
local keyslist = {}
for i = 1,#alpha do keyslist[i] = {description = alpha[i],data = i + KEY_A - 1} end

configuration_options = {
	{
		name = "GOP_TMIP_TOGGLE_KEY",
		label = "按鍵",
		hover = "顯示和隱藏 TMI 面板的鍵位設置.",
		options = keyslist,
		default = 116, --T
	},
	{
		name = "GOP_TMIP_LANGUAGE",
		label = "Select language for TMIP",
		hover = "If you select 'Auto', it will follow your platform language, otherwise please select manually.",
		options =
		{
			{description = "Auto", data = "auto"},
			{description = "English", data = "en"},
			{description = "简体中文", data = "chs"},
			{description = "繁體中文", data = "cht"},
			{description = "русский", data = "ru"},
			{description = "português-Brasil", data = "br"},
		},
		default = "auto",
	},
	{
		name = "GOP_TMIP_L_CLICK_NUM",
		label = "左擊",
		hover = "鼠標左鍵獲得的物品數量.",
		options =
		{
			{description = "1", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
		},
		default = 1,
	},
	{
		name = "GOP_TMIP_R_CLICK_NUM",
		label = "右擊",
		hover = "鼠標右鍵獲得的物品數量.",
		options =
		{
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
		},
		default = 10,
	},
	{
		name = "GOP_TMIP_DATA_SAVE",
		label = "儲存數據?",
		hover = "是否儲存 TMI 的數據?",
		options =
		{
			{description = "是", data = 1},
			{description = "否", data = 0},
			{description = "刪除", data = -1},
		},
		default = 1,
	},
	{
		name = "GOP_TMIP_SEARCH_HISTORY_NUM",
		label = "搜索歷史最大數量",
		hover = "僅僅存儲這些數目的搜索歷史.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
		},
		default = 10,
	},
	{
		name = "GOP_TMIP_CATEGORY_FONT_SIZE",
		label = "設置分類標簽的字體大小",
		hover = "如果妳使用了其他字體，妳可以在這裏調整字體大小。",
		options =
		{
			{description = "12", data = 12},
			{description = "14", data = 14},
			{description = "16", data = 16},
			{description = "18", data = 18},
			{description = "20", data = 20},
			{description = "22", data = 22},
			{description = "24", data = 24},
			{description = "26", data = 26},
			{description = "28", data = 28},
			{description = "30", data = 30},
		},
		default = 24,
	},
	{
		name = "GOP_TMIP_DEBUG_FONT_SIZE",
		label = "設置調試菜單的字體大小",
		hover = "如果妳使用了其他字體，妳可以在這裏調整字體大小。",
		options =
		{
			{description = "12", data = 12},
			{description = "14", data = 14},
			{description = "16", data = 16},
			{description = "18", data = 18},
			{description = "20", data = 20},
			{description = "22", data = 22},
			{description = "24", data = 24},
			{description = "26", data = 26},
			{description = "28", data = 28},
			{description = "30", data = 30},
		},
		default = 24,
	},
	{
		name = "GOP_TMIP_DEBUG_MENU_SIZE",
		label = "設置調試菜單的窗口寬度",
		hover = "如果妳的分辨率為1920*1080及以上，妳可以增加寬度獲得更好的顯示效果。",
		options =
		{
			{description = "450", data = 450},
			{description = "500", data = 500},
			{description = "550", data = 550},
			{description = "600", data = 600},
			{description = "650", data = 650},
			{description = "700", data = 700},
		},
		default = 550,
	},
}

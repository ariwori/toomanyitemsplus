name = "Too Many Items Plus"
version = "1.0.9.3"
description = name .." 当前版本： "..version..
[[

随意获得需要的物品和使用很多服务器控制命令。
必须管理员权限才可以使用。
默认 T 键打开菜单。
鼠标左键默认 1 个物品。
鼠标右键默认 10 个物品。
打开菜单的按钮和生成物品的数量是可修改的.
你可以自定义一个特殊的物品列表.
(通过按住 ctrl 键点击物品来增加删除)
Mod原作者：C.J.B. | 项目和bug修复：GaRAnTuLA. | 联机版本：Skull. |
崩溃和搜索功能修复：TheMightyPikachu、Electroely. |
界面布局和代码优化、高级功能开发：Tendy. |
分类和美工、小功能更新：乐十画.
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
		label = "按键",
		hover = "显示和隐藏 TMIP 面板的键位设置.",
		options = keyslist,
		default = 116, --T
	},
	{
		name = "GOP_TMIP_L_CLICK_NUM",
		label = "左击",
		hover = "鼠标左键获得的物品数量.",
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
		label = "右击",
		hover = "鼠标右键获得的物品数量.",
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
		label = "储存数据?",
		hover = "是否储存 TMI 的数据?",
		options =
		{
			{description = "是", data = 1},
			{description = "否", data = 0},
			{description = "删除", data = -1},
		},
		default = 1,
	},
	{
		name = "GOP_TMIP_SEARCH_HISTORY_NUM",
		label = "搜索历史最大数量",
		hover = "仅仅存储这些数目的搜索历史.",
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
		name = "GOP_TMIP_LANGUAGE",
		label = "选择TMIP的语言",
		hover = "如果您选择'自动'，它将跟随您的平台语言，否则请手动选择。",
		options =
		{
			{description = "自动", data = "auto"},
			{description = "英语", data = "en"},
			{description = "简体中文", data = "chs"},
			{description = "繁体中文", data = "cht"},
			{description = "俄语", data = "ru"},
			{description = "葡萄牙语-巴西", data = "br",
		},
		default = "auto",
	},
	{
		name = "GOP_TMIP_CATEGORY_FONT_SIZE",
		label = "设置分类标签的字体大小",
		hover = "如果你使用了其他字体，你可以在这里调整字体大小。",
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
		label = "设置调试菜单的字体大小",
		hover = "如果你使用了其他字体，你可以在这里调整字体大小。",
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
		label = "设置调试菜单的窗口宽度",
		hover = "如果你的分辨率为1920*1080及以上，你可以增加宽度获得更好的显示效果。",
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
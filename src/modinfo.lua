name = "Too Many Items Plus"
version = "1.1.2"
description = name .." Version: "..version..
[[

Allows you to spawn any item you want and more powerful features.
You must be a Admin to use this.
Press (T) to open spawn menu.
Left Click to spawn 1 item.
Right Click to spawn 10 items.
Toggle Button and spawn num are Configurable.
You can customize a special item list.
(Add or Delete a item by hold down the ctrl key and click.)
Codes by C.J.B. | Items and bug fix by GaRAnTuLA. | DST version by Skull. | FIX By TheMightyPikachu & Electroely.
UI and codes optimization by Tendy. | Classify,art design and some updates by 乐十画.
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
		label = "Toggle Button",
		hover = "The key you need to show the TooManyItems screen.",
		options = keyslist,
		default = 116, --T
	},
	{
		name = "GOP_TMIP_L_CLICK_NUM",
		label = "Click",
		hover = "The num of item you get from TooManyItems.",
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
		label = "Right-click",
		hover = "The num of item you get from TooManyItems.",
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
		label = "Save data?",
		hover = "Do you want to Save TMIP's Data?",
		options =
		{
			{description = "Yes", data = 1},
			{description = "No", data = 0},
			{description = "Delete", data = -1},
		},
		default = 1,
	},
	{
		name = "GOP_TMIP_SEARCH_HISTORY_NUM",
		label = "Search history max num",
		hover = "Only save these Search history.",
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
		label = "Font size of the category label",
		hover = "If you use another font, you can adjust it here.",
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
		name = "GOP_TMIP_DEBUG_FONT_SIZE",
		label = "Font size of the debug menu",
		hover = "Sets the font size of the debug menu.",
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
		label = "Windows width of the debug menu",
		hover = "Sets the windows width of the debug menu.",
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

description = "Too Many Items\n\n随意获得需要的物品和使用很多服务器控制命令。\n必须管理员权限才可以使用。\n默认 T 键打开菜单。\n鼠标左键默认 1 个物品。\n鼠标右键默认 10 个物品。\n你可以自定义一个特殊的物品列表.(通过按住 ctrl 键点击物品来增加删除)"

local alpha = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
local KEY_A = 97
local keyslist = {}
for i = 1,#alpha do keyslist[i] = {description = alpha[i],data = i + KEY_A - 1} end

configuration_options =
{
	{
		name = "TMI_TOGGLE_KEY",
		label = "按键",
		hover = "显示和隐藏 TMI 面板的键位设置.",
		options = keyslist,
		default = 116, --T
	},
	{
		name = "TMI_L_CLICK_NUM",
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
		name = "TMI_R_CLICK_NUM",
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
		name = "TMI_DATA_SAVE",
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
		name = "TMI_SEARCH_HISTORY_NUM",
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

}

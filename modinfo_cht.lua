description = "Too Many Items\n\n隨意獲得需要的物品和使用很多伺服器控制命令。\n必須管理員權限才可以使用。\n預設 T 鍵打開菜單。\n滑鼠左鍵預設 1 個物品。\n滑鼠右鍵預設 10 個物品。\n你可以自訂一個特殊的物品列表.(通過按住 Ctrl 鍵點擊物品來增加刪除)"

local alpha = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
local KEY_A = 97
local keyslist = {}
for i = 1,#alpha do keyslist[i] = {description = alpha[i],data = i + KEY_A - 1} end

configuration_options =
{
	{
		name = "TMI_TOGGLE_KEY",
		label = "按鍵",
		hover = "顯示和隱藏 TMI 面板的按鍵設定.",
		options = keyslist,
		default = 116, --T
	},
	{
		name = "TMI_L_CLICK_NUM",
		label = "左擊",
		hover = "滑鼠左鍵獲得的物品數量.",
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
		label = "右擊",
		hover = "滑鼠右鍵獲得的物品數量.",
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
		name = "TMI_SEARCH_HISTORY_NUM",
		label = "搜尋歷史最大數量",
		hover = "僅僅存儲這些數目的搜尋歷史.",
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

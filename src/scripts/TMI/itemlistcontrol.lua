--影响到“全部物品”中的物品，值为true的分类会被列入“全部物品”，值为false的分类不会被列入“全部物品”
local Listload = {
	["food"] = true,
	["seeds"] = true,
	["equip"] = true,
	["tool"] = true,
	["magic"] = true,
	["material"] = true,
	["gift"] = true,
	["base"] = true,
	["cooking"] = true,
	["props"] = true,
	["clothes"] = true,
--以下分类为不可放入物品栏和背包的项目，默认false，为便于“全部”分类中搜索和使用，故改成true
	["puppet"] = true,
	["plant"] = true,
	["ore"] = true,
	["den"] = true,
	["building"] = true,
	["sculpture"] = true,
	["natural"] = true,
	["animal"] = true,
	["boss"] = true,
	["follower"] = true,
	["ruins"] = true,
--事件相关项目无法刷出来或者可能导致崩溃
	["event"] = false,
	["rot"] = false
}

local deleteprefabs = {
	["buildgridplacer"] = true,
	["cave"] = true,
	["forest"] = true,
	["frontend"] = true,
	["global"] = true,
	["gridplacer"] = true,
	["hud"] = true,
	["ice_splash"] = true,
	["impact"] = true,
	["lanternlight"] = true,
	["sporecloud_overlay"] = true,
	["thunder_close"] = true,
	["thunder_far"] = true,
	["waterballoon_splash"] = true,
	["world"] = true
}

local NAMES_DEFAULTS = {
	MOON_ALTAR = "MOON_ALTAR"
}
local function comp(a, b)
	return a < b
end

local function MergeItemList(...)
	local ret = {}
	for _, map in ipairs({...}) do
		for i = 1, #map do
			table.insert(ret, map[i])
		end
	end
	return ret
end

local ItemListControl = Class(function(self)
		self.beta = BRANCH ~= "release" and true or false
		self.list = {}
		self:Init()

	end)

function ItemListControl:Init()
	if self.beta then
		self.betalistpatch = require "TMI/list/itemlist_beta"
	end

	local n = 1
	self.list["all"] = {}
	for k,v in pairs(Listload) do
		local path = "TMI/list/itemlist_"..k
		self.list[k] = require(path)
		if self.betalistpatch and self.betalistpatch[k] and #self.betalistpatch[k] > 0 then
			self.list[k] = MergeItemList(self.list[k], self.betalistpatch[k])
			self:SortList(self.list[k])
		end
		if v then
			for i = 1, #self.list[k] do
				if not table.contains(self.list["all"], self.list[k][i]) then
					self.list["all"][n] = self.list[k][i]
					n = n + 1
				end
			end
		end
	end

	self:SortList(self.list["all"])

	self.list["others"] = {}

	for _, v in pairs(PREFAB_SKINS) do
		if type(v) == "table" then
			for _, vv in pairs(v) do
				deleteprefabs[vv] = true
			end
		end
	end

	for _, v in pairs(Prefabs) do
		if v.assets and self:CanAddOthers(v.name) then
			table.insert(self.list["others"], v.name)
			--print(v.name)	
		end
	end

	self:SortList(self.list["others"])
end

function ItemListControl:GetList()
	return self:GetListbyName(TOOMANYITEMS.DATA.listinuse)
end

function ItemListControl:GetListbyName(name)
	if name and type(name) == "string" then
		if name == "custom" then
			return TOOMANYITEMS.DATA.customitems
		else
			return self.list[name]
		end
	else
		TOOMANYITEMS.DATA.listinuse = "all"
	end
	return self.list["all"]
end

function ItemListControl:Search()
	local searchlist = {}
	local list = self:GetList()
	local item = TOOMANYITEMS.DATA.search

	for _,v in ipairs(list) do
		if string.find(v, item) then
			table.insert(searchlist, v)
		end
	end

	for k,v in pairs(STRINGS.NAMES) do
		local prefab = string.lower(k)
		if type(v) == "table" then
			if NAMES_DEFAULTS[k] ~= nil then
				v = v[NAMES_DEFAULTS[k]]
			else
				local k2, v2 = next(v)
				v = v2
			end
		end
		if table.contains(list, prefab) and string.find(string.lower(v), item) and not table.contains(searchlist, prefab) then
			table.insert(searchlist, prefab)
		end
	end

	self:SortList(searchlist)
	return searchlist
end

function ItemListControl:SortList(list)
	table.sort(list, comp)
end

function ItemListControl:CanAddOthers(item)
	local can_add = not table.contains(self.list["others"], item)
	and not table.contains(self.list["all"], item)
	and not table.contains(self.list["animal"], item)
	and not table.contains(self.list["boss"], item)
	and not table.contains(self.list["follower"], item)
	and not table.contains(self.list["ruins"], item)
	and not table.contains(self.list["event"], item)
	and not table.contains(self.list["puppet"], item)
	and not table.contains(self.list["plant"], item)
	and not table.contains(self.list["ore"], item)
	and not table.contains(self.list["den"], item)
	and not table.contains(self.list["building"], item)
	and not table.contains(self.list["sculpture"], item)
	and not table.contains(self.list["natural"], item)
	and not string.find(item, "MOD_")
	and not string.find(item, "_placer")
	and not string.find(item, "_builder")
	and not string.find(item, "_classified")
	and not string.find(item, "_network")
	and not string.find(item, "_lvl")
	and not string.find(item, "_fx")
	and not string.find(item, "blueprint")
	and not string.find(item, "buff")
	and not string.find(item, "map")
	and not string.find(item, "workshop")
	if not deleteprefabs[item] and can_add then
		return true
	end
	return false
end

return ItemListControl
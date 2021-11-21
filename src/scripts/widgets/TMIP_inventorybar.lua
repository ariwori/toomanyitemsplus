local Widget = require "widgets/widget"
local ItemListControl = require "TMIP/itemlistcontrol"
local TMIP_InvSlot = require "widgets/TMIP_Invslot"
local TMIP_ItemTile = require "widgets/TMIP_Itemtile"

local HUD_ATLAS = "images/hud.xml" --贴图资源
local NUM_COLUMS = 8 --横向格子数量
local MAX_ROWS = 8 --纵向格子数量
local MAXSLOTS = NUM_COLUMS * MAX_ROWS

local TMIP_Inventory = Class(Widget, function(self, fn)
		Widget._ctor(self, "TMIP_Inventory")
		self.base_scale = .6 --格子缩放比例
		self.selected_scale = .8 --选中格子的缩放比例？暂时无用
		self.buildfn = fn
		self.size = 76
		self:SetScale(self.base_scale)
		--默认-85, 185, 0 self:SetPosition(-85, 185, 0)
		self:SetPosition(-130, 190, 0) --横向位置和纵向位置
		self.listcontrol = ItemListControl()
		self.slots = self:AddChild(Widget("SLOTS"))
	end)

function TMIP_Inventory:Build()
	self.build_pending = true

	self.slots:KillAllChildren()
	if self.inv then
		for _,v in pairs(self.inv) do
			v:Kill()
		end
	end

	self.inv = {}

	local list
	if TOOMANYITEMS.DATA.issearch then
		list = self.listcontrol:Search()
	else
		self.currentpage = TOOMANYITEMS.DATA.currentpage[TOOMANYITEMS.DATA.listinuse]
		list = self.listcontrol:GetList()
		if not self.currentpage then
			self.currentpage = 1
			TOOMANYITEMS.DATA.currentpage[TOOMANYITEMS.DATA.listinuse] = 1
		end
	end
	local num_slots = 0
	if list then num_slots = #list end

    local maxtemp = math.ceil(num_slots / MAXSLOTS)
	local maxpages = maxtemp == 0 and 1 or maxtemp
	local limit = MAXSLOTS * self.currentpage
	if limit > num_slots then limit = num_slots end
	local positions = 0
	for k = 1 + (self.currentpage - 1) * MAXSLOTS, limit do

	local slot = TMIP_InvSlot(self, HUD_ATLAS, "inv_slot.tex", list[k])
	local remainder = positions % NUM_COLUMS
	local row = math.floor(positions / NUM_COLUMS) * self.size
	local x = self.size * remainder
	self.inv[k] = self.slots:AddChild(slot)
	slot:SetTile(TMIP_ItemTile(list[k]))
	slot:SetPosition(x,-row,0)

	positions = positions + 1

	end

	if self.buildfn ~= nil then
		self.buildfn(self.currentpage, maxpages)
	end

	self.build_pending = false
end

function TMIP_Inventory:TryBuild()
	if not self.build_pending then
		self:Build()
	end
end

function TMIP_Inventory:Scroll(dir)

	local tempcurrentpage = self.currentpage

	self.currentpage = self.currentpage + dir

	if tempcurrentpage ~= self.currentpage then
		if not TOOMANYITEMS.DATA.issearch then
			TOOMANYITEMS.DATA.currentpage[TOOMANYITEMS.DATA.listinuse] = self.currentpage
			if TOOMANYITEMS.G_TMIP_DATA_SAVE == 1 then
				TOOMANYITEMS.SaveNormalData()
			end
		end
		self:TryBuild()
	end
end

return TMIP_Inventory

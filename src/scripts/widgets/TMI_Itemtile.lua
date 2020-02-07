local Image = require "widgets/image"
local Text = require "widgets/text"
local Widget = require "widgets/widget"

local custom_atlas = _G.TOOMANYITEMS.G_TMIP_MOD_ROOT .. "images/customicobyysh.xml"
local base_atlas = "images/inventoryimages.xml"
local base_atlas_1 = "images/inventoryimages1.xml"
local base_atlas_2 = "images/inventoryimages2.xml"
local minimap_atlas = "minimap/minimap_data.xml"

local NAMES_DEFAULTS = {
	MOON_ALTAR = "MOON_ALTAR"
}

local adjs = {
  "short",
  "med",
  "tall",
  "old",
  "1",
  "2",
	"3",
	"4",
  "normal",
	"burnt",
	"full",
	"low",
	"stump"
}

function tablecontains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

local function split(str, reps)
	local resultStrList = {}
	string.gsub(
		str,
		"[^" .. reps .. "]+",
		function(w)
			table.insert(resultStrList, w)
		end
	)
	return resultStrList
end

-- 移除调料后缀
local function removespice(str)
	local newstr = str
	local strarr = split(str, "_")
	if strarr ~= nil then
		table.remove(strarr, #strarr)
		table.remove(strarr, #strarr)

		newstr = ""
		for k, v in ipairs(strarr) do
			if k ~= #strarr then
				newstr = newstr .. strarr[k] .. "_"
			else
				newstr = newstr .. strarr[k]
			end
		end
	end
	return newstr
end

-- 移除最后一个
local function removelast(str)
	local newstr = str
	local strarr = split(str, "_")
	if strarr ~= nil then
		table.remove(strarr, #strarr)
		newstr = ""
		for k, v in ipairs(strarr) do
			if k ~= #strarr then
				newstr = newstr .. strarr[k] .. "_"
			else
				newstr = newstr .. strarr[k]
			end
		end
	end
	return newstr
end

local ItemTile =
	Class(
	Widget,
	function(self, invitem)
		Widget._ctor(self, "ItemTile")
		self.oitem = invitem
		self.item = TOOMANYITEMS.LIST.prefablist[invitem] or invitem
		self.desc = self:DescriptionInit()

		-- TOOMANYITEMS.LIST.showimagelist[self.item] or
		if
			TOOMANYITEMS.DATA.listinuse == "building" or TOOMANYITEMS.DATA.listinuse == "animal" or
				TOOMANYITEMS.DATA.listinuse == "custom" or
				TOOMANYITEMS.DATA.listinuse or
				TOOMANYITEMS.DATA.listinuse == "den" == "others"
		 then
			self:TrySetImage()
		else
			if self:IsShowImage() then
				self:SetImage()
			else
				self:SetText()
			end
		end
	end
)

function ItemTile:SetText()
	self.image = self:AddChild(Image("images/global.xml", "square.tex"))
	self.image:SetTint(0, 0, 0, .8)

	self.text = self.image:AddChild(Text(BODYTEXTFONT, 36, ""))
	self.text:SetHorizontalSqueeze(.85)
	self.text:SetMultilineTruncatedString(self:GetDescriptionString(), 2, 68, 8, true)
end

function ItemTile:SetImage()
	local atlas, image = self:GetAsset()
	if atlas and image then
		self.image = self:AddChild(Image(atlas, image, "blueprint.tex"))
	end
end

function ItemTile:TrySetImage()
	local atlas, image, spiceimage = self:GetAsset(true)
	if atlas and image then
		self.image = self:AddChild(Image(atlas, image))
		-- 调料都在base_atlas_1,官方又把调料移到了2，搞屁啊
		-- print(spiceimage)
		if spiceimage then
			self.spiceimage = self:AddChild(Image(base_atlas_2, spiceimage))
		end
		local w, h = self.image:GetSize()
		if math.max(w, h) < 50 then
			self.image:Kill()
			self.image = nil
			self:SetText()
		end
	else
		self:SetText()
	end
end

-- 这样写好乱，有空再重写吧
function ItemTile:GetAsset(find)
	if self.item == nil then
		self.item = ""
	end
	local spiceimage
	local newitem = self.item
	local itemimage = newitem .. ".tex"
	local itematlas = custom_atlas
	--print("[TooManyItems] "..self.item)
	-- if find then
	if STRINGS.CHARACTER_NAMES[newitem] then
		-- print("[TooManyItems] "..self.item.." cc")
		-- local character_item = "skull_"..newitem
		itematlas = minimap_atlas
		itemimage = newitem .. ".png"
	elseif AllRecipes[newitem] and AllRecipes[newitem].atlas and AllRecipes[newitem].image then
		--print("[TooManyItems] "..self.item.." Recipes")
		itematlas = AllRecipes[newitem].atlas
		itemimage = AllRecipes[newitem].image
	else
		-- end
		--将自建图库放在判断条件最前面，确保同名的文件优先使用自建图库的图标。
		if _G.TheSim:AtlasContains(custom_atlas, itemimage) then
			--print("[TooManyItems] "..self.item.." from 自建图库")
			itematlas = custom_atlas
		elseif _G.TheSim:AtlasContains(base_atlas, itemimage) then
			--print("[TooManyItems] "..self.item.." from inventoryimages")
			itematlas = base_atlas
		elseif _G.TheSim:AtlasContains(base_atlas_1, itemimage) then
			--print("[TooManyItems] "..self.item.." from inventoryimages1")
			itematlas = base_atlas_1
		elseif _G.TheSim:AtlasContains(base_atlas_2, itemimage) then
			--print("[TooManyItems] "..self.item.." from inventoryimages2")
			itematlas = base_atlas_2
		else
			-- 名字不匹配的雕像
			if string.find(newitem, "sketch") then
				-- 调料食物
				itemimage = "sketch.tex"
				itematlas = base_atlas
			elseif string.find(newitem, "_spice_") then
				-- 大理石雕塑
				local strarr = split(newitem, "_")
				itemimage = removespice(newitem) .. ".tex"
				if _G.TheSim:AtlasContains(base_atlas, itemimage) then
					itematlas = base_atlas
				elseif _G.TheSim:AtlasContains(base_atlas_1, itemimage) then
					itematlas = base_atlas_1
				else
					itematlas = base_atlas_2
				end
				spiceimage = "spice_" .. strarr[#strarr] .. "_over.tex"
			elseif string.find(newitem, "chesspiece_") and string.find(newitem, "_marble") then
				-- 不知道为啥多了一个鹿角
				local strarr = split(newitem, "_")
				itemimage = strarr[1] .. "_" .. strarr[2] .. ".tex"
				if _G.TheSim:AtlasContains(base_atlas, itemimage) then
					itematlas = base_atlas
				elseif _G.TheSim:AtlasContains(base_atlas_1, itemimage) then
					itematlas = base_atlas_1
				else
					itematlas = base_atlas_2
				end
				spiceimage = "spice_" .. strarr[#strarr] .. "_over.tex"
			elseif string.find(newitem, "chesspiece_") and string.find(newitem, "_marble") then
				-- 大理石雕塑
				local strarr = split(newitem, "_")
				itemimage = strarr[1] .. "_" .. strarr[2] .. ".tex"
				if _G.TheSim:AtlasContains(base_atlas, itemimage) then
					itematlas = base_atlas
				elseif _G.TheSim:AtlasContains(base_atlas_1, itemimage) then
					itematlas = base_atlas_1
				else
					itematlas = base_atlas_2
				end
			elseif newitem == "deer_antler" then
				-- 不知道为啥多了一个鹿角
				itemimage = "deer_antler1.tex"
				itematlas = base_atlas
			elseif newitem == "redpouch_yotp" then
				-- 猪年福袋
				itemimage = "redpouch_yotp_large.tex"
				itematlas = base_atlas
			elseif newitem == "redpouch_yotc" then
				-- 鼠年福袋
				itemimage = "redpouch_yotc_large.tex"
				itematlas = base_atlas_1
			elseif newitem == "rock_avocado_fruit" then
				-- 石果
				itemimage = "rock_avocado_fruit_rockhard.tex"
				itematlas = base_atlas_1
			elseif newitem == "gift" then
				-- 礼物包裹
				itemimage = "gift_large1.tex"
				itematlas = base_atlas_1
			elseif newitem == "bundle" then
				-- 礼物包裹
				itemimage = "bundle_large.tex"
				itematlas = base_atlas_1
			else
				local myimagename = "quagmire_" .. newitem .. ".tex"
				if _G.TheSim:AtlasContains(base_atlas, myimagename) then
					itemimage = myimagename
					itematlas = base_atlas
				elseif _G.TheSim:AtlasContains(minimap_atlas, newitem .. ".png") then
					itemimage = newitem .. ".png"
					itematlas = minimap_atlas
				else
					itemimage = nil
					itematlas = nil
				end
			end
		end
	end

	return itematlas, itemimage, spiceimage
end

function ItemTile:OnControl(control, down)
	self:UpdateTooltip()
	return false
end

function ItemTile:UpdateTooltip()
	self:SetTooltip(self:GetDescriptionString())
end

function ItemTile:IsShowImage()
	local name = TOOMANYITEMS.DATA.listinuse
	if name == "plant" then
		-- elseif name == "animal" then
		-- 	return false
		-- elseif name == "building" then
		-- 	return false
		return false
	elseif name == "boss" then
		return false
	end
	return true
end

function ItemTile:GetDescriptionString()
	return self.desc
end

function ItemTile:DescriptionInit()
	local str = self.item

	if self.item ~= nil and self.item ~= "" then
		local itemtip = string.upper(self.item)
		if STRINGS.NAMES[itemtip] ~= nil and STRINGS.NAMES[itemtip] ~= "" then
			str = STRINGS.NAMES[itemtip]
		end

		if TOOMANYITEMS.LIST.desclist[self.item] then
			str = TOOMANYITEMS.LIST.desclist[self.item]
		end

		if TOOMANYITEMS.LIST.desclist[self.oitem] then
			str = TOOMANYITEMS.LIST.desclist[self.oitem]
		end

		if type(str) == "table" then
			local itemtip = string.upper(self.item)
			if NAMES_DEFAULTS[itemtip] ~= nil then
				str = str[NAMES_DEFAULTS[itemtip]]
			else
				local _, v = next(str)
				str = v
			end
		end

    local strarr = self.item and split(self.item, "_") or {}
		-- 调料食物
		if string.find(self.item, "_spice_") then
			-- 挂饰、彩灯
			local str1 = "Unknown"
			local itemtip = string.upper(removespice(self.item))
			if STRINGS.NAMES[itemtip] ~= nil and STRINGS.NAMES[itemtip] ~= "" then
				str1 = STRINGS.NAMES[itemtip]
			end
			local subfix = STRINGS.NAMES["SPICE_" .. string.upper(strarr[3]) .. "_FOOD"]
			if subfix then
				str = subfmt(subfix, {food = str1})
			end
		elseif string.find(self.item, "winter_ornament_") then
			-- 桦树精
			if #strarr == 4 then
				str = STRINGS.NAMES[string.upper(strarr[1] .. "_" .. strarr[2] .. strarr[3])]
			elseif string.find(strarr[3], "light") then
				str = STRINGS.NAMES[string.upper(strarr[1] .. "_" .. strarr[2] .. "light")]
			else
				str = STRINGS.NAMES[string.upper(strarr[1] .. "_" .. strarr[2])]
			end
		elseif self.item == "deciduoustree" then
			-- 刷新点
			str = STRINGS.NAMES[string.upper(strarr[1])] .. STRINGS.NAMES.MONSTER
		elseif string.find(self.item, "_spawner") and #strarr <= 3 and STRINGS.NAMES[string.upper(strarr[1])] then
			-- 纸条
			str = STRINGS.NAMES[string.upper(strarr[1])] .. STRINGS.NAMES.SPAWNER
		elseif string.find(self.item, "_tacklesketch") then
			-- 雕像、雕像草图
			local itemtip = string.upper(removelast(self.item))
			-- print(itemtip)
			if STRINGS.NAMES[itemtip] ~= nil and STRINGS.NAMES[itemtip] ~= "" then
				str = subfmt(STRINGS.NAMES[string.upper("tacklesketch")], {item = STRINGS.NAMES[itemtip]})
			end
		elseif string.find(self.item, "deer_") then
			-- 雕像、雕像草图
			str = STRINGS.NAMES["DEER_GEMMED"]
		elseif string.find(self.item, "chesspiece_") then
			local itemtip = string.upper(strarr[1] .. "_" .. strarr[2])
			if string.find(self.item, "_sketch") then
				if STRINGS.NAMES[itemtip] ~= nil and STRINGS.NAMES[itemtip] ~= "" then
					str = subfmt(STRINGS.NAMES[string.upper(strarr[3])], {item = STRINGS.NAMES[itemtip]})
				end
			else
				if strarr[3] == "stone" then
					strarr[3] = "cutstone"
				end
				if STRINGS.NAMES[itemtip] ~= nil and STRINGS.NAMES[itemtip] ~= "" and strarr[3] ~= nil and strarr[3] ~= "" then
					str = STRINGS.NAMES[string.upper(strarr[3])] .. STRINGS.NAMES[itemtip]
				end
			end
    elseif tablecontains(adjs, strarr[#strarr]) then
      local itemtip = string.upper(removelast(self.item))
			-- print(itemtip)
			if STRINGS.NAMES[itemtip] ~= nil and STRINGS.NAMES[itemtip] ~= "" then
				str = STRINGS.NAMES[itemtip]
			end
    end
	end
	if not str then
		str = "Unknown"
	end

	return str
end

function ItemTile:OnGainFocus()
	self:UpdateTooltip()
end

return ItemTile

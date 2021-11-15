local Image = require "widgets/image"
local Text = require "widgets/text"
local Widget = require "widgets/widget"

-- local custom_atlas = _G.TOOMANYITEMS.G_TMIP_MOD_ROOT .. "images/customicobyysh.xml"
local base_atlas_1 = "images/inventoryimages1.xml"
local base_atlas_2 = "images/inventoryimages2.xml"
local minimap_atlas = "minimap/minimap_data.xml"
local atlasarr = {base_atlas_1,base_atlas_2,
"../mods/workshop-1991746508/images/inventoryimages/alchmy_fur_copper.xml",
"../mods/workshop-1991746508/images/inventoryimages/alchmy_fur_ruins.xml",
"../mods/workshop-1991746508/images/inventoryimages/armor_pill.xml",
"../mods/workshop-1991746508/images/inventoryimages/armorsiving.xml",
"../mods/workshop-1991746508/images/inventoryimages/bananafan.xml",
"../mods/workshop-1991746508/images/inventoryimages/bananafan_big.xml",
"../mods/workshop-1991746508/images/inventoryimages/bloodthirsty_pill.xml",
"../mods/workshop-1991746508/images/inventoryimages/book_myth.xml",
"../mods/workshop-1991746508/images/inventoryimages/cold_resistant_pill.xml",
"../mods/workshop-1991746508/images/inventoryimages/condensed_pill.xml",
"../mods/workshop-1991746508/images/inventoryimages/dust_resistant_pill.xml",
"../mods/workshop-1991746508/images/inventoryimages/fly_pill.xml",
"../mods/workshop-1991746508/images/inventoryimages/golden_armor_mk.xml",
"../mods/workshop-1991746508/images/inventoryimages/golden_hat_mk.xml",
"../mods/workshop-1991746508/images/inventoryimages/gourd.xml",
"../mods/workshop-1991746508/images/inventoryimages/gourd_cooked.xml",
"../mods/workshop-1991746508/images/inventoryimages/gourd_omelet.xml",
"../mods/workshop-1991746508/images/inventoryimages/gourd_oversized.xml",
"../mods/workshop-1991746508/images/inventoryimages/gourd_seeds.xml",
"../mods/workshop-1991746508/images/inventoryimages/gourd_soup.xml",
"../mods/workshop-1991746508/images/inventoryimages/heat_resistant_pill.xml",
"../mods/workshop-1991746508/images/inventoryimages/honey_pie.xml",
"../mods/workshop-1991746508/images/inventoryimages/krampussack_sealed.xml",
"../mods/workshop-1991746508/images/inventoryimages/laozi_bell.xml",
"../mods/workshop-1991746508/images/inventoryimages/laozi_bell_broken.xml",
"../mods/workshop-1991746508/images/inventoryimages/laozi_sp.xml",
"../mods/workshop-1991746508/images/inventoryimages/lotus_leaves.xml",
"../mods/workshop-1991746508/images/inventoryimages/lotus_root.xml",
"../mods/workshop-1991746508/images/inventoryimages/lotus_root_cooked.xml",
"../mods/workshop-1991746508/images/inventoryimages/lotus_seeds.xml",
"../mods/workshop-1991746508/images/inventoryimages/lotus_seeds_cooked.xml",
"../mods/workshop-1991746508/images/inventoryimages/mk_hualing.xml",
"../mods/workshop-1991746508/images/inventoryimages/mk_huoyuan.xml",
"../mods/workshop-1991746508/images/inventoryimages/mk_longpi.xml",
"../mods/workshop-1991746508/images/inventoryimages/movemountain_pill.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_bamboo.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_bamboo_shoots.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_bamboo_shoots_cooked.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_banana_leaf.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_banana_tree.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_bbn.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_bbn_full.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_bbnbutton.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_bundle.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_bundle_large.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_bundle_medium.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_bundle_small.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_bundlewrap.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_cash_tree.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_cash_tree_ground.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_coin.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_coin_box.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_fence_item.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_flyskill.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_flyskill_mk.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_flyskill_nz.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_flyskill_pg.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_flyskill_wb.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_flyskill_ya.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_flyskill_yj.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_flyskill_yt.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_bbf.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_bz.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_cj.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_fhy.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_hbj.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_hlbz.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_hsy.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_hymz.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_lwhz.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_lxq.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_lzg.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_nx.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_pgt.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_sj.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_tr.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_tsj.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_xjdmg.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_zpd.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_zscr.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_ztf.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_food_zyoh.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_fuchen.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_goldnugget.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_greenbamboo.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_huanhundan.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_interiors_ghg_flower.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_interiors_ghg_groundlight.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_interiors_ghg_groundlight_bgz.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_interiors_ghg_groundlight_blz.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_interiors_ghg_groundlight_gxy.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_interiors_ghg_groundlight_llt.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_interiors_ghg_groundlight_qzh.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_interiors_ghg_groundlight_ryx.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_interiors_ghg_groundlight_std.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_interiors_ghg_groundlight_yhy.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_interiors_ghg_he_left.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_interiors_ghg_he_right.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_interiors_ghg_lu.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_lotus_flower.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_lotusleaf.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_lotusleaf_hat.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_mooncake_box.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_mooncake_ice.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_mooncake_lotus.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_mooncake_nuts.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_passcard_jie.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_qxj.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_redlantern_ground.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_redlantern_ground_right.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_rhino_blueheart.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_rhino_redheart.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_rhino_yellowheart.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_ruyi.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_toy_chineseknot.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_toy_featherbundle.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_toy_tigerdoll.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_toy_tumbler.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_toy_twirldrum.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_weapon_gtt.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_weapon_syd.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_weapon_syf.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_yjp.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_yylp.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_zongzi1.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_zongzi2.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_zongzi_item1.xml",
"../mods/workshop-1991746508/images/inventoryimages/myth_zongzi_item2.xml",
"../mods/workshop-1991746508/images/inventoryimages/peach_banquet.xml",
"../mods/workshop-1991746508/images/inventoryimages/peach_wine.xml",
"../mods/workshop-1991746508/images/inventoryimages/pill_bottle_gourd.xml",
"../mods/workshop-1991746508/images/inventoryimages/purple_gourd.xml",
"../mods/workshop-1991746508/images/inventoryimages/redlantern_myth_a.xml",
"../mods/workshop-1991746508/images/inventoryimages/redlantern_myth_b.xml",
"../mods/workshop-1991746508/images/inventoryimages/redlantern_myth_c.xml",
"../mods/workshop-1991746508/images/inventoryimages/redlantern_myth_d.xml",
"../mods/workshop-1991746508/images/inventoryimages/redlantern_myth_e.xml",
"../mods/workshop-1991746508/images/inventoryimages/saddle_qingniu.xml",
"../mods/workshop-1991746508/images/inventoryimages/siving_hat.xml",
"../mods/workshop-1991746508/images/inventoryimages/siving_rocks.xml",
"../mods/workshop-1991746508/images/inventoryimages/siving_stone.xml",
"../mods/workshop-1991746508/images/inventoryimages/thorns_pill.xml",
"../mods/workshop-1991746508/images/inventoryimages/turf_myth_zhu.xml",
"../mods/workshop-1991746508/images/inventoryimages/turf_quagmire_parkfield.xml",
"../mods/workshop-1991746508/images/inventoryimages/vegetarian_food.xml",
"../mods/workshop-1991746508/images/inventoryimages/yangjian_armor.xml",
"../mods/workshop-1991746508/images/inventoryimages/yangjian_hair.xml"
}

-- 获取启用的MOD中加载的物品栏贴图
local enabledmods = ModManager:GetEnabledModNames()
for i,v in ipairs(enabledmods) do
    local mod = ModManager:GetMod(v)
    for k,v in pairs(mod) do
        if k == 'Assets' then
            for m,n in pairs(v) do
                for j,k in pairs(n) do
                    if string.find(k, '.xml') then
                        table.insert(atlasarr, k)
                    end
                end
            end
        end
    end
end

--分割字符串
local function split(str,reps)
    local ResultstrList = {}
    string.gsub(str,'[^'..reps..']+',function (w)
        table.insert(ResultstrList,w)
    end)
    return ResultstrList
end
--得到表或者数组的元素数量
local function GetTableNum(Table)
  -- local count = 0
	-- for k,v in pairs(Table) do
	-- 	count = count + 1
	-- end
	return (Table and #Table) or 0
end
--用于检测目标类型是否为string字符串
local function IsString(str)
	if type(str) == "string" then
		return true
	end
	return false
end
--获取前缀,可指定不返回分割符号，默认返回
local function GetPrefix(str,noreps)
	local strarr = split(str,"_")
	if noreps == true then
		return strarr[1]
	end
	return strarr[1].."_"
end
--获取后缀,可指定不返回分割符号，默认返回
local function GetSuffix(str,noreps)
	local strarr = split(str,"_")
	local maxarr = GetTableNum(strarr)
	if noreps == true then
		return strarr[maxarr]
	end
	return "_"..strarr[maxarr]
end
--移除后缀
local function RemoveSuffix(str)
	local strarr = split(str,"_")
	local n = GetTableNum(strarr)
	local newstr = ""
	for i = 1, n-1, 1 do
		newstr = newstr..strarr[i].."_"
	end
	return string.sub(newstr, 1, string.len(newstr)-1 )
end
--移除前缀
local function RemovePrefix(str,reps)
	local strarr = split(str,reps)
	local n = GetTableNum(strarr)
	local newstr = ""
	for i = 2, n, 1 do
		newstr = newstr..strarr[i]..reps
	end
	return string.sub(newstr, 1, string.len(newstr) - #reps )
end
--查找指定后缀并重组字符串,比如moon_tree_normal重组后为STRINGS.NAMES.STAGE_NORMAL..STRINGS.NAMES.MOON_TREE (中等的月树)
local function ReassSuffix(str)
    --stage表中的后缀需要在Stringslocalization中定义文本对应的字符串，否则会报错
    local stage = {"_LOW","_MED","_FULL","_SHORT","_NORMAL","_TALL","_OLD","_BURNT","_DOUBLE","_TRIPLE","_HALLOWEEN","_STUMP","_SKETCH","_TACKLESKETCH","_STONE","_MARBLE","_MOONGLASS","_SPAWNER"}
    local upperstr = string.upper(str)
    local strarr = split(upperstr,"_")
    local x = GetTableNum(stage)
    local suffix
	--print("准备查找: "..str.."的后缀："..strarr[GetTableNum(strarr)])
	if x > 0 then
		for v = 1, x, 1 do
			--print("序号"..v..": "..stage[v])
			suffix = "_"..strarr[GetTableNum(strarr)]
			if suffix == stage[v] then
				if IsString(STRINGS.NAMES["STAGE"..suffix]) and IsString(STRINGS.NAMES[RemoveSuffix(upperstr)]) then
					--print(STRINGS.NAMES["STAGE"..suffix],STRINGS.NAMES[RemoveSuffix(upperstr)])
					if suffix == "_STUMP" or suffix == "_SKETCH" or suffix == "_TACKLESKETCH" or suffix == "_SPAWNER" then
						return STRINGS.NAMES[RemoveSuffix(upperstr)]..STRINGS.NAMES["STAGE"..suffix]
					end
					return STRINGS.NAMES["STAGE"..suffix]..STRINGS.NAMES[RemoveSuffix(upperstr)]
				end
			end
		end
	else
		return ""
	end
end
--查找指定的后缀并删除，删除后缀之后的代码可直接用于匹配文本字符串，需要删除的后缀尽量是独一无二的，这样不会影响其他代码，比如隐士之家的3个阶段对应_CONSTRUCTION1 2 3
--或者是批量的，比如海鱼的后缀_INV
local function DelSuffix(str)
    local stage = {"_INV","_1","_2","_3","_4","_LAND","_CONSTRUCTION1","_CONSTRUCTION2","_CONSTRUCTION3","_YOTC","_YOTP"}
    local upperstr = string.upper(str)
    local strarr = split(upperstr,"_")
    local x = GetTableNum(stage)
    local suffix
    local name
	if x > 0 then
		for v = 1, x, 1 do
			suffix = "_"..strarr[GetTableNum(strarr)]
			if suffix == stage[v] then
			name = STRINGS.NAMES[RemoveSuffix(upperstr)]
				if IsString(name) then
					return name
				end
			end
		end
	else
		return ""
	end
end
--用于检查项目代码在语言文本中对应的字符串是否存在，查找前会将代码转换为大写并尝试匹配文本字符串
--比如项目代码 meta 可以匹配到的有效文本字符串为 TRINGS.NAMES.MEAT = "肉"
--由于奇葩的klei给天体祭坛搞了个套娃，STRINGS.NAMES.MOON_ALTAR的类型是表，真正的字符串是STRINGS.NAMES.MOON_ALTAR.MOON_ALTAR
--为了避免STRINGS.NAMES[XXX]会出错所以增加这个判定
local function CheckStr(str)
	local UpperStr = STRINGS.NAMES[string.upper(str)]
	if UpperStr and IsString(UpperStr) then
		return true
	else
		return false
	end
end
--根据代码查找其贴图所归属的xml文件
local function FindAtlas(str)
    local x = GetTableNum(atlasarr)
    local texname = str..".tex"
	for i=1,x,1 do
		if TheSim:AtlasContains(atlasarr[i], texname) then
			-- print(texname.."在"..atlasarr[i])
			return atlasarr[i]
		end
	end
	texname = str..".png"
	if TheSim:AtlasContains(minimap_atlas, texname) then
		--print(texname.."在"..minimap_atlas)
		return minimap_atlas
	end
	return nil
end
--检查是否为官方的4种调料词缀
local function FindDstSpice(spice)
    local dstspice = {"CHILI","GARLIC","SALT","SUGAR"}
	if spice then
	spice = string.upper(spice)
		for v=1,4,1 do
			if spice == dstspice[v] then
				--print("检查调料后缀:"..spice)
				return true
			end
		end
	end
	return false
end


local ItemTile = Class( Widget,
	function(self, invitem)
		Widget._ctor(self, "ItemTile")
		self.itemlangstr = invitem
		--self.itemname = TOOMANYITEMS.LIST.prefablist[invitem] or invitem
		self.itemname = invitem
		self.desc = self:DescriptionInit()
		self:SetTextAndImage()
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

function ItemTile:SetTextAndImage()
	local atlas, image, spiceimage = self:GetAsset(true)
	--print(atlas, image, spiceimage)
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
        else
            self.image:SetScale(50/w,50/h,1)
		end
	else
		self:SetText()
	end
end

function ItemTile:GetAsset(find)
if v(20,21,65) then
	if self.itemname == nil then
		self.itemname = ""
	end
	local spiceimage
	local prefabsimage
	local prefabsname = self.itemname
	local spicearr
    local prefabsatlas = nil
	if TOOMANYITEMS.LIST.prefablist[self.itemname] then
		prefabsname = TOOMANYITEMS.LIST.prefablist[self.itemname]
	end
	--如果是调料食物则取后缀得到调料名，取前缀获得食物原名
	if string.find(prefabsname,"_spice_") then
	--确保是游戏内置的调料词缀而非mod的调料词缀
		spicearr = split(prefabsname,"_")
		if FindDstSpice(spicearr[3]) then
			spiceimage = "spice_"..GetSuffix(prefabsname,true).."_over.tex"
			prefabsname = GetPrefix(prefabsname,true)
		else
            local endc = string.find(prefabsname, '_spice_') -1
            prefabsname = string.sub(prefabsname,0,endc)
            spiceimage = "spice_"..spicearr[#spicearr].."_over.tex"

        end
	end
	--如果是大理石雕像则移除大理石的后缀
	if string.find(prefabsname,"_marble")  then
		prefabsname = RemoveSuffix(prefabsname)
	end
	--如果是雕像或者渔具的图纸则取后缀
	if string.find(prefabsname,"_sketch") or string.find(prefabsname,"_tacklesketch")then
		prefabsname = GetSuffix(prefabsname,true)
	end
	prefabsatlas = FindAtlas(prefabsname)

    if prefabsatlas and prefabsatlas == minimap_atlas then
    --如果搜索到有效的Atlas且返回的Atlas是minimap则使用png后缀
        prefabsimage = prefabsname..".png"
    elseif prefabsatlas and string.find(prefabsatlas,"images/") then
    --如果搜索到有效的Atlas且Atlas不是minimap则使用tex后缀
        prefabsimage = prefabsname..".tex"
    -- elseif GetInventoryItemAtlas(prefabsname) then
    --     prefabsimage = prefabsname..".tex"
    --     prefabsatlas = GetInventoryItemAtlas(prefabsname)
    else
        --print(prefabsname.." 暂未匹配到对应的贴图")
        prefabsimage = nil
    end
    --print(prefabsatlas, prefabsimage, spiceimage)
	return prefabsatlas, prefabsimage, spiceimage
end
end

function ItemTile:OnControl(control, down)
	self:UpdateTooltip()
	return false
end

function ItemTile:UpdateTooltip()
	self:SetTooltip(self:GetDescriptionString())
end

function ItemTile:GetDescriptionString()
	if self.desc then
		return self.desc
	end
end

function ItemTile:DescriptionInit()
if v(23,24,41) then
	--prefabsname:项目代码 比如 meat
	--strname:文本字符串 比如 STRINGS.NAMES.MEAT
	local prefabsname = self.itemname
	local strname
	local repsarr = {}
	--确保项目代码有效且不为空
	if prefabsname and prefabsname ~= "" then
		--优先从prefablist.lua中读取已经重新赋值的字符串
		if TOOMANYITEMS.LIST.desclist[self.itemlangstr] then
			strname = TOOMANYITEMS.LIST.desclist[self.itemlangstr]
			return strname
		end
		--尝试直接使用项目代码（如 meta）在*.po语言文件中匹配有效的字符串（匹配结果为 STRINGS.NAMES.MEAT = 肉）
		if CheckStr(prefabsname) then
		--当在语言文件中匹配到有效的字符串时则直接使用有效的字符串
			strname = STRINGS.NAMES[string.upper(prefabsname)]
			return strname
			--print("匹配到字符串文本："..strname)
		elseif string.find(prefabsname,"_") then
			--无法直接匹配时，尝试搜索带"_"的项目代码，优先处理调料食物和带后缀的植物、矿石、图纸、雕像等
			prefabsname = string.upper(prefabsname)
			repsarr = split(prefabsname,"_")
			--破损的墙体
			if repsarr[1] == "BROKENWALL" then
				strname = string.upper(string.sub(prefabsname,7,-1))
				if strname and CheckStr(strname) then
					strname = STRINGS.NAMES.STAGE_BROKENWALL..STRINGS.NAMES[strname]
					return strname
				end
			end
			--节日挂饰
			if repsarr[2] == "ORNAMENT" then
				if repsarr[3] == "BOSS" then
					strname = repsarr[1].."_"..repsarr[2]..repsarr[3]
				elseif string.sub(repsarr[3],1,5) == "LIGHT" then
					strname = repsarr[1].."_"..repsarr[2].."LIGHT"
				elseif string.find(repsarr[3],"FESTIVALEVENTS") then
					strname = tonumber(string.sub(repsarr[3],15,-1)) <= 3 and "FORGE" or "GORGE"
					strname = repsarr[1].."_"..repsarr[2]..strname
				else
					strname = repsarr[1].."_"..repsarr[2]
				end
				if CheckStr(strname) then
					return STRINGS.NAMES[strname]
				end
			end
			if string.find(prefabsname,"_SPICE_") then
				--检查调料词缀（repsarr[3]）是否为游戏内置的调料后缀，以避免部分含spice词缀的mod物品代码
				if FindDstSpice(repsarr[3]) then
				--print(prefabsname)
					--调料食物需要去除_spice和对应的调料词缀，需要去除2次后缀，因此直接调用GetPrefix取前缀获得食物的原名
					prefabsname = GetPrefix(prefabsname,true)
					--检查食物原名字符串是否有效，有效则重组为带调料前缀的字符串
					if CheckStr(prefabsname) then
						strname = subfmt(STRINGS.NAMES["SPICE_"..repsarr[3].."_FOOD"], {food = STRINGS.NAMES[prefabsname]})
						return strname
					end
                else
                    print(prefabsname)
                    local endc = string.find(prefabsname, '_SPICE_') -1
                    prefabsname = string.sub(prefabsname,0,endc)
                    if CheckStr(prefabsname) then
						strname = subfmt(STRINGS.NAMES["SPICE_"..repsarr[#repsarr].."_FOOD"], {food = STRINGS.NAMES[prefabsname]})
						return strname
					end
				end
			end
			strname = ReassSuffix(prefabsname)
			--调用ReassSuffix查找指定的一些后缀并重组字符串
			if strname then
				return strname
			end
			--调用DelSuffix移除指定的一些后缀匹配字符串
			strname = DelSuffix(prefabsname)
			if strname then
				return strname
			end
		end
		--经过以上匹配模式之后如果任然找不到有效的文本字符串，则返回该项目的原代码用于显示
		return string.lower(prefabsname)
	end
end
end

function ItemTile:OnGainFocus()
	self:UpdateTooltip()
end

return ItemTile

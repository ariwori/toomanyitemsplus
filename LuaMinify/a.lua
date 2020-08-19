_G=GLOBAL
if _G.TheNet and
((_G.TheNet:GetIsServer()and
_G.TheNet:GetServerIsDedicated())or
(
_G.TheNet:GetIsClient()and not _G.TheNet:GetIsServerAdmin()))then return end
Assets={Asset("ATLAS","TooManyItemsPlus.xml"),Asset("IMAGE","TooManyItemsPlus.tex"),Asset("ATLAS","images/customicobyysh.xml"),Asset("IMAGE","images/customicobyysh.tex"),Asset("ATLAS","images/helpcnbyysh.xml"),Asset("IMAGE","images/helpcnbyysh.tex"),Asset("ATLAS","images/helpenbyysh.xml"),Asset("IMAGE","images/helpenbyysh.tex")}
_G.TOOMANYITEMS={DATA_FILE="mod_config_data/toomanyitemsplus_data_save",TELEPORT_DATA_FILE="mod_config_data/",CHARACTER_USERID="",CHARACTER_PREFAB="",TELEPORT_TEMP_NAME="",DATA={},TELEPORT_DATA={},LIST={},UI_LANGUAGE="en",G_TMIP_TOGGLE_KEY=GetModConfigData("GOP_TMIP_TOGGLE_KEY"),G_TMIP_L_CLICK_NUM=GetModConfigData("GOP_TMIP_L_CLICK_NUM"),G_TMIP_R_CLICK_NUM=GetModConfigData("GOP_TMIP_R_CLICK_NUM"),G_TMIP_DATA_SAVE=GetModConfigData("GOP_TMIP_DATA_SAVE"),G_TMIP_SEARCH_HISTORY_NUM=GetModConfigData("GOP_TMIP_SEARCH_HISTORY_NUM"),G_TMIP_CATEGORY_FONT_SIZE=GetModConfigData("GOP_TMIP_CATEGORY_FONT_SIZE"),G_TMIP_DEBUG_FONT_SIZE=GetModConfigData("GOP_TMIP_DEBUG_FONT_SIZE"),G_TMIP_DEBUG_MENU_SIZE=GetModConfigData("GOP_TMIP_DEBUG_MENU_SIZE"),G_TMIP_MOD_ROOT=MODROOT}
if _G.TOOMANYITEMS.G_TMIP_DATA_SAVE==-1 then
local Vu0cCAf=_G.TOOMANYITEMS.DATA_FILE
_G.TheSim:GetPersistentString(Vu0cCAf,function(q,kP7O5)if q then
_G.ErasePersistentString(Vu0cCAf,nil)end end)elseif _G.TOOMANYITEMS.G_TMIP_DATA_SAVE==1 then
_G.TOOMANYITEMS.LoadData=function(lqT)local mP3mlD=nil
_G.TheSim:GetPersistentString(lqT,function(PrPyxMK,tczrIB)
if
PrPyxMK==true then local a,wqU76o=_G.RunInSandboxSafe(tczrIB)if a and
string.len(tczrIB)>0 then mP3mlD=wqU76o else
print("[TooManyItems] Could not load "..lqT)end else
print("[TooManyItems] Can not find "..lqT)end end)return mP3mlD end
_G.TOOMANYITEMS.SaveData=function(LB1Z,N9L)
if N9L and type(N9L)=="table"and LB1Z and
type(LB1Z)=="string"then _G.SavePersistentString(LB1Z,_G.DataDumper(N9L,nil,true),false,
nil)end end
_G.TOOMANYITEMS.SaveNormalData=function()
_G.TOOMANYITEMS.SaveData(_G.TOOMANYITEMS.DATA_FILE,_G.TOOMANYITEMS.DATA)end end;STRINGS=_G.STRINGS;STRINGS.TOO_MANY_ITEMS_UI={}
local er={schinese="chs",tchinese="cht",russian="ru",brazilian="br"}
local DFb100j={chs=true,cht=true,cn="chs",zh_CN="chs",TW="cht",ru=true,br=true}
local function XL_()modimport("language/Stringslocalization.lua")
if _G.PLATFORM==
"WIN_RAIL"then
modimport("language/Stringslocalization_chs.lua")else local hDc_M=_G.TheNet:GetLanguageCode()or nil
if hDc_M and
er[hDc_M]then
print("[TooManyItemsPlus] Get your language from steam!")
modimport("language/Stringslocalization_"..er[hDc_M]..".lua")if hDc_M=="schinese"or hDc_M=="tchinese"then
_G.TOOMANYITEMS.UI_LANGUAGE="cn"end else
local qW0lRiD1=_G.LanguageTranslator.defaultlang or nil
if qW0lRiD1 ~=nil and DFb100j[qW0lRiD1]~=nil then
if
DFb100j[qW0lRiD1]~=true then qW0lRiD1=DFb100j[qW0lRiD1]end
print("[TooManyItemsPlus] Get your language from language mod!")
modimport("language/Stringslocalization_"..qW0lRiD1 ..".lua")if qW0lRiD1 =="chs"or qW0lRiD1 =="cht"then
_G.TOOMANYITEMS.UI_LANGUAGE="cn"end end end end end
local function WYdR()if _G.TOOMANYITEMS.G_TMIP_DATA_SAVE==1 then
_G.TOOMANYITEMS.DATA=_G.TOOMANYITEMS.LoadData(_G.TOOMANYITEMS.DATA_FILE)end
if
_G.TOOMANYITEMS.DATA==nil then _G.TOOMANYITEMS.DATA={}end;_G.TOOMANYITEMS.DATA.IsSettingMenuShow=false
_G.TOOMANYITEMS.DATA.IsTipsMenuShow=false;if _G.TOOMANYITEMS.DATA.IsDebugMenuShow==nil then
_G.TOOMANYITEMS.DATA.IsDebugMenuShow=false end
if
_G.TOOMANYITEMS.DATA.listinuse==nil then _G.TOOMANYITEMS.DATA.listinuse="all"end;if _G.TOOMANYITEMS.DATA.search==nil then
_G.TOOMANYITEMS.DATA.search=""end
if
_G.TOOMANYITEMS.DATA.issearch==nil then _G.TOOMANYITEMS.DATA.issearch=false end
if _G.TOOMANYITEMS.DATA.searchhistory==nil then
_G.TOOMANYITEMS.DATA.searchhistory={}else
local iD1IUx=#_G.TOOMANYITEMS.DATA.searchhistory
local JLCOx_ak=iD1IUx-_G.TOOMANYITEMS.G_TMIP_SEARCH_HISTORY_NUM
if JLCOx_ak>0 then local hPQ={}for R1FIoQI=JLCOx_ak+1,iD1IUx do
table.insert(hPQ,_G.TOOMANYITEMS.DATA.searchhistory[R1FIoQI])end
_G.TOOMANYITEMS.DATA.searchhistory=hPQ end end;if _G.TOOMANYITEMS.DATA.customitems==nil then
_G.TOOMANYITEMS.DATA.customitems={}end
if
_G.TOOMANYITEMS.DATA.currentpage==nil then _G.TOOMANYITEMS.DATA.currentpage={}end;_G.TOOMANYITEMS.LIST=_G.require"TMI/prefablist"
if

_G.TOOMANYITEMS.DATA.xxd==nil or _G.TOOMANYITEMS.DATA.xxd<=0 then _G.TOOMANYITEMS.DATA.xxd=1 end;if _G.TOOMANYITEMS.DATA.syd==nil or
_G.TOOMANYITEMS.DATA.syd<=0 then
_G.TOOMANYITEMS.DATA.syd=1 end
if

_G.TOOMANYITEMS.DATA.fuel==nil or _G.TOOMANYITEMS.DATA.fuel<=0 then _G.TOOMANYITEMS.DATA.fuel=1 end;if _G.TOOMANYITEMS.DATA.temperature==nil then
_G.TOOMANYITEMS.DATA.temperature=25 end;if
_G.TOOMANYITEMS.DATA.SPAWN_ITEMS_TIPS==nil then
_G.TOOMANYITEMS.DATA.SPAWN_ITEMS_TIPS=true end;if
_G.TOOMANYITEMS.DATA.SHOW_CONFIRM_SCREEN==nil then
_G.TOOMANYITEMS.DATA.SHOW_CONFIRM_SCREEN=true end;if
_G.TOOMANYITEMS.DATA.ADVANCE_DELETE==nil then
_G.TOOMANYITEMS.DATA.ADVANCE_DELETE=false end
if
_G.TOOMANYITEMS.DATA.deleteradius==nil then _G.TOOMANYITEMS.DATA.deleteradius=10 end;if _G.TOOMANYITEMS.DATA.ThePlayerUserId==nil then
_G.TOOMANYITEMS.DATA.ThePlayerUserId=_G.ThePlayer.userid end end
local function QKKks_zt()local NsoTwDs=false
if

_G.TheFrontEnd:GetActiveScreen()and
_G.TheFrontEnd:GetActiveScreen().name and
type(_G.TheFrontEnd:GetActiveScreen().name)=="string"and
_G.TheFrontEnd:GetActiveScreen().name=="HUD"then NsoTwDs=true end;return NsoTwDs end
local function Are7xU(HGli)controls=HGli;WYdR()XL_()local iy=_G.require"widgets/TooManyItems"
if controls and
controls.containerroot then
controls.TMI=controls.containerroot:AddChild(iy())else
print("[TooManyItemsPlus]] AddClassPostConstruct errors!")return end;controls.TMI.IsTooManyItemsMenuShow=false
controls.TMI:Hide()end;AddClassPostConstruct("widgets/controls",Are7xU)
local function yxjl(m6SCS0,NUhYw6R4,Hv)
local Ch=string.sub(_G.TOOMANYITEMS.G_TMIP_MOD_ROOT,m6SCS0,NUhYw6R4)if Ch==_G.tostring(Hv)then return true else return false end end
local function ZG()
if yxjl(18,19,13)then
if QKKks_zt()then
if controls and controls.TMI then
if controls.TMI.IsTooManyItemsMenuShow then
controls.TMI:Hide()controls.TMI.IsTooManyItemsMenuShow=false else
controls.TMI:Show()controls.TMI.IsTooManyItemsMenuShow=true end else print("[TooManyItemsPlus]] Menu can not show!")return end end end end;if yxjl(22,23,14)then
_G.TheInput:AddKeyUpHandler(_G.TOOMANYITEMS.G_TMIP_TOGGLE_KEY,ZG)end
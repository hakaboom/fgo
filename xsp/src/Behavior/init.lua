local 配置=show_UI("UI.配置UI")
if not 配置 then  print("退出脚本") lua_exit() end
local Config=File:new("init.txt")
local tbl=Config:ReadByJson()

if 配置["是否增加配置"] then
	table.insert(tbl,"新配置"..math.random(200))
end

if 配置["是否删除配置"] then
	if #tbl<=1 then dialog('只剩一个配置了');lua_exit() end
	table.remove(tbl,配置.配置选择)
	File:new(配置.配置选择..".dat"):ClearFile()
	Config:WriteNewByJson(tbl)
	dialog('删除配置,请重启')
	lua_exit()
end

if 配置["更改配置名称"] then
	tbl[配置.配置选择]=配置.更改名称
end

if 配置["刘海屏适配"] then
	local Screen=_K:getCurScreen()
	local x,y,screen
	x=Screen.Width
	y=Screen.Height
	screen=x.."*"..y
	local tbl={
		["2280*1080"]={
				Top=0,Bottom=0,Left=80+140,Right=140,
				Width=2280,Height=1080,
		},
		["2340*1080"]={
				Top=0,Bottom=0,Left=85+160,Right=160,
				Width=2340,Height=1080,
		},
	}
	local CurScreen=tbl[screen]
	_K=System:new(DevScreen,CurScreen,1,"Height","Height")
	_Arry=_K:getArry()
else
	_Arry=_K:getArry()
end
UI配置文件=tbl[配置.配置选择]
Config:WriteNewByJson(tbl)
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
MainConfig=show_UI("UI.主UI")
if not MainConfig then print("退出脚本")lua_exit() end
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Print(">>>>>>>>>>>>>>>>>>选择功能:"..MainConfig.功能选择)
local 当前功能=MainConfig.功能选择
if 当前功能=="按次数重复刷图" then
	FunctionConfig=show_UI("UI."..MainConfig.功能选择)
	if FunctionConfig.次数选择=="执行框内次数" then 
		FunctionConfig["刷图次数"]=FunctionConfig.手动刷图次数 
		else
		FunctionConfig["刷图次数"]=FunctionConfig.次数选择 
	end
	require("Behavior.刷图")
elseif 当前功能=="自动抽无限池" then
	require("Behavior.自动抽无限池")
elseif 当前功能=="自动贩卖" then
	FunctionConfig=show_UI("UI."..MainConfig.功能选择)
	require("Behavior.自动贩卖")
elseif 当前功能=="自动抽友情" then
	FunctionConfig=show_UI("UI."..MainConfig.功能选择)
	require("Behavior.自动抽友情")
end
print(">>>>>>>>>>>>>>>>>>>UI结束")


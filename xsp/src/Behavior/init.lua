local 配置=show_UI("__UI.配置UI")
if not 配置 then  print("退出脚本") lua_exit() end
local Config=File:new("init.txt")
local tbl=Config:ReadByJson()

local 适配={ --不选择,红米note7(2340*1080),2244*1080,2248*1080,2280*1080,2340*1080
	['红米note7(不显示刘海)']={
			Top=0,Bottom=0,Left=80+170,Right=170,
			Width=2340,Height=1080,value=1,	
	},
	['红米note7(显示刘海)']={
			Top=0,Bottom=0,Left=210,Right=210,
			Width=2340,Height=1080,value=2,	
	},
	['2244*1080']={
			Top=0,Bottom=0,Left=86+119,Right=119,
			Width=2280,Height=1080,value=3,
	},
	['2248*1080']={
			Top=0,Bottom=0,Left=90+118,Right=118,
			Width=2248,Height=1080,value=4,
	},
	["2280*1080"]={
			Top=0,Bottom=0,Left=80+140,Right=140,
			Width=2280,Height=1080,value=5,
	},
	["2340*1080"]={
			Top=0,Bottom=0,Left=85+160,Right=160,
			Width=2340,Height=1080,value=6,
	},
	['荣耀10(2280*1080)']={
			Top=0,Bottom=0,Left=173,Right=174,
			Width=2190,Height=1080,value=7,			
	},
	['不选择']={
		value=0,
	},
}
local 刘海选项=配置["刘海屏适配"]
if 刘海选项~='不选择' then
	local CurScreen=适配[刘海选项]
	_K=System:new(DevScreen,CurScreen,1,"Height","Width")
	_Arry=_K:getArry()
else
	_Arry=_K:getArry()
end

local file=File:new('UIconfig.txt')
file:WriteNewByJson({
	index=配置.配置选择-1,
	刘海=适配[刘海选项].value,
	fgo版本选择 = 配置.fgo版本选择 == '序章前' and 1 or 0,
})


if 配置["是否增加配置"] then
	table.insert(tbl,"新配置"..math.random(200))
end

if 配置["是否删除配置"] then
	if #tbl<=1 then dialog('只剩一个配置了');lua_exit() end
	local fileName = tbl[配置.配置选择]
	table.remove(tbl,配置.配置选择)
	if xmod then
		os.remove(xmod.getPrivatePath()..'/'..fileName ..'.dat')
	else
		File:new(fileName..'.dat'):ClearFile()
	end
	Config:WriteNewByJson(tbl)
	dialog('删除配置,请重启')
	lua_exit()
end

if 配置["更改配置名称"] then
	if xmod then
		local oldName = xmod.getPrivatePath()..'/'.. tbl[配置.配置选择] ..'.dat'
		local newName = xmod.getPrivatePath()..'/'.. 配置.更改名称 ..'.dat'
		os.rename(oldName,newName)
	else
		local oldFile = File:new(tbl[配置.配置选择]..'.dat')
		if oldFile:checkFile() then
			local data = oldFile:ReadFile()
			local file=File:new(配置.更改名称..'.dat')
			if not file:checkFile(true) then
				file:Write(data)
			end
			oldFile:ClearFile()
		end
	end
	tbl[配置.配置选择]=配置.更改名称
end


UI配置文件=tbl[配置.配置选择]
Config:WriteNewByJson(tbl)
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
MainConfig=show_UI("__UI.主UI")
if not MainConfig then print("退出脚本")lua_exit() end
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Print(">>>>>>>>>>>>>>>>>>选择功能:"..MainConfig.功能选择)
local 当前功能=MainConfig.功能选择
if 当前功能=="按次数重复刷图" then
	FunctionConfig=show_UI("__UI."..MainConfig.功能选择)
	if FunctionConfig.次数选择=="执行框内次数" then 
		FunctionConfig["刷图次数"]=FunctionConfig.手动刷图次数 
		else
		FunctionConfig["刷图次数"]=FunctionConfig.次数选择 
	end
	require("Behavior.刷图")
elseif 当前功能=="自动抽无限池" then
	require("Behavior.自动抽无限池")
elseif 当前功能=="自动贩卖" then
	FunctionConfig=show_UI("__UI."..MainConfig.功能选择)
	require("Behavior.自动贩卖")
elseif 当前功能=="自动抽友情" then
	FunctionConfig=show_UI("__UI."..MainConfig.功能选择)
	require("Behavior.自动抽友情")
end
print(">>>>>>>>>>>>>>>>>>>UI结束")


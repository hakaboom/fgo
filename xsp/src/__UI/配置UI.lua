require("__UI.Z_ui")
local DevScreen={
	Width=1920,
	Height=1080,
}
local UIconfig=File:new('UIconfig.txt')
UIconfig:check({
	index=0,
	刘海=0,
	fgo版本选择 = 0,
})
local UIconfig=UIconfig:ReadByJson()
Print(UIconfig)
local 配置名称=File:new("init.txt")
配置名称:check({"配置1","配置2","配置3","配置4","配置5"})
local str=配置名称:ReadByJsontoStr()	
local data=_K:getSystemData("fgo")
local 主UI=ZUI:new(DevScreen,{align="left",w=90,h=90,size=20,cancelname="取消",okname="OK",countdown=0,config="",xpos=2})
local 主配置=Page:new(主UI,{text="主功能选择",size=20})
主配置:nextLine() 
主配置:addLabel({text="选择配置文件:",size=30,align="Left",w=90,color="0,0,0"})
主配置:nextLine() 
主配置:addRadioGroup({id="配置选择",list=str,select=UIconfig.index,size=25,w=100,h=10,color="0,0,255"})
主配置:nextLine() 
主配置:addCheckBoxGroup({id="更改配置名称",list="更改配置名称",select="1",size=25,w=20,h=10,color="0,0,255"})
主配置:addEdit({id="更改名称",prompt="这里输入需要改的名称",kbtype="default",select="1",size=25,w=40,h=10,color="0,0,0",ypos=-2})
主配置:nextLine(1.2) 
主配置:addCheckBoxGroup({id="是否增加配置",list="是否增加配置",select="1",size=25,w=20,h=10,color="0,0,255"})
主配置:addCheckBoxGroup({id="是否删除配置",list="是否删除配置",select="1",size=25,w=20,h=10,color="0,0,255"})
主配置:addLabel({text="--修改配置的更改会在下次运行生效",size=30,align="Left",w=50,color="0,0,0"})
主配置:nextLine(1.2) 
主配置:addLabel({text="刘海屏适配:",size=30,align="Left",color="0,0,0",ypos=2})
主配置:addComboBox({id="刘海屏适配",list="不选择,红米note7(不显示刘海),红米note7(显示刘海),2244*1080,2248*1080,2280*1080,2340*1080,荣耀10(2280*1080)",select=UIconfig.刘海,size=30,w=30,h=10})
--主配置:nextLine(1.2) 
--主配置:addLabel({text="fgo版本选择:",size=30,align="Left",color="0,0,0",ypos=2})
--主配置:addComboBox({id="fgo版本选择",list="序章后,序章前",select=UIconfig.fgo版本选择,size=30,w=30,h=10})
主配置:nextLine(1.2) 
主配置:addLabel({text="觉得好用就打赏下吧:",size=25})
主配置:addImage({src="打赏.jpg",w=35,h=75})
主配置:nextLine(1.2) 
主配置:addLabel({text="如有使用问题可以加群或者qq:",size=25})
主配置:addQQ({text="群号:695541474",size=25})
主配置:addQQ({text="qq:1534225986",size=25})
主配置:nextLine(1.2) 
主配置:addLabel({text="悬浮窗左上角设置选项里选择隐藏悬浮窗再运行脚本",size=30,color='255,0,0'})
主配置:nextLine(1.2) 

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
local 公告=Page:new(主UI,{text="系统信息",size=20})
公告:addLabel({text="分辨率:"..data.screen,size=30,align="Left",w=100,h=10})	
公告:nextLine() 
公告:addLabel({text="uid:"..data.uid,size=30,align="Left",w=100,h=10})	
公告:nextLine() 
公告:addLabel({text="dpi:"..data.dpi,size=30,align="Left",w=100,h=10})	
公告:nextLine() 
公告:addLabel({text="版本:"..data.scriptver,size=30,align="Left",w=100,h=10})	
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

return 主UI:show(0)






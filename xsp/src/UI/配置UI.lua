require("UI.Z_ui")
local DevScreen={
	Width=1920,
	Height=1080,
}
local 配置名称=File:new("init.txt")
配置名称:check({"配置1","配置2","配置3","配置4","配置5"})
local str=配置名称:ReadByJsontoStr()	
local data=_K:getSystemData("fgo")
local 主UI=UI:new(DevScreen,{align="left",w=90,h=90,size=20,cancelname="取消",okname="OK",countdown=0,config="",xpos=2})
local 主配置=Page:new(主UI,{text="主功能选择",size=20})
主配置:addLabel({text="安卓用户可以进群下载2.0引擎版本小精灵,速度会比现在的快哟",size=50,align="Left",w=90,color="255,0,0"})
主配置:nextLine() 
主配置:addLabel({text="选择配置文件:",size=30,align="Left",w=90,color="0,0,0"})
主配置:nextLine() 
主配置:addRadioGroup({id="配置选择",list=str,select=0,size=25,w=100,h=10,color="0,0,255"})
主配置:nextLine() 
主配置:addCheckBoxGroup({id="更改配置名称",list="更改配置名称",select="1",size=25,w=20,h=10,color="0,0,255"})
主配置:addEdit({id="更改名称",prompt="这里输入需要改的名称",kbtype="default",select="1",size=25,w=40,h=10,color="0,0,0",ypos=-2})
主配置:nextLine(1.2) 
主配置:addCheckBoxGroup({id="是否增加配置",list="是否增加配置",select="1",size=25,w=20,h=10,color="0,0,255"})
主配置:addCheckBoxGroup({id="是否删除配置",list="是否删除配置",select="1",size=25,w=20,h=10,color="0,0,255"})
主配置:addLabel({text="--修改配置的更改会在下次运行生效",size=30,align="Left",w=50,color="0,0,0"})
主配置:nextLine(1.2) 
主配置:addCheckBoxGroup({id="刘海屏适配",list="刘海屏适配",select="1",size=25,w=20,h=10,color="0,0,255"})
主配置:addLabel({text="--部分情况需要开启,没有收集到的情况请私聊",size=30,align="Left",w=50,color="0,0,0"})
主配置:nextLine(1.2) 
主配置:addLabel({text="如有使用问题可以加群或者qq:",size=25})
主配置:addQQ({text="群号:695541474",size=25})
主配置:addQQ({text="qq:1534225986",size=25})
主配置:nextLine(1.2) 
主配置:addLabel({text="悬浮窗左上角设置选项里选择隐藏悬浮窗再运行脚本",size=30,color='255,0,0'})
主配置:nextLine(1.2) 

主配置:addImage({src="红包.png",w=26,h=75})
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






require("__UI.Z_ui")
local DevScreen={
	Width=1920,
	Height=1080,
}
local 主UI=ZUI:new(DevScreen,{align="left",w=80,h=80,size=90,cancelname="取消",okname="OK",countdown=0,config=UI配置文件.."刷图.dat",xpos=2})
local 按次数刷图=Page:new(主UI,{text="按次数刷图",size=20})
按次数刷图:addLabel({text="按次数刷图",size=60,align="center",w=100,color="255,0,0"})
按次数刷图:nextLine(1) 
按次数刷图:addLabel({text="请把需要刷的副本放在关卡列表第一位",size=60,align="center",w=100,color="255,0,0"})
按次数刷图:nextLine(2) 
按次数刷图:addEdit({id="手动刷图次数",prompt="这里输入需要刷的次数",text="30",kbtype="number",select="1",size=25,w=40,h=10,color="0,0,0"})
按次数刷图:nextLine(2)
按次数刷图:addRadioGroup({id="次数选择",list="执行框内次数,5,10,20,50,100,200,99999",select=0,size=25,w=80,h=30,color="0,0,255"})



return 主UI:show(1)

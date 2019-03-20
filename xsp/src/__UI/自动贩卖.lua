require("__UI.Z_ui")
local DevScreen={
	Width=1920,
	Height=1080,
}	
local 主UI=ZUI:new(DevScreen,{align="left",w=90,h=90,size=90,cancelname="取消",okname="OK",countdown=0,config=UI配置文件.."贩卖.dat",xpos=2})
local 自动贩卖=Page:new(主UI,{text="自动贩卖",size=20})
自动贩卖:addLabel({text="自动贩卖",size=60,align="center",w=100,color="255,0,0"})
自动贩卖:nextLine(1) 
自动贩卖:addLabel({text="--请先设置贩卖时为一排7个的最小状态,脚本目前不会自动调整",size=30,align="center",w=100,color="255,0,0"})
自动贩卖:nextLine(1) 
自动贩卖:addLabel({text="选择贩卖模式",size=30,align="center",color="0,0,0"})
自动贩卖:addRadioGroup({id="贩卖功能选择",list="从者,礼装",select=0,w=100,h=10,size=30})
自动贩卖:nextLine() 
自动贩卖:addLabel({text="从者贩卖设置:",size=30,align="center",color="0,0,0"})
自动贩卖:addCheckBoxGroup({id="从者贩卖设置",list="狗粮,芙芙,从者",select="0",size=30,w=30,h=10,color="0,0,0"})
自动贩卖:addLabel({text="从者贩卖星级设置:",size=30,align="center",color="0,0,0"})
自动贩卖:addRadioGroup({id="从者贩卖星级设置",list="铜,铜+银",select="0",size=30,w=70,h=10,color="0,0,0"})
自动贩卖:nextLine() 
自动贩卖:addLabel({text="礼装贩卖设置:",size=30,align="center",color="0,0,0"})
自动贩卖:addCheckBoxGroup({id="礼装贩卖设置",list="一星,两星,三星",select="0",size=30,w=70,h=10,color="0,0,0"})


return 主UI:show(1)
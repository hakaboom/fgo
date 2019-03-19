require"Tool.All"
_scriptver="2019.3.19 21.32"
DevScreen={	--开发
	Top=0,Bottom=0,Left=0,Right=0,
	Width=1920,Height=1080,
}

_const={
	GetColorMode='getColorEX'
}

_K=System:new(DevScreen,getCur(1000/560,1280/720),1,"Height","Height")
if (_K.Cur.Height==1080 and _K.Cur.Width==1920) then _const.GetColorMode='getColor' end

init("0",getScreenDirection())
setUIOrientation(getScreenDirection())

require("Behavior.init") --return MainConfig和FunctionConfig

scene=require("Behavior.scene")
behavior=require("Behavior.Behavior")

_K:getSystemData("fgo")
_K:postToServer()

主流程:run()
---]]---
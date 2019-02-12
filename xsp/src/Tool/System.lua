System={ 
}
function System:new(DevScreen,CurScreen,initfor,MainPointsScaleMode,AppurtenantScaleMode,GameAspect)
	local o={
		Dev=TableCopy(DevScreen),
		Cur=TableCopy(CurScreen),
		Arry={
			Cur=TableCopy(CurScreen),
			Dev=TableCopy(DevScreen),
			MainPointsScaleMode=MainPointsScaleMode or false,
			AppurtenantScaleMode=AppurtenantScaleMode or false,
		},
	}
	-----------------------------------------------------------------
	if initfor==1 then	--screen.LANDSCAPE_RIGHT
		local DevX=o.Dev.Width-o.Dev.Left-o.Dev.Right		--开发机X减去黑边
		local DevY=o.Dev.Height-o.Dev.Top-o.Dev.Bottom		--开发机Y减去黑边
		local CurX=o.Cur.Width-o.Cur.Left-o.Cur.Right		--当前机器X减去黑边
		local CurY=o.Cur.Height-o.Cur.Top-o.Cur.Bottom		--当前机器Y减去黑边
		o.Arry.Dev.x,o.Arry.Dev.y,o.Arry.Cur.x,o.Arry.Cur.y=DevX,DevY,CurX,CurY
		o.Arry.x=CurX/DevX		--x的缩放比例
		o.Arry.y=CurY/DevY		--Y的缩放比例
		o.Arry.Dev.scale,o.Arry.Cur.scale=DevX/DevY,CurX/CurY--宽高比
	elseif initfor==0 then --screen.PORTRAIT
		local DevX=o.Dev.Height-o.Dev.Top-o.Dev.Bottom
		local DevY=o.Dev.Width-o.Dev.Left-o.Dev.Right
		local CurX=o.Cur.Height-o.Cur.Top-o.Cur.Bottom
		local CurY=o.Cur.Width-o.Cur.Left-o.Cur.Right
		o.Arry.Dev.x,o.Arry.Dev.y,o.Arry.Cur.x,o.Arry.Cur.y=DevX,DevY,CurX,CurY
		o.Arry.x=CurX/DevX
		o.Arry.y=CurY/DevY
	end
	--------------------------------------------------------------------------
	if MainPointsScaleMode=="Height" then		--锚点的相对坐标缩放
		o.Arry.MainPointsScaleMode=o.Arry.Cur.y/o.Arry.Dev.y
	elseif MainPointsScaleMode=="Width" then	
		o.Arry.MainPointsScaleMode=o.Arry.Cur.x/o.Arry.Dev.x
	elseif MainPointsScaleMode=="unequal" then ---全屏游戏用
		if o.Arry.Cur.scale>GameAspect then
			o.Arry.MainPointsScaleMode=o.Arry.Cur.y/o.Arry.Dev.y
		else
			o.Arry.MainPointsScaleMode=(o.Arry.Cur.y/o.Arry.Dev.y)*(1/GameAspect)
		end
	else
		print("没有设置锚点缩放模式")
		lua_exit()
	end	
	
	if AppurtenantScaleMode=="Height" then		--多点从属点的相对坐标缩放
		o.Arry.AppurtenantScaleMode=o.Arry.Cur.y/o.Arry.Dev.y
	elseif AppurtenantScaleMode=="Width" then
		o.Arry.AppurtenantScaleMode=o.Arry.Cur.x/o.Arry.Dev.x
	elseif AppurtenantScaleMode=="unequal" then	--全屏游戏用
		if o.Arry.Cur.scale>GameAspect then
			o.Arry.AppurtenantScaleMode=o.Arry.Cur.y/o.Arry.Dev.y
		else
			o.Arry.AppurtenantScaleMode=(o.Arry.Cur.y/o.Arry.Dev.y)*(1/GameAspect)
		end
	else
		print("没有设置多点从属点")
		lua_exit()
	end
	
	setmetatable(o,{__index=self} )
	return o
end

function System:keepScreen(boole,T)
	if boole then if self.KeepScreen then return end end
	keepScreen(boole)
	slp(T or 0)
	self.KeepScreen=boole
end

function System:SwitchScreen()
	self:keepScreen(false)
	self:keepScreen(true)
end

function System:printSelf()--打印自身
	Print(self)
end

function System:getArry()--获取Arry缩放参数
	return self.Arry
end

function System:getSystemData(game)
MainConfig=MainConfig or {}
local data={
		ver=getOSType(),
		uid=string.sub(getUserID(),1,8),
		screen=self.Cur.Width.."*"..self.Cur.Height,
		NowTime=os.date("%Y-%m-%d %H:%M:%S");
		gamename="fatego",
		dpi=getScreenDPI(),
		game=game or "fgo",
		["function"]=MainConfig.功能选择,
		stateTime=os.time(),
		scriptver=_scriptver,
		val=getSystemProperty('ro.build.product'),
	}
	if data.uid=="null" then data.uid="屌丝" end
	if data.ver=="android" then
		if isPrivateMode()==0 then data.code="免ROOT" else data.code="root" end
	else 
		if isPrivateMode()==0 then data.code="ipa精灵" else data.code="越狱" end
	end
self.SystemData=data
return data
end

function System:getCurScreen()
	return self.Cur
end

function System:postToServer()
local json=require("JSON")
local data=json:encode(self.SystemData)
local url=urlencode("http://47.107.224.60:8282/index.php/home/api/getinfo/info/"..data)
	if asyncExec~=nil then 
		asyncExec({
			type = "httppost",                       
			immediate = false,
			headers = "User-Agent:Test-Agent#Accept-Language:zh-CN",
			url = url, 
			callback = function (result)
					assert(type(result) == "table")
					sysLog("服务器返回数据: 代码 = " .. result.code .. " 数据 = " .. result.data)
				end
			})
	end
end

function System:postgamedataToServer(tbl)
local json=require("JSON")
if self.SystemData.stateTime+15>os.time() then return end
self.SystemData.stateTime=os.time()
tbl.uid,tbl.game=self.SystemData.uid,self.SystemData.game
local data=json:encode(tbl)
local url=urlencode("http://47.107.224.60:8282/index.php/home/api/getstate/info/"..data)
	if asyncExec~=nil then 
		asyncExec({
			type = "httppost",                       
			immediate = false,
			headers = "User-Agent:Test-Agent#Accept-Language:zh-CN",
			url = url, 
			callback = function (result)
				--	assert(type(result) == "table")
					sysLog("服务器返回数据: 代码 = " .. result.code .. " 数据 = " .. result.data)
					if result.code==-2 then
						function self:postgamedataToServer()
							
						end
					end
				end
			})
	end
end






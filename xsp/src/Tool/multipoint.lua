local function getScaleMainPoint(MainPoint,mode,Arry)	--缩放锚点
	local MainPoint=TableCopy(MainPoint)
	MainPoint.x=MainPoint.x-Arry.Dev.Left
	MainPoint.y=MainPoint.y-Arry.Dev.Top
	local x,y
	local switch={
		["Middle"]=function()
			x=(Arry.Cur.x+Arry.Cur.Left+Arry.Cur.Right)/2-((Arry.Dev.x/2-MainPoint.x)*Arry.MainPointsScaleMode)
			y=(Arry.Cur.y+Arry.Cur.Top+Arry.Cur.Bottom)/2-((Arry.Dev.y/2-MainPoint.y)*Arry.MainPointsScaleMode)
		end,
		["Left"]=function ()--左中
			x=MainPoint.x*Arry.MainPointsScaleMode+Arry.Cur.Left
			y=MainPoint.y*Arry.MainPointsScaleMode+Arry.Cur.Top
		end,
		["Right"]=function ()--右中
			x=Arry.Cur.x-((Arry.Dev.x-MainPoint.x)*Arry.MainPointsScaleMode)+Arry.Cur.Left
			y=MainPoint.y*Arry.MainPointsScaleMode+Arry.Cur.Top
		end,
		["Top"]=function ()--上中 
			x=MainPoint.x*Arry.MainPointsScaleMode+Arry.Cur.Left
			y=MainPoint.y*Arry.MainPointsScaleMode+Arry.Cur.Top
		end,
		["Bottom"]=function ()--下中
			x=o.MainPoint.x*Arry.MainPointsScaleMode+Arry.Cur.Top
			y=Arry.Cur.y-((Arry.Dev.y-MainPoint.y)*Arry.MainPointsScaleMode)+Arry.Cur.Top
		end,
		["LeftTop"]=function ()--左上
			x=MainPoint.x*Arry.MainPointsScaleMode+Arry.Cur.Left
			y=MainPoint.y*Arry.MainPointsScaleMode+Arry.Cur.Top
		end,
		["LeftBottom"]=function ()--左下
			x=MainPoint.x*Arry.MainPointsScaleMode+Arry.Cur.Left
			y=Arry.Cur.y-((Arry.Dev.y-MainPoint.y)*Arry.MainPointsScaleMode)+Arry.Cur.Top
		end,
		["RightTop"]=function () --右上角
			x=Arry.Cur.x-((Arry.Dev.x-MainPoint.x)*Arry.MainPointsScaleMode)+Arry.Cur.Left
			x=MainPoint.y*Arry.MainPointsScaleMode+Arry.Cur.Top
		end,
		["RightBottom"]=function () --右下角
			x=Arry.Cur.x-((Arry.Dev.x-MainPoint.x)*Arry.MainPointsScaleMode)+Arry.Cur.Left
			y=Arry.Cur.y-((Arry.Dev.y-MainPoint.y)*Arry.MainPointsScaleMode)+Arry.Cur.Top
		end,
	}
	switch[mode]()
	return {x=x,y=y}
end
local function getScaleXY(v,MainPoint,DstMainPoint,Arry)	--缩放XY
	v.x=DstMainPoint.x+(v.x-MainPoint.x)*Arry.AppurtenantScaleMode
	v.y=DstMainPoint.y+(v.y-MainPoint.y)*Arry.AppurtenantScaleMode
	return v.x,v.y
	
end

point={
}

function point:new(Baseinfo)
	local Arry=Baseinfo.Arry or _Arry
	Baseinfo.Degree=Baseinfo.Degree or 95
	Baseinfo.index=Baseinfo.index or 1
	local o=Baseinfo
	--table.foreach(Baseinfo,function (k,v) o[k]=v end)
	if o.mode then	--如果从多点对象中创建过了则会直接返回
		setmetatable(o,{__index = self} )	
		return o
	end
	---------------------------------------------------
	if not o.Anchor then --如果没有设置锚点
		o.x=(o.x-Arry.Dev.Left)*Arry.AppurtenantScaleMode+Arry.Cur.Left	--分别计算出缩放后的X,Y
		o.y=(o.y-Arry.Dev.Top)*Arry.AppurtenantScaleMode+Arry.Cur.Top
	elseif Baseinfo.DstMainPoint then							--预先设置锚点
		o.x,o.y=getScaleXY({x=o.x,y=o.y},o.MainPoint,Baseinfo.DstMainPoint,Arry)	--缩放
	else	
		o.DstMainPoint=getScaleMainPoint(o.MainPoint,o.Anchor,Arry)	--计算锚点
		o.x,o.y=getScaleXY({x=o.x,y=o.y},o.MainPoint,o.DstMainPoint,Arry)	--缩放
	end
	
	setmetatable(o,{__index = self} )	
	return o
end

function point:touchHold(T)--按住屏幕,单位/秒
	touchDown(self.index,self.x,self.y)
	slp(T)
	touchUp(self.index,self.x,self.y)
	slp()
end

function point:Click(T)	--单点屏幕
	touchDown(1,self.x,self.y)
	slp()
	touchUp(1,self.x,self.y)
	slp(T)
end

function point:getColor()--获取点的颜色R,G,B
	local r,g,b=getColorRGB(self.x,self.y) --screen.getRGB(point)
	self.DstColor={
			r=r,
			g=g,
			b=b,
		}
end

function point:getColorEX()--二次插值取点
	_K:keepScreen(true)
	local point={x=self.x,y=self.y}
	local ZoomX,ZoomY=math.floor(point.x),math.floor(point.y)	--缩放后的临近点
	local u,v=(point.x-ZoomX),(point.y-ZoomY)
		local r0,g0,b0=getColorRGB(ZoomX,ZoomY)
		local r1,g1,b1=getColorRGB(ZoomX+1,ZoomY)
		local r2,g2,b2=getColorRGB(ZoomX,ZoomY+1)
		local r3,g3,b3=getColorRGB(ZoomX+1,ZoomY+1)
		local	tmpColor0={
					r=(r0*(1-u)+r1*u),
					g=(g0*(1-u)+g1*u),
					b=(b0*(1-u)+b1*u),
					}
		local	tmpColor1={
					r=(r2*(1-u)+r3*u),
					g=(g2*(1-u)+g3*u),
					b=(b2*(1-u)+b3*u),
					}
		local	DstColor={
					r=tmpColor0.r*(1-v)+tmpColor1.r*v,
					g=tmpColor0.g*(1-v)+tmpColor1.g*v,
					b=tmpColor0.b*(1-v)+tmpColor1.b*v,
				}
		self.DstColor=DstColor
end

function point:getDiff()
	local floor=math.floor
	if not self.DstColor then self:getColor() end
	local lr,lg,lb=self.DstColor.r,self.DstColor.g,self.DstColor.b
	local r,g,b=floor(self.color/0x10000),floor(self.color%0x10000/0x100),floor(self.color%0x100)
	local diff={
		r=math.abs(r-lr),
		g=math.abs(g-lg),
		b=math.abs(b-lb),
	}
	return diff
end

function point:cmpColor()--比色
	local floor = math.floor
	local r ,g ,b =floor(self.color/0x10000),floor(self.color%0x10000/0x100),floor(self.color%0x100)	
	local lr,lg,lb=self.DstColor.r,self.DstColor.g,self.DstColor.b
	if self.DiffColor then
		local offColor=self.DiffColor
		local ofr,ofg,ofb=floor(offColor/0x10000),floor(offColor%0x10000/0x100),floor(offColor%0x100)
		local ar,ag,ab=r-ofr,g-ofg,b-ofb	--max
		local ir,ig,ib=r+ofr,g+ofg,b+ofb	--min
		-- print(string.format('max=(%0.2f:%0.2f,%0.2f:%0.2f,%0.2f:%0.2f)',ar,lr,ag,lg,ab,lb))
		-- print(string.format('min=(%0.2f:%0.2f,%0.2f:%0.2f,%0.2f:%0.2f)',ir,lr,ig,lg,ib,lb))
		if ((ar<lr)and(ag<lg)and(ab<lb)) and  --max< color <min
			((lr<ir)and(lg<ig)and(lb<ib)) then
			return true
		end
		return false
	else
		local fuzz =math.floor(0xff * (100 - self.Degree) * 0.01)
		local r3,g3,b3=(lr-r),(lg-g),(lb-b)
		local diff=math.sqrt(r3^2+g3^2+b3^2)
			if diff>fuzz then
				return false
			end
		return true
	end
end

function point:getandCmpColor(touchmode,T)
	self:getColorEX()
	local bool=self:cmpColor()
	if touchmode==true then
		if bool then self:Click(T) end
	elseif touchmode==false then
		if not bool then self:Click(T) end
	end
	return bool
end

function point:getXY()--获取XY坐标
	return {x=self.x,y=self.y}
end

function point:printXY()--打印坐标
	print(string.format("{x=%s,y=%s}",self.x,self.y))
end

function point:printSelf()--打印自身
	Print(self)
end

multiPoint={
}

function multiPoint:new(Baseinfo)
	local Arry=Baseinfo.Arry or _Arry
	local Anchor=Baseinfo.Anchor
	Baseinfo.Degree=Baseinfo.Degree or 95--全局模糊度
	Baseinfo.Area=Baseinfo.Area or nil--设置范围(findColor和OCR必须要传入Area)
	Baseinfo.hdir=Baseinfo.hdir or 0
	Baseinfo.vdir=Baseinfo.vdir or 0
	Baseinfo.priority=Baseinfo.priority or 0
	local o=Baseinfo
	--table.foreach(Baseinfo,function(k,v) o[k]=v end)	--把Baseinfo写入o
	------------------------------------------------------------------------------
	local function getScaleArea(Area,DstMainPoint)	--缩放Area
		if DstMainPoint then
			Area[1],Area[2]=getScaleXY({x=Area[1],y=Area[2]},MainPoint,DstMainPoint,Arry)
			Area[3],Area[4]=getScaleXY({x=Area[3],y=Area[4]},MainPoint,DstMainPoint,Arry)
		else
			Area[1]=(Area[1]-Arry.Dev.Left)*Arry.AppurtenantScaleMode+Arry.Cur.Left
			Area[3]=(Area[3]-Arry.Dev.Left)*Arry.AppurtenantScaleMode+Arry.Cur.Left
			Area[2]=(Area[2]-Arry.Dev.Top)*Arry.AppurtenantScaleMode+Arry.Cur.Top
			Area[4]=(Area[4]-Arry.Dev.Top)*Arry.AppurtenantScaleMode+Arry.Cur.Top
		end
		return Area
	end
	------------------------------------------------------------------------------
	if Baseinfo.DstMainPoint then	
		table.foreachi(o,function(k,v) 
			v.x,v.y=getScaleXY(v,o.MainPoint,Baseinfo.DstMainPoint,Arry);v.mode=true;
			v.Degree=Baseinfo.Degree;
			o[k]=point:new(v)	--缩放
		end)
	elseif not Anchor then --如果没有设置锚点
		table.foreachi(o,function(k,v) 
			v.x=(v.x-Arry.Dev.Left)*Arry.AppurtenantScaleMode+Arry.Cur.Left	--分别计算出缩放后的X,Y
			v.y=(v.y-Arry.Dev.Top)*Arry.AppurtenantScaleMode+Arry.Cur.Top
			v.mode=true;v.Degree=Baseinfo.Degree;
			o[k]=point:new(v)
		end)
	else	
		o.DstMainPoint=getScaleMainPoint(o.MainPoint,Anchor,Arry)	--计算锚点
		table.foreachi(o,function(k,v) 
			v.x,v.y=getScaleXY(v,o.MainPoint,o.DstMainPoint,Arry);v.mode=true;
			v.Degree=Baseinfo.Degree;
			o[k]=point:new(v)--缩放
		end)
	end
	
	if o.index then o.index=getScaleArea(o.index,o.DstMainPoint,Arry) end--如果有设置点击点
	
	if o.Area then o.Area=getScaleArea(o.Area,o.DstMainPoint,o.MainPoint,Arry) end	--缩放范围
	
	setmetatable(o,{__index = self} )
	return o
end

function multiPoint:Click(T)
	math.randomseed(tonumber(string.reverse(tostring(mTime())):sub(1,6)))
	local p=self.index
	local point={math.random(p[1],p[3]),math.random(p[2],p[4])}
	touchDown(1,point[1],point[2])
	slp()
	touchUp(1,point[1],point[2])
	slp(T)
end

function multiPoint:AllClick(T)
	for k,v in ipairs(self) do
		self[k]:Click(T)
	end
end

function multiPoint:getColor()--获取当前所有坐标的R,G,B值并且存放在self.color里
	_K:keepScreen(true)
	for k,v in ipairs(self) do
		self[k]:getColor()
		self[k].DstColor=self[k].DstColor		--screen.getColor(data.x,data.y)
	end
end

function multiPoint:getColorEX()--获取当前所有坐标的R,G,B值并且存放在self.color里
	_K:keepScreen(true)
	for k,v in ipairs(self) do
		self[k]:getColorEX()
		self[k].DstColor=self[k].DstColor
	end
end

function multiPoint:cmpColor()--比色
	for k,v in ipairs(self) do
		local  res=v:cmpColor()
			if not res then
			--	print(string.format(">>>>>>>>>>>>>>>>%s:false",(self._tag or "")))
			return false,err
		end
  	end
		print(string.format(">>>>>>>>>>>>>>>>%s:true",(self._tag or "")))
  	return true
end

function multiPoint:getandCmpColor(touchmode,T)
	self[_const.GetColorMode](self)
	local bool=self:cmpColor()
	if touchmode==true then
		if bool then self:Click(T) end
	elseif touchmode==false then
		if not bool then self:Click(T) end
	end
	return bool
end
	
function multiPoint:findColor()--区域找色
	local color={}
	local floor=math.floor
	table.foreachi(self,function (k,v) 
		color[k]={x=floor(v.x+0.5),y=floor(v.y+0.5),
		color=v.color,degree=self.Degree,
		offset=v.DiffColor or nil} 
	end)
	local x, y = findColor(self.Area,color,self.Degree,self.hdir,self.vdir,self.priority)
		if x~=-1 then
			return {x=x,y=y}
		end
	return false
end

function multiPoint:binarizeImage()--二值化图片
	local Data=binarizeImage({
		rect=self.Area,
		diff={self.DiffColor},
		})
	self.binarize=Data
end

function multiPoint:getText(data)
	if not self.binarize then self:binarizeImage() end
	local Ocr=OCR:new({lang="eng"})
	data.binarize=self.binarize
	data.white=data.white
	return Ocr:getText(data)
end

function multiPoint:WaitScreen(name)	--等待页面出现
	while not self:getandCmpColor(name) do _K:keepScreen(false,0.5) end
end

function multiPoint:printbinarize()--打印二值化data
local data=self.binarize
	for _,v in pairs(data) do
		print(table.concat(v, ''))
	end
end

function multiPoint:printXY()--打印所有的点参数
print(string.format(">>>>>>>>>>>>>>>>%s",(self._tag or "")))
	table.foreachi(self, function(k,v) 
		self[k]:printXY()
	end)
print(">>>>>>>>>>>>>>>>")
end

function multiPoint:getPoints()--获取参数点
	local tbl={}
	table.foreachi(self,function (k,v) tbl[k]=v end)
	return tbl
end

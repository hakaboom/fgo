HUD={
}

function HUD:new(Baseinfo)	--Baseinfo={multipoint,color,text,bg,size}
	local o={
		coordinate=Baseinfo.point[1],
		Area=Baseinfo.point[2],
		color=Baseinfo.color,
		bg=Baseinfo.bg or nil,
		size=Baseinfo.size*_Arry.AppurtenantScaleMode or 20,
		id=createHUD(),
		pos=self.pos or 0 ,

	}
	o.x,o.y=o.coordinate.x,o.coordinate.y
	o.width,o.height=o.Area.x-o.x,o.Area.y-o.y
	setmetatable(o,{__index = self} )	
	return o
end

function HUD:show(text)
	showHUD(self.id,text,self.size,self.color,self.bg,self.pos,self.x,self.y,self.width,self.height)
end

function HUD:hide()
	showHUD(self.id,"",self.size,"0x00000000","0x00000000",self.pos,self.x,self.y,self.width,self.height)
end
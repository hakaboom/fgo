runTime={
}

function runTime:new(name)	--毫秒
	local o={
		Time=mTime(), --os.milliTime(),
		name=name or "",
	}
	
	setmetatable(o,{__index = self})
	
	return o
end

function runTime:CmpTime()
local cmptime=(mTime()-self.Time)
	  print(self.name..":运行时间="..cmptime.."毫秒")
end

function runTime:checkTime(Time,isReset)--传入秒
local Time=Time*1000	--转换成毫秒
local nowTime=cmpTime()--os.milliTime()
	if (self.Time+Time)<nowTime then
		if isReset then
			self.Time=os.milliTime()
		end
	end
end

function runTime:reset()
	self.Time=os.milliTime()
end


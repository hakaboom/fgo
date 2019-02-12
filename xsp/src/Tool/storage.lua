--文件对象
File={
}

function File:new(filename,Path)	--File:new("userconfig","自定义路径")
	local o={
		PublicPath=nil,	--引擎公共文件夹目录路径
		PrivatePath=nil,	--脚本私有文件夹目录路径
		Filename=filename,					--文件名
	}
	o.Path=o.Filename
	setmetatable(o,{ __index = self})
	return o
end

function File:WriteNewByJson(tbl)			--以Json格式写入文件{["xxxxx"]="123",["aaaaaa"]=true}
	local json=require("JSON")
	local file=io.open(self.Path,"w+")
	assert(file,"path of the file don't exist or can't open")
	local mstr=json:encode(tbl)	--table转为json格式
	file:write(mstr)
	file:flush()
	file:close()
end

function File:ReadByJsontoStr()				--读取Json格式的文件
	local json=require("JSON")
	local file=io.open(self.Path,"r")
	assert(file,"path of the file don't exist or can't open")
	local tbl=json:decode(file:read("*a"))
	local str=table.concat(tbl,",")
	file:close()
	return str
end

function File:ReadByJson()					--读取Json格式的文件
	local json=require("JSON")
	local file=io.open(self.Path,"r")
	assert(file,"path of the file don't exist or can't open")
	local tbl=json:decode(file:read("*a"))
	file:close()
	return tbl
end

function File:ChangeFileName(filename)		--重设文件名
	self.Filename=filename
end

function File:ClearFile()					--清除当前文件内容
	local file=io.open(self.Path,"w")
	file:flush()
	file:close()
end

function File:check(data)
	if io.open(self.Path,"r")==nil then
		print("没有"..self.Path.."这个文件")
		io.open(self.Path,"w"):close()
		self:WriteNewByJson(data)
	else
		local file=io.open(self.Path,"r") 
		if file:seek("end")==0 then
			self:WriteNewByJson(data)
		end
	end
end

function File:printpath()					--打印当前文件路径
	printf("路径为 : %s",xmod.resolvePath(self.Path))
end
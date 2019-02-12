--Print 格式化打印
function Print(...)
local Print_Empty_String="empty_s"
local Print_Empty_Table="empty_t"
local Print_Space_str="  "
	function printTable(t,SpaceNum)
		SpaceNum=SpaceNum and SpaceNum+1
		SpaceNum=SpaceNum or 0
		local str=""
		for i=1,SpaceNum,2 do
			str=str..Print_Space_str
		end
		for k,v in pairs(t) do
			local type_t=type(v)
			if type_t=="table" then
				print(string.format("%s[%s]={",string.rep("\t",SpaceNum),tostring(k)))
				printTable(v,SpaceNum+1)
				print(string.format("%s}",string.rep("\t",SpaceNum)))
			elseif type_t=="number" then
				print(string.format("%s[%s] = %s",string.rep("\t",SpaceNum),tostring(k),tonumber(v)))
			elseif type_t=="string" then
				print(string.format("%s[%s] = %s",string.rep("\t",SpaceNum),tostring(k),(v=="" and Print_Empty_String or v)))
			elseif type_t=="boolean" then
				print(string.format("%s[%s] = %s",string.rep("\t",SpaceNum),tostring(k),(v and "true" or "false")))
			elseif type_t=="userdata" then
				printf("%s%s",string.rep("\t",SpaceNum),v)
			else
				print(str..k..':'..type_t)
			end
		end
	end
	arg = { ... }
	for i=1,#arg do
		local t=arg[i]
		local type_t=type(t)
		if type_t=="table" then
			print("Print Table={")
			printTable(t)
			print("}")
		elseif type_t=="string" then
			print(t=="" and Print_Empty_String or t)
		elseif type_t=="boolean" then
			print(string.format("%s%s","Print boolean = ",(t and "true" or "false")))
		elseif type_t=="userdata" then
			printf("%s",t)
		else
			print(t)
		end
	end
end
return Print;
local base="Tool."
require(base.."System")
require(base.."runTime")
require(base.."multipoint")
require(base.."Print")
require(base.."storage")
require(base.."OCR")
require(base.."HUD")
require	"Task"--任务模块

function TableCopy(Tbl)						--表复制
	local t={}
	for k,v in pairs(Tbl) do
		if type(v)=="table" then
			t[k]=TableCopy(v)
		else
			t[k]=v
		end
	end
	return t
end

function slp(T,mode)	--传入秒
T=T or 0.05
T=T*1000
mode=mode or "无"
local switch={
	["极快"]=0.6,
	["快"]=0.75,
	["正常"]=1,
	["一般"]=1.5,
	["慢"]=2.2,
	["无"]=1,
}
	mSleep(T*switch[mode])
end

function belongvalue(aimTable,aim)					--判断目标变量在表中是否存在
	for _,v in pairs(aimTable) do
		if aim==v then
			return true
		end
	end
	return false
end

function belongindex(aimTable,aim)					--判断目标变量在表中是否存在
	for k,_ in pairs(aimTable) do
		if aim==k then
			return true
		end
	end
	return false
end

function show_UI(ui)
local 脚本设置=require(ui)
	if 脚本设置._cancel then
		lua_exit()
		return false
	else
		return 脚本设置
	end
end

function cloudContent(key)	--获取云公告
	local content, err = getCloudContent(key, "A3354C1468E64ED1", "")
	if err == 0 then
	 return content
	elseif err == 1 then
	  dialog("网络错误")
	elseif err == 999 then
	  dialog("未知错误")
	end
end

function getCur(minwh,maxwh)	--获取用户机器分辨率参数
	local Top,Bottom,Left,Right
	local ceil=math.ceil
	local _width,_height =getScreenSize() 
	local DevX,DevY=1920,1080
	if _width<_height then _width,_height=_height,_width end
	if _width/_height<minwh then--上下有黑边
		local diff=(_height-_width/minwh)/2
		if diff<5 then diff=0 end
		Top,Bottom,Left,Right=diff,diff,0,0
	elseif _width/_height>maxwh then--左右有黑边
		local diff=(_width-_height*maxwh)/2
		if diff<5 then diff=0 end
		Left,Right,Top,Bottom=diff,diff,0,0
	end
	Screen={Top=Top,Bottom=Bottom,Left=Left,Right=Right,Width=_width,Height=_height}
	Print(Screen)
	return Screen
end

function delay(Second)
	slp(Second)
	_addToDelay_()--前后无所谓
end

function Move(Movestart,Moveend,t)
t=t or 2
local ceil=math.ceil
local x1,y1=Movestart[1],Movestart[2]
local x2,y2=Moveend[1],Moveend[2]
	touchDown(2,x1,y1)
	for i=0,100,t do
		local x=x1+(x2-x1)*(i/100)
		local y=y1+(y2-y1)*(i/100)
	touchMove(2,ceil(x),ceil(y))
	mSleep(20)
	end
	slp(0.5)
	touchUp(2,x2,y2)
	slp(0.5)
end

function getKeysSortedByValue(tbl, sortFunction)	--表按照value排序
  local keys = {}
  for key in pairs(tbl) do
    table.insert(keys, key)
  end

  table.sort(keys, function(a, b)
    return sortFunction(tbl[a], tbl[b])
  end)

  return keys
end

function getSkillChoice(skillChoice,order)
	local t=skillChoice 
	local mt={}
	for _,v in pairs(order) do
		if belongindex(t,v) then
			table.insert(mt,v)
		end
	end
	return mt 
end

function getTableFromString(str,aim)            --从表中查找符合aim的条件,以表返回
	local insert=table.insert
	local aimTable={}
	for v in string.gmatch(str,aim) do
		insert(aimTable,v)
	end
	return aimTable
end

function getTableRepeat(tbl)	--获取表中重复的数字
local t={}
	for k,v in pairs(tbl) do
		if t[v] then
			t[v]=t[v]+1
		else
			t[v]=1
		end
	end
	return t
end

function urlencode(w)
local pattern = "[^%w%d%?=&:/._%-%* ]"
    s = string.gsub(w, pattern, function(c)
        local c = string.format("%%%02X", string.byte(c))
        return c
    end)
    s = string.gsub(s, " ", "+")
    return s
end

local Scene={
}
local tbl=require("Behavior.Data")

function Scene.进入关卡()
	if tbl.主页面:getandCmpColor() then
		return true
	end
	if tbl.助战选择页面:getandCmpColor() then
		return "选择助战"
	end
	if tbl.战斗主页:getandCmpColor() then
		return "已进入战斗"
	end
	if tbl.AP回复:getandCmpColor() then
		return "AP不足"
	end
	if tbl.仓库到上限:getandCmpColor() then
		return "仓库爆仓"
	end
end

function Scene.检查进入关卡()
	if tbl.助战选择页面:getandCmpColor() then
		return true
	end
	if tbl.AP回复:getandCmpColor() then
		return "AP不足"
	end
	if tbl.仓库到上限:getandCmpColor() then
		return "仓库爆仓"
	end
end

function Scene.重回主页()
	if tbl.主页面:getandCmpColor() then
		return "主页面"
	end
end

function Scene.开始任务()
	if tbl.队伍确认:getandCmpColor() then
		return true
	end
	if tbl.助战选择页面:getandCmpColor() then
		return "选择助战"
	end
end

function Scene.等待战斗开始()
	if tbl.战斗主页:getandCmpColor() then
		return true
	end
	if tbl.队伍确认:getandCmpColor() then
		return "队伍确认"
	end
	if tbl.道具使用:getandCmpColor() then
		return "道具使用"
	end
end

function Scene.识别当前关卡()
	local text=multiPoint:new({Area={1295,18,1380,58},DiffColor="0xC4C4C4-0x3B3B3B"}):getText({white="123456789/"})
	if text==false or text==nil then text="1/3" end
	local now,max=string.match(text,"(%d+)/(%d+)")
		local type_now=type(tonumber(now))
		if type_new~="number" then
	
		end
	return tonumber(now)
end 

function Scene.等待回合结束()
	if tbl.战斗主页:getandCmpColor() then
		return "继续战斗"
	end
	if tbl.羁绊结算:getandCmpColor() then
		return "结算"
	end
	if tbl.获得战利品:getandCmpColor() then
		return "获得战利品"
	end
	multiPoint:new({index={1190,74,1400,160}}):Click(0.5) 
end

local _获得战利品=multiPoint:new({index={3,175,53,272}})
function Scene.获得战利品()
	if tbl.获得战利品:getandCmpColor() then
		return "获得战利品"
	end
	if tbl.申请好友:getandCmpColor() then
		return "申请好友"
	end
	if tbl.获得新卡:getandCmpColor() then
		return "获得新卡"
	end
	if tbl.主页面:getandCmpColor() then
		slp(2)
		tbl.主页面:Click()
		return true
	end
	_获得战利品:Click(0.5) 
end

function Scene.等待友情池()
	if tbl.友情池:getandCmpColor("友情池") then
		return true
	end

end

function Scene.友情池抽卡检测()
	if tbl.友情池决定召唤:getandCmpColor() then
		return true
	end
	if tbl.仓库到上限:getandCmpColor() then
		return "仓库到上限"
	end

end

function Scene.等待抽卡结束()
	if tbl.友情池:getandCmpColor() then
		return "友情池"
	end
	if tbl.友情池_召唤结束:getandCmpColor() then
		return "召唤结束"
	end
	if tbl.友情池_结算下一步:getandCmpColor() then
		return "下一步"
	end
	if tbl.获得新卡:getandCmpColor() then
		return "获得新卡"
	end
end

return Scene


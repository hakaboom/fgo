
local 黑板=Blackboard:new()

黑板:setValueBatch({
	["启动时间"]=mTime(),
	["当前游戏场景"]="自动贩卖",
	["贩卖功能选择"]=FunctionConfig.贩卖功能选择,
	["从者贩卖设置"]=FunctionConfig.从者贩卖设置,
	["礼装贩卖设置"]=FunctionConfig.礼装贩卖设置,
	["从者贩卖星级设置"]=FunctionConfig.从者贩卖星级设置,
	})
主流程=Sequence:new()--新建主运行流程
local 自动贩卖从者=黑板:createScene()
local 自动贩卖礼装=黑板:createScene()
主流程:addScene(自动贩卖从者)
主流程:addScene(自动贩卖礼装)
-------------------------------------------------------------------

自动贩卖从者:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("贩卖功能选择")=="从者"
	end
	)
自动贩卖礼装:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("贩卖功能选择")=="礼装"
	end
	)
-------------------------------------------------------------------
自动贩卖从者:getDoingBehavior():setServer(
	function(Blackboard)
		if not behavior.贩卖({功能="从者",筛选=Blackboard:getValue("从者贩卖设置"),星级=Blackboard:getValue("从者贩卖星级设置")},Blackboard:getValue("当前游戏场景")) then lua_exit() end
	end
	)
自动贩卖礼装:getDoingBehavior():setServer(
	function(Blackboard)
		if not behavior.贩卖({功能="礼装",筛选=Blackboard:getValue("礼装贩卖设置")},Blackboard:getValue("当前游戏场景")) then lua_exit() end
	end
	)
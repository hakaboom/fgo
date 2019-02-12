local 黑板=Blackboard:new()

黑板:setValueBatch({
	["启动时间"]=mTime(),
	["当前游戏场景"]="自动抽无限池",
	})
主流程=Sequence:new()--新建主运行流程
local 点击无限池=黑板:createScene()
主流程:addScene(点击无限池)


点击无限池:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="自动抽无限池"
	end
	)

点击无限池:getDoingBehavior():setServer(
	function(Blackboard)	
		multiPoint:new({index={570,616,677,661}}):Click()
		_K:SwitchScreen()
		if point:new({x=1628,y=356,color=0x698ac3}):getandCmpColor() then --重置奖品
			point:new({x=1628,y=356,color=0x698ac3}):Click()
		end
		if point:new({x=1366,y=843,color=0xd5d5d6}):getandCmpColor() then--执行
			point:new({x=1366,y=843,color=0xd5d5d6}):Click()
		end
		if point:new({x=855,y=843,color=0xd6d6d6}):getandCmpColor() then--关闭
			point:new({x=855,y=843,color=0xd6d6d6}):Click()
		end
		slp(0.3)
		_K:keepScreen(false)
	end
	)

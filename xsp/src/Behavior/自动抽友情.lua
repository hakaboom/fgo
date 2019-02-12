
local 黑板=Blackboard:new()

黑板:setValueBatch({
	["启动时间"]=mTime(),
	["功能"]="自动抽友情",
	["当前游戏场景"]="等待进入友情池",
	["抽卡次数"]=FunctionConfig.抽卡次数,
	["抽卡模式"]=FunctionConfig.抽卡模式,
	["是否清理从者"]=FunctionConfig.清理从者开关,
	["是否清理礼装"]=FunctionConfig.清理礼装开关,
	["从者清理"]=FunctionConfig.从者清理,
	["礼装清理"]="铜+银",
	["已抽次数"]=0
	})
主流程=Sequence:new()--新建主运行流程
local 进入友情页面=黑板:createScene()
local 点击抽友情=黑板:createScene()
local 检测状态=黑板:createScene()
local 等待抽卡结束=黑板:createScene()
local 仓库到上限=黑板:createScene()
local 重回主页=黑板:createScene()
local 重回召唤=黑板:createScene()
主流程:addScene(进入友情页面)
主流程:addScene(点击抽友情)
主流程:addScene(检测状态)
主流程:addScene(等待抽卡结束)
主流程:addScene(仓库到上限)
主流程:addScene(重回主页)
主流程:addScene(重回召唤)
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
进入友情页面:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="等待进入友情池"
	end
	)
点击抽友情:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="已在友情池" and (blackboard:getValue("已抽次数")<blackboard:getValue("抽卡次数"))
	end
	)
检测状态:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="检测状态"
	end
	)
等待抽卡结束:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="等待抽卡结束"
	end
	)
仓库到上限:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="仓库到上限"
	end
	)
重回主页:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="重回主页"
	end
	)
重回召唤:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="重回召唤"
	end
	)
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
进入友情页面:getDoingBehavior():setServer(
	function(blackboard)
	delay(1)
	_K:SwitchScreen()
		if scene.等待友情池()==true then
			blackboard:setValue("当前游戏场景","已在友情池")
		else
			point:new({x=27,y=529}):Click()
		end
	end
	)
点击抽友情:getDoingBehavior():setServer(
	function(blackboard)
	delay(0.2)
	_K:SwitchScreen()
		local 抽卡模式=blackboard:getValue("抽卡模式")
		if 抽卡模式=="单抽" then
			point:new({x=681,y=828}):Click()
		elseif 抽卡模式=="十连" then
			point:new({x=1232,y=831}):Click()
		end
		blackboard:setValue("已抽次数",blackboard:getValue("已抽次数","已抽次数")+1)
		blackboard:setValue("当前游戏场景","检测状态")
		slp(0.5)
	end
	)
检测状态:getDoingBehavior():setServer(
	function(blackboard)
	delay(0.4)
	_K:SwitchScreen()
		local aim=scene.友情池抽卡检测()
		if aim==true then
			point:new({x=1258,y=840}):Click(1)
			blackboard:setValue("当前游戏场景","等待抽卡结束")
		elseif aim=="仓库到上限" then
			point:new({x=520,y=712}):Click(1)
			blackboard:setValue("当前游戏场景","仓库到上限")
		end
	end
	)
仓库到上限:getDoingBehavior():setServer(
	function(blackboard)
	local 策略={["礼装"]=false,["从者"]=false}
		if blackboard:getValue("是否清理礼装") then 策略["礼装"]=true 策略["礼装策略"]=blackboard:getValue("礼装清理") end
		if blackboard:getValue("是否清理从者") then 策略["从者"]=true 策略["从者策略"]=blackboard:getValue("从者清理") end
		behavior.贩卖(策略,blackboard:getValue("功能"))
		blackboard:setValue("当前游戏场景","重回主页")
	end
	)
重回主页:getDoingBehavior():setServer(
	function(blackboard)
	delay(2)
	_K:SwitchScreen()
		if scene.重回主页()=="主页面" then
			blackboard:setValue("当前游戏场景","重回召唤")
		else
			point:new({x=161,y=69}):Click(1)
		end	
	end
)
重回召唤:getDoingBehavior():setServer(
	function(blackboard)
		delay(1)
		point:new({x=1779,y=1028}):Click(1)
		point:new({x=807,y=965}):Click(1)
		blackboard:setValue("当前游戏场景","等待进入友情池" )
	end
)
等待抽卡结束:getDoingBehavior():setServer(
	function(blackboard)
	delay(0.5)
	_K:SwitchScreen()
		local aim=scene.等待抽卡结束()
		if aim=="友情池" then
			blackboard:setValue("当前游戏场景","已在友情池")
		elseif aim=="下一步" then
			point:new({x=1605,y=1006}):Click(1)	--点击下一步
		elseif aim=="召唤结束" then
			point:new({x=1142,y=1011}):Click(1) --在结算页面点召唤
		elseif aim=="获得新卡" then
			point:new({x=71,y=63}):Click()
		end
		multiPoint:new({index={1152,0,1498,83}}):Click() --随机点击
	end
	)
	
	
	
	
	

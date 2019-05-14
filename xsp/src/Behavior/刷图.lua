local tbl=require("Behavior.Data")
--[[            黑板创建                 ]]
local 黑板=Blackboard:new()
--[[            黑板变量初始化                 ]]

黑板:setValueBatch({ --在黑板上存一些变量
	["启动时间"]=mTime(),
	["当前时间"]=os.time(),
	["已刷次数"]=0,
	["当前游戏场景"]="初始化页面",
	["当前战斗流程"]="等待进入战斗",
	["功能"]=MainConfig.功能选择,
	["体力补充"]=MainConfig.体力补充,
	["刷图次数"]=tonumber(FunctionConfig.刷图次数),
	["刷qp数量"]=FunctionConfig.刷qp数量,
	["当前回合"]="不知道",
	["是否为新回合"]=false,
	["当前结算流程"]=" ",
	['体力补充记录器']=false,
})
--Print(黑板:getAllValue())
print(">>>>>>>>>>>>>>>>>>>黑板初始化完毕")

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--[[            场景和流程的创建和绑定                 ]]
主流程=Sequence:new()--新建主运行流程
local 初始化页面=黑板:createScene()
local 重回主页=黑板:createScene()
local 进入关卡=黑板:createScene()	--检测是否进入关卡的流程
主流程:addScene(初始化页面)
主流程:addScene(进入关卡)
主流程:addScene(重回主页)
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
local 检测进入流程=Sequence:new()--创建检测的运行流程
local AP不足=黑板:createScene()
local 仓库爆仓=黑板:createScene()
进入关卡:addSequence(检测进入流程)--在进入关卡流程中添加检测
检测进入流程:addScene(AP不足)
检测进入流程:addScene(仓库爆仓)
初始化页面:addSequence(检测进入流程)
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
local 选择助战=黑板:createScene()	--进入关卡后选择助战
local 队伍确认=黑板:createScene()	--队伍确认
local 等待战斗开始=黑板:createScene() --等待战斗开始
local 开始战斗=黑板:createScene()	--开始战斗
主流程:addScene(选择助战)
主流程:addScene(队伍确认)
主流程:addScene(等待战斗开始)
主流程:addScene(开始战斗)
local 战斗流程=Sequence:new()--创建战斗流程的运行流程
local 识别当前关卡=黑板:createScene()	--识别当前关卡
local 选择优先敌人=黑板:createScene()	--选择优先敌人
local 释放技能=黑板:createScene()	--释放从者技能
local 选卡=黑板:createScene()	--选卡
local 等待回合结束=黑板:createScene()--识别回合是否结束
local 继续战斗=黑板:createScene()
local 关卡结算=黑板:createScene()
开始战斗:addSequence(战斗流程)
战斗流程:addScene(识别当前关卡)
战斗流程:addScene(选择优先敌人)
战斗流程:addScene(释放技能)
战斗流程:addScene(选卡)
战斗流程:addScene(等待回合结束)
战斗流程:addScene(继续战斗)
主流程:addScene(关卡结算)
print("场景流程初始化完毕")


-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--[[             场景的触发器设定               ]]
初始化页面:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="初始化页面" and (blackboard:getValue("已刷次数")<blackboard:getValue("刷图次数"))
	end
	)
进入关卡:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="检测进入关卡"
	end
	)
重回主页:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="重回主页"
	end
	)
AP不足:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="AP不足"
	end
	)
仓库爆仓:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="仓库爆仓"
	end
	)
选择助战:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="选择助战"
	end
	)
队伍确认:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="队伍确认"
	end
	)
等待战斗开始:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="等待战斗开始"
	end
	)
开始战斗:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="已进入战斗" and blackboard:getValue("当前战斗流程")=="等待进入战斗"
	end
	)
识别当前关卡:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="已进入战斗" and blackboard:getValue("当前战斗流程")=="回合开始"
	end
	)
选择优先敌人:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="已进入战斗" and blackboard:getValue("当前战斗流程")=="识别关卡结束"
	end
	)
释放技能:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="已进入战斗" and blackboard:getValue("当前战斗流程")=="选择优先敌人结束"
	end
	)
选卡:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="已进入战斗" and blackboard:getValue("当前战斗流程")=="释放技能结束"
	end
	)
等待回合结束:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="已进入战斗" and blackboard:getValue("当前战斗流程")=="选卡结束"
	end
	)
继续战斗:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="已进入战斗" and blackboard:getValue("当前战斗流程")=="继续战斗"
	end
	)
关卡结算:getStartTrigger():setRule(
	function(blackboard)
		return blackboard:getValue("当前游戏场景")=="关卡结算" and blackboard:getValue("当前战斗流程")=="关卡结算"
	end
	)
print("触发器设定完毕")


-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--[[             场景内的行为设定               ]]
初始化页面:getDoingBehavior():setServer(
	function(blackboard)
	_K:keepScreen(true)
		local aim=scene.进入关卡()
		if aim==true then
			print("进入关卡")
			tbl.主页面:Click()
			blackboard:setValue("当前游戏场景","检测进入关卡")
		elseif aim=="选择助战" then
			print("选择助战")
			blackboard:setValue("当前游戏场景","选择助战")
		elseif aim=="已进入战斗" then
			blackboard:setValue("当前游戏场景","已进入战斗")
		elseif aim=="AP不足" then
			blackboard:setValue("当前游戏场景","AP不足")
		elseif aim=="仓库爆仓" then
			blackboard:setValue("当前游戏场景","仓库爆仓")
		end
	计数器:show(blackboard:getValue('当前游戏场景'))
	_K:keepScreen(false)
	delay(0.4)
	end
	)
进入关卡:getDoingBehavior():setServer(
	function(blackboard)
	_K:keepScreen(true)
		local aim=scene.检查进入关卡()
		if aim==true then
			blackboard:setValue("当前游戏场景","选择助战")
		elseif aim=="AP不足" then
			blackboard:setValue("当前游戏场景","AP不足")
		elseif aim=="仓库爆仓" then
			blackboard:setValue("当前游戏场景","仓库爆仓")
		end
	计数器:show(blackboard:getValue('当前游戏场景'))
	_K:keepScreen(false)
	delay(0.4)
	end
	)
AP不足:getDoingBehavior():setServer(
	function(blackboard)
		print("补充AP")
		if not blackboard:getValue('体力补充记录器') then  --在开始战斗处,改为false
			behavior.AP回复(blackboard:getValue("体力补充"))
			blackboard:setValue('体力补充记录器',true)
		end
		blackboard:setValue("当前游戏场景","初始化页面")
		print('结束补充AP')
	end
	)
仓库爆仓:getDoingBehavior():setServer(
	function(blackboard)
		point:new({x=427,y=714}):Click(2)
		behavior.贩卖(MainConfig["仓库爆仓"],blackboard:getValue("功能"))
		blackboard:setValue("当前游戏场景","重回主页")
	end
	)
重回主页:getDoingBehavior():setServer(
	function(blackboard)
		delay(1)
		if scene.重回主页()=="主页面" then
			tbl.主页面:Click()
			blackboard:setValue("当前游戏场景","检测进入关卡")
		else
			point:new({x=161,y=69}):Click()
		end	
	end
	)
选择助战:getDoingBehavior():setServer(
	function(blackboard)
		behavior.选择助战()
		blackboard:setValue("当前游戏场景","队伍确认")
		计数器:hide()
	end
	)
队伍确认:getDoingBehavior():setServer(
	function(blackboard)
	_K:keepScreen(true)
		local aim=scene.开始任务()
		if aim==true then
			point:new({x=1779,y=1016}):Click()
			blackboard:setValue("当前游戏场景","等待战斗开始")
			计数器:show((blackboard:getValue("已刷次数").."/"..blackboard:getValue("刷图次数")))
		elseif aim=="选择助战" then
			blackboard:setValue("当前游戏场景","选择助战")
		end
	_K:keepScreen(false)
	delay(1)
	end
	)
等待战斗开始:getDoingBehavior():setServer(
	function(blackboard)
	delay(1)
	_K:keepScreen(true)
		local aim=scene.等待战斗开始()
		if aim==true then
			blackboard:setValue("当前游戏场景","已进入战斗")
			blackboard:setValue("当前战斗流程","等待进入战斗")
		elseif aim=="跳过" then
		
		elseif aim=="道具使用" then
			behavior.使用道具()
		elseif aim=="队伍确认" then
			point:new({x=1779,y=1016}):Click()
			print("之前没点进去重点一次")
		end
	_K:keepScreen(false)
	end
	)
开始战斗:getDoingBehavior():setServer(
	function(blackboard)
		print("战斗开始")
		blackboard:setValue("当前战斗流程","回合开始")
		blackboard:setValue('体力补充记录器',false)
	end
	)
识别当前关卡:getDoingBehavior():setServer(
	function(blackboard)
		print("识别当前关卡")
		local t={"第一关","第二关","第三关"}
		local index=scene.识别当前关卡()
			if type(index)~="number" then index=1 end
			if index>3 then index=1 end
			print("index="..index)
			local 当前关卡=t[index]
			if blackboard:getValue("当前关卡")==当前关卡 then 
				blackboard:setValue("是否为新回合",false)
			else
				blackboard:setValue("是否为新回合",true)
			end
		blackboard:setValue("当前关卡",当前关卡)
		blackboard:setValue("当前战斗流程","识别关卡结束")
		if not MainConfig.隐藏计数器 then
			计数器:show((blackboard:getValue("当前关卡")))
		end
	end
	)
选择优先敌人:getDoingBehavior():setServer(
	function (blackboard)
		print("选择优先敌人")
		behavior.选择优先敌人(blackboard:getValue("当前关卡"))
		blackboard:setValue("当前战斗流程","选择优先敌人结束")
	end
	)
释放技能:getDoingBehavior():setServer(
	function(blackboard)
		behavior.释放技能(blackboard:getValue("当前关卡"),blackboard:getValue("是否为新回合"))
		blackboard:setValue("当前战斗流程","释放技能结束")
	end
	)
选卡:getDoingBehavior():setServer(
	function(blackboard)
		print("开始选卡")
		local ColorArea={{140,830,265,947},{525,830,649,933},{909,830,1033,895},{1277,830,1418,933},{1686,830,1819,934}}
		local 助战Area={{223,609,346,677},{606,607,730,679},{992,594,1114,669},{1377,594,1499,673},{1766,604,1890,683}}		
		local 克制Area={{263,540,352,625},{652,540,733,625},{1028,540,1123,625},{1413,540,1510,626},{1815,540,1887,625}}	
		point:new({x=1703,y=899}):Click()
		slp(2,MainConfig["脚本运行速度"])
		
		local Data={Color=ColorArea,助战=助战Area,克制=克制Area,人物=人物Area}
		local 宝具Data={Color=宝具Area,助战=nil,克制=nil}
		local 卡牌信息=behavior.取得卡牌信息(Data,5)
		behavior.释放宝具(blackboard:getValue("当前关卡"),blackboard:getValue("是否为新回合"))
		behavior.选卡(卡牌信息,blackboard:getValue("当前关卡"))
		blackboard:setValue("当前战斗流程","选卡结束")
	end
	)
等待回合结束:getDoingBehavior():setServer(
	function(blackboard)
	_K:keepScreen(true)
		local aim=scene.等待回合结束()
		if aim=="结算" or aim=="获得战利品" then
			blackboard:setValue("当前游戏场景","关卡结算")
			blackboard:setValue("当前战斗流程","关卡结算")
			计数器:hide()
		elseif aim=="继续战斗" then
			blackboard:setValue("当前战斗流程","继续战斗")		
		end
	_K:keepScreen(false)
	delay(0.5)
	end
	)
继续战斗:getDoingBehavior():setServer(
	function(blackboard)
		blackboard:setValue("当前战斗流程","回合开始")
	end
	)
关卡结算:getDoingBehavior():setServer(
	function(blackboard)
	_K:keepScreen(true)
		local aim=scene.获得战利品()
		if aim=="获得战利品" then
			multiPoint:new({index={1484,981,1842,1053}}):Click()
			blackboard:setValue("已刷次数",blackboard:getValue("已刷次数","已刷次数")+1)
		elseif aim=="申请好友" then
			point:new({x=495,y=923}):Click()
		elseif aim=="获取新卡" then
			print('获取新卡')
			point:new({x=55,y=63}):Click()
		elseif aim==true then
			blackboard:setValue("当前游戏场景","初始化页面")
		end
	_K:keepScreen(false)
	delay(0.5)
	end
	)

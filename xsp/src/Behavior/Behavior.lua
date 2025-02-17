local Behavior={}

local tbl=require("Behavior.Data")
计数器=HUD:new({point=tbl.HUD:getPoints(),color="0xfff9d854",bg="0x80222a15",size=35})

function Behavior.AP回复(index)
	local 金苹果,银苹果=point:new({x=1090,y=445,color=0xf1e9d8}),point:new({x=1090,y=660,color=0xf1e9d8})
	local 铜苹果,圣晶石=point:new({x=1090,y=848,color=0xeee6d5}),point:new({x=1090,y=220,color=0xf1e9d8})
	if index=="不补充体力" then  print("不补充体力") lua_exit()
	elseif index=="金苹果" then
		if 金苹果:getandCmpColor(true) then else lua_exit() end
	elseif index=="银苹果" then
		if 银苹果:getandCmpColor(true) then else lua_exit() end
	elseif index=="铜苹果" then
		if 铜苹果:getandCmpColor(true) then else lua_exit() end
	elseif index=="铜+银苹果" then
		if 银苹果:getandCmpColor(true) then
			else
			if 铜苹果:getandCmpColor(true) then else lua_exit() end
		end
	elseif index=="圣晶石" then
		if 圣晶石:getandCmpColor(true) then else lua_exit() end
	elseif index=="挂机等待60分钟" then for i=1,60*30 do slp(2) end
	elseif index=="挂机等待120分钟"	then for i=1,60*60 do slp(2) end
	end
	slp(2)
	point:new({x=1156,y=832}):Click(1)
end

function Behavior.选择助战()
	local 从者data,礼装data=require("Behavior.助战从者Data"),require("Behavior.助战礼装data")
	local function 下滑距离()
		local x=point:new({x=960,y=0})
		local 一号位Y=multiPoint:new({Area={1232,248,1491,506},{x=1255,y=367,color=0x386717},{x=1354,y=367,color=0x509739},vidr=1}):findColor()
		local 三号位Y=multiPoint:new({Area={1240,862,1492,1067},{x=1255,y=367,color=0x386717},{x=1354,y=367,color=0x509739},vidr=1}):findColor()
			if not 三号位Y then 三号位Y=point:new({x=1322,y=965}) end
			if not 一号位Y then 一号位Y=point:new({x=1322,y=365}) end
			return {{x.x,三号位Y.y},{x.x,一号位Y.y}}
	end 
	local function 获取助战位置()
		local Arry=_Arry.AppurtenantScaleMode
		local 一号位=multiPoint:new({Area={1232,248,1491,506},{x=1255,y=367,color=0x386717},{x=1354,y=367,color=0x509739},vidr=1}):findColor()
		local 二号位=multiPoint:new({Area={1241,566,1504,771},{x=1255,y=367,color=0x386717},{x=1354,y=367,color=0x509739},vidr=1}):findColor()
		if not 一号位 then 一号位=point:new({x=1322,y=365}) end
		if not 二号位 then 二号位=point:new({x=1322,y=665}) end
		local index={{x=一号位.x-200*Arry,y=一号位.y,mode=true},{x=二号位.x-200*Arry,y=二号位.y,mode=true}}
		local x1=point:new({x=71,y=751}).x
		if not 一号位 then y1=0 else	y1=一号位.y-(73*Arry)end
		if not 二号位 then y2=0 else	y2=二号位.y-(73*Arry)end
			return {{x=x1,y=y1},{x=x1,y=y2}},index
	end
	local function 识别(data,area,name)--传入data识别礼装和助战或和是否满破
		if data==nil or data==false then return true end --代表选择了无要求和列表前几
		local data=TableCopy(data)
		data.DstMainPoint=area
		data.Degree=data.Degree or 90
		data._tag=name
		local aim,err,ret=multiPoint:new(data):getandCmpColor()
		if aim==true then
			return true
		end
		return false
	end
	local function 列表更新()
		print("列表更新")
		local 按钮=point:new({x=1249,y=193})
		local 是=point:new({x=1247,y=847})
		local 关闭=point:new({x=953,y=841})
		按钮:Click(2)
		_K:SwitchScreen(false)
		if tbl.更新助战列表:getandCmpColor("更新助战列表") then 
			是:Click() 
			return true
		else
			if tbl.更新助战失败:getandCmpColor("更新助战失败") then
				关闭:Click(6)
				列表更新()
			end
		end
		
	end
	local function 等待助战页面()
		tbl.助战选择页面:WaitScreen("助战选择页面")
		slp(0.5)
	end
	local function 识别下拉框()
		_K:SwitchScreen(false)
		if point:new({x=1864,y=1017,color=0xebebf3,offset=0x121212}):getandCmpColor() then
			print("下拉框到底")
			return true
		end
		return false
	end
	-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	local 礼装选择,从者选择=MainConfig.礼装选择,MainConfig.从者选择
	local 是否满破,是否好友=MainConfig.是否选择满破礼装,MainConfig.是否选择好友
	local 列表位置={point:new({x=890,y=395}),point:new({x=890,y=695}),point:new({x=890,y=985})}
	local 无符合是否更新,助战选择优先级=MainConfig.无符合助战,MainConfig.助战选择优先级 
	local 已更新列表次数=0
	if 无符合是否更新=="不更新" then 列表更新次数=0 
		elseif 无符合是否更新=="更新一次助战" then 列表更新次数=1 
		elseif 无符合是否更新=="更新两次助战" then 列表更新次数=2 
		elseif 无符合是否更新=="更新三次助战" then 列表更新次数=3
	end
	-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	if     从者选择=="列表第一个" then 列表位置[1]:Click(0.5) return 
		elseif 从者选择=="列表第二个" then 列表位置[2]:Click(0.5) return 
		elseif 从者选择=="列表第三个" then 列表位置[3]:Click(0.5) return 
	else
		local 下滑=下滑距离()
		while true do
			for k=1,6 do	--代表下滑并且识别5次
			slp(0.5)
				_K:SwitchScreen(false)
				local area,index=获取助战位置()
					for i=1,2 do
						while true do
							if not 识别(从者data[从者选择],area[i],从者选择..i) then print("未识别到从者") break end
							if not 识别(礼装data[礼装选择],area[i],礼装选择..i) then print("未识别到礼装") break end 
							if 是否满破 then if 礼装data[礼装选择] then if not 识别(礼装data["满破"],area[i],"满破") then print("未识别到满破") break end end end
							if 是否好友 then if not 识别(礼装data["好友"],area[i],"好友") then print("未识别到好友") break end end
							return point:new(index[i]):Click(1)
						end
					end
					Move(下滑[1],下滑[2],4)
				_K:keepScreen(false)
				if 识别下拉框() then print("下拉条到底") break end
			end	
			if 列表更新次数>已更新列表次数 then 列表更新() 已更新列表次数=已更新列表次数+1 等待助战页面() else break end --列表更新
		end
		
		if 助战选择优先级=="无符合时优先从者" then	--无符号助战时优先选择
			for k=1,3 do
				for i=1,6 do
					slp(0.5)
					_K:SwitchScreen(false)
					local area=获取助战位置()
						for i=1,2 do
							while true do
								if not 识别(从者data[从者选择],area[i],从者选择..i) then break end
								return 列表位置[i]:Click(1)
							end
						end
						Move(下滑[1],下滑[2],4)
					_K:keepScreen(false)
					if 识别下拉框() then print("下拉条到底") break end --tbl.助战下拉条:findColor()
				end
				列表更新();等待助战页面()
			end
		elseif 助战选择优先级=="刷到需要的礼装为止" then
			while true do
				for i=1,6 do
					slp(0.5)
					_K:SwitchScreen(false)
					local area=获取助战位置()
						for i=1,2 do
							while true do
								if not 识别(礼装data[礼装选择],area[i],礼装选择..i) then break end
								if 是否满破 then if not 识别(礼装data["满破"],area[i],"满破") then break end end
								return 列表位置[i]:Click(1)
							end
						end
						Move(下滑[1],下滑[2],4)
					_K:keepScreen(false)
					if 识别下拉框() then print("下拉条到底") break end --tbl.助战下拉条:findColor()
				end	
				列表更新();等待助战页面()
			end		
		elseif 助战选择优先级=="无符合时优先礼装" then
			for k=1,3 do
				for i=1,6 do
					slp(0.5)
					_K:SwitchScreen(false)
					local area=获取助战位置()
						for i=1,2 do
							while true do
								if not 识别(礼装data[礼装选择],area[i],礼装选择..i) then break end
								if 是否满破 then if not 识别(礼装data["满破"],area[i],"满破") then break end end
								return 列表位置[i]:Click(1)
							end
						end
						Move(下滑[1],下滑[2],4)
					_K:keepScreen(false)
					if 识别下拉框() then print("下拉条到底") break end --tbl.助战下拉条:findColor()
				end	
				列表更新();等待助战页面()
			end
		elseif 助战选择优先级=="列表第一" then
			return point:new({x=890,y=360}):Click()
		end
	end
	print("退出默认第一")
	point:new({x=890,y=360}):Click(0.5)
end

function Behavior.选择优先敌人(index)
	local 策略=MainConfig[index.."优先攻击敌人"]
	if 策略=="默认" then return end
	local tbl={左=point:new({x=80,y=61}),右=point:new({x=780,y=72}),中=point:new({x=430,y=69})}
	tbl[策略]:Click(0.5)
end

function Behavior.释放技能(index,newRound)
	local 技能策略 = {从者技能=MainConfig[index.."技能选择"],御主技能=MainConfig[index.."御主技能选择"]}
	local 换人策略 = {先发=MainConfig["换人礼装_先发"],替补=MainConfig["换人礼装_替补"]}
	local 换人技能策略			= MainConfig["换人后释放技能"]
	local 指向性技能策略			= MainConfig[index.."指向性技能"]
	local 换人后指向性技能策略       = MainConfig["换人后指向性技能"]
	-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>防御
	local 识别敌方宝具策略		    = MainConfig[index.."识别敌方宝具"]
	local 防御技能策略			= MainConfig[index..'防御技能']
	local 御主防御技能策略		    = MainConfig[index..'御主防御技能']
	local 防御指向性技能策略		= MainConfig[index..'防御指向性技能']
	-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	local 从者技能顺序			= MainConfig[index..'从者技能顺序']
	
	local 技能顺序,御主技能={},{}

	if MainConfig.优先释放御主技能 and not 从者技能顺序 then
		从者技能顺序 = 'ABC123456789'
	end
	从者技能顺序 = strToTable(从者技能顺序)
	技能策略['御主技能'] = keyToValueTable(技能策略['御主技能'])
	table.foreach(技能策略['御主技能'],function(k,v) 
		if 		v=='1' or v==1 then 御主技能[#御主技能+1]=10
		elseif  v=='2' or v==2 then 御主技能[#御主技能+1]=11
		elseif  v=='3' or v==3 then 御主技能[#御主技能+1]=12
		end
	end)
	技能策略['从者技能'] = keyToValueTable(技能策略['从者技能'])
	技能顺序=TableCopy(技能策略['从者技能'])
	margeTable(技能顺序,御主技能)
	技能顺序 = getSkillChoice(技能顺序,从者技能顺序)
	table.foreach(技能策略['从者技能'],function(k,v) 
		if not belongvalue(技能顺序,v) then
			技能顺序[#技能顺序+1]=v
		end
	end)
	table.foreach(御主技能,function(k,v) 
		if not belongvalue(技能顺序,v) then
			技能顺序[#技能顺序+1]=v
		end
	end)
	
	-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	local 技能位置={ 
					{69,830,137,898},{219,837,272,894},{347,833,406,893},
					{551,840,607,891},{678,827,754,900},{827,845,876,897},
					{1031,836,1084,899},{1159,832,1213,895},{1302,831,1357,902},
					{1325,439,1390,493},{1456,431,1524,498},{1596,430,1651,496}		--御主技能	
		}
	local 指向性技能位置={	
			一号位=multiPoint:new({index={409,674,525,783}}),
			二号位=multiPoint:new({index={887,672,1047,786}}),
			三号位=multiPoint:new({index={1361,676,1482,775}})
			}
	local 换人位置={
		先发={第一位={x=209,y=512},第二位={x=503,y=519},第三位={x=801,y=517}},
		替补={第一位={x=1109,y=514},第二位={x=1416,y=508},第三位={x=1718,y=506}}
	}
	local 敌人充能槽={
		左={208,104,359,137},中={570,105,721,136},右={926,105,1077,136}
	}
	-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	function 换人后释放技能(str)
		print("换人后释放技能")
		local t={}
		if str=="第一位" then t={1,2,3}
		elseif str=="第二位" then t={4,5,6}
		elseif str=="第三位" then t={7,8,9}
		end
			tbl.战斗主页:WaitScreen("战斗主页")
			if not 换人技能策略 then return end
			for k,_ in pairs(换人技能策略) do
				multiPoint:new({index=技能位置[t[k]]}):Click(1)
				放技能(换人后指向性技能策略)
			end
	end
	function 放技能(策略)
		local 指向性技能策略=策略 or 指向性技能策略
		local now=os.time()
			while now+15>os.time() do
				_K:SwitchScreen(true)
				if tbl.技能多选框:getandCmpColor() then
					指向性技能位置[指向性技能策略]:Click(0.5)
					point:new({x=1649,y=226}):Click(0.5)
				elseif tbl.宝具详细:getandCmpColor() then print("没有这个技能")
					point:new({x=1590,y=130}):Click()
				elseif tbl.技能使用框:getandCmpColor() then  print("弹出使用框")
					local 决定=point:new({x=1398,y=635,color=0x666666})
						if 决定:getandCmpColor() then 
							point:new({x=550,y=630}):Click()
						else
							决定:Click()
						end
				elseif tbl.无法使用技能:getandCmpColor() then
					point:new({x=952,y=841}):Click(0.5)
				elseif tbl.换人礼装:getandCmpColor() then print("换人")
					point:new(换人位置.先发[换人策略.先发]):Click(0.5)
					point:new(换人位置.替补[换人策略.替补]):Click(0.5)
					point:new({x=940,y=940}):Click()
					换人后释放技能(换人策略.先发)
				elseif tbl.战斗主页:getandCmpColor() then
					print("技能释放完成")
					return true
				end
				slp(0.3)
			end
	end
	function 敌人宝具充能满(策略,index)
		print('检测敌方充能')
		local 敌人位置={'左','中','右'}
		for k,v in pairs(策略) do
			local multi=multiPoint:new({
				Area=敌人充能槽[敌人位置[k]],
				{x=257,y=119,color=0xff5c60},
				{x=281,y=119,color=0xff5c62},
				_tag='敌人充能槽'
			})
			防御技能策略 = 防御技能策略 and 防御技能策略 or {} 
			御主防御技能策略 = 御主防御技能策略 and 御主防御技能策略 or {} 
			local 御主技能策略={}
			table.foreach(御主防御技能策略,function(k,v) 
				if 		k=='1' or k==1 then 御主技能策略[#御主技能策略+1]=10
				elseif  k=='2' or k==2 then 御主技能策略[#御主技能策略+1]=11
				elseif  k=='3' or k==3 then 御主技能策略[#御主技能策略+1]=12
				end
			end)
				if multi:findColor() then
					for k,_ in pairs(防御技能策略) do
						multiPoint:new({index=技能位置[k]}):Click(1)
						放技能(防御指向性技能策略)
					end
					for k,v in pairs(御主技能策略) do
						point:new({x=1795,y=477}):Click(0.6)
						multiPoint:new({index=技能位置[v]}):Click(1)
						放技能(防御指向性技能策略)
					end
					return
				end
		end
	end
	function 重新释放技能()
		local 技能策略=		keyToValueTable(MainConfig[index.."CD冷却技能选择"])
		-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		local 检测位置={
			{x=112,y=916,color=0xbfbfae},{x=261,y=916,color=0xbfbfae},{x=392,y=916,color=0xbfbfae},
			{x=587,y=916,color=0xbfbfae},{x=727,y=916,color=0xbfbfae},{x=868,y=916,color=0xbfbfae},
			{x=1066,y=916,color=0xbfbfae},{x=1206,y=916,color=0xbfbfae},{x=1347,y=916,color=0xbfbfae},
		}
		local 技能检测位置={
			{x=112,y=814,color=0xffffff},{x=261,y=814,color=0xffffff},{x=392,y=814,color=0xffffff},
			{x=587,y=814,color=0xffffff},{x=727,y=814,color=0xffffff},{x=868,y=814,color=0xffffff},
			{x=1066,y=814,color=0xffffff},{x=1206,y=814,color=0xffffff},{x=1347,y=814,color=0xffffff},
		}
		for _,v in pairs(技能策略) do
			local p=point:new(技能检测位置[v])
			p:getColor()
			if p:cmpColor() then 
				local diff=point:new(检测位置[v]):getDiff()
				if diff.r>90 or diff.g>90 then
					print(v.."cd中")
				else
					multiPoint:new({index=技能位置[v]}):Click(1)
					放技能()	
				end
			end
		end
	end
	-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	if newRound then
		print('释放技能')
		for _,v in pairs(技能顺序) do
			if v>=10 then point:new({x=1795,y=477}):Click(0.6) end
			multiPoint:new({index=技能位置[v]}):Click(1)
			放技能()	
		end
	end
	
	print('重新释放技能')
	_K:SwitchScreen()
	重新释放技能()
	_K:keepScreen(false)
		
	if 识别敌方宝具策略 then 
		_K:SwitchScreen()
		敌人宝具充能满(识别敌方宝具策略,index)
		_K:keepScreen(false)	
	end	
end

function Behavior.释放宝具(index,bool)
	local 宝具释放		= keyToValueTable(MainConfig[index.."宝具选择"])
	local 释放顺序策略	= MainConfig[index.."宝具释放顺序"]
	local 循环释放		= MainConfig[index.."宝具循环释放"]
	
	if not 宝具释放 then print('未选择宝具') return end
	local tbl={[123]={1,2,3},[213]={2,1,3},[321]={3,2,1},[132]={1,3,2},[312]={3,1,2}}
	local 宝具位置={		 	
		{542,184,671,225},{900,184,1025,225},{1255,184,1369,225}
	}
	local 顺序=getSkillChoice(宝具释放,tbl[释放顺序策略])
	if not 循环释放 then	--不循环释放
		if bool==true then --新回合
			for k,v in pairs(顺序) do
				multiPoint:new({index=宝具位置[v]}):Click(0.2)
				slp()
			end
		end
	else
		for k,v in pairs(顺序) do
			multiPoint:new({index=宝具位置[v]}):Click(0.2)
		end
	end
end

function Behavior.选卡(卡牌Data,index)
	local function 设定卡牌权重(出卡顺序,出卡逻辑,是否克制)
		local 权重={}
		if 是否克制 then 
			克制,被克制=1.75,0.5
		else
			克制,被克制 = 1,1
		end
		if 出卡顺序=="红>蓝>绿" then 
			红色,蓝色,绿色=1.5,1,0.8
		elseif 出卡顺序=="蓝>红>绿"	then 
			红色,蓝色,绿色=1,1.5,0.8
		elseif 出卡顺序=="绿>红>蓝"	then 
			红色,蓝色,绿色=1,0.8,1.5
		elseif 出卡顺序=="红>绿>蓝"	then 
			红色,蓝色,绿色=1.5,0.8,1
		end     
		if 出卡逻辑=="无要求" then 
			助战=1
		elseif 出卡逻辑=="同颜色" then 
			助战,克制,被克制=1,1,1
		elseif 出卡逻辑=="优先助战卡" then 
			助战=3
		elseif 出卡逻辑=="不优先助战卡" then 
			助战=0.2
		elseif 出卡逻辑=="不优先同角色" then 
			助战=1
		end
		权重={颜色={红=红色,蓝=蓝色,绿=绿色},克制=克制,被克制=被克制,助战=助战}
		return 权重
	end
	local 出卡顺序 = MainConfig[index.."出卡颜色顺序"]	--"红>蓝>绿,蓝>红>绿,绿>红>蓝,红>绿>蓝"
	local 出卡逻辑 = MainConfig[index.."出卡逻辑"]	--无要求,前三张,同颜色,优先助战,不优先助战,优先同个角色
	local 是否克制 = MainConfig.是否计算克制
	local 选卡={{120,680,258,860},{515,680,640,860},{874,680,1044,860},{1269,680,1414,860},{1660,680,1813,860}}
	local 权重=设定卡牌权重(出卡顺序,出卡逻辑,是否克制);
	local Data=TableCopy(卡牌Data)
	
	local 卡牌={1000,1000,1000,1000,1000}
		for i=1,5 do
			local data=Data[i]
			for k,v in pairs(data) do
				if k=="颜色" then
					卡牌[i]=卡牌[i]*权重[k][v]
				else	
					卡牌[i]=卡牌[i]*(v and 权重[k] or 1)
				end
			end
		end
		local 结算=getKeysSortedByValue(卡牌,function(a,b) return a>b end)
		if 出卡逻辑=="前三张" then 
			for i=1,3 do multiPoint:new({index=选卡[i]}):Click(0.3) end
		elseif 出卡逻辑=="同颜色" then
			local data=getTableRepeat(卡牌);local aim
			for k,v in pairs(data) do
				if v>=3 then
					for q,e in pairs(卡牌) do
						if e==k then
							multiPoint:new({index=选卡[q]}):Click(0.3)
						end
					end
				return
				end
			end
			for k,v in pairs(结算) do
				multiPoint:new({index=选卡[v]}):Click(0.3)
			end
		elseif 出卡逻辑=="交替出卡" then
		
		
		else
			for k,v in pairs(结算) do
				multiPoint:new({index=选卡[v]}):Click(0.3)
			end
		end
end

function Behavior.取得卡牌信息(AreaTbl,index)
	local function 取得每张卡颜色(Area)
		local ColorData={
			红={{x=0,y=0,color=0xd0370b},{x=7,y=-6,color=0xfff8ae},{x=2,y=12,color=0xfafac7}},
			蓝={{x=0,y=0,color=0x82f5fd},{x=-67,y=6,color=0xfdf5ab},{x=-50,y=44,color=0xab7940}},
			绿={{x=0,y=0,color=0x51f535},{x=-6,y=-21,color=0xb6854b},{x=-7,y=-30,color=0xe8c682}}}
		for k,v in pairs(ColorData) do
			local data={};data.Area=Area;data.Degree=90
			table.foreach(v,function (k,v) data[k]=v end)
			local data=multiPoint:new(data):findColor()
			if data then return k end 
		end
	end
	local function 取得助战关系(Area)
		local ColorData={{x=0,y=0,color=0xbf5353},{x=-7,y=0,color=0x8c3737},{x=-14,y=-1,color=0xf2f2f4}}
		local data={};data.Area=Area;data.Degree=90
		table.foreach(ColorData,function (k,v) data[k]=v end)
		local data=multiPoint:new(data):findColor()
		if data then return true else return false end
	end
	local function 取得克制关系(Area)
		local ColorData={{x=0,y=0,color=0xf65322},{x=1,y=8,color=0xd30000},{x=0,y=18,color=0x720101},{x=-20,y=29,color=0xffed8e}}	
		local data={};data.Area=Area;data.Degree=90
		table.foreach(ColorData,function (k,v) data[k]=v end)
		local data=multiPoint:new(data):findColor()
			if data then return true else return false end
		end
	_K:SwitchScreen()
	local data={}
		for i=1,index do
			data[i]={
				颜色=取得每张卡颜色(AreaTbl.Color[i]),
				助战=取得助战关系(AreaTbl.助战[i]),
				克制=取得克制关系(AreaTbl.克制[i]),
			}
		end
	_K:keepScreen(false)
	return data
end

function Behavior.贩卖(策略,nowfunction)
	local mode,screen
	local function 筛选(mode,nowfunction,screen)
	point:new({x=1471,y=196}):Click(1)--点击筛选
		if mode=="从者" then
			if nowfunction=="自动贩卖" or mowfunction=="自动抽友情" then
				point:new({x=1254,y=828}):Click(1)--点击全部取消
				point:new({x=313,y=584}):Click(0.5)--点击标记状态外
				if screen[1] then point:new({x=1275,y=453}):Click(0.5) end --狗粮
				if screen[2] then point:new({x=1598,y=462}):Click(0.5) end --芙芙
				if screen[3] then tbl.筛选从者:AllClick(0.2) end --从者
				point:new({x=1257,y=956}):Click(1)--点击决定
			else 
				multiPoint:new({{x=1254,y=828},{x=313,y=584},{x=1275,y=453},{x=1257,y=956}}):AllClick(0.5)
			end
		elseif mode=="礼装" then
			if nowfunction=="自动贩卖" then
				point:new({x=1254,y=828}):Click(1)--点击全部取消
				point:new({x=810,y=457}):Click(0.5)--点击标记状态外
				if screen[1] then point:new({x=485,y=457}):Click(0.5) end
				if screen[2] then point:new({x=1439,y=340}):Click(0.5) end
				if screen[3] then point:new({x=1111,y=342}):Click(0.5) end
				point:new({x=1257,y=956}):Click(1)--点击决定
			else
				multiPoint:new({{x=1254,y=828},{x=810,y=457},{x=485,y=457},{x=1439,y=340},{x=1257,y=956}}):AllClick(0.5)
			end
		else
			dialog("筛选错误");lua_exit()
		end
	end
	local function 调整顺序(mode)
		point:new({x=1686,y=190}):Click(1);_K:keepScreen(false)
		point:new({x=830,y=706,color=0x5b5b5b}):getandCmpColor(true,0.5)
		if mode=="从者" then
			multiPoint:new({{x=1600,y=353},{x=1277,y=950}}):AllClick(0.5)
		elseif mode=="礼装" then
			multiPoint:new({{x=643,y=482},{x=1277,y=955}}):AllClick(0.5)
		else
			dialog("排序mode错误")
			lua_exit()
		end
	end
	local function 升降序(index)
		local tbl={
				升序={x=1859,y=214,color=0xf0ffff},降序={x=1859,y=193,color=0xeefefe},
			}
		point:new(tbl[index]):getandCmpColor(false)
	end
	local function 调整列表大小()	--没写呢
		for i=1,2 do
			point:new({x=41,y=1015}):Click(0.3)
		end
	end
	local function 卖出()
		point:new({x=1636,y=1006}):Click(1)--决定
		point:new({x=1156,y=875}):Click(1)--销毁
		tbl.等待变还页面:WaitScreen("等待变还关闭")
		point:new({x=952,y=877}):Click(1)--关闭
	end
	tbl.灵基变还:WaitScreen("灵基变还")
	
	if point:new({x=256,y=189,color=0xf7c618}):getandCmpColor() then 
		mode="从者" 
	elseif point:new({x=328,y=186,color=0xebb125}):getandCmpColor() then
		mode="礼装" 
	end
	if nowfunction=="按次数重复刷图" then 
		if 策略=="停止脚本" then lua_exit() end
	elseif nowfunction=="自动抽友情" then
		if 策略[mode] then 策略=策略[mode.."策略"] else lua_exit() end
	elseif nowfunction=="自动贩卖" then
		if 策略.功能=="礼装" then 
			if mode=="从者" then point:new({x=711,y=192}):Click(0.5) end
				screen=策略.筛选
				if screen[3] and not screen[1] and not screen[2] then 
					策略="银"
				elseif screen[1] or screen[2] and screen[3] then
					策略="铜银狗粮"
				else
					策略="铜"
				end	
			elseif 策略.功能=="从者" then
				if mode=="礼装" then point:new({x=162,y=219}):Click(0.5) end
					screen=策略.筛选
					策略=策略.星级
				end
	else
		策略="铜银狗粮"
	end
	筛选(mode,nowfunction,screen);调整顺序(mode);升降序("升序")
	slp(1)
	-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	local Arry=_Arry.AppurtenantScaleMode
	local 行间距,列间距=200*Arry,213*Arry
	local 左列表=point:new({x=93,y=0,MainPoint={x=0,y=0},Anchor='Left'}):getXY()
	local 上列表=point:new({x=93,y=248,MainPoint={x=0,y=0},Anchor='Top'}):getXY()
	local 第一行第一个={	x=左列表.x+48*Arry,
						y=上列表.y+27*Arry+180*Arry --140,455
					} 
	while true do
	local Tbl,clickTbl={},{}
		_K:SwitchScreen(true)
			for i=0,2 do
				for k=0,6 do
					for v=1,1 do
						local x= 第一行第一个.x+行间距*k
						local y= 第一行第一个.y+列间距*i
						clickTbl[#clickTbl+1]=point:new({x=x,y=y,mode=true})
						if point:new({x=x,y=y,color=0x928269,mode=true,Degree=90}):getandCmpColor() then
							Tbl[#Tbl+1]='铜';break
						end
						if point:new({x=x,y=y,color=0xb2b2b2,mode=true,Degree=90}):getandCmpColor() then
							Tbl[#Tbl+1]='银';break
						end
						if point:new({x=x,y=y,color=0xdcb327,mode=true,Degree=90}):getandCmpColor() then
							Tbl[#Tbl+1]='金';break
						end	
						Tbl[#Tbl+1]='无'
					end
				end
			end
		_K:keepScreen(false)
		
			if 策略=="铜银狗粮" or 策略=="铜+银" then
				if Tbl[1]=="金" or Tbl[1]=="无" then return false end
				for k,v in pairs(Tbl) do
					if v=="铜" or v=="银" then
						clickTbl[k]:Click(0.1)
					end
					if v=="金" then break end
				end
				
			elseif 策略=="铜" then
				if Tbl[1]=="金" or Tbl[1]=="无" or Tbl[1]=="银" then return false end
				for k,v in pairs(Tbl) do
					if v=="铜" then
						clickTbl[k]:Click(0.1)
					end
					if v=="金" or v=="银" then break end
				end
			elseif 策略=="银" then
				if Tbl[1]=="金" or Tbl[1]=="无" or Tbl[1]=="铜" then return false end
				for k,v in pairs(Tbl) do
					if v=="银" then
						clickTbl[k]:Click(0.1)
					end
					if v=="金" or v=="铜" then break end
				end
			elseif 策略=="全都卖" then
				if not Tbl[1] then return false end
				for k,v in pairs(Tbl) do
					clickTbl[k]:Click(0.1)
			end
		end
			卖出()
			slp(1.5)
	end
end

function Behavior.使用道具()
	local 策略=MainConfig["活动加成道具选择"]
	local 道具={
		勇者之剑=point:new({x=1037,y=260,color=0x625e58}),勇者之枪=point:new({x=1051,y=495,color=0x625e58}),
		勇者之弓=point:new({x=1017,y=715,color=0xf4ecdb}),勇者披风=point:new({x=1037,y=498,color=0x625e58}),
		勇者之盾=point:new({x=1037,y=720,color=0x625e58}),开关=point:new({x=1628,y=136,color=0x119dfe})
		}
	local 下滑={point:new({x=1000,y=650}),point:new({x=1000,y=250})}
	slp(0.1)
	if 道具.开关:getandCmpColor("开关") then 道具.开关:Click() end 
		if 策略=="不选择" then
			point:new({x=1234,y=977}):Click()
		elseif 策略=="勇者之剑" then
			道具.勇者之剑:getandCmpColor(false,0.3)
		elseif 策略=="勇者之枪" then
			道具.勇者之枪:getandCmpColor(false,0.3) 
		elseif 策略=="勇者之弓" then
			道具.勇者之弓:getandCmpColor(false,0.3)
		elseif 策略=="勇者披风" then
			Move({下滑[1].x,下滑[1].y},{下滑[2].x,下滑[2].y},4);slp(0.1)
			道具.勇者披风:getandCmpColor(false,0.3)
		elseif 策略=="勇者之盾" then
			Move({下滑[1].x,下滑[1].y},{下滑[2].x,下滑[2].y},4);slp(0.1)
			道具.勇者之盾:getandCmpColor(false,0.3)
		end
		point:new({x=1234,y=977}):Click()
end











return Behavior














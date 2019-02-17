require("UI.Z_ui")
local DevScreen={
	Width=1920,
	Height=1080,
}
local 助战名单="无要求,列表第一个,列表第二个,列表第三个,梅林,诸葛孔明,玉藻前,拉二,德雷克,海伦娜(Caster),小莫(Rider),小莫(saber),花嫁尼禄,"
local 助战名单=助战名单.."闪闪,黑狗,源赖光,宫本武藏,刑部姬,天草四郎,弓凛"
local 礼装名单="无要求,学妹午餐,2030年的碎片,蒙娜丽莎,宇宙棱镜,万华镜,虚数魔术,"
local 礼装名单=礼装名单.."死之艺术,迦勒底的学者,无慈悲者,引导迦勒底的少女,柔软的慈爱,毒蛇一艺"

local 主UI=UI:new(DevScreen,{align="left",w=90,h=90,size=90,cancelname="取消",okname="OK",countdown=0,config=UI配置文件..".dat",xpos=2})
local 主功能选择=Page:new(主UI,{text="主功能选择",size=20})
主功能选择:addLabel({text="[冥界的圣诞快乐]",size=60,align="center",w=90,color="255,0,0"})
主功能选择:nextLine()
主功能选择:addLabel({text="功能选择:",size=40,color="57,85,164"})
主功能选择:addLabel({text="--运行前请去叉叉设置里选择运行时隐藏悬浮窗,选择了自动卖狗粮要先调整成一排7个的模式",size=25,color="255,0,0",ypos=2})
主功能选择:nextLine(1.5)
主功能选择:addRadioGroup({id="功能选择",list="按次数重复刷图,自动贩卖,自动抽友情,自动抽无限池",select=0,w=100,h=10,size=30,xpos=2})
主功能选择:nextLine()
主功能选择:addLabel({text="抽完十池后再选择自动抽,不然大奖抽到后就会重置",size=40,color="255,0,0"})
主功能选择:nextLine()
主功能选择:addLabel({text="体力补充:",size=40,color="41,157,255"})
主功能选择:addComboBox({id="体力补充",list="不补充体力,金苹果,银苹果,铜苹果,圣晶石,铜+银苹果,挂机等待60分钟,挂机等待120分钟",select=0,size=30,w=30,h=10})
主功能选择:nextLine(1.2)
主功能选择:addLabel({text="活动道具:",size=40,color="41,157,255"})
主功能选择:addComboBox({id="活动加成道具选择",list="不选择,勇者之剑,勇者之枪,勇者之弓,勇者披风,勇者之盾",select=0,size=30,w=30,h=10})
主功能选择:nextLine(1.2)
主功能选择:addLabel({text="仓库爆仓:",size=40,color="41,157,255"})
主功能选择:addComboBox({id="仓库爆仓",list="停止脚本,铜银狗粮,全都卖",select=0,size=30,w=30,h=10})
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
local 技能宝具设置=Page:new(主UI,{text="技能宝具设置"})
local 分割线=">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
技能宝具设置:addLabel({text="技能设置",size=30,align="center",color="57,85,164"})
技能宝具设置:nextLine(1.5)
技能宝具设置:addLabel({text="从者技能:",size=25,color="0,0,255",xpos=1})
技能宝具设置:addLabel({text="————(一到九对应三个从者的技能)建议关闭技能使用确认",size=25,color="255,0,0",xpos=1})
技能宝具设置:addCheckBoxGroup({id="优先释放御主技能",list="优先释放御主技能",select="2",size=30,w=25,h=10,color="0,0,0",xpos=2})
技能宝具设置:nextLine(0.5)
-------------------------------------------------------------------------------------------
local 关卡={"第一关","第二关","第三关"}
for k,v in pairs(关卡) do
技能宝具设置:addLabel({text=分割线..v,size=25,color="41,157,255"})
技能宝具设置:nextLine(0.4)
技能宝具设置:addLabel({text="从者技能:",size=30,color="41,157,255"})
技能宝具设置:addCheckBoxGroup({id=v.."技能选择",list="一,二,三,四,五,六,七,八,九",select="10",size=30,w=70,h=10,color="0,0,0"})
技能宝具设置:nextLine(0.7)
技能宝具设置:addLabel({text="御主技能:",size=30,color="41,157,255"})
技能宝具设置:addCheckBoxGroup({id=v.."御主技能选择",list="一,二,三",select="10",size=30,w=40,h=10,color="0,0,0"})
技能宝具设置:nextLine(0.7)
技能宝具设置:addLabel({text="宝具选择:",size=30,color="41,157,255"})
技能宝具设置:addCheckBoxGroup({id=v.."宝具选择",list="一,二,三",select="10",size=30,w=30,h=10,color="0,0,0"})
技能宝具设置:addCheckBoxGroup({id=v.."宝具循环释放",list="循环释放",select="2",size=30,w=15,h=10,color="0,0,0"})
技能宝具设置:nextLine(0.7)
技能宝具设置:addLabel({text="宝具释放顺序:",size=30,color="41,157,255"})
技能宝具设置:addRadioGroup({id=v.."宝具释放顺序",list="123,213,312,321,132",select="0",size=30,w=50,h=10,color="0,0,0"})
技能宝具设置:nextLine(0.7)
技能宝具设置:addLabel({text="指向性技能目标:",size=30,color="41,157,255"})
技能宝具设置:addRadioGroup({id=v.."指向性技能",list="一号位,二号位,三号位",select="0",size=30,w=40,h=10,color="0,0,0"})
技能宝具设置:nextLine(0.7)
技能宝具设置:addLabel({text="优先攻击敌人:",size=25,color="41,157,255"})
技能宝具设置:addRadioGroup({id=v.."优先攻击敌人",list="默认,左,中,右",select="0",size=30,w=50,h=10,color="0,0,0"})
技能宝具设置:nextLine(0.7)
技能宝具设置:addLabel({text="防御策略   ",size=25,color="255,0,0"})
技能宝具设置:addLabel({text="识别敌方宝具充能:",size=25,color="41,157,255"})
技能宝具设置:addCheckBoxGroup({id=v.."识别敌方宝具",list="左,中,右",select="10",size=30,w=30,h=10,color="0,0,0"})
技能宝具设置:nextLine(0.7)
技能宝具设置:addLabel({text="释放防御技能:",size=25,color="41,157,255"})
技能宝具设置:addCheckBoxGroup({id=v.."防御技能",list="一,二,三,四,五,六,七,八,九",select="10",size=30,w=70,h=10,color="0,0,0"})
技能宝具设置:nextLine(0.7)
技能宝具设置:addLabel({text="释放御主防御技能:",size=25,color="41,157,255"})
技能宝具设置:addCheckBoxGroup({id=v.."御主防御技能",list="一,二,三",select="10",size=30,w=70,h=10,color="0,0,0"})
技能宝具设置:nextLine(0.7)
技能宝具设置:addLabel({text="指向性技能目标(防御):",size=30,color="41,157,255"})
技能宝具设置:addRadioGroup({id=v.."防御指向性技能",list="一号位,二号位,三号位",select="0",size=30,w=40,h=10,color="0,0,0"})
技能宝具设置:nextLine()
end
技能宝具设置:addLabel({text=分割线,size=25,color="41,157,255"})
技能宝具设置:nextLine(0.6)
-------------------------------------------------------------------------------------------
技能宝具设置:addLabel({text="换人礼装设置:",size=25,color="0,0,255",xpos=1,w=40})
技能宝具设置:nextLine(0.6)
-------------------------------------------------------------------------------------------指向性技能
技能宝具设置:addComboBox({id="换人礼装_先发",list="第一位,第二位,第三位,",select=0,size=30,w=20,h=10,xpos=5})
技能宝具设置:addLabel({text="< 交换 >",size=25,color="0,0,0",xpos=5,ypos=3})
技能宝具设置:addComboBox({id="换人礼装_替补",list="第一位,第二位,第三位,",select=0,size=30,w=20,h=10,xpos=5})
技能宝具设置:nextLine()
技能宝具设置:addLabel({text="换人后释放技能:",size=25,color="41,157,255",xpos=5,ypos=3})
技能宝具设置:addCheckBoxGroup({id="换人后释放技能",list="一,二,三",select="10",size=30,w=25,h=10,color="0,0,0",ypos=1})
技能宝具设置:addLabel({text="换人后指向性技能目标:",size=25,color="41,157,255",ypos=3})
技能宝具设置:addRadioGroup({id="换人后指向性技能",list="一号位,二号位,三号位",select="0",size=30,w=40,h=10,color="0,0,0",ypos=1})

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
local 出卡设置=Page:new(主UI,{text="战斗设置"})
出卡设置:addLabel({text="出卡设置",size=30,align="center",color="57,85,164"})
出卡设置:nextLine(1.5)
出卡设置:addLabel({text="出卡颜色顺序:",size=25,color="0,0,255",xpos=1})
出卡设置:nextLine(0.6)
-------------------------------------------------------------------------------------------出卡颜色顺序
出卡设置:addLabel({text="第一关:",size=25,color="41,157,255",xpos=2})
出卡设置:addRadioGroup({id="第一关出卡颜色顺序",list="红>蓝>绿,蓝>红>绿,绿>红>蓝,红>绿>蓝",select="0",size=25,w=60,h=10,color="0,0,0"})
出卡设置:nextLine(0.5) 
出卡设置:addLabel({text="",size=25,color="41,157,255",xpos=8})
出卡设置:addRadioGroup({id="第一关出卡逻辑",list="无要求,前三张,同颜色,优先助战卡,不优先助战卡",select="0",size=25,w=70,h=10,color="0,0,0"})
出卡设置:nextLine(0.6)
出卡设置:addLabel({text="第二关:",size=25,color="41,157,255",xpos=2})
出卡设置:addRadioGroup({id="第二关出卡颜色顺序",list="红>蓝>绿,蓝>红>绿,绿>红>蓝,红>绿>蓝",select="0",size=25,w=60,h=10,color="0,0,0"})
出卡设置:nextLine(0.5) 
出卡设置:addLabel({text="",size=25,color="41,157,255",xpos=8})
出卡设置:addRadioGroup({id="第二关出卡逻辑",list="无要求,前三张,同颜色,优先助战卡,不优先助战卡",select="0",size=25,w=70,h=10,color="0,0,0"})
出卡设置:nextLine(0.6)
出卡设置:addLabel({text="第三关:",size=25,color="41,157,255",xpos=2})
出卡设置:addRadioGroup({id="第三关出卡颜色顺序",list="红>蓝>绿,蓝>红>绿,绿>红>蓝,红>绿>蓝",select="0",size=25,w=60,h=10,color="0,0,0"})
出卡设置:nextLine(0.5)  
出卡设置:addLabel({text="",size=25,color="41,157,255",xpos=8})
出卡设置:addRadioGroup({id="第三关出卡逻辑",list="无要求,前三张,同颜色,优先助战卡,不优先助战卡",select="0",size=25,w=70,h=10,color="0,0,0"})
出卡设置:nextLine(0.5)
出卡设置:addCheckBoxGroup({id="是否计算克制",list="是否计算克制",select="10",size=25,w=60,h=10,color="0,0,0",xpos=2})
-------------------------------------------------------------------------------------------
--出卡设置:nextLine(1)
--出卡设置:addLabel({text="战败设置",size=30,align="center",color="57,85,164"})
--出卡设置:nextLine(0.6)
---------------------------------------------------------------------------------------------战败
--出卡设置:addCheckBoxGroup({id="令咒复活",list="令咒复活一次",select="10",size=25,w=60,h=10,color="0,0,0",xpos=2})
--出卡设置:nextLine(0.6)
--出卡设置:addComboBox({id="战败设置",list="脚本退出,战败重开",select="0",size=25,w=30,h=10,color="0,0,0",xpos=2})
--出卡设置:addComboBox({id="战败退出",list="战败两次退出,战败三次退出,战败四次退出,战败五次退出,无限重开",select="0",size=25,w=30,h=10,color="0,0,0",xpos=2})
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
local 助战=Page:new(主UI,{text="选择助战"})
助战:addLabel({text="助战选择",size=30,align="center",color="57,85,164"})
助战:nextLine(1)
助战:addRadioGroup({id="从者选择",select="0",size=25,w=100,h=50,color="0,0,0",list=助战名单})
助战:nextLine(1)
助战:addLabel({text="礼装",size=30,align="center",color="57,85,164"})
助战:addCheckBoxGroup({id="是否选择好友",list="优先选择好友",select="2",size=25,w=15,h=10,color="0,0,0",xpos=2})
助战:addCheckBoxGroup({id="是否选择满破礼装",list="优先满破礼装",select="2",size=25,w=15,h=10,color="0,0,0",xpos=2})
助战:nextLine(0.4)
助战:addRadioGroup({id="礼装选择",select="0",size=25,w=100,h=40,color="0,0,0",list=礼装名单})
助战:nextLine(0.6)
助战:addLabel({text="无符合助战或礼装时:",size=30,align="center",color="57,85,164",xpos=-1})
助战:nextLine(0.5)
助战:addComboBox({id="无符合助战",list="不更新,更新一次助战,更新两次助战,更新三次助战",select="0",size=25,w=30,h=10,color="0,0,0"})
助战:addComboBox({id="助战选择优先级",list="无符合时优先从者,无符合时优先礼装,刷到需要的礼装为止,列表第一",select="0",size=25,w=30,h=10,color="0,0,0",xpos=5})
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
local 其他设置=Page:new(主UI,{text="其他设置"})
其他设置:addLabel({text="脚本运行速度:",size=30,align="Left",color="57,85,164",xpos=-1})
其他设置:addRadioGroup({id="脚本运行速度",list="极快,快,正常,一般,慢",select="2",size=25,w=40,h=10,color="0,0,0",xpos=2})
其他设置:nextLine(0.5)
其他设置:addCheckBoxGroup({id="隐藏计数器",list="隐藏计数器",select="2",size=25,w=15,h=10,color="0,0,0",xpos=-1})
--其他设置:addCheckBoxGroup({id="保留助战日志到剪贴板",list="保留助战日志到剪贴板",select="2",size=30,w=25,h=10,color="0,0,0",xpos=2})





return 主UI:show(1)
class_name BurgerOrderStats
extends Resource

@export var type: OrderType

enum OrderType {汉堡1,汉堡2,汉堡3}

const OrderContent := {

	
	
	
}

# 这是处理汉堡类型的系统，所以需要：
# 定义汉堡类型的名称OrderType
# 定义汉堡类型需要的内容OrderContent
# 问题：如何转化packed_burger和这个脚本之间的联动
# packed_burger是个Array[BurgerPartStats]的数组，里面的数据是BurgerPartStats
# 存储并print出来的是[<Resource#-9223372003166124730>, <Resource#-9223372003568777920>, <Resource#-9223372003434560190>, <Resource#-9223372003434560190>, <Resource#-9223372003300342460>]
# 类型的数据
# ————————>
# 需要做基于BurgerPartStats类的数据匹配

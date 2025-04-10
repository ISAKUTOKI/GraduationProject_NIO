class_name BurgerOrderStats
extends Node

enum OrderType { 普通汉堡, 芝士汉堡, 芝士双层堡, 素食主义汉堡, 豪华蟹黄堡, 全麦汉堡, }

const OrderContent := {
	OrderType.普通汉堡: [1, 2, 4, 6, 7, 0],
	OrderType.芝士汉堡: [1, 2, 3, 6, 5, 0],
	OrderType.芝士双层堡: [1, 2, 3, 2, 3, 6, 5, 0],
	OrderType.素食主义汉堡: [1, 6, 7, 4, 8, 9, 0],
	OrderType.豪华蟹黄堡: [1, 2, 6, 3, 7, 8, 4, 5, 9, 0],
	OrderType.全麦汉堡: [1, 2, 5, 0],
}

const OrderSprite := {
	OrderType.普通汉堡: "",
	OrderType.芝士汉堡: "",
	OrderType.芝士双层堡: "",
	OrderType.素食主义汉堡: "",
	OrderType.豪华蟹黄堡: "",
	OrderType.全麦汉堡: "",
}

const OrderName := {
	OrderType.普通汉堡: "普通汉堡", 
	OrderType.芝士汉堡: "芝士汉堡", 
	OrderType.芝士双层堡: "芝士双层堡", 
	OrderType.素食主义汉堡: "素食主义汉堡", 
	OrderType.豪华蟹黄堡: "三层超豪华四乘四新鲜的泛着光经过高压了的低脂蟹皇堡", 
	OrderType.全麦汉堡: "全麦汉堡",
}
#const PartTypeNumber := {
#PartType.汉堡上: 0,
#PartType.汉堡下: 1,
#PartType.肉饼: 2,
#PartType.芝士: 3,
#PartType.芥末酱: 4,
#PartType.番茄酱: 5,
#PartType.生菜: 6,
#PartType.洋葱: 7,
#PartType.番茄: 8,
#PartType.黄瓜: 9
#}

# 普通汉堡（面包，肉饼，芥末酱，生菜，洋葱，面包）
# 芝士汉堡（面包，肉饼，芝士，生菜，番茄酱，面包）
# 芝士双层堡（面包，肉饼，芝士，肉饼，芝士，生菜，番茄酱，面包）
# 素食主义汉堡（面包，生菜，洋葱，芥末酱，西红柿，腌黄瓜，面包）
# 三层超豪华四乘四新鲜的泛着光经过高压了的低脂蟹皇堡（豪华蟹黄堡）
# （面包，肉饼，生菜，芝士，洋葱，西红柿，番茄酱，芥末，腌椰菜 面包）

# 这是处理汉堡类型的系统，所以需要：
# 定义汉堡类型的名称OrderType
# 定义汉堡类型需要的内容OrderContent
# 字典，但是字典的单项是数组
# 问题：如何转化packed_burger和这个脚本之间的联动
# packed_burger是个Array[BurgerPartStats]的数组，里面的数据是BurgerPartStats
# 存储并print出来的是[<Resource#-9223372003166124730>, <Resource#-9223372003568777920>, <Resource#-9223372003434560190>, <Resource#-9223372003434560190>, <Resource#-9223372003300342460>]
# 类型的数据
# ————————>
# 需要做基于BurgerPartStats类的数据匹配
# 或许可以在BurgerPartStats写新的const，把string转换成int

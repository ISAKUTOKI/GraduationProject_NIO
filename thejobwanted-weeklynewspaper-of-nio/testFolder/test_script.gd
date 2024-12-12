extends Node2D
#这是一条用来学习的脚本，没有任何实际作用

#变量
#enum	枚举
#bool	布尔
#variable	几乎可以存储任何类型
#var	几乎可以存储任何类型
#float	浮点数
#int	整数
#const	常量
#string	字符串
#var 变量名称 : Array = []		数组，可以不同类型，可以嵌套字典或数组
#var 变量名称 : Array[变量类型] = []	数组，强制同类型
#var 变量名称 = {}	字典，内部需要用:给各个键赋予对应的值，键和对应的值可以是任何内容
#var 变量名称 : Dictionary = {}	字典，内部需要用:给各个键赋予对应的值，键和对应的值可以是任何内容
	#字典默认输出键名
	#访问字典
	#dic.键名
	#dic["键名"]

#强制固定变量类型
#变量类型 变量名 : 想要固定为的变量类型 = 值 ;

#函数
#print()		打印，在控制台输出括号内文本
#range()	  从0或者指定的整数开始的，到指定的整数结束的，整数数组
#if()	判断，输入bool值，true时执行
#while()		循环，输入bool值，true时循环
#for 变量名称 : 变量类型 in 可以表示数组含义的内容	 遍历，使"变量名称"的值逐个等于每一个值

#数组和字典函数
#arr.push_front()	在数组开头添加一个元素
#arr.push_back()	 在数组末尾添加一个元素
#arr.append()	在数组末尾添加一个元素
#arr.remove_at()	 去除数组内指定标号位置的元素
#arr.erase()	 去除数组内第一个对应内容的元素
#arr.clear()	 清空数组	 #字典通用
#arr.resize()	重新指定数组长度，从后向前改变
#arr.is_empty()	判断数组是否为空，返回布尔值	#字典通用
#arr.size()	读取数组长度，返回整数	 #字典通用
#dic.has()	寻找字典是否有某个值，返回布尔值
#dic.keys()	查找所有的键名
#dic.values()	查找所有的值

#方法
#func _ready():	开始时运算
#func _process():	每帧运算

#特殊语句
#pass	跳过，占位用
#break	停止，停止循环
#continue	继续，停止此次循环重新开始一次新的循环


func _ready() -> void:
	var arr: Array = [1, 2, "a", 4, "b"]
	print(arr[arr.size() - 1])
	pass


func _process(delta: float) -> void:
	pass

class_name 对信号系统的简单说明
extends Node

# <i><b>内置信号</b></i>
# 信号就是一种方法
# 例如Button节点，具有一个信号：
##func _on_button_pressed() ->void:
##    pass
# 这个信号是当button节点触发了pressed事件时调用这个信号下的内容
# 同样的功能可以用另一种写法实现
# 用 @onready 声明一个只有当脚本初始化时才会被赋值的变量 var button 然后用 get_node() 方法将其赋值为Button节点：
##@onready var button = get_node("Button")
# 之后用 button.pressed.connect(_on_button_pressed) 的方式，将pressed作为参数传递给这个方法
##func _ready() -> void:
##    button.pressed.connect(_on_button_pressed)
# 这里的 pressed 就是一个自定义信号，当button被按下时会发出信号（自定义信号的说明在下方）
# 而当信号接通时pressed传递的是个值为true的bool值，既实现了内置信号的“当按下时调用这个方法”的功能
# （因为只有当preesed时才会连接信号并调用方法所以这个值肯定为true，但不同情况下传递的参数可能是不同的）

# 额外说明
# get_node() 方法需求的参数类型是 string ，与当前脚本挂载的组件所在的节点树中的节点名字对应，改名时可能会丢失值
# 如果需要获取的节点为父节点建议直接使用 get_parent() 方法

# <i><b>自定义信号</b></i>
##signal test_signal
# 用 signal 关键字可以声明信号类型的变量，同时可以向其传参，例如：
##signal attacked
##signal item_dropped(item_name, amount)
# 如果信号有参：
# 	在发出这个信号时必须为其传参
# 	在信号发出时会将信号内的参传递给被这个信号调用的所有Callable的对应值（如果有的话，没有则忽略这个参）
# connect() 和 disconnect() 和 emit() 这三个是最常用的和信号有关的方法
# 首先说明关键概念：Callable
# 简单来说，这是个可以被调用的东西，比如方法，例如：
##func _when_is_calling() ->void:
##    pass

##connect(Callable的名字)
# 使用方法为 test_signal.connect(...)
# 为一个信号连接一个Callable，当信号被发出时会调用这个Callable
# 一般会在 func _ready() ->void: 中进行connect

##disconnect(Callable的名字)
# 使用方法为 test_signal.disconnect(...)
# 为这个信号取消对一个Callable的连接，但是当这个信号还没有连接过这个Callable时会报错
# 所以一般需要用 is_connected() 方法先进行验证
# （这个是个具有一个bool返回值的方法，当传进去的参数（名字）与这个信号下绑定的Callable对应时为true），例如：
##if test_signal.is_connected（Callable的名字）
##    test_signal.disconnect(Callable的名字)

##emit(signal的需求参数)
# 使用方法为 test_signal.emit(...)
# 它会调用这个信号connect过的所有Callable，并且传参，无参需求则可以不传

# <i><b>以下为对信号使用的简单示例</b></i>

signal is_pressed

@onready var button = get_node("Button")
var i: int = 0


func _ready() -> void:
	is_pressed.connect(_add_one)
	is_pressed.connect(_disconnect_button_signal)


func _add_one() -> void:
	i = i + 1


func _disconnect_button_signal() -> void:
	print("尝试解绑信号")
	if is_pressed.is_connected(_add_one):
		is_pressed.disconnect(_add_one)
	else:
		print("信号不存在")


func _on_button_pressed() -> void:
	is_pressed.emit()
	print(i)

# 以上内容实现的效果：
# 按下按钮则使i+1，打印出1，同时解绑_add_one方法，再次按下时打印出i但是值不变仍为1

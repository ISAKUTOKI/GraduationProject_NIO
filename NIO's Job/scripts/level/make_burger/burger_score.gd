extends Node

var all_order_list := []
var current_order := []
var current_packed_burger := []
var succeeeded_count: int = 0
var failed_count: int = 0


func _ready() -> void:
	GlobalSignalBus.burger_is_packed.connect(_on_burger_is_packed)
	GlobalSignalBus.burger_order_is_created.connect(_on_burger_order_is_created)
	GlobalSignalBus.burger_order_is_submitted.connect(_on_burger_order_is_submitted)
	GlobalSignalBus.burger_order_succeeded.connect(_on_burger_order_succeeded)
	GlobalSignalBus.burger_order_failed.connect(_on_burger_order_failed)


func _on_burger_is_packed(_array) -> void:
	current_packed_burger = _array


func _on_burger_order_is_created(_array, _position, _z_index) -> void:
	all_order_list.push_back(_array)
	if all_order_list.size() > 0:
		var _order_type: int = all_order_list[0]
		current_order = BurgerOrderStats.OrderContent[_order_type]
		#print("当前订单要求为： ", str(current_order))
	pass


func _on_burger_order_is_submitted(_array) -> void:
	print("当前制作的汉堡为： ", current_packed_burger)
	if current_packed_burger == current_order:
		if current_order == []:
			print("当前已无订单")
			GlobalSignalBus.burger_order_failed.emit()
		else:
			print("成功")
			GlobalSignalBus.burger_order_succeeded.emit()
	else:
		print("失败")
		GlobalSignalBus.burger_order_failed.emit()
	GlobalSignalBus.burger_is_ok_to_clear.emit()


func _on_burger_order_succeeded() -> void:
	succeeeded_count += 1
	if all_order_list.size() > 0:
		all_order_list.remove_at(0)
		if all_order_list.size() > 0:
			current_order = BurgerOrderStats.OrderContent[all_order_list[0]]
			#print("当前订单要求为： ", str(current_order))
		else:
			print("结束了最后一个订单")


func _on_burger_order_failed() -> void:
	failed_count += 1
	#print("当前订单要求为： ", str(current_order))
	pass

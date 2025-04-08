extends Node

var all_order_list := []
var current_order := []
var current_packed_burger := []


func _ready() -> void:
	GlobalSignalBus.burger_is_packed.connect(_on_burger_is_packed)
	GlobalSignalBus.burger_order_is_created.connect(_on_burger_order_is_created)
	GlobalSignalBus.burger_order_is_submitted.connect(_on_burger_order_is_submitted)
	GlobalSignalBus.burger_order_succeeded.connect(_on_burger_order_succeeded)


func _on_burger_is_packed(_array) -> void:
	current_packed_burger = _array
	pass


func _on_burger_order_is_created(_array, _position, _z_index) -> void:
	all_order_list.push_back(_array)
	if all_order_list.size() > 0:
		var _order_type: int = all_order_list[0]
		current_order = BurgerOrderStats.OrderContent[_order_type]
	pass


func _on_burger_order_is_submitted(_array) -> void:
	if current_packed_burger == current_order:
		print("成功")
		GlobalSignalBus.burger_order_succeeded.emit()
	else:
		print("失败")
		GlobalSignalBus.burger_order_failed.emit()
		pass
	pass


func _on_burger_order_succeeded() -> void:
	if all_order_list.size() > 0:
		all_order_list.remove_at(0)

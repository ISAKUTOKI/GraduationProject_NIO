extends Node

@export var order: PackedScene
var order_list: Array[Node2D] = []
var order_type: BurgerOrderStats.OrderType

@export var create_offset: Vector2 = Vector2(10, 0)
var initialize_position: Vector2 = Vector2(249, 14)
var create_position: Vector2
var create_z_index: int


func _ready() -> void:
	GlobalSignalBus.burger_order_succeeded.connect(_on_burger_order_succeeded)


func _create_order(_is_random: bool = true, _designated_type_number: int = -1) -> void:
# 合法性检测————————————————————
	if order:
		var _order = order.instantiate() as BurgerOrder
		add_child(_order)
		order_list.push_back(_order)
	else:
		return
# 计算位置————————————————————
	_calculate_create_position()
# 随机或指定 订单类型————————————————————
	if _is_random:
		var random_order_type_number: int = randi() % BurgerOrderStats.OrderType.size()
		order_type = BurgerOrderStats.OrderType.values()[random_order_type_number]
		GlobalSignalBus.burger_order_is_created.emit(order_type, create_position, create_z_index)
	else:
		if _designated_type_number == -1:
			print("为指定类型订单，但是没有赋值")
		else:
			order_type = BurgerOrderStats.OrderType.values()[_designated_type_number]
			GlobalSignalBus.burger_order_is_created.emit(_designated_type_number, create_position, create_z_index)


func _calculate_create_position() -> void:
	create_position = initialize_position + create_offset * order_list.size()
	create_z_index = order_list.size() * -1
	#print("create_position ", create_position)


func _on_button_pressed() -> void:
	_create_order()
	pass  # Replace with function body.


func _on_burger_order_succeeded() -> void:
	if order_list.size() > 0:
		var order_to_remove = order_list.pop_front()
		order_to_remove.queue_free()

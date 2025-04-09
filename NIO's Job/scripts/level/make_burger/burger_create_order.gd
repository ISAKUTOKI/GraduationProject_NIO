extends Node

@export var order: PackedScene
var order_list: Array[Node2D] = []
var order_type: BurgerOrderStats.OrderType

@export var create_offset: Vector2 = Vector2(10, 0)
var initialize_position: Vector2 = Vector2(249, 14)
var create_position: Vector2
var create_z_index: int


func _on_button_pressed() -> void:
	_create_order()


func _ready() -> void:
	GlobalSignalBus.burger_order_succeeded.connect(_on_burger_order_succeeded)


func _create_order(_is_random: bool = true, _designated_type_number: int = -1) -> void:
	if order:
		var _order = order.instantiate() as BurgerOrder
		add_child(_order)
		order_list.push_back(_order)
	else:
		return

	_calculate_create_position()

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

	_rank_burger_order()

	print("新创建的订单种类为：", BurgerOrderStats.OrderType.keys()[order_type])
	print("新创建的订单要求为：", BurgerOrderStats.OrderContent[order_type])


func _calculate_create_position() -> void:
	create_position = initialize_position + create_offset * order_list.size()
	create_z_index = order_list.size() * -1


func _rank_burger_order() -> void:
	# 清理无效节点
	order_list = order_list.filter(func(node): return is_instance_valid(node))

	if order_list.is_empty():
		return

	# 创建并行Tween
	var tween = get_tree().create_tween().set_parallel(true)

	for i in order_list.size():
		var node = order_list[i]
		var target_position = initialize_position + create_offset * (i + 1)

		node.z_index = i * -1

		tween.tween_property(node, "position", target_position, 0.05)

	print("当前共有 ", order_list.size()," 个订单")


func _on_burger_order_succeeded() -> void:
	if order_list.size() > 0:
		var order_to_remove = order_list.pop_front()
		if is_instance_valid(order_to_remove):
			order_to_remove.queue_free()
		_rank_burger_order()

extends Node

@onready var button: Button = $Button

@export var can_use_button: bool = false
@export var order: PackedScene

# 对订单进行记录的变量
var order_list: Array[Node2D] = []
var order_type: BurgerOrderStats.OrderType

# 创建订单相关的变量
@export var create_offset: Vector2 = Vector2(10, 0)
var initialize_position: Vector2 = Vector2(249, 14)
var create_position: Vector2
var create_z_index: int
var current_tween: Tween = null


func _ready() -> void:
	GlobalSignalBus.burger_create_order.connect(_on_burger_create_order)
	GlobalSignalBus.burger_order_succeeded.connect(_on_burger_order_succeeded)
	button.visible = can_use_button


func _on_button_pressed() -> void:
	if can_use_button:
		create_order()


func _on_burger_create_order(_bool: bool, _int: int) -> void:
	create_order(_bool, _int)


func create_order(_is_random: bool = true, _designated_type_number: int = -1) -> void:
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
			print("此订单为指定类型订单，但是没有赋值")
		else:
			order_type = BurgerOrderStats.OrderType.values()[_designated_type_number]
			GlobalSignalBus.burger_order_is_created.emit(_designated_type_number, create_position, create_z_index)

	_rank_burger_order()
	print("新创建的订单种类为：", BurgerOrderStats.OrderName[order_type])
	#print("新创建的订单要求为：", BurgerOrderStats.OrderContent[order_type])


func _calculate_create_position() -> void:
	create_position = initialize_position + create_offset * order_list.size()
	create_z_index = order_list.size() * -1


func _rank_burger_order() -> void:
# 合法性检测————————————————————
	if current_tween:
		current_tween.kill()
	if order_list.is_empty():
		return
	order_list = order_list.filter(func(node): return is_instance_valid(node) and not node.is_queued_for_deletion())
# 通过tween创建订单的移动————————————————————
	current_tween = get_tree().create_tween().set_parallel(true)
	for i in order_list.size():
		var node = order_list[i]
		if not is_instance_valid(node):
			continue
		var target_pos = initialize_position + create_offset * (i)  # 关键修改：i代替i+1
		node.z_index = i * -1
		current_tween.tween_property(node, "position", target_pos, 0.07)


func _on_burger_order_succeeded() -> void:
	if order_list.is_empty():
		return
	var order_to_remove = order_list.pop_front()
	if is_instance_valid(order_to_remove):
		order_to_remove.queue_free()
# 延迟一帧确保节点完全释放————————————————————
	await get_tree().process_frame
	_rank_burger_order()

extends Node

@onready var button: Button = $Button

@export var can_use_button: bool = false
@export var order: PackedScene

# 对订单进行记录的变量
var order_list: Array[Node2D] = []
var order_type: BurgerOrderStats.OrderType

# 创建订单相关的变量
@export var create_offset: Vector2 = Vector2(10, 0)
@export var initialize_position: Vector2 = Vector2(340, 14)
var first_position: Vector2 = Vector2(249, 14)
var create_target_position: Vector2
var create_target_z_index: int


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
		_order.position = initialize_position
		order_list.push_back(_order)
	else:
		return

	_calculate_create_position()

	if _is_random:
		var random_order_type_number: int = randi() % BurgerOrderStats.OrderType.size()
		order_type = BurgerOrderStats.OrderType.values()[random_order_type_number]
		GlobalSignalBus.burger_order_is_created.emit(order_type, create_target_position, create_target_z_index)
	else:
		if _designated_type_number == -1:
			push_error("此订单为指定类型订单，但是没有赋值")
		else:
			order_type = BurgerOrderStats.OrderType.values()[_designated_type_number]
			GlobalSignalBus.burger_order_is_created.emit(_designated_type_number, create_target_position, create_target_z_index)

	_rank_burger_order()
	#print("新创建的订单种类为：", BurgerOrderStats.OrderName[order_type])
	#print("新创建的订单要求为：", BurgerOrderStats.OrderContent[order_type])


func _calculate_create_position() -> void:
	create_target_position = first_position + create_offset * order_list.size()
	create_target_z_index = order_list.size() * -1


func _rank_burger_order() -> void:
# 数组记录————————————————————
	order_list = order_list.filter(func(_order): return is_instance_valid(_order))
	#print(order_list[order_list.size()-1].position)
	for i in order_list.size():
		var _order = order_list[i]
		if not is_instance_valid(_order):
			#print("一个continue断点检测")
			continue
# 计算排序位置————————————————————
		var _target_pos = first_position + create_offset * i
		var tween = create_tween()
		tween.tween_property(_order, "position", _target_pos, 0.1)
# 计算z索引————————————————————
		_order.z_index = (i + 1) * -1
	#print(order_list[order_list.size()-1].position)


func _on_burger_order_succeeded() -> void:
	if order_list.is_empty():
		return
	var order_to_remove = order_list.pop_front()
	if is_instance_valid(order_to_remove):
		order_to_remove.queue_free()
# 延迟一帧确保节点完全释放————————————————————
	await get_tree().process_frame
	_rank_burger_order()

class_name BurgerCreateBurgerParts
extends Node

@export var burger_part: PackedScene
var can_create_burger: bool = false

# 记录汉堡相关
var last_packed_part_type: BurgerPartStats
var last_packed_part_position: Vector2
var packed_burger: Array[int] = []
var burger_part_list: Array[Node2D] = []

# 位置相关
var y_offset: Vector2
var initialize_position: Vector2 = Vector2(72, 16)
var target_position: Vector2
var bottom_position: Vector2 = Vector2(72, 144)
var shadow_position: Vector2
@export var use_random_x_offset: bool = true

@onready var shadow: Sprite2D = $"../Shadow"


func _ready() -> void:
	last_packed_part_position = bottom_position
	shadow.modulate = Color(1, 1, 1, 0)
	GlobalSignalBus.burger_is_ready_for_start_stage.connect(_on_burger_is_ready_for_start_stage)
	GlobalSignalBus.burger_part_is_picked.connect(_on_burger_part_is_picked)
	GlobalSignalBus.burger_is_ok_to_clear.connect(_on_burger_is_ok_to_clear)


func _on_burger_is_ready_for_start_stage() -> void:
	can_create_burger = true


func _on_burger_is_ok_to_clear() -> void:
	_clear_all_burger_parts_on_table()


func _on_burger_part_is_picked(_picked_type: BurgerPartStats) -> void:
	_create_burger_part(_picked_type)


func _create_burger_part(_type: BurgerPartStats) -> void:
	if not can_create_burger:
		return
# 创造汉堡部件————————————————————
	if burger_part:
		var _part = burger_part.instantiate() as BurgerPart
		add_child(_part)
		burger_part_list.push_back(_part)
	else:
		return
# 计算位置————————————————————
	_calculate_create_position()
	_create_shadow()
# 增加汉堡数组————————————————————
	last_packed_part_type = _type
	var last_packed_part_type_number: int = BurgerPartStats.PartTypeNumber[_type.type]
	packed_burger.push_back(last_packed_part_type_number)
	#print(str(packed_burger))
# 创造汉堡————————————————————
	GlobalSignalBus.burger_part_is_created.emit(_type, initialize_position, target_position)
	GlobalSignalBus.burger_is_packed.emit(packed_burger)
	#print("发出了信号 burger_part_is_created")


func _calculate_create_position() -> void:
	var _random_x_offset: int
	if use_random_x_offset:
		_random_x_offset = randi_range(-3, 3)
	else:
		_random_x_offset = 0

	if last_packed_part_type != null:
		y_offset = BurgerPartStats.CreateOffset[last_packed_part_type.type]
	target_position = Vector2(initialize_position.x + _random_x_offset, last_packed_part_position.y + -y_offset.y)
	last_packed_part_position = Vector2(initialize_position.x, target_position.y)


func _create_shadow() -> void:
	if packed_burger.size() == 0:
		var timer = get_tree().create_timer(0.15)
		await timer.timeout
		# 关键修改：添加阴影节点有效性检查
		if not is_instance_valid(shadow):
			return
		var tween = get_tree().create_tween()
		shadow.position = target_position + Vector2(0, 5)
		tween.tween_property(shadow, "modulate", Color(1, 1, 1, 1), 0.1)


func _clear_all_burger_parts_on_table() -> void:
	for i in range(burger_part_list.size() - 1, -1, -1):
		burger_part_list[i].queue_free()
	burger_part_list.clear()
	packed_burger.clear()
	shadow.modulate = Color(1, 1, 1, 0)
	last_packed_part_position = bottom_position
	#print("清除了桌面的汉堡")
	print("————————————————————")

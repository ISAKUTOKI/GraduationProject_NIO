extends Node

@export var burger_part: PackedScene

var last_packed_burger_part: BurgerPartStats
var packed_burger_part: Array[BurgerPartStats] = []

var offset: Vector2
var initialize_position: Vector2 = Vector2(72, 16)
var target_position: Vector2
var bottom_position: Vector2 = Vector2(72, 144)


func _ready() -> void:
	GlobalSignalBus.burger_part_is_picked.connect(_on_burger_part_is_picked)


func _on_burger_part_is_picked(_picked_type: BurgerPartStats) -> void:
	_create_burger_part(_picked_type)


func _create_burger_part(_type) -> void:
# 创造汉堡部件————————————————————
	if burger_part:
		var _part = burger_part.instantiate() as BurgerPart
		add_child(_part)
# 增加汉堡数组，计算位置————————————————————
	last_packed_burger_part = _type
	packed_burger_part.push_back(last_packed_burger_part)
	_calculate_create_position()
# 创造汉堡————————————————————
	GlobalSignalBus.burger_part_is_created.emit(_type, initialize_position, target_position)
	#print("发出了信号 burger_part_is_created")


func _calculate_create_position() -> void:
	target_position = bottom_position + ((packed_burger_part.size() - 1) * offset)

	pass

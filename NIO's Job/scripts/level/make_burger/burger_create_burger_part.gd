extends Node

@export var burger_part: PackedScene

# 记录汉堡相关
var last_packed_part_type: BurgerPartStats
var last_packed_part_position: Vector2
var packed_burger: Array[BurgerPartStats] = []

# 位置相关
var y_offset: Vector2
var initialize_position: Vector2 = Vector2(72, 16)
var target_position: Vector2
var bottom_position: Vector2 = Vector2(72, 144)
var shadow_position: Vector2

@onready var shadow: Sprite2D = $"../Shadow"


func _ready() -> void:
	last_packed_part_position = bottom_position
	GlobalSignalBus.burger_part_is_picked.connect(_on_burger_part_is_picked)


func _on_burger_part_is_picked(_picked_type: BurgerPartStats) -> void:
	_create_burger_part(_picked_type)


func _create_burger_part(_type) -> void:
# 创造汉堡部件————————————————————
	if burger_part:
		var _part = burger_part.instantiate() as BurgerPart
		add_child(_part)
# 计算位置————————————————————
	_calculate_create_position()
	_create_shadow()
# 增加汉堡数组————————————————————
	last_packed_part_type = _type
	packed_burger.push_back(last_packed_part_type)
# 创造汉堡————————————————————
	GlobalSignalBus.burger_part_is_created.emit(_type, initialize_position, target_position)
	#print("发出了信号 burger_part_is_created")


func _calculate_create_position() -> void:
	if last_packed_part_type != null:
		y_offset = BurgerPartStats.CreateOffset[last_packed_part_type.type]
	target_position = last_packed_part_position + -y_offset
	last_packed_part_position = target_position
	pass


func _create_shadow() -> void:
	if packed_burger.size() == 0:
		var timer = get_tree().create_timer(0.15)
		await timer.timeout
		shadow.position = target_position + Vector2(0, 5)

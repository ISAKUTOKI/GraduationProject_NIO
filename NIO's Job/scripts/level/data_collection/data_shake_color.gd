extends Node

@export var target: Node2D
@export_range(0, 100) var affected_distance: float = 45
@export var max_position_shake := Vector2(0.2, 0.4)
@export var max_rotation_shake: float = 7
@export var shake_speed: float = 20
@export var number_color: Color
@export_range(0, 1.0) var min_alpha: float = 0.11

var original_position: Vector2  # 存储初始位置
var original_rotation: float  # 存储初始旋转
var shake_phase: float = randf() * 100.0  # 随机初始相位
var distance_to_mouse: float
var is_picked: bool = false

var can_start_process: bool = false


func _ready() -> void:
	target.number_is_ready.connect(_on_number_is_ready)
	target.number_is_picked.connect(on_number_is_picked)
	target = get_parent()


func _process(delta: float) -> void:
	if can_start_process:
		if not is_picked:
			_get_mouse_distance()
			_change_alpha()
			_shake_number(delta)


func _on_number_is_ready() -> void:
	original_position = target.global_position
	original_rotation = target.rotation_degrees
	can_start_process = true


func on_number_is_picked() -> void:
	is_picked = true


func _get_mouse_distance() -> void:
	distance_to_mouse = (target.global_position - target.get_global_mouse_position()).length()


func _change_alpha() -> void:
	var _alpha = clamp(1.0 - (distance_to_mouse / affected_distance), min_alpha, 1.0)
	target.modulate = Color(number_color.r, number_color.g, number_color.b, _alpha)


# 震动数字的方法
func _shake_number(_delta) -> void:
	var strength = clamp(1.0 - distance_to_mouse / affected_distance, 0.0, 1.0)
	if strength > 0:
		shake_phase += _delta * shake_speed
# 进行震动————————————————————
		var pos_shake = Vector2(sin(shake_phase * 1.2) * max_position_shake.x, cos(shake_phase * 0.8) * max_position_shake.y) * strength
		var rot_shake = sin(shake_phase * 1.5) * max_rotation_shake * strength
		#print("赋值前的位置为： " + str(target.position))
		#print("初始位置值为： " + str(original_position))
		target.position = original_position + pos_shake
		target.rotation_degrees = original_rotation + rot_shake
		#print("赋值后的位置为： " + str(target.position))
		#print("断点占位")
	else:
# 回到初始状态————————————————————
		target.position = original_position
		target.rotation_degrees = original_rotation

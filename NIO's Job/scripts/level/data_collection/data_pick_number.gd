extends Node

@export var target: Area2D
@export var target_position: Vector2 = Vector2(275, 134)
@export var pick_move_offset: Vector2 = Vector2(-5, -5)
@export var pick_move_time: float = 0.2
@export var send_move_time: float = 0.5

var can_pick: bool = false
var is_picked: bool = false
var _score_is_full: bool = false


func _ready() -> void:
	GlobalSignalBus.data_score_is_full.connect(on_data_score_is_full)


func _process(_delta: float) -> void:
	if _score_is_full:
		return
	if can_pick and Input.is_action_pressed("click"):
		GlobalSignalBus.data_number_is_picked.emit()
		target.number_is_picked.emit()
		_move_number_to_folder()


func on_data_score_is_full() -> void:
	_score_is_full = true


func _move_number_to_folder() -> void:
# 保证只执行一次————————————————————
	if is_picked:
		return
	is_picked = true
# 向左上移动————————————————————
	var tween1 = create_tween()
	tween1.tween_property(target, "position", target.position + pick_move_offset, pick_move_time)
	await tween1.finished
# 向目标移动————————————————————
	var tween2 = create_tween()
	tween2.tween_property(target, "position", target_position, send_move_time)
	await tween2.finished
# 参数有效性检查————————————————————
	if target.last_position:
		GlobalSignalBus.data_gain_score.emit(target.last_number, target.last_position)
	else:
		print("得分参数不全")
	target.queue_free()


func turn_to_can_pick() -> void:
	can_pick = true


func turn_to_cant_pick() -> void:
	can_pick = false

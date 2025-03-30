extends Node

@export var target: Area2D
@export var target_folder: Node2D
@export var pick_move_direction: Vector2 = Vector2(-5, -5)
@export var pick_move_duration: float = 0.5

var can_pick: bool = false
var is_picked: bool = false


func _ready() -> void:
	target.mouse_entered.connect(_on_mouse_entered)
	target.mouse_exited.connect(_on_mouse_exited)


func _process(delta: float) -> void:
	if can_pick and Input.is_action_just_pressed("click"):
		GlobalSignalBus.data_number_is_picked.emit()
		is_picked = true

	if is_picked:
		_move_number_to_folder(delta)



func _move_number_to_folder(_delta) -> void:
	pass


func _on_mouse_entered() -> void:
	can_pick = true


func _on_mouse_exited() -> void:
	can_pick = false

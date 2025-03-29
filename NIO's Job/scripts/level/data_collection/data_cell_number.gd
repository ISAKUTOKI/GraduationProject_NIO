class_name DataCellNumber
extends Area2D

@onready var content: Label = $Label
signal number_is_ready

func _ready() -> void:
	_initialize_number()


func _initialize_number(number: int = 42) -> void:
# 设置数字————————————————————
	if number != 42:
		content.text = str(number)
	else:
		var random_number = randi() % 10  # 0-9
		content.text = str(random_number)
# 设置旋转————————————————————
	rotation_degrees = randf_range(-7, 7)
	number_is_ready.emit()

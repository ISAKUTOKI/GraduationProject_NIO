class_name DataCellNumber
extends Area2D

@onready var outline_highlighter: OutlineHighlighter = $OutlineHighlighter
@onready var content: Label = $visuals/Label
signal number_is_ready



func _ready() -> void:
	self.add_to_group("data_number")
	


func initialize_number(number: int = 42) -> void:
# 设置数字————————————————————
	if number != 42:
		content.text = str(number)
	else:
		var random_number = randi() % 10  # 0-9
		content.text = str(random_number)
# 设置旋转————————————————————
	rotation_degrees = randf_range(-7, 7)
	number_is_ready.emit()


func _on_mouse_entered() -> void:
	outline_highlighter.highlight()
	
	#print("鼠标进入数字")


func _on_mouse_exited() -> void:
	outline_highlighter.clear_highlight()

	#print("鼠标离开数字")

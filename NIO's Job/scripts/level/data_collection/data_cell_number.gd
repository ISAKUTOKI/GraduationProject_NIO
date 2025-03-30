class_name DataCellNumber
extends Area2D

@onready var shake_and_color: Node = $ShakeAndColor
@onready var pick_number: Node = $PickNumber
@onready var outline_highlighter: OutlineHighlighter = $OutlineHighlighter
@onready var content: Label = $visuals/Label
var last_number: int
var last_position: Vector2

signal number_is_ready
@warning_ignore("unused_signal")
signal number_is_picked


func _ready() -> void:
	self.add_to_group("data_number")


func initialize_number(_number: int = 42) -> void:
# 设置数字————————————————————
	if _number != 42:
		content.text = str(_number)
		last_number = _number
	else:
		var random_number = randi() % 10  # 0-9
		content.text = str(random_number)
# 赋值last_number————————————————————
		last_number = random_number
# 设置旋转————————————————————
	rotation_degrees = randf_range(-7, 7)
	number_is_ready.emit()
# 赋值last_position————————————————————
	last_position = position
# 赋值检查————————————————————
	if last_position:
		pass
	else:
		print("位置或数字 没有成功赋值")


func _on_mouse_entered() -> void:
	outline_highlighter.highlight()
	pick_number.turn_to_can_pick()
	#print("鼠标进入数字")


func _on_mouse_exited() -> void:
	outline_highlighter.clear_highlight()
	pick_number.turn_to_cant_pick()
	#print("鼠标离开数字")

extends Node

@onready var outline: BurgerOutlineHighlighter = $OutlineHighlighter
@onready var visuals: CanvasGroup = $Visuals

var mouse_is_in_area: bool = false
var packed_burger := []


func _ready() -> void:
	GlobalSignalBus.burger_is_packed.connect(_on_burger_is_packed)


func _on_mouse_entered() -> void:
	mouse_is_in_area = true
	outline.show_outline()
	visuals.z_index = 1
	pass  # Replace with function body.


func _on_mouse_exited() -> void:
	mouse_is_in_area = false
	outline.hide_outline()
	visuals.z_index = 0
	pass  # Replace with function body.


func _on_burger_is_packed(_array) -> void:
	packed_burger = _array


func _input(event: InputEvent) -> void:
	if mouse_is_in_area and event.is_action_pressed("select"):
		_submit_order()


func _submit_order() -> void:
	GlobalSignalBus.burger_order_is_submitted.emit(packed_burger)
	#print("提交了")
	_clear_burger_pack()


func _clear_burger_pack() -> void:
	packed_burger.clear()

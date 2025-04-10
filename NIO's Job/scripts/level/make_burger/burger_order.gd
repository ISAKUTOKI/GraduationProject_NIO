@tool
class_name BurgerOrder
extends Area2D

@onready var visuals: CanvasGroup = $Visuals
@onready var sprite: Sprite2D = $Visuals/Sprite2D
@onready var outline: BurgerOutlineHighlighter = $OutlineHighlighter
@onready var label: Label = $Visuals/Label

var order_content := []
var target_z_index: int

var mouse_is_in_area: bool = false


func _ready() -> void:
	GlobalSignalBus.burger_order_is_created.connect(_initialize)
	#await outline.ready
	outline.set_new_color(Color(0, 0, 0, 1))


func _process(_delta: float) -> void:
	label.text = str(z_index)


func _initialize(_type: BurgerOrderStats.OrderType, _position: Vector2, _z_index: int) -> void:
	self.add_to_group("burger_orders")
	order_content = BurgerOrderStats.OrderContent[_type]
	if BurgerOrderStats.OrderSprite[_type]:
		sprite.texture = load(BurgerOrderStats.OrderSprite[_type])
	position = _position
	target_z_index = _z_index
	z_index = target_z_index
	#print("新创建订单的z_index为： ", z_index)
	GlobalSignalBus.burger_order_is_created.disconnect(_initialize)


func _on_mouse_entered() -> void:
	if Engine.is_editor_hint():
		return
	#print("鼠标进入")
	outline.show_outline()
	z_index = 1

	mouse_is_in_area = true


func _on_mouse_exited() -> void:
	if Engine.is_editor_hint():
		return
	#print("鼠标离开")
	outline.hide_outline()
	z_index = target_z_index

	mouse_is_in_area = false

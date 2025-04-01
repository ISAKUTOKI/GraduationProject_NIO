@tool
extends Area2D

@export var stats: BurgerPartStats:
	set = _set_stats

@onready var sprite: Sprite2D = $Visuals/Sprite2D
@onready var visuals: CanvasGroup = $Visuals
@onready var outline: BurgerOutlineHighlighter = $OutlineHighlighter

var mouse_is_in_area: bool = false


func _ready() -> void:
	if Engine.is_editor_hint():
		return


func _input(event: InputEvent) -> void:
	if mouse_is_in_area and event.is_action_pressed("select"):
		#print("鼠标在区域内按下了 select 键")
		GlobalSignalBus.burger_part_is_picked.emit(stats)
		#print(str(stats.type) + " 的 burger_part_is_picked 信号发出了")


func _set_stats(_value: BurgerPartStats) -> void:
	stats = _value
	if _value == null:
		return
	if not is_node_ready():
		await ready

	sprite.texture = load(BurgerPartStats.UnusedPartSprite[stats.type])

	sprite.position = Vector2(160, 90)


func _on_mouse_entered() -> void:
	if Engine.is_editor_hint():
		return
	#print("鼠标进入")
	outline.show_outline()
	visuals.z_index = 1

	mouse_is_in_area = true


func _on_mouse_exited() -> void:
	if Engine.is_editor_hint():
		return
	#print("鼠标离开")
	outline.hide_outline()
	visuals.z_index = 0

	mouse_is_in_area = false

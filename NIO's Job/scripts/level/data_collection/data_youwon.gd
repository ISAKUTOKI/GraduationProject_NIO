extends Node2D

@export var can_show_this: bool = false


func _ready() -> void:
	GlobalSignalBus.data_score_is_full.connect(_on_data_score_is_full)
	visible = false


func _on_data_score_is_full() -> void:
	if can_show_this:
		visible = true
	else:
		print("你没有资格啊你没有资格，正因为如此你没有资格")

extends Node2D

@export var can_show_this: bool = false


func _ready() -> void:
	GlobalSignalBus.score_is_full.connect(_on_score_is_full)
	visible = false


func _on_score_is_full() -> void:
	if can_show_this:
		visible = true
	else:
		"你没有资格啊你没有资格，正因为如此你没有资格"

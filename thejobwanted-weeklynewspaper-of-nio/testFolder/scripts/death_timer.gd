extends Node

@onready var death_timer: Timer = $"."


func _on_timeout() -> void:
	print("你！复活！")
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
	pass  # Replace with function body.

extends Node

@export var group_name: String = "player"
@export var is_in_test: bool = true


func _ready() -> void:
	add_to_group(group_name)


func kill() -> void:
	print("Nio没了！")
	GlobalSignalBus.player_is_dead.emit()
	queue_free()
	SceneManager.reload_current_scene(1.5)

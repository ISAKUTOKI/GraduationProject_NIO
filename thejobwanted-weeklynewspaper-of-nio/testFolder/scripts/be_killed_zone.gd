extends Node
@onready var slime: Node2D = $".."
@onready var be_killed_zone: Area2D = $"."


func _on_body_entered(body: Node2D) -> void:
	GlobalData.kill_jump_bool = true
	body.get_node("jump_kill_SFX").jump_kill_SFX.play()
	slime.queue_free()

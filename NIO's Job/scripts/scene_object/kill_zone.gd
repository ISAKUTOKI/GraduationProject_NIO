extends Area2D

var target_group: String = "player"


func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(target_group):
		_kill(body)
		print("玩家进入KillZone")


func _kill(body: Node2D) -> void:
	if body.has_method("kill"):
		body.kill()
	else:
		print("KillZone: 对象无法被杀死")

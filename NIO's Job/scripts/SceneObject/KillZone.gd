extends Area2D

@export var target_group: String = "player"

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

# 当有对象进入区域时调用
func _on_body_entered(body: Node2D) -> void:
	# 检查对象是否属于目标组
	if body.is_in_group(target_group):
		_kill_or_reset(body)

# 杀死或重置对象
func _kill_or_reset(body: Node2D) -> void:
	if body.has_method("kill"):  # 如果对象有 kill 方法，调用它
		body.kill()
	else:
		print("KillZone: 对象无法被杀死")

extends Node


func _on_body_entered(body: Node2D) -> void:
	if body != null:  #检测玩家，如果进入就通知
		print_debug("玩家进入KillZone")
		#body.queue_free()

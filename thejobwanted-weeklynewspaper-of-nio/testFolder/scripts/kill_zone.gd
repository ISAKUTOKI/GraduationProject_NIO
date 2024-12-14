extends Area2D

@onready var hurt_SFX: AudioStreamPlayer = $AudioStreamPlayer


func _on_body_entered(body: Node2D) -> void:
	print("YOU DIED...")
	Engine.time_scale = 0.4
	body.get_node("CollisionShape2D").queue_free()  #获取body的碰撞箱节点然后把节点删掉
	body.get_node("death_timer").death_timer.start()
	hurt_SFX.play()

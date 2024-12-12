extends Area2D

@onready var timer: Timer = $Timer
#var canGetLeftTime: bool = false


func _on_body_entered(body: Node2D) -> void:
	print("YOU DIED...")
	Engine.time_scale = 0.4
	body.get_node("CollisionShape2D").queue_free()
	#canGetLeftTime = true
	timer.start()


func _on_timer_timeout() -> void:
	print("你！复活！")
	#canGetLeftTime = false
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()


#func _timerLeft():
	#if(canGetLeftTime):
		#print("Timer time left: ", timer.get_time_left())
#
#
#func _process(delta: float) -> void:
	#_timerLeft()

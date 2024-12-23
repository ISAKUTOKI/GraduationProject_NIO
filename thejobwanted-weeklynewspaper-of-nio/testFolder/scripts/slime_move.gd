extends Node2D

const speed = 60
var direction = 1

@onready var RC_right: RayCast2D = $RayCastRight
@onready var RC_left: RayCast2D = $RayCastLeft
@onready var AnimePlayer: AnimatedSprite2D = $AnimatedSprite2D


func _process(delta: float) -> void:
	if RC_right.is_colliding():
		_flipLeft()
	if RC_left.is_colliding():
		_flipRight()
	position.x += direction * speed * delta


func _flipLeft():
	AnimePlayer.flip_h = true
	direction = 0
	direction = -1

func _flipRight():
	AnimePlayer.flip_h = false
	direction = 0
	direction = 1

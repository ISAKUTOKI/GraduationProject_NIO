extends Node

var isMoving: bool = false
var canMove: bool = true


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if canMove:
		_move()


func _move() -> void:
	if Input.is_action_pressed("move_up"):
		$AnimatedSprite2D.play("B_walk")
	elif Input.is_action_pressed("move_down"):
		$AnimatedSprite2D.play("F_walk")
	elif Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.play("L_walk")
	elif Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.play("R_walk")

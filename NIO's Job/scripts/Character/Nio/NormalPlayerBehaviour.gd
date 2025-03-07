extends Node2D

@export var group_name: String = "player"

# 移动相关变量
@export var moveSpeed: int = 100
var velocity: Vector2 = Vector2.ZERO
var isMoving: bool = false
var canMove: bool = true
var last_direction: String = "down"


func _ready() -> void:
	$AnimatedSprite2D.play("F_idle")
	add_to_group(group_name)


func _process(delta: float) -> void:
	if canMove:
		_move(delta)


func _move(delta: float) -> void:
	velocity = Vector2.ZERO #为了在没有输入的时候停止移动
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		last_direction = "up"
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		last_direction = "down"
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		last_direction = "left"
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		last_direction = "right"

	if velocity == Vector2.ZERO:
		isMoving = false
		match last_direction:
			"up":
				if $AnimatedSprite2D.animation != "B_idle":
					$AnimatedSprite2D.play("B_idle")
			"down":
				if $AnimatedSprite2D.animation != "F_idle":
					$AnimatedSprite2D.play("F_idle")
			"left":
				if $AnimatedSprite2D.animation != "L_idle":
					$AnimatedSprite2D.play("L_idle")
			"right":
				if $AnimatedSprite2D.animation != "R_idle":
					$AnimatedSprite2D.play("R_idle")
	else:
		isMoving = true
		velocity = velocity.normalized() * moveSpeed
		position += velocity * delta

		# 根据移动方向播放动画
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				$AnimatedSprite2D.play("R_walk")
			else:
				$AnimatedSprite2D.play("L_walk")
		else:
			if velocity.y > 0:
				$AnimatedSprite2D.play("F_walk")
			else:
				$AnimatedSprite2D.play("B_walk")

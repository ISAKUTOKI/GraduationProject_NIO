extends Node

@onready var target: CharacterBody2D = get_parent() as CharacterBody2D
@onready var animator: AnimatedSprite2D = $"../Animator"

# 移动相关变量
@export var move_speed: int = 100
var velocity: Vector2 = Vector2.ZERO
var is_moving: bool = false
var can_move: bool = true
var last_direction: String = "down"


func _ready() -> void:
	GlobalSignalBus.interaction_started.connect(_on_interaction_started)
	GlobalSignalBus.interaction_ended.connect(_on_interaction_ended)


func _process(delta: float) -> void:  # 移动监测
	if can_move:
		_move(delta)


#region 当互动时无法移动
func _on_interaction_started(_interact_type = null):
	can_move = false
	match last_direction:
		"up":
			$"../Animator".play("B_idle")
		"down":
			$"../Animator".play("F_idle")
		"left":
			$"../Animator".play("L_idle")
		"right":
			$"../Animator".play("R_idle")


func _on_interaction_ended():
	can_move = true


#endregion


#region 移动行为逻辑
func _move(delta: float) -> void:
	if not can_move:
		return
	velocity = Vector2.ZERO  # 为了在没有输入的时候停止移动
# 通过按键控制速度速度————————————————————
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
# 通过最后移动方向切换停止移动时的待机动画（默认为down）————————————————————
	if velocity == Vector2.ZERO:
		is_moving = false
		match last_direction:
			"up":
				if animator.animation != "B_idle":
					animator.play("B_idle")
			"down":
				if animator.animation != "F_idle":
					animator.play("F_idle")
			"left":
				if animator.animation != "L_idle":
					animator.play("L_idle")
			"right":
				if animator.animation != "R_idle":
					animator.play("R_idle")
# 移动————————————————————
	else:
		is_moving = true
		velocity = velocity.normalized() * move_speed
		target.position += velocity * delta
# 根据移动方向播放动画————————————————————
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				animator.play("R_walk")
			else:
				animator.play("L_walk")
		else:
			if velocity.y > 0:
				animator.play("F_walk")
			else:
				animator.play("B_walk")
#endregion

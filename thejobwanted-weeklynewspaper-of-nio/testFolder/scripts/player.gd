extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const LITTLE_JUMP_VELOCITY = -100
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	#不在地面时给予重力
	if not is_on_floor():
		velocity += get_gravity() * delta

	#如果输入跳跃便给予向上的力
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#踩头杀怪
	#进入怪头顶的碰撞箱后往上跳跃一小段
	if GlobalData.kill_jump_bool:
		velocity.y = LITTLE_JUMP_VELOCITY
		GlobalData.kill_jump_bool = false

	#声明一个方向变量
	var direction := Input.get_axis("move_left", "muve_right")

	#转向
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	#控制动画
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	#移动
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

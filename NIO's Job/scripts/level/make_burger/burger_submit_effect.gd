extends Node

@onready var normal_hand: Sprite2D = $NormalHand
@onready var bang_hand: Sprite2D = $BangHand
@onready var push_hand: Sprite2D = $PushHand
@onready var final_burger: Sprite2D = $FinalBurger

var tween: Tween

var bang_start_pos: Vector2
var bang_end_pos: Vector2
var push_start_pos: Vector2
var push_end_pos: Vector2


func _ready() -> void:
	normal_hand.visible = false
	bang_hand.visible = false
	push_hand.visible = false
	final_burger.visible = false

	GlobalSignalBus.burger_part_is_created.connect(_on_burger_part_is_created)
	GlobalSignalBus.burger_order_succeeded.connect(_on_burger_order_succeeded)
	GlobalSignalBus.burger_order_failed.connect(_on_burger_order_failed)


func _on_burger_part_is_created(_type, from: Vector2, to: Vector2) -> void:
	_calculate_start_position(from, to)


func _on_burger_order_succeeded() -> void:
	_bang()


func _on_burger_order_failed() -> void:
	pass


func _bang() -> void:
# 出现手————————————————————
	bang_hand.position = bang_start_pos
	bang_hand.visible = true
# 合法性检测并创建tween————————————————————
	if tween:
		tween.kill()
	tween = create_tween().set_parallel()
# 动画————————————————————
	tween.tween_property(bang_hand, "position", bang_end_pos, 0.2)
	await tween.finished
	_show_final_burger(bang_end_pos + Vector2(0, 5))  # 出现final_burger，并往下
	await get_tree().create_timer(0.15).timeout  # 让手悬停一会
# 手消失————————————————————
	bang_hand.visible = false
	await get_tree().create_timer(0.2).timeout  # 等一会再push
	_push()


func _push() -> void:
# 出现手————————————————————
	push_hand.position = push_start_pos
	push_hand.visible = true
# 合法性检测并创建tween————————————————————
	if tween:
		tween.kill()
	tween = create_tween().set_parallel(true)
# 动画————————————————————
	tween.tween_property(push_hand, "position", push_end_pos, 0.5)
	tween.tween_property(final_burger, "position", push_end_pos, 0.5).set_delay(0.1)
	await tween.finished
# 手和汉堡消失————————————————————
	push_hand.visible = false
	_hide_final_burger()


func _show_final_burger(show_pos: Vector2) -> void:
	final_burger.position = show_pos
	final_burger.visible = true


func _hide_final_burger() -> void:
	final_burger.visible = false


func _calculate_start_position(from_pos: Vector2, to_pos: Vector2) -> void:
	bang_start_pos = from_pos
	bang_end_pos = Vector2(to_pos.x, to_pos.y+10)  # y定为14
	push_start_pos = Vector2(bang_end_pos.x + 100, bang_end_pos.y)  # 往右5像素
	push_end_pos = Vector2(bang_end_pos.x - 300, push_start_pos.y)


func _on_test_button_button_down() -> void:
	_calculate_start_position(Vector2(72,16), Vector2(72,144))
	_bang()
	pass  # Replace with function body.

extends Camera2D

@export var is_in_test: bool = false
var target: CharacterBody2D
var group_name: String = "player"
var current_scene_have_player: bool = false
@export var camera_move_speed: float = 5


func _ready():
	_try_to_find_player()
	GlobalSignalBus.player_is_dead.connect(_on_target_destroyed)


func _process(delta: float) -> void:
	if current_scene_have_player:
		_try_to_follow_player()
	else:
		if is_in_test:
			try_to_move_camera_by_keyboard(delta)


#region 寻找并跟踪玩家
func _try_to_find_player():
	var players = get_tree().get_nodes_in_group(group_name)
	if players.size() > 0:
		target = players[0]
		current_scene_have_player = true
	else:
		#print("当前场景没有目标： ", group_name)
		current_scene_have_player = false


func _try_to_follow_player(_speed: float = 0.1):
	if target:
		position = position.lerp(target.position, _speed)


func _on_target_destroyed():
	target = null


#endregion


func try_to_move_camera_by_keyboard(_delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		position += Vector2(1, 0) * _delta * camera_move_speed
	elif Input.is_action_pressed("move_left"):
		position += Vector2(-1, 0) * _delta * camera_move_speed
	elif Input.is_action_pressed("move_up"):
		position += Vector2(0, -1) * _delta * camera_move_speed
	elif Input.is_action_pressed("move_down"):
		position += Vector2(0, 1) * _delta * camera_move_speed

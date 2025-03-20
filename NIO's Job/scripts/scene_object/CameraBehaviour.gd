extends Camera2D

var target: CharacterBody2D
var group_name: String = "player"


func _ready():
	_try_to_find_player()
	GlobalSignalBus.player_is_dead.connect(_on_target_destroyed)


func _process(_delta: float) -> void:
	_try_to_follow_player()


func _try_to_find_player():
	var players = get_tree().get_nodes_in_group(group_name)
	if players.size() > 0:
		target = players[0]
	else:
		print("当前场景没有目标： ", group_name)


func _try_to_follow_player(_speed: float = 0.1):
	if target:
		position = position.lerp(target.position, _speed)


func _on_target_destroyed():
	target = null

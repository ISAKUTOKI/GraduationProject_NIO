extends Node

@export var is_in_test: bool = false
@export var score_demand_multiplier: float = 100
@export var score_buff_random_value: Vector2 = Vector2(1, 3)
var current_score: int = 0
@onready var progress_bar: ProgressBar = $"../Visuals/Movable/ProgressBar"


func _ready() -> void:
	GlobalSignalBus.data_gain_score.connect(_on_data_gain_score)
	_initialize_score()


func _input(_event: InputEvent) -> void:
	if is_in_test:
		if Input.is_key_pressed(KEY_F12):
			score_demand_multiplier = 10


func _on_data_gain_score(_score: int, _position: Vector2) -> void:
	current_score += _score
	print("获得 " + str(_score) + " 分，当前总分： " + str(current_score))
# 把分数转化成值，并增加少量的得分加成————————————————————
	var _score_buff = randf_range(score_buff_random_value.x, score_buff_random_value.y)
	var _v: float = (_score + _score_buff) / score_demand_multiplier
	print("进度条获得： " + str(_v))
	_change_progress_bar(_v)


func _change_progress_bar(_value: float) -> void:
	if progress_bar.value >= 100:
		print("进度条已满")
		GlobalSignalBus.score_is_full.emit()
	else:
		progress_bar.value += _value
		print("当前进度条为： " + str(progress_bar.value))


func _initialize_score() -> void:
	progress_bar.value = 0
	current_score = 0

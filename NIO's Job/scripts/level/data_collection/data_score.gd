extends Node

@export var score_demand_multiplier: float = 100
@export var score_buff_random_value: Vector2 = Vector2(1, 3)
var current_score: int = 0
@onready var progress_bar: ProgressBar = $"../Visuals/Movable/ProgressBar"



func _ready() -> void:
	GlobalSignalBus.data_gain_score.connect(_on_data_gain_score)
	GlobalSignalBus.score_is_full.connect(_on_score_is_full)
	_initialize_score()


func _on_data_gain_score(_score: int) -> void:
	current_score += _score
# 把分数转化成值，并增加少量的得分加成————————————————————
	var _score_buff = randf_range(score_buff_random_value.x, score_buff_random_value.y)
	var _v: float = (_score + _score_buff) / score_demand_multiplier
	_change_progress_bar(_v)


func _change_progress_bar(_value: float) -> void:
	if progress_bar.value <=1:
		progress_bar.value += _value
	else:
		GlobalSignalBus.score_is_full.emit()

func _on_score_is_full()->void:
	pass

func _initialize_score() -> void:
	progress_bar.value = 0
	current_score = 0

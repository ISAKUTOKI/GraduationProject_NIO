extends Area2D

@export var interaction: InteractStats

var target_group: String = "player"
var player_is_in_interact_area: bool = false
var is_in_interaction: bool = false


func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	GlobalSignalBus.interaction_started.connect(on_interaction_started)
	GlobalSignalBus.interaction_ended.connect(on_interaction_ended)


func _process(_delta: float) -> void:
	if not is_in_interaction:
		_try_to_interact()


#region 处理互动状态
func on_interaction_started(_placeholder = null):
	#print("开始了互动")
	is_in_interaction = true


func on_interaction_ended():
	#print("结束了互动")
	await get_tree().create_timer(0.05).timeout
	is_in_interaction = false


#endregion


#region 检测玩家位置
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(target_group):
		player_is_in_interact_area = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group(target_group):
		player_is_in_interact_area = false


#endregion


#region 尝试互动行为
func _try_to_interact():
	if player_is_in_interact_area:
		if Input.is_action_just_pressed("interact"):
			#print($".", "准备发送信号")
			GlobalSignalBus.interaction_started.emit(interaction)
			#print($".", " 信号已发送，携带数据为： ", 
			#str(interaction.interact_type), 
			#" ", 
			#str(interaction.text_path))
#endregion

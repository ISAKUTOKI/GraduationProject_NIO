extends Node

var is_interacting: bool = false
@onready var nio: CharacterBody2D = $".."


func _ready() -> void:
	GlobalSignalBus.interaction_started.connect(_on_interaction_started)


#region 处理互动类型
func _on_interaction_started(interact: InteractStats):
	match interact.interact_type:
		InteractStats.InteractType.浮动对话:
			_talk_interact(interact.text_path)
		InteractStats.InteractType.底部对话:
			_box_talk_interact(interact.text_path)
		InteractStats.InteractType.使用:
			_use_interact()
		InteractStats.InteractType.捡起:
			_pick_up_interact()
		InteractStats.InteractType.占位词:
			_placeholder()


#endregion


#region 不同互动类型发射不同信号
func _talk_interact(path):
	#print(str(path))
	GlobalSignalBus.talk_interacted.emit(path)
	#print("Nio正在和什么说话")
	#GlobalSignalBus.interaction_ended.emit()


func _box_talk_interact(path):
	GlobalSignalBus.box_talk_interacted.emit(path)
	#print("Nio正在使用对话框和什么说话")
	#GlobalSignalBus.interaction_ended.emit()


func _use_interact():
	GlobalSignalBus.use_interacted.emit()
	#print("Nio使用了什么")
	GlobalSignalBus.interaction_ended.emit()


func _pick_up_interact():
	GlobalSignalBus.pick_up_interacted.emit()
	#print("Nio捡起了什么")
	GlobalSignalBus.interaction_ended.emit()


func _placeholder():
	push_error(str(nio.position), " 此互动地点没有设置互动类型")
	GlobalSignalBus.interaction_ended.emit()
#endregion

extends Node

var is_interacting: bool = false


func _ready() -> void:
	GlobalSignalBus.interaction_started.connect(_interact)


#region 处理互动类型
func _interact(_interact_type: InteractStats.InteractType):
	match _interact_type:
		InteractStats.InteractType.TALK:
			_talk_interact()
		InteractStats.InteractType.BOX_TALK:
			_box_talk_interact()
		InteractStats.InteractType.USE:
			_use_interact()
		InteractStats.InteractType.PICK_UP:
			_pick_up_interact()

#endregion


#region 不同互动类型发射不同信号
func _talk_interact():
	GlobalSignalBus.talk_interacted.emit()
	print("Nio正在和什么说话")
	#GlobalSignalBus.interaction_ended.emit()


func _box_talk_interact():
	GlobalSignalBus.box_talk_interacted.emit()
	print("Nio正在使用对话框和什么说话")
	#GlobalSignalBus.interaction_ended.emit()

func _use_interact():
	GlobalSignalBus.use_interacted.emit()
	print("Nio使用了什么")
	GlobalSignalBus.interaction_ended.emit()


func _pick_up_interact():
	GlobalSignalBus.pick_up_interacted.emit()
	print("Nio捡起了什么")
	GlobalSignalBus.interaction_ended.emit()
#endregion

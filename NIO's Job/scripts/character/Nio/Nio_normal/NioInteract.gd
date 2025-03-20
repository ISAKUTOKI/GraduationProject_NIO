extends Node

var is_interacting: bool = false


func _ready() -> void: # 通过信号捕捉互动动作
	GlobalSignalBus.player_has_interacted.connect(_interact)


#region 互动行为
func _interact(_interact_type: GlobalVarBus.InteractType):
	match _interact_type:
		GlobalVarBus.InteractType.TALK:
			_talk_interact()
		GlobalVarBus.InteractType.USE:
			_use_interact()
		GlobalVarBus.InteractType.PICK_UP:
			_pick_up_interact()


#endregion

#region 互动类型
func _talk_interact():
	print("Nio正在和什么说话")
	pass


func _use_interact():
	print("Nio使用了什么")
	pass


func _pick_up_interact():
	print("Nio捡起了什么")
	pass

#endregion

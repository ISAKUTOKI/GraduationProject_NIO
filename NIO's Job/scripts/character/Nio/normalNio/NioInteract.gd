extends Node

var is_interacting: bool = false


func _ready() -> void:
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


func _talk_interact():
	pass


func _use_interact():
	pass


func _pick_up_interact():
	pass
#endregion

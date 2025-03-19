extends Area2D

@export var _interact_type: GlobalVarBus.InteractType = GlobalVarBus.InteractType.TALK

var target_group: String = "player"
var player_is_in_interact_area: bool = false


func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))


func _process(_delta: float) -> void:
	if player_is_in_interact_area:
		if Input.is_action_just_pressed("interact"):
			GlobalSignalBus.player_has_interacted.emit(_interact_type)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(target_group):
		player_is_in_interact_area = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group(target_group):
		player_is_in_interact_area = false

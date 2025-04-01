extends Node

@export var burger_part: PackedScene

var packed_burger_part: Array[BurgerPartStats] = []
var last_packed_burger_part: BurgerPartStats


func _ready() -> void:
	pass


func _on_burger_part_is_picked(_picked_type: BurgerPartStats) -> void:
	pass


func _create_burger_part() -> void:
	if burger_part:
		var _part = burger_part.instantiate() as BurgerPart
		add_child(_part)


func _drop_burger_part() -> void:
	pass

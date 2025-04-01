class_name BurgerPart
extends Node2D

@export var stats: BurgerPartStats
@onready var sprite: Sprite2D = $Sprite2D
var offset: Vector2


func _ready() -> void:
	GlobalSignalBus.burger_part_is_picked.connect(_initialize)
	pass


func _initialize(picked_type: BurgerPartStats.PartType) -> void:
	sprite.texture = BurgerPartStats.UsedPartSprite[picked_type]
	position = get_global_mouse_position() + offset
	pass

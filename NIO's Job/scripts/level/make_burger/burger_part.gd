class_name BurgerPart
extends Node2D

@export var stats: BurgerPartStats
@onready var sprite: Sprite2D = $Sprite2D
var offset: Vector2


func _ready() -> void:
	GlobalSignalBus.burger_part_is_picked.connect(_initialize)


func _initialize(_picked_type: BurgerPartStats) -> void:
	print("初始化了一个部件： " + str(_picked_type.type))
# 图像设定————————————————————
	sprite.texture = BurgerPartStats.UsedPartSprite[_picked_type.type]
# 位置设定————————————————————
	var _random_x_offset: int = randi_range(-2, 2)
	position = get_global_mouse_position() + BurgerPartStats.PickedOffset[_picked_type.type] + _random_x_offset

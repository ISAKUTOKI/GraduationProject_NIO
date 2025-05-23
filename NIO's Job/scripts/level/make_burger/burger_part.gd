class_name BurgerPart
extends Node2D

@export var stats: BurgerPartStats

@export var drop_time: float = 0.3

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	GlobalSignalBus.burger_part_is_created.connect(_on_burger_part_is_created)
	z_index = 2
	#print("链接了 burger_part_is_created")


func _on_burger_part_is_created(part_type: BurgerPartStats, from: Vector2, to: Vector2) -> void:
	#print("参数为： " + str(part_type.type))
	GlobalSignalBus.burger_part_is_created.disconnect(_on_burger_part_is_created)
	_initialize(part_type, from, to)


func _initialize(_picked_type: BurgerPartStats, _initialize_position: Vector2, _target_position: Vector2) -> void:
	#print("初始化了一个部件： " + str(_picked_type.type))
# 图像设定————————————————————
	sprite.texture = load(BurgerPartStats.UsedPartSprite[_picked_type.type])
# 位置设定————————————————————
	var _created_position: Vector2 = _initialize_position
	var _drop_position: Vector2 = _target_position
	position = _created_position
	_drop_part(_drop_position)


func _drop_part(to) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", to, drop_time)
	tween.tween_property(self, "position", to + Vector2(0, 4), 0.1)
	tween.tween_property(self, "position", to, 0.07)
	tween.tween_property(self, "position", to + Vector2(0, 2), 0.07)
	tween.tween_property(self, "position", to, 0.03)
	await tween.finished

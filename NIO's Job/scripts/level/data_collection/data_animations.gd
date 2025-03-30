extends Node

@onready var camera_light: Sprite2D = $"../Visuals/Movable/CameraRedLight"
@onready var scanning_line: Sprite2D = $"../Visuals/Movable/ScanningLine"

@export var red_light_blink_time: float = 0.5


func _ready() -> void:
	GlobalSignalBus.data_number_is_picked.connect(_blink_camera_light)


func _blink_camera_light() -> void:
	_turn_red_light_on(false)
	await get_tree().create_timer(red_light_blink_time).timeout
	_turn_red_light_on(true)



func _turn_red_light_on(light_is_red: bool = true) -> void:
	if camera_light:
		camera_light.visible = light_is_red
	else:
		print("摄像头红灯 加载失败")



func _blink_scanning_line() -> void:
	if scanning_line:
		pass
	else:
		print("扫描线 加载失败")

extends Node

@onready var camera_light: Sprite2D = $"../Visuals/Movable/CameraRedLight"
@onready var scanning_line: Sprite2D = $"../Visuals/Movable/ScanningLine"
@onready var blink_timer: Timer = $BlinkTimer

@export var red_light_blink_time: float = 0.5
@export var light_is_green: bool = false


func _ready() -> void:
	_turn_red_light_on(true)  # 红灯
	blink_timer.wait_time = red_light_blink_time
	GlobalSignalBus.data_number_is_picked.connect(_blink_camera_light)


func _blink_camera_light() -> void:
	_turn_red_light_on(false)  # 绿灯
	if blink_timer.is_stopped() == true:
		blink_timer.start()
	else:
		blink_timer.stop()
		blink_timer.start()
	await blink_timer.timeout
	_turn_red_light_on(true)  # 红灯


func _turn_red_light_on(light_is_red: bool = true) -> void:
	if camera_light:
		camera_light.visible = light_is_red
		light_is_green = !light_is_red
	else:
		print("摄像头红灯 加载失败")


func _blink_scanning_line() -> void:
	if scanning_line:
		pass
	else:
		print("扫描线 加载失败")

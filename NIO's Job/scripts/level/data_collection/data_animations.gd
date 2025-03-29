extends Node

@onready var camera_light: Sprite2D = $"../CanvasGroup/Movable/CameraRedLight"
@onready var scanning_line: Sprite2D = $"../CanvasGroup/Movable/ScanningLine"


func _camera_light_visibility(_can_see: bool = false) -> void:
	if camera_light:
		camera_light.visible = _can_see
	else:
		print("摄像机红点 加载失败")


func _blink_scanning_line() -> void:
	if scanning_line:
		pass
	else:
		print("扫描线 加载失败")

@tool
extends Node

@export var texture: Texture2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var outline: Node = $OutlineHighlighter


func _ready() -> void:
# 初始化————————————————————
	sprite.position = Vector2(160, 90)
	sprite.texture = texture
	outline.hide_outline()
# 安全检查————————————————————
	if sprite.texture:
		pass
	else:
		print("没有加载到图片")


func _on_mouse_entered() -> void:
	print("鼠标进入")
	outline.show_outline()


func _on_mouse_exited() -> void:
	print("鼠标离开")
	outline.hide_outline()

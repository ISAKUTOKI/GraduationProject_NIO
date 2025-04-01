extends Node

@export var target: Sprite2D
@export var outline_color: Color = Color(1, 1, 1, 1)
@export var outline_thickness:float=1.5


func _ready() -> void:
# 获取并初始化节点————————————————————
	if target:
		print("加载到目标： " + str(target))
		target.material.set("shader_parameter/clr", outline_color)
	else:
		print("没有加载到目标" + str(target))
		return

func show_outline() -> void:
	target.material.set("shader_parameter/thickness", outline_thickness)


func hide_outline() -> void:
	target.material.set("shader_parameter/thickness", 0)

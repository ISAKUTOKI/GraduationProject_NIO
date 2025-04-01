class_name BurgerOutlineHighlighter
extends Node

@export var target: CanvasGroup
@export var outline_color: Color = Color(1, 1, 1, 1)
@export var outline_thickness: float = 5

@onready var parent: Area2D = $".."


func _ready() -> void:
	if target != null:
		target.material.set("shader_parameter/line_color", outline_color)
		hide_outline()


func show_outline() -> void:
	#print("显示")
	target.material.set("shader_parameter/line_thickness", outline_thickness)


func hide_outline() -> void:
	#print("隐藏")
	target.material.set("shader_parameter/line_thickness", 0)

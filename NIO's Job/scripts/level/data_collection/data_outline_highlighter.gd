class_name OutlineHighlighter
extends Node

@onready var target: DataCellNumber = $".."
@export var visuals: CanvasGroup
@export var outline_color: Color
@export_range(1, 10) var outline_thickness: int


func _ready() -> void:
	visuals.material.set("shader_parameter/line_color", outline_color)
	clear_highlight()


func highlight() -> void:
	visuals.material.set("shader_parameter/line_thickness", outline_thickness)


func clear_highlight() -> void:
	visuals.material.set("shader_parameter/line_thickness", 0)

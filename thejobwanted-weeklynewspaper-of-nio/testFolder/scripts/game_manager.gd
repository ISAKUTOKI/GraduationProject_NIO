extends Node

var score = 0
@onready var score_label: Label = $score_Label


func add_point():
	score += 1
	score_label.text = "you've got " + str(score) + " coins"
	print("you've got " + str(score) + " coins")

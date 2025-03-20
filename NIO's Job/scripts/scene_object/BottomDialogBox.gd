extends CanvasLayer

const AVATAR_MAP = {
	"Nio_normal_null": preload("res://assets/images/hd_pic/Nio_normal_hd_pic.png"),
	"Nio_normal_embarrass": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_embarrass.png"),
	"Nio_normal_lookdown": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_lookdown.png"),
	"Nio_normal_sick": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_sick.png"),
	"Nio_normal_sigh": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_sigh.png"),
	"Nio_normal_wodden": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_wodden.png")
}

var dialogs = []
var current_dialog = 0

@onready var avatar_pic: TextureRect = $AvatarPic
@onready var contene_text: Label = $Text


func _ready() -> void:
	_hide_dialog_box()
	_show_dialog_box(
		[
			{avatar = "Nio_normal_null", text = "这是 普通Nio"},
			{avatar = "Nio_normal_embarrass", text = "这是 尴尬Nio"},
			{avatar = "Nio_normal_lookdown", text = "这是 向下看Nio"},
			{avatar = "Nio_normal_sick", text = "这是 恶心Nio"},
			{avatar = "Nio_normal_sigh", text = "这是 叹气Nio"},
			{avatar = "Nio_normal_wodden", text = "这是 木讷Nio"},
		]
	)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if current_dialog + 1 < dialogs.size():
			_show_dialog(current_dialog + 1)
		else:
			_hide_dialog_box()
		get_viewport().set_input_as_handleed()


func _hide_dialog_box():
	self.visible = false


func _show_dialog_box(_dialog):
	dialogs = _dialog
	self.visible = true
	_show_dialog(0)


func _show_dialog(index):
	current_dialog = index
	var dialog = dialogs[current_dialog]
	contene_text.text = dialog.text
	avatar_pic.texture = AVATAR_MAP[dialog.avatar]

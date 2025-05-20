@tool
class_name InteractStats
extends Resource

enum InteractType { 占位词, 浮动对话, 底部对话, 使用, 捡起 }
enum FloatTalkType { 占位词, 浮动块测试, 镜子测试 }
enum ButtomTalkType { 占位词, 底部测试, 今晚思考 }

@export var interact_type: InteractType = InteractType.占位词:
	set(value):
		interact_type = value
		notify_property_list_changed()

@export var float_talk: FloatTalkType = FloatTalkType.占位词:
	set(value):
		float_talk = value
		notify_property_list_changed()
		_set_text_path()

@export var buttom_talk: ButtomTalkType = ButtomTalkType.占位词:
	set(value):
		buttom_talk = value
		notify_property_list_changed()
		_set_text_path()

var text_path: String


func _set_text_path():
	match interact_type:
		InteractType.占位词:
			pass
		InteractType.浮动对话:
			text_path = FLOAT_TALK_PATH[float_talk]
		InteractType.底部对话:
			text_path = BUTTOM_TALK_PATH[buttom_talk]
		InteractType.使用:
			pass
		InteractType.捡起:
			pass


# 头像路径
const AVATAR_MAP = {
	"no_avatar": "",
	"Nio_normal_null": preload("res://assets/images/hd_pic/Nio_normal_hd_pic.png"),
	"Nio_normal_embarrass": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_embarrass.png"),
	"Nio_normal_lookdown": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_lookdown.png"),
	"Nio_normal_sick": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_sick.png"),
	"Nio_normal_sigh": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_sigh.png"),
	"Nio_normal_wodden": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_wodden.png")
}

# 浮动对话框路径
const FLOAT_TALK_PATH = {
	FloatTalkType.占位词: "res://dialogs/placeholder.json",
	FloatTalkType.浮动块测试: "res://dialogs/float_dialogs/test_float_dialog.json",
	FloatTalkType.镜子测试: "res://dialogs/float_dialogs/test_mirror_dialog.json"
}

# 底部对话框路径
const BUTTOM_TALK_PATH = {
	ButtomTalkType.占位词: "res://dialogs/placeholder.json",
	ButtomTalkType.底部测试: "res://dialogs/bottom_dialogs/test_bottom_dialog.json",
	ButtomTalkType.今晚思考: "res://dialogs/bottom_dialogs/test_think_dialog.json"
}


func _validate_property(property: Dictionary) -> void:
	if property.name == "float_talk" and interact_type != InteractType.浮动对话:
		property.usage = PROPERTY_USAGE_NO_EDITOR
	elif property.name == "buttom_talk" and interact_type != InteractType.底部对话:
		property.usage = PROPERTY_USAGE_NO_EDITOR

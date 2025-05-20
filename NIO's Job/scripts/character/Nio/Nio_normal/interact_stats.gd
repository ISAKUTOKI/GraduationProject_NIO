@tool
class_name InteractStats
extends Resource

enum InteractType { 占位词, 浮动对话, 底部对话, 使用, 捡起 }
enum FloatTalk { 占位词, 浮动块测试, 镜子测试 }
enum ButtomTalk { 占位词, 固定块测试, 今晚思考 }

@export var type: InteractType = InteractType.占位词:
	set(value):
		type = value
		notify_property_list_changed()

@export var float_talk_path: FloatTalk = FloatTalk.占位词:
	set(value):
		float_talk_path = value
		notify_property_list_changed()

@export var bottom_talk_path: ButtomTalk = ButtomTalk.占位词:
	set(value):
		bottom_talk_path = value
		notify_property_list_changed()

# 头像路径
const AVATAR_MAP = {
	"Nio_normal_null": preload("res://assets/images/hd_pic/Nio_normal_hd_pic.png"),
	"Nio_normal_embarrass": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_embarrass.png"),
	"Nio_normal_lookdown": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_lookdown.png"),
	"Nio_normal_sick": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_sick.png"),
	"Nio_normal_sigh": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_sigh.png"),
	"Nio_normal_wodden": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_wodden.png")
}

# 浮动对话框路径
const FLOAT_TALK_PATH = {
	FloatTalk.占位词: "", 
	FloatTalk.浮动块测试: "res://dialogs/float_dialogs/test_float_dialog.json", 
	FloatTalk.镜子测试: "res://dialogs/float_dialogs/test_mirror_dialog.json"
}

# 底部对话框路径
const BUTTOM_TALK_PATH = {
	ButtomTalk.占位词: "", 
	ButtomTalk.固定块测试: "res://dialogs/bottom_dialogs/test_bottom_dialog.json", 
	ButtomTalk.今晚思考: "res://dialogs/bottom_dialogs/test_think_dialog.json"
}

func _validate_property(property: Dictionary) -> void:
	if property.name == "float_talk_path" and type != InteractType.浮动对话:
		property.usage = PROPERTY_USAGE_NO_EDITOR
	elif property.name == "bottom_talk_path" and type != InteractType.底部对话:
		property.usage = PROPERTY_USAGE_NO_EDITOR

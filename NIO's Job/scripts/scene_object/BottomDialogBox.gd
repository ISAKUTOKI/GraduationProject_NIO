class_name BottomDialogBox
extends CanvasLayer

@onready var avatar_pic: TextureRect = $AvatarPic
@onready var content_text: Label = $Text

var dialogs = []
var current_dialog = 0
@export var show_dialog_interval: float = 0.1  # 逐字显示的时间间隔（秒）
var tween: Tween


func _ready() -> void:
	_hide_dialog_box()
	GlobalSignalBus.box_talk_interacted.connect(临时函数)


func 临时函数():
	show_dialog_box(
		[
			{avatar = "Nio_normal_null", text = "这是 普通Nio"},
			{avatar = "Nio_normal_embarrass", text = "这是 尴尬Nio"},
			{avatar = "Nio_normal_lookdown", text = "这是 向下看Nio"},
			{avatar = "Nio_normal_sick", text = "这是 恶心Nio"},
			{avatar = "Nio_normal_sigh", text = "这是 叹气Nio"},
			{avatar = "Nio_normal_wodden", text = "这是 木讷Nio"},
			{avatar = "Nio_normal_null", text = "这是一串非常长的用来测试的，所以它应该非常长，十分长，需要换行，也可能放不下"}
		]
	)


#region 切换可见性
func _hide_dialog_box():
	self.visible = false
	current_dialog = 0
	dialogs = []


func show_dialog_box(_dialog):
	dialogs = _dialog
	self.visible = true
	_show_dialog(0)
#endregion


#region 显示内容
func _show_dialog(index):
	if index < 0 or index >= dialogs.size():
		return

	current_dialog = index
	var dialog = dialogs[current_dialog]
	avatar_pic.texture = GlobalVarBus.AVATAR_MAP.get(dialog.avatar, null)
	content_text.text = dialog.text

	content_text.visible_ratio = 0.0
	tween = create_tween()
	tween.tween_property(content_text, "visible_ratio", 1.0, show_dialog_interval * content_text.text.length())
#endregion


#region 对话中处理点击行为
func _unhandled_input(event: InputEvent) -> void:
	if self.visible == false:
		return

	if event.is_action_pressed("ui_accept"):
		if tween and tween.is_running():
			tween.stop()
			content_text.visible_ratio = 1.0
		elif current_dialog + 1 < dialogs.size():
			_show_dialog(current_dialog + 1)
		else:
			_hide_dialog_box()
			GlobalSignalBus.interaction_ended.emit()
		get_viewport().set_input_as_handled()
#endregion

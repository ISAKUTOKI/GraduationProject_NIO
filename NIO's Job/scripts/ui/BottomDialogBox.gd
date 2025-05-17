extends CanvasLayer

@onready var avatar_pic: TextureRect = $AvatarPic
@onready var text_content: Label = $Text

var dialogs = []  # 当前对话内容
var current_dialog = 0  # 当前对话索引（数组中的数）
@export var show_dialog_unit_interval: float = 0.1
var tween: Tween
var interaction_count: int = 0  # 记录互动次数
var all_dialogs = []  # 存储所有对话内容


func _ready() -> void:
	_hide_bottom_dialog_box()
	_load_dialogs_from_json("res://dialogs/bottom_dialogs/test_bottom_dialog.json")
# 连接信号
	GlobalSignalBus.box_talk_interacted.connect(_on_box_talk_interacted)


#region 解析JSON文件
func _load_dialogs_from_json(file_path: String):
	var file = FileAccess.open(file_path, FileAccess.READ)
	if not file:
		print("错误：无法打开文件 ", file_path)
		return

	var json_text = file.get_as_text()
	file.close()

	var json = JSON.new()
	var error = json.parse(json_text)
	if error != OK:
		print("JSON 解析错误：", json.get_error_message())
		return

	all_dialogs = json.data  # 存储所有对话内容
	print("加载对话组数量：", all_dialogs.size())


#endregion


func _on_box_talk_interacted():
	interaction_count += 1
	_load_dialogs_for_interaction(interaction_count)  # 加载对应次数的对话
	_show_bottom_dialog_box()  # 显示对话


func _load_dialogs_for_interaction(count: int):
	for dia in all_dialogs:
		if dia.interaction_count == count:
			dialogs = dia.dialogs
			return
	# 如果没有找到对应次数的对话，使用默认内容
	dialogs = [{"avatar": "Nio_normal_null", "text": "没有更多对话了。"}]


#region 切换底部对话框可见性
func _show_bottom_dialog_box():
	self.visible = true
	_show_dialog(0)


func _hide_bottom_dialog_box():
	self.visible = false
	current_dialog = 0
	dialogs = []


#endregion


#region 显示内容
func _show_dialog(index):
	if index < 0 or index >= dialogs.size():
		#print("无效索引：", index)
		_hide_bottom_dialog_box()
		return

	current_dialog = index
	var _dialog = dialogs[current_dialog]
	#print("正在显示对话：", _dialog)

	avatar_pic.texture = InteractStats.AVATAR_MAP.get(_dialog.avatar, null)

	text_content.text = _dialog.text
	text_content.visible_ratio = 0.0

	if tween:
		tween.kill()
		tween = null
	tween = create_tween().bind_node(self)
	tween.tween_property(text_content, "visible_ratio", 1.0, show_dialog_unit_interval * text_content.text.length())


#endregion


#region 对话中处理点击行为
func _unhandled_input(event: InputEvent) -> void:
	if not self.visible:  # 如果对话框不可见，不处理输入，防止出现重复触发的bug
		return

	if event.is_action_pressed("ui_accept"):
		if tween and tween.is_running():
			tween.stop()
			text_content.visible_ratio = 1.0
		elif current_dialog + 1 < dialogs.size():
			_show_dialog(current_dialog + 1)
		else:
			_hide_bottom_dialog_box()
			GlobalSignalBus.interaction_ended.emit()
		get_viewport().set_input_as_handled()
#endregion

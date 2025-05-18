@tool
extends EditorPlugin

const OUTPUT_DIR = "res://script_images/"


func _enter_tree():
	# Godot 4.3 要求使用 Callable 作为参数
	add_tool_menu_item("Export Scripts as Images", Callable(self, "_export_scripts"))


func _exit_tree():
	remove_tool_menu_item("Export Scripts as Images")


func _export_scripts():
	# 使用 DirAccess 替代废弃的 Directory
	if not DirAccess.dir_exists_absolute(OUTPUT_DIR):
		DirAccess.make_dir_recursive_absolute(OUTPUT_DIR)

	var scripts = _find_script_files("res://")
	for path in scripts:
		_export_script_as_image(path)
	print("导出完成至: ", OUTPUT_DIR)


func _find_script_files(path: String) -> Array:
	var scripts = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				if file_name != "." and file_name != "..":
					scripts += _find_script_files(path.path_join(file_name))
			else:
				if file_name.ends_with(".gd"):
					scripts.append(path.path_join(file_name))
			file_name = dir.get_next()
	return scripts


func _export_script_as_image(script_path: String):
	# 使用 FileAccess 替代废弃的 File
	if not FileAccess.file_exists(script_path):
		printerr("脚本不存在: ", script_path)
		return

	var file = FileAccess.open(script_path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()

	# 创建TextEdit节点
	var text_edit = TextEdit.new()
	text_edit.text = content
	text_edit.wrap_mode = TextEdit.LINE_WRAPPING_NONE
	text_edit.scroll_horizontal = 0

	# 动态计算字体尺寸
	var font = text_edit.get_theme_font("font")
	var font_size = text_edit.get_theme_font_size("font_size")
	var char_width = font.get_string_size("A", HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
	var line_height = font.get_height(font_size)

	# 计算控件尺寸
	var lines = content.split("\n")
	var max_line_length = 0
	for line in lines:
		max_line_length = max(max_line_length, line.length())
	var width = max_line_length * char_width + 20
	var height = lines.size() * line_height + 20

	# 设置SubViewport
	var viewport = SubViewport.new()
	viewport.size = Vector2i(width, height)
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	viewport.add_child(text_edit)
	text_edit.position = Vector2(10, 10)
	text_edit.size = Vector2(width - 20, height - 20)

	# 添加到场景树
	get_editor_interface().get_editor_main_screen().add_child(viewport)

	# 等待渲染完成
	await RenderingServer.frame_post_draw

	# 保存图像
	var image = viewport.get_texture().get_image()
	var output_path = OUTPUT_DIR.path_join(script_path.get_file().get_basename() + ".png")
	image.save_png(output_path)

	# 清理节点
	viewport.remove_child(text_edit)
	viewport.queue_free()

extends Node


func reload_current_scene(delay: float = 0):
	var current_scene_path = get_tree().current_scene.scene_file_path
	await get_tree().create_timer(delay).timeout
	get_tree().change_scene_to_file(current_scene_path)
	print("重加载了当前场景")
	pass


func load_next_scene():
	print("加载了下一个场景")
	pass


func load_last_scene():
	print("加载了上一个场景")
	pass

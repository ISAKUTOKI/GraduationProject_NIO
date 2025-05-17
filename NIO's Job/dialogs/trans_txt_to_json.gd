extends Node

func convert_txt_to_json(txt_path: String, json_path: String):
	var file = FileAccess.open(txt_path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()

# 使用|||分割文本————————————————————
	var dialogues = content.split("|||", false)
	
	var json_data = {
		"interaction_count": 1,
		"dialogs": []
	}
	
	for text in dialogues:
		if text.strip() != "":  # 跳过空行
			json_data["dialogs"].append({
				"avatar": "",
				"text": text.strip()
			})
	
# 保存JSON文件————————————————————
	var save_file = FileAccess.open(json_path, FileAccess.WRITE)
	save_file.store_string(JSON.stringify(json_data, "\t"))
	save_file.close()


func _ready():
	convert_txt_to_json("res://dialogue.txt", "res://dialogue.json")
	print("转换完成！生成的JSON已保存到项目根目录")

extends Node

@export var data_cell_numbers: PackedScene
@export var number_size := Vector2(20, 20)  # 每个数字的尺寸
@export var spacing := Vector2(10, 16)  # 数字间距
var spawn_rect := Rect2(Vector2(39, 28), Vector2(255, 105))  # 边距

@onready var scanning_line: Sprite2D = $"../CanvasGroup/Movable/ScanningLine"


func _ready():
	_regenerate_all_grid()


func _regenerate_all_grid():
# 清除旧实例
	for child in get_children():
		if child is DataCellNumber:
			child.queue_free()

	# 计算行列容量
	var cols = floori((spawn_rect.size.x - spacing.x) / spacing.x) + 1
	var rows = floori((spawn_rect.size.y - spacing.y) / spacing.y) + 1
	#print("可生成范围的size为：" + str(spawn_rect.size))
	#print("可生成数量（x，y）为： " + str(cols) + " , " + str(rows))

	# 实际起始位置（左上角对齐）
	var start_pos = spawn_rect.position + number_size / 2

	# 紧凑排列算法
	for y in rows:
		for x in cols:
			var cell_pos = Vector2(start_pos.x + x * spacing.x, start_pos.y + y * spacing.y)

			# 边界检查
			if cell_pos.x + number_size.x / 2 > spawn_rect.end.x:
				continue
			if cell_pos.y + number_size.y / 2 > spawn_rect.end.y:
				continue

			_create_cell(cell_pos)

	scanning_line.z_index = 99


func _create_cell(pos: Vector2):
	var cell = data_cell_numbers.instantiate() as DataCellNumber
	add_child(cell)
	cell.position = pos
	cell.initialize_number(randi() % 10)
	cell.content.custom_minimum_size = number_size

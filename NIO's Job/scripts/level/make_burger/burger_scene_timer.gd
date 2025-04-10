extends Timer

@onready var stage_label: Label = $Label
@onready var create_label: Label = $Label2
@onready var order_create_timer: Timer = $OrderCreateTimer

@export var is_in_test: bool = false
@export var current_stage_timer: float = 180
@export var create_order_interval: Vector2i = Vector2(7, 12)
@export var order_create_is_random: bool = true

var designated_order_type_number: int = -1
var can_create_order: bool = false


func _ready() -> void:
	GlobalSignalBus.burger_is_ready_for_start_stage.connect(_on_burger_is_ready_for_start_stage)
	wait_time = current_stage_timer
	stage_label.text = "关卡总时间剩余: "
	create_label.text = "距离新订单创建还有： "


func _process(_delta: float) -> void:
	if can_create_order:
		_create_order_by_random_interval()
		stage_label.text = str("关卡总时间剩余: ", int(time_left))
		create_label.text = str("距离新订单创建还有： ", int(order_create_timer.time_left))


func _input(event: InputEvent) -> void:
	if is_in_test:
		if event.is_action_pressed("test"):
			GlobalSignalBus.burger_is_ready_for_start_stage.emit()


func _on_burger_is_ready_for_start_stage() -> void:
	start()
	can_create_order = true


func _create_order_by_random_interval() -> void:
	if not order_create_timer.is_stopped():
		return
	var current_interval = randi_range(create_order_interval.x, create_order_interval.y)
	order_create_timer.wait_time = current_interval
	order_create_timer.start()
	await order_create_timer.timeout
	GlobalSignalBus.burger_create_order.emit(order_create_is_random, designated_order_type_number)

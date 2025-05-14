extends StaticBody2D

@onready var timer: Timer = $FruitGrowthTimer
@onready var unripe_fruit_top: Sprite2D = %UnripeFruits
@onready var ripe_fruit_top: Sprite2D = %RipeFruits
@onready var empty_fruit_top: Sprite2D = %Top
@onready var surround_area: Area2D = $TrunkArea

const APPLE = preload("res://resources/inventory/items/apple.tres") as InventoryItem

var player_nearby: bool = false
var is_ripe: bool = false

func _ready():
	timer.timeout.connect(on_timer_timeout)
	surround_area.area_entered.connect(on_area_entered)
	surround_area.area_exited.connect(on_area_exited)

func _process(_delta: float) -> void:
	var half_time = timer.wait_time / 2;
	if abs(timer.time_left - half_time) < 0.1:
		show_unripe_tree()

func _input(event):
	if event is InputEventMouseButton and event.is_action_pressed("mouse_left_click") and player_nearby and is_ripe:
		harvest_tree()

func harvest_tree():
	var player = get_tree().get_first_node_in_group("player") as Player

	if player == null:
		return

	var inventory_slot = InventorySlot.new()

	inventory_slot.item = APPLE
	inventory_slot.amount = 6

	player.add_item_to_inventory(inventory_slot)

	show_tree_empty()
	timer.start()

func show_unripe_tree():
	unripe_fruit_top.visible = true
	ripe_fruit_top.visible = false

func show_ripe_tree():
	is_ripe = true
	unripe_fruit_top.visible = false
	ripe_fruit_top.visible = true
	timer.stop()

func show_tree_empty():
	is_ripe = false
	empty_fruit_top.visible = true
	unripe_fruit_top.visible = false
	ripe_fruit_top.visible = false

func on_area_entered(_area: Area2D):
	player_nearby = true

func on_area_exited(_area: Area2D):
	player_nearby = false

func on_timer_timeout():
	timer.stop()
	show_ripe_tree()

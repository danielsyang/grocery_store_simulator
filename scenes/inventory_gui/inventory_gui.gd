extends CanvasLayer

@onready var inventory: Inventory = preload("res://resources/inventory/player_inventory_resource.tres")
@onready var slots: Array = %SlotContainer.get_children()

func _ready():
	var slot_container = %SlotContainer as GridContainer

	if slot_container == null:
		return

	for i in slot_container.get_child_count():
		slots[i].update_item(inventory.items[i])


func update_inventory():
	pass

extends CanvasLayer

@onready var inventory: Inventory = preload("res://resources/inventory/player_inventory_resource.tres")
@onready var slots: Array = %SlotContainer.get_children()

const MAX_SLOTS = 4

func _ready():
	inventory.item_added.connect(on_item_added)

func render_inventory():
	for i in inventory.items.size():
		slots[i].update_item(inventory.items[i])

func on_item_added(item: InventoryItem):
	if inventory.items.size() < MAX_SLOTS:
		inventory.items.append(item)

	render_inventory()

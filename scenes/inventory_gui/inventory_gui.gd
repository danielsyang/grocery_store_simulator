extends CanvasLayer

@onready var inventory: Inventory = preload("res://resources/inventory/player_inventory_resource.tres")
@onready var slots: Array = %SlotContainer.get_children()

const MAX_SLOTS = 4

func _ready():
	inventory.item_added.connect(on_item_added)

func render_inventory():
	for i in inventory.items.size():
		slots[i].update_item(inventory.items[i])

func on_item_added(item: InventorySlot):
	var existing_slot: int = -1

	for i in inventory.items.size():
		if inventory.items[i].item.id == item.item.id:
			existing_slot = i
			break

	if existing_slot == -1:
		inventory.items.append(item)
	else:
		inventory.items.map(
			func(slot: InventorySlot):
				if slot.item.id == item.item.id:
					slot.amount += item.amount
				
				return slot
		)
	
	render_inventory()

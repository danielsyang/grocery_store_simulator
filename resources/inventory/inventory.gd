extends Resource

class_name Inventory

signal item_added(item: InventorySlot)

@export var items: Array[InventorySlot] = []

func add_item(item: InventorySlot):
    item_added.emit(item)

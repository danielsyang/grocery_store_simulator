extends Resource

class_name Inventory

signal item_added(item: InventoryItem)

@export var items: Array[InventoryItem] = []

func add_item(item: InventoryItem):
    item_added.emit(item)

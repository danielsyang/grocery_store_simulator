extends Panel

@onready var background_sprite: Sprite2D = $Background
@onready var item_sprite: Sprite2D = $Item
@onready var item_quantity: Label = $Item/Quantity

func update_item(slot: InventorySlot):
	background_sprite.frame = 1
	item_sprite.visible = true
	item_sprite.texture = slot.item.texture
	item_quantity.visible = true
	item_quantity.text = str(slot.amount)

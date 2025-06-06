extends CharacterBody2D
class_name Player

const SPEED = 200
const ACCELERATION = 10

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

@export var inventory: Inventory

func _process(_delta):
    var movement_vector = get_movement_vector()
    var direction = movement_vector.normalized()
    var target_velocity = SPEED * direction

    velocity = target_velocity

    if movement_vector.y > 0:
        animatedSprite.play("walk_down")
    elif movement_vector.y < 0:
        animatedSprite.play("walk_up")
    elif movement_vector.x > 0:
        animatedSprite.play("walk_right")
    elif movement_vector.x < 0:
        animatedSprite.play("walk_left")
    else:
        animatedSprite.play("idling")

    move_and_slide()


func get_movement_vector() -> Vector2:
    var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

    return Vector2(x_movement, y_movement)

func add_item_to_inventory(item: InventorySlot):
    inventory.add_item(item)

extends CharacterBody2D
class_name Target

var speed := PI
const KNIFE_POSITION = Vector2(0, 180)
@onready var items_container := $ItemsContainer


func _physics_process(delta):
	rotation += speed * delta

func add_object_with_pivot(object: Node2D, object_rotation :float):
	var pivot := Node2D.new()
	pivot.rotation = object_rotation
	pivot.add_child(object)
	items_container.add_child(pivot)

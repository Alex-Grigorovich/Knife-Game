extends CharacterBody2D
class_name Target

var speed := PI
const EXPLOSION_TIME := 1.0
const GENERATION_LIMIT := 10
const KNIFE_POSITION = Vector2(0, 180)
const APLLE_POSITION = Vector2(0, 176)
const OBJECT_MARGIN = PI / 6


@onready var items_container := $ItemsContainer
@onready var sprite := $Sprite2D
@onready var knife_particle = $KnifeParticles2D
@onready var particles_target_parts := [
	$TargetParticles2D,
	$TargetParticles2D2,
	$TargetParticles2D3
]

var knife_scene : PackedScene = load("res://elements/knife.tscn") 
var apple_scene : PackedScene = load("res://elements/apple.tscn") 



func _ready():
	knife_particle.texture = Globals.KNIFES_TEXTURES[Globals.active_knife_index]



func _physics_process(delta):
	move(delta)
	
func move(delta: float):
	rotation += speed * delta

func take_damage():
	if Globals.knifes == 0:
		explode()
	#await get_tree().create_timer(1).timeout
	#explode()
	
func explode():
	sprite.hide()
	items_container.hide()
	
	var tween := create_tween()
	
	for particles_target_part in particles_target_parts:
		tween.parallel().tween_property(particles_target_part, "modulate", Color("ffffff00"), EXPLOSION_TIME)
		particles_target_part.emitting = true
		
	knife_particle.rotation = -rotation
	knife_particle.emitting = true
	tween.parallel().tween_property(knife_particle, "modulate", Color("ffffff00"), EXPLOSION_TIME)
	
	tween.play()
	await tween.finished
	Globals.change_stage(Globals.current_stage + 1)

func add_object_with_pivot(object: Node2D, object_rotation :float):
	var pivot := Node2D.new()
	pivot.rotation = object_rotation
	pivot.add_child(object)
	items_container.add_child(pivot)
	
func add_default_items(knives: int, apples: int):
	var occupied_rotations := []
	for i in range(knives):
		var pivot_rotation = get_free_random_locations(occupied_rotations)
		if pivot_rotation == null:
			return
		occupied_rotations.append(pivot_rotation)
		var knife = knife_scene.instantiate()
		knife.position = KNIFE_POSITION
		add_object_with_pivot(knife, pivot_rotation)
		
	for i in range(apples):
		var pivot_rotation = get_free_random_locations(occupied_rotations)
		if pivot_rotation == null:
			return
		occupied_rotations.append(pivot_rotation)
		var apple = apple_scene.instantiate()
		apple.position = APLLE_POSITION
		add_object_with_pivot(apple, pivot_rotation)

func get_free_random_locations(occupied_rotations: Array, generation_attempts = 0):
	if generation_attempts >= GENERATION_LIMIT:
		return null
	var random_rotation = Globals.rng.randf_range(0, PI * 2)
	
	for occupied in occupied_rotations:
		if random_rotation <= occupied + OBJECT_MARGIN / 2.0 and  random_rotation >= occupied - OBJECT_MARGIN / 2.0:
			return get_free_random_locations(occupied_rotations)
		
	return random_rotation

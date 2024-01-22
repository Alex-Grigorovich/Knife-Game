extends Node

const location_to_scene = {
	Events.LOCATIONS.GAME: preload("res://scenes/game.tscn"),
	Events.LOCATIONS.START: preload("res://scenes/start screen/start_screen.tscn"),
	Events.LOCATIONS.SHOP: preload("res://scenes/scene shop/knife_shop.tscn")
}

var rng := RandomNumberGenerator.new()
var points := 0
var knifes := 6

func _ready():
	rng.randomize()
	print_debug(rng.seed)
	Events.location_changed.connect(handle_location_change)

func add_point():
	points += 1
	Events.points_changed.emit(points)
	
func reset_points():
	points = 0
	Events.points_changed.emit(points)
	
func remove_knife():
	knifes -= 1
	Events.knifes_changed.emit(knifes)

func handle_location_change(location: Events.LOCATIONS):
	get_tree().change_scene_to_packed(location_to_scene.get(location))
 

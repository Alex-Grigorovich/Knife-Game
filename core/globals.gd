extends Node

const location_to_scene = {
	Events.LOCATIONS.GAME: preload("res://scenes/game.tscn"),
	Events.LOCATIONS.START: preload("res://scenes/start screen/start_screen.tscn"),
	Events.LOCATIONS.SHOP: preload("res://scenes/scene shop/knife_shop.tscn")
}
const MAX_STAGE_APPLES := 3
const MAX_STAGE_KNIFES := 2
const MIN_KNIFES := 5
const MAX_KNIFES := 8

var rng := RandomNumberGenerator.new()

var current_stage := 1
var points := 0
var knifes := 6

func _ready():
	rng.randomize()
	print_debug(rng.seed)
	Events.location_changed.connect(handle_location_change)

func change_stage(stage_i: int):
	current_stage = stage_i
	var stage = get_common_stage()
	knifes = rng.randi_range(MIN_KNIFES, MAX_KNIFES)
	Events.knifes_changed.emit(knifes)
	Events.stage_changed.emit(stage)

func get_common_stage() -> Stage:
	var stage := Stage.new()
	stage.apples = rng.randi_range(0, MAX_STAGE_APPLES)
	stage.knifes = rng.randi_range(0, MAX_STAGE_KNIFES)
	return stage

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
 

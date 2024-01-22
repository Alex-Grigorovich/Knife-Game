extends Node2D

var restart_overlay_scene = preload("res://elements/ui/restart_overlay/restart_overlay.tscn")

@onready var knife_shooter := $KnifeShooter

func _ready():
	Events.game_over.connect(end_game)
	Events.knifes_changed.emit(Globals.knifes)

func end_game():
	knife_shooter.is_enabled = false
	show_restart_overlay()
	Globals.reset_points()
	
func show_restart_overlay():
	add_child(restart_overlay_scene.instantiate())
	Hud.update_hud_restart()

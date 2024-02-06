extends CanvasLayer

@onready var stage_label := %StageLbl

func _ready():
	get_current_stage()
	
	
func _on_button_pressed():
	Events.location_changed.emit(Events.LOCATIONS.GAME)

func get_current_stage():
	stage_label.text = str(Globals.current_stage)

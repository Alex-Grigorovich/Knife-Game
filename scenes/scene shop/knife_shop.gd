extends Control

@onready var grid_container = $MarginContainer2/VBoxContainer/GridContainer
@onready var texture_knife = $MarginContainer2/VBoxContainer/ActiveKnifeTexture

func _ready():
	Events.active_knifes_changed.connect(update_active_knife)
	update_active_knife(Globals.active_knife_index)
	for i in range(Globals.KNIFES_TEXTURES.size()):
		var shop_item := grid_container.get_child(i)
		shop_item.initialize(i)

func update_active_knife(knife_idx: int):
	texture_knife.texture = Globals.KNIFES_TEXTURES[knife_idx]

func _on_unblock_button_pressed():
	if Globals.apples >= Globals.UNLOCK_COST:
		var locked_knives := []
		for i in range(Globals.KNIFES_TEXTURES.size()):
			if not Globals.is_knife_unlocked(i):
				locked_knives.append(i)
		
		if locked_knives.is_empty():
			return
		
		var random_index = locked_knives.pick_random()
		Globals.unlock_knife(random_index)
		Globals.add_apples(-Globals.UNLOCK_COST)
		Globals.save_game()
		grid_container.get_child(random_index).unlock()
	
	else:
		pass

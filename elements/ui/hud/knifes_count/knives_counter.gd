extends VBoxContainer


var knife_texture :Texture2D = preload("res://assets/knife_ico_2.png")

func _ready():
	Events.knifes_changed.connect(update_knife_counter)

func update_knife_counter(knifes: int):
	var knifes_diff = knifes - get_child_count()
	if knifes_diff > 0:
		add_knifes(knifes_diff)
	elif knifes_diff < 0:
		remove_knifes(-knifes_diff)

func  create_knife_icon() -> TextureRect:
	var texture_rect := TextureRect.new()
	texture_rect.texture = knife_texture
	return texture_rect
	
func add_knifes(amount: int):
	for i in range(amount):
		add_child(create_knife_icon())
		
func remove_knifes(amount: int):
	for i in range(amount):
		get_child(i).queue_free() 

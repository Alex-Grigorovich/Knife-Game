extends RefCounted
class_name Stage

var knifes := 0
var apples := 0
var target_scene_resource : PackedScene

func _init(target_scene = preload("res://elements/Targets/target.tscn")):
	target_scene_resource = target_scene

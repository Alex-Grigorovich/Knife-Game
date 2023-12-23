extends CharacterBody2D

var speed := PI

func _physics_process(delta):
	rotation += speed * delta

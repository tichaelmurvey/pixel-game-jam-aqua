extends CharacterBody2D


@export var SPEED = 1000.0
const explosion_scene = preload("res://components/effects/explosion.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var collisions = move_and_collide(velocity*SPEED*delta)
	if collisions:
		#explode
		print("boom")
		var new_explosion = explosion_scene.instantiate()
		new_explosion.position = position
		get_parent().add_child(new_explosion)
		queue_free()

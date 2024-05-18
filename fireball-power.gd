extends Node2D

var agent
const fireball_scene = preload("res://components/effects/fireball.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	agent = get_parent()


#on item keypress
func _input(event):
	if event.is_action_pressed("use_effect"):
		var fireball = fireball_scene.instantiate()
		get_tree().get_root().add_child(fireball)
		fireball.global_position = agent.global_position + Vector2(20*agent.facing_left, 0)
		fireball.velocity = Vector2(agent.facing_left, 0)

extends Node2D

var agent
var drizzling = false
var drizzle = null
const drizzle_scene = preload("res://components/effects/drizzle.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	agent = get_parent()


#on item keypress
func _input(event):
	if event.is_action_pressed("use_effect") and drizzling == false:
		drizzling = true
		drizzle = drizzle_scene.instantiate()
		add_child(drizzle)
		drizzle.velocity = Vector2(1, 0)
	if event.is_action_released("use_effect"):
		drizzling = false
		drizzle.queue_free()

func remove():
	queue_free()

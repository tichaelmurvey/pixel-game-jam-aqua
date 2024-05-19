extends Node2D
var agent
const puff_scene = preload("res://components/effects/puff.tscn")
var puffing = false
var puff = null
# Called when the node enters the scene tree for the first time.
func _ready():
	agent = get_parent()

#on item keypress
func _input(event):
	if event.is_action_pressed("use_effect") and puffing == false:
		agent.play_sound("puff")
		puff = puff_scene.instantiate()
		puffing = true
		add_child(puff)
		agent.velocity.x -= 500*agent.facing_left
		$Timer.start()


func _on_timer_timeout():
	puff.queue_free()
	puffing = false
		
func remove():
	queue_free()

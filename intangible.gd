extends Node2D

var agent

# Called when the node enters the scene tree for the first time.
func _ready():
	agent = get_parent()

func _input(event):
	if event.is_action_pressed("use_effect") and agent.drift_mode == false:
		$Timer.start()
		#make intangible
		agent.set_collision_layer_value(2, false)
		agent.set_collision_mask_value(1, false)
		agent.drift_mode = true


func remove():
	queue_free()


func _on_timer_timeout():
	#make tangible
	agent.set_collision_layer_value(2, true)
	agent.set_collision_mask_value(1, true)
	agent.drift_mode = false

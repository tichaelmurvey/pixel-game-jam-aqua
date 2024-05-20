extends Node2D

var agent
# Called when the node enters the scene tree for the first time.
func _ready():
	agent = get_parent()
	agent.ACCELERATION /= 2
	agent.DECELERATION /= 10
	agent.MAX_RUN_SPEED *= 1.5
	agent.play_sound("ice_boot")

func remove():
	agent.ACCELERATION *= 2
	agent.DECELERATION *= 10
	agent.MAX_RUN_SPEED /= 1.5
	queue_free()

func _process(delta):
	#get agent direction
	var direction = agent.direction
	#if direction is not 0, and sound is not already playing
	if direction != 0 and agent.is_on_floor():
		agent.play_sound("ice", true)

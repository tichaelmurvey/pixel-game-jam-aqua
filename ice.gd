extends Node2D

var agent
# Called when the node enters the scene tree for the first time.
func _ready():
	agent = get_parent()
	agent.ACCELERATION /= 2
	agent.DECELERATION /= 10
	agent.MAX_RUN_SPEED *= 1.5

func remove():
	agent.ACCELERATION *= 2
	agent.DECELERATION *= 10
	agent.MAX_RUN_SPEED /= 1.5
	queue_free()

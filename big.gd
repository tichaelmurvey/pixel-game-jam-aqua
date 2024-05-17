extends Node2D

var agent;
# Called when the node enters the scene tree for the first time.
func _ready():
	print("big enabled")
	#get parent characterbody
	agent = get_parent()
	#increase agent scale
	agent.scale *= 2
	#update y position
	agent.position.y -= 50

func remove():
	agent.scale /= 2
	queue_free()
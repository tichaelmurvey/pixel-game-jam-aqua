extends Node2D

var agent;
# Called when the node enters the scene tree for the first time.
func _ready():
	#get parent characterbody
	agent = get_parent()
	#decrease agent scale
	agent.scale /= 2
	#update y position
	agent.position.y += 50

func remove():
	agent.scale *= 2
	agent.position.y -= 50
	queue_free()
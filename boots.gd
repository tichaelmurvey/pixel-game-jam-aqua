extends Node2D

var agent;
# Called when the node enters the scene tree for the first time.
func _ready():
	#get parent characterbody
	agent = get_parent()
	#add down as protected angle
	agent.protectedAngles.append(0)
	# agent.armor = true
	#get height of agent
	var agentHeight = agent.get_height()
	position.y = agentHeight
	agent.play_sound("boot")

func remove():
	#reset agent variables
	agent.protectedAngles.remove_at(agent.protectedAngles.find(0))
	# agent.armor = false
	queue_free()

func _process(delta):
	#get agent direction
	var direction = agent.direction
	#if direction is not 0, and sound is not already playing
	if direction != 0 and agent.is_on_floor():
		agent.play_sound("boot", true)

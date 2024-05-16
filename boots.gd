extends Node2D

var agent;
# Called when the node enters the scene tree for the first time.
func _ready():
	#get parent characterbody
	agent = get_parent()
	#add down as protected angle
	agent.protectedAngles.append(0)
	#get height of agent
	var agentHeight = agent.get_height()
	position.y = agentHeight

func remove():
	#reset agent variables
	agent.protectedAngles.remove_at(agent.protectedAngles.find(0))
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in get_children():
		if i is CollisionShape2D:
			print(agent)
			i.reparent(agent)
			#scale
			i.scale = scale
			#position

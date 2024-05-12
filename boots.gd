extends Node2D

var agent;
# Called when the node enters the scene tree for the first time.
func _ready():
	#get parent characterbody
	agent = get_parent()
	#move parent up by height of my collision shape plus its sprite size
	agent.position.y -= ($CollisionShape2D.shape.extents.y)
	#add down as protected angle
	agent.protectedAngles.append(0)
	#get height of agent
	var agentHeight = agent.get_height()
	position.y = agentHeight
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in get_children():
		if i is CollisionShape2D:
			print(agent)
			i.reparent(agent)
			#scale
			i.scale = scale
			#position

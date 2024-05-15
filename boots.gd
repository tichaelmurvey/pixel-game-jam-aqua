extends Node2D

var agent;
@export var enabled = false
# Called when the node enters the scene tree for the first time.
func _ready():
	#get parent characterbody
	agent = get_parent()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in get_children():
		if i is CollisionShape2D:
			print(agent)
			i.reparent(agent)
			#scale
			i.scale = scale
			#position

func enable():
	#move parent up by height of my collision shape plus its sprite size
	agent.position.y -= 30
	#add down as protected angle
	agent.protectedAngles.append(0)
	#get height of agent
	var agentHeight = agent.get_height()
	position.y = agentHeight
	#make self visible
	visible = true

func disable():
	#move parent down by height of my collision shape plus its sprite size
	agent.position.y += 30
	#remove down as protected angle
	agent.protectedAngles.remove(0)
	#get height of agent
	var agentHeight = agent.get_height()
	position.y = agentHeight
	#make self invisible
	visible = false
	#disable physics process
	
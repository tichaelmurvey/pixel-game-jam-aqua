extends Node2D

var agent

# Called when the node enters the scene tree for the first time.
func _ready():
	agent = get_parent()
	#make agent heavy
	agent.gravity *= 2
	agent.JUMP_VELOCITY *= 0.5
	agent.armor = true
	agent.play_sound("statue")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func remove():
	agent.gravity /= 2
	agent.JUMP_VELOCITY *= 2
	agent.armor = false
	queue_free()
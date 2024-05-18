extends Node2D

var agent

# Called when the node enters the scene tree for the first time.
func _ready():
	agent = get_parent()
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func remove():
	queue_free()


func _on_timer_timeout():
	agent.death(" Become Stone")
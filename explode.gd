extends Node2D


const explosion_scene = preload("res://components/effects/explosion.tscn")
var agent
# Called when the node enters the scene tree for the first time.
func _ready():
	print("explode ready")
	agent = get_parent()
	$Timer.start()

func _on_timer_timeout():
	var explosion = explosion_scene.instantiate()
	agent.add_child(explosion)
	print("boom")

func remove():
	queue_free()
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#start timer
	$Timer.start()

func _on_timer_timeout():
	#delete self
	queue_free()

func _on_body_entered(body:Node2D):
	print("body entered")
	print(body)
	print(PlayerInfo.player)
	if body == PlayerInfo.player:
		body.death()
extends Area2D

var type = "fire"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body:Node2D):
	if body == PlayerInfo.player:
		body.death("Have Perished in Flames")


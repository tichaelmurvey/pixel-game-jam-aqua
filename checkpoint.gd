extends Area2D


func _ready():
	pass # Replace with function body.
	$hint.hide()
var accessible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	$hint.show()
	accessible = true

func _on_body_exited(body):
	$hint.hide()
	accessible = false

#listen for f key press
func _input(event):
	if event.is_action_pressed("pick_up") and accessible:
		PlayerInfo.spawn_point = self.global_position

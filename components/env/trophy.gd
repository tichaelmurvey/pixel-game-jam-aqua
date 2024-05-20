extends Area2D
@export var win_screen = Node
var accessible = false

func _on_body_entered(body):
	print("body entered")
	accessible = true
	#play animation on all shapes
	for shape in get_node("shapes").get_children():
		shape.play("Fixed")
	$door.play("opening")
	$hint.show()

func _on_body_exited(body):
	accessible = false
	#stop animation on all shapes
	for shape in get_node("shapes").get_children():
		shape.stop()
	$door.play("default")
	$hint.hide()


#listen for f key press
func _input(event):
	if event.is_action_pressed("pick_up") and accessible:
		$win_sound.play()
		print("win")
		win_screen.show()
		

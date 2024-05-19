extends Area2D	

@export var element = "earth"
# Called when the node enters the scene tree for the first time.
func _ready():
	$hint.hide()
	#check if i have been used
	for source in Inventory.used_sources:
		if source == position:
			queue_free()
			break

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
		Inventory.add_element(element)
		Inventory.used_sources.append(position)
		queue_free()

extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$sound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_area_entered(area:Area2D):
	if "type" in area and area.type == "fire":
		area.queue_free()

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().play_sound("glow")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func remove():
	queue_free()
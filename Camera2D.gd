extends Camera2D

@export var player = CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = player.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	#visible = false
	print(Inventory.elements)

var inventory = {}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _show():
	visible = true

func _hide():
	visible = false

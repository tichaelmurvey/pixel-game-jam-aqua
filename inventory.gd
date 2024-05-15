extends Node

var elements = ["earth", "fire", "water", "air"]
signal inventory_changed

var inventory = {
	"earth": 1,
	"fire": 1,
	"water": 1,
	"air": 5
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func remove_element(element):
	if inventory[element] > 0:
		inventory[element] -= 1
		inventory_changed.emit()

func add_element(element):
	inventory[element] += 1
	inventory_changed.emit()

func get_element_count(element):
	return inventory[element]
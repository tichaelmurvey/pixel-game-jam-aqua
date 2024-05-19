extends Node

var elements = ["earth", "fire", "water", "air"]
signal inventory_changed

var inventory = {
	"earth": 5,
	"fire": 5,
	"water": 5,
	"air": 5
}

var used_sources = []
var saved_used_sources = null

var saved_inventory = inventory.duplicate(true)

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
	print('adding element ', element)
	if inventory[element] != null:
		inventory[element] += 1
	else:
		print('element not found ', element)
	inventory_changed.emit()

func get_element_count(element):
	return inventory[element]

func reset():
	if saved_inventory:
		print("loading inventory", saved_inventory)
		inventory = saved_inventory.duplicate(true)
	if saved_used_sources:
		used_sources = saved_used_sources.duplicate(true)

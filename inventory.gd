extends Node

var elements = ["earth", "fire", "water", "air"]
signal inventory_changed
signal inventory_reset
var inventory = {
	"earth": 0,
	"fire": 0,
	"water": 0,
	"air": 0
}

var available = {
	"earth": 0,
	"fire": 0,
	"water": 0,
	"air": 0
}

var used_sources = []
var saved_used_sources = []

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
		available[element] -= 1
		inventory_changed.emit()

func add_element(element):
	print('adding element ', element)
	if inventory[element] != null:
		inventory[element] += 1
		available[element] += 1
	else:
		print('element not found ', element)
	inventory_changed.emit()

func get_element_count(element):
	return inventory[element]

	
func remove_available(element):
	if available[element] > 0:
		available[element] -= 1
		inventory_changed.emit()

func add_available(element):
	print('adding element ', element)
	if available[element] != null:
		available[element] += 1
	else:
		print('element not found ', element)
	inventory_changed.emit()

func get_available_count(element):
	return available[element]

func reset():
	inventory_reset.emit()
	if saved_inventory:
		print("loading inventory", saved_inventory)
		inventory = saved_inventory.duplicate(true)
		available = saved_inventory.duplicate(true)
		used_sources = saved_used_sources.duplicate(true)
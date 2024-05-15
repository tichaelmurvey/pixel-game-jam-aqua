extends TextureRect

var element = null
var locked = false
func _can_drop_data(at_position, data):
	if locked:
		return false
	return true

func _drop_data(position, data):
	update_element(data)

func update_element(data):
	#remove old element
	if element != null:
		texture = null
		Inventory.add_element(element)

	#add new element
	element = data
	texture = load("res://assets/symbols/" + element + ".svg")
	$name.text = element
	Inventory.remove_element(element)

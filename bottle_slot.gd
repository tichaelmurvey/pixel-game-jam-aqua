extends TextureRect

var element = null
var locked = false

func _get_drag_data(_pos):
	var data = element

	var drag_texture = TextureRect.new()
	drag_texture.texture = texture
	drag_texture.custom_minimum_size = Vector2(64, 64)

	var preview = Control.new()
	preview.add_child(drag_texture)
	drag_texture.position = -0.5 * drag_texture.custom_minimum_size
	set_drag_preview(preview)

	#remove element
	update_element()
	return data


func _can_drop_data(at_position, data):
	if locked:
		return false
	return true

func _drop_data(position, data):
	update_element(data)

func update_element(data = null):
	#remove old element
	if element != null:
		texture = null
		Inventory.add_element(element)

	#add new element
	if data != null:
		element = data
		texture = load("res://assets/symbols/" + element + ".svg")
		$name.text = element
		Inventory.remove_element(element)
	else:
		element = null
		$name.text = ""
		texture = null

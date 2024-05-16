extends PanelContainer

#preload element grid scene
var element_grid = preload("res://components/ui/element_grid.tscn")

# func _get_drag_data(at_position):
# 	var preview_texture = TextureRect.new()

# 	preview_texture.texture = texture
# 	preview_texture.expand_mode = 1
# 	preview_texture.size = Vector2(64, 64)

# 	var preview = Control.new()
# 	preview.add_child(preview_texture)

# 	set_drag_preview(preview)
# 	texture = null

# 	return preview_texture.texture

func _can_drop_data(at_position, data):
	return data is String

func _drop_data(at_position, data):
	print("dropped")
	print(data)
	#create element grid for this element
	var new_element = element_grid.instance()
	new_element.element = data
	add_child(new_element)

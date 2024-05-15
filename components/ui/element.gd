extends PanelContainer

var element = "banana"
var element_grid_scene = preload("res://components/ui/element_grid.tscn")
var element_grid

func _ready():
	element_grid = element_grid_scene.instantiate()
	add_child(element_grid)
	element_grid.element = element

func _get_drag_data(at_position):
	var preview = element_grid.duplicate()
	set_drag_preview(preview)
	return element

# func _can_drop_data(at_position, data):
# 	print("dropping")
# 	return data is Texture2D

# func _drop_data(at_position, data):
# 	print("dropped")
# 	texture = data

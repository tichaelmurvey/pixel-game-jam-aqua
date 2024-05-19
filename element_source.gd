extends TextureRect
@export var element = 'banana'
@export var count = 5
@export var hint = "This is a hint"
@export var hint_box = Label
func _ready():
	set_element(element)
	Inventory.inventory_changed.connect(update_count)

func _get_drag_data(_pos):
	#check if there is enough of the element to pick up
	if count == 0:
		return null
	print("picked up")
	var data = element

	var drag_texture = TextureRect.new()
	drag_texture.texture = texture
	drag_texture.custom_minimum_size = Vector2(64, 64)

	var preview = Control.new()
	preview.add_child(drag_texture)
	drag_texture.position = -0.5 * drag_texture.custom_minimum_size
	set_drag_preview(preview)
	return data

func set_element(_element):
	element = _element
	texture = load("res://assets/symbols/" + element + ".svg")
	$name.text = element
	update_count()

func update_count():
	count = Inventory.get_available_count(element)
	$count.text = str(count)

func _on_mouse_entered():
	hint_box.text =  hint


func _on_mouse_exited():
	hint_box.text = "Hint: Use Shift to activate some powers"

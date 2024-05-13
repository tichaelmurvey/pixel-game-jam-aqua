extends GridContainer

# get item container scene
var item_container = preload("res://components/ui/element.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	# Create a new item container for each item in inventory
	for element in Inventory.elements:
		for i in range(Inventory.inventory[element]):
			var item = item_container.instantiate()
			item.element = element
			add_child(item)
			# item.connect("item_selected", self, "_on_item_selected")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

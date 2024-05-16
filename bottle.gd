extends TextureRect

@export var slot1 = TextureRect
@export var slot2 = TextureRect
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	print("alchemizing")
	var element1 = slot1.element
	var element2 = slot2.element
	if element1 and element2:
		print("brewing potion with " + element1 + " and " + element2)
		#lock the slots
		slot1.locked = true
		slot2.locked = true
		#add the effect
		PlayerInfo.add_power(element1, element2)
	

func _aqua_regia():
	if slot1.locked and slot2.locked:
		#unlock slots
		slot1.locked = false
		slot2.locked = false
		#remove the effect
		var element1 = slot1.element
		var element2 = slot2.element
		PlayerInfo.remove_power(element1, element2)
		#remove the elements from the slots
		slot1.update_element()
		slot2.update_element()

extends Node

var powers = [
	{
		"name": "boots",
		"active": true
	},
	{
		"name": "wings",
		"active": false
	}
]

#power update signal
signal power_updated

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_power(element1, element2):
	var new_power = power_combo_table[element1][element2]
	print("enabling power " + new_power)
	#find power in powers list
	for power in powers:
		if power["name"] == new_power:
			power["active"] = true
			break
	power_updated.emit()

var power_combo_table = {
	"fire": {
		"fire": "fireball",
		"water": "spout",
		"earth": "block",
		"air": "cloud"
	},
	"water": {
		"fire": "explode",
		"water": "big",
		"earth": "heavy",
		"air": "intangible"
	},
	"earth": {
		"fire": "bright",
		"water": "small",
		"earth": "stone",
		"air": "wings"
	},
	"air": {
		"fire": "rocket",
		"water": "ice",
		"earth": "boots",
		"air": "air"
	}
}
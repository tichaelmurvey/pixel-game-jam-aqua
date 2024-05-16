extends Node

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
		"air": "cloud"
	}
}


var powers = [
	{
		"name": "fireball",
		"active": false
	},
	{
		"name": "spout",
		"active": false
	},
	{
		"name": "block",
		"active": false
	},
	{
		"name": "cloud",
		"active": false
	},
	{
		"name": "explode",
		"active": false
	},
	{
		"name": "big",
		"active": false
	},
	{
		"name": "heavy",
		"active": false
	},
	{
		"name": "intangible",
		"active": false
	},
	{
		"name": "bright",
		"active": false
	},
	{
		"name": "small",
		"active": false
	},
	{
		"name": "stone",
		"active": false
	},
	{
		"name": "wings",
		"active": false
	},
	{
		"name": "rocket",
		"active": false
	},
	{
		"name": "ice",
		"active": false
	},
	{
		"name": "boots",
		"active": false
	},
	{
		"name": "cloud",
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

func remove_power(element1, element2):
	var old_power = power_combo_table[element1][element2]
	print("disabling power " + old_power)
	#find power in powers list
	for power in powers:
		if power["name"] == old_power:
			power["active"] = false
			break
	power_updated.emit()


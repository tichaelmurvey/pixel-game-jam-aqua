extends Node

var power_combo_table = {
	"fire": {
		"fire": "fireball", #done
		"water": "spout", #done
		"earth": "block", #done
		"air": "cloud"
	},
	"water": {
		"fire": "explode",
		"water": "big", #done
		"earth": "heavy", 
		"air": "intangible"
	},
	"earth": {
		"fire": "bright",
		"water": "small",
		"earth": "stone",
		"air": "wings" #done
	},
	"air": {
		"fire": "rocket",
		"water": "ice",
		"earth": "boots", #done
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

var player = null
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player == null:
		var root = get_tree().get_root()
		print(root.get_children())
		player = root.get_node("game/player")
		print("player found")
		print(player)


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


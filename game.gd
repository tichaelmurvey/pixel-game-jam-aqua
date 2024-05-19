extends Node2D
var inventory = {
	"fire": 0,
	"water": 0,
	"earth": 0,
	"air": 0
}

#public variable for control
@export var craftingMenu = Control

func _ready():
	#play music
	$MusicPlayer.play()

func _process(delta):
	craftingMenu.inventory = inventory

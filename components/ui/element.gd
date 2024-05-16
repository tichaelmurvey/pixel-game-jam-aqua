extends PanelContainer

@onready var symbol = $grid/elementSymbol
@onready var label = $grid/elementLabel
var element = "banana"

func _ready():
	label.text = element
	symbol.texture = load("res://assets/symbols/" + element + ".svg")
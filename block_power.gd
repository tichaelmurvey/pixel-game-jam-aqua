extends Node2D
@export var max_blocks = 10
var blocks = []
var agent
const block_scene = preload("res://components/env/block.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	agent = get_parent()

#on item keypress
func _input(event):
	if event.is_action_pressed("use_effect"):
		var block = block_scene.instantiate()
		blocks.append(block)
		get_tree().get_root().add_child(block)
		block.global_position = global_position + Vector2(+20, 0)
		block.apply_impulse(Vector2(100, 0))
		if blocks.size() > max_blocks:
			var block_to_remove = blocks.pop_front()
			block_to_remove.queue_free()

func remove():
	queue_free()
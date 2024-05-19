extends Area2D

@export var map : TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	print("explosion created")
	#start timer
	$Timer.start()
	$explosion_sfx.play()

func _on_timer_timeout():
	#delete self
	queue_free()

func _on_body_entered(body:Node2D):
	print("body entered")
	print(PlayerInfo.player)
	if body == PlayerInfo.player:
		body.death(" Have Become Particles", "Death2")
	elif body is RigidBody2D:
		body.queue_free()
	elif body is TileMap:
		print("tilemap")
		#get cell
		var cell = body.local_to_map(self.global_position)
		body.erase_cell(1, Vector2(cell.x, cell.y))
		#destroy surrounding cells
		body.erase_cell(1, Vector2(cell.x+1, cell.y))
		body.erase_cell(1, Vector2(cell.x-1, cell.y))
		body.erase_cell(1, Vector2(cell.x, cell.y+1))
		body.erase_cell(1, Vector2(cell.x, cell.y-1))
		body.erase_cell(1, Vector2(cell.x+1, cell.y+1))
		body.erase_cell(1, Vector2(cell.x-1, cell.y-1))
		body.erase_cell(1, Vector2(cell.x+1, cell.y-1))
		body.erase_cell(1, Vector2(cell.x-1, cell.y+1))

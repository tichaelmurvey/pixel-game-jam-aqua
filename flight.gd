extends Node2D

var agent = null
var FLIGHT_VELOCITY = 2000
var MAX_FLIGHT_TIME = 0.5
var wings = []
var flight_time = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	#get parent characterbody
	agent = get_parent()
	#deferred function
	#set collision shape to parent
	pass_up_collision_shapes.call_deferred()
	agent.play_sound("wings")
	

func pass_up_collision_shapes():
	for i in get_children():
		if i is CollisionShape2D:
			print(agent)
			i.reparent(agent)
			#scale
			i.scale = scale
			wings.append(i)

func remove_wings():
	for i in wings:
		i.queue_free()

func remove():
	remove_wings()
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_key_pressed(KEY_SPACE) and agent.is_on_floor() == false and flight_time < MAX_FLIGHT_TIME:
		print("fly")
		agent.play_sound("wings")
		agent.velocity.y -= FLIGHT_VELOCITY*delta
		agent.velocity.x = move_toward(agent.velocity.x, 0, 10000*delta)
		print(agent.velocity.y)
		flight_time += delta
	#reset flight time if on the ground
	elif agent.is_on_floor():
		flight_time = 0.0


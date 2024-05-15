extends Node2D

var agent = null
var enabled = false
@export var FLIGHT_VELOCITY = 2000
@export var MAX_FLIGHT_TIME = 0.5
var flight_time = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	#get parent characterbody
	agent = get_parent()
	

func _process(delta):
	for i in get_children():
		if i is CollisionShape2D:
			print(agent)
			i.reparent(agent)
			#scale
			i.scale = scale
			# #set position
			# i.position = Vector2(0,0)
			# print(i.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_key_pressed(KEY_SPACE) and agent.is_on_floor() == false and flight_time < MAX_FLIGHT_TIME:
		print("fly")
		agent.velocity.y -= FLIGHT_VELOCITY*delta
		agent.velocity.x = move_toward(agent.velocity.x, 0, 10000*delta)
		print(agent.velocity.y)
		flight_time += delta
	#reset flight time if on the ground
	elif agent.is_on_floor():
		flight_time = 0.0
	#pass collisions to parent
	# move_and_slide()
	# check for collision speed
	# for i in get_slide_collision_count():
	# 	var collision = get_slide_collision(i)
	# 	agent.handle_collision(collision, self)

#if spacebar is pressed while not on the ground, go upwards
# func _input(event):
# 	print("input")
# 	#print key pressed
# 	if event is InputEventKey:
# 		if event.pressed and event.keycode == KEY_SPACE:

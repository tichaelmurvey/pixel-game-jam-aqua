extends CharacterBody2D


var MAX_SPEED = 1500
var MAX_RUN_SPEED = 250
var SPEED = 0
var ACCELERATION = 25
var JUMP_VELOCITY = -450
var DEATH_COLLISION = 1150
var WEIGHT = 50
var HEIGHT = 50
var priorVelocity = Vector2(0, 0)
var protectedAngles = []
var dead = false

var power_scenes = {
	"boots": preload("res://components/powerups/boots.tscn"),
	"wings": preload("res://components/powerups/flight.tscn"),
	"big": preload("res://components/powerups/big.tscn"),
	"fireball": preload("res://components/powerups/fireball.tscn")

}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	#connect to power signal
	PlayerInfo.power_updated.connect(change_powers)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * MAX_RUN_SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION)
	
	priorVelocity = velocity

	move_and_slide()

	# check for collision speed
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		handle_collision(collision, self)
	#reset speed to max speed if it is greater than max speed
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED	


func handle_collision(collision, origin_collider):
	#check if the collision is with a deadly object
	if "deadly" in collision.get_collider() and collision.get_collider().deadly:
		death()
	#log velocity
	if priorVelocity.y != 0 or priorVelocity.x != 0:
		var angle = collision.get_angle()
		# check speed of collision in angle direction
		var collision_speed = priorVelocity.project(Vector2(sin(angle), cos(angle))).length()
		if collision_speed != 0:
			print('collision speed is ', collision_speed)
		if collision_speed > DEATH_COLLISION:
			#check if the angle is in the protected angles
			print("angle", rad_to_deg(angle))
			print("protected angles", protectedAngles)
			if int(angle) in protectedAngles:
				#say oof
				print('oof')
			else:
				death()
		
		

func death():
	# Handle the death of the player.
	# restart the game
	if !dead:
		dead = true
		#reset inventory
		Inventory.reset()
		print("parent", get_parent())
		print("tree", get_tree())
		get_tree().reload_current_scene()
		#pause the physics process
	


func _change_size(scaleFactor):
	# scale to the scale factor
	scale *= scaleFactor

func get_height():
	# return the height of the player
	return HEIGHT

func change_powers():
	print("changing powers on player")
	# change the powers of the player
	# get the new powers
	var powers = PlayerInfo.powers
	
	#iterate over powers
	for power in powers:
		#if power is not active, check if there is a child node that matches its name and remove it
		if not power.active:
			var power_node = get_node(power.name)
			if power_node:
				print("disabling power", power.name)
				power_node.remove()
		else:
			#if power is active, check if there is a scene that matches its name and add it
			if power.name in power_scenes:
				print("enabling power", power.name)
				#check if the power is already added
				if not get_node(power.name):
					#instantiate the power scene
					var power_scene = power_scenes[power.name].instantiate()
					add_child(power_scene)
		

extends CharacterBody2D


@export var MAX_SPEED = 1000
@export var MAX_RUN_SPEED = 500
@export var SPEED = 0
@export var ACCELERATION = 100
@export var JUMP_VELOCITY = -400
@export var DEATH_COLLISION = 500
@export var WEIGHT = 50
var priorVelocity = Vector2(0, 0)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
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
	if collision.get_collider().deadly:
		death()
	#log velocity
	if priorVelocity.y != 0 or priorVelocity.x != 0:
		print('handling collision')
		var angle = collision.get_angle()
		# check speed of collision in angle direction
		var collision_speed = priorVelocity.project(Vector2(sin(angle), cos(angle))).length()
		if collision_speed != 0:
			print('collision speed is ', collision_speed)
		if collision_speed > DEATH_COLLISION:
			death()
		
		

func death():
	# Handle the death of the player.
	# restart the game
	get_tree().reload_current_scene()


func _change_size(scaleFactor):
	# scale to the scale factor
	scale *= scaleFactor

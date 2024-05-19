extends CharacterBody2D

@export var death_panel : Control
@export var win_screen : Control
var MAX_SPEED = 1500
var MAX_RUN_SPEED = 250
var SPEED = 100
var ACCELERATION = 25
var DECELERATION = ACCELERATION
var JUMP_VELOCITY = -495
var DEATH_COLLISION = 1150
var WEIGHT = 50
var HEIGHT = 50
var priorVelocity = Vector2(0, 0)
var protectedAngles = []
var dead = false
var drift_mode = false
var facing_left = 1
var direction = 0
var armor = false
@onready var sprite = $Sprite
var power_scenes = {
	"boots": preload("res://components/powerups/boots.tscn"),
	"wings": preload("res://components/powerups/flight.tscn"),
	"big": preload("res://components/powerups/big.tscn"),
	"fireball": preload("res://components/powerups/fireball.tscn"),
	"block": preload("res://components/powerups/block.tscn"),
	"spout": preload("res://components/powerups/spout.tscn"),
	"cloud": preload("res://components/powerups/cloud.tscn"),
	"explode": preload("res://components/powerups/explode.tscn"),
	"heavy": preload("res://components/powerups/heavy.tscn"),
	"intangible": preload("res://components/powerups/intangible.tscn"),
	"bright": preload("res://components/powerups/bright.tscn"),
	"small": preload("res://components/powerups/small.tscn"),
	"puff": preload("res://components/powerups/puff.tscn"),
	"ice": preload("res://components/powerups/ice.tscn"),
	"rocket": preload("res://components/powerups/rocket.tscn"),
}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")*1.3
signal touched_floor

func _ready():
	#connect to power signal
	PlayerInfo.power_updated.connect(change_powers)
	#go to spawn point
	if PlayerInfo.spawn_point:
		position = PlayerInfo.spawn_point

func _physics_process(delta):
	if dead:
		return
	#handle drift mode
	if drift_mode:
		var x_direction = Input.get_axis("move_left", "move_right")
		var y_direction = Input.get_axis("move_up", "move_down")
		if x_direction:
			position.x += x_direction * SPEED * delta
		if y_direction:
			position.y += y_direction * SPEED * delta
		return

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta



	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		#play walking animation
		if is_on_floor():
			sprite.animation = "Run"
		velocity.x = move_toward(velocity.x, direction * MAX_RUN_SPEED, ACCELERATION)
		if direction < 0:
			facing_left = -1
			scale.x = scale.y * -1
			#flip the sprite
			# if not $Sprite.flip_h:
			# 	$Sprite.flip_h = true
		else:
			facing_left = 1
			scale.x = scale.y * 1
			#flip the sprite
			# if $Sprite.flip_h:
			# 	$Sprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		#play idle animation
		if is_on_floor() and sprite.animation  != "Death":
			sprite.animation = "Idle"
		# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	#check if falling faster than the death speed
	if velocity.y > DEATH_COLLISION*0.9:
		$falling.show()
	else:
		$falling.hide()
	priorVelocity = velocity
	move_and_slide()

	# check for collision speed
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		handle_collision(collision, self)
	#reset speed to max speed if it is greater than max speed
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED


func jump():
	sprite.animation = "Jump"
	# Jump with the jump velocity.
	velocity.y = JUMP_VELOCITY

func handle_collision(collision, origin_collider):
	#check if the collision is with a deadly object
	if "deadly" in collision.get_collider() and collision.get_collider().deadly and armor == false:
		death(" Touched Something Horrible")
	#check if collision is with floor

	#check if type of collider is tilemap
	if collision.get_collider() is TileMap:
		#check if the angle of the collision is between 90 and -90
		if collision.get_angle() < PI/2 and collision.get_angle() > -PI/2:
			touched_floor.emit()
	#log velocity
	if priorVelocity.y != 0 or priorVelocity.x != 0:
		var angle = collision.get_angle()
		# check speed of collision in angle direction
		var collision_speed = priorVelocity.project(Vector2(sin(angle), cos(angle))).length()
		if collision_speed > DEATH_COLLISION:
			#check if the angle is in the protected angles
			print("angle", rad_to_deg(angle))
			print("protected angles", protectedAngles)
			if int(angle) in protectedAngles:
				#say oof
				print('oof')
			else:
				death("Have Perhished by Falling")
		
		

func death(type = "Have Perished", death_animation = "Death"):
	# Handle the death of the player.
	# restart the game
	print("death")
	if !dead:
		#stop player movement and prevent further movement
		velocity = Vector2(0, 0)
		death_panel.get_node("Label").text += type
		print("dying")
		sprite.animation = death_animation
		#increase animation speed
		#sprite.speed_scale = 2
		#remove all powers
		for power in power_scenes:
			if get_node(power):
				get_node(power).remove()
		#create timer
		var timer = Timer.new()
		var message_timer = Timer.new()
		timer.one_shot = true
		message_timer.one_shot = true
		#add timer to scene
		add_child(timer)
		add_child(message_timer)
		#connect timeout signal to function
		timer.timeout.connect(_final_death)
		message_timer.timeout.connect(func(): death_panel.show())
		#start timer
		timer.start(3)
		message_timer.start(1)
		dead = true	

func _final_death():
	print("final death")
	Inventory.reset()
	print("parent", get_parent())
	print("tree", get_tree())
	get_tree().reload_current_scene()

func _change_size(scaleFactor):
	# scale to the scale factor
	scale *= scaleFactor

func get_height():
	# get the collision shape
	print($CollisionShape2D.shape.size.y)
	return $CollisionShape2D.shape.size.y

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
		


func _on_trophy_area_entered(area):
	win_screen.show()


func play_sound(sound):
	#play the sound
	if sound == "boot" and $boot_sfx.playing == false:
		$boot_sfx.play()
	if sound == "ice_boot" and $ice_boot_sfx.playing == false:
		$ice_boot_sfx.play()
	if sound == "wings" and $wings_sfx.playing == false:
		$wings_sfx.play()

func set_animation(animation):
	#set the animation
	sprite.animation = animation

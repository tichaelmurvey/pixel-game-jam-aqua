extends Node2D


var agent = null
var FLIGHT_VELOCITY = 2500
var MAX_FLIGHT_VELOCITY = 100
var MAX_FLIGHT_TIME = 5.0
var flight_time = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	#get parent characterbody
	agent = get_parent()
	#deferred function	

func remove():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_key_pressed(KEY_SPACE) and agent.is_on_floor() == false and flight_time < MAX_FLIGHT_TIME:
		print("fly")
		if agent.velocity.y > -MAX_FLIGHT_VELOCITY:
			agent.velocity.y -= FLIGHT_VELOCITY*delta
		print(agent.velocity.y)
		flight_time += delta
		$Sprite2D.play("default")
		$Sprite2D2.play("default")
	#reset flight time if on the ground
	elif agent.is_on_floor():
		flight_time = 0.0
		$Sprite2D.stop()
		$Sprite2D2.stop()
